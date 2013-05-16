<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ include file="config.jsp"%>
<%
JSONArray array_obj = new JSONArray();
//Parameter 
String paramYear=request.getParameter("paramYear");
String paramMonth=request.getParameter("paramMonth");
String paramUser=request.getParameter("paramUser");
String paramProject=request.getParameter("paramProject");
String cateKpi=request.getParameter("cateKpi");
String paramScore=request.getParameter("score");
String paramKpiCode=request.getParameter("paramKpiCode");


//Parameter

if(request.getParameter("request").equals("month")){
	
//out.println("paramYear"+paramYear);

String queryMonth="";
queryMonth+="select distinct result_month, result_month_name";
queryMonth+=" from kpi_result";
queryMonth+=" where result_year = "+paramYear+"";
queryMonth+=" order by result_month ";
JSONArray array_obj1 = new JSONArray();
	rs=mysqlConn.selectData(queryMonth);
	while(rs.next()){
		//out.println(rs.getString("result_month_name"));
		JSONArray array_obj2 = new JSONArray();
		array_obj2.add(rs.getString("result_month_name"));
		array_obj2.add(rs.getString("result_month"));

		array_obj1.add(array_obj2);
	}
	out.println(array_obj1);
}
if(request.getParameter("request").equals("Project")){
	
	//out.println("paramYear"+paramYear);
	//out.println("paramMonth"+paramMonth);
	//out.println("paramUser"+paramUser);

	String queryProject="CALL ParamProject('"+paramUser+"',"+paramYear+","+paramMonth+")";
	rs=mysqlConn.selectData(queryProject);
	String project_code="";
	while(rs.next()){
	project_code = rs.getString("project_code");
	array_obj.add(project_code);
	}
	
	out.println(array_obj);
	
	
/*
select distinct project_code
from project_user
where user_name =00000001
and result_year = 2012
and result_month = 12
order by project_code
*/
}
if(request.getParameter("request").equals("TotalWeightPercentage")){
	//out.println("hello world total weightp percentage");
	//out.println("paramYear"+paramYear);
	//out.println("paramMonth"+paramMonth);
	//out.println("paramProject"+paramProject);
	String	project="";
	Double	total_weight_percentage=0.0;
	String color_code="";
	String TotalWeightPercentage="CALL TotalWeightPercentage("+paramYear+","+paramMonth+",'"+paramProject+"')";
	rs=mysqlConn.selectData(TotalWeightPercentage);
	if(rs.next()){
	project=rs.getString("project");
	total_weight_percentage=rs.getDouble("total_weight_percentage");
		String threshold_score="CALL threshold_color("+total_weight_percentage+")";
		rs=mysqlConn.selectData(threshold_score);
		if(rs.next()){
			color_code=rs.getString("color_code");
		}
	}
	
	array_obj.add(project);
	array_obj.add(total_weight_percentage);
	array_obj.add(color_code);
	out.println(array_obj);
	
}
if(request.getParameter("request").equals("catePerspective")){
	//out.println("paramYear"+paramYear);
	//out.println("paramMonth"+paramMonth);
	//out.println("paramProject"+paramProject);
	JSONArray array_objCate = new JSONArray();
	String queryPerspective="CALL catePerspective("+paramYear+","+paramMonth+",'"+paramProject+"')";
	rs=mysqlConn.selectData(queryPerspective);
	
		
			while(rs.next()){
			//out.println(rs.getString("perspective_name"));
			array_objCate.add(rs.getString("perspective_name"));
			
	}
	out.println(array_objCate);
}

if(request.getParameter("request").equals("KpiList")){
	/*
	out.println("paramYear"+paramYear);
	out.println("paramMonth"+paramMonth);
	out.println("paramProject"+paramProject);
	out.println("cateKpi"+cateKpi);
	*/
	//2012,12,10000000,'Customer'
	JSONArray objKpi = new JSONArray();
	
	String queryKpi="CALL KpiList("+paramYear+","+paramMonth+",'"+paramProject+"','"+cateKpi+"')";
	
	
	rs= mysqlConn.selectData(queryKpi);
	while(rs.next()){
		JSONArray objKpiSub = new JSONArray();
		objKpiSub.add(rs.getString(1));
		objKpiSub.add(rs.getString(2));
		objKpiSub.add(rs.getString(3));
		objKpiSub.add(rs.getString(4));
		objKpiSub.add(rs.getString(5));
		objKpiSub.add(rs.getString(6));
		objKpiSub.add(rs.getString(7));
		objKpiSub.add(rs.getString(8));
		objKpiSub.add(rs.getString(9));

		
		objKpi.add(objKpiSub);
		
	}
	out.println(objKpi);
}
if(request.getParameter("request").equals("threshold_color")){
	//out.println("score"+paramScore);
	JSONArray obj_color=new JSONArray();
	String queryColorScore="CALL threshold_color("+paramScore+")";
	rs=mysqlConn.selectData(queryColorScore);
	rs.next();
	
	obj_color.add(rs.getString("color_code"));
	out.println(obj_color);
}
if(request.getParameter("request").equals("ItemList")){
	
	/*
	out.println("paramYear"+paramYear);
	out.println("paramMonth"+paramMonth);
	out.println("paramProject"+paramProject);
	out.println("paramKpiCode"+paramKpiCode);
	*/
	JSONArray objKpiItemList = new JSONArray();
	//String queryItemList="CALL ItemList("+paramYear+","+paramMonth+",'"+paramProject+"','"+paramKpiCode+"')";
	String queryItemList="CALL ItemList(2012,12,'10000000','CS1')";
	//String queryItemList="CALL ItemList(2012,12,'10000000','CS1')";
	rs=mysqlConn.selectData(queryItemList);
	ResultSet rs2=null;
	while(rs.next()){
		JSONArray objKpiItemListSub = new JSONArray();
		objKpiItemListSub.add(rs.getString(1));
		objKpiItemListSub.add(rs.getString(2));
		objKpiItemListSub.add(rs.getString(3));
		objKpiItemListSub.add(rs.getString(4));
		objKpiItemListSub.add(rs.getString(5));
		objKpiItemListSub.add(rs.getString(6));
		
		
		String threshold_score2="CALL threshold_color("+rs.getString(7)+")";
		rs2=mysqlConn.selectData(threshold_score2);
		if(rs2.next()){
			//color_code=rs.getString("color_code");
			objKpiItemListSub.add(rs2.getString("color_code"));
		}
		objKpiItemListSub.add(rs.getString(7));
		objKpiItemListSub.add(rs.getString(8));
	
		objKpiItemList.add(objKpiItemListSub);
		
	}
	out.println(objKpiItemList);
}

if(request.getParameter("request").equals("ComparisonChart")){
	/*
	out.println("paramYear"+paramYear);
	out.println("paramMonth"+paramMonth);
	out.println("paramProject"+paramProject);
	out.println("cateKpi"+cateKpi);
	*/
	String ComparisonChart="CALL ComparisonChart("+paramYear+","+paramMonth+",'"+paramProject+"','"+cateKpi+"')";
	
	JSONArray obj_ComparisonChart =new JSONArray();
	rs=mysqlConn.selectData(ComparisonChart);
	int max=0;
	while(rs.next()){
		JSONArray obj_ComparisonChart_sub =new JSONArray();
		obj_ComparisonChart_sub.add(rs.getString("kpi_code"));
		obj_ComparisonChart_sub.add(rs.getString("achieve_percentage"));
		if(max<=rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
		}
		obj_ComparisonChart_sub.add(max);
		obj_ComparisonChart.add(obj_ComparisonChart_sub);
	}
	out.println(obj_ComparisonChart);
}
if(request.getParameter("request").equals("KpiTrendChart")){
	
	String ComparisonChart="CALL KpiTrendChart("+paramYear+",'"+paramProject+"','"+paramKpiCode+"')";
	
	JSONArray obj_KpiTrendChart =new JSONArray();
	rs=mysqlConn.selectData(ComparisonChart);
	while(rs.next()){
		JSONArray obj_KpiTrendChart_sub =new JSONArray();
		int max =0;
		if(rs.getInt("result_month")!=1){
			obj_KpiTrendChart_sub.add("Jan");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==1){
			obj_KpiTrendChart_sub.add("Jan");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=2){
			obj_KpiTrendChart_sub.add("Feb");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==2){
			obj_KpiTrendChart_sub.add("Feb");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=3){
			obj_KpiTrendChart_sub.add("Mar");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==3){
			obj_KpiTrendChart_sub.add("Mar");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=4){
			obj_KpiTrendChart_sub.add("Apr");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==4){
			obj_KpiTrendChart_sub.add("Apr");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=5){
			obj_KpiTrendChart_sub.add("May");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==5){
			obj_KpiTrendChart_sub.add("May");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=6){
			obj_KpiTrendChart_sub.add("Jun");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==6){
			obj_KpiTrendChart_sub.add("Jun");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=7){
			obj_KpiTrendChart_sub.add("Jul");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==7){
			obj_KpiTrendChart_sub.add("Jul");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
	
		
		
		
		if(rs.getInt("result_month")!=8){
			obj_KpiTrendChart_sub.add("Aug");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==8){
			obj_KpiTrendChart_sub.add("Aug");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=9){
			obj_KpiTrendChart_sub.add("Sep");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==9){
			obj_KpiTrendChart_sub.add("Sep");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=10){
			obj_KpiTrendChart_sub.add("Oct");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==10){
			obj_KpiTrendChart_sub.add("Oct");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=11){
			obj_KpiTrendChart_sub.add("Nov");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==11){
			obj_KpiTrendChart_sub.add("Nov");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		
		if(rs.getInt("result_month")!=12){
			obj_KpiTrendChart_sub.add("Dec");
			obj_KpiTrendChart_sub.add("0");	
		}else if(rs.getInt("result_month")==12){
			obj_KpiTrendChart_sub.add("Dec");
			obj_KpiTrendChart_sub.add(rs.getString("achieve_percentage"));	
			if(max <= rs.getInt("achieve_percentage")){
			max=rs.getInt("achieve_percentage");
			}
		}
		obj_KpiTrendChart_sub.add(max);	
		obj_KpiTrendChart.add(obj_KpiTrendChart_sub);
	}
	out.println(obj_KpiTrendChart);
}

if(request.getParameter("request").equals("Participants")){
	/*
	out.println("paramYear"+paramYear);
	out.println("paramMonth"+paramMonth);
	out.println("paramProject"+paramProject);
	*/
	String queryParticipants="CALL Participants("+paramYear+","+paramMonth+",'"+paramProject+"')";
	//String queryParticipants="CALL Participants(2012,12,10000000)";
	rs= mysqlConn.selectData(queryParticipants);
	String html="";
	
	while(rs.next()){
		html+="<tr>";
		html+="<td>"+rs.getString(1)+"</td>";
		html+="<td>"+rs.getString(2)+"</td>";
		html+="</tr>";
		
	}
	out.println(html);
	
	
	
	
	
}

%>