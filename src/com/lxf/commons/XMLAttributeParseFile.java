package com.lxf.commons;

import java.io.File;
import java.io.InputStream;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * 用于保存XML属性配置
 * 存在本机文件中,修改后可以直接得到
 * @author zhaoheng
 */
public class XMLAttributeParseFile {
	private static XMLAttributeParseFile stance = new XMLAttributeParseFile();
	/**
	 * 构造方法，初始化XML数据
	 */
	private XMLAttributeParseFile(){
	}
	/**
	 * 获得唯一实例
	 * @return
	 */
	public static XMLAttributeParseFile getInstance(){
		return stance;
	}
	/**
	 * 通过配置文件中的某个节点中的节点名获取值
	 * @param name
	 * @return
	 */
	public String getValue(String id,String name){
		return parseXml().get(id).get(name);
	}
	/**
	 * 把XML中的数据解释到HashMap中
	 */
	private HashMap<String,HashMap<String,String>> parseXml(){
		HashMap<String,HashMap<String,String>> maps = new HashMap<String,HashMap<String,String>>();
		//用于存储XML中的数据
		DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder;
		try {
			docBuilder = docBuilderFactory.newDocumentBuilder();
			//InputStream in = this.getClass().getResourceAsStream("/fileProperty.xml");
			Document doc = docBuilder.parse (new File(Log.getRootPath()+"WEB-INF/classes/fileProperty.xml"));
			
			
			//File f = new File("/fileProperty.xml");
			// Document doc = docBuilder.parse(new InputSource(new StringReader(xml)));
			//Document doc = docBuilder.parse(in);
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
		return maps;
	}
	public static void main(String[] args) {
		System.out.println(XMLAttributeParseFile.getInstance().getValue("hh", "name"));
	}
}
