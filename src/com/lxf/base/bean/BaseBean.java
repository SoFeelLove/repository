package com.lxf.base.bean;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: tanlei
 * Date: 13-5-29
 * Time: 上午10:37
 * 所有表对象的基础类
 */
public class BaseBean implements Serializable {

    /**
     * 表名
     */
    protected String _tableName="";
    /**
     * 主键
     */
    protected String _pkName="";
    /**
     * 主键生成序列名称
     */
    protected  String _sequencesName="";
    /**
     * 主键生成序列名称
     */
    public String getSequencesName() {
        return _sequencesName;
    }

    /**
     * 表名
     * @return
     */
    public String getTableName() {
        return _tableName;
    }

    /**
     * 主键
     * @return
     */
    public String getPkName() {
        if(_pkName.equals(""))
        {
            _pkName="id";
        }
        return _pkName;
    }
}
