package com.lxf.commons;


import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * 日期工具类
 * <p>
 * 可获取当前日期，转化日期格式，解析<code>String</code>型的日期为<code>Date</code>类型等
 * 
 * @author lxf
 * @see java.text.SimpleDateFormat
 */

public final class DateUtils {

	public final static String YYYY = "yyyy";

	public final static String MM = "MM";

	public final static String DD = "dd";

	public final static String YYYY_MM_DD = "yyyy-MM-dd";
	public final static String YYYY_MM_DD1 = "yyyy年MM月dd日";

	public final static String YYYY_MM = "yyyy-MM";

	public final static String HH_MM_SS = "HH:mm:ss";

	public final static String HH_MM = "HH:mm";

	public final static String YYYY_MM_DD_HH_MM = "yyyy-MM-dd HH:mm";

	public final static String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
	public final static String YYYYMMDDHHMMSS = "yyyyMMddHHmmss";	
	public final static String YYYYMM = "yyyymm";
	

	

	/**
	 * 根据传入时间，向前推interval个月
	 * @author lxf
	 * @time 2015-8-24上午9:01:38
	 * @param endTime
	 * @param interval 时间间隔
	 * @return dateStr[]
	 * @throws Exception 
	 */
	public static String[] dateArray(String endTime,int interval) throws Exception {
		String[] dateStr = new String[interval];
		for (int i = interval - 1; i >= 0; i--) {
			dateStr[i] = endTime;
			endTime = DateUtils.getLastMonth(endTime);
		}		
		return dateStr;
	}


	
	/**
	 * 日期类根据传入的日期 2012-02 获得 201202
	 */
	public static String format(String date) {
		return date.replace("-", "");
	}

	/**
	 * 默认为yyyy-MM-dd的格式化
	 * 
	 * @param date
	 * @return
	 */
	public static String format(Date date) {
		if (date == null)
			return "";
		else
			return getFormatter("yyyy-MM-dd").format(date);
	}
	
	/**
	 * 日期格式化－将<code>Date</code>类型的日期格式化为<code>String</code>型
	 * 
	 * @param date
	 *            待格式化的日期
	 * @param pattern
	 *            时间样式
	 * @return 一个被格式化了的<code>String</code>日期
	 */
	public static String format(Date date, String pattern) {
		if (date == null)
			return "";
		else
			return getFormatter(pattern).format(date);
	}

	/**
	 * 处理时间字符串
	 * @author lxf
	 * @time 2015-1-7下午5:03:12
	 * @param time 毫秒
	 * @return
	 */
	public static String formatTime(long time) {
		if(time < 0){
			return "---";
		}
		long days, hours, minutes, seconds;
		days = time / 86400000;
		time = time - (days * 3600 * 24 * 1000);
		hours = time / 3600000;
		time = time - (hours * 3600 * 1000);
		minutes = time / 60000;
		time = time - (minutes * 60 * 1000);
		seconds = time / 1000;
		String str = "";
		if (days > 0) {
			str += days + "天";
		}
		
		if (hours > 0) {
			if(hours < 10 && str.length() > 0){
				str += "0";
			}
			str += hours + "小时";
		}else if(str.length() > 0){
			str += "00小时";
		}
		
		if (minutes > 0) {
			if(minutes < 10 && str.length() > 0){
				str += "0";
			}
			str += minutes + "分钟";
		}else if(str.length() > 0){
			str += "00分钟";
		}
		
		if(seconds > 0){
			if(seconds < 10 && str.length() > 0){
				str += "0";
			}
			str += seconds + "秒";
		}else if(str.length() > 0){
			str += "00秒";
		}
		
		if(str.length() == 0){
			str = "0秒";
		}
		
		return str;
	}

	/**
	 * 获取指定日期往
	 * @param refenceDate
	 * @param intevalDays
	 * @return
	 */
	public static String getBeforeDate(Date refenceDate, int intevalDays) {
		try {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(refenceDate);
			calendar.set(Calendar.DATE, calendar.get(Calendar.DATE)-intevalDays);
			return format(calendar.getTime(), YYYY_MM_DD);
		} catch (Exception ee) {
			return "";
		}
	}

	/**
     * 获取指定日期往
     * @param refenceDate
     * @param intevalDays
     * @return
     */
    public static String getBeforeDate(Date refenceDate, int intevalDays,String pattern) {
        try {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(refenceDate);
            calendar.set(Calendar.DATE, calendar.get(Calendar.DATE)-intevalDays);
            return format(calendar.getTime(), pattern);
        } catch (Exception ee) {
            return "";
        }
    }

	/**
	 * 获取当前日期
	 * 
	 * @return 一个包含年月日的<code>Date</code>型日期
	 */
	public static Date getCurrentDate() {
		Calendar calendar = Calendar.getInstance();
		return calendar.getTime();
	}

	/**
	 * 获取当前日期
	 * 
	 * @return 一个包含年月日的<code>String</code>型日期，但不包含时分秒。yyyy-mm-dd
	 */
	public static String getCurrDateStr() {
		return format(getCurrentDate(), YYYY_MM_DD);
	}
	/**
	 * 获取当前日期，格式如:pattern
	 * @author lxf
	 * time 2015-8-27上午10:40:11
	 * @param pattern 日期格式
	 * @return 所需格式日期
	 */
	public static String getCurrDateStr(String pattern){
		return format(getCurrentDate(),pattern);
	}

	/**
	 * 获取当前时间所处季度
	 * @return
	 */
	public static String getCurrentQuarter()
	{
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(getCurrentDate());
		int season = (calendar.get(Calendar.MONTH)/3) + 1;
		return calendar.get(Calendar.YEAR)+"年"+season+"季";
	}
	
	/**
	 * 获取当前的时间
	 * 
	 * @return 一个包含时分的<code>String</code>型日期。hh:mm
	 */
	public static String getCurrentHMStr() {
		return format(getCurrentDate(), HH_MM);
	}
	
	/**
	 * 获取当前时间
	 * 
	 * @return 一个包含年月日时分秒的<code>String</code>型日期。hh:mm:ss
	 */
	public static String getCurrentTimeStr() {
		return format(getCurrentDate(), HH_MM_SS);
	}

	/**
	 * 获取当前日期号 样式：dd
	 * 
	 * @return 当前日期号
	 */
	public static String getCurrentDayStr() {
		return format(getCurrentDate(), DD);
	}
	/**
	 * 获取当前日期号
	 * @author lxf
	 * time 2015-8-27上午11:03:49
	 * @return
	 */
	public static int getCurrentDayNum(){
		Calendar calendar = Calendar.getInstance();
		return calendar.get(Calendar.DAY_OF_MONTH); 
	}

	/**
	 *获取当月的天数
	 *@param year
	 *@param month
	 * */
	public static int getDayOfMonth(int year, int month)
	{
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, Integer.valueOf(year));
		calendar.set(Calendar.MONTH,Integer.valueOf(month)-1);
		int dayOfMonth = calendar.getActualMaximum(Calendar.DATE);//本月最大天数
		return dayOfMonth;
	}

	/**
	 * 获取当前日期所在月的第一天的日期
	 * 
	 * @param current
	 * @return
	 */
	public static Date getFirstDate(Date current) throws Exception {
		try {
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			return calendar.getTime();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 获取指定月份的第一天
	 * @author lxf
	 * time 2015-8-24下午2:33:29
	 * @param current
	 * @return firstDate
	 * @throws Exception
	 */
	public static Date getFirstDate(String current) throws Exception {
		Date currDate= DateUtils.parse(current);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(currDate);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		try {
			return calendar.getTime();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 根据传入日期2012-02 获得上个月的2012-01
	 * 
	 * @throws Exception
	 */
	public  static String getLastMonth(String date) throws Exception {
		if (!date.equals("") && date != null) {
			Date dateTemp = DateUtils.parse(date, DateUtils.YYYY_MM);
			Date beforeMonth = DateUtils.getLastMonth(dateTemp);
			return DateUtils.format(beforeMonth, DateUtils.YYYY_MM);
		} else {
			return date;
		}
	}

	/**
	 * 获取指定天数后的日期，不包括周六周日
	 * 
	 * @param date
	 *            指定的日期
	 * @param day
	 *            时间间隔
	 * @return 返回规定时限后的日期
	 */
	public static Date getIntervalDate(Date date, int interval) {
		Date applyDate = null;
		Calendar replay = Calendar.getInstance();
		if (date == null) {
			return null;
		}
		replay.setTime(date);
		for (int i = 0; i < interval; i++) {
			replay.roll(Calendar.DAY_OF_YEAR, 1);
			while (replay.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY
					|| replay.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
				replay.roll(Calendar.DAY_OF_YEAR, 1);
			}
		}
		applyDate = replay.getTime();
		return applyDate;
	}

	/**
	 * 得到两个时间相差的天数
	 */ 
	public static long getIntevalDays(Date startDate, Date endDate) {
		try {
			Calendar startCalendar = Calendar.getInstance();
			Calendar endCalendar = Calendar.getInstance();

			startCalendar.setTime(startDate);
			endCalendar.setTime(endDate);
			long diff = endCalendar.getTimeInMillis()
					- startCalendar.getTimeInMillis();

			return (diff / (1000 * 60 * 60 * 24));
		} catch (Exception ee) {
			return 0l;
		}
	}

	/**
	 * 得到两个时间相差的天数
	 */ 
	public static long getIntevalDays(String startDate, String endDate) {
		try {
			return getIntevalDays(parse(startDate, YYYY_MM_DD), parse(endDate,
					YYYY_MM_DD));
		} catch (Exception ee) {
			return 0l;
		}
	}
	/**
	 * 得到两个时间相差的小时数
	 */ 
	public static double getIntevalHours(Date startDate, Date endDate) {
		try {
			Calendar startCalendar = Calendar.getInstance();
			Calendar endCalendar = Calendar.getInstance();

			startCalendar.setTime(startDate);
			endCalendar.setTime(endDate);
			long diff = endCalendar.getTimeInMillis()
					- startCalendar.getTimeInMillis();

			return ((double) diff / (1000 * 60 * 60));
		} catch (Exception ee) {
			return 0.0;
		}
	}

	/**
	 * 得到两个时间相差的年数(zhouyong)
	 */ 
	@SuppressWarnings("deprecation")
	public static int getIntevalYears(Date startDate, Date endDate) {
		try {
			int a = startDate.getYear();
			int b = endDate.getYear();
			return b - a;
		} catch (Exception ee) {
			return 0;
		}
	}

	/***
	 * 将当前时间向前推进一个月
	 * @author lxf
	 * 2012-04-18   ---->2012-03-18
	 */
	public static Date getLastMonth(Object date) {
		Calendar cl = Calendar.getInstance();
		Date temp = null;
		
		if (date instanceof Date) {
			temp = (Date) date;
		}
		
		if (date instanceof String) {
			try {
				temp = parse((String) date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		cl.setTime(temp);
		cl.add(Calendar.MONTH, -1);
		return cl.getTime();
	}
	

	/**
	 * 获取给定日期上个月的最后一天的日期
	 * 
	 * @param date
	 * @return
	 * @throws Exception
	 */
	public static Date getFinallyDayOfLastMonth(Date date) throws Exception {
		try {
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			c.set(Calendar.DATE,1);//设为当前月的1号
			c.add(Calendar.DATE, -1);// 减一天，变为上月最后一天
			return c.getTime();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 获取当前月最后一天日期
	 * @author lxf
	 * time 2015-8-27上午11:22:54
	 * @param date
	 * @return
	 */
	public static Date getFinallytDayOfCurrentMonth(Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE));
		return calendar.getTime();
	}
	/**
	 * 获取给定日期上年的当天的日期
	 * @param Date date
	 * @return 年份减一
	 * @throws Exception
	 */
	public static Date getLastYearDate(Date date) throws Exception {
		try {
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			c.add(Calendar.YEAR, -1);// 减一年，变为去年的第一天
			return c.getTime();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 获取当前月分 样式：MM
	 * 
	 * @return 当前月分
	 */
	public static String getCurrMonthStr() {
		return format(getCurrentDate(), MM);
	}
	/**
	 * 当前月份数字
	 * @author lxf
	 * time 2015-8-27上午10:33:54
	 * @return 当前月数字
	 */
	public static int getCurrMonthNum(){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(getCurrentDate());
		int i = calendar.get(Calendar.MONTH);
		return i + 1;
	}
	/**
	 * 拿到两个间格时间相距多少月份
	 * @param startyear 开始年
	 * @param startmonth开始月
	 * @param endyear结束年
	 * @param endmonth结束月
	 * @return返回月份的list对象，每条数据以yyyymm表示
	 */
	@SuppressWarnings("unchecked")
	public static List getMonthList(int startyear,int startmonth,int endyear,int endmonth)
	{
		List result=new ArrayList();
		for(int i=startyear;i<=endyear;i++)
		{
			for(int j=startmonth;j<=12;j++)
			{
				//判断是否是当年的数据
				if(startyear==endyear && j>endmonth)
				{
					break;
				}
				else
				{
					if(i==endyear && j>endmonth)
					{
						break;
					}
					else
					{
						if(j<10)
						{
							result.add(i+"0"+j);
						}
						else
						{
							result.add(String.valueOf(i)+String.valueOf(j));
						}
					}
				}
			}
		}
		return result;
	}

	/**
	 * 获取给定日期的后intevalDay天的日期
	 * 
	 * @param refenceDate
	 *            Date 给定日期
	 * @param intevalDays
	 *            int 间隔天数
	 * @return String 计算后的日期
	 */
	public static String getNextDate(Date refenceDate, int intevalDays) {
		try {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(refenceDate);
			calendar.set(Calendar.DATE, calendar.get(Calendar.DATE)
					+ intevalDays);
			return format(calendar.getTime(), YYYY_MM_DD);
		} catch (Exception ee) {
			return "";
		}
	}

	/**
	 * 获取给定日期的后intevalDay天的日期
	 * 
	 * @param refenceDate
	 *            给定日期（格式为：yyyy-MM-dd）
	 * @param intevalDays
	 *            间隔天数
	 * @return 计算后的日期
	 */
	public static String getNextDate(String refenceDate, int intevalDays) {
		try {
			return getNextDate(parse(refenceDate, YYYY_MM_DD), intevalDays);
		} catch (Exception ee) {
			return "";
		}
	}

	/**
	 *	将当前时间加一个月,返回Date对象.
	 * @param date
	 * @return 下一月的Date对象
	 */
	public static Date getNextMonthDate(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MONTH, 1);// 加一月，变为下一月
		return c.getTime();
	}
	
	/**
	 *	将当前时间加一年,返回Date对象.
	 *	@author FanQinglin
	 * @param date
	 * @return 下一年的Date对象
	 */
	public static Date getNextYearDate(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.YEAR, 1);// 加一月，变为下一月
		return c.getTime();
	} 
	
	/**
	 * 获取date日期之前连续指定的日期
	 * 
	 * @param date
	 *            当前日期Date类型 interval 指定之前连续的日期天数
	 * @return
	 */
	public static String[] getRecentDays(Date date, int interval) {
		Calendar c = Calendar.getInstance();
		if (date == null) {
			date = new Date();
		}
		c.setTime(date);
		String[] days = new String[interval];
		days[0] = DateUtils.format(date, DateUtils.YYYY_MM_DD);
		System.out.println(days[0].substring(5));
		for (int i = 1; i < days.length; i++) {
			c.add(Calendar.DAY_OF_YEAR, -1);
			Date d1 = c.getTime();
			days[i] = DateUtils.format(d1);
			System.out.println(days[i].substring(5));
		}
		return days;
	}
	 
	/**
	 * 获取date日期之前连续指定的月份个数
	 * 
	 * @param date
	 *            指定的日期 Date类型 interval 指定之前连续的月份个数
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static String[] getRecentMonths(Date date, int interval) {
		if (date == null) {
			date = new Date();
		}
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		String[] months = new String[interval];
		months[0] = DateUtils.format(date, DateUtils.YYYY_MM_DD);
		for (int i = 1; i < months.length; i++) {
			c.roll(Calendar.MONTH, -1);
			Date d = c.getTime();
			if (d.getMonth() == 0) {
				c.roll(Calendar.YEAR, -1);
			}
			months[i] = DateUtils.format(d);
			System.out.println(months[i]);
		}
		return months;
	}
	
	/**
	 * 获取去年，今年，明年的年月，格式为2011年10月
	 * @author lxf
	 */
	public static List<String> getThreeYearMonth(){
		int year = getCurrentYearNum();
		List<Integer> ls=new ArrayList<Integer>();
		ls.add(year-1);
		ls.add(year);
		ls.add(year+1);
		List<String> list=new ArrayList<String>();
		for(int i=0;i<ls.size();i++)
		{
			int value=ls.get(i);
			for(int j=1;j<=12;j++)
			{
				list.add(value+"年"+j+"月");
			}
		}
		
		return list;
	}
	/**
	 * 去年本月，今年前一月，本月
	 * @author lxf
	 * @param date
	 * @return
	 */
	public static List<String> getThreeMonthOfTHB(String date){
		List<String> result = new ArrayList<String>();
		try {
			Date tempDate = parse(date);
			result.add(format(getLastYearDate(tempDate),YYYY_MM));
			result.add(format(getLastMonth(tempDate),YYYY_MM));
			result.add(format((tempDate),YYYY_MM));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 获取去年，今年，明年的年月，格式为2011年1季度
	 * @author 朱强
	 */
	public static List<String> getThreeYearQuarter(){
		int year=getCurrentYearNum();
		List<Integer> ls=new ArrayList<Integer>();
		ls.add(year-1);
		ls.add(year);
		ls.add(year+1);
		List<String> list=new ArrayList<String>();
		for(int i=0;i<ls.size();i++)
		{
			int value=ls.get(i);
			for(int j=1;j<=4;j++)
			{
				list.add(value+"年"+j+"季度");
			}
		}
		return list;
	}
	
	/**
	 * 获取指定日期为周几 
	 * @return String
	 */
	public static String getWeekOfDate(Date date){
		String[] weeks = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int week = calendar.get(Calendar.DAY_OF_WEEK) - 1;
		return weeks[0 > week ? 0 : week];
	}
	
	/**
	 * 获取当前年分 样式：yyyy
	 * 
	 * @return 当前年分
	 */
	public static String getCurrentYearStr() {
		return format(getCurrentDate(), YYYY);
	}
	/**
	 * 获取当前年份
	 * @author lxf
	 * @return
	 */
	public static int getCurrentYearNum() {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(getCurrentDate());
		return calendar.get(Calendar.YEAR);
	}
	
	/**
	 * 从给定年到当前时间的年份列表
	 * @param givenYear
	 */
	public static List<String> getYears(int givenYear) {
		List<String> yearList = new ArrayList<String>();
		int curYear = getCurrentYearNum();
		for (int i = givenYear; i <= curYear; i++) {
			yearList.add(String.valueOf(i));
		}
		return yearList;
	}
	/**
	 * 按给定日期样式判断给定字符串是否为合法日期数据
	 * 
	 * @param strDate
	 *            要判断的日期
	 * @param pattern
	 *            日期样式
	 * @return true 如果是，否则返回false
	 */
	public static boolean isDate(String strDate, String pattern) {
		try {
			parse(strDate, pattern);
			return true;
		} catch (ParseException pe) {
			return false;
		}
	}
	/**
	 * 判断给定字符串是否为特定格式时分秒（格式：HH:mm:ss）数据
	 * 
	 * @param strDate
	 *            要判断的日期
	 * @return true 如果是，否则返回false
	 */
	public static boolean isHH_MM_SS(String strDate) {
		try {
			parse(strDate, HH_MM_SS);
			return true;
		} catch (ParseException pe) {
			return false;
		}
	}
	/**
	 * 判断给定字符串是否为特定格式年份（格式：yyyy）数据
	 * 
	 * @param strDate
	 *            要判断的日期
	 * @return true 如果是，否则返回false
	 */
	public static boolean isYYYY(String strDate) {
		try {
			parse(strDate, YYYY);
			return true;
		} catch (ParseException pe) {
			return false;
		}
	}
	public static boolean isYYYY_MM(String strDate) {
		try {
			parse(strDate, YYYY_MM);
			return true;
		} catch (ParseException pe) {
			return false;
		}
	}

	/**
	 * 判断给定字符串是否为特定格式的年月日（格式：yyyy-MM-dd）数据
	 * 
	 * @param strDate
	 *            要判断的日期
	 * @return true 如果是，否则返回false
	 */
	public static boolean isYYYY_MM_DD(String strDate) {
		try {
			parse(strDate, YYYY_MM_DD);
			return true;
		} catch (ParseException pe) {
			return false;
		}
	}
	
	public static boolean isYYYY_MM_DD_HH_MM(String strDate) {
		try {
			parse(strDate, YYYY_MM_DD_HH_MM);
			return true;
		} catch (ParseException pe) {
			return false;
		}
	}
	/**
	 * 判断给定字符串是否为特定格式年月日时分秒（格式：yyyy-MM-dd HH:mm:ss）数据
	 * 
	 * @param strDate
	 *            要判断的日期
	 * @return true 如果是，否则返回false
	 */
	public static boolean isYYYY_MM_DD_HH_MM_SS(String strDate) {
		try {
			parse(strDate, YYYY_MM_DD_HH_MM_SS);
			return true;
		} catch (ParseException pe) {
			return false;
		}
	}
	
	/**
	 * 默认为yyyy-MM-dd格式的解析
	 * 
	 * @param strDate
	 * @return
	 * @throws java.text.ParseException
	 */
	public static Date parse(String strDate) throws ParseException {
		try {
			return getFormatter("yyyy-MM-dd").parse(strDate);
		} catch (ParseException pe) {
			throw new ParseException(
					"Method parse in Class DateUtils  err: parse strDate fail.",
					pe.getErrorOffset());
		}
	}
    
    /**
	 * 日期解析－将<code>String</code>类型的日期解析为<code>Date</code>型
	 * 
	 * @param date
	 *            待格式化的日期
	 * @param pattern
	 *            日期样式
	 * @exception java.text.ParseException
	 *                如果所给的字符串不能被解析成一个日期
	 * @return 一个被格式化了的<code>Date</code>日期
	 */
	public static Date parse(String strDate, String pattern)
			throws ParseException {
		try {
			return getFormatter(pattern).parse(strDate);
		} catch (ParseException pe) {
			throw new ParseException(
					"Method parse in Class DateUtils  err: parse strDate fail.",
					pe.getErrorOffset());
		}
	}
	/**
	 * 格式化MySQL日期
	 * @author lxf
	 * @param list
	 * @param dateName
	 * @return
	 */
	public static List<HashMap<String, Object>> formatMySQLDate(List<HashMap<String, Object>> list,String dateName,String pattern){
		for (HashMap<String, Object> hashMap : list) {
			Timestamp date = (Timestamp) hashMap.get("SM_DATE");
			hashMap.put(dateName, DateUtils.format(date,pattern));
		}
		return list;
	}

	public DateUtils() {
	}
	
	/**
	 * 获取一个简单的日期格式化对象
	 * 
	 * @return 一个简单的日期格式化对象
	 */
	private static SimpleDateFormat getFormatter(String parttern) {
		return new SimpleDateFormat(parttern);
	}
}
