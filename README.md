# Microservice with Message Queue by k8s
## Title

Redis를 Message Queue로 하여 Message Queue로 Microservice Architecture를 구현합니다.

## Description

- 손님이 가게(Store)로 찾아와 물건을 하나씩 삽니다.
- 가게에 재고가 떨어지면, 외부에 있는 공장 서버로 재고 추가 요청을 보냅니다. 이때 외부 공장 서버는 재고 추가 요청을 받으면 10초 후에 가게로 다시 재고를 올려라는 요청을 보냅니다
    - 프로젝트 당시에는 외부 서버가 따로 만들어졌으나 현재는 테스트용으로 다시 구축하였습니다.

## Installation

1. Local
    - Kubernetes와 minikube를 설치합니다.
    - 루트 위치에서 `kubectl apply -f infra/kube/first_deploy` -> `kubectl apply -f infra/kube/second_deploy` -> `kubectl apply -f infra/kube/third_deploy` 순으로 입력해서 애플리케이션을 설치합니다.
2. On AWS EKS : 70% 완성, AWS EKS 테라폼 인프라는 구축되었습니다.
    - Terraform과 AWS-CLI 그리고 eksctl을 설치합니다.

## License

- MIT License

## Project status

- Helm으로 코드화 중입니다.
- Factory 서버 구현 90% 완료
- Istio와 Metric Controller를 붙일 예정입니다.
- EKS 상에서 작동하는지 확인해야합니다.
- 애플리케이션과 인프라 테스트 코드 작성이 필요합니다.