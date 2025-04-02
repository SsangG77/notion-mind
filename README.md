

# Notion-Mind
![Image](https://github-production-user-asset-6210df.s3.amazonaws.com/63487642/429539302-d03307d3-5a34-41d4-9ec4-29a2168c1ebd.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250402%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250402T145452Z&X-Amz-Expires=300&X-Amz-Signature=71237717f9b404a38b60792f212e7c2001fccd09c9390feacc3a5ec5d387bb4f&X-Amz-SignedHeaders=host)

- 배포 URL : [Notion-Mind AppStore]()

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

</br>

## 2. 디자인
[Figma link](https://www.figma.com/design/ueIXatxFPZVghTQUWHrMRv/notion-mind?node-id=0-1&p=f&t=CmTskKT6zOVqRJkB-0)



</br>

## 3. 기능

- Notion 인증을 통해 사용자의 데이터를 가져옴.

<div>
  <img width="200" src="https://github-production-user-asset-6210df.s3.amazonaws.com/63487642/428424659-566dde71-941e-4bbc-b950-3455f4171ecb.PNG?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250330%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250330T200314Z&X-Amz-Expires=300&X-Amz-Signature=6de6bbdfdf65e575d7639989fe5125622f0939186c0465f1f4f8aefd3a7d3a08&X-Amz-SignedHeaders=host" />
</div>

</br>

- 관계형 데이터베이스를 시각화.


<div>
  <img width="200" src="https://github-production-user-asset-6210df.s3.amazonaws.com/63487642/429539704-d72bce38-ac8a-4fc0-bdc5-ca77b6b9eaf6.PNG?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250402%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250402T145548Z&X-Amz-Expires=300&X-Amz-Signature=c6726f8bf6eb1520c314f185b6f32a071096156944c8fe0758e7fa4b621506ab&X-Amz-SignedHeaders=host" />
</div>

</br>

- 각 아이템의 상세페이지 확인.

<div>
  <img width="200" src="https://github-production-user-asset-6210df.s3.amazonaws.com/63487642/429540056-87152b5e-531f-4b23-a0e5-9407e4542760.PNG?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250402%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250402T145622Z&X-Amz-Expires=300&X-Amz-Signature=7faaeb0c4ed43773a544015dc41c5d9be4a0d2928eaf62260083cb7631296827&X-Amz-SignedHeaders=host" />
</div>

</br>



