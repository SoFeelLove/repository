jQuery.extend(    
 {    
  isInt : function (obj)    
  {    
    return Object.prototype.toString.call(obj) === "[object Number]"; 
  },
  isString : function (obj)    
  {    
    return Object.prototype.toString.call(obj) === "[object String]"; 
  },
  isInteger : function(obj)
  {
  	if((typeof obj == 'number') && obj == parseInt(obj))
		{
			return true;
		}
		else if(!isNaN(obj))
		{
			 if(parseInt(obj).toString().length == obj.length) return true; 
		}
		return false;
  }    
 });