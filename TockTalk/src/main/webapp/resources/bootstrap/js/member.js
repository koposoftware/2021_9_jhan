var ajaxOn = false;
$("#join").on("click", function() {
    $("#loginBtn").text("Join");
    $("#join").hide();
    $("#memberForm").height('420px');
    $("input[name=name]").prop("type", "name");
    $("input[name=pwdCfm]").prop("type", "password");
    $("#loginBtn").attr("id", "joinBtn");
    $("#joinBtn").attr("disabled", true);
    $("#joinBtn").attr("class", "btn btn-md mb-1");
    $("input[name=email]").val("");
    $("input[name=name]").val("");
    $("input[name=pwd]").val("");
    $("#form").attr("action","/member/join");
    ajaxOn = true;
    make_input();
});

function make_input() {
    let last_li = document.getElementById("form").lastElementChild;
    last_li.innerHTML = "<a href='/member/loginPage' style='color: #fff;'>Back to Login</a>";
  }


$(".chk").on("input", function() {
    let pwd = $("input[name=pwd]").val();
    let pwdCfm = $("input[name=pwdCfm]").val();
    let email = $("input[name=email]").val();

    if (pwd == pwdCfm && email != null && email != "" && pwd != null && pwd != ""
        && pwdCfm != null && pwdCfm != "") {
        $("#joinBtn").attr("disabled", false);
        $("#joinBtn").attr("class", "btn btn-md mb1");
    }
    if (pwd != pwdCfm || email == null || email == "") {
        $("#joinBtn").attr("disabled", true);
        $("#joinBtn").attr("class", "btn btn-md mb1");
    }
});

$(function() {
    $("#email").on("focusout", function() {
        var email_val = $("#email").val();

        if (ajaxOn) {
            $.ajax({
                url : '/member/chkEmail',
                type : 'post',
                data : {
                    email : email_val
                },
                success : function(result) {
                    if (result > 0) {
                        alert('중복된 이메일입니다.');
                        $("#email").val("");
                        $("#email").focus();
                    }
                }
            })
        }
    });
}); 

$(function() {
	$("#joinBtn").on("click",function() {
		$("#joinBtn").submit();
	});
});


$(function() {
	$("#lookArd").on("click",function() {
		var num = Math.floor(Math.random() * 6666 * 777);
		
            $.ajax({
                url : '/member/chkTester',
                type : 'post',
                data : {
                    email : "tester"+num+"@tester.com"
                },
               success : function(result) {
                    if (result > 0) {
                    	var id = "tester" + num + "@tester.com";
                    	alert('[Notice]\n' + '1) "' + id + '"' + '으로 접속하였습니다.\n2) 초기 비밀번호는 "1234"입니다.\n3) 익일 오전9시 모든 테스터 계정은 자동 삭제됩니다.\n4) 데이터 보존을 원하시면 회원가입 후 사용하시기 바랍니다.');
                        window.location.reload();
                    } else {
                    	alert('테스터 계정 접속 실패');
                    	window.location.reload();
                    }
                }
            })		
	});
});


