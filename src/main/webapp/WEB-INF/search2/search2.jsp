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
       	  $("#bestsearchword").hide();
         }
         else{
       	  $("#recent").show();
       	  $("#bestsearchword").show();
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
                   s+="<b onclick='selectSearch()' class='searchResult'>"+dto+"</b><br>"
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
         //alert("이벤트 감지");
         var searchword=$("#search").val();
         var s_id=$("#btnsearch").val();
         
          

         location.href="search/main?search="+searchword+"&s_id="+s_id

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
   font-size: 13pt;
   margin-bottom: 10px;
}
#result{
	margin-left: 25%;
	margin-top: 9%;
}
.recentsearch{
	display: inline-block;
	width: auto;
	height: auto;
	border: 1px solid lightgray;
	border-radius: 30px;
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
	width: 400px;
}
#bestdiv2{
	width: 400px;
}
#best{
	width: 1000px;
	display: inline-flex;
}
#allsearch{
	position: absolute;
	left: 25%;
	top: 22%;
}
#searchdiv{
	position: absolute;
	border-bottom: 3px solid black;
	left: 25%;
	top: 12%;
	padding-bottom: 5px;
}
#search{
	border: 0px;
}
input::placeholder{
	font-size: 17pt;

}
</style>
</head>
<body>

<div id="mainsearch">
	<div class="input-group w-50" id="searchdiv">
      <input type="search" class="form-control rounded" placeholder="상품을 입력하세요" aria-label="Search" aria-describedby="search-addon"
       id="search" autocomplete="off"/>
      <input type="hidden" id="btnsearch" class="btn btn-dark" value="${sessionScope.myid }">
    </div>
    <div id="result"></div>
</div>
   
    <div id="allsearch">
	    <div id="recent">
		    <b>최근 검색어</b><br>
		    <c:forEach var="dto" items="${list }" varStatus="i">
		    	<c:if test="${i.count%7 == 0}">
		    		<div class="recentsearch">${dto }</div><br>
		    	</c:if>
		    	
		    	<c:if test="${i.count%7 != 0}">
		    		<div class="recentsearch">${dto }</div>
		    	</c:if>
		    </c:forEach>
	    </div>
	    <br>
	    <div id="bestsearchword">
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
    </div>

</body>
</html>