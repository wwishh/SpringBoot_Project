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
}


</style>
<script>
$(function(){
	
	
    $("#btnsearch2").click(function(e){
    	
       
       var search=$("#search2").val(); //검색어
       var option= $("#selOption").val(); //필터
       //alert(option);
       
       $.ajax({
    	   type:"get",
    	   dataType:"json",
    	   url:"/search/sangpumCount",
    	   data:{"search":search},
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
          data:{"search":search, "option":option},
          success:function(res){
        	  
        	 //alert("hi")
        	   
             var s="";
        	 var count = 1;
             
             $.each(res,function(i,dto){
            	

                s+="<div class='sangpum' style='width:250px; height:250px; margin: 20px'>";
                s+="<input type='hidden' name='num' id='num' value='" + dto.j_sangid + "'>";
                s+="<img src='../img/"+ dto.j_imageurl + "' style='width:250px; height:250px'><br>";
                s+="<b>" + dto.j_title + "</b>";
                s+="<p>" + dto.j_explanation + "</p>";
                s+="<b>"+dto.j_price.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' }) +"</b>";
                s+= "<br><i class='bi bi-eye-fill'>" + dto.j_readcount + "</i>&nbsp;&nbsp;";
                s+= "<i class='bi bi-heart-fill'>" + dto.j_interest + "</i>";
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
    
    $("#search2").keypress(function(e){
        //검색어 입력 후 엔터키 입력하면 조회버튼 클릭
        if(e.keyCode && e.keyCode == 13){
           $("#btnsearch2").trigger("click");
           return false;
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

  <div class="input-group w-25" >
      <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon"
       id="search2" autocomplete="off" value="${search }"/>
      <input type="button" value="검색" id="btnsearch2" class="btn btn-dark">
     </div>
     <div id=search>
     	<div id="sangCount" style="margin-top : 50px; margin-left:280px;"></div>
     	<select id="selOption" class="form-select" aria-label="Default select example" style="float : right; margin-right:200px; width:100px">
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
     	<c:forEach var="dto" items="${list }">
     		<div class='sangpum' style='width:250px; height:250px; margin: 20px'>
     			<input type="hidden" name="num" id="num" value="${dto.j_sangid }">
                <img src="../img/${dto.j_imageurl }" style='width:250px; height:250px'><br>
                <b>${dto.j_title}</b>
                <p>${dto.j_explanation}</p>
                <b><fmt:formatNumber value="${dto.j_price}" type="currency"/></b>
                <br><i class='bi bi-eye-fill'>${dto.j_readcount}</i>&nbsp;&nbsp;
                <i class='bi bi-heart-fill'>${dto.j_interest}</i>
                </div>
     	</c:forEach>
     	</c:if>
     	</div>
     	
     </div>
     
     


</body>
</html>