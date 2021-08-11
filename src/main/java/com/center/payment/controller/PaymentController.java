package com.center.payment.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.center.member.model.MemberVO;
import com.center.payment.mail.GoogleMail;
import com.center.payment.model.CartVO;
import com.center.payment.service.InterPaymentService;

@Controller
public class PaymentController {
	
	@Autowired
	private InterPaymentService service;

	@Autowired
	private GoogleMail mail;
	
	///////////////////////////// 솜님 //////////////////////////////////////////////
	
	// 1. 장바구니 업데이트
	@RequestMapping(value="/cart.to")
	public ModelAndView requiredLogin_cart(HttpServletRequest request, HttpServletResponse response ,ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userno = loginuser.getUserno();
		String class_seq = request.getParameter("class_seq");
		
		HashMap<String, String> cartMap = new HashMap<String, String>();		
		cartMap.put("userno", userno);
		cartMap.put("class_seq", class_seq);
		
		
		List<CartVO> cartList = null;
		
		// <1> 바로 cart.to로 들어갈 경우 : 해당 회원의 장바구니 리스트를 불러온다. 
		if(class_seq==null) {
			
			cartList = service.getCartList(userno); 

			mav.addObject("cartList", cartList);
			mav.setViewName("payment/cart.tiles1");
			
		}
		// <2> 장바구니 버튼(cart.to?class_seq=)으로 장바구니 페이지에 들어온 경우
		else {
			
			// <3> 장바구니 테이블에 넣는다.
			int n = service.addCart(cartMap);
			
			if(n==0) { // 이미 존재하는 상품인 경우		
				String msg = "이미 장바구니에 존재하는 상품입니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");

			}
			
			else if(n>0) { // 존재하지 않는 상품이라 정상적으로 장바구니에 update가 된 경우
				
				cartList = service.getCartList(userno); 

				mav.addObject("cartList", cartList);
				mav.setViewName("payment/cart.tiles1");
			}
		}
		return mav;
	}
	
	// 2. 장바구니 강좌 삭제
	@ResponseBody
	@RequestMapping(value="/deleteCart.to", produces="text/plain;charset=UTF-8")
	public String requiredLogin_cart(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="deleteLecture[]")String[] deleteLecture) {	

		for(int i=0;i<deleteLecture.length;i++) {
			service.deleteCart(deleteLecture[i]);			
		}
		
		JSONObject jsobj = new JSONObject();
		
		jsobj.put("msg", "강좌가 삭제되었습니다.");
		
		return jsobj.toString();
	}
	
	// 3. 결제 페이지
	@RequestMapping(value="/payment.to", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_payment(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 로그인한 유저의 유저번호 알아오기
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");		
		String userno = loginuser.getUserno();
		
		// HashMap에 userno 담기
		HashMap<String, String> cartMap = new HashMap<String, String>();		
		cartMap.put("userno", userno);
		
		String sep = request.getParameter("sep");
		
		String[] deleteLecture = request.getParameterValues("deleteLecture");

		String cart_seq = "";
		
		if(deleteLecture!=null) { // 장바구니에서 결제로 넘어 온 경우 : 배열로 복수개의 강좌가 넘어온다 (status=0)
			
			for(int i=0;i<deleteLecture.length;i++) {
				// 정상적으로 들어옵니다...
			//	System.out.println("올바르게 들어온 장바구니 번호 : " + deleteLecture[i]);			
			}
			
		}
		
		// 대기번호의 사람이 결제
		else if("wait".equalsIgnoreCase(sep)) {
		
			String class_seq = request.getParameter("class_seq");
			
			// 장바구니테이블로 insert한다.
			cartMap.put("class_seq", class_seq);
			service.insertOneCart(cartMap);
			
			cart_seq = service.getCartNum(cartMap);
			
		}
		
		else { // 상세페이지에서 바로 결제로 넘어온다 : 1개의 강좌만 넘어온다
			// 정상적으로 들어옵니다...
			String class_seq = request.getParameter("class_seq");
		//	System.out.println("올바르게 넘어온 강좌 번호 : " + class_seq);
			
			// 장바구니테이블로 insert한다.
			cartMap.put("class_seq", class_seq);
			service.insertOneCart(cartMap);
			// 상세페이지에서 넘어온 장바구니 버튼 reuturn(status=1)
			cart_seq = service.getCartNum(cartMap);
		//	System.out.println("올바르게 넘어온 카트 번호 : " + cart_seq);
			
		}
		
		HashMap<String, Object> orderMap = new HashMap<String, Object>();
		
		orderMap.put("userno", userno);
		orderMap.put("deleteLecture", deleteLecture);
		if(cart_seq == null || "".equals(cart_seq)) {
			cart_seq = "";
		}
		
		orderMap.put("cart_seq", cart_seq);
		
		// 장바구니 번호로 가져온 정보를 조회
		List<CartVO> orderDueList = service.getOrderDueList(orderMap);
		
		int totalCount = 0; 
		for(CartVO cvo : orderDueList ) {
			
			totalCount += cvo.getClass_fee();
		}
		
		mav.addObject("orderDueList", orderDueList);
		mav.addObject("totalCount", totalCount);
		
		mav.setViewName("payment/payment.tiles1");
		
		return mav;
		
	}

	////////////////////////////////////// 서승헌 ////////////////////////////////////////
	// 파이널 수강결제  << 3. 수강결제 변경
/*  	@RequestMapping(value="/payment.to") 
  	public String payment(HttpServletRequest request) {
  		
  		return "payment/payment.tiles1";
  	}*/
	
	@RequestMapping(value="/paying.to", method={RequestMethod.GET})
	public String requiredLogin_paying(HttpServletRequest request, HttpServletResponse response) {
		
		
		
		HttpSession session = request.getSession();
   		
   		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userno =	loginuser.getUserno();
		String username = loginuser.getUsername();
   		String totalPrice = request.getParameter("totalCount");
		
   		request.setAttribute("userno", userno);
   		request.setAttribute("username", username);
   		request.setAttribute("totalPrice", totalPrice);
   		
   		String payArr = request.getParameter("payArr");
   		String[] class_seqArr = payArr.split(",");
   		
   		for(int i=0; i<class_seqArr.length; i++) {
   			
   			HashMap<String, String> map = new HashMap<String, String>();
   	   		map.put("userno", userno);
   			map.put("class_seq", class_seqArr[i]);
   			// 결제한 강좌가 있는지 알아보기
   			int n = service.lecPaymentSuc(map);
   	   		
   			if(n == 0) {
   				
   				request.setAttribute("msg", "이미 결제한 강좌는 결제하실 수 없습니다.");
   				
   				return "msg";
   			}
   			
   		}
   
   		
   		return "payment/paymentGateway";
	}
	

  	// 수강결제 수강내역 리스트에 insert
   	@RequestMapping(value="/paymentEnd.to", method={RequestMethod.POST}) 
   	public String requiredLogin_paymentEnd(HttpServletRequest request, HttpServletResponse response) throws Throwable {
   		
   		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy년 MM월dd일 HH시mm분ss초");
		
   		Date time = new Date();
   				
   		String time2 = format2.format(time);
   		
   		String totalCount = request.getParameter("totalCount");
   		
   		HttpSession session = request.getSession();
   		
   		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userno =	loginuser.getUserno();
		
   		String payArr = request.getParameter("payArr");
   		String cartArr = request.getParameter("cartArr");
   		String priceArr = request.getParameter("priceArr");
   		
   		String[] class_seqArr = payArr.split(",");
   		
   		String[] cart_seqArr = null;
   		if(cartArr == null || "".equals(cartArr)) {
   			cart_seqArr = null;
   		}
   		else {
   			cart_seqArr = cartArr.split(",");
   		}

   		String[] class_feeArr = priceArr.split(",");
   		
   		List<CartVO> payList = new ArrayList<CartVO>();
   		
   		String str = "";
   		
   		for(int i=0; i<class_seqArr.length; i++) {
   			
   		//	System.out.println(class_seqArr[i]);
   			
   			HashMap<String, String> map = new HashMap<String, String>();
   	   		map.put("userno", userno);
   			map.put("class_seq", class_seqArr[i]);
   			map.put("cart_seq", cart_seqArr[i]);
   			map.put("class_fee", class_feeArr[i]);
   			
   			// 이미 들어가 있는지 한번 더 확인
   			int r = service.lecPaymentSuc(map);

   			// 결제한 강좌가 아닐때
   			if(r == 1) {
   			
	   			int n = service.insertOneOrder(map);
	   			
	   			if(n == 1) {
	   				
	   		//		수강생 테이블 select 
	   		//		-> 정원 --> 강좌tbl 대기접수
	   				// 수강생 테이블에서 강좌 수강생 수 조회
	   				String studentCnt = service.getStudentCnt(map);
	   				
	   				if(studentCnt != null || !"".equals(studentCnt)) {
	   					
	   					map.put("studentCnt", studentCnt);
	   					
	   					// 정원과 수강생이 같으면 강좌를 대기접수로 Update
	   					service.waitUpdate(map);
	   				}
	   				
	   			}
	   			
	   			CartVO cvo = service.selectPayment(map);
	   			
	   			if(i == 0) {
	   				
	   				str = cvo.getClass_title();
	   				
	   			}
	   			
	   			payList.add(cvo);
	   			
	   		}
	   		
	   		
	   		String email = loginuser.getEmail();
		    
	   		DecimalFormat Dec = new DecimalFormat("###,###");
	   		
	   		///////////////////////////////////   이메일 내용       ///////////////////////////////////////
		
			StringBuilder sb = new StringBuilder(); 
	
		   	sb.append("<table style = \"border-top: 4px solid #eb2d2f; max-width: 679px; margin: auto; width: 100%;   font-family: Roboto,'나눔고딕',NanumGothic,'맑은고딕',Malgun Gothic,'돋움',Dotum,Helvetica,'Apple SD Gothic Neo',Sans-serif;\">\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td colspan = \"4\">\r\n" + 
		   			"					<img src=\"https://postfiles.pstatic.net/MjAyMDAxMzBfMzgg/MDAxNTgwMzQ5MDc0MDgw.VKoeNyeYiSS-mlP9Et6W2dKsekrfVGPfE_VZtI0KubEg.t94N4HwX8bjxBAsFaJGZVDb4C4CMXqn03_PDYq6DkQ4g.PNG.27tjtmdgjs/logo.PNG?type=w966\" width=\"200\" height=\"40\" style=\"padding:30px 30px 30px 10px\" alt=\"nicepay\" loading=\"lazy\">\r\n" + 
		   			"				</td>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width=\"39\"></td>\r\n" + 
		   			"				<td colspan = \"2\" width = \"600\" style = \"font-size: 28px; color: #666; padding: 25px 0;\">\r\n" + 
		   			"					"+loginuser.getUsername()+"님,<br>\r\n" + 
		   			"					<span style = \"color : #444; font-weight: bold;\">결제가 완료</span>되었습니다.\r\n" + 
		   			"				</td>\r\n" + 
		   			"				<td width=\"39\"></td>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width=\"39\"></td>\r\n" + 
		   			"				<td width=\"600\" style = \"font-size: 15px; color: #666;word-break: keep-all; padding: 25px 0\">\r\n" + 
		   			"						고객님이 결제하신 내역입니다.\r\n" + 
		   			"				</td>\r\n" + 
		   			"				<td width=\"39\"></td>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td colspan = \"2\" width = \"600\" align = \"left\" style = \"font-size: 15px; color: #000; font-weight: bold;  padding-bottom: 10px; border-bottom: 1px solid #000;\">결제정보</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"			\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td style = \" font-size: 13px;color: #666;padding-bottom: 10px;padding-top: 15px;\">구매자명</td>\r\n" + 
		   			"				<td width = \"500\" align=\"right\" style = \"font-size: 13px; color: #666; font-weight: bold; padding-bottom: 10px; padding-top: 15px;\">"+loginuser.getUsername()+"</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td style = \" font-size: 13px;color: #666;padding-bottom: 10px;padding-top: 15px;\">상품명</td>\r\n" + 
		   			"				<td width = \"500\" align=\"right\" style = \"font-size: 13px; color: #666; font-weight: bold; padding-bottom: 10px; padding-top: 15px;\">"+str+"</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td style = \" font-size: 13px;color: #666;padding-bottom: 10px;padding-top: 15px;\">결제일시</td>\r\n" + 
		   			"				<td width = \"500\" align=\"right\" style = \"font-size: 13px; color: #666; font-weight: bold; padding-bottom: 10px; padding-top: 15px;\">"+time2+"</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td style = \" font-size: 13px;color: #666;padding-bottom: 10px;padding-top: 15px;\">결제수단</td>\r\n" + 
		   			"				<td width = \"500\" align=\"right\" style = \"font-size: 13px; color: #666; font-weight: bold; padding-bottom: 10px; padding-top: 15px;\">신용카드</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td style = \" font-size: 19px; color: #666;padding-bottom: 10px;padding-top: 15px; font-weight: bold;\">결제금액</td>\r\n" + 
		   			"				<td width = \"500\" align=\"right\" style = \"color: #eb2d2f; font-weight: bold; font-size: 19px; padding-bottom: 10px;padding-top: 15px;\">"+Dec.format(Integer.parseInt(totalCount))+"원</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td></td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td colspan = \"2\" width = \"600\" align = \"left\" style = \"font-size: 15px; color: #000; font-weight: bold; padding: 10px 0; border-bottom: 1px solid #000;\">상점정보</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td width = \"100\" style = \" font-size: 13px;color: #666;padding-bottom: 10px;padding-top: 15px;\">상점명</td>\r\n" + 
		   			"				<td width = \"500\" align=\"right\" style = \"font-size: 13px; color: #666; font-weight: bold; padding-bottom: 10px; padding-top: 15px;\">으뜸문화센터</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			<tr>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td style = \" font-size: 13px;color: #666;padding-bottom: 10px;padding-top: 15px;\">사이트주소</td>\r\n" + 
		   			"				<td align=\"right\" style = \"font-size: 13px; color: #666; font-weight: bold; padding-bottom: 10px; padding-top: 15px;\">http://localhost:9090/awesomecenter/</td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"			\r\n" + 
		   			"			<tr style = \"padding-bottom: 50px;\">\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"				<td colspan = \"2\" align=\"center\" width = \"600\" style = \"height: 42px; background:#eb2d2f;\"><a href = \"http://localhost:9090/awesomecenter/\"  style = \" color: #fff;font-size: 15px;text-align: center; text-decoration: none;\">상점 바로가기</a></td>\r\n" + 
		   			"				<td width = \"39\"></td>\r\n" + 
		   			"			</tr>\r\n" + 
		   			"		\r\n" + 
		   			"		\r\n" + 
		   			"		</table>");
		   	
		   	String emailContents = sb.toString();
		   	
		//   	HttpSession session = req.getSession();
		   	
		    // === #191. 입고에 관련된 최종관리자 이메일(younghak0959@naver.com)을 DB에서 불러왔다고 가정한다. === 
		   	String emailAddress = email; // 자신의 이메일을 기재하세요!!
		   	
		   	mail.sendmail(emailAddress, emailContents);
		 // ======= ***** 제품입고가 완료되었다라는 email 보내기 끝 ***** ======= //

   		}
   		

   		request.setAttribute("payList", payList);
   		request.setAttribute("totalCount", totalCount);
   		
   		
   		return "payment/paymentEnd.tiles1";
   	}
	
   
   	
}