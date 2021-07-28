package www.dream.com.business.model;

import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TradeConditionVO {
	private String sellerId;
    private String buyerId;
    private String tradeId;
    private String productId;
    private int discountPrice;
    private int auctionCurrentPrice;
    private Date auctionStartDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime auctionEndDate;
}
