package www.dream.com.chat.control;

import java.io.IOException;
import java.net.URLDecoder;
import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import www.dream.com.bulletinBoard.model.PostVO;
import www.dream.com.business.model.TradeConditionVO;
import www.dream.com.business.service.BusinessService;
import www.dream.com.chat.model.ChatVO;
import www.dream.com.chat.service.ChatMethode;
import www.dream.com.chat.service.ChatService;
import www.dream.com.framework.springSecurityAdapter.CustomUser;
import www.dream.com.party.model.Party;

@Controller
@RequestMapping("/chat/*")
public class ChatController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Autowired // 10. Autowired @ 생성
	private ChatService chatService;

	@Autowired // 10. Autowired @ 생성
	private ChatMethode chatMethode;
	@Autowired
	private BusinessService businessService;

	// --------------------------채팅방 내용 조회-----------------------------------
	@ResponseBody
	@PostMapping(value = "chatList", produces = ("text/html; charset=UTF-8"))
	protected String chatList(ChatVO chat, Model model,
			@AuthenticationPrincipal Principal principal){
		Party curUser = getPrincipal(principal);
		if (chat.getFromID() == null || chat.getFromID().equals("") || chat.getToID() == null || chat.getToID().equals("")) {
			return "";
		} else {
			try {
				return chatMethode.getChatList(chat, curUser);
			} catch (Exception e) {
				return "";
			}
		}
	}



	private Party getPrincipal(Principal principal) {
		Party curUser = null;
		if (principal != null) {
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
		}
		return curUser;
	}

	

	// --------------------------채팅방 내용띄우기 및 채팅 내용
	// 저장-----------------------------------
	@GetMapping(value = "chatting")
	public void sendChat(@RequestParam("toId") String toId, @AuthenticationPrincipal Principal principal, Model model) {
		Party curUser = getPrincipal(principal);
		model.addAttribute("userId", curUser.getUserId());
		model.addAttribute("toId", toId);
	}

	@ResponseBody
	@PostMapping(value = "chatting", produces = ("text/html; charset=UTF-8"))
	public String sendChat(@RequestParam(value = "toId", required = false) String toId, ChatVO chat, Model model,
			@AuthenticationPrincipal Principal principal){
		Party curUser = getPrincipal(principal);
		if(curUser != null) {
			chat.setFromID(curUser.getUserId());
		}
		if(chat.getFromID() == null || chat.getFromID().equals("") || chat.getToID() == null || chat.getToID().equals("")
				|| chat.getChatContent() == null || chat.getChatContent().equals("")) {
			return "0";
			// 자기 자신에게 메시지를 보낸경우 -1 출력하여 오류를 나타냄
		} else if(chat.getFromID().equals(chat.getToID())) {
			return "-1";
		}
		else {
			return chatService.submit(chat) + "";
		}
	}

	// --------------------------채팅목록 띄우기-----------------------------------
	@GetMapping(value = "chatBox")
	public void chatBox(@AuthenticationPrincipal Principal principal, Model model, ChatVO chatvo) {
		Party curUser = getPrincipal(principal);
		model.addAttribute("userId", curUser.getUserId());
	}

	@ResponseBody
	@PostMapping(value = "chatBox", produces = ("text/html; charset=UTF-8"))
	protected String chatBox(ChatVO chat, Model model, @AuthenticationPrincipal Principal principal) {
		Party curUser = null;
		if (principal != null) {
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
		}
		String userId = null;
		if (curUser == null) {
			return "";
		}else {
			userId = curUser.getUserId();
		}
		// 특정 사용자(userID) 아이디 값을 매개변수로 받는다.
		// 넘어온 사용자 아이디 값이 존재하지 않는다면
		if (userId == null || userId.equals("")) {
			// 0이라는 값을 출력하여 클라이언트에게 오류가 발생하였다는 것을 알려준다.
			return "";
		} else {
			try {
				// userID를 인자로 받아 특정 사용자의 메시지함을 출력
				return chatMethode.getChatBox(userId);
			} catch (Exception e) {
				// 공백으로 예외 처리
				return "";
			}
		}
	}

	

	// ---------------------------안읽은 메시지개수 가져오기------------------------------------
	@GetMapping(value = "unread")
	public void unreadChat(@AuthenticationPrincipal Principal principal, Model model, ChatVO chatvo) {
		Party curUser = getPrincipal(principal);
		model.addAttribute("unread", chatService.getUnreadChat(curUser.getUserId()));
		model.addAttribute("userId", curUser.getUserId());
	}

	@ResponseBody
	@PostMapping(value = "unread", produces = ("text/html; charset=UTF-8"))
	public String unreadChat(@AuthenticationPrincipal Principal principal) {
		
		// 특정 사용자(userID) 아이디 값을 매개변수로 받는다.
		Party curUser = null;
		if (principal != null) {
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
		}
		String userId = null;
		if (curUser == null) {
			return null;
		}else {
			userId = curUser.getUserId();
		}
		// 넘어온 사용자 아이디 값이 존재하지 않는다면
		userId = userId.trim();
		int test = chatService.getUnreadChat(userId);
		if (userId == null || userId.equals("") || chatService.getUnreadChat(userId) == 0) {
			// 0이라는 값을 출력하여 클라이언트에게 오류가 발생하였다는 것을 알려준다.
			return "0";
		} else {
			// ChatDAO에 정의된 AllUnreadChat에 userID를 문자열로 바꾸어서 출력한다.
			// 즉 읽지 않은 채팅 수를 클라이언트에게 출력해주는 부분.
			return chatService.getUnreadChat(userId) + "";
		}
	}
	
	/*------------------------거래수락시 실행할 함수---------------------------------------*/
	@ResponseBody
	@PostMapping(value = "agreeNegoSug", produces = ("text/html; charset=UTF-8"))
	public void agreeNegoSug(@RequestParam(value = "toId", required = false) String toId, ChatVO chat, Model model,
			@AuthenticationPrincipal Principal principal, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Party curUser = getPrincipal(principal);
		chat.setFromID(curUser.getUserId());
		String fromID = curUser.getUserId();
		String toID = chat.getToID();
		String chatContent = request.getParameter("chatContent");
		String postId = request.getParameter("postId");
		String agree = request.getParameter("agree");
		PostVO newPost = new PostVO(); 
		
		
		UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
	    CustomUser cu = (CustomUser) upat.getPrincipal();
	    Party writer = cu.getCurUser();
	    newPost.setWriter(writer);
		TradeConditionVO tradeCondition = new TradeConditionVO();
		if (agree != null) {
			tradeCondition.setBuyerId(toID);
			String str[] = chatContent.split("<");
			int i = Integer.parseInt(str[0]);
			tradeCondition.setDiscountPrice(i);
			businessService.insertNegoProductPrice2Buyer(tradeCondition, postId, newPost);
			response.getWriter().write("0");
		}
		if (postId != null) {
			chatService.deleteSugChat(chat, postId);
		}
		
	}
}