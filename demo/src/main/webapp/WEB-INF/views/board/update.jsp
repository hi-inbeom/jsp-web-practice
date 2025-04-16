<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성</title>

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

.form-group {
	margin-bottom: 1.25rem;
}

label {
	font-weight: 600;
	color: #666;
	margin-bottom: 0.5rem;
	display: block;
}

input[type="text"], textarea {
	width: 100%;
	padding: 0.75rem;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 1rem;
}

textarea {
	resize: vertical;
	min-height: 300px;
}

.top-buttons {
	display: flex;
	margin-bottom: 1rem;
	justify-content: flex-end;
	gap: 5px;
}

.right-buttons {
	display: flex;
	right: 0px;
}

.right-buttons button {
	padding: 0.6rem 1.2rem;
	background: #007bff;
	color: #fff;
	border: none;
	border-radius: 6px;
	font-size: 0.95rem;
	transition: background 0.2s;
	cursor: pointer;
	text-align: center;
}

.right-buttons button:hover {
	background: #0056b3;
}
</style>

<script>
	async function updateBoard(event) {
		event.preventDefault();
		
		const formData = {
				boardTitle: document.getElementById("boardTitle").value,
				boardContent: document.getElementById("boardContent").value,
				boardNo: ${board.boardNo}
		};

		if (formData.boardTitle===null) {
			alert("제목 입력");
			return;
		}
		if (formData.boardContent===null) {
		    alert("내용 입력");
			return;
		}
		
		const fetchData = JSON.stringify(formData);
		
		$.ajax({
			url: "/update.bo",
			method: "PATCH",
			data: fetchData,
			contentType: "application/json; charset=utf-8",
			success: function(response) {
				if (response.success === true) {
					alert("수정 성공");
					window.location.href = "/board/"+${board.boardNo};
				} else {
					alert( response.message || "수정 실패");
				}
			},
	        error: function(xhr, status, error) {
	            alert(error);
	        }
		});
	}
</script>

</head>
<body>
	<div class="detail-container">
		<h2>게시글 수정</h2>

		<form onsubmit="updateBoard(event)">
			<div class="form-group">
				<label for="boardTitle">제목</label>
				<input type="text" id="boardTitle" value="${ board.boardTitle }" name="boardTitle" required>
			</div>

			<div class="form-group">
				<label for="boardContent">내용</label>
				<textarea id="boardContent" name="boardContent" required>${ board.boardContent }</textarea>
			</div>

			<div class="top-buttons">
				<div class="right-buttons">
					<button type="submit">수정</button>
				</div>
				<div class="right-buttons">
					<button type="button">취소</button>
				</div>
			</div>
		</form>
		
		<jsp:include page="componentList.jsp"></jsp:include>
	</div>
</body>
</html>
