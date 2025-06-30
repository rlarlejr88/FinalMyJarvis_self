package kr.or.iei;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class}) //import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
public class MyJarvisApplication {

	public static void main(String[] args) {
		SpringApplication.run(MyJarvisApplication.class, args);
	}


	
}
