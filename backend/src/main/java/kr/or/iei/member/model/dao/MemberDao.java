package kr.or.iei.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.iei.member.model.dto.Member;


@Mapper
public interface MemberDao {

	int chkMemberId(String memberId);

	int insertMember(Member member);

	Member memberLogin(String memberId);

	Member selectOneMember(String memberId);

	int deleteMember(String memberId);

	int updateMember(Member member);

	int chkMemberEmail(String memberEmail);

	

	
}
