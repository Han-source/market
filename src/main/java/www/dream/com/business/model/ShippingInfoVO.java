package www.dream.com.business.model;

import java.util.Date;

import lombok.Data;

@Data
public class ShippingInfoVO extends TradeVO {
	private String address;
	private int phonNum;
	private int reserveNum;
	private String absentMsg;
}
