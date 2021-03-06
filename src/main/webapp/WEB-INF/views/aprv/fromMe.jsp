<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<script>
var childWin;

$(function(){
		
 	$("#testTable").DataTable().page(page-1).order( [ 4, 'desc' ] ).draw();
 	
	$("#excel").click(function(){
		
		location.href="${path}/excel";
	});
	
});

function detail(one)
{
	var seq = $(one).parent().prev().text();
	var kind = seq[0];
	
	if(kind == 'M')
	{
		childWin = window.open("${path}/aprv/moveAprvDetail?mseq="+seq, "aprvDetail",
				"width=1200, height=800, top=100, left=400, resizable=no, location=no");
	}
	else
	{
		childWin = window.open("${path}/aprv/orderAprvDetail?oseq="+seq, "aprvDetail",
		"width=1200, height=800, top=100, left=400, resizable=no, location=no");
	}
}

window.onunload=function(){
	childWin.close();
};
</script>
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
	<%@include file="/resources/jspf/topnav.jspf"%>
    <%@include file="/resources/jspf/sidenavGyulJae.jspf"%>
       
    <div id="page-wrapper">

    	<div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary" style="margin-top: 30px">
                    <div class="panel-heading">
                    	내가 올린 결재
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="testTable">
                            <thead>
                                <tr>
                                    <th>종류</th>
                                    <th>결재 번호</th>
                                    <th>제목</th>
                                    <th>비고</th>
                                    <th>등록일</th>
                                    <th>만료일</th>
                                    <th>진행 현황</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${afmlist}" var="a">
                            		<tr>
	                                    <td>${a.kind}</td>
	                                    <td>${a.seq}</td>
	                                    <td><a onclick="detail(this)" style="cursor: pointer;">${a.title}</a></td>
	                                    <td>${a.note}</td>
	                                    <td>
	                                    	<fmt:parseDate var="regdate" value="${a.regdate}" pattern="yyyy-MM-dd HH:mm:ss" />
	                                    	<fmt:formatDate value="${regdate}" type="date" pattern="yyyy-MM-dd HH:mm" />
	                                    </td>
	                                    <td>
	                                    	<fmt:parseDate var="expdate" value="${a.expdate}" pattern="yyyy-MM-dd HH:mm:ss" />
	                                    	<fmt:formatDate value="${expdate}" type="date" pattern="yyyy-MM-dd" />
	                                    </td>
	                                    <td><strong class="primary-font">${a.state}</strong></td>
	                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                     <div class="col-md-4">
               	    	<button id="excel" type="button" class="btn btn-default">엑셀 다운</button>
                     </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
		</div>
    </div>       
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>