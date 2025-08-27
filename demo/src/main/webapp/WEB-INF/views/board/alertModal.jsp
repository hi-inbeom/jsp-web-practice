<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 모달</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function detailAlert({ title, message, btnClass, btnText, onConfirm = null }) {
    document.getElementById('alert-title').innerText = title;
    document.getElementById('alert-message').innerText = message;
    document.getElementById('alert-btn').innerText = btnText;

    const confirmBtn = document.getElementById('alert-btn');
    confirmBtn.className = 'btn ' + btnClass;
    

    if (onConfirm) {
    	confirmBtn.onclick = function() {
        onConfirm();
        var alertModal = new bootstrap.Modal(document.getElementById('alert-modal'));
        alertModal.hide();
      };
    }
    
  }
</script>
</head>
<body>

<div class="modal fade" id="alert-modal" tabindex="-1" aria-labelledby="alert-title" aria-hidden="true">

  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="alert-title">알림</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body">
        <p id="alert-message">점검 중입니다.</p>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="alert-btn">확인</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

</body>
</html>
