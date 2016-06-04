package com.lxf.commons;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class SqlFileConfig
{
  public static String getLocalSql(String resource, String id)
  {
    try
    {
      return loadXmlConfig("com\\lxf\\sql\\" + resource, id);
    }
    catch (ParserConfigurationException e)
    {
      e.printStackTrace();
    }
    catch (SAXException e)
    {
      e.printStackTrace();
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
    return "";
  }

  private static String loadXmlConfig(String resource, String id)
    throws ParserConfigurationException, SAXException, IOException
  {
    if ((resource == null) || (resource.equals("")))
    {
      System.out.print("\n拒绝加载文件未找到");
      return "";
    }

    String rootPath = Log.getRootPath() + "\\WEB-INF\\classes\\";

    DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
    DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
    Document doc = docBuilder.parse(new File(rootPath + resource));

    Node root = doc.getElementsByTagName("root").item(0);

    Element dsele = (Element)root;

    NodeList rootList = dsele.getElementsByTagName("content");

    String result = "";
    for (int i = 0; i < rootList.getLength(); i++)
    {
      Element node = (Element)rootList.item(i);
      String idname = node.getAttribute("id");
      if (!idname.toLowerCase().equals(id.toLowerCase()))
      {
        continue;
      }

      result = node.getTextContent();
      break;
    }

    return result;
  }
}