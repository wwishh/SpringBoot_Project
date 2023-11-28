<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
   rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gamja+Flower&family=Nanum+Pen+Script&family=Noto+Serif+KR:wght@200&display=swap"
   rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

<title>Insert title here</title>
<script type="text/javascript">
   $(function(){
      $("#search").keyup(function(){
         
         var search=$(this).val();
         //alert(search);
         
         $.ajax({
            type:"get",
            dataType:"json",
            url:"/search/result",
            data:{"search":search},
            success:function(res){
               var s="";
               
               $.each(res,function(i,dto){
                  s+="<b onclick='selectSearch()' class='searchResult'style='font-size: 15pt;'>"+dto+"</b><br>"
               });
               
               if(search==""){
                  $("#result").html("");
               }
               else{
                  $("#result").html(s);
               }
            }
         });
      });

      $("#search").keypress(function(e){
         //검색어 입력 후 엔터키 입력하면 조회버튼 클릭
         if(e.keyCode && e.keyCode == 13){
            $("#btnsearch").trigger("click");
            return false;
         }
         //엔터키 막기
         if(e.keyCode && e.keyCode == 13){
              e.preventDefault();   
         }
      });
      
      $("#btnsearch").click(function(){
         alert("이벤트 감지");
      });
      
      
      $("#alarmBtn").click(function(){
    	  //세션에서 현재 로그인한 사용자의 아이디를 가져와야 됨
    	  var myid = '${sessionScope.myid}';
    	  alert(myid);
    	  //location.href="/message/goChattingList?user_id="+myid;
    	  
      });
      
   });
   
   <!--사용자 정의함수-->
   function selectSearch() {
       $(document).on("click","b.searchResult",function(event){
          var s=$(this).html();
          //alert(s);
          
          $("#search").val(s);
          $("#result").html("");
       });
    }
   
   
   $(document).on("mouseover",".searchResult", function(event){
      $(this).css("background-color", "lightgray");
   });
   
   $(document).on("mouseout",".searchResult", function(event){
      $(this).css("background-color", "white");
   }); 
</script>
<style type="text/css">
.searchResult{
   cursor: pointer;
}

nav{
   font-size: 1.5em;
}
</style>
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light">
		<div class="container px-4 px-lg-3">
			<a class="navbar-brand" href="/"> <img alt=""
				src="../img/icon.PNG" style="width: 20vh;">
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">About</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">Fleamarket</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="/list">All Products</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">Popular Items</a></li>
							<li><a class="dropdown-item" href="/">New Arrivals</a></li>
						</ul></li>
				</ul>


				<div style="justify-content: space-between;">
				<c:if test="${sessionScope.loginok==null}">
				<button type="button" class="btn btn-outline-primary" onclick="location.href='../loginform'">로그인</button>
				</c:if>
				
				<c:if test="${sessionScope.loginok!=null}">
				<img alt="" src="../img/loginprofile.png" width="50vw" height="50vh" align="left" style="border-radius:30px;"/>
				<b>${sessionScope.myname}님이 로그인중입니다</b>
				<button type="button" class="btn btn-outline-primary" onclick="location.href='../logoutprocess'">로그아웃</button>
				</c:if>
				
				
				
				 
				
				
				
				
				
				<!-- 검색창 -->
				<div class="input-group w-25">
					<c:if test="${sessionScope.myid == null}">
						${sessionScope.myid = "guest"}
					</c:if>
					<i class="bi bi-search" onclick="location.href='/search?s_id=${sessionScope.myid}'" style="cursor: pointer;"></i>
						
				</div>
				
				<div>
					<i class="bi bi-bell-fill alarmBtn" style="cursor: pointer;"></i>
				</div>
				


			</div>
			
		</div>

		<div id="result"></div>

	</nav>
         
</body>
</html>