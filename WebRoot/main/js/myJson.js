function test(){ 
var person= {
  name: 'zhangsan',
  pass: '123' ,
  'sni.ni' : 'sss',
  hello:function (){
     for(var i=0;i<arguments.length;i++){
             //在不知参数个数情况下可通过for循环遍历            
             // arguments这个是js 默认提供
            alert("arr["+i+"]="+arguments[i]);
     }    
  }
 }
  
//遍历属性
 for(var item in person){
    if(typeof person[item]  === 'string'){
      alert("person中"+item+"的值="+person[item]);
    }else if(typeof person[item] === 'function'){
        person[item](1,1);//js 的function的参数可以动态的改变
    } 
 }
//添加属性

 person.isMe = 'kaobian'; // 这种是属性名字正常的
//当属性名字不正常时，像下面这种，必须用这种形式的，
 person['isMe.kaobian'] = 'hello kaobian'; //上面的也可以用下面的形式

 for(var item in person){
    if(typeof person[item]  === 'string'){
      alert("person中"+item+"的值="+person[item]);
    }else if(typeof person[item] === 'function'){

        person[item](1,1);
    } 
 } 
}
//遍历JsonObj
function forEachJsonObj(jsonObj){
	for(var p in jsonObj){
		str = str +jsonObj[p]+',';
	}
	return str;
}
//遍历JsonArray
function forEachJsonArray(){
	var l = jsonArray.length;
	for(var i=0; i < l; i++){
		for(var key in json[i]){
			alert(key+':'+json[i][key]);
		}
	}
}
/**
 * 获取JsonObj的长度
 * @param jsonObj
 */
function getJsonObjLength(jsonObj){
	var length = 0;
	for(var item in jsonObj){
		length++;
	}
	return length;
}
/**
*把passiveObj合并为finalObj
*/
function objMerger(finalObj,passiveObj){

	for(var i =0,l = finalObj.length;i < l;i++){
			is = finalObj[i];
			for(var r in passiveObj){
			eval("is."+r+"=passiveObj."+r);
		}
	}
	return finalObj;
}
