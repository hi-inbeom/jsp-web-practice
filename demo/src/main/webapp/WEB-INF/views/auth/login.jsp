<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    
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
        .login-container {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        h2 {
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
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.9rem;
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
        .links {
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        .links a {
            text-decoration: none;
            color: #007bff;
        }
        .links a:hover {
            text-decoration: underline;
        }
    </style>
    
    <script>
    	function login(event) {
    		event.preventDefault();
    		
    		const formData = {
    				userId: document.getElementById('userId').value,
    				userPassword: document.getElementById('userPassword').value
    		}

            const jsonData = JSON.stringify(formData);
    		
    		fetch('/login.au', {
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
    			alert('로그인 중 오류가 발생했습니다.');
    			console.log(error);
    		});
    	}
    
    </script>
</head>
<body>
    <div class="login-container">
        <h2>로그인</h2>
        <form onsubmit="login(event)">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div class="form-group">
                <label for="userPassword">비밀번호</label>
                <input type="password" id="userPassword" name="userPassword" required>
            </div>
            <div class="form-group checkbox-group">
                <input type="checkbox" id="autoLogin" name="autoLogin">
                <label for="autoLogin">자동 로그인</label>
            </div>
            <button type="submit">로그인</button>
            <div class="links">
                <a href="/findAccount">계정 찾기</a> | <a href="/signup">회원가입</a>
            </div>
        </form>
    </div>
</body>
</html>