package kr.co.main.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
	@Autowired
	AdminMapper AMapper;
	
	public int adminLoginProcess(AdminVO vo) {
		return AMapper.adminLoginProcess(vo); 
	}
}
