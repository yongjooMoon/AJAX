<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP AJAX</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
    var searchRequest= new XMLHttpRequest(); //ajax를 쓰기 위해 인스턴스 생성
    var registerRequest= new XMLHttpRequest();
    function searchFunction(){
        searchRequest.open("Post","./UserSearchServlet?userName="+ encodeURIComponent(document.getElementById("userName").value),true); //이름을 입력받으면 userName에서 그 값을 검색하기 위해 넘겨줌
        searchRequest.onreadystatechange =searchProcess; //어떠한 이벤트(변화)가 나타났을 때 바로  알려줌
        searchRequest.send(null);
    }
    function searchProcess(){
        var table = document.getElementById("ajaxTable"); //html에 ajaxTable이라는 아이디를 갖는 tbody를 가져옴
        table.innerHTML =""; //빈공간으로 초기화
        if(searchRequest.readyState == 4 && searchRequest.status == 200){    //성공적으로 통신이 된다면 
            var object = eval('('+searchRequest.responseText+')');
            var result = object.result;        //servlet에서 배열을 담는 result를 받아옴 
            for(var i=0; i<result.length; i++){        //넘어온 result의 길이까지 반복
                var row = table.insertRow(0);         //테이블에 행을 추가
                for(var j=0; j<result[i].length; j++){    //result 배열에는 userNamae,userAge,userGender... 가 들어있으므로 하나씩 접근
                    var cell = row.insertCell(j);    //위에서 만들어진 행에 하나의 셀을 추가
                    cell.innerHTML=result[i][j].value;    //innerHTML에 값을 표시
                }
            }
        }
    }
    function registerFunction(){
        registerRequest.open("Post","./UserRegisterServlet?userName="+ encodeURIComponent(document.getElementById("registerName").value) +
                            "&userAge="+encodeURIComponent(document.getElementById("registerAge").value)+
                            "&userGender="+encodeURIComponent($('input[name=registerGender]:checked').val())+    //userGender는 name값으로 받았기때문에 JQuery를 사용해서 받아옴
                            "&userEmail="+encodeURIComponent(document.getElementById("registerEmail").value),true); //회원등록을 위해 입력받은 모든 값을 넘겨줌
        registerRequest.onreadystatechange =registerProcess; 
        registerRequest.send(null);
    }
    function registerProcess(){
        if(registerRequest.readyState == 4 && registerRequest.status == 200){    //성공적으로 통신이 된다면
            var result = registerRequest.responseText;
            if(result!=1){    //잘못되었다면
                alert('등록에 실패했습니다.');
            }
            else{
                var userName=document.getElementById("userName");
                var registerName=document.getElementById("registerName");
                var registerAge=document.getElementById("registerAge");
                var registerEmail=document.getElementById("registerEmail");
                userName.value ="";        //정보가 성공적으로 회원등록이 되었다면 모든 값을 초기화해줘서 input에 입력한 값을 비워줌
                registerName.value ="";
                registerAge.value ="";
                registerEmail.value ="";
                searchFunction();
            }
        }
        
    }
    window.onload =function(){
        searchFunction();
    }
</script>
</head>
<body>
    <br>
        <div class="container">
            <div class="form-gorup row pull-right">
                <div class="col-xs-8">
                    <input class="form-control" id="userName" onkeyup="searchFunction()" type="text" size="20">
                </div>
                <div class="col-xs-2">
                    <button class="btn btn-primary" onclick="searchFunction();" type="button">검색</button><br>
                </div>
            </div>
            <table class="table" style="text-align:center; border: 1px solid #dddddd">
            <thead>
                <tr>
                    <th style="background-color: #fafafa; text-align:center;">이름</th>
                    <th style="background-color: #fafafa; text-align:center;">나이</th>
                    <th style="background-color: #fafafa; text-align:center;">성별</th>
                    <th style="background-color: #fafafa; text-align:center;">이메일</th>
                </tr>
            </thead>
            <tbody id="ajaxTable">
                <tr>
                    
                </tr>
            </tbody>
		</table>
	</div>
	<div class="container">
            <table class="table" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
                        <th colspan="2" style="background-color: #fafafa; text-align:center;">회원 등록 양식</th>
                    </tr>
				</thead>
                <tbody>
                    <tr>
                        <td style="background-color:#fafafa; text-align:center;"><h5>이름</h5></td>
                        <td><input class="form-control" type="text" id="registerName" size="20"></td>
                    </tr>
                    <tr>
                        <td style="background-color:#fafafa; text-align:center;"><h5>나이</h5></td>
                        <td><input class="form-control" type="text" id="registerAge" size="20"></td>
                    </tr>
                    <tr>
                        <td style="background-color:#fafafa; text-align:center;"><h5>성별</h5></td>
                        <td>
                            <div class="form-group" style="text-align:center; margin:0 auto;">
                                <div class="btn-group" data-toggle="buttons">
                                    <label class="btn btn-primary active">
                                    <input type="radio" name="registerGender" autocomplete="off" value="남자" checked>남자
                                    </label>
                                    <label class="btn btn-primary">
                                    <input type="radio" name="registerGender" autocomplete="off" value="여자">여자
                                    </label>
                                </div>
                             </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color:#fafafa; text-align:center;"><h5>이메일</h5></td>
                        <td><input class="form-control" type="text" id="registerEmail" size="20"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><button class="btn btn-primary pull-right" onclick="registerFunction();" type="button">등록</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
</body>
</html>

