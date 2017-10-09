package com.vgm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ImportResource;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.filter.DelegatingFilterProxy;

import javax.servlet.DispatcherType;

@SpringBootApplication
@EnableTransactionManagement(proxyTargetClass = true)
@ImportResource(
		locations={
				"classpath:spring/applicationContext-jpa.xml",
				"classpath:shiro/applicationContext-Shiro.xml",
				"classpath:shiro/applicationContext-ShiroCache.xml",
				"classpath:spring-mvc/springmvc-servlet.xml"
		})
public class VgmBasicApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(VgmBasicApplication.class);
	}

	/**
	 * 注册shiroFilter
	 * @return
	 */
	@Bean
	public FilterRegistrationBean shiroFilterRegistrationBean() {
		FilterRegistrationBean registration = new FilterRegistrationBean();
		registration.setFilter(new DelegatingFilterProxy("shiroFilter"));
		registration.setEnabled(true);
		registration.addUrlPatterns("/*");
		registration.setDispatcherTypes(DispatcherType.REQUEST);
		return registration;
	}

	public static void main(String[] args) {
		SpringApplication.run(VgmBasicApplication.class, args);
	}

}
