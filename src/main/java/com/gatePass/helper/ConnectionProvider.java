package com.gatePass.helper;

import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
	private static Connection con;
	private static  int OTP_LENGTH = 5;
	private static String ALLOWED_CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_-+=<>?";

	public static Connection getConnection() {
		try {

			if (con == null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gate_pass_db?characterEncoding=utf8",
						"root", "root");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	public static String getOTP() {
		StringBuilder otp = new StringBuilder(OTP_LENGTH);

		SecureRandom random = new SecureRandom();
		for (int i = 0; i < OTP_LENGTH; i++) {
			int randomIndex = random.nextInt(ALLOWED_CHARACTERS.length());
			otp.append(ALLOWED_CHARACTERS.charAt(randomIndex));
		}

		return otp.toString();
	}
	
	
}
