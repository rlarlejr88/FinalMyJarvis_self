import { useState } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Swal from "sweetalert2";
import { useNavigate } from "react-router-dom";
import createInstance from "../../axios/interceptor";
import './Join.css';

export default function Join() {

    //.env에 저장된 환경변수 값 가져오기
    const serverUrl = import.meta.env.VITE_BACK_SERVER;

    //인터셉터에서 커스터마이징한 axiosInstance 사용
    const axiosInstance = createInstance();

    //각 입력 값 변경 시, 저장 변수
    const [member, setMember] = useState({
        memberId: "",
        memberPw: "",
        memberName: "",
        memberEmail: "",
        memberPhone: ""
    });

    //아이디, 비밀번호, 이름, 전화번호 onChange 호출 함수
    function chgMember(e) {
        member[e.target.id] = e.target.value;
        setMember({ ...member })
    }
    //비밀번호 확인 값 변경 시, 저장 변수 (서버에 전송 X)
    const [memberPwRe, setMemberPwRe] = useState('');


    //비밀번호 확인 값 onChagne 호출 함수
    function chgMemberPwRe(e) {
        setMemberPwRe(e.target.value);
    }

    //아이디 유효성 체크
    const [idChk, setIdChk] = useState(0);

    const [emailChk, setEmailChk] = useState(0);

    function checkMemberEmail() {
        const regExp = /^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!regExp.test(member.memberEmail)) {
            setEmailChk(2); // 이메일 형식 오류
        } else {
            // 중복 체크 API 호출
            let options = {};
            options.url = serverUrl + "/member/" + encodeURIComponent(member.memberEmail) + "/chkEmail";
            options.method = 'get';

            axiosInstance(options)
                .then(function (res) {
                    if (res.data.resData == 1) {
                        setEmailChk(3); // 중복 있음
                    } else if (res.data.resData == 0) {
                        setEmailChk(1); // 중복 없음
                    }
                })
                .catch(function (err) {
                    console.log(err);
                });
        }
    }
    function checkMemberId(e) {
        //아이디 표현식
        const regExp = /^[a-zA-Z0-9]{8,20}$/;

        if (!regExp.test(member.memberId)) {
            //유효성 검증 실패일때
            setIdChk(2);
        } else {
            //유효성 검증 성공일때 DB에 중복된 아이디가 존재하는지 체크하기 위해 서버 아이디 전달하여 중복체크 
            let options = {};
            options.url = serverUrl + "/member/" + member.memberId + "/chkId";
            options.method = 'get';

            axiosInstance(options)
                .then(function (res) {
                    if (res.data.resData == 1) {
                        //중복된 아이디가 존재하는 경우
                        setIdChk(3);
                    } else if (res.data.resData == 0) {
                        //중복된 아이디가 존재하지 않는 경우
                        setIdChk(1);
                    }

                })
                .catch(function (err) {
                    console.log(err);
                });

        }
    }

    //비밀번호 검증 결과,검사 이전 상태
    const [pwChk, setPwChk] = useState(0);

    //비밀번호, 비밀번호 확인 값 onBlur 함수
    function chkMemberPw(e) {
        //비밀번호 정규 표현식
        const regExp = /^[a-zA-Z0-9!@#$]{6,30}$/; //영어 대/소문자, 특수문자, 숫자 6~30글자

        if (e.target.id == 'memberPw') { //비밀번호 입력

            if (!regExp.test(e.target.value)) {
                //비밀번호 유효성 체크 실패
                setPwChk(2);
            } else if (memberPwRe != '') { //비밀번호 확인 입력된 경우

                if (e.target.value == memberPwRe) { //비밀번호 == 비밀번호 확인
                    setPwChk(1); //유효성 검사 통과 + 비밀번호 일치
                } else {
                    setPwChk(3); //비밀번호와 확인값 불일치
                }
            } else { //비밀번호는 유효성 검증 통과 && 비밀번호 확인이 입력되지 않은 경우
                setPwChk(3); //비밀번호와 확인값 불일치
            }


        } else { //비밀번호 확인 입력 
            if (member.memberPw == e.target.value) { //비밀번호 == 비밀번호 확인

                if (regExp.test(member.memberPw)) { //비밀번호 유효성 검증 통과
                    setPwChk(1);//유효성 검사 통과 + 비밀번호 일치
                }
            } else {
                setPwChk(3); //비밀번호와 확인값 불일치
            }
        }
    }

    //회원가입 정상 처리 후, 컴포넌트 전환
    const navigate = useNavigate();


    //회원가입 처리 함수
    async function join() {
        const regId = /^[a-zA-Z0-9]{8,20}$/;
        const regPw = /^[a-zA-Z0-9!@#$]{6,30}$/;
        const regEmail = /^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (
            !regId.test(member.memberId) ||
            !regPw.test(member.memberPw) ||
            member.memberPw !== memberPwRe ||
            !regEmail.test(member.memberEmail)
        ) {
            Swal.fire({
                title: '알림',
                text: '입력값 형식이 올바르지 않거나 비밀번호가 일치하지 않습니다.',
                icon: 'warning',
                confirmButtonText: '확인'
            });
            return;
        }

        try {
            // 이메일 중복 체크
            const emailRes = await axiosInstance.get(serverUrl + `/member/${encodeURIComponent(member.memberEmail)}/chkEmail`);
            if (emailRes.data.resData === 1) {
                Swal.fire({
                    title: '알림',
                    text: '이미 사용 중인 이메일입니다.',
                    icon: 'warning'
                });
                return;
            }

            // 아이디 중복 체크
            const idRes = await axiosInstance.get(serverUrl + `/member/${member.memberId}/chkId`);
            if (idRes.data.resData === 1) {
                Swal.fire({
                    title: '알림',
                    text: '이미 사용 중인 아이디입니다.',
                    icon: 'warning'
                });
                return;
            }

            // 모든 유효성 검사를 통과했을 경우 → 회원가입 요청
            const options = {
                url: serverUrl + '/member',
                method: 'post',
                data: member
            };

            const res = await axiosInstance(options);

            Swal.fire({
                title: '알림',
                text: res.data.clientMsg,
                icon: res.data.alertIcon,
                confirmButtonText: '확인'
            }).then(() => {
                if (res.data.resData) {
                    navigate('/login');
                }
            });

        } catch (err) {
            console.error('회원가입 중 에러:', err);
            Swal.fire({
                title: '에러',
                text: '회원가입 중 문제가 발생했습니다.',
                icon: 'error'
            });
        }
    }


            // 회원가입시 중복 체크 과정에서 0으로 계속 남아 회원가입 불가
    // function join() {
    //     if (idChk == 1 && pwChk == 1 && emailChk === 1) { //아이디와 비밀번호 입력했을때

    //         let options = {};
    //         options.url = serverUrl + '/member';
    //         options.method = 'post';
    //         options.data = member;
    //         /* res.data == ResponseDTO
    //            res.data.resData == 회원가입 결과 (true or false)
    //            res.data.clientMsg == 서버가 응답해준 메시지
    //         */

    //         axiosInstance(options)
    //             .then(function (res) {

    //                 Swal.fire({
    //                     title: '알림',
    //                     text: res.data.clientMsg,
    //                     icon: res.data.alertIcon,
    //                     confirmButtonText: '확인'
    //                 })
    //                     .then(function (result) {
    //                         if (res.data.resData) { //회원가입 정상 처리
    //                             navigate('/login');//로그인 컴포넌트로 전환
    //                         }
    //                     });
    //             })
    //             .catch(function (err) {
    //                 console.log(err);
    //             });
    //     } else {
    //         Swal.fire({
    //             title: '알림',
    //             text: '입력값이 유효하지 않습니다.',
    //             icon: "warning",
    //             confirmButtonText: '확인'
    //         });
    //     }
    // }




    return (
        <section className="join-container">

            {/* 왼쪽: 회원가입 폼 */}
            <div className="join-left">
                <div className="join-title">회원 가입</div>

                <form className="join-form" onSubmit={function (e) {
                    e.preventDefault();     //기본 submit 이벤트 

                    join();                 //회원가입 처리 함수
                }}>
                    <div className="input-title4">
                        <label htmlFor="memberId">아이디</label>
                    </div>
                    <div className="join-wrap">
                        <div className="input-title3">
                        </div>
                        <div className="join-item3">
                            <input type="text" id="memberId" value={member.memberId} onChange={chgMember} onBlur={checkMemberId} placeholder="8~20글자를 입력하세요." required />
                        </div>
                        <p className={"input-msg" + (idChk == 0 ? '' : idChk == 1 ? ' valid' : ' invalid')}>
                            {
                                idChk == 0
                                    ? ''
                                    : idChk == 1
                                        ? '사용 가능한 아이디입니다.'
                                        : idChk == 2
                                            ? '아이디는 영어 대/소문자 8~20글자 입니다.'
                                            : '이미 사용중인 아이디입니다.'
                            }
                        </p>
                    </div>
                    <div className="join-wrap">
                        <div className="input-title5">
                            <label htmlFor="memberPw">비밀번호</label>
                        </div>
                        <div className="join-item3">
                            <input type="password" id="memberPw" value={member.memberPw} onChange={chgMember} onBlur={chkMemberPw} placeholder="6~30글자를 입력하세요." required /> {/** onChange={chgMember} onBlur={chkMemberPw} */}
                        </div>
                    </div>
                    <div className="join-wrap">
                        <div className="input-title6">
                            <label htmlFor="memberPwRe">비밀번호 확인</label>
                        </div>
                        <div className="join-item3">
                            <input type="password" id="memberPwRe" value={memberPwRe} onChange={chgMemberPwRe} onBlur={chkMemberPw} placeholder="비밀번호와 동일하게 입력하세요" required />
                        </div>
                        <p className={"input-msg" + (pwChk == 0 ? '' : pwChk == 1 ? ' valid' : ' invalid')}>
                            {
                                pwChk == 0
                                    ? ''
                                    : pwChk == 1
                                        ? '비밀번호가 정상 입력되었습니다.'
                                        : pwChk == 2
                                            ? '비밀번호는 영어, 숫자, 특수문자로 6~30글자를 입력하세요.'
                                            : '비밀번호와 비밀번호 확인값이 일치하지 않습니다.'
                            }
                        </p>
                    </div>
                    <div className="join-wrap">
                        <div className="input-title7">
                            <label htmlFor="memberName">이름</label>
                        </div>
                        <div className="join-item3">
                            <input type="text" id="memberName" value={member.memberName} onChange={chgMember} placeholder="OOOO" required />
                        </div>
                    </div>
                    <div className="join-wrap">
                        <div className="input-title8">
                            <label htmlFor="memberEmail">이메일</label>
                        </div>
                        <div className="join-item3">
                            <input type="text" id="memberEmail" value={member.memberEmail} onChange={chgMember} onBlur={checkMemberEmail} placeholder="mail@example.com" required />
                        </div>
                        <p className={"input-msg" + (emailChk == 0 ? '' : emailChk == 1 ? ' valid' : ' invalid')}>
                            {
                                emailChk === 0
                                    ? ''
                                    : emailChk === 1
                                        ? '사용 가능한 이메일입니다.'
                                        : emailChk === 2
                                            ? '이메일 형식이 올바르지 않습니다.'
                                            : '이미 사용 중인 이메일입니다.'
                            }
                        </p>

                    </div>
                    <div className="join-wrap">
                        <div className="input-title3">
                            <label htmlFor="memberPhone">전화번호</label>
                        </div>
                        <div className="join-item3">
                            <input type="text" id="memberPhone" value={member.memberPhone} onChange={chgMember} placeholder="010-0000-0000" required />
                        </div>


                    </div>
                    <div className="join-button-box">
                        <button type="submit" className="join-button">
                            회원가입
                        </button>
                    </div>


                    {/* ...기존 폼 요소들 유지 */}
                    {/* 생략된 부분은 기존 Join.jsx 코드 그대로 */}
                </form>
            </div>

            {/* 오른쪽: 배경 및 로고 */}
            <div className="join-right">
                <div className="brand-wrapper">
                    <div className="brand-logo">
                        <img src="/Picture/MyJarvis.png" alt="Brand Logo" />
                    </div>
                    <div className="brand-text">
                    </div>
                </div>

                {/* 오른쪽 하단 */}
                <div style={{ textAlign: 'center' }}>
                    <div className="footer-links">
                        <a href="#">Support</a>
                        <a href="#">License</a>
                        <a href="#">Terms of Use</a>
                        <a href="#">Blog</a>
                    </div>

                </div>
            </div>

        </section>

    );
}