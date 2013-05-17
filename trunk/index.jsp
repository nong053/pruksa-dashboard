<%@page contentType="text/html" pageEncoding="utf-8"%>
<% 
String pjCode="";
String sendParamMonth="";
String sendParamYear="";
String paramYear="";


pjCode = request.getParameter("pjCode");
sendParamMonth =request.getParameter("paramMonth");
sendParamYear = request.getParameter("paramYear");
if(pjCode==null){
pjCode="";
}
if(sendParamYear==null){
sendParamYear="";
}
if(sendParamMonth==null){
sendParamMonth="";
}

%>
<%@ include file="config.jsp" %>
<%@ page language="java" 
	import="java.util.ArrayList,
			org.pentaho.platform.engine.core.system.PentahoSystem,
			org.pentaho.platform.api.engine.IPentahoSession,
			org.pentaho.platform.web.jsp.messages.Messages,
			org.pentaho.platform.web.http.WebTemplateHelper,
			org.pentaho.platform.api.engine.IUITemplater,
			org.pentaho.platform.util.messages.LocaleHelper,
			org.pentaho.platform.util.VersionHelper,
			org.pentaho.platform.api.ui.INavigationComponent,
			org.pentaho.platform.uifoundation.component.HtmlComponent,
			org.pentaho.platform.util.web.SimpleUrlFactory,
			org.pentaho.platform.engine.core.solution.SimpleParameterProvider,
			org.pentaho.platform.uifoundation.chart.ChartHelper,
      org.pentaho.platform.web.http.PentahoHttpSessionHelper" %>
<% String remoteUser = request.getRemoteUser();%>

<!doctype html>
<html>
    <head>
        <title>BSC Dashboard</title>
		<!-- load stylesheet แบบ external-->
		<link href="styles/index.css" rel="stylesheet">
		<link href="styles/kendo.common.min.css" rel="stylesheet">
		<link href="styles/kendo.default.min.css" rel="stylesheet">
		<link href="jqueryUI/css/cupertino/jquery-ui-1.8.21.custom.css" rel="stylesheet">
		<link href="styles/kendo.dataviz.min.css" rel="stylesheet">
		
		<!-- load stylesheet-->
		<!-- load javascript-->
		<script src="js/jquery.min.js"></script>  
		<script type="text/javascript" src="js/jquery.corner.js"></script>
		<script src="js/kendo.all.min.js" type="text/javascript"></script>
		<script src="js/kendo.dataviz.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="js/jquery-ui-1.8.21.custom.min.js"  type="text/javascript"></script>
		<script src="js/kendo.dataviz.min.js" type="text/javascript"></script>
		<!--"WebContent/jqueryUI/js/jquery-ui-1.8.21.custom.min.js"-->
		<!-- load javascript-->
<!-- กำหนด stylesheet แบบ embed-->

	<!-- jq plot css start -->
	
	<link class="include" rel="stylesheet" type="text/css" href="dist/jquery.jqplot.min.css" />
	<link type="text/css" rel="stylesheet" href="syntaxhighlighter/styles/shCoreDefault.min.css" />
	<link type="text/css" rel="stylesheet" href="syntaxhighlighter/styles/shThemejqPlot.min.css" />
   
	<!-- jq plot css end -->
	
	<!-- jq plot javascript start -->
	<script language="javascript" type="text/javascript" src="dist/excanvas.js"></script>
	<script class="include" type="text/javascript" src="dist/jquery.jqplot.min.js"></script>
<!-- Additional plugins go here -->
	<script class="include" language="javascript" type="text/javascript" src="dist/plugins/jqplot.highlighter.min.js"></script>
    <script class="include" language="javascript" type="text/javascript" src="dist/plugins/jqplot.barRenderer.min.js"></script>
    <script class="include" language="javascript" type="text/javascript" src="dist/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script class="include" language="javascript" type="text/javascript" src="dist/plugins/jqplot.pointLabels.min.js"></script>
<!---->	

<!-- End additional plugins -->

	<!-- jq plot javascript end -->


<style type="text/css">
	html,
	body {
		background-color: white;
		color:black;
		font-size:12px;
		font:Tahoma;
		margin:0;
		padding:0;
	}
	*{
	font:Tahoma;
	}
	#content{
	width:975px;
	margin:auto;
	}
	#Detail-Panel {
		position:absolute;
		top:80px;
		left:0px;
		border-radius: 5px;
		border: 1px solid #dedede;
		background-color:#008EC3;
	}
	#loading{
	display:none;
	color:black;
	width:50px;
	height:50px;
	background-image:url("images/loading.gif");
	position:absolute ;
	position:center;
	z-index:5;
	}
	table tbody tr td .toRight{
	text-align:right;
	}
	.tableTitileWidth{
	width:200px;
	}
	.tableParamWidth{
	width:200px;
	}
	
</style>

<style scoped>
	#Main-Panel{
		margin:0px;
		margin-bottom:2px;
		padding: 3px;
		/*border: 1px solid #dedede;*/
		-webkit-border-radius: 5px;
		-moz-border-radius: 5px;
		border-radius: 5px;
		text-align: left;
		min-height: 30px;
		width: 970px;
		position: relative;
		background-color:#008EC3;
		color:white;
		font-weight:bold;
	}
</style>

<script class="code" type="text/javascript">

$(document).ready(function(){
	//define kendoDropDownList default ou load 1
	$("#ParamProject").kendoDropDownList();
	
//Start Chart
var barChart=function(s1,ticks,max){
	
  //  alert("barchart1"+max);
	   var plot1 = $.jqplot('chart1', [s1], {
        seriesDefaults:{
            renderer:$.jqplot.BarRenderer,
			rendererOptions: {
				fillToZero: true,
				barMargin:2,
				barWidth:40
			},
            pointLabels: { show: true, location: 'n', edgeTolerance: -0 }
        },
        series:[
            {label:'%Achieve'},
        ],
/*
        legend: {
            show: true,
            placement: 'outsideGrid',
    
        },
		*/ 
		highlighter: {
			show: false,
			sizeAdjust: 1.0
		 },
        axes: {
            xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer,
                ticks: ticks
            },
            yaxis: {
				min:0, max:max+20,
                pad: 0,
				//ticks:[0, max+20],
                tickOptions: {formatString: '%.2f'}
            }
        }
    });
 // $("#chart1").hide();
}//end function barchart
var barChart2=function(s2,ticks2,max){
	//alert(max);
//var s2 = [200, 600, 700, 1000];
//var ticks2 = ['May', 'June', 'July', 'August'];
    //alert("barChart2"+ticks2);
	   var plot1 = $.jqplot('chart2', [s2], {
     seriesDefaults:{
        renderer:$.jqplot.BarRenderer,
		rendererOptions: {
			fillToZero: true,
			barMargin:2,
			barWidth:40
		},
        pointLabels: { show: true, location: 'n', edgeTolerance: -0 }
     },
     series:[
         {label:'%Achieve'},
     ],
		 /*
     legend: {
         show: true,
         placement: 'outsideGrid',
 
     },
	 */
	 highlighter: {
		show: false,
		sizeAdjust: 1.0
	 },
     axes: {
         xaxis: {
             renderer: $.jqplot.CategoryAxisRenderer,
             ticks: ticks2
         },
         yaxis: {
             pad: 0,
			min:0, max:max+20,
			//ticks:[0, max+20],
             tickOptions: {formatString: '%.2f'}
         }
     }
 });
$("#chart2").hide();
}//end function barchart
  //End Chart

 

	
	//#########################  dialogbox1 start ##################
	$(".kpi").live("click",function(){
		$("#dialogbox2").show();
		//2012,10000000,'CS1'
		var title_name = $(this).html();
		//alert(this.id);
		$.ajax({
			url:'resultUrl.jsp',
			type:'get',
			dataType:'json',
			data:{'request':'KpiTrendChart','paramYear':$("#year").val(),'paramProject':$("#project").val(),'paramKpiCode':this.id},
			success:function(data){
				//console.log(data);
				
				var series="";
				var category="";
				category+="['','"+data[0][0]+"','"+data[0][2]+"','"+data[0][4]+"','"+data[0][6]+"','"+data[0][8]+"','"+data[0][10]+"','"+data[0][12]+"','"+data[0][14]+"','"+data[0][16]+"','"+data[0][18]+"','"+data[0][20]+"','"+data[0][22]+"','']";
				series+="['',"+data[0][1]+","+data[0][3]+","+data[0][5]+","+data[0][7]+","+data[0][9]+","+data[0][11]+","+data[0][13]+","+data[0][15]+","+data[0][17]+","+data[0][19]+","+data[0][21]+","+data[0][23]+",'']";
				//alert(category+""+series);
				var obj_category=eval("("+category+")");
				var obj_series=eval("("+series+")");
				
				
				$("#chart2").remove();
				$("#dialogbox2").append("<div id='chart2'></div>");
				
				$("#dialogbox2").dialog({
					height:370,
					width:650,
					modal:true,
					title:title_name
				});

				barChart2(obj_series,obj_category,data[0][24]);
				$("#chart2").show();
				
			}
		});
	});
	$(".titleKPI_R").live("click",function(){
		$("#dialogbox1").show();
		//alert(this.id);
		var title_name  = $(this).prev().html();
		$.ajax({
			url:'resultUrl.jsp',
			type:'get',
			dataType:'json',
			data:{'request':'ComparisonChart','paramYear':$("#year").val(),'paramMonth':$("#month").val(),'paramProject':$("#project").val(),'cateKpi':this.id},
			success:function(data){
				//console.log(data);
				
				var series="";
				var category="";
				category+="[";
				series+="[";
				var i=0;
				var max1=0;
				$.each(data,function(index,indexEntry){
					
					if(i!=0){
					category+=",";	
					series+=",";	
					}
					category+="'"+indexEntry[0]+"'";
					series+=indexEntry[1];
					max1=indexEntry[2];
				i++;
				});
				category+="]";
				series+="]";
				//alert(category+""+series);
				
				var obj_category=eval("("+category+")");
				var obj_series=eval("("+series+")");
				
				//alert(obj_series+","+obj_category);
				$("#chart1").remove();
				$("#dialogbox1").append("<div id='chart1'></div>");
				
				
				$("#chart1").show();
				
				$("#dialogbox1").dialog({
					height:370,
					width:650,
					modal:true,
					title: title_name
				});
			barChart(obj_series,obj_category,max1);
			
			}
		});
		
		
		
	});
	//#########################  dialogbox1 end ##################
	$(".listSelect").kendoDropDownList();
	
	//################################################ball
	
	var ballRed  = "<div id='ballRed'  class='ball' style='background-color:#e51e25; width:20px;height:20px;border-radius:100px; float:left;'></div>";
	var ballYellow  = "<div id='ballYellow'  class='ball' style='background-color:yellow; width:20px;height:20px;border-radius:100px; float:left;'></div>";
	var ballGreen  = "<div id='ballGreen'  class='ball' style='background-color:#8fbc01; width:20px;height:20px;border-radius:100px; float:left;'></div>";
	var ballGray  = "<div id='ballGray'  class='ball' style='background-color:#cccccc; width:20px;height:20px;border-radius:100px; float:left;'></div>";
	
	var ballColor="";
	var ballColorFunction=function(codeColor){
		ballColor="<div id='ball' class='ball' style='background-color:"+codeColor+"; width:20px;height:20px;border-radius:100px; float:left;'></div>";
		return ballColor;
	}
	//alert(ballColorFunction("#e51e25"));
	//$("#ballScoreTotal").html(ballGreen);
	//################################################# 1
	// TITLE BY JSON START
	//กำหนดค่าเริ่มต้นของชื่อ column เพื่อเอาไว้อ้างอิงกับ datasource

	var $titleJ =[
              {
                  field: "KPI",
				   width: 250
              },
              {
                  field: "UOM",
				  width: 60
			 },
              {
                  field: "Weight",
				  width: 60
			 },
              {
                  field: "Target",
				  width:60
			 },
              {
                  field: "Actual",
				  width: 60
			 },
              {
                  field: "Achieve",
				  width: 60
			 },
             
              {
                  field: "Your",
				  width: 60
			 }];







	//CONTENT BY JSON START 
	//นำค่าที่ได้มาจากการ query แล้วจัดการให้อยู่ในรูปแบบ json ที่ได้จากด้านบนมาเก็บไว้ในตัวแปร $dataJ
/*
KPI
UOM
Weight
Target
Actual
Achieve
Your
	*/
	var $dataJ =[
                  {
                	  KPI: "<div class='kpi'>F1 ลูกค้าจองและทำสัญญาได้ Y MB เป็นไปตามแผนธุรกิจ</div>",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>10</div> ",
                	  Target: "<div class='textR'>400</div>",
                	  Actual: "<div class='textR'>350</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>87.50%</div>",
                	  Your: " <div class='textR'>8.75%<div>"
                     
                     
					  
                     
                  },
                  {
                	  KPI: "<div class='kpi'>F2 โอนกรรมสิทธิ์ได้ Y MB</div>",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>20</div> ",
                	  Target: "<div class='textR'>300</div>",
                	  Actual: "<div class='textR'>290</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>96.67%</div>",
                	  Your: " <div class='textR'>19.33%<div>"
				  }
				  
				  ]; 	
	// ################ Genarate GRID ################# //
	var grid=function(gridName,contentData){
	$("#"+gridName).kendoGrid({
		   //ไม่กำหนดความสูง height จะเป็น auto
          //height: 500,
		  detailInit: detailInit1,
          columns: $titleJ,//[{"filed":"Filed1",width:100},{"filed":"Filed2","width":200}]
          dataSource: {
          data: contentData //[{"Filed1":"content1"},{"Filed2":"content2"}]
			// pageSize: 3,
			
          }
			  /*sortable: true,
                     pageable: {
                        refresh: true,
                        pageSizes: true
              },*/
		
   	});
	
	function detailInit1(e) {
	//console.log(e.data.YEAR);
	//console.log(e.data.MONTH);
	//console.log(e.data.PROJECT);
	//console.log(e.data.KPI_CODE);
	
	$.ajax({
		url:'resultUrl.jsp',
		type:'get',
		dataType:'json',
		data:{'request':'ItemList','paramYear':e.data.YEAR,'paramMonth':e.data.MONTH,'paramProject':e.data.PROJECT,'paramKpiCode':e.data.KPI_CODE},
		success:function(dataItem){
			//alert(dataItem);
			
			var contentData="";
			contentData+="[";
			var j=0;
			$.each(dataItem,function(index,indexEntry){
				/*
				console.log(indexEntry[0]);
				console.log(indexEntry[1]);
				console.log(indexEntry[2]);
				console.log(indexEntry[3]);
				*/
				if(j!=0){
				contentData+=",{";
				}else{
				contentData+="{";
				}
			
				contentData+="KPI:\"<div class='textL'>"+indexEntry[1]+"</div>\",";
				contentData+="UOM:\"<div class='textL'>"+indexEntry[2]+"</div>\",";
				contentData+="Weight:\"<div class='textR'>"+indexEntry[3]+"</div>\",";
				contentData+="Target:\"<div class='textR'>"+indexEntry[4]+"</div>\",";
				contentData+="Actual:\"<div class='textR'>"+indexEntry[5]+"</div>\",";
				contentData+="Achieve:\"<div class='textR'>"+ballColorFunction(indexEntry[6])+""+indexEntry[7]+"%</div>\",";
				contentData+="Your:\"<div class='textR'>"+indexEntry[8]+"</div>\"";
				
				contentData+="}";
				j++;
	
			});
			contentData+="]";
			var obj_contentData = eval("("+contentData+")");
			//console.log(obj_contentData);
			//grid(obj_contentData);
			
			
			
			
			
			
			//funcion gird item
			$("<table bgcolor='#f5f5f5'><th></th></table>").kendoGrid({
				columns: $titleJ2,
				dataSource: {
				data: obj_contentData,
				pageSize: 8
				
			}
			}).appendTo(e.detailCell);
			$(".ball").corner();
			//function grid item
		}
	
	});
	
		
	}
	
	
	};/*end function grid*/
	// ################ Genarate GRID ################# //
	//################################################# 1
	//################################################# 2
	// TITLE BY JSON START
	//กำหนดค่าเริ่มต้นของชื่อ column เพื่อเอาไว้อ้างอิงกับ datasource

	var $titleJ =[
              {
                  field: "KPI",
				   width: 250
              },
              {
                  field: "UOM",
				  width: 60
			 },
              {
                  field: "Weight",
				  width: 60
			 },
              {
                  field: "Target",
				  width:60
			 },
              {
                  field: "Actual",
				  width: 60
			 },
              {
                  field: "Achieve",
				  width: 60
			 },
              {
                  field: "Your",
				  width: 60
			 }];


var $titleJ2 =[
               {
                   field: "KPI",
 				   width: 365
               },
               {
                   field: "UOM",
 				  width: 90
 			 },
               {
                   field: "Weight",
 				  width: 88
 			 },
               {
                   field: "Target",
 				  width:88
 			 },
               {
                   field: "Actual",
 				  width: 90
 			 },
               {
                   field: "Achieve",
 				  width: 89
 			 },
              
               {
                   field: "Your"
 				  //width: 60
 			 }];





	//CONTENT BY JSON START 
	//นำค่าที่ได้มาจากการ query แล้วจัดการให้อยู่ในรูปแบบ json ที่ได้จากด้านบนมาเก็บไว้ในตัวแปร $dataJ
/*
KPI
UOM
Weight
Target
Actual
Achieve
Your
	*/
	var $dataJ21 =[
                  {
                	  KPI: "<div class='kpi'>CS1: ความพึงพอใจของลูกค้าต่อคุณภาพบ้านหลังโอน</div>",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>20</div> ",
                	  Target: "<div class='textR'>90</div>",
                	  Actual: "<div class='textR'>88</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>97.78%</div>",
                	  Your: " <div class='textR'>19.56%<div>"
                     
                     
					  
                     
                  },
                  {
                	  KPI: "<div class='kpi'>CS2: ความพึงพอใจต่อพนักงานขายและสำนักงานขาย</div>",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>20</div> ",
                	  Target: "<div class='textR'>80</div>",
                	  Actual: "<div class='textR'>80</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>100.00%</div>",
                	  Your: " <div class='textR'>20.00%<div>"
				  }
				  
				  ]; 	
	var $dataJ22 =[
                  {
                	  KPI: "1_1 การพูดจา การต้อนรับและมารยาทที่ดีของพนักงานขาย",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>25</div> ",
                	  Target: "<div class='textR'>90</div>",
                	  Actual: "<div class='textR'>80</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>88.89%</div>",
                	  Your: " <div class='textR'>22.22%<div>"
					  
                     
                  },
                  {
                	  KPI: "1_2 การให้ข้อมูลเกี่ยวกับสินค้าและโครงการของพนักงานขาย",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>25</div> ",
                	  Target: "<div class='textR'>90</div>",
                	  Actual: "<div class='textR'>80</div>",
                	  Achieve:""+ballYellow+"<div class='textR'>66.67%</div>",
                	  Your: " <div class='textR'>16.67%<div>"
					  
                     
                  },
                  {
                	  KPI: "1_3 การเอาใจใส่ กระตือรือร้น และการติดตามงานของพนักงานขาย",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>20</div> ",
                	  Target: "<div class='textR'>90</div>",
                	  Actual: "<div class='textR'>85</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>94.44%</div>",
                	  Your: " <div class='textR'>18.89%<div>"
					  
                     
                  },
                  {
                	  KPI: "1_4 ความสะอาดของสำนักงานขาย และบ้านตัวอย่าง",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>30</div> ",
                	  Target: "<div class='textR'>90</div>",
                	  Actual: "<div class='textR'>90</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>100%</div>",
                	  Your: " <div class='textR'>30.00%<div>"
					  
                     
                  }
				  
				  ]; 
	
	
	//CONTENT BY JSON END
	
	// ################ Genarate GRID ################# //
	$("#grid2").kendoGrid({
		   //ไม่กำหนดความสูง height จะเป็น auto
          //height: 500,
		  detailInit: detailInit,
          columns: $titleJ,//[{"filed":"Filed1",width:100},{"filed":"Filed2","width":200}]
          dataSource: {
          data: $dataJ21//[{"Filed1":"content1"},{"Filed2":"content2"}]
			// pageSize: 3,
			
          }
			  /*sortable: true,
                     pageable: {
                        refresh: true,
                        pageSizes: true
              },*/
		
   	});
	// ################ Genarate GRID ################# //
	//################################################# 2
	 function detailInit(e) {
	//console.log(e.data.Field1);
							$("<table bgcolor='#f5f5f5'><th></th></table>").kendoGrid({
								columns: $titleJ2,
								dataSource: {
								data: $dataJ22,
								pageSize: 8
								
							}
							}).appendTo(e.detailCell);
	};
							
							
	//################################################# 3
	// TITLE BY JSON START
	//กำหนดค่าเริ่มต้นของชื่อ column เพื่อเอาไว้อ้างอิงกับ datasource

	var $titleJ =[
              {
                  field: "KPI",
				   width: 250
              },
              {
                  field: "UOM",
				  width: 60
			 },
              {
                  field: "Weight",
				  width: 60
			 },
              {
                  field: "Target",
				  width:60
			 },
              {
                  field: "Actual",
				  width: 60
			 },
              {
                  field: "Achieve",
				  width: 60
			 },
             
              {
                  field: "Your",
				  width: 60
			 }];







	//CONTENT BY JSON START 
	//นำค่าที่ได้มาจากการ query แล้วจัดการให้อยู่ในรูปแบบ json ที่ได้จากด้านบนมาเก็บไว้ในตัวแปร $dataJ
/*
KPI
UOM
Weight
Target
Actual
Achieve
Your
	*/
	var $dataJ3 =[
                  {
                	  KPI: "<div class='kpi'>PP1 โอนกรรมสิทธิ์บ้านหลังแรกโดยเฉลี่ยทุกโครงการตาม Schedule</div>",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>10</div> ",
                	  Target: "<div class='textR'>200</div>",
                	  Actual: "<div class='textR'>190</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>95.00%</div>",
                	  Your: " <div class='textR'>9.50%<div>"
                     
                     
					  
                     
                  },
                  {
                	  KPI: "<div class='kpi'>PP2 ลูกค้า Walk-in ทุกโครงการโดยเฉลี่ย 5y หลัง/เดือน</div>",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>20</div> ",
                	  Target: "<div class='textR'>150</div>",
                	  Actual: "<div class='textR'>145</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>96.67%</div>",
                	  Your: " <div class='textR'>9.67%<div>"
				  }
				  
				  ]; 	
	// ################ Genarate GRID ################# //
	$("#grid3").kendoGrid({
		   //ไม่กำหนดความสูง height จะเป็น auto
          //height: 500,
		  //detailInit: detailInit,
          columns: $titleJ,//[{"filed":"Filed1",width:100},{"filed":"Filed2","width":200}]
          dataSource: {
          data: $dataJ3//[{"Filed1":"content1"},{"Filed2":"content2"}]
			// pageSize: 3,
			
          }
			  /*sortable: true,
                     pageable: {
                        refresh: true,
                        pageSizes: true
              },*/
		
   	});
	// ################ Genarate GRID ################# //
	//################################################# 3
	//################################################# 4
	// TITLE BY JSON START
	//กำหนดค่าเริ่มต้นของชื่อ column เพื่อเอาไว้อ้างอิงกับ datasource

	var $titleJ =[
              {
                  field: "KPI",
				   width: 250
              },
              {
                  field: "UOM",
				  width: 60
			 },
              {
                  field: "Weight",
				  width: 60
			 },
              {
                  field: "Target",
				  width:60
			 },
              {
                  field: "Actual",
				  width: 60
			 },
              {
                  field: "Achieve",
				  width: 60
			 },
             
              {
                  field: "Your",
				  width: 60
			 }];







	//CONTENT BY JSON START 
	//นำค่าที่ได้มาจากการ query แล้วจัดการให้อยู่ในรูปแบบ json ที่ได้จากด้านบนมาเก็บไว้ในตัวแปร $dataJ
/*
KPI
UOM
Weight
Target
Actual
Achieve
Your
	*/
	var $dataJ4 =[
                  {
                	  KPI: "<div class='kpi'>L1 พนักงานทุกคนมี Pruksa Culture เหมาะสมในระดับประเมินผล 90%</div>",
                	  UOM: "Percentage",
                	  Weight: " <div class='textR'>10</div> ",
                	  Target: "<div class='textR'>90</div>",
                	  Actual: "<div class='textR'>80</div>",
                	  Achieve:""+ballGreen+"<div class='textR'>88.89%</div>",
                	  Your: " <div class='textR'>8.89%<div>"
                     
                     
					  
                     
                  }
				  
				  ]; 	
	// ################ Genarate GRID ################# //
	$("#grid4").kendoGrid({
		   //ไม่กำหนดความสูง height จะเป็น auto
          //height: 500,
		  //detailInit: detailInit,
          columns: $titleJ,//[{"filed":"Filed1",width:100},{"filed":"Filed2","width":200}]
          dataSource: {
          data: $dataJ4//[{"Filed1":"content1"},{"Filed2":"content2"}]
			// pageSize: 3,
			
          }
			  /*sortable: true,
                     pageable: {
                        refresh: true,
                        pageSizes: true
              },*/
		
   	});
	// ################ Genarate GRID ################# //
	//################################################# 4
	var userLogin="";
	 
	 
	if(!userLogin){
		userLogin="00000001";
	}else{
		userLogin ="<%=remoteUser%>";
	}
	//alert(userLogin);
	//console.log(userLogin);
	/*JavaScript Require*/
	$("#ParamYear").change(function(){
		//alert($(this).val());
		var year=$(this).val();
		$.ajax({
			url:'resultUrl.jsp',
			type:'get',
			dataType:'json',
			data:{'paramYear':year,'request':'month'},
			success:function(data){
				if(data[0]!='None'){
				//alert(data[0]);
				//console.log(parseInt((data[1]))+1);
				
				//Ajax
				var monthNumber="";
				//Month(monthNumber);
				$(".listSelectMonth").remove();
				var month="";
				month+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";
				$.each(data,function(index,indexEntry){
				monthNumber=parseInt((indexEntry[1]));
				//alert(monthNumber);
				month+="<option value=\""+indexEntry[1]+"\">"+indexEntry[0]+"</option>";
				});
				month+="</select>";
				$("#tdMonth").html(month);
				
				$(".listSelectMonth").kendoDropDownList();


				//Run Project List 
				Project(year,monthNumber,userLogin);
				}
			}
		
		
		});
	
	});
	$("#ParamYear").trigger("change");

	//Function Manage Month
	
	var Month = function(monthNumber){
		
		$(".listSelectMonth").remove();
		
		var MonthData ="";
		if(monthNumber==1){
		
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";
		MonthData+="<option value=\"1\" selected>Jan</option>";
		MonthData+="<option value=\"2\">Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==2){
			
	
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" selected>Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==3){
			
			
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\" selected>Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==4){
				
				
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\" selected>Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==5){
					
					
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\" >Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\" selected>May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==6){
						
						
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\" selected>Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==7){
							
							
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\" selected>July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==8){
			
			
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\" selected>Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==9){
			
			
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\" selected>Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==10){
				
				
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\" selected>Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==11){
					
					
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\" selected>Nov</option>";
		MonthData+="<option value=\"12\">Dec</option>";
		MonthData+="</select>";
		}else if(monthNumber==12){
						
						
		MonthData+="<select class=\"listSelectMonth\" id=\"ParamMonth\">";	
		MonthData+="<option value=\"1\" >Jan</option>";
		MonthData+="<option value=\"2\" >Feb</option>";
		MonthData+="<option value=\"3\">Mar</option>";
		MonthData+="<option value=\"4\">Apr</option>";
		MonthData+="<option value=\"5\">May</option>";
		MonthData+="<option value=\"6\">Jun</option>";
		MonthData+="<option value=\"7\">July</option>";
		MonthData+="<option value=\"8\">Aug</option>";
		MonthData+="<option value=\"9\">Sep</option>";
		MonthData+="<option value=\"10\">Oct</option>";
		MonthData+="<option value=\"11\">Nov</option>";
		MonthData+="<option value=\"12\" selected>Dec</option>";
		MonthData+="</select>";
		}
		
		$("#tdMonth").html(MonthData);
		
		
	};
	
	Month(1);
	$(".listSelectMonth").kendoDropDownList();
	//Management Month
	$("#ParamMonth").live("change",function(){
	 //alert("hello change month");
	 Project($("#ParamYear").val(),$("#ParamMonth").val(),userLogin);
	});
	
	//End Month
	//Start Project
	var Project = function(year,month,userLogin){
		var sendParameterJavaScript="<%=pjCode%>";
		//alert(sendParameterJavaScript);
		//$("#tdProject").remove();
		
		//alert("YEAR="+year+"month="+month+"userLogin="+userLogin);
		$.ajax({
			url:'resultUrl.jsp',
			type:'get',
			dataType:'json',
			data:{'request':'Project','paramMonth':month,'paramYear':year,'paramUser':userLogin},
			success:function(data){
				$("#selected").remove();
				var optionArray=new Array();
				var i=0;
				/*
				$("td#tdProject select#ParamProject option").each(function(){
					optionArray[i]=$(this).val();
				i++;
				});
				*/
				/*
				var selectProject="";
				$("td#tdProject").empty();
				selectProject+="<select id=\"ParamProject\">";
				selectProject+="<option value=\""+data[0]+"\" selected>"+data[0]+"</option>";
				
				for(var i=0;i<optionArray.length;i++){
					selectProject+="<option value=\""+optionArray[i]+"\">"+optionArray[i]+"</option>";
				}
				selectProject+="</select>";
				$("td#tdProject").prepend(selectProject);
				//Define kendoDrowDownList 2 on change
				$("#ParamProject").kendoDropDownList();
				*/
				var selectProject="";
				$("td#tdProject").empty();
				selectProject+="<select id=\"ParamProject\">";
				
				$.each(data,function(index,indexEntry){
					if(sendParameterJavaScript==""){
					//alert("parameter is null"+sendParameterJavaScript);
					selectProject+="<option value=\""+indexEntry+"\">"+indexEntry+"</option>";
					}else{
						if(sendParameterJavaScript==indexEntry){
								selectProject+="<option value=\""+indexEntry+"\" selected>"+indexEntry+"</option>";
							}else{
								//selectProject+="<option value=\""+indexEntry+"\">"+indexEntry+"</option>";
							}//if2
					}//if1
				});
				
				selectProject+="</select>";
				$("td#tdProject").prepend(selectProject);
				//Define kendoDrowDownList 2 on change
				$("#ParamProject").kendoDropDownList();
				$("#submit1").trigger("click");
			}
		});
		
	
	};
	//End Project
	//Start TotalWeightPercentage
	$("#form_1").submit(function(){
		$("#contentKpi").empty();
		$("#bodyContent").show();
		//START Participants 
		$.ajax({
			url:'resultUrl.jsp',
			type:'get',
			dataType:'html',
			data:{'request':'Participants','paramYear':$("#ParamYear").val(),'paramMonth':$("#ParamMonth").val(),'paramProject':$("#ParamProject").val()},
			success:function(data){
				//alert(data);
				$("table#Participants tbody").html(data);
			}
		});
		
		//END Participants
		
		$(".parameter").remove();
		$("body").append("<input type='hidden' name='year' id='year' class='parameter' value='"+$("#ParamYear").val()+"'>");
		$("body").append("<input type='hidden' name='month' id='month' class='parameter' value='"+$("#ParamMonth").val()+"'>");
		$("body").append("<input type='hidden' name='project' id='project' class='parameter' value='"+$("#ParamProject").val()+"'>");
		
		//TotalWeightPercentage
		$.ajax({
			url:'resultUrl.jsp',
			type:'get',
			dataType:'json',
			data:{'request':'TotalWeightPercentage','paramYear':$("#ParamYear").val(),'paramMonth':$("#ParamMonth").val(),'paramProject':$("#ParamProject").val()},
			success:function(dataTotalWeight){
			//alert(data[0]+" "+data[1]);
			$("#userScore").html(dataTotalWeight[0]);
			$("#score").html(parseFloat(dataTotalWeight[1]).toFixed(2));
			//$("#score").html(data[2]); call function genarator color ball
			//alert("data"+dataTotalWeight[2]);
			$("#ballScoreTotal").html(ballColorFunction(dataTotalWeight[2]));
			$(".ball").corner();
			}
			
		});
		
		//catePerspective
		$.ajax({
		url:'resultUrl.jsp',
		type:'get',
		async:true,
		dataType:'json',
		data:{'request':'catePerspective','paramYear':$("#ParamYear").val(),'paramMonth':$("#ParamMonth").val(),'paramProject':$("#ParamProject").val()},
		success:function(data){
			//alert(data.length);
			//console.log(data);
			var contentKpi="";
			for(var i=0;i<data.length;i++){
				
				$.ajax({
					url:'resultUrl.jsp',
					type:'get',
					dataType:'json',
					async:false,
					data:{'cateKpi':data[i],'request':'KpiList','paramYear':$("#ParamYear").val(),'paramMonth':$("#ParamMonth").val(),'paramProject':$("#ParamProject").val()},
					success:function(data2){
						//alert(data2[0][9]);
						//alert(data2[0]);
						
						contentKpi+="<!--------------------------- Finance start--------------------------->";
						contentKpi+="	<div class=\"titleKPI\">";
						
						contentKpi+="<div class=\"titleKPI_L\">"+data2[0][0]+"</div>";
						contentKpi+="<div class=\"titleKPI_R\" id=\""+data2[0][0]+"\">Click to show comparison chart</div>";
						contentKpi+="<br style=\"clear:both\">";
						contentKpi+="</div>";
							contentKpi+="<div class=\"tableContent\">";
							contentKpi+="<table id=\"grid"+data2[0][0]+"\">";
							contentKpi+="<thead>";
								contentKpi+="<tr>";
										  
									contentKpi+="<th data-field=\"KPI\" ><center><b>KPI</b></center></th>";
									contentKpi+="<th  data-field=\"UOM\"><center><b>UOM</center></th>";
									contentKpi+="<th data-field=\"Weight\"><center><b>Weight</b></center></th>";
									contentKpi+="<th data-field=\"Target\"><center><b>Target</b></center></th>";
									contentKpi+="<th data-field=\"Actual\"><center><b>Actual</b></center></th>";
									contentKpi+="<th data-field=\"Achieve\"><center><b>%Achieve</b></center></th>";
									contentKpi+="<th data-field=\"Your\"><center><b>Your%</b></center></th>";
										  
								
									contentKpi+="</tr>";
								contentKpi+="</thead>";
								contentKpi+="<tbody>";
									contentKpi+="<tr>";
								        
										contentKpi+="<td></td>";
										contentKpi+="<td></td>";
										contentKpi+="<td></td>";
										contentKpi+="<td></td>";
										contentKpi+="<td></td>";
										contentKpi+="<td></td>";
										contentKpi+="<td></td>";
									
								
									contentKpi+="</tr>";	
								contentKpi+="</tbody>";
							contentKpi+="</table>";
						contentKpi+="</div>";
						contentKpi+="<!--------------------------- Finance end--------------------------->";
						
						//alert(contentKpi);
						
						$("#contentKpi").append(contentKpi);
						contentKpi="";
						
						var contentData="";
						contentData+="[";
						var j=0;
						//alert(data2[0][0]+"-"+data2[0][1]+"-"+data2[0][2]+"-"+data2[0][3]+"-"+data2[0][4]+"-"+data2[0][5]+"-"+data2[0][6]+"-"+data2[0][7]+"-"+data2[0][8]);
						$.each(data2,function(index,indexEntry){
							/*
							console.log(indexEntry[0]);
							console.log(indexEntry[1]);
							console.log(indexEntry[2]);
							console.log(indexEntry[3]);
							*/
							if(j!=0){
							contentData+=",{";
							}else{
							contentData+="{";
							}
							contentData+="YEAR:\""+$("#ParamYear").val()+"\",";
							contentData+="MONTH:\""+$("#ParamMonth").val()+"\",";
							contentData+="PROJECT:\""+$("#ParamProject").val()+"\",";
							contentData+="KPI_CODE:\""+indexEntry[1]+"\",";
							contentData+="KPI:\"<div class='textL kpi' id='"+indexEntry[1]+"'>"+indexEntry[1]+":"+indexEntry[2]+"</div>\",";
							contentData+="UOM:\"<div class='textL'>"+indexEntry[3]+"</div>\",";
							contentData+="Weight:\"<div class='textR'>"+indexEntry[4]+"</div>\",";
							contentData+="Target:\"<div class='textR'>"+indexEntry[5]+"</div>\",";
							contentData+="Actual:\"<div class='textR'>"+indexEntry[6]+"</div>\",";
							var code_color="";
							$.ajax({
									url:'resultUrl.jsp',
									type:'get',
									dataType:'json',
									async:false,
									data:{'request':'threshold_color','score':indexEntry[7]},
									success:function(data3){
										//alert(data3[0]);
										
										code_color=ballColorFunction(data3[0]);
										
									}
								});
								
							contentData+="Achieve:\"<div class='textR'>"+code_color+""+indexEntry[7]+"%</div>\",";
							contentData+="Your:\"<div class='textR'>"+indexEntry[8]+"</div>\"";
							contentData+="}";
							j++;
				
						});
						contentData+="]";
						var obj_contentData = eval("("+contentData+")");
						//console.log(obj_contentData);
						grid("grid"+data2[0][0],obj_contentData);
						$(".ball").corner();
					}
					});
				}
			}
		
		});
		$(".ball").corner();
		//management table Participants
		$("table#Participants thead tr").css({'background':'#cccccc','color':'#000000'});
		$("table#Participants tbody tr:odd").css({'background':'#DBEEF3','color':'#000000'});
		
		return false;
	});
	//Trigger click submit

		

	
	
	//End TotalWeightPercentage
	/*JavaScript Require*/
});
</script>
	
    </head>
    <body>
	<%
	/*
	out.println(pjCode);
	out.println(sendParamMonth);
	out.println(sendParamYear);
	*/
	//if(sendParamYear==null){
		//out.print("data is null");
	//}
	//Year
	/*
	String paramYear="";
	int currentYear=0;
	String query="select distinct result_year from kpi_result order by result_year desc";
	rs=mysqlConn.selectData(query);
	rs.next();
	paramYear="";
	currentYear=rs.getInt("result_year");	
	
	paramYear+="<option>"+(currentYear+1)+"</option>";
	for(int i=10;i>=1;i--){
	paramYear+="<option value="+currentYear+">"+(currentYear--)+"</option>";
	}
	conn.close();
	*/

	String query="select distinct result_year from kpi_result order by result_year desc";
	rs=mysqlConn.selectData(query);

	while(rs.next()){
		if(sendParamYear.equals(rs.getString("result_year"))){
			paramYear+="<option value="+sendParamYear+" selected>"+sendParamYear+"</option>";
		}else{
			paramYear+="<option value="+rs.getInt("result_year")+">"+rs.getInt("result_year")+"</option>";
		}
			
	}
	conn.close();

	//Month
	String paramMonth="Jan";
	
	
	//Project
/*
	String queryProjectAll="SELECT project_code from project_user";
	//String queryProjectAll="CALL ParamProject('"+remoteUser+"',"++","++")";
	String listProjectAll="";
	rs=mysqlConn.selectData(queryProjectAll);
	if(rs.next()){
		
		listProjectAll+="<select id='ParamProject'>";
		while(rs.next()){
			
			listProjectAll+="<option>";
			listProjectAll+=rs.getString("project_code");
			listProjectAll+="</option>";
			
		}
		listProjectAll+="</select>";
		
	}
*/	
	%>
	
	<div align="center">
	<!--------------------------- HEADER --------------------------->
		<div id="Main-Panel" class="k-content">
		
				<form method="GET" id="form_1">
				<table width=100% >
				<tr>
					<td class="tableTitileWidth">
				
					<label for="ParamYear" ><div class="toRight">Year :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></label>
				
					</td>
					
					<td class="tableParamWidth">
					<select name="ParamYear" id="ParamYear" class="listSelect">
						<%
							out.print(paramYear);
						%>
					</select>
					</td>
					
					<td class="tableTitileWidth">
					<label for="ParamProject"><div class="toRight"> Month:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></label>
					</td>
					<td class="tableParamWidth" id="tdMonth">
					<select name="ParamMonth" id="ParamMonth" class="listSelectMonth">
						<!--  
						<option value="01" selected="">Jan</option>
						<option value="02" selected="">Feb</option>
						<option value="03" selected="">Mar</option>
						<option value="04" selected="">Apr</option>
						<option value="05" selected="">May</option>
						<option value="06" selected="">Jun</option>
						<option value="07" selected="">Jul</option>
						<option value="08" selected="">Aug</option>
						<option value="09" selected="">Sep</option>
						<option value="10" selected="">Oct</option>
						<option value="11" selected="">Nov</option>
						<option value="12" selected="">Dec</option>
						-->
					</select>
					</td>
					<td>
					
					</td>
				</tr>
				<tr>
					<td class="tableTitileWidth">
					<label for="ParamMonthFrom"><div class="toRight">Project/Cost Center :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></label>
					</td>
					<td class="tableParamWidth" id ="tdProject">
					
					<% //listProjectAll%>
					<!-- 
					<select name="ParamProject" id="ParamProject" class="listSelectProject">
						<option>PC0390-ภัสสร</option>
						<option>PC0391-นภาพร</option>
						<option>PC0392-อาภาพร</option>
					</select>
					-->
					
					</td>
					<td class="tableTitileWidth">
					<label for="ParamMonthTo"><div class="toRight"></div></label>
					</td>
					<td class="tableParamWidth">
					<input type="submit"value="&nbsp;&nbsp;OK&nbsp;&nbsp;"  class="k-button" id="submit1" >
					</td>
					<td>
					
					</td>
				</tr>
				</table>
				</form>

		</div>
		<!--------------------------- HEADER --------------------------->
		<!--------------------------- CONTENT --------------------------->
		<div id="bodyContent">
			<div id="titleScore">
				<div id="mainTitleScore">
					Project/Cost Center: <div id="userScore"> </div> ได้คะแนนรวม: <div id="score">%</div>  &nbsp;
				</div>
				
				<div id="ballScoreTotal"></div>
				<br style="clear:both">
			</div>
			<div class="titleContent1">
			Performance
			</div>
			<div id="contentKpi"><!-- Connnent kpi start here -->
			<!--------------------------- Finance start--------------------------->
			<!--  
			<div class="titleKPI">
			
			<div class="titleKPI_L">Finance</div>
			<div class="titleKPI_R">Click to show comparison chart</div>
			<br style="clear:both">
			</div>
			<div class="tableContent">
				<table id="grid">
					  <thead>
					      <tr>
							  
					          <th data-field="KPI" ><center><b>KPI</b></center></th>
							  <th  data-field="UOM"><center><b>UOM</center></th>
							  <th data-field="Weight"><center><b>Weight</b></center></th>
							  <th data-field="Target"><center><b>Target</b></center></th>
							  <th data-field="Actual"><center><b>Actual</b></center></th>
							  <th data-field="Achieve"><center><b>%Achieve</b></center></th>
							  <th data-field="Your"><center><b>Your%</b></center></th>
							  
					
						  </tr>
					  </thead>
					  <tbody>
					      <tr>
					        
					          <td></td>
							  <td></td>
					          <td></td>
							  <td></td>
					          <td></td>
							  <td></td>
					      	  <td></td>
						
					
						</tr>	
					  </tbody>
			  </table>
			</div>
			-->
			<!--------------------------- Finance end--------------------------->
			</div><!-- Connnent kpi end here -->
			<!--------------------------- Customer start--------------------------->
			<!--  
			<div class="titleKPI">
			
			<div class="titleKPI_L">Customer</div>
			<div class="titleKPI_R">Click to show comparison chart</div>
			<br style="clear:both">
			</div>
			<div class="tableContent">
				<table id="grid2">
					  <thead>
					      <tr>
							  
					          <th data-field="KPI" ><center><b>KPI</b></center></th>
							  <th  data-field="UOM"><center><b>UOM</center></th>
							  <th data-field="Weight"><center><b>Weight</b></center></th>
							  <th data-field="Target"><center><b>Target</b></center></th>
							  <th data-field="Actual"><center><b>Actual</b></center></th>
							  <th data-field="Achieve"><center><b>%Achieve</b></center></th>
							  <th data-field="Your"><center><b>Your%</b></center></th>
							  
					
						  </tr>
					  </thead>
					  <tbody>
					      <tr>
					        
					          <td></td>
							  <td></td>
					          <td></td>
							  <td></td>
					          <td></td>
							  <td></td>
					      	  <td></td>
						
					
						</tr>	
					  </tbody>
			  </table>
			</div>
			*/
			<!--------------------------- Customer end--------------------------->
			<!--------------------------- Process start--------------------------->
			<!--  
			<div class="titleKPI">
			
			<div class="titleKPI_L">Process</div>
			<div class="titleKPI_R">Click to show comparison chart</div>
			<br style="clear:both">
			</div>
			<div class="tableContent">
				<table id="grid3">
					  <thead>
					      <tr>
							  
					          <th data-field="KPI" ><center><b>KPI</b></center></th>
							  <th  data-field="UOM"><center><b>UOM</center></th>
							  <th data-field="Weight"><center><b>Weight</b></center></th>
							  <th data-field="Target"><center><b>Target</b></center></th>
							  <th data-field="Actual"><center><b>Actual</b></center></th>
							  <th data-field="Achieve"><center><b>%Achieve</b></center></th>
							  <th data-field="Your"><center><b>Your%</b></center></th>
							  
					
						  </tr>
					  </thead>
					  <tbody>
					      <tr>
					        
					          <td></td>
							  <td></td>
					          <td></td>
							  <td></td>
					          <td></td>
							  <td></td>
					      	  <td></td>
						
					
						</tr>	
					  </tbody>
			  </table>
			</div>
			-->
			<!--------------------------- Process end--------------------------->
			<!--------------------------- Learning & Growth start--------------------------->
			<!--  
			<div class="titleKPI">
			<div class="titleKPI_L">Learning & Growth</div>
			<div class="titleKPI_R">Click to show comparison chart</div>
			<br style="clear:both">
			</div>
			<div class="tableContent">
				<table id="grid4">
					  <thead>
					      <tr>
							  
					          <th data-field="KPI" ><center><b>KPI</b></center></th>
							  <th  data-field="UOM"><center><b>UOM</center></th>
							  <th data-field="Weight"><center><b>Weight</b></center></th>
							  <th data-field="Target"><center><b>Target</b></center></th>
							  <th data-field="Actual"><center><b>Actual</b></center></th>
							  <th data-field="Achieve"><center><b>%Achieve</b></center></th>
							  <th data-field="Your"><center><b>Your%</b></center></th>
							  
					
						  </tr>
					  </thead>
					  <tbody>
					      <tr>
					        
					          <td></td>
							  <td></td>
					          <td></td>
							  <td></td>
					          <td></td>
							  <td></td>
					      	  <td></td>
						
					
						</tr>	
					  </tbody>
			  </table>
			</div>
			-->
			<!--------------------------- Learning & Growth end--------------------------->
			<div class="titleContent1">
			Participants
			</div>
			<div class="tableContent">
			<table width="50%" border="0" id="Participants" cellspacing="1" cellspacing="1">
				<thead>
				<tr>
					<th>Name</th>
					<th>Position</th>
				</tr>
				</thead>
				<tbody>
				<!--  
					<tr>
						<td>
						สมชาย ใจเพชร
						</td>
						<td>
						Project Manager
						</td>
					</tr>
					<tr>
						<td>
						สมศรี บัวขาว	
						</td>
						<td>
						Project Manager
						</td>
					</tr>
					<tr>
						<td>
						สมใจ บุญสม	
						</td>
						<td>
						Sales Representative
						</td>
					</tr>
					<tr>
						<td>
						สมพล คนดี
						</td>
						<td>
						Foreman	
						</td>
					</tr>
					-->
				</tbody>
			</table>
			</div>
		</div>
		<!--------------------------- CONTENT --------------------------->
	</div>
	
	<div id="dialogbox1" style="padding-top:20px;">
		<div id="chart1" style="width:600px; height:275px; margin-top:20px;"></div>
		
	</div>
	<div id="dialogbox2" style="padding-top:20px;">
		
		<div id="chart2" style="width:600px; height:275px; margin-top:20px;"></div>
	</div>

	</body>
</html>
