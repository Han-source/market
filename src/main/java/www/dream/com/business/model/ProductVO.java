package www.dream.com.business.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.bulletinBoard.model.BoardVO;
import www.dream.com.framework.printer.ClassPrintTarget;

@Data
@NoArgsConstructor // 여기서도 생성자를 강제로 만들거기 때문에
@ClassPrintTarget
public class ProductVO extends BoardVO{
	public static final String DESCRIM4POST = "product";
	
	private String productId;
	private String userId;
	private int productPrice;
	private String discrim;
	
	
}
