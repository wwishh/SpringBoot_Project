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
   href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gamja+Flower&family=Nanum+Pen+Script&family=
   Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
   $(function(){
      $("#search").keyup(function(e){
         
         var search=$(this).val();
         //alert(search);
         
         //검색창에 검색어 입력시 다른 div hide
         if($("#search").val() != ""){
       	  $("#recent").hide();
       	  $("#best").hide();
         }
         else{
       	  $("#recent").show();
       	  $("#best").show();
         }
         
         $.ajax({
            type:"get",
            dataType:"json",
            url:"/search/result",
            data:{"search":search},
            success:function(res){
               var s="";
               
               $.each(res,function(i,dto){
                   s+="<div class='eachdiv'>"
                   s+="<b onclick='selectSearch()' class='searchResult'style='font-size: 15pt;'>"+dto+"</b><br>"
                   s+="</div>"
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
      
      //최근 검색어 클릭시 검색창에 값 받아오기
      $(".recentsearch").click(function(){
    	 var recentSearch=$(this).html();
    	 
    	 $("#search").val(recentSearch);
      });
      
      //인기 검색어 클릭시 검색창에 값 받아오기
      $(".bestsearch").click(function(){
     	 var recentSearch=$(this).children("span").html();
     	 
     	 $("#search").val(recentSearch);
       });
      
   });
   
	// 방향키 이벤트
   var selectedIndex = -1; // 초기 선택 인덱스
     document.addEventListener('keydown', function(event) {
        switch(event.key) {
           case 'ArrowUp':
              // 위쪽 방향키 눌렸을 때의 동작
              if (selectedIndex > 0) {
                 // 이전 선택 취소
                 $(".searchResult:eq(" + selectedIndex + ")").css("background-color", "white");
                 // 현재 선택
                 selectedIndex--;
                 $(".searchResult:eq(" + selectedIndex + ")").css("background-color", "lightgray");
              }
              break;
           case 'ArrowDown':
              // 아래쪽 방향키 눌렸을 때의 동작
              if (selectedIndex < $(".searchResult").length - 1) {
                 // 이전 선택 취소
                 $(".searchResult:eq(" + selectedIndex + ")").css("background-color", "white");
                 // 현재 선택
                 selectedIndex++;
                 $(".searchResult:eq(" + selectedIndex + ")").css("background-color", "lightgray");
              }
              break;
        }
     });
   
   
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
#search{
	left: 50%;
	top: 100px;
}
#result{
	text-align: center;
	margin-top: 110px;
}
.recentsearch{
	display: inline-block;
	border: 1px solid gray;
	border-radius: 30px;
	width: auto;
	height: auto;
	text-align: center;
	padding: 5px 5px 5px 5px;
	cursor: pointer;
}
.bestsearch{
	cursor: pointer;
	width: 200px;
	margin: 7px 0px 7px 0px; 
}
#bestdiv1{
	width: 500px;
}
#bestdiv2{
	width: 500px;
}
#best{
	width: 1000px;
	display: inline-flex;
}
</style>
</head>
<body>
   <div class="input-group w-50">
      <input type="search" class="form-control rounded" placeholder="상품을 입력하세요" aria-label="Search" aria-describedby="search-addon"
       id="search" autocomplete="off"/>
      <input type="hidden" id="btnsearch" class="btn btn-dark" onclick="location.href=''">
    </div>
    
    <div id="recent">
	    <b>최근 검색어</b><br>
	    <c:forEach var="dto" items="${list }" varStatus="i">
	    	<div class="recentsearch">${dto }</div>
	    </c:forEach>
    </div>
    <br>
    <div>
    	<b>인기 검색어</b><br>
    	<div id="best">
    	<div id="bestdiv1">
	    	<c:forEach var="title" items="${title }" varStatus="i">
	    		<c:if test="${i.count <= 5}">
	    			<div class="bestsearch"><b>${i.count}</b> <span>${title }</span></div>
	    		</c:if>
	    	</c:forEach>
    	</div>
    	<div id="bestdiv2">
	    	<c:forEach var="title" items="${title }" varStatus="i">
	    		<c:if test="${i.count > 5}">
	    			<div class="bestsearch"><b>${i.count}</b> <span>${title }</span></div>
	    		</c:if>
	    	</c:forEach>
    	</div>
    	</div>
    </div>
    
    <div id="result"></div>
    
    
</body>
</html>