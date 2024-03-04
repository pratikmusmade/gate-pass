package com.gatePass.helper;

import java.security.SecureRandom;

public class OTPGenerator {

	private static final int OTP_LENGTH = 5;
	private static final String ALLOWED_CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_-+=<>?";

	public static String generateOTP() {
		StringBuilder otp = new StringBuilder(OTP_LENGTH);

		SecureRandom random = new SecureRandom();
		for (int i = 0; i < OTP_LENGTH; i++) {
			int randomIndex = random.nextInt(ALLOWED_CHARACTERS.length());
			otp.append(ALLOWED_CHARACTERS.charAt(randomIndex));
		}

		return otp.toString();
	}

}
