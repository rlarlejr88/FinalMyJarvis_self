package kr.or.iei.common.util;

import java.util.Calendar;
import java.util.Date;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import kr.or.iei.member.model.dto.Member;

@Component
public class JwtUtils {
	
	//application.properties에 작성된 값 읽어오기
	@Value("${jwt.secret-key}")
	private String jwtSecretKey;
	@Value("${jwt.expire-minute}")
	private int jwtExpireMinute;
	@Value("${jwt.expire-hour-refresh}")
	private int jwtExpireHourRefresh;
	
	
	//AccessToken 발급 메소드
	public String createAccessToken(Member member, String memberLevel) { // 파라미터명 명확화
		//1. 내부에서 사용할 방식으로, 정의한 key 변환
		SecretKey key = Keys.hmacShaKeyFor(jwtSecretKey.getBytes());
		
		//2. 토큰 생성시간 및 만료시간 설정
		
		Calendar calendar = Calendar.getInstance(); 					//현재시간
		Date startTime = calendar.getTime();							//현재시간 == 유효 시작시간
		calendar.add(Calendar.MINUTE, jwtExpireMinute);					//현재시간 + 10분 == 유효 만료시간
		Date expireTime = calendar.getTime();							//만료시간
		
		//3. 토큰 생성
		String accessToken = Jwts.builder()								//builder를 이용해 토큰 생성
								 .issuedAt(startTime)					//시작시간
								 .expiration(expireTime)				//만료시간
								 .signWith(key)							//암호화 서명
								 .claim("memberId", member.getMemberId())			//토큰 포함 정보(key ~ value 형태)
								 .claim("memberLevel", memberLevel)		//토큰 포함 정보(key ~ value 형태)
								 .claim("memberNo", member.getMemberNo())  // 토큰에 memeberno 추가
								 .compact();							//생성
		
		return accessToken;
	}
	
	//RefreshToken 발급 메소드
	public String createRefreshToken(String memberId, String string) {
		//1. 내부에서 사용할 방식으로, 정의한 key 변환
		SecretKey key = Keys.hmacShaKeyFor(jwtSecretKey.getBytes());
		
		//2. 토큰 생성시간 및 만료시간 설정
		
		Calendar calendar = Calendar.getInstance(); 					//현재시간
		Date startTime = calendar.getTime();							//현재시간 == 유효 시작시간
		calendar.add(Calendar.HOUR, jwtExpireHourRefresh);				//현재시간 + 10분 == 유효 만료시간
		Date expireTime = calendar.getTime();							//만료시간
		
		//3. 토큰 생성
		String refreshToken = Jwts.builder()								//builder를 이용해 토큰 생성
								 .issuedAt(startTime)					//시작시간
								 .expiration(expireTime)				//만료시간
								 .signWith(key)							//암호화 서명
								 .claim("memberId", memberId)			//토큰 포함 정보(key ~ value 형태)
								 .claim("memberLevel", string)		//토큰 포함 정보(key ~ value 형태)
								 .compact();							//생성
		
		return refreshToken;
	}
	
	//토큰 검증
	public Object validateToken(String token) {
		
		Member m = new Member();
		
		try {
			//1. 토큰 해석을 위한 암호화 키 세팅
			SecretKey key = Keys.hmacShaKeyFor(jwtSecretKey.getBytes());
			
			//2. 토큰 해석
			Claims claims = Jwts.parserBuilder()
				.setSigningKey(key)	//해석에 필요한 Key
				.build()
				.parseClaimsJws(token)
				.getBody();
			
			//3. 토큰에서 데이터 추출
			String memberId = (String) claims.get("memberId");
			m.setMemberId(memberId);
			
			// 로그인 이후. 토큰으로 검증
			// memberNo 타입에 따라 변환 (String 또는 Integer)
			Object memberNoObj = claims.get("memberNo");
			if (memberNoObj != null) {
				m.setMemberNo(memberNoObj.toString()); // memberNo가 String이 아니면 toString으로 변환
			}
			
		}catch(SignatureException e) { // 발급 토큰과 요청 토큰 불일치
			return HttpStatus.UNAUTHORIZED; //401 코드 
		}catch(Exception e) { //토큰 유효 시간 경과
			return HttpStatus.FORBIDDEN; //403 코드
		}
		
		return m;
	}
	
	/** 토큰에서 memberNo(subject) 꺼내기 */
	public String getMemberNo(String token) {
	    Claims claims = Jwts.parserBuilder()
	        .setSigningKey(Keys.hmacShaKeyFor(jwtSecretKey.getBytes())) // SECRET_KEY -> jwtSecretKey로 변경
	        .build()
	        .parseClaimsJws(token)
	        .getBody();
	    return claims.getSubject();
	}

}