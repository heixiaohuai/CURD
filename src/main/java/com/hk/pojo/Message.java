package com.hk.pojo;

import org.springframework.context.MessageSource;

import java.util.HashMap;
import java.util.Map;

/**
 * @Classname Message
 * @Description 这是一个通用的请求信息返回类
 * @Date 2019/7/17 19:01
 * @Created by 13055
 */
public class Message {
	//状态码，我在这里人为的规定（100：成功，  200：失败）
	private int code;
	//提示信息
	private String msg;
	//用户要返回给浏览器中的数据
	private Map<String, Object> extend = new HashMap<>();

	public static Message success(){
		Message result = new Message();
		result.setCode(100);
		result.setMsg("处理成功");
		return result;
	}

	public static Message failed(){
		Message result = new Message();
		result.setCode(200);
		result.setMsg("处理失败");
		return result;
	}

	public Message add(String key, Object value){
		this.getExtend().put(key, value);
		return this;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
}
