package kr.co.main.admin;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	int adminLoginProcess(AdminVO vo);
}
