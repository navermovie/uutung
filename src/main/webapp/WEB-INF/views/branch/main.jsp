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
	
	var page = "${page}";
	
	if(page=="") {
		page = 1;
	} else {
		page = parseInt(page);
	}
		
 	$("#testTable").DataTable().page(page-1).draw('page');
 	
	$("#reg").click(function(){
		
		childWin = window.open("${path}/branch/new", "addBranch",
				"width=600, height=600, top=200, left=600, resizable=no, location=no");
	});
	
	$("#excel").click(function(){
		
		location.href="${path}/branch/excel";
	});
	
	$("#del").click(function(){
		
		var checkedList=[];
		var page = $(".paginate_button.active a").text();
		
		$("input[type='checkbox']:checked").each(function() {
			
			var bseq = $(this).parent().siblings(".bseq").text(); 

			checkedList.push(bseq);
		});
		
		if(checkedList.length==0) {
			alert("선택된 항목이 없습니다!");
			return;
		}
			
		$.ajax({
			type:"POST",
			url:"${path}/branch/delete",
			data: JSON.stringify(checkedList),
			contentType : 'application/json; charset=utf-8', 
			success: function(result){
				
				if(result==true)
				{
					alert("삭제되었습니다.");
					location.href="${path}/branch?page="+page;
				}	
			} 
		});
	});
});

window.onunload=function(){
	childWin.close();
};

function edit(one)
{
	var page = $(".paginate_button.active a").text();
	
	var bseq = $(one).parent().prev().text();
	
	window.open("${path}/branch/edit?page="+page+"&bseq="+bseq, "addBranch",
			"width=600, height=600, top=200, left=600, resizable=no, location=no");
}
</script>
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
	<%@include file="/resources/jspf/topnav.jspf"%>
    <%@include file="/resources/jspf/sidenavJaego.jspf"%>
       
    <div id="page-wrapper">

    	<div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary" style="margin-top: 30px">
                    <div class="panel-heading">
                    	매장 관리
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="testTable">
                            <thead>
                                <tr>
                                	<th>선택</th>
                                    <th>매장 코드</th>
                                    <th>매장 이름</th>
                                    <th>매장 관리자</th>
                                    <th>매장 연락처</th>
                                    <th>매장 위치</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${blist}" var="b">
                            		<tr>
                            			<td><input type="checkbox"></td>
	                                    <td class="bseq">${b.bseq}</td>
	                                    <td><a class="edit" onclick="edit(this)" style="cursor: pointer;">${b.name}</a></td>
	                                    <td>${b.managerName} (${b.manager})</td>
	                                    <td>${b.phone}</td>
	                                    <td>${b.location}</td>
	                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                     <div class="col-md-4">
                   		<button id="reg" type="button" class="btn btn-primary" style="margin-right:10px;">등록</button>
               	    	<button id="del" type="button" class="btn btn-default" style="margin-right:10px;">선택 삭제</button>
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