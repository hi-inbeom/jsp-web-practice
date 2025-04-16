<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    
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
      background: #007bff;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  cursor: pointer;
	  transition: background-color 0.2s ease;
	  color: white;
	  font-weight: bold;
	  font-size: 18px;
	}
	.back-button:hover {
        background: #0056b3;
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
        function submitForm(event) {
            event.preventDefault();

            // 폼 데이터 추출
            const userId = document.getElementById('userId').value;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            // 비밀번호 일치 여부 확인
            if (password !== confirmPassword) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }

            // JSON 데이터로 변환
            const jsonData = JSON.stringify({ userId, email, password });

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
    	<div class="back-button" onclick="history.back()">←</div>
        <h2>회원가입</h2>
    </div>
        <form onsubmit="submitForm(event)">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit">회원가입</button>
        </form>
    </div>
</body>
</html>