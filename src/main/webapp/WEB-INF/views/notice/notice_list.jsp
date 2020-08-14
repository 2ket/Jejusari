<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<%-- <link rel="stylesheet" href="${root}/css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="${root}/css/admin/notice_list.css"> --%>
<script>
	$(function(){
		$(".write-btn").click(function(){
			location.href='${root}/notice/write';
		});
	});
</script>

<style type="text/css">
	body{
      overflow-x:hidden;
   }
</style>
</head>
<body>
<form>
	<div class = "container" id="admin_container">
		<h3 class="text-secondary">[공지사항]</h3>
		<span class="badge badge-secondary">관리자</span>
		<br/>
		
		<div class="table active">
			<div class="row border-bottom" id="table_th">
				<div class="col-md-1"><strong>글번호</strong></div>
				<div class="col-md-8"><strong>제목</strong></div>
				<div class="col-md-1"><strong>조회수</strong></div>
				<div class="col-md-2"><strong>날짜</strong></div>
			</div>
		<c:forEach var = "noticeList" items = "${noticeList}">	
			<a href="${root}/notice/detail?notice_number=${noticeList.notice_number}">
			<div class="row border-bottom" id="table_td">
				<div class="col-md-1">${noticeList.notice_number}</div>
				<div class="col-md-8"><p><strong>${noticeList.notice_title}</strong></p></div>
				<div class="col-md-1">${noticeList.notice_count}</div>
				<div class="col-md-2">${noticeList.notice_date}</div>
			<!-- 	<div class="col-md-2"></div> -->
			</div>
			</a>
		</c:forEach>
		</div>
		
		<!-- 페이징 -->
		<fmt:parseNumber var = "pageCount" value = "${count / boardSize + (count % boardSize == 0 ? 0 : 1)}" integerOnly = "true"/>
		<c:set var = "pageBlock" value = "${5}"/>
		<fmt:parseNumber var = "result" value = "${(currentPage - 1) / pageBlock}" integerOnly = "true"/>
		<c:set var = "startPage" value = "${result * pageBlock + 1}"/>
		<c:set var = "endPage" value ="${startPage + pageBlock - 1}"/>
		<c:if test="${endPage > pageCount }">
			<c:set var = "endPage" value = "${pageCount}"/>
		</c:if>

		<c:if test="${startPage > pageBlock }">
			<script type="text/javascript">
				$(function(){
					$('#previous').removeClass('disabled');
				})
			</script>
		</c:if>
		<c:if test="${endPage < pageCount }">
			<script type="text/javascript">
				$(function(){
					$('#next').removeClass('disabled');
				})
			</script>
		</c:if>
		<div class="d-flex bd-highlight">
			 <div class="p-2 w-100 bd-highlight">
				<nav aria-label="Page navigation">
				  <ul class="pagination justify-content-center">
				    <li id = "previous" class="page-item disabled">
				      <a class="page-link" href="${root}/notice?pageNumber=${startPage - pageBlock}" tabindex="-1" aria-disabled="true">이전</a>
				    </li>
				    <c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
				    <li class = "page-item"><a class="page-link" href="${root}/notice?pageNumber=${i}">${i}</a></li>
				  	</c:forEach>
				    <li id = "next" class = "page-item disabled">
				      <a class = "page-link" href = "${root}/notice?pageNumber=${startPage + pageBlock}">다음</a>
				    </li>
				  </ul>
				  
				</nav>
			 </div>
			 
			 <!-- 관리자에게만 보이는 글쓰기 버튼 -->
			 <div class = "p-2 flex-shrink-1 bd-highlight">
			  	<input type = "button" value = "글작성" class = "btn btn-secondary write-btn">
			 </div>
		</div>
	</div>
</form>
</body>
</html>