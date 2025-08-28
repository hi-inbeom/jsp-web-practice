<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: 'Arial', sans-serif;
}
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f4f4f4;
}
.container {
    background: #fff;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
    text-align: center;
}
.title-wrapper {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 60px;
  padding: 10px;
}

.back-button {
  position: absolute;
  left: -10px;
  top: -10px;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  color: black;
  font-weight: bold;
  font-size: 28px;
}
h2 {
  margin: 0;
  text-align: center;
}
.form-group {
    margin-bottom: 1rem;
    text-align: left;
}
label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}
input[type="text"],
input[type="email"],
input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

form i {
    margin-left: -30px;
    cursor: pointer;
}

button {
    width: 100%;
    padding: 10px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    margin-top: 1rem;
}
button:hover {
    background: #0056b3;
}
</style>

<script>
	// 비밀번호 토글 기능
	$(document).ready(function() {
	    $('#togglePassword').on('click', function() {
	        const $password = $('#userPassword');
	        const type = $password.attr('type') === 'password' ? 'text' : 'password';
	        $password.attr('type', type);
	
	        // 아이콘 토글
	        $(this).toggleClass('bi-eye');
	    });
	});
	
	// 회원가입완료
    function submitForm(event) {
        event.preventDefault();

        // 폼 데이터 추출
        const userId = document.getElementById('userId').value;
        const userEmail = document.getElementById('userEmail').value;
        const userNick = document.getElementById('userNick').value;
        const userPassword = document.getElementById('userPassword').value;

        // JSON 데이터로 변환
        const jsonData = JSON.stringify({ userId, userEmail, userNick, userPassword });

        fetch('/signup.au', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: jsonData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                window.location.href = '/';
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            alert('회원가입 중 오류가 발생했습니다.');
        });
    }
</script>
</head>
<body>
    <div class="container">
    <div class="title-wrapper">
    	<div class="back-button" onclick="history.back()">
    		<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#000000"><path d="m313-440 224 224-57 56-320-320 320-320 57 56-224 224h487v80H313Z"/></svg>
    	</div>
        <h2>회원가입</h2>
    </div>
        <form onsubmit="submitForm(event)">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="userEmail" name="userEmail" required>
            </div>
            <div class="form-group">
                <label for="nick">닉네임</label>
                <input type="text" id="userNick" name="userNick" required>
            </div>
            
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="userPassword" id="userPassword" required/>
				<i class="bi bi-eye-slash" id="togglePassword"></i>
			</div>
			
            <button type="submit">회원가입</button>
        </form>
    </div>
</body>
</html>