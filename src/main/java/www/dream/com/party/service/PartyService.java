package www.dream.com.party.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import www.dream.com.framework.springSecurityAdapter.CustomUser;
import www.dream.com.party.model.ContactPoint;
import www.dream.com.party.model.ContactPointTypeVO;
import www.dream.com.party.model.Member;
import www.dream.com.party.model.Party;
import www.dream.com.party.model.partyOfAuthVO;
import www.dream.com.party.persistence.PartyMapper;

@Service // 2. @Seivce @ 생성 그리고 root-context.xml 로 가서 tag 작성 service는 root-context에 생성
@AllArgsConstructor // 4. Allargsconstructor @ 생성
@NoArgsConstructor
public class PartyService implements UserDetailsService { // 1. 순서가 의미가 없어졌다. 일단은 두 가지 CommonMngVO , PartyMapper의 xml을
															// 만들었고, 시작한다 이부분은.
	@Autowired // 5. NonNull @도 만들어준다. 일단 이친구의 기능이뭔지 공부하기.
	private PartyMapper partyMapper; // 3. PartyMapper 객체를 받아낼 것

	public List<Party> getList(Party member) { // 6. Party List를 끌고와도 괜찮다. 왜? List를 불러오는 함수를 만들거라서
		return partyMapper.getList(member); // 7. public으로 만들었으니, 그에대한 반환값必 partyMapper 변수의 getList 함수 선언
	}
	public List<ContactPoint> getContactListByUserId(String userId){
		return partyMapper.getContactListByUserId(userId);
	}
	// 해당 사용자 정보 가져오기
	public Party findPartyByUserId(String userId) {
		return partyMapper.findPartyByUserId(userId);
	};

	// 사용자 정보 수정
	public void updateUser(@Param("party") Party party) {
		partyMapper.updateUser(party);
	};

	// 사용자 연락처 수정
	public void updateUserCP(@Param("party") Party party) {
		partyMapper.updateUserCP(party);
	};

	// 사용자 회원 탈퇴
	public void deleteId(Party party) {
		partyMapper.deleteId(party);
	}

	// 연락처 유형 목록 조회
	public List<ContactPointTypeVO> getCPTypeList() {
		return partyMapper.getCPTypeList();
	}

	// 권한 테이블에서 사용자 조회
	public partyOfAuthVO getMemberType() {
		return partyMapper.getMemberType();
	};

	public int IDDuplicateCheck(String userId) {
		return partyMapper.IDDuplicateCheck(userId);
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Party loginParty = partyMapper.findPartyByUserId(username);
		return loginParty == null ? null : new CustomUser(loginParty);
	}

	public void joinMember(Member m) {
		partyMapper.joinMember(m);
	}

}
