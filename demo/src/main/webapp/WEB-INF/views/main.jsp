<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .main-container {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 800px;
            text-align: center;
        }
        
	    .main-image {
	        width: 100%;
	        object-fit: cover;
		    border-bottom-left-radius: 10px;
		    border-bottom-right-radius: 10px;
	    }
    </style>
    
    <script>
    	function logout(event) {
            event.preventDefault();
            
            fetch('/logout.au', {
                method: 'POST'
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
                alert('로그아웃 중 오류가 발생했습니다.');
                console.log(error);
            });
    	}
    
    </script>
</head>
<body>
	<div class="main-container">
		<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
    	<img class="main-image" alt="수하물" src="image/kiki-main.png">
    </div>
</body>
</html>
