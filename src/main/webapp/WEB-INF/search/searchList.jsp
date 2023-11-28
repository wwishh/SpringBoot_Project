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
<style>

#list{
	width:auto;
	height:auto;
}

.sangpum{
	cursor : pointer;
	display : inline-block;
	width:250px;
	height:250px;
	margin: 20px;
}

.interest{
	cursor : pointer;
}


</style>
<script>
$(function(){
	
	
    $("#btnsearch2").click(function(e){
    	
       
       var search=$("#search2").val(); //검색어
       var option= $("#selOption").val(); //필터
       var category = $("#category").val();//카테고리
       //alert(category);
       
       $.ajax({
    	   type:"get",
    	   dataType:"json",
    	   url:"/search/sangpumCount",
    	   data:{"search":search, "category":category},
    	   success:function(res){

    		   var count = "";
    		   
    		   count += "<b>상품 " + res + "</b>";
    		   
    		   if(search=="" || res==0){
                   $("#sangCount").html("<b>"+search+ "에 대한 검색결과가 없습니다</b>");
                   
                }
                else if(count!=0){
                   $("#sangCount").html(count);
                }
    		   
    		   
    	   }
       });
       
       $.ajax({
          type:"get",
          dataType:"json",
          url:"/search/list",
          data:{"search":search, "option":option, "category": category},
          success:function(res){
        	  
        	 //alert("hi")
        	   
             var s="";
        	 var count = 1;
             
             $.each(res,function(i,dto){
            	
				s+="<div style='display : inline-block;'>";
                s+="<div class='sangpum'>";
                s+="<input type='hidden' name='num' id='num' value='" + dto.j_sangid + "'>";
                s+="<img src='../img/"+ dto.j_imageurl + "' style='width:250px; height:250px'><br>";
                s+="<b>" + dto.j_title + "</b>";
                s+="<p>" + dto.j_explanation + "</p>";
                s+="<b>"+dto.j_price.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' }) +"</b>";
                s+="</div>";
                s+="<div style='margin-left:20px;'>";
                s+= "<i class='bi bi-eye-fill'>" + dto.j_readcount + "</i>&nbsp;&nbsp;";
                s+= "<i class='bi bi-heart-fill interest' num='" + dto.j_sangid + "'>" + dto.j_interest + "</i>";
                s+="</div>";
                s+="</div>";
                if(count%4==0){
                	s+="<br>";
                }
                
                count++;
                //console.log(count)

              });
             
             if(search==""){
                $("#list").html("");
             }
             else{
                $("#list").html(s);
             }
          }
       });
    });
    
    
    $("#selOption").change(function(){
    	$("#btnsearch2").trigger("click");
    });
    
    $("#category").change(function(){
    	$("#btnsearch2").trigger("click");
    });
    
    $("#search2").keypress(function(e){
        //검색어 입력 후 엔터키 입력하면 조회버튼 클릭
        if(e.keyCode && e.keyCode == 13){
           $("#btnsearch2").trigger("click");
           return false;
        }

     });
    
    //하트누르면 1증가 및 db에 좋아요 여부 저장
    $(document).on ("click","i.interest", function(event){
    	var currentColor = $(this).css("color");
    	

    	var num = $(this).attr('num');
    	
    	var i_id = $("#myid").val();
    	
    	var interest = $(this);

    	//alert(interest);
    	//alert(i_id);
    	//alert(num);

    	if (currentColor === "rgb(255, 0, 0)") {
             // 현재 색상이 빨간색인 경우 검은색으로 변경합니다.
             $(this).css("color", "black");
             $.ajax({
               type: "get",
               dataType:"html",
               url: "/interest/delete",
               data: {"i_id":i_id, "i_sangpum":num},
               success: function(data) {
                console.log("좋아요취소");
                  
               }
             });
             
             $.ajax({
             	   type:"get",
             	   dataType:"json",
             	   url:"/sangpum/minusInterest",
             	   data:{"num":num},
             	   success:function(res){
             		  interest.text(res.mInterest);
             		       		   
             	   }
                });
             
             
         } else {
             // 현재 색상이 빨간색이 아닌 경우 빨간색으로 변경합니다.
             $(this).css("color", "red");
             $.ajax({
               type: "get",
               dataType:"html",
               url: "/interest/insert",
               data: {"i_id":i_id, "i_sangpum":num},
               success: function(data) {
                console.log("좋아요클릭");
                  
               }
             });
             
             $.ajax({
           	   type:"get",
           	   dataType:"json",
           	   url:"/sangpum/plusInterest",
           	   data:{"num":num},
           	   success:function(res){
           		interest.text(res.pInterest);
           		       		   
           	   }
              });
         }

    });

});

$(document).on("click","div.sangpum", function(event){
	
	var num = $(this).find('#num').val();
	//alert(num)
	location.href="../sangpum/detail?num=" + num;
});



</script>
</head>
<body>
<div class="container"> <!-- 내용을 중앙에 정렬하기 위한 컨테이너 추가 -->
    <div class="row justify-content-center">
      <div class="col-md-6"> <!-- 필요에 따라 컬럼 너비를 조절합니다. -->
  <div class="input-group w-75">
  	  <input type="hidden" id="myid" value="${sessionScope.myid }">
      <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon"
       id="search2" autocomplete="off" value="${search }" style="width:200px"/>
      <input type="button" value="검색" id="btnsearch2" class="btn btn-dark">
      
      <select id="category" class="form-select" style="margin-left:50px; width:100px;">
      							<option value="all" selected="selected">전체</option>
								<option value="mobile">모바일</option>
								<option value="digital">디지털</option>
								<option value="computer">컴퓨터/주변기기</option>
								<option value="camera">전자제품/카메라</option>
								<option value="leisure">스포츠/레저</option>
								<option value="w_clothing">여성의류</option>		<!-- women's clothing -->
								<option value="m_clothing">남성의류</option>		<!-- men's clothing -->
								<option value="c_clothing">아동의류</option>		<!-- children's clothing -->
								<option value="beauty">뷰티/미용</option>
								<option value="food">식품</option>
								<option value="hobby">취미</option>
								<option value="c_goods ">굿즈/수집품</option>		<!-- Collectible_goods -->
								<option value="h_goods">생활용품</option>			<!-- Household_goods -->
								<option value="m_goods">잡화용품</option>			<!-- miscellaneous goods -->
								<option value="cm_goods">아동잡화</option>			<!-- Children's miscellaneous goods -->								
								<option value="interior">가구/인테리어</option>
								<option value="pet">반려동/식물</option>
								<option value="etc">기타</option>
							</select>
  </div>
  </div>
  </div>
  </div>
  
     
     <div id=search>
     	<div id="sangCount" style="margin-top : 50px; margin-left:280px;"></div>
     	
     	<select id="selOption" class="form-select" aria-label="Default select example" style="float : right; margin-right:200px; width:100px;">
  			<option value="j_readcount" selected>인기순</option>
  			<option value="j_interest">좋아요순</option>
  			<option value="j_price">높은 가격순</option>
  			<option value="J_PRICE">낮은 가격순</option>
  			<option value="j_postdate">등록일순</option>
		</select>
     	<div id="list" style="margin-top : 20px; margin-left:260px;">
     	<c:if test="${list.size()==0 }">
     		<b>${search }에 대한 검색결과가 없습니다</b>
     	</c:if>
     	<c:if test="${list.size()!=0 }">
     	<div style="margin-left:20px">
     	<b>상품 ${list.size() }</b>
     	</div>
     	<c:forEach var="dto" items="${list }">
     	<div style='display : inline-block;'>
     		<div class='sangpum'>
     			<input type="hidden" name="num" id="num" value="${dto.j_sangid }">
                	<img src="../img/${dto.j_imageurl }" style='width:250px; height:250px'><br>
                	<b>${dto.j_title}</b>
                	<p>${dto.j_explanation}</p>
                	<b><fmt:formatNumber value="${dto.j_price}" type="currency"/></b>
                </div>
                <div style='margin-left:20px;'>
                	<i class='bi bi-eye-fill'>${dto.j_readcount}</i>&nbsp;&nbsp;
                	<i class='bi bi-heart-fill interest' num='${dto.j_sangid }'>${dto.j_interest}</i>
                </div>
             </div>  
     	</c:forEach>
     	</c:if>
     	</div>
     	
     </div>
     
     


</body>
</html>