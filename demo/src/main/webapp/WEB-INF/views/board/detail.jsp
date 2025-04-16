<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 상세보기</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>


<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background: linear-gradient(135deg, #ece9e6, #ffffff);
	padding: 1rem;
}

.detail-container {
	background: #ffffff;
	padding: 2.5rem;
	border-radius: 16px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
	width: 100%;
	max-width: 900px;
}

h2 {
	margin-bottom: 1.5rem;
	color: #333;
	text-align: center;
	font-size: 1.8rem;
	font-weight: 700;
}

.detail-group {
	margin-bottom: 1.25rem;
}

.detail-group label {
	font-weight: 600;
	color: #666;
	margin-bottom: 0.5rem;
	display: block;
}

.detail-group .value {
	padding: 0;
	background: none;
	border: none;
	color: #333;
	line-height: 1.6;
	font-size: 1rem;
}

.detail-meta {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: -1rem;
	margin-bottom: 1.25rem;
	font-size: 0.95rem;
	color: #666;
	font-weight: 500;
	gap: 1rem;
	flex-wrap: wrap;
}

.top-buttons {
	display: flex;
	justify-content: space-between;
	margin-bottom: 1rem;
	align-items: center;
}

.left-buttons, .right-buttons {
	display: flex;
	gap: 0.5rem;
}

.left-buttons div, .right-buttons div {
	padding: 0.6rem 1.2rem;
	background: #007bff;
	color: #fff;
	border-radius: 6px;
	font-size: 0.95rem;
	transition: background 0.2s;
	cursor: pointer;
	text-align: center;
}

.left-buttons div:hover, .right-buttons div:hover {
	background: #0056b3;
}

#board-content {
	min-height: 700px;
}
</style>


<script>
	function showAlert(boardNo) {
		detailAlert({
			title:"게시물 삭제",
			message:"정말로 삭제하시겠습니까?",
			btnClass:"btn-danger",
			btnText:"삭제",
			onConfirm: () => { deleteBoard(boardNo); }
		});
		
		var alertModal = new bootstrap.Modal(document.getElementById('alert-modal'));
		alertModal.show();	
	}
	
	async function deleteBoard(boardNo) {
	    $.ajax({
	        url: '/delete.bo/' + boardNo,
	        method: 'DELETE',
	        success: function(response) {
	            if (response === "success") {
	                alert('삭제 완료');
	                const query = sessionStorage.getItem("boardListQuery") || "";
	                window.location.href = "/board" + query;
	            } else {
	                alert('삭제 실패');
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('삭제 실패:', error);
	            alert('서버 오류로 삭제 실패');
	        }
	    });
	}
</script>
</head>
<body>
	<div class="detail-container">
		<div class="top-buttons">
			<div class="left-buttons">
				<div onclick="location.href='/board'">목록으로</div>
			</div>
			<c:if test="${loginUser.userId == board.boardWriter}">
				<div class="right-buttons">
					<div onclick="location.href='/board/update/${board.boardNo}'">수정</div>
					<div onclick="showAlert(${board.boardNo})">삭제</div>
				</div>
			</c:if>
		</div>


		<div class="detail-group">
			<div class="value" style="font-size: 1.4rem; font-weight: bold;">${board.boardTitle}</div>
		</div>

		<div class="detail-meta">
			<div>작성자 : ${board.boardWriter}</div>
			<div>조회수 : ${board.boardViews}</div>
			<div>작성일 : ${board.boardDate}</div>
		</div>

		<div class="detail-group">
			<div class="value" id="board-content" style="white-space: pre-line;">${board.boardContent}</div>
		</div>
		<jsp:include page="componentList.jsp"></jsp:include>
	</div>

	<jsp:include page="alertModal.jsp"></jsp:include>
</body>
</html>
