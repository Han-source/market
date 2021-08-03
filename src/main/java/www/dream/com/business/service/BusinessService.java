package www.dream.com.business.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.dream.com.bulletinBoard.model.BoardVO;
import www.dream.com.bulletinBoard.model.PostVO;
import www.dream.com.bulletinBoard.persistence.ReplyMapper;
import www.dream.com.business.model.ProductVO;
import www.dream.com.business.model.TradeConditionVO;
import www.dream.com.business.model.TradeVO;
import www.dream.com.business.persistence.BusinessMapper;
import www.dream.com.common.attachFile.model.AttachFileVO;
import www.dream.com.common.attachFile.persistence.AttachFileVOMapper;

@Service
public class BusinessService {

   @Autowired
   private BusinessMapper businessMapper;

   @Autowired
   private AttachFileVOMapper attachFileVOMapper;

   /* 상품id를 통한 product 정보 검색 */
   public ProductVO findPriceById(String id) {
      return businessMapper.findPriceById(id);
   }

   /* 상품id를 통한 tradeCondition 정보 검색 */
   public TradeConditionVO findAuctionPriceById(String id) {
      return businessMapper.findAuctionPriceById(id);
   }

   /* 상품id를 통한 경매 참여자 정보 검색 */
   public List<TradeConditionVO> findAuctionPartyById(String id) {
      return businessMapper.findAuctionPartyById(id);
   }
   
   /* 상품 차트 기능 */ 
   public List<TradeConditionVO> lookChartProduct(String postId) {
      return businessMapper.lookChartProduct(postId);
   }

   /* 경매 가격의 최대값 비교 */
   public int findMaxBidPrice(String productId) {
      return businessMapper.findMaxBidPrice(productId);
   }
   
   /* 안전거래에서 해당 이용자가 네고한 적이 있는지를 가져오는 함수 */
   public TradeConditionVO findNegoPriceByBuyerWithProductId(String productId, TradeConditionVO tc) {
      return businessMapper.findNegoPriceByBuyerWithProductId(productId, tc);
   }

   public void insertAuctionPrice(PostVO post,TradeConditionVO tradeCondition, BoardVO board) {
      businessMapper.insertAuctionPrice(post, tradeCondition, board);
   }

   /* 일반 상품 등록 기능 */
   @Transactional
   public void insertCommonProduct(ProductVO productVO, PostVO post, BoardVO board) {
      int affectedRows = businessMapper.insertCommonProduct(productVO, post, board);
      List<AttachFileVO> listAttach = post.getListAttach();
      if (listAttach != null && !listAttach.isEmpty()) {
         attachFileVOMapper.insertAttachFile2ProductId(post.getId(), listAttach);
      }
   }

   /* 경매 상품 등록 가능 */
   @Transactional
   public void insertAuctionProduct(ProductVO productVO, PostVO post, TradeConditionVO tradeCondition, BoardVO board) {
      int affectedRows = businessMapper.insertAuctionProduct(productVO, post, tradeCondition, board);
      List<AttachFileVO> listAttach = post.getListAttach();
      if (listAttach != null && !listAttach.isEmpty()) {
         attachFileVOMapper.insertAttachFile2ProductId(post.getId(), listAttach);
      }
   }

   /* 상품 네고 기능 */
   public void insertNegoProductPrice2Buyer(TradeConditionVO tradeCondition, String postId, PostVO post) {
      businessMapper.insertNegoProductPrice2Buyer(tradeCondition, postId, post);
   }

   /* 장바구니 담기 기능 */
   public void insertShopphingCart(String userId, String productId) {
      businessMapper.insertShopphingCart(userId, productId);
   }
   /* 해당 상품을 내가 장바구니에 이미 담았는지를 검사 */
   public int findShoppingCartByUserIdAndProductId(String userId, String productId) {
      return businessMapper.findShoppingCartByUserIdAndProductId(userId, productId); 
   }
   
   /* 결제가 완료 되면 결제 테이블에 값 담기 */
   public void purchaseProduct(TradeVO trade) {
      businessMapper.purchaseProduct(trade);
   }


}