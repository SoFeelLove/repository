package com.lxf.commons;


import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class Log
{
  public static void Log(String ms)
  {
    String msg = DateUtils.getCurrentTimeStr() + "：" + ms;
    String exePath = getRootPath();
    File logDir = new File(exePath + "log");
    if (!logDir.exists())
      logDir.mkdir();
    String path = exePath + "log\\" + DateUtils.getCurrDateStr() + "_log.txt";
    FileWriter fw = null;
    Object lock = new Object();
    synchronized (lock)
    {
      try
      {
        File f = new File(path);
        if (!f.exists())
        {
          f.createNewFile();
        }
        fw = new FileWriter(f, true);
        fw.write(msg + "\r\n");
      }
      catch (Exception localException)
      {
        if (fw != null)
        {
          try
          {
            fw.close();
          }
          catch (IOException e1)
          {
            e1.printStackTrace();
          }
        }
      }
      finally
      {
        if (fw != null)
        {
          try
          {
            fw.close();
          }
          catch (IOException e1)
          {
            e1.printStackTrace();
          }
        }
      }
    }
    System.out.println(msg);
  }

  public static String getRootPath()
  {
    RootPath roo = new RootPath();
    return roo.getRootPath();
  }
}