package com.center.member.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.center.common.MyUtilHM;
import com.center.common.SHA256;
import com.center.member.model.MemberVO;
import com.center.member.service.InterMemberService;
import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

@Controller
public class LoginController {
	@Autowired
	private InterMemberService service;
	
	@RequestMapping(value="/member/Register.to")
	public String Register() {
		return "member/login/register.tiles1";
	}
	
/*	@RequestMapping(value = "/smstest.to")
	public String smstest() {
		
		return "member/login/smsTest";
	}*/
	
	/* 문자보내기 */
	@ResponseBody
    @RequestMapping(value = "/sendSms.to", method= {RequestMethod.POST})
	public String sendSms(String receiver, HttpSession session) throws Exception {
		int rand = (int) (Math.random() * 899999) + 100000;
    	session.setAttribute("rand", rand);

    	//String api_key = "test"; //api key
        //String api_secret = "test";  //api secret
        String api_key = MyUtilHM.coolKey(); //api key
        String api_secret = MyUtilHM.coolSecretKey();  //api secret
        com.center.sms.Coolsms coolsms = new com.center.sms.Coolsms(api_key, api_secret);

        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", receiver);

        params.put("from", "01086885219"); 
        params.put("text", "안녕하세요 으뜸문화센터 입니다. 인증번호 [" + rand + "] 를 화면에 입력해주세요."); 
        params.put("type", "sms");
        params.put("mode", "test");
        //문자메세지 확인용
        //System.out.println(params);

        JSONObject result = coolsms.send(params); 

        if ((boolean)result.get("status") == true) {
          return ""+rand;
        } else {

          System.out.println(result.get("code")); // REST API 에러코드
          //return "fail";
          return ""+rand;
        }
    }
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/* 아이디 중복검사 */
	@ResponseBody
    @RequestMapping(value = "/idCheck.to", method= {RequestMethod.GET})
	public String sendSms(HttpServletRequest request) throws Exception {
        String userid = request.getParameter("userid");
        int n = service.idCheck(userid);
        return ""+n;
    }
	
	/* 회원가입 */
	@RequestMapping(value = "/member/registerUser.to", method= {RequestMethod.POST})
	public ModelAndView registerUser(ModelAndView mav, HttpServletRequest request) {
		String userid = request.getParameter("userid");
		String userName = request.getParameter("userName");
		String userpwd = request.getParameter("userpwd");
		String ResidentNum1 = request.getParameter("ResidentNum1");
		String ResidentNum2 = request.getParameter("ResidentNum2");
		String celphone_no1 = request.getParameter("celphone_no1");
		String celphone_no2 = request.getParameter("celphone_no2");
		String celphone_no3 = request.getParameter("celphone_no3");
		String user_email = request.getParameter("user_email");
		String post_code = request.getParameter("post_code");
		String post_address1 = request.getParameter("post_address1");
		String post_address2 = request.getParameter("post_address2");
		String marketingEmail = request.getParameter("marketingEmail");
		String marketingSMS = request.getParameter("marketingSMS");
		String gender = ResidentNum2.substring(0, 1);
		if("1".equals(gender) || "3".equals(gender)) {
			gender = "M";
		}
		else if("2".equals(gender) || "4".equals(gender)) {
			gender = "F";
		}
		else {
			gender = "N";
		}

		if(marketingEmail == null) {
			marketingEmail = "N";
		}
		if(marketingSMS == null) {
			marketingSMS = "N";
		}
//		System.out.println("userName: " + userName);
//		System.out.println("userid: " + userid);
//		System.out.println("userpwd: " + userpwd);
//		System.out.println("ResidentNum1: " + ResidentNum1);
//		System.out.println("ResidentNum2: " + ResidentNum2);
//		System.out.println("celphone_no1: " + celphone_no1);
//		System.out.println("celphone_no2: " + celphone_no2);
//		System.out.println("celphone_no3: " + celphone_no3);
//		System.out.println("user_email: " + user_email);
//		System.out.println("post_code: " + post_code);
//		System.out.println("post_address1: " + post_address1);
//		System.out.println("post_address2: " + post_address2);
//		System.out.println("marketingEmail: " + marketingEmail);
//		System.out.println("marketingSMS: " + marketingSMS);
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("userid", userid);
		paraMap.put("userName", userName);
		paraMap.put("userpwd", SHA256.encrypt(userpwd));
		paraMap.put("ResidentNum1", ResidentNum1);
		paraMap.put("ResidentNum2", SHA256.encrypt(ResidentNum2));
		paraMap.put("celphone_no1", celphone_no1);
		paraMap.put("celphone_no2", celphone_no2);
		paraMap.put("celphone_no3", celphone_no3);
		paraMap.put("user_email", user_email);
		paraMap.put("post_code", post_code);
		paraMap.put("post_address1", post_address1);
		paraMap.put("post_address2", post_address2);
		paraMap.put("marketingEmail", marketingEmail);
		paraMap.put("marketingSMS", marketingSMS);
		paraMap.put("gender", gender);
		
		int n = service.registerUser(paraMap);
		String msg = "";
		String loc = request.getContextPath()+"/main.to";
		if(n==0) {
			msg = "회원가입에 실패했습니다. 고객센터에 문의하세요";
		}
		else {
			msg = "회원가입에 성공했습니다.";
		}
		mav.addObject("msg",msg);
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		return mav;
	}
	
	@RequestMapping(value="/login.to")
	public String login(HttpServletRequest request) {
		String newURL = request.getParameter("newURL");
		request.setAttribute("newURL", newURL);
		return "member/login/login.tiles1";
	}
	
	/* 로그인 체크 */
	@RequestMapping(value="/loginAction.to", method= {RequestMethod.POST})
	public ModelAndView loginAction(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		String userid = request.getParameter("userid");
		String userpwd = request.getParameter("userpwd");
		String newURL = request.getParameter("newURL");
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("userid", userid);
		paraMap.put("userpwd", SHA256.encrypt(userpwd));
		
		MemberVO loginuser = service.isExistUser(paraMap);
		String loc = "";
		
		if(loginuser==null) {
			String msg = "회원정보가 일치하지 않습니다.";
			/*loc = request.getContextPath()+"/login.to";*/
			loc = "javascript:history.back()";
			mav.addObject("msg",msg);
		}
		else {
			//마지막 로그인일자 갱신
			int n = service.setLoginday(loginuser.getUserno());

			if(session.getAttribute("gobackURL") != null)
				loc = (String)session.getAttribute("gobackURL");
			else 
				loc = newURL;
				//loc = request.getContextPath()+"/main.to";
			
			session.setAttribute("loginuser", loginuser);
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			
			// 오늘 날짜
			Date time = new Date();
			String sys = format.format(time);
			
			File file = new File("C:\\log\\Accesslog.txt");
	        FileWriter writer = null;
	        String country = (String)request.getHeader("accept-language");
	        country = country.substring(0,5);
	        try {
	            // 기존 파일의 내용에 이어서 쓰려면 true를, 기존 내용을 없애고 새로 쓰려면 false를 지정한다.
				String message = "[" + sys + "]" + "  ID: " + loginuser.getUserid() + " 님이 IP["+ request.getRemoteAddr() +
								 "] 에서 접속하셨습니다. 접속국가: "+ country + "\n" ;
	            writer = new FileWriter(file, true);
	            writer.write(message);
	            writer.flush();
	            
	        } catch(IOException e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                if(writer != null) writer.close();
	            } catch(IOException e) {
	                e.printStackTrace();
	            }
	        }
		}
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		return mav;
	}
	
	@RequestMapping(value="/logout.to")
	public String logout() {
		return "member/login/logout";
	}
	
	@RequestMapping(value="/pwdchange.to")
	public String requiredLogin_pwdChange(HttpServletRequest request, HttpServletResponse response) {
		return "member/login/pwdChange.tiles1";
	}
	

	/* 패스워드 변경 */
	@RequestMapping(value="/pwdCheck.to", method= {RequestMethod.POST})
	public ModelAndView requiredLogin_pwdCheck(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelAndView mav) {
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String oldPasswd = SHA256.encrypt(request.getParameter("inputOldPasswd"));
		String newPasswd = SHA256.encrypt(request.getParameter("inputNewPasswd1"));
		String msg = "";
		String loc = "";
		
		/* loginuser패스워드와 입력한 패스워드값 비교 */
		if(!oldPasswd.equals(loginuser.getUserpw())) {
			msg = "현재 비밀번호가 맞지 않습니다. 다시 입력해 주세요.";
			loc = "javascript:history.back();";
		}
		else {
			String userno = loginuser.getUserno();
			HashMap<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("userno", userno);
			paraMap.put("newPasswd", newPasswd);
			int n = service.setUserPwd(paraMap);
			
			if(n==0) {
				msg = "예상치 못한 오류로 변경하지 못했습니다. 고객센터로 문의해주세요.";
				loc = "javascript:history.back()";
			}
			else {
				msg = "비밀번호 변경이 완료되었습니다.";
				String userid = loginuser.getUserid();
				String userpwd = newPasswd;
				
				session.removeAttribute("loginuser");
				paraMap = new HashMap<String, String>();
				paraMap.clear();
				paraMap.put("userid", userid);
				paraMap.put("userpwd", userpwd);
				
				loginuser = service.isExistUser(paraMap);
				
				session.setAttribute("loginuser", loginuser);
				loc = request.getContextPath()+"/main.to";
			}
		}
		
		mav.addObject("loc",loc);
		mav.addObject("msg",msg);
		mav.setViewName("msg");
		
		return mav;
	}
	
	@RequestMapping(value="/editMyinfo.to")
	public String editMyinfo(HttpServletRequest request, HttpServletResponse response) {
		return "member/login/editMyinfo";
	}
	
	@RequestMapping(value="/editMyinfoAction.to", method= {RequestMethod.POST})
	public ModelAndView editMyinfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelAndView mav) {
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String celphone_no1 = request.getParameter("celphone_no1");
		String celphone_no2 = request.getParameter("celphone_no2");
		String celphone_no3 = request.getParameter("celphone_no3");
		String user_email = request.getParameter("user_email");
		String post_code = request.getParameter("post_code");
		String post_address1 = request.getParameter("post_address1");
		String post_address2 = request.getParameter("post_address2");
		String userno = loginuser.getUserno();
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("celphone_no1", celphone_no1);
		paraMap.put("celphone_no2", celphone_no2);
		paraMap.put("celphone_no3", celphone_no3);
		paraMap.put("user_email", user_email);
		paraMap.put("post_code", post_code);
		paraMap.put("post_address1", post_address1);
		paraMap.put("post_address2", post_address2);
		paraMap.put("userno", userno);
		
		int n = service.updateUser(paraMap);
		
		String msg = "";
		String loc = "";
		if(n==0) {
			msg = "정보변경에 실패했습니다. 고객센터에 문의하세요";
		}
		else {
			msg = "정보변경이 완료되었습니다.";
			
			String userid = loginuser.getUserid();
			String userpwd = loginuser.getUserpw();
			
			session.removeAttribute("loginuser");
			paraMap = new HashMap<String, String>();
			paraMap.clear();
			paraMap.put("userid", userid);
			paraMap.put("userpwd", userpwd);
			
			loginuser = service.isExistUser(paraMap);
			
			session.setAttribute("loginuser", loginuser);
			
		}
		loc = "javascript:self.close()";
		
		mav.addObject("msg",msg);
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		
		return mav;
	}
	
	@RequestMapping(value="/delUser.to")
	public ModelAndView delUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelAndView mav) {
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userno = loginuser.getUserno();
		
		int n = service.delUser(userno);
		String msg = "";
		String loc = "";
		
		if(n==0) {
			msg = "예상치 못한 오류로 실패했습니다. 고객센터에 문의해주세요";
		}
		else {
			msg = "탈퇴가 완료되었습니다.";
		}
		
		loc = request.getContextPath()+"/logout.to";
		
		mav.addObject("msg",msg);
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		return mav;
	}
	
	@RequestMapping(value="/findid.to")
	public String findid() {
		return "member/login/findid";
	}
	
	@RequestMapping(value="/findidAction.to")
	public String findidAction(HttpServletRequest request, ModelAndView mav) {
		String emailUsername = request.getParameter("find-email-user-name");
		String email = request.getParameter("email");
		String hpUsername = request.getParameter("find-hp-user-name");
		String hp1 = request.getParameter("hp1");
		String hp2 = request.getParameter("hp2");
		String hp3 = request.getParameter("hp3");
		HashMap<String, String> paraMap = new HashMap<String, String>();
		int status = 0;
		String userid = null;
		
		//이메일로 아이디 찾기
		if(email!="") {
			paraMap.put("emailUsername", emailUsername);
			paraMap.put("email", email);
			userid = service.findidByEmail(paraMap);
			if(userid!=null)
				status=1;
		}
		
		//휴대폰 번호로 아이디 찾기
		else {
			paraMap.put("hpUsername", hpUsername);
			paraMap.put("hp1", hp1);
			paraMap.put("hp2", hp2);
			paraMap.put("hp3", hp3);
			userid = service.findidByHp(paraMap);
			if(userid!=null)
				status=1;
		}
		request.setAttribute("userid", userid);
		request.setAttribute("status", status);
		return "member/login/findid";
	}
	
	@RequestMapping(value="/findpw.to")
	public String findpw(HttpServletRequest request) {
		String userid = request.getParameter("userid");
		String authCodehidden = request.getParameter("authCodehidden");
		String useridHidden1 = request.getParameter("useridHidden1");
		String useridHidden2 = request.getParameter("useridHidden2");
		String userno = request.getParameter("usernoHidden");
		String userpw = request.getParameter("userpw");
		String celphone_no1 = request.getParameter("celphone_no1");
		String celphone_no2 = request.getParameter("celphone_no2");
		String celphone_no3 = request.getParameter("celphone_no3");
		
		String msg = "";
		
		//첫번째 페이지 출력
		int status = 0;
		
		//두번째 페이지 출력
		if(userid!=null) {
			int n = service.idCheck(userid);
			if(n==0) {
				msg = "존재하지 않는 아이디 입니다.";
			}
			else {
				MemberVO memvo = service.getUserById(userid);
				status = 1;
				request.setAttribute("memvo", memvo);
			}
		}
		
		//세번째 페이지 출력
		if(authCodehidden!=null) {
			request.setAttribute("userno", userno);
			status = 2;
		}
		
		if(userpw!=null) {
			HashMap<String, String> paraMap = new HashMap<String, String>();
			userno = request.getParameter("usernoHidden2");
			paraMap.put("userid", useridHidden2);
			paraMap.put("userpw", SHA256.encrypt(userpw));
			paraMap.put("userno", userno);
			System.out.println(userno);
			int n = service.updatePW(paraMap);
			
			if(n==1) {
				msg = "비밀번호 변경이 완료되었습니다.";
			}
			else {
				msg = "비밀번호 변경에 실패했습니다. 고객센터로 문의해주세요.";
			}
			
			status = 3;
		}
		
		request.setAttribute("useridHidden1", useridHidden1);
		request.setAttribute("msg", msg);
		request.setAttribute("status", status);
		request.setAttribute("userid", userid);
		return "member/login/findpw";
	}
	
	
}
