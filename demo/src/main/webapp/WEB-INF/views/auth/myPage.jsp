<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<script>
	function togglePasswordChange() {
	    document.getElementById('passwordChangeForm').style.display = 'block';
	}
	
	function changePassword() {
	    const userId = "${loginUser}";
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
	            alert('비밀번호 변경 완료');
	            document.getElementById('passwordChangeForm').style.display = 'none';
	            window.location.href = "/";
	        } else {
	            alert(data.message);
	        }
	    })
	    .catch(error => {
	        alert('비밀번호 변경 중 오류가 발생했습니다.');
	    });
	}
	
	function deleteAccount() {
	    const userId = "${loginUser}";
	
	    const jsonData = JSON.stringify({ userId });
	
	    fetch('/deleteAccount', {
	        method: 'DELETE',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: jsonData
	    })
	    .then(response => response.json())
	    .then(data => {
	        if (data.success) {
	            alert("회원 탈퇴 완료");
	            window.location.href = "/"; // 탈퇴 후 메인 화면으로 리디렉션
	        } else {
	            alert(data.message);
	        }
	    })
	    .catch(error => {
	        alert("회원 탈퇴 중 오류가 발생했습니다.");
	    });
	}
	
	function confirmDelete() {
	    document.getElementById('deleteModal').style.display = 'block';
	}
	
	function cancelDelete() {
	    document.getElementById('deleteModal').style.display = 'none';
	}
</script>
</head>
<body>
	<h1>마이페이지</h1>

	<h2>${loginUser}님의마이페이지</h2>
	<button onclick="togglePasswordChange()">비밀번호 변경</button>

	<div id="passwordChangeForm" style="display: none;">
		<input type="password" id="password" placeholder="새 비밀번호"> <input
			type="password" id="confirmPassword" placeholder="비밀번호 확인">
		<button onclick="changePassword()">비밀번호 변경 확인</button>
	</div>

	<button onclick="confirmDelete()">회원 탈퇴</button>

	<div id="deleteModal"
		style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border: 1px solid black;">
		<p>정말 탈퇴하시겠습니까?</p>
		<button onclick="deleteAccount()">예</button>
		<button onclick="cancelDelete()">아니오</button>
	</div>
</body>
</html>
