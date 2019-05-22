package jenkim49.jumun;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import jenkim49.jumundetail.JumunDetail;
import jenkim49.jumundetail.JumunDetailDao;


public class JumunDaoImplMain {

	public static void main(String[] args) throws Exception {
		System.out.println("----------Spring Container 초기화시작-----------");
		ApplicationContext applicationContext=new ClassPathXmlApplicationContext("classpath:spring/application-config.xml");
		System.out.println("----------Spring Container 초기화끝-----------");
		JumunDao jumunDao=(JumunDao)applicationContext.getBean("jumunDao");
		JumunDetailDao jdDao=(JumunDetailDao)applicationContext.getBean("jumunDetailDao");
		ArrayList<JumunDetail> jumunDetailList = new ArrayList<JumunDetail>();
		/*
		 jd_no	NUMBER	PK	주문상품번호	20
		 jd_item_qty	NUMBER		상품별수량	10
		 jd_items_price	NUMBER		상품별총가격	10
		 j_no	NUMBER	FK	주문번호	20
		 p_no	NUMBER	FK	상품번호	10	
		 INSERT INTO JUMUN_DETAIL VALUES(JUMUNDETAIL_NO_SEQ.NEXTVAL,?,?,?,?
		 */
		
		jumunDetailList.add(new JumunDetail(-999, 1, 142000, -999, 1));
		jumunDetailList.add(new JumunDetail(-999, 2, 250000, -999, 2));
		jumunDetailList.add(new JumunDetail(-999, 1, 170000, -999, 3));
		jumunDetailList.add(new JumunDetail(-999, 2, 340000, -999, 4));
		Jumun jumun = new Jumun(-999, "DO SON 외 3종", 6, 900000, new java.sql.Date(System.currentTimeMillis()), "jenkim49", jumunDetailList);
		System.out.println(jumunDao.jumun_insert_directly(jumun));
		
		//System.out.println(jumunDao.jumun_readAll());
		//System.out.println(jumunDao.jumun_readId("jenkim49"));
		
		
		
	}

}
