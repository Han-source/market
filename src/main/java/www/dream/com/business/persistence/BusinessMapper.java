package www.dream.com.business.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import www.dream.com.bulletinBoard.model.BoardVO;
import www.dream.com.bulletinBoard.model.PostVO;
import www.dream.com.business.model.ProductVO;
import www.dream.com.business.model.TradeConditionVO;

public interface BusinessMapper {

	/* 상품 상세 조회 기능 */
	public ProductVO findPriceById(@Param("productId") String id); // id와 childId를 통해 조회

	/* 경매 상세 조회 기능 */
	public TradeConditionVO findAuctionPriceById(@Param("productId") String id);

	/* 경매 참여자 목록 조회 */
	public List<TradeConditionVO> findAuctionPartyById(@Param("productId") String id);

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
}
