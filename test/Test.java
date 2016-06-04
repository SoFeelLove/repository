import java.util.HashMap;
import java.util.Map;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;


public class Test {
    
    public static void opEditor(){
    	boolean [] isEditor ={false,false,true,true,true};
    	String [] editorType ={"textbox","textbox","numberbox","numberbox","numberbox"};
    	int i = 0; //标记，记数
    	for (boolean bool : isEditor) {
    		
    		StringBuffer stringBuffer = new StringBuffer("editor:{");		
			stringBuffer.append("type:'"+editorType[i]+"'");
			if (editorType[i].equals("numberbox")) {
				stringBuffer.append(", options:{precision:2}");
			}
			stringBuffer.append("}");
			i++;
			System.out.println(stringBuffer);
		}
    }
    
	public static void main(String[] args) {
		Map map = new HashMap();
		map.put("lxf", "1");
		map.put("ckl", 2);
		System.out.println(map.containsKey("ckl"));
		System.out.println("lxfckl".contains("lxf"));
		opEditor();
	}
	

}
