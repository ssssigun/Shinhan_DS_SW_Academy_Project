# 여행 플래너 We go
<p align="center">
<img src=./Wego/src/main/webapp/image/readMe/WegoMain.png width="80%" />
</p>
스프링 + JSP를 사용하여 만든 여행 플래너 서비스

## 👨🏻‍💻 멤버
 - 이시권 (팀장)
    - SSO(Single Sign-On) 로그인
 - 김지원
    - 여행 기록
 - 이창준
    - 여행 계획 작성, 가게 정보 및 후기
 - 박정은 
    - 가계부
 - 윤서영 
    - 여행 후기 게시판


## 🖥️ 프로젝트 소개
여행 플래너 서비스는 여행 계획을 세우고 여행 후의 소비를 시각적으로 확인하는데 도움이 되는 서비스입니다. 지도를 통해 여행 동선을 계획할 수 있어 여행 일정을 효율적으로 구성할 수 있습니다. 또한, 카드 사용 내역을 가져와 여행 계획과 비교하여 소비 패턴을 분석할 수 있는 그래프로 시각화하여 제공합니다.

<br>

## ⏰ 개발 기간
* 23.05.19 ~ 23.07.18


### ⚙️ 기술 스택

- **Language** : Java 
- **Framework** : Spring
- **Database** : MySQL
- **ORM** : Mybatis

## 📝 기획 및 설계

| 아키텍쳐 |
| :---: |
| <br><img src=./Wego/src/main/webapp/image/readMe/WegoArchitecture.png width="90%" /><br><br> |
|  |

| ERD |
| :---: |
| <br><img src=./Wego/src/main/webapp/image/readMe/WegoERD.png width="90%" /><br><br> |
|  |

| 화면 설계 |
| :---: |
| <br><img src=./Wego/src/main/webapp/image/readMe/WegoDesign0.png width="90%" /><br><br><img src=./Wego/src/main/webapp/image/readMe/WegoDesign1.png width="90%" /><br><br><img src=./Wego/src/main/webapp/image/readMe/WegoDesign.png width="90%" /><br><br> |

### 📌 주요 기능
| 로그인 |
| :---: |
| <br><img src=./Wego/src/main/webapp/image/readMe/WegoLogin.png width ="90%"/> <br>|
| 회원 정보를 받아 로그인하는 화면입니다. <br> 로그인의 관련 정보는 [SSO Repository](https://github.com/ssssigun/SSO_final)를 확인해주세요! |
|<br><img src=./Wego/src/main/webapp/image/readMe/WegoFirstLogin.png width ="90%" /> <br>|
| 첫 로그인 시, 약관 동의 화면이 나오며 닉네임을 입력받습니다. |


| 메인 페이지 |
| :---: |
| <br><img src=./Wego/src/main/webapp/image/readMe/WegoMain.png width ="90%"/> <br> |
| 로그인 후 보이는 메인 화면입니다. |
|<br> <img src=./Wego/src/main/webapp/image/readMe/WegoMain2.png width ="90%"/> <br>|
| 상단에는 사용자가 작성한 여행 계획들이 표시되고, 하단에는 후기 게시판에 작성된 다른 이용자들의 여행 후기가 나옵니다. |


| 여행 계획 |
| :---: |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoPlan1.png width ="90%"/> <br> |
| 여행을 계획하는 페이지입니다. 왼쪽 상단에서 지역과 날짜를 입력하고 일정을 구성할 수 있으며, 오른쪽에는 해당 지역이 표시되고 지도를 통해 시각적으로 여행 경로를 확인할 수 있습니다. <br> 왼쪽 하단에는 지도 주변 가게들의 정보가 표시됩니다.|
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoPlan4.png width ="90%"/> <br>|
| 클릭하면 가게의 상세 정보와 방문자들의 후기를 볼 수 있습니다. |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoPlan2.png width ="90%"/> <br><br> <img src=./Wego/src/main/webapp/image/readMe/WegoPlan3.png width ="90%"/> <br>|
| 일정을 모두 작성한 후 완료 버튼을 누르면, 작성한 계획과 예산이 요약된 내용을 확인할 수 있습니다. 또한, 금액에 따라 포인트가 적립됩니다.|


| 여행 게시판 |
| :---: |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoBoard1.png width ="90%"/> <br>|
| 여행 후기 게시판입니다. 다른 사용자들의 후기들을 볼 수 있습니다.|
|<br> <img src=./Wego/src/main/webapp/image/readMe/WegoBoard2.png width ="90%"/> <br><br> <img src=./Wego/src/main/webapp/image/readMe/WegoBoard4.png width ="90%"/> <br>|
| 게시판 상세 페이지입니다. 조회수가 표시되며, 아이디당 한 번씩 추천할 수 있습니다. 게시물 신고 기능과 댓글 작성도 가능합니다.|
|<br> <br> <img src=./Wego/src/main/webapp/image/readMe/WegoReviewUpdate1.png width ="90%"/> <br>|
| 본인이 작성한 게시물은 ‘수정하기’ 버튼을 통해 수정할 수 있습니다. |

| 여행 기록 |
| :---: |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoMyRecord2.png width ="90%"/> <br><br> <img src=./Wego/src/main/webapp/image/readMe/WegoMyRecord3.png width ="90%"/> |
| 여행 기록 페이지입니다. 내가 작성한 여행 계획, 후기, 그리고 임시 저장된 내용을 확인할 수 있습니다. |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoReview1.png width ="90%"/> <br>|
| 후기란에서는 본인이 다녀온 여행에 대한 후기를 작성할 수 있습니다. |
|<br> <img src=./Wego/src/main/webapp/image/readMe/WegoReview2.png width ="90%"/> <br>|
| 각 장소마다 한줄 후기와 별점을 작성할 수 있으며, 작성된 후기는 해당 가게의 상세 정보에 표시됩니다. |

| 가계부 |
| :---: |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoMyRecord1.png width ="90%"/> <br>|
| 가계부 페이지입니다. 내가 다녀온 여행에서 소비를 계획했던 예산과 카드 내역과 비교하여 보여줍니다. 또한, 사용한 금액을 카테고리별로 분류해 육각형 도형으로 시각적으로 나타냅니다. 하단에는 내가 다녀온 여행 목록이 표시됩니다.|
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoInfo4.png width ="90%"/> <br> |
| 카드 사용 내역을 표 형태로 보여줍니다. |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoInfo5.png width ="90%"/> <br> |
| 계획한 예산과 실제 카드 사용 내역을 그래프로 시각적으로 비교하여 보여줍니다. |
|<br> <img src=./Wego/src/main/webapp/image/readMe/WegoInfo6.png width ="90%"/> |
| 카드 사용 내역을 막대 그래프로 시각적으로 나타냅니다. |  

| 마이페이지 |
| :---: |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoMypage1.png width ="90%"/> <br> |
| 마이페이지입니다. 접근 시 본인 확인을 위해 비밀번호를 입력받아 확인합니다. |
| <br> <img src=./Wego/src/main/webapp/image/readMe/WegoMypage2.png width ="90%"/> <br>|
| 닉네임을 변경할 수 있으며, 카드 정보를 확인할 수 있습니다. | 