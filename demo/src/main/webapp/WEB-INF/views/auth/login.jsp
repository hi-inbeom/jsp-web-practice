<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

		.login-container {
			width: 100%;
			max-width: 800px;
			height: 600px;
			background: repeating-linear-gradient(
				45deg,
				red,
				red 10px,
				white 10px,
				white 20px,
				blue 20px,
				blue 30px,
				white 30px,
				white 40px
			);
			display: flex;
			flex-direction: column;
		}
		
		.form-top,
		.form-bottom {
			height: 10px;
			width: 100%;
		}
		.form-middle {
			flex: 1;
			display: flex;
		}
		.form-middle-left,
		.form-middle-right {
			width: 10px;
		}
		
		.main-container {
			width: 100%;
			background-color: white;
		    display: flex;
		    flex-wrap: wrap;
		    justify-content: space-between;
			padding: 15px;
		}
		.top-left,
		.top-right,
		.bottom-left,
		.bottom-right {
			width: 50%;
		}
		
		/* 2사분면 */
		.top-left form {
			width: 80%;
		}
		.login-input {
			width: 100%;
			font-size: 18px;
			border: none;
			border-bottom: 1px solid black;
			margin-bottom: 5px;
			outline: none;
		}
		
		.submit-btn {
			width: 46%;
			border-bottom: 1px solid black;
			margin-bottom: 5px;
			font-size: 18px;
		}
		
		.submit-btn button {
			background: none;
			border: none;
			cursor: pointer;
		}
		
		.main-container a {
			color: black;
			text-decoration: none;
		}
		
		.top-left span {
			font-size: 28px;
		}
		
		
		.top-right {
		    width: 100px;
		    height: 100px;
		}
		
		.top-right a {
		    display: flex;
		    flex-direction: column;
		    width: 100px;
		    height: 100px;
		    justify-content: flex-start;
			font-size: 12px;
			color : blue;
    		text-decoration: none;
		}
		
		.top-right a,
		.top-right a div {
			text-align: center;
			justify-content: flex-start;
		    text-decoration: none;
		}
		
		.bottom-right {
			display:flex;
			align-items: center; 
		}
		.bottom-right div {
			width: 100%;
			padding-left: 25px;
		}
		.main-image {
		    height: 100%;
		    object-fit: contain;
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
 			<div class="form-top"></div>
		    <div class="form-middle">
		      <div class="form-middle-left"></div>
      		  <div class="main-container">
      		    <div class="top-left">
	      		  	<form onsubmit="login(event)" class="top-left">
	      		  		<span style="font-size: 28px;">From</span> <br>
				        <input type="text" class="login-input" id="userId" name="userId" placeholder="아이디" autocomplete="none" required> <br>
				        <input type="password" class="login-input" id="userPassword" name="userPassword" placeholder="비밀번호" required>
				        <div class="submit-btn">
				        	<button type="submit">로그인</button> <br>
				        </div>
	          			<a href="/findAccount">계정 찾기</a> | <a href="/signup">회원가입</a>
	      		  	</form>
      		  	</div>
      		  	<div class="top-right">
      		  		<a href="/">
	      		  		<img alt="우편" src="image/kiki-seal.png">
	      		  		<div style="font-size: 12px;">Kiki`s Delivery</div>
      		  		</a>
      		  	</div>
      		  	<div class="bottom-left"></div>
      		  	<div class="bottom-right">
      		  		<div class="span-form">
	      		  		<span style="font-size: 28px;">To</span> <br>
	      		  		<span>15 Church St, Ross TAS 7209</span> <br>
	      		  		<span style="font-size: 18px; font-weight: 800;">Kiki</span> <br>
	      		  		<span>7209</span> <br>
	      		  		<span>Australia</span>
      		  		</div>
      		  	</div>
      		  </div>
		      <div class="form-middle-right"></div>
		    </div>
 			<div class="form-bottom"></div>
 		</div>
 	</body>
 
 </html>