<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="${root }/javascript/jquery-3.5.1.js"></script>
		<script>
		function updateCostInput(val) {
          document.getElementById('costInput').value=val; 
        }
		function updateAreaInput(val) {
          document.getElementById('areaInput').value=val; 
        }
		</script>
<title>Insert title here</title>
</head>
<body>
	<div class="container" id="sales_list">
		<h3>매물게시판</h3>
		<form>
			<div class="btn-group btn-group-toggle mb-3" data-toggle="buttons">
					<label class="btn btn-outline-warning">
						<input type="checkbox" name="room_type" value="APT" id="APT">아파트
					</label>
					<label class="btn btn-outline-warning">
						<input type="checkbox" name="room_type" value="ONE" id="ONE">원룸
					</label>
					<label class="btn btn-outline-warning">
						<input type="checkbox" name="room_type" value="TWO" id="TWO">투룸
					</label>
					<label class="btn btn-outline-warning">
						<input type="checkbox" name="room_type" value="THREE" id="THREE">쓰리룸
					</label>
					<label class="btn btn-outline-warning">
						<input type="checkbox" name="room_type" value="OFFICE" id="OFFICE">오피스텔
					</label>
				</div>
			<input type="hidden" value="위에 li값 가져오기" name="sales_type">

			<div class="input-group mb-3">
				<select class="custom-select col-md-1">
					<option value="">옵션</option>
					<option value="sales">매매</option>
					<option value="rent_year">전세</option>
					<option value="rent_month">월세</option>
				</select>
			  <input type="text" class="form-control col-md-4" placeholder="지역명을 입력하세요." aria-label="지역명을 입력하세요." aria-describedby="button-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-outline-warning" type="submit" id="button-addon2"><strong>검색</strong></button>
			  </div>
			</div>

			<!-- range -->

			<input type="range" min="0" max="20" step="0.1" onchange="updateCostInput(this.value);"> <label>가격</label>
			<input type="text" style="text-align:center;"size="1" id="costInput" value=""><span>억</span>
			<input type="range"  onchange="updateAreaInput(this.value);"> <label>면적</label>
			<input type="text" style="text-align:center;"size="1" id="areaInput" value=""><span>평</span>
			<br>
			
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="checkbox" id="foolOption" value="풀옵션">
			  <label class="form-check-label" for="inlineCheckbox1">풀옵션</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="checkbox" id="parking" value="주차장">
			  <label class="form-check-label" for="inlineCheckbox2">주차장</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="checkbox" id="cctv" value="CCTV">
			  <label class="form-check-label" for="inlineCheckbox3">CCTV</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="checkbox" id="elevator" value="엘레베이터">
			  <label class="form-check-label" for="inlineCheckbox3">엘레베이터</label>
			</div>
			
		</form>
		<nav aria-label="정렬">
		  <div class="pagination justify-content-end">
		    <select>
			<option value="">정렬	</option>
			<option value="">가격내림차순</option>
			<option value="">가격오름차순</option>
			<option value="">지수오름순</option>
			<option value="">지수내림순</option>
		</select>
		  </div>
		</nav>
		
		<!-- 게시판 목록 -->
		<div class="table active">
			<div class="row border-bottom" id="table_th">
				<div class="col-md-8"><strong>제목</strong></div>
				<div class="col-md-1"><strong>구분</strong></div>
				<div class="col-md-2"><strong>면적</strong></div>
				<div class="col-md-1"><strong>가격</strong></div>
			</div>
		<c:forEach var="salesList" items="${salesList }">	
			<a href="${root}/sales/detail">
			<div class="row border-bottom" id="table_td">
				<div class="col-md-8"><strong>${salesList.sales_title }</strong><p>${salesList.sales_address }</p></div>
				<div class="col-md-1">${salesList.sales_category_type }</div>
				<div class="col-md-2"><fmt:formatNumber value="${salesList.sales_area/(3.3) }" type="number" pattern="0"/>평/${salesList.sales_area }m<sup>2</sup>/${salesList.sales_floor }층</div>
				<div class="col-md-1">${salesList.sales_deposit }<span>${salesList.sales_cost }</span></div>
			<!-- 	<div class="col-md-2"></div> -->
			</div>
			</a>
		</c:forEach>
		</div>
		
		<!-- 페이징 -->
		<div class="d-flex bd-highlight">
			 <div class="p-2 w-100 bd-highlight">
				<nav aria-label="Page navigation">
				  <ul class="pagination justify-content-center">
				    <li class="page-item disabled">
				      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
				    </li>
				    <li class="page-item"><a class="page-link" href="#">1</a></li>
				    <li class="page-item"><a class="page-link" href="#">2</a></li>
				    <li class="page-item"><a class="page-link" href="#">3</a></li>
				    <li class="page-item">
				      <a class="page-link" href="#">Next</a>
				    </li>
				  </ul>
				  
				</nav>
			 </div>
			 
			 <!-- 매매업자에게만 보이는 글쓰기 버튼 -->
			 <div class="p-2 flex-shrink-1 bd-highlight">
			  	<input type="button" value="매물올리기" class="btn btn-warning btn-sales">
			 </div>
		</div>
		<script>
			$(function(){
				$(".btn-sales").click(function(){
					location.href='${root}/sales/write';
				});
			});
		</script>
		
		<br>
		<br>
	</div>
<!-- 	<script type="text/javascript">
	$(function () {
		  $('[data-toggle="tooltip"]').tooltip()
		})
	$('#example').tooltip(options)
	</script> -->
</body>
</html>