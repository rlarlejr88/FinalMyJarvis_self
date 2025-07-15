package kr.or.iei.common.util;

import org.springframework.stereotype.Component;

import kr.or.iei.common.model.dto.PageInfo;

@Component
public class PageUtil {
	
	public PageInfo getPageInfo(int reqPage, 	//요청 페이지 번호
								int viewCnt,		//한 페이지에 보여줄 게시글 갯수	
								int pageNaviSize,	//페이지 네비게이션 크기
								int totalCount		//전체 게시글 갯수
							   ) {
		    int end = reqPage * viewCnt;		//마지막 번호
		    int start = end - viewCnt + 1;		//시작 번호
		    
		    //전체 페이지 수
		    /*
		     * totalCount : 30
		     * viewCnt : 12
		     * 
		     * totalCount / (double) viewCnt
		     *       30   /  12.0
		     *       30.0 /  12.0  => 2.5
		     *       
		     * Math.ceil(2.5) => 3.0 => 3
		     * 
		     */
		     
		    int totalPage = (int) Math.ceil(totalCount / (double) viewCnt);
		    
		    //시작 페이지 번호
		    int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		    
		    return new PageInfo(start, end, pageNo, pageNaviSize, totalPage);
		
	}

}
