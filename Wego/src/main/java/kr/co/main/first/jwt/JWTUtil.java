package kr.co.main.first.jwt;

import java.util.Map;

import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import lombok.extern.java.Log;

@Component
@Log
public class JWTUtil {
	private String key = "SigwonSsoLogin";
	
	// 토큰 파싱
	public String validateToken(String token) throws JwtException {
		
		Claims claim = Jwts.parser()
				.setSigningKey(key.getBytes())
				.parseClaimsJws(token)
				.getBody();
		
		String id = claim.get("id", String.class);
		return id;
	}
}