package kr.or.iei.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.boot.web.servlet.FilterRegistrationBean;

import jakarta.servlet.Filter;
import kr.or.iei.common.filter.EncodingFilter; //위 1번 클래스

@Configuration // import org.springframework.context.annotation.Configuration;
public class WebConfig implements WebMvcConfigurer { // import
														// org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

    // 인코딩 필터 등록 (모든 요청 UTF-8 처리)
	@Bean // 컨테이너에 Bean으로 등록
	public FilterRegistrationBean<Filter> EncodingFilter() {

		FilterRegistrationBean<Filter> filterRegistrationBean = new FilterRegistrationBean<>();
		filterRegistrationBean.setFilter(new EncodingFilter()); // 등록할 필터 클래스
		filterRegistrationBean.setOrder(1); // 필터 순서 (낮을수록 우선순위 높음)
		filterRegistrationBean.addUrlPatterns("/*"); // 필터를 적용할 url 패턴(모든 요청에 대해 필터 동작)

		return filterRegistrationBean;
	}
	
    //패스워드 암호화 객체 등록
	 @Bean
		public BCryptPasswordEncoder bCrypt() {
			return new BCryptPasswordEncoder();
		}

}