package com.lxf.commons;

import java.util.Properties;

public class ReadProperties {
	private Properties cfg = new Properties();

	public ReadProperties(String fileName) {
		try {
			cfg.load(this.getClass().getClassLoader().getResourceAsStream(fileName));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getString(String key) {
		return cfg.getProperty(key);
	}

	public int getInt(String key) {
		return Integer.parseInt(cfg.getProperty(key));
	}

	public Double getDouble(String key) {
		return Double.parseDouble(cfg.getProperty(key));
	}
}