<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/rolling.css" />
<style>

</style>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
   $('.btn').addClass('pointer').click(function () {
   var ih = $(this).index() == 0 ? -18 : 18; //위아래로 움직이는 px 숫자
   var obj = $('.recommend_list');
   obj.animate({ scrollTop:obj.scrollTop() + ih }, 100);
  });
});

$(function(){
  function fn_article(container,btn, auto){}
  fn_article3('rolling','bt5',true);
});




function fn_article3(containerID, buttonID, autoStart){
	var $element = $('#'+containerID).find('.notice-list');
	var $prev = $('#'+buttonID).find('.prev');
	var $next = $('#'+buttonID).find('.next');
	var $play = $('#'+containerID).find('.control > a.play');
	var $stop = $('#'+containerID).find('.control > a.stop');
	var autoPlay = autoStart;
	var auto = null;
	var speed = 3000;
	var timer = null;

	var move = $element.children().outerHeight();
	var first = false;
	var lastChild;

	lastChild = $element.children().eq(-1).clone(true);
	lastChild.prependTo($element);
	$element.children().eq(-1).remove();

	if($element.children().length==1){
		$element.css('top','0px');
	}else{
		$element.css('top','-'+move+'px');
	}

	if(autoPlay){
		timer = setInterval(moveNextSlide, speed);
		$play.addClass('on').text('▶');
		auto = true;
	}else{
		$play.hide();
		$stop.hide();
	}

	$element.find('>li').bind({
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	$play.bind({
		'click': function(e){
			if(auto) return false;

			e.preventDefault();
			timer = setInterval(moveNextSlide, speed);
			$(this).addClass('on').text('▶');
			$stop.removeClass('on').text('▣');
			auto = true;
		}
	});

	$stop.bind({
		'click': function(e){
			if(!auto) return false;

			e.preventDefault();
			clearInterval(timer);
			$(this).addClass('on').text('■');
			$play.removeClass('on').text('▷');
			auto = false;
		}
	});

	$prev.bind({
		'click': function(){
			movePrevSlide();
			return false;	
		},
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	$next.bind({
		'click': function(){
			moveNextSlide();
			return false;
		},
		'mouseenter': function(){
			if(auto){
				clearInterval(timer);
			}
		},
		'mouseleave': function(){
			if(auto){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	function movePrevSlide(){
		$element.each(function(idx){
			if(!first){
				$element.eq(idx).animate({'top': '0px'},'normal',function(){
					lastChild = $(this).children().eq(-1).clone(true);
					lastChild.prependTo($element.eq(idx));
					$(this).children().eq(-1).remove();
					$(this).css('top','-'+move+'px');
				});
				first = true;
				return false;
			}

			$element.eq(idx).animate({'top': '0px'},'normal',function(){
				lastChild = $(this).children().filter(':last-child').clone(true);
				lastChild.prependTo($element.eq(idx));
				$(this).children().filter(':last-child').remove();
				$(this).css('top','-'+move+'px');
			});
		});
	}

	function moveNextSlide(){
		$element.each(function(idx){

			var firstChild = $element.children().filter(':first-child').clone(true);
			firstChild.appendTo($element.eq(idx));
			$element.children().filter(':first-child').remove();
			$element.css('top','0px');

			$element.eq(idx).animate({'top':'-'+move+'px'},'normal');

		});
	}
}  
</script>

<div class="news" id="rolling">
	<div class="open-event fl">
		<span style="font-weight: bold;">공지사항</span>
		<span style="position: absolute; left: 680px; z-index: 1; cursor: pointer; font-size: 10pt; color: #999; line-height: 23px;" onclick="location.href='/awesomecenter/boardmenu.to'">더보기▶</span>
		<ul class="notice-list" style="margin-left: 80px; color:">
			<c:if test = "${ requestScope.noticeList != null }">
				<c:forEach var = "notList" items="${ requestScope.noticeList }" varStatus="status" > 
					<li><a href="/awesomecenter/noticeBoardDetail.to?not_seq=${notList.not_seq}">${notList.not_title}</a><span class="date"></span></li>
				</c:forEach>
			</c:if>
			
			<c:if test="${ requestScope.noticeList == null }">
				<li><a href="#">공지사항이 없습니다.</a><span class="date"></span></li>
			</c:if>
		</ul>
		<%-- 
		<ul class="notice-list">
			<li><a href="#">1. 공지사항1공지사항1공지사항1공지사항1 수정중수정중수정중수정중</a><span class="date">2020.01.01</span></li>
			<li><a href="#">2. 공지사항2공지사항2공지사항2공지사항2 수정중수정중수정중수정중</a><span class="date">2020.01.02</span></li>
			<li><a href="#">3. 공지사항3공지사항3공지사항3공지사항3 수정중수정중수정중수정중</a><span class="date">2020.01.03</span></li>
			<li><a href="#">4. 공지사항4공지사항4공지사항4공지사항4 수정중수정중수정중수정중</a><span class="date">2020.01.05</span></li>
			<li><a href="#">5. 공지사항5공지사항5공지사항5공지사항5 수정중수정중수정중수정중</a><span class="date">2020.01.07</span></li>
		</ul>
		--%>
	</div>
</div>