<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.Constants"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@include file="header.jsp"%>
<span style="color:green;font-weight:bold;"><%=I18N.getLbl(request,"usr.title","用户管理") %></span><br><br>
<%
boolean hasAdminRight = (Boolean)request.getAttribute("hasAdminRight");
%>

<%
org.svnadmin.entity.Usr entity = (org.svnadmin.entity.Usr)request.getAttribute("entity");
if(entity==null)entity=new org.svnadmin.entity.Usr();
%>
<script>
function checkForm(f){
	if(f.elements["usr"].value==""){
		alert("<%=I18N.getLbl(request,"usr.error.usr","用户不可以为空") %>");
		f.elements["usr"].focus();
		return false;
	}
	if(f.elements["psw"].value==""  && f.elements["newPsw"]!=null && f.elements["newPsw"].value==""){
		alert("<%=I18N.getLbl(request,"usr.error.psw","密码不可以为空") %>");
		f.elements["psw"].focus();
		return false;
	}
	return true;
}
</script>
<form name="usr" action="<%=ctx%>/usr" method="post" onsubmit="return checkForm(this);">
	<input type="hidden" name="act" value="save">
	<table class="thinborder">
		<tr>
			<td class="lbl"><%=I18N.getLbl(request,"usr.usr","用户") %></td>
			<td>
				<%if(hasAdminRight){ %>
					<input type="text" name="usr" value="<%=entity.getUsr()==null?"":entity.getUsr()%>" 
					onkeyup="value=value.replace(/[^._\-A-Za-z0-9*]/g,'')">
					<span style="color:red;">*</span>
				<%}else{ %>
				   	<input type="hidden" name="usr" value="<%=entity.getUsr()==null?"":entity.getUsr()%>" >
				   	<%=entity.getUsr()==null?"":entity.getUsr()%>
				<%} %>				
			</td>
			
			<td class="lbl"><%=I18N.getLbl(request,"usr.psw","密码") %></td>
			<td>
			<input type="password" name="newPsw" value="">
			<input type="hidden" name="psw" value="<%=entity.getPsw()==null?"":entity.getPsw()%>">
			</td>
			
			<%if(hasAdminRight){ %>
			<td class="lbl"><%=I18N.getLbl(request,"usr.role","角色") %></td>
			<td>
				<select name="role">
					<option value=""><%=I18N.getLbl(request,"usr.role.select","选择角色") %></option>
					<option value="<%=Constants.USR_ROLE_ADMIN%>" <%=Constants.USR_ROLE_ADMIN.equals(entity.getRole())?"selected='selected'":""%>>admin</option>
				</select>
			</td>
			<%} %>
			<td>
				<input type="submit" value="<%=I18N.getLbl(request,"usr.op.submit","提交") %>">
			</td>
		</tr>
	</table>
</form>

<%if(hasAdminRight){ %>

<table class="sortable thinborder">

	<thead>
		<td><%=I18N.getLbl(request,"sys.lbl.no","NO.") %></td>
		<td><%=I18N.getLbl(request,"usr.usr","用户") %></td>
		<td><%=I18N.getLbl(request,"usr.psw","密码") %></td>
		<td><%=I18N.getLbl(request,"usr.role","角色") %></td>
		<td><%=I18N.getLbl(request,"usr.op.delete","删除") %></td>
	</thead>
	<%
	java.util.List<org.svnadmin.entity.Usr> list = (java.util.List<org.svnadmin.entity.Usr>)request.getAttribute("list");

	if(list!=null){
		int no = 1;	  
		for(int i = 0;i<list.size();i++){
		  org.svnadmin.entity.Usr usr = list.get(i);
		  if("*".equals(usr.getUsr())){
			  continue;
		  }
		%>
		<tr>
		<td><%=(no++) %></td>
		<td>
			<a href="<%=ctx%>/usr?act=get&usr=<%=usr.getUsr()%>"><%=usr.getUsr() %></a>
		</td>
		<td><%=usr.getPsw() %></td>
		<td><%=usr.getRole()==null?"":usr.getRole() %></td>
		<td><a href="javascript:if(confirm('<%=I18N.getLbl(request,"usr.op.delete.confirm","确认删除?") %>')){del('<%=ctx%>/usr?usr=<%=usr.getUsr()%>')}"><%=I18N.getLbl(request,"usr.op.delete","删除") %></a></td>
	</tr>
		<%	
	}}
	%>
</table>
<%} %>