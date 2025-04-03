<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>계정 찾기</title>
    
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
    
    h2, h3 {
        margin-bottom: 1.5rem;
        color: #333;
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
        function findAccount(event) {
            event.preventDefault();
            
            const formData = {
            		email: document.getElementById('email').value
            };
            
            const jsonData = JSON.stringify(formData);
            
            fetch('/findAccount.au', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: jsonData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                	document.getElementById('account-info').style.display = 'block';
                    document.getElementById('user-id').innerText = data.userId;
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                alert('아이디 찾는 과정에서 오류.');
            });
            
        };
    	
    	function updateAccount(event) {
            event.preventDefault();

            const userId = document.getElementById('userId').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }

            const jsonData = JSON.stringify({ userId, password });
            
            fetch('/updateAccount.au', {
                method: 'PATCH',
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
                alert('아이디 찾는 과정에서 오류.');
            });
    	}
    </script>
</head>
<body>
    <div class="container">
    <div class="title-wrapper">
    	<div class="back-button" onclick="history.back()">←</div>
        <h2>계정 찾기</h2>
    </div>
        <form onsubmit="findAccount(event)">
            <div class="form-group">
                <label for="email">이메일 주소</label>
                <input type="email" id="email" name="email" required>
            </div>
            <button type="submit">계정 찾기</button>
        </form>
        
        <div id="account-info" style="display: none;">
            <h3>계정 정보</h3>
            <div id="user-id"></div>
            <div class="form-group">
                <label for="password">새 비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="button" onclick="updateAccount(event)">비밀번호 변경</button>
        </div>
    </div>
</body>
</html>