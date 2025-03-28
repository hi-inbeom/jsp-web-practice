<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>계정 찾기</title>
    <script>
        function findAccount(event) {
            event.preventDefault();
            
            const formData = {
            		email: document.getElementById('email').value
            };
            
            const jsonData = JSON.stringify(formData);
            
            fetch('/findAccount', {
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
            
            fetch('/updateAccount', {
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
    <h2>계정 찾기</h2>
    <form onsubmit="findAccount(event)">
        <div>
            <label for="email">이메일 주소:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <button type="submit">계정 찾기</button>
        </div>
    </form>
    
    <div id="account-info" style="display: none;">
        <h3>계정 정보</h3>
        <div id="user-id"></div>
        <div>
            <label for="password">새 비밀번호:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <label for="confirm-password">비밀번호 확인:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>
        <div>
            <button type="button" onclick="updateAccount(event)">비밀번호 변경</button>
        </div>
    </div>
</body>
</html>