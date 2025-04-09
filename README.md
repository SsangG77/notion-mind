

# Notion-Mind


- 배포 URL : [Notion-Mind AppStore](https://apps.apple.com/kr/app/notion-mind/id6744064353)

</br>

## 프로젝트 소개
- Notion의 관계형 데이터베이스를 그래프뷰의 형태로 보여준다.
- 각 Node를 탭하면 상세 페이지로 넘어가고 해당 페이지의 내용을 보여준다.
- 연결되어있는 데이터베이스들의 리스트가 나타난다.

</br>

##  기술 스택

- **언어:** Swift
- **프레임워크:** UIKit
- **네트워킹:** URLSession
- **인증:** Notion API(인증을 통해 발급받은 bot id로 accessToken으로 API에 접근)

</br>

##  아키텍처

- **패턴:** MVVM (Model-View-ViewModel)
    - View와 로직을 분리하여 유지보수 용이
    - ViewModel을 통해 데이터 흐름과 상태 관리
- **비동기 처리:** RxSwift 기반의 리액티브 방식
    - 사용자 입력, 네트워크 응답 등을 Observable로 관리
- **레이아웃:** UIScrollView + Custom Layout
    - 각 노드를 랜덤 배치하여 그래프 형태 구현
- **스크롤:** 4방향(상/하/좌/우) 스크롤 가능하도록 제스처 및 ContentSize 커스터마이징

</br>


##  사용된 API

- **Notion API:** 사용자의 데이터베이스에 접근하기 위한 API 사용

</br>

##  라이브러리 및 의존성

- **RxSwift / RxCocoa:** 비동기 데이터 흐름 처리 및 바인딩
- **SnapKit:** 오토레이아웃 코드 간결화
- **UIViewSeparator:** UIView 구분선

</br>

## 2. 디자인
[Figma link](https://www.figma.com/design/ueIXatxFPZVghTQUWHrMRv/notion-mind?node-id=0-1&p=f&t=CmTskKT6zOVqRJkB-0)



</br>

## 3. 기능

- Notion 인증을 통해 사용자의 데이터를 가져옴.

<div>
  <img width="200" src="https://file.notion.so/f/f/0f86b459-412a-451d-9229-4dc4f87d6213/4b4629b9-4c11-4dc4-a272-eb2ef6616064/IMG_0180.png?table=block&id=1cdee035-a51f-8069-964a-e78ea0ef669e&spaceId=0f86b459-412a-451d-9229-4dc4f87d6213&expirationTimestamp=1744221600000&signature=jxfl4iWHS1GyNymiOWmSOrBfrk5VNmRMU_9UZhlBazY&downloadName=IMG_0180.PNG.png" />
</div> 

</br>

- 관계형 데이터베이스를 시각화.


<div>
  <img width="200" src="https://file.notion.so/f/f/0f86b459-412a-451d-9229-4dc4f87d6213/571bc27c-4434-4a02-87d3-196526265bbc/IMG_0183.png?table=block&id=1cdee035-a51f-80d4-bdb3-cef5c83ce482&spaceId=0f86b459-412a-451d-9229-4dc4f87d6213&expirationTimestamp=1744221600000&signature=vlivJH9hp8K34IOqO6UZa3tyxFCBVj3h01yxJf6d2rw&downloadName=IMG_0183.PNG.png" />
</div> 

</br>

- 각 아이템의 상세페이지 확인.

<div>
  <img width="200" src="https://file.notion.so/f/f/0f86b459-412a-451d-9229-4dc4f87d6213/7ea87dd1-2f9c-48fb-85ba-b93f9ab7cea9/IMG_0181.png?table=block&id=1cdee035-a51f-80a7-8605-cdcacaf80499&spaceId=0f86b459-412a-451d-9229-4dc4f87d6213&expirationTimestamp=1744221600000&signature=Ddx_C4spa0zkz0HfioKcv7YmCGnmrvB6cXXCBz5M-Vk&downloadName=IMG_0181.PNG.png" />
</div> 

</br>





