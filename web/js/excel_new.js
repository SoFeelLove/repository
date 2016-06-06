/*Excel导出依赖jquery.js,util.js(getFormData函数)*/
(function(){
    if(!window['hnepri']){
        window['hnepri'] = {};
    }
    /*
     * Excel导出基类定义
     */
    function ExcelExport(_page_prefix,_field_config_xml){
        this._field_config_xml = _field_config_xml;//XML配置
        this._page_prefix = _page_prefix;//当前页面的JSP文件前缀
    }
    window['hnepri']['ExcelExport'] = ExcelExport;
    //初始化函数
    ExcelExport.prototype.init = function(){
        //是否只导出当前页面
        this.currentPageOnlyCheck = $($(this._page_prefix + ' currentPageOnlyCheck',this._field_config_xml)[0]).text();
        //导出类型 js,java,customize
        this._excel_export_type = $(this._page_prefix,this._field_config_xml).attr('sqlGenerateType');
        //customize没有内容不处理
        if(this._excel_export_type == 'java'){
            this.paramConfig = {};
        }else if(this._excel_export_type == 'js'){
            this.paramConfig = {};
            this.paramConfig._order = [];
            this.paramConfig._excel_page_search = [];
            var _search = $(this._page_prefix + ' SearchConfig SearchCondition',this._field_config_xml);//搜索条件,即查询条件
           
            var _order = $(this._page_prefix + ' OrderBy Column',this._field_config_xml);
            var _table_name = $(this._page_prefix + ' fromTables table',this._field_config_xml);
            
            this.paramConfig.table_name = $(_table_name[0]).attr('name');

            //查询条件
            for(var i = 0; i < _search.length; i++){
                var temp = $(_search[i]);
                this.paramConfig._excel_page_search.push({name:temp.attr('name'),format:temp.attr('format'),type:temp.attr('type'),option:temp.attr('option'),sqlField:temp.text()});
            }
            //排序字段
            for(var i = 0; i < _order.length; i++){
                var temp = $(_order[i]);
                this.paramConfig._order.push({filed:temp.attr('name'),type:temp.attr('type')});
            }
        }
        //模态窗口列配置
        if(this._excel_export_type == 'java' || this._excel_export_type == 'js'){
        	this.paramConfig._column_config_search = [];
        	var _column = $(this._page_prefix + ' ColumnConfig Column',this._field_config_xml);//模态窗口列配置,即分页显示字段
            for(var i = 0; i < _column.length; i++){
                this.paramConfig._column_config_search.push({name:$(_column[i]).attr('name'),text:$(_column[i]).text()});
            }
        }
        //alert(this.paramConfig._column_config_search.length);
    };
    //生成并提交form
    ExcelExport.prototype.generatorFormAndPost = function(obj,action){
        if(obj && obj.param){
            var oo = obj.param;
			var params = '<form name="excel_export_form" action="' + action + '" method="post"  >';
			params += '<input type="hidden" name="sql" value="' + oo.sql + '"/>';
			params += '<input type="hidden" name="columns" value="' + oo.strEnField + '"/>';
			params += '<input type="hidden" name="headers" value="' + oo.strCnField + '"/>';
			var _cur_page_flag = false;
			if(this.currentPageOnlyCheck == 'true'){
				if(confirm('是否只导出当前页，点击取消导出所有数据。')){
					_cur_page_flag = true;
				}
			}
			if(_cur_page_flag){
				params += '<input type="hidden" name="currentPageOnly" value="1"/>';
				params += '<input type="hidden" name="currentPage" value="' + $('#curPage').val() + '"/>';
			}else{
				params += '<input type="hidden" name="currentPageOnly" value="0"/>';
			}
			
			params += '<input type="hidden" name="sqlGenerateType" value="' + this._excel_export_type + '"/>';
			
			
			if(this._excel_export_type == 'java'){
				var formObj = getFormData();
				for(var name in formObj){
					params += '<input type="hidden" name="' + name + '" value="' + formObj[name] + '"/>';
				}
			}
			params += '</form>';
			var forms = document.getElementsByName('excel_export_form');
			
			for(var i = 0; i < forms.length; i++){
				document.body.removeChild(forms[i]);
			}
			$('body').append(params);
			//alert(params);
			document.forms["excel_export_form"].submit();
		}
    };
    ExcelExport.prototype.generatorSearchConditionSql = function(){
    	if(!this.paramConfig._excel_page_search)return '';
    	var temp = '';
		for(var i = 0; i < this.paramConfig._excel_page_search.length; i++){
			temp += this.combination_sql(this.paramConfig._excel_page_search[i]);
		}
		return temp;
    };
    //用于组合SQL条件
	ExcelExport.prototype.combination_sql = function(obj){		
		var flag = obj.option;
		var type=obj.type;
		var sql_field=obj.sqlField;		
		var _val = $("#" + obj.name).val();
		
		if(!_val) return "";
		if(flag == 'like'){
			return " and " + sql_field + " like '%" + _val + "%'";
		}else if(flag == 'equals'){
			if(type == 'string'){
				return " and " + sql_field + "='" + _val + "'";
			}else if(type == 'num'){				
				return " and " + sql_field + "=" + _val + " ";
			}else if(type == 'date'){
				var format = obj.format;
				return " and " + sql_field + "=to_date('" + _val + "','" + format + "') ";
			}
		}else if(flag == 'greaterEqual'){
			if(type == 'num'){
				return " and " + sql_field + ">=" + _val + " ";
			}else if(type == 'date'){
				var format = obj.format;
				return " and " + sql_field + ">=to_date('" + _val + "','" + format + "') ";
			}
		}else if(flag == 'lessEqual'){
			if(type == 'num'){
				return " and " + sql_field + "<=" + _val + " ";
			}else if(type == 'date'){
				var format = obj.format;
				return " and " + sql_field + "<=to_date('" + _val + "','" + format + "') ";
			}
		}
		else if(flag == 'greaterThan'){
			if(type == 'num'){
				return " and " + sql_field + ">" + _val + " ";
			}else if(type == 'date'){
				var format = obj.format;
				return " and " + sql_field + ">to_date('" + _val + "','" + format + "') ";
			}
		}else if(flag == 'lessThan'){
			if(type == 'num'){
				return " and " + sql_field + "<" + _val + " ";
			}else if(type == 'date'){
				var format = obj.format;
				return " and " + sql_field + "<to_date('" + _val + "','" + format + "') ";
			}
		}
	};
	ExcelExport.prototype.exportExcel = function(action){
		if(this._excel_export_type != 'customize'){
			var _config = {
		        title:'Excel导出',
		        url:'../util/export_columns.html',
		        w:500,
		        h:400,
		        winChild: self,
		        winRefush:0
		    };
		    top.alertWinCall(_config);
		}else{
			var formObj = getFormData();
			var params = '<form name="excel_export_form" action="' + action + '" method="post"  >';
			var _cur_page_flag = false;
			if(this.currentPageOnlyCheck == 'true'){
				if(confirm('是否只导出当前页')){
					_cur_page_flag = true;
				}
			}
			if(_cur_page_flag){
				params += '<input type="hidden" name="currentPageOnly" value="1"/>';
				params += '<input type="hidden" name="currentPage" value="' + $('#curPage').val() + '"/>';
			}else{
				params += '<input type="hidden" name="currentPageOnly" value="0"/>';
			}
			for(var name in formObj){
				params += '<input type="hidden" name="' + name + '" value="' + formObj[name] + '"/>';
			}
			params += '</form>';
			var forms = document.getElementsByName('excel_export_form');
			for(var i = 0; i < forms.length; i++){
				document.body.removeChild(forms[i]);
			}
			$('body').append(params);
			//alert(params);
			document.forms["excel_export_form"].submit();
		}
	};
    //获得当前页面的jsp前缀
    function getCurJSPPrefix(){
        var jsp_prefix = window.location.href;
        if(jsp_prefix.substring(jsp_prefix.length - 1,jsp_prefix.length) == '#'){
            jsp_prefix = jsp_prefix.substring(0,jsp_prefix.length - 1);
        }
        if(jsp_prefix.indexOf('?') != -1){
            jsp_prefix = jsp_prefix.substring(0,jsp_prefix.indexOf('?'));
        }
        jsp_prefix = jsp_prefix.substring(jsp_prefix.lastIndexOf('/') + 1,jsp_prefix.length);
        jsp_prefix = jsp_prefix.substring(0,jsp_prefix.indexOf('.'));
        jsp_prefix = jsp_prefix.replace('!','_');
        return jsp_prefix;
    }
    
    window['hnepri']['getCurJSPPrefix'] = getCurJSPPrefix;
})();
var _excel_export = null;
var _excel_action = '';
$(function(){
    $.get('ExportConfig.xml',null,function(doc){
        _excel_id = '#' +  hnepri.getCurJSPPrefix();   
        _excel_export = new hnepri.ExcelExport(_excel_id,doc);
        _excel_export.init();
        //alert(_excel_export.paramConfig._column_config_search.length);
    },'xml');
});
function callFun_(obj){	
	_excel_export.generatorFormAndPost(obj,_excel_action);
}
function showExcelModelDialog(action){
	_excel_action = action;
	_excel_export.exportExcel(action);
}