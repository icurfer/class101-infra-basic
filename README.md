# 웹사이트 구축으로 배우는 서버 인프라 기초

클라우드 엔지니어 **icurfer**의 [CLASS101 강의](https://class101.net/ko/products/68331ea3e541ec885d817fd6?viewMode=svod) 실습 자료입니다.

우분투 리눅스에서 웹서버, 로드밸런서, 데이터베이스와 컨테이너를 구성하고 웹서비스를 배포하며 서버 인프라의 기초를 익힙니다. 각 구성 요소의 역할을 배운 뒤, 마지막 미니 프로젝트에서 프런트엔드·백엔드·데이터베이스를 연결해 하나의 웹사이트를 완성합니다.

[강의 바로가기](https://class101.net/ko/products/68331ea3e541ec885d817fd6?viewMode=svod) · [크리에이터 소개](https://class101.net/ko/creators/@kndurwpw/about) · [YouTube @icurfer](https://www.youtube.com/@icurfer)

## 이런 분께 추천합니다

- 서버와 인프라를 어디서부터 공부할지 고민하는 비전공자
- 직접 실습하며 기초를 다지고 싶은 신입·주니어 엔지니어
- 웹서비스가 동작하는 시스템과 네트워크 구성을 이해하고 싶은 운영자·관리자
- 리눅스와 오픈소스를 활용해 작은 웹서비스를 배포해 보고 싶은 분

## 배우는 내용

- **우분투 기초**: 가상머신 준비, 계정과 권한, 파일 편집, 명령어와 패키지 관리
- **네트워크와 보안**: IP 설정, SSH 접속, UFW 방화벽
- **웹서비스 인프라**: Nginx 웹서버, HAProxy 로드밸런서, HTTPS와 인증서
- **데이터와 컨테이너**: MariaDB, Docker, Nginx 컨테이너 실행
- **미니 프로젝트**: 준비한 구성 요소를 연결하여 웹사이트 구축

### 학습 순서

강의는 11개 챕터, 26개 강의로 구성됩니다. 실습 환경 준비부터 미니 프로젝트까지 순서대로 학습해 주세요.

| 순서 | 챕터 | 주요 내용 |
| --- | --- | --- |
| 1 | 안녕하세요. 웰컴 챕터 입니다. | 강의 소개, 권장 실습 환경 |
| 2 | 환경 설정하기 | Chrome, MobaXterm, VSCode, VirtualBox, 우분투 가상머신 |
| 3 | 우분투 사용 기초 다지기 | User·Root, vim, 기본 명령어, 패키지 관리 |
| 4 | 우분투 리눅스 네트워크 설정 | 고정·유동 IP, DHCP, netplan |
| 5 | Nginx 웹서버 | 웹서버의 역할, 우분투 폴더 구조 |
| 6 | 우분투 보안 | SSH, UFW 방화벽 |
| 7 | HAProxy 로드밸런서 | 로드밸런서·리버스 프록시, HAProxy 구성 |
| 8 | HTTPS | HTTPS의 개념, 자체 서명 인증서 실습 |
| 9 | MariaDB | 데이터베이스의 역할, MariaDB 실습 |
| 10 | Docker | 컨테이너의 개념, Docker로 Nginx 실행 |
| 11 | 미니 프로젝트 | 웹사이트 인프라 구성과 서비스 배포 |

## 자료 구성

이 저장소에는 HTTPS 실습 자료와 미니 프로젝트 설정 템플릿이 들어 있습니다. 설명과 실습 과정은 해당 강의를 함께 참고해 주세요.

```text
class101-infra-basic/
├── HTTPS/
│   ├── create-private-cert.sh
│   ├── nginx-https.conf
│   ├── ca.crt
│   └── demo-certs.tar
└── mini-project/
    ├── sample.env
    ├── docker-compose.yaml
    └── haproxy.cfg
```

### HTTPS 실습

| 자료 | 용도 |
| --- | --- |
| [create-private-cert.sh](HTTPS/create-private-cert.sh) | 실습용 CA와 `demo.test`, `*.demo.test` 서버 인증서를 만드는 OpenSSL 예제 |
| [nginx-https.conf](HTTPS/nginx-https.conf) | HTTP 요청을 HTTPS로 전환하고 정적 웹페이지를 제공하는 Nginx 설정 |
| [ca.crt](HTTPS/ca.crt) | 실습용 CA 인증서 |
| [demo-certs.tar](HTTPS/demo-certs.tar) | CA·서버 인증서, 개인키, CSR, 확장 설정을 포함한 실습 자료 |

인증서 생성 예제의 출력 위치는 `$HOME/certs`입니다. Nginx 설정은 `/etc/nginx/ssl/fullchain.pem`과 `/etc/nginx/ssl/server.key`를 참조하므로, 강의에서 설명하는 인증서 구성과 배치 경로를 맞춰 주세요. `demo.test`와 서버 IP의 연결도 실습 환경에 맞게 설정해야 합니다.

인증서와 개인키는 학습용 예제입니다. 실제 서비스에서는 이 예제 키를 재사용하지 마세요.

### 미니 프로젝트

| 자료 | 용도 |
| --- | --- |
| [sample.env](mini-project/sample.env) | Django 서비스의 데이터베이스 연결 정보와 환경 변수 예제 |
| [docker-compose.yaml](mini-project/docker-compose.yaml) | React 프런트엔드, Django 인증·블로그 서비스와 공용 네트워크 구성 |
| [haproxy.cfg](mini-project/haproxy.cfg) | HTTP→HTTPS 전환과 앱 서버로의 요청 전달 설정 |

Compose 템플릿에 포함된 서비스는 다음과 같습니다.

| 서비스 | 이미지 | 호스트:컨테이너 포트 |
| --- | --- | --- |
| 프런트엔드 | `icurfer/class101-react-fe:0.1` | `80:80` |
| 인증 API | `icurfer/class101-django-auth:0.1` | `8000:8000` |
| 블로그 API | `icurfer/class101-django-blog:0.1` | `8800:8800` |

세 서비스는 `msa-net` 네트워크를 사용합니다. MariaDB는 이 Compose 파일에 포함되지 않으며, 강의에서 준비한 데이터베이스 서버에 연결합니다.

## 미니 프로젝트 자료 사용 방법

1. 강의의 환경 설정·네트워크·MariaDB 실습을 먼저 진행합니다.
2. 저장소 루트에서 환경 변수 예제 파일을 복사합니다.

   ```bash
   cp mini-project/sample.env mini-project/.env
   ```

3. `mini-project/.env`의 값을 본인의 실습 환경에 맞춥니다.

   | 설정 | 확인할 내용 |
   | --- | --- |
   | `SQL_HOST`, `SQL_PORT` | MariaDB 서버 주소와 포트 |
   | `SQL_USER`, `SQL_PASSWORD`, `SQL_DATABASE` | 실습에서 만든 DB 계정·비밀번호·데이터베이스 |
   | `SECRET_KEY` | 본인의 Django 실습 환경에서 사용할 키 |
   | `AUTH_VERIFY_URL` | 인증 서비스 주소. 기본 예제는 Compose 네트워크의 컨테이너 이름 사용 |

4. `haproxy.cfg`의 앱 서버 주소와 인증서 경로를 확인한 뒤 강의의 배포 순서를 따릅니다.

   | 항목 | 예제값 |
   | --- | --- |
   | 데이터베이스 서버 | `10.0.3.63:3306` |
   | HAProxy가 요청을 전달할 앱 서버 | `10.0.3.62:80` |
   | HAProxy 인증서 번들 | `/etc/haproxy/ssl/bundle.pem` |

`.env`는 로컬 환경 설정 파일로 Git 관리에서 제외됩니다. 배포용 예제는 `sample.env`를 참고해 주세요. HAProxy 파일에는 `frontend`·`backend` 설정이 담겨 있으므로, 강의의 `global`·`defaults` 설정과 함께 사용합니다. HAProxy와 앱 서버의 배치도 강의 구성을 따르며, 동일한 호스트에서 실행할 경우 80번 포트가 겹치지 않도록 조정해야 합니다.

## 질문과 참고

실습 중 궁금한 점은 [CLASS101 강의](https://class101.net/ko/products/68331ea3e541ec885d817fd6?viewMode=svod)의 해당 강의 댓글에 남겨 주세요. 사용한 OS와 실습 단계, 오류 메시지를 함께 적으면 상황을 확인하기 쉽습니다. 비밀번호나 개인키는 포함하지 마세요.
