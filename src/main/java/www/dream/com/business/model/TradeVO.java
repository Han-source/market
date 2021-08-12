package www.dream.com.business.model;

import java.util.Date;

import lombok.Data;

@Data
public class TradeVO {
	private String tradeId;
	private String productId;
	private int productFinalPrice;
	private String sellerId;
	private String buyerId;
	private Date tradeDate;
}
