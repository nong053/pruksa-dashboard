<%@ 
	page language="java" 
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
<%
String remoteUser = request.getRemoteUser();
out.print("remoteUser="+remoteUser+"<br>");


%>