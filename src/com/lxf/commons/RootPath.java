package com.lxf.commons;


import java.io.File;
import java.net.URISyntaxException;
import java.net.URL;

public class RootPath
{
  private static String path = "";

  public String getRootPath()
  {
    try
    {
      if (path.equals(""))
      {
        path = new File(getClass().getClassLoader().getResource("").toURI()).getPath();
        path = path.replace("WEB-INF\\classes", "");
      }
    } catch (URISyntaxException localURISyntaxException) {
    }
    return path;
  }
}