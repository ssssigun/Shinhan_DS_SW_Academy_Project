package kr.co.main.plan;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/plan")
public class PlanController {
	// 임시 포인트 적립 제도
	public final double POINT[] = {0.025, 0.025, 0.025, 0.025, 0.025, 0.025}; 
	
	@Autowired
	PlanService service;
	
	// 기본 페이지 반환
	@GetMapping("/index.do")
	public String index() {
		return "plan/index";
	}
	
	@GetMapping("/plan.do")
	public String index(Integer plan_pk, Model model) {
		PlanVO plan = service.selectPlanByPK(plan_pk);
		List<PlanDetailVO> planDetail = service.selectPlanDetailByPK(plan_pk);
		model.addAttribute("plan", plan);
		model.addAttribute("planDetail", planDetail);
		return "plan/index";
	}	
	
	// ajax를 위해서 지역, 카테고리, 검색어, 지도 중심 위치를 받아와서 장소 정보를 json으로 반환하는 api 
	@GetMapping("/filter.do")
	@ResponseBody
	public Map filter(LocationVO vo) {
		Map map =  service.selectLocationPer5(vo);
		return map;
	}
	
	// location_pk를 사용해서 해당 장소의 세부 사항을 json으로 반환하는 api
	@GetMapping("/spotDetail.do")
	@ResponseBody
	public List<LocationVO> spotDetail(Integer location_pk) {
		List<LocationVO> locationVO = service.selectLocationByPK(location_pk);
		return locationVO;
	}
	
	// 일자별 담아 놓은 장소의 정보(예산 포함)를 사용하여 예산의 총합 구하고, 포인트 누적 계산해서 json으로 반환하는 api
	// 로그인 기능 완성되고, 카드 테이블 생기면 해당 회원이 갖고 있는 카드 조회해서 포인트 계산(미정)
	@PostMapping("/calculate.do")
	@ResponseBody
	public List<Map> calculate(@RequestBody String details) {
		List<Map> oriPoint = new ArrayList<>();
		Map<Integer, Integer> original = new HashMap<>();
		Map<Integer, Integer> calculated = new HashMap<>();
		Map<Integer, Integer> bonus = new HashMap<>();
		for (int i = 1; i < 7; i++) {
			original.put(i, 0);
		}
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, Object> jsonDetails = mapper.readValue(details, Map.class);
			List<Map<String, Object>> data = (List) jsonDetails.get("details");
			for (Map<String, Object> detail : data) {
				int curHour = Integer.parseInt(String.valueOf(detail.get("hour")));
				List<String> info = (List) detail.get("info");
				int startHour = Integer.parseInt(String.valueOf(info.get(0)));
				if (curHour == startHour) {
					int category = Integer.parseInt(String.valueOf(info.get(8)));
					int budget = Integer.parseInt(String.valueOf(info.get(7)));
					original.put(category, original.get(category) + budget);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int oriSum = 0;
		int pointSum = 0;
		int bonusSum = 0;
		for (int i = 1; i < 7; i++) {
			calculated.put(i, (int) Math.round(original.get(i) * POINT[i - 1]));
			bonus.put(i, (int) Math.round(original.get(i) * 0.03));
			oriSum += original.get(i);
			pointSum += calculated.get(i);
			bonusSum += bonus.get(i);
		}
		original.put(7, oriSum);
		calculated.put(7, pointSum);
		bonus.put(7, bonusSum);
		
		oriPoint.add(original);
		oriPoint.add(calculated);
		oriPoint.add(bonus);
		return oriPoint;
	}
	
	// 최종적으로 plan, plan_detail을 insert하는 api
	@PostMapping("/submit.do")
	@ResponseBody
	public Map submit(@RequestBody String plans) throws ParseException {
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, Object> plansDetails = mapper.readValue(plans, Map.class);
			
			// json으로 받아온 데이터에서 plan 정보를 추출해서 planVO에 넣는 코드
			PlanVO planVO = new PlanVO();
			planVO.setUser_pk(Integer.parseInt(String.valueOf(plansDetails.get("user_pk"))));
			planVO.setTitle(String.valueOf(plansDetails.get("title")));
			planVO.setNum_of_people(Integer.parseInt(String.valueOf(plansDetails.get("num_of_people"))));
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date start_date = formatter.parse(String.valueOf(plansDetails.get("start_date")));
			planVO.setStart_date(start_date);
			
			Date end_date = formatter.parse(String.valueOf(plansDetails.get("end_date")));
			planVO.setEnd_date(end_date);
			
			int state = Integer.parseInt(String.valueOf(plansDetails.get("state")));
			planVO.setState(state);
			
			// json으로 받아온 데이터에서 plan_detail 정보를 추출해서 planDetailVO에 넣는 코드
			int plan_pk = Integer.parseInt(String.valueOf(plansDetails.get("plan_pk")));
			List<List<String>> data = (List) plansDetails.get("plan_details");
			List<PlanDetailVO> listPlanDetailVO = new ArrayList<>();
			StatisticsVO statisticsVO = new StatisticsVO();
			
			// 나중에 user_pk 받아오기!!
			statisticsVO.setUser_pk(1);
			for (List<String> planDetail : data) {
				PlanDetailVO planDetailVO = new PlanDetailVO();
				planDetailVO.setLocation_pk(Integer.parseInt(String.valueOf(planDetail.get(0))));
				
				int addDay = Integer.parseInt(String.valueOf(planDetail.get(4)));
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(start_date);
				calendar.add(Calendar.DAY_OF_MONTH, addDay - 1);

				int start_hour = Integer.parseInt(String.valueOf(planDetail.get(1)));
				calendar.add(Calendar.HOUR_OF_DAY, start_hour);
				Date start_time = calendar.getTime();
				
				int end_hour = Integer.parseInt(String.valueOf(planDetail.get(2)));
				calendar.add(Calendar.HOUR_OF_DAY, end_hour - start_hour);
				Date end_time = calendar.getTime();
				
				planDetailVO.setStart_time(start_time);
				planDetailVO.setEnd_time(end_time);
				int budget = Integer.parseInt(String.valueOf(planDetail.get(3)));
				planDetailVO.setBudget(budget);
				planDetailVO.setDay(addDay);
				if (plan_pk != -1) {
					planVO.setPlan_pk(plan_pk);
					planDetailVO.setPlan_pk(plan_pk);
				}
				int category = Integer.parseInt(String.valueOf(planDetail.get(5)));
				switch (category) {
					case 1: statisticsVO.setFood(statisticsVO.getFood() + budget);
							break;
					case 2: statisticsVO.setAccommodation(statisticsVO.getAccommodation() + budget);
							break;
					case 3: statisticsVO.setShopping(statisticsVO.getShopping() + budget);
							break;
					case 4: statisticsVO.setCulture(statisticsVO.getCulture() + budget);
							break;
					case 5: statisticsVO.setTour(statisticsVO.getTour() + budget);
							break;
					case 6: statisticsVO.setLeisure(statisticsVO.getLeisure() + budget);
							break;
				}
				listPlanDetailVO.add(planDetailVO);
			}
			
			if (state == 0) {
				service.updateStat(statisticsVO);
			}
			// planVO와 planDetailVO 정보를 이용해서 DB에 insert
			if (plan_pk == -1) {
				service.insertPlanAndDetail(planVO, listPlanDetailVO);
			} else {
				
				service.updatePlanAndDetail(planVO, listPlanDetailVO);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Map<String, Integer> result = new HashMap<>();
		result.put("Success", 1);
		
		return result;
	}
	
	@GetMapping("/delete.do")
	@ResponseBody
	public Map delete(Integer plan_pk){
		service.deletePlanAndDetail(plan_pk);
		
		Map<String, Integer> result = new HashMap<>();
		result.put("Success", 1);
		
		return result;
	}
	
	
	// 세부 경로 그려주는 api
	@GetMapping("/findRoute.do")
	@ResponseBody
	public List<List<String>> findRoute(String start_long, String start_lat, String end_long, String end_lat) {
		ObjectMapper mapper = new ObjectMapper();
		List<List<String>> path = new ArrayList<>();
        String url = "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving?start="+start_long+","+start_lat+"&goal="+end_long+","+end_lat+"&option=trafast";
        String apiKeyId = "l8m4oe0ivu";
        String apiKey = "fJzazbNyzB4cbh6HYRm3Ch1qfoG1sexOiY35i9He";

        try {
            URL apiUrl = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) apiUrl.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("X-NCP-APIGW-API-KEY-ID", apiKeyId);
            conn.setRequestProperty("X-NCP-APIGW-API-KEY", apiKey);

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
            	InputStream inputStream = conn.getInputStream();
            	BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            	StringBuilder responseBody = new StringBuilder();
            	String line;
            	while ((line = reader.readLine()) != null) {
            	    responseBody.append(line);
            	}
            	reader.close();
            	inputStream.close();

            	String response = responseBody.toString();
            	JsonNode info = mapper.readTree(response);
            	JsonNode pathArray = info.path("route").path("trafast").get(0).path("path");
            	
                for (JsonNode coordinate : pathArray) {
                    String longitude = coordinate.get(0).asText();
                    String latitude = coordinate.get(1).asText();
                    List<String> point = new ArrayList<>();
                    point.add(longitude);
                    point.add(latitude);
                    path.add(point);
                }
                // 여기서 응답 데이터를 처리합니다.
            } else {
                System.out.println("HTTP 요청 오류: " + responseCode);
                // 여기서 오류를 처리합니다.
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		return path;
	}
	
	// 수정시 기존 plan_details에 있는 예산 빼는 메소드
	@GetMapping("/subtract.do")
	@ResponseBody
	public Map subtract(Integer food, Integer accommodation, Integer shopping, Integer culture, Integer tour, Integer leisure) {
		Integer[] budget = new Integer[6];
		budget[0] = food;
		budget[1] = accommodation;
		budget[2] = shopping;
		budget[3] = culture;
		budget[4] = tour;
		budget[5] = leisure;
		service.subtractStat(budget);
		for (Integer tmp : budget) {
			System.out.println(tmp);
		}
		Map<String, Integer> result = new HashMap<>();
		result.put("Success", 1);
		
		return result;
	}
	
	@GetMapping("/checkDate.do")
	@ResponseBody
	public Map checkDate(String start_date, String end_date, String user_pk, String plan_pk) {
		Map<String, String> ipt = new HashMap<>();
		ipt.put("start_date", start_date);
		ipt.put("end_date", end_date);
		ipt.put("user_pk", user_pk);
		ipt.put("plan_pk", plan_pk);
		Map<String, Integer> result = new HashMap<>();
		if (service.checkDate(ipt)) {
			result.put("result", 1);
		} else {
			result.put("result", 0);
		}
		
		return result;
	}
}
