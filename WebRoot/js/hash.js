var Hash = function(){
    this._data = new Object();    
}
    function Hash$add(key,value){     
        if(!key) return;
        if(typeof(value) === 'undefined') return;        
        this._data[key] = value;   
    }
    function Hash$addRange(h){
        if(!h || !h._data) return;
        for(var key in h._data){
            var value = h._data[key];            
            this.add(key,value);            
        }
    }
    function Hash$remove(key){
        if(!key) return null;
        var value = this._data[key];
        delete this._data[key];    
        return value;              
    }
    
    function Hash$removeAt(index){
        if(isNaN(index)) return null;
        var i = 0;        
        for(var key in this._data){
            if(i == index){
                return this.remove(key);
            }
            i++;
        }
        return null;
    }
    function Hash$removeRange(startIndex,endIndex){
        if(isNaN(startIndex) || isNaN(endIndex)) return null;
        if(startIndex > endIndex)return null;
        var i = 0;
        var h = new Hash();
        for(var key in this._data){
            if(i>=startIndex && i<= endIndex){
                h.add(key,this.remove(key));
            }else if(i>endIndex){                
                break;
            }
            i++;
        }        
        return h;
    }    
    function Hash$getCount(){
        var i = 0;
        for(var key in this._data) i++;        
        return i;
    }
    function Hash$find(key){
        if(!key) return null;   
        return this._data[key];
    }
    function Hash$forEach(method,instance){
        var i = 0;
        for(var key in this._data){
            var value = this._data[key];
            if(typeof(value) !== 'undefined'){
                var r = method.call(instance, key, value, i, this);
                if(r == 'break') break;                
                i++;
            }
        }
    }
    function Hash$getKeys(){
        var arr = new Array();
        for (var key in this._data){
            arr.push(key);
        }
        return arr;
    }
    function Hash$getValues(){
        var arr = new Array();
        for (var key in this._data){
            arr.push(this._data[key]);
        }
        return arr;        
    }
	function Hash$clear(){
		for(var key in this._data){this.remove(key);}
		delete this._data;
		this._data = new Object(); 
	}

Hash.prototype = {
    _data : null,
    add : Hash$add,
    addRange: Hash$addRange,
    remove : Hash$remove,
    removeAt : Hash$removeAt,
    removeRange : Hash$removeRange,
    getCount : Hash$getCount,
    find : Hash$find,
    forEach : Hash$forEach,
    getKeys : Hash$getKeys,
    getValues : Hash$getValues,
	clear : Hash$clear
}
Hash.__typeName = 'Hash';
