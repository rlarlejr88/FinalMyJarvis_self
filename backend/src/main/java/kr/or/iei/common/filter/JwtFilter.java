package kr.or.iei.common.filter;

import java.io.IOException;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerMapping;

import kr.or.iei.common.util.JwtUtils;
import kr.or.iei.common.annotation.NoTokenCheck;

import java.util.Map;

@Component
public class JwtFilter extends OncePerRequestFilter {

	@Autowired
	private JwtUtils jwtUtils;

	@Override
	protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
			throws ServletException, IOException {
		// HandlerMethod를 통해 어노테이션 확인
		Object handler = req.getAttribute(HandlerMapping.BEST_MATCHING_HANDLER_ATTRIBUTE);
		if (handler instanceof HandlerMethod) {
			HandlerMethod handlerMethod = (HandlerMethod) handler;
			// 메서드 또는 클래스에 NoTokenCheck가 붙어 있으면 우회
			if (handlerMethod.getMethodAnnotation(NoTokenCheck.class) != null
					|| handlerMethod.getBeanType().getAnnotation(NoTokenCheck.class) != null) {
				chain.doFilter(req, res);
				return;
			}
		}

		String authHeader = req.getHeader("Authorization");
		System.out.println("[JwtFilter] Authorization 헤더: " + authHeader); // JWT 헤더 로그

		// 인증 토큰 검사 (Bearer 방식)
		if (authHeader != null && authHeader.startsWith("Bearer ")) {
			String token = authHeader.substring(7); // "Bearer " 이후의 토큰
			System.out.println("[JwtFilter] 추출된 JWT 토큰: " + token); // 토큰 로그

			Object result = jwtUtils.validateToken(token);

			if (result instanceof HttpStatus) {
				System.out.println("[JwtFilter] JWT 토큰 유효성 실패: " + result);
				res.setStatus(((HttpStatus) result).value());
				res.setContentType("application/json;charset=UTF-8");
				res.getWriter().write("{\"error\":\"invalid jwtToken in request Header\"}");
				res.getWriter().flush();
				return; // Stop filter chain if token is invalid
			}

			// 토큰에서 memberNo 추출 =// 회의록 등록시 memberNo가 null방지
			String memberNo = jwtUtils.getMemberNo(token);
			System.out.println("[JwtFilter] 토큰에서 추출한 memberNo: " + memberNo); // memberNo 로그
			req.setAttribute("memberNo", memberNo);

		}

		chain.doFilter(req, res);
	}
}