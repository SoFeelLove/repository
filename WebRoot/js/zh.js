(function(){
    if(!window['zh']) window['zh'] = {};
    String.prototype.trim = function()
    {
        var rePatten = /^\s*(.*?)\s*$/;
        var temp = this.replace(rePatten,'$1');
        return temp;
    };
    function $() {
	    var elements = new Array();
	    // Find all the elements supplied as arguments
	    for (var i = 0; i < arguments.length; i++) {
	        var element = arguments[i];
	        // If the argument is a string assume it's an id
	        if (typeof element == 'string') {
	            element = document.getElementById(element);
	        }
	        // If only one argument was supplied, return the element immediately
	        if (arguments.length == 1) {
	            return element;
	        }
	        // Otherwise add it to the array
	        elements.push(element);
	    }
	    
	    // Return the array of multiple requested elements
	    return elements;
	};
	window['zh']['$'] = $;
    /**
    * 模仿Java中的StringBuffer操作(性能比直接使用字符串相加方式节省50%~66%的时间)
    * 使用方式:
    * var sb = new zh.StringBuffer();
    * sb.append("zh");
    * sb.append("kangzh");
    * alert(sb.toString());
    */
    function StringBuffer()
    {
        this._strings_ = [];
    }
    StringBuffer.prototype.append = function(str)
    {
        this._strings_.push(str);
    };
    StringBuffer.prototype.toString = function()
    {
        return this._strings_.join("");
    };
    window['zh']['StringBuffer'] = StringBuffer;
    /**
    * 模仿JAVA中的List
    * 使用方法：
    * var a = new zh.List(1,2,3);
    * a.add(4);
    * a.add(5,6,7);
    * alert(a.length);
    * alert(a);
    */
   function List()
   {
       var m_elements = [];
       m_elements = Array.apply(m_elements,arguments);
       this.length = {
           valueOf:function(){
               return m_elements.length;
           },
           toString:function(){
               return m_elements.length;
           }
       };
       this.toString = function()
       {
           return m_elements.toString();
       }
       this.add = function()
       {
           m_elements.push.apply(m_elements,arguments);
       }
   }
   window['zh']['List'] = List;
   
   /**
    * 对数组数据进行去重
    * @param aData 数组
    * @return 去除重复数据后的数组
    */
   function quChongArr(aData)
   {
       var aTemp = [];
       var bflag;
       for(var i = 0; i < aData.length; i++)
       {
           bflag = true;
           for(var j = 0; j < aTemp.length; j++)
           {
               if(aTemp[j] == aData[i])
               {
                   bflag = false;
                   break;
               }
           }
           if(bflag)aTemp.push(aData[i]);
       }
       return aTemp;
   }
   window['zh']['quChongArr'] = quChongArr;
   /**
    *检查数组中是否存在新添加的条目
    *aArray:数组
    *item  :新添加的条目
    *存在返回true否则返回false
    */
	function checkExist(aArray,item){
		for(var i = 0; i < aArray.length; i++)
			if(aArray[i] == item)return true;
		return false;
	}
	window['zh']['checkExist'] = checkExist;
	
	//判断是否是int类型
	function checkInt(str)
	{
		if(parseInt(str)==str)   
	 		return true; 
	 	else
	 		return false;
	}
	window['zh']['checkInt'] = checkInt;
    //--------------------------------------------取得数组比较函数---------------------------------------
    /*格式化为日期(此处假设传来的数据要么是正确的格式要么就是空)
    *new Date(yy,mm,dd,hh,mm,ss)
    *此处处理日期格式为yyyy-MM-dd或者yyyy-MM-dd HH24:mi:ss
    */
    function dateParse(sDate){
		if(!sDate)return null;//如果不是数据就返回
		var arrd = sDate.split(' ');
		var _date = arrd[0].split('-');
		if(arrd.length == 2){
		    var _time = arrd[1].split(':');
		    return new Date(_date[0],_date[1],_date[2],_time[0],_time[1],_time[2]);
		}else{
		    return new Date(_date[0],_date[1],_date[2]);
		}
    }
    /*
    *sValue   :待转型值
    *sDataType:数据类型(int,float,date,string)
    */
    function convertFun(sValue, sDataType){
		if(sDataType == 'int'){
		    return parseInt(sValue,10);
		}else if(sDataType == 'float'){
		    return parseFloat(sValue,10);
		}else if(sDataType == 'date'){
		    return dateParse(sValue);
		}else{
		    return sValue.toString();
		}
    }
    /*取得基本数据类型数组比较函数(排序方式-正序)
    *sDateType:数据类型(int,float,date,string)
    *
    */
    function getBaseSortFun(sDateType){
		return function(param1,param2){
		    var vValue1 = convertFun(param1,sDateType);
		    var vValue2 = convertFun(param2,sDateType);
		    if(vValue1 < vValue2){//左边小于右边不用换位置
				return -1;
		    }else if(vValue1 > vValue2){//左边大于右边，交换位置
				return 1;
		    }else{//相等，直接返回
				return 0;
		    }
		}
    }
    /*使用方式var fun = zh.getBaseSortFun('int')参数可取值为float,date,string
    *  arr.sort(fun);
    */
    window['zh']['getBaseSortFun'] = getBaseSortFun;
})();