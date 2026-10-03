package com.jgmdev.finanzas;

import java.util.TimeZone;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class FinanzasApplication {

	public static void main(String[] args) {
		TimeZone.setDefault(TimeZone.getTimeZone("America/Argentina/Buenos_Aires"));
		SpringApplication.run(FinanzasApplication.class, args);
	}
}