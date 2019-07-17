package com.hk.test;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * @Classname Test
 * @Description TODO
 * @Date 2019/7/16 16:52
 * @Created by 13055
 */
public class Test {
	public static void main(String[] args) throws Exception{
//		List<String> warnings = new ArrayList<String>();
//		boolean overwrite = true;
//		File configFile = new File("mbg.xml");
//		ConfigurationParser cp = new ConfigurationParser(warnings);
//		Configuration config = cp.parseConfiguration(configFile);
//		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
//		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
//		myBatisGenerator.generate(null);

		for (int i = 0; i < 20; i++) {
			Random random = new Random();
			int emp_age = random.nextInt(23)+22;
			System.out.println(emp_age);
		}
	}
}
