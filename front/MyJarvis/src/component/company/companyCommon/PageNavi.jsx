import "./PageNavi.css";

//목록 하단 페이지네비게이션 제작 컴포넌트
export default function PageNavi(props){

    const pageInfo = props.pageInfo;        //페이지 네비게이션 정보
    const reqPage = props.reqPage;          //요청 페이지
    const setReqPage = props.setReqPage;    //요청 페이지 변경 호출 함수

    const pageArr = new Array();            //페이지 네비게이션 JSX를 저장할 배열

    // << 제일 앞 페이지로 이동
    pageArr.push (
        <li key="first-page">
            <span className="page-item page-arrow material-symbols-outlined" onClick={function(){
                setReqPage(1);
            }}>
                keyboard_double_arrow_left
            </span>
        </li>
    );

    // < 이전 페이지로 이동
    pageArr.push (
        <li key="prev-page">
            <span className="page-item page-arrow material-symbols-outlined" onClick={function(){
                
                if(reqPage > 1){
                setReqPage(reqPage-1);
                }        

            }}>
                chevron_left
            </span>
        </li>
    )

    // 1 2 3 4 5 페이징 숫자 제작
    let pageNo = pageInfo.pageNo;   //페이지 시작 번호
    for(let i=0; i<pageInfo.pageNaviSize; i++){
        pageArr.push(
            <li key={"page"+i}>
                <span className={"page-item page-number" + (pageNo == reqPage ? " active-page" : "")} onClick={function(e){
                    setReqPage(Number(e.target.innerText));
                }}>
                    {pageNo}
                </span>
            </li>
        );

        pageNo++;

        //항상 pageNaviSize만큼 제작하지 않고, 게시글 전부 출력되었으면 Stop
        if(pageNo > pageInfo.totalPage){
            break;
        }
    }

    // > 다음 페이지로 이동
    pageArr.push(
        <li key="next-page">
            <span className="page-item page-arrow material-symbols-outlined" onClick={function(){
                if(reqPage < pageInfo.totalPage){
                    setReqPage(reqPage+1);
                }
            }}>
                chevron_right
            </span>
        </li>  
    );

    // >> 제일 마지막 페이지로 이동
    pageArr.push(
        <li key="last-page">
            <span className="page-item page-arrow material-symbols-outlined" onClick={function(){
                setReqPage(pageInfo.totalPage);
            }}>
                keyboard_double_arrow_right
            </span>
        </li>
    );


    return (
        <ul className="pagination">
            {pageArr}
        </ul>
    )
}