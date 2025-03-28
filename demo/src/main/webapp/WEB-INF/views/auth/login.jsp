<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    
    <script>
    	function login(event) {
    		event.preventDefault();
    		
    		const formData = {
    				userId: document.getElementById('userId').value,
    				password: document.getElementById('password').value
    		}

            const jsonData = JSON.stringify(formData);
    		
    		fetch('/login', {
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
    			alert('로그인 중 오류가 발생했습니다.')
    		});
    	}
    
    </script>
    
</head>
<body>
    <h2>로그인</h2>
    <form onsubmit="login(event)">
        <div>
            <label for="userId">아이디:</label>
            <input type="text" id="userId" name="userId" required>
        </div>
        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <label for="autoLogin">자동 로그인:</label>
            <input type="checkbox" id="autoLogin" name="autoLogin">
        </div>
        <div>
            <button type="submit">로그인</button>
        </div>
        <div>
            <a href="/findAccount">계정 찾기</a> | <a href="/signup">회원가입</a>
        </div>
    </form>
</body>
</html>
