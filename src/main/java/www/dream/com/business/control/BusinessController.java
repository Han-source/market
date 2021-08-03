package www.dream.com.business.control;

import java.io.IOException;
import java.math.BigDecimal;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import www.dream.com.bulletinBoard.model.BoardVO;
import www.dream.com.bulletinBoard.model.PostVO;
import www.dream.com.bulletinBoard.service.BoardService;
import www.dream.com.bulletinBoard.service.PostService;
import www.dream.com.bulletinBoard.service.ReplyService;
import www.dream.com.business.model.ProductVO;
import www.dream.com.business.model.TradeConditionVO;
import www.dream.com.business.model.TradeVO;
import www.dream.com.business.service.BusinessService;
import www.dream.com.common.dto.Criteria;
import www.dream.com.framework.springSecurityAdapter.CustomUser;
import www.dream.com.party.model.Party;

@Controller
@RequestMapping("/business/*")
public class BusinessController {

	@Autowired
	private BusinessService businessService;

	@Autowired
	private ReplyService replyService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private PostService postService;

	@GetMapping(value = "productList") // LCRUD 에서 L:list
	public void listBySearch(@RequestParam("boardId") int boardId, @RequestParam("child") int child,
			@ModelAttribute("pagination") Criteria userCriteria, @AuthenticationPrincipal Principal principal,
			Model model) {
		Party curUser = null;
		if (principal != null) {
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
			model.addAttribute("userId", curUser.getUserId());
		}

		// model.addAttribute("listPost", postService.getListByHashTag(curUser, boardId,
		// child, userCriteria));
		model.addAttribute("boardId", boardId);
		model.addAttribute("child", child);
		model.addAttribute("boardName", boardService.getBoard(boardId).getName());
		model.addAttribute("childBoardList", boardService.getChildBoardList(4));
		model.addAttribute("childBoardName", boardService.getChildBoard(boardId, child).getName());
		model.addAttribute("productList", postService.findProductByBoardId(boardId, child));
		model.addAttribute("boardList", boardService.getList());
		userCriteria.setTotal(postService.getSearchTotalCount(boardId, userCriteria));
	}

	@GetMapping(value = "readProduct")
	public void findProductById(@RequestParam("boardId") int boardId, String productId,
			@RequestParam("child") int child, Model model, @AuthenticationPrincipal Principal principal) {
		Party curUser = null;
		if (principal != null) {
			TradeConditionVO newProductCondition = new TradeConditionVO();
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
			newProductCondition.setBuyerId(curUser.getUserId());
			model.addAttribute("userId", curUser.getUserId());
			TradeConditionVO  a = businessService.findNegoPriceByBuyerWithProductId(productId, newProductCondition);
			model.addAttribute("negoBuyer",
					businessService.findNegoPriceByBuyerWithProductId(productId, newProductCondition));
			model.addAttribute("checkShoppingCart",
					businessService.findShoppingCartByUserIdAndProductId(curUser.getUserId(), productId));
		}

		model.addAttribute("boardList", boardService.getList());
		model.addAttribute("post", replyService.findProductById(productId, child));
		model.addAttribute("product", businessService.findPriceById(productId));
		model.addAttribute("condition", businessService.findAuctionPriceById(productId));
		model.addAttribute("auctionParty", businessService.findAuctionPartyById(productId));
		model.addAttribute("boardId", boardId);
		model.addAttribute("child", child);
		model.addAttribute("tc", businessService.lookChartProduct(productId));
		model.addAttribute("maxBidPrice", businessService.findMaxBidPrice(productId));
	}

	@PostMapping(value = "readProduct")
	@PreAuthorize("isAuthenticated()")
	public String findProductById(@RequestParam("boardId") int boardId, @RequestParam("child") int child,
			TradeConditionVO tradeCondition, PostVO newPost, @RequestParam("postId") String postId,
			RedirectAttributes rttr) {
		BoardVO board = new BoardVO(boardId, child);

		newPost.setId(postId);
		businessService.insertAuctionPrice(newPost, tradeCondition, board);
		return "redirect:/business/readProduct?boardId=" + boardId + "&child=" + child + "&productId=" + postId;
	}

	@GetMapping(value = "registerProduct") // LCRUD 에서 Create 부분
	@PreAuthorize("isAuthenticated()") // 현재 사용자가 로그인 처리 했습니까?
	public void registerPost(@RequestParam("boardId") int boardId, @RequestParam("child") int child, Model model,
			final TradeConditionVO tradeCondition) {
		if (tradeCondition.getAuctionEndDate() == null) {
			tradeCondition.setAuctionEndDate(LocalDateTime.now());
		}
		model.addAttribute("child", child);
		model.addAttribute("boardId", boardId);
		model.addAttribute("childBoardList", boardService.getChildBoardList(4));
	}

	@PostMapping(value = "registerProduct") // LCRUD 에서 Update 부분
	@PreAuthorize("isAuthenticated()")
	public String registerPost(@AuthenticationPrincipal Principal principal, @RequestParam("boardId") int boardId,
			@RequestParam("child") int child, int productPrice, TradeConditionVO tradeCondition, String postId,
			PostVO newPost, RedirectAttributes rttr) throws IOException {
		newPost.parseAttachInfo();
		newPost.setId(postId);
		// boardId = 4
		// child = 567
		BoardVO board = new BoardVO(boardId, child);
		ProductVO productVO = new ProductVO();
		productVO.setProductPrice(productPrice);
		UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
		CustomUser cu = (CustomUser) upat.getPrincipal();
		Party writer = cu.getCurUser();
		newPost.setWriter(writer);
		if (child == 7) {
			businessService.insertAuctionProduct(productVO, newPost, tradeCondition, board);
		} else {
			businessService.insertCommonProduct(productVO, newPost, board);

		}

		rttr.addFlashAttribute("result", newPost.getId());
		return "redirect:/business/productList?boardId=" + boardId + "&child=" + child;
	}

	@PostMapping(value = "insertShoppingCart") // LCRUD 에서 Update 부분
	@PreAuthorize("isAuthenticated()")
	public String insertShoppingCart(String productId, @AuthenticationPrincipal Principal principal,
			@RequestParam("boardId") int boardId, @RequestParam("child") int child) {
		Party curUser = null;
		if (principal != null) {
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
		}

		businessService.insertShopphingCart(curUser.getUserId(), productId);
		return "redirect:/business/readProduct?boardId=" + boardId + "&child=" + child + "&productId=" + productId;
	}

	private IamportClient api;

	@GetMapping("/user/mypage/charge/point") // LCRUD 에서 Update 부분
	public @ResponseBody void purchaseKaKao(@AuthenticationPrincipal Principal principal, Long amount) {
		this.api = new IamportClient("3452420157053319",
				"DXI0XVlgpUwS8B3Hj9cFxozTrGn6CXmfU4fS0B8pvFhDglkzvxe3VNXnukt7hPmcUC4UddkJSCn9XIJt");
		Party curUser = null;
		if (principal != null) {
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
		}
		TradeVO newTrade = new TradeVO();
		newTrade.setBuyerId(curUser.getUserId());
	}

	@RequestMapping(value = "/orderCompleteMobile", produces = "application/text; charset=utf8", method = RequestMethod.GET)
	public String orderCompleteMobile(@RequestParam(required = false) String imp_uid,
			@RequestParam(required = false) String merchant_uid, Model model, Locale locale, HttpSession session)
			throws IamportResponseException, IOException {
		IamportResponse<Payment> result = api.paymentByImpUid(imp_uid);
		// 결제 가격과 검증결과를 비교한다.
		if (result.getResponse().getAmount().compareTo(BigDecimal.valueOf(100)) == 0) {
			System.out.println("검증통과");
		}
		return "home";
	}

}