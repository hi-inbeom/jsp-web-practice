var socket = new SockJS("/ws"); // STOMP용 SockJS로 연결
var stompClient = Stomp.over(socket);

// 디버그 메시지 비활성화
stompClient.debug = null;

stompClient.connect({}, function (frame) {
    stompClient.subscribe("/board", function (message) {
        if (message.body === "new") {
			document.getElementById('favicon').href = '/newFavicon.ico';
        }
    });
});