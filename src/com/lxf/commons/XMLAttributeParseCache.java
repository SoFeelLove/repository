package com.lxf.commons;

import java.io.InputStream;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * 用于保存XML属性配置存在于缓存中,启动服务时候加载
 * XMLAttributeParseCache.java
 * @author lxf; 2015-9-15 下午4:38:58
 */
public class XMLAttributeParseCache {
	/**
	 * 存储所有的结点
	 * 结构 id-<name,value>
	 */
	private static HashMap<String,HashMap<String,String>> maps = new HashMap<String,HashMap<String,String>>();
	
	/**
	 * 构造方法
	 */
	public XMLAttributeParseCache(){
		parseXml();
	}
	
	/**
	 * 通过配置文件中的某个节点中的节点名获取值  根据类名、方法名获得相应xml值
	 * @param name	方法名
	 * @param id 类名
	 * @return
	 */
	public static String getValue(String id,String name){
		return maps.get(id).get(name);//map.get(name);
	}
	/**
	 * 获得默认xml对应值
	 * @return
	 */
	public static String getValue(){
		StackTraceElement[] stacks = new Throwable().getStackTrace();   
	     int stacksLen = stacks.length;  
	     String classname = stacks[1].getClassName();
	     classname = classname.substring(classname.lastIndexOf('.')+1,classname.length());
	     String val = getValue(classname,stacks[1].getMethodName());
		return val;
	}
	/**
	 * 根据方法名获得对象的xml值
	 * @param method 调用的方面名
	 * @return
	 */
	public static String getValue(String method){
		 StackTraceElement[] stacks = new Throwable().getStackTrace();   
	     int stacksLen = stacks.length;  
	     String classname = stacks[1].getClassName();
	     classname = classname.substring(classname.lastIndexOf('.')+1,classname.length());
	     String val = getValue(classname,method);
	     return val;
	}
	/**
	 * 把XML中的数据解释到HashMap中
	 */
	private void parseXml(){
		//用于存储XML中的数据
		DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder;
		try {
			docBuilder = docBuilderFactory.newDocumentBuilder();
			//File f = new File("/cacheProperty.xml");
			InputStream in = this.getClass().getResourceAsStream("/fileProperty.xml");
			// Document doc = docBuilder.parse(new InputSource(new StringReader(xml)));
			Document doc = docBuilder.parse(in);
			doc.getDocumentElement().normalize();
			NodeList nl = doc.getElementsByTagName("node");
			HashMap<String,String> keyValue = null;
			for (int i = 0; i < nl.getLength(); i++) {
				keyValue = new HashMap<String,String>();
				Node node = nl.item(i);
				String id = node.getAttributes().getNamedItem("id").getTextContent();
				for (int j = 0; j < node.getChildNodes().getLength(); j++) {
					Node n = node.getChildNodes().item(j);
					String na = n.getNodeName();
					if (!na.equals("#text")) {
						String key = n.getNodeName();
						String value = n.getFirstChild().getNodeValue();
						keyValue.put(key, value);
					}
				}
				maps.put(id, keyValue);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		XMLAttributeParseCache dd = new XMLAttributeParseCache();
		System.out.println(dd.getValue("hh", "name"));
	}
}
