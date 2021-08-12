package www.dream.com.business.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import www.dream.com.bulletinBoard.model.BoardVO;
import www.dream.com.bulletinBoard.model.PostVO;
import www.dream.com.business.model.ProductVO;
import www.dream.com.business.model.ShippingInfoVO;
import www.dream.com.business.model.TradeConditionVO;
import www.dream.com.business.model.TradeVO;

public interface BusinessMapper {

	/* 상품 상세 조회 기능 */
	public ProductVO findPriceById(@Param("productId") String id); // id와 childId를 통해 조회

	/* 경매 상세 조회 기능 */
	public TradeConditionVO findAuctionPriceById(@Param("productId") String id);

	/* 경매 참여자 목록 조회 */
	public List<TradeConditionVO> findAuctionPartyById(@Param("productId") String id);

	/* 상품 차트 보는 기능 */
	public List<TradeConditionVO> lookChartProduct(@Param("productId") String productId);

	/* 경매 가격의 최대값 비교 */
	public TradeConditionVO findMaxBidPrice(@Param("productId") String productId);
	
	/* 안전거래에서 해당 이용자가 네고한 적이 있는지를 가져오는 함수 */
	public TradeConditionVO findNegoPriceByBuyerWithProductId(@Param("productId") String productId, @Param("tc") TradeConditionVO tc);
	/* 해당 상품을 내가 장바구니에 이미 담았는지를 검사 */
	public int findShoppingCartByUserIdAndProductId(@Param("userId") String userId, @Param("productId") String productId);
	/* 일반 상품 등록 기능 */
	public int insertCommonProduct(@Param("productVO") ProductVO productVO, @Param("post") PostVO post,
			@Param("board") BoardVO board);

	/* 경매 상품 등록 가능 */
	public int insertAuctionProduct(@Param("productVO") ProductVO productVO, @Param("post") PostVO post,
			@Param("tradeCondition") TradeConditionVO tradeCondition, @Param("board") BoardVO board);
	
	/*경매 입찰자 등록 가능*/
	public int insertAuctionPrice(@Param("post") PostVO post, @Param("tradeCondition") TradeConditionVO tradeCondition,  @Param("board") BoardVO board);
	
	/* 상품 네고 기능 */
	public void insertNegoProductPrice2Buyer(@Param("tradeCondition") TradeConditionVO tradeCondition,
			@Param("postId") String postId, @Param("post") PostVO post);
	
	/* 장바구니 담기 기능 */
	public void insertShopphingCart(@Param("userId") String userId, @Param("productId") String productId);
	
	/* 결제가 완료 되면 결제 테이블에 값 담기 */
	public void purchaseProduct(@Param("shippingInfo") ShippingInfoVO shippingInfo);
	
	/* 결제가 완료 되면 selled에 +1 하는 기능 */
	   public int selledProdut(@Param("productId") String productId);
}
