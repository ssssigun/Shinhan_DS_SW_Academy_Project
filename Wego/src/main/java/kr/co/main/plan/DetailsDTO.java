package kr.co.main.plan;

import lombok.Data;

@Data
public class DetailsDTO {
    private int start_time;
    private int end_time;
    private String location_pk;
    private String longitude;
    private String latitude;
    private int saveIndex;
    private String location_name;
    private int location_budget;
    private String category;
}
