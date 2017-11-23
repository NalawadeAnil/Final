<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Blog</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://bootswatch.com/united/bootstrap.css">
<link href="files/bootstrap.css" rel="stylesheet">
<link href="files/bootstrap.min.css" rel="stylesheet">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js">
        </script>
        
   <!--      <script>
    $(document).ready(function() {
        function disableBack() { window.history.forward() }

        window.onload = disableBack();
        window.onpageshow = function(evt) { if (evt.persisted) disableBack() }
    });
</script> -->
</head>
<body>
<jsp:include page="header1.jsp"></jsp:include>
<%
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/blogger";
Connection con=DriverManager.getConnection(url,"root","Nilnik@143");

String name=(String)session.getAttribute("uname");
if(name == null)
{
	 String redirectURL = "login.jsp";
	 response.sendRedirect(redirectURL);	
}

Statement stmt=con.createStatement();
String query="select b.blogid,r.first_name,r.last_name,b.BlogContent,b.BlogTitle,b.createdDate from registration r inner join blogs b on r.login_name=b.login_name where r.login_name='"+name+"'"; 
ResultSet rs=stmt.executeQuery(query);

while(rs.next())
{
%>
<div class="container">
<div class="profile_border">
  <div class="profile">
   <div class="protext">
   <div class="name">
   <form action="showBlog.jsp" method="get">
<h3>Title:<%=rs.getString(5) %> </h3><br />
<p>Publish Date:<%=rs.getString(6) %></p><br />
<p>Author:<%=rs.getString(2) %>  <%=rs.getString(3) %></p>
<%int blogId=rs.getInt(1); %>

<input hidden name="blogid" value="<%=blogId%>" />

<input type="submit" value="Continue Reading" class="btn btn-primary">
<hr />
    
 </form>
</div>
</div>
</div>
</div>
</div>
<% } %>
<hr />
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
