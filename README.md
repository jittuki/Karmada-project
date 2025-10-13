### [실험 환경 구성]

**Host cluster** 

jisu-mgmt: 192.168.40.122

**Member cluster**

jisu-member-1: 192.168.40.102

jisu-member-2: 192.168.40.155

1. **Kubernetes 설치**
    - root에서 설치
    - 호스트, 멤버 클러스터 각각 모두 설치
2. **Karmada 설치**
    - host에만 설치
    - sudo 사용
    
    Karmada가 설치 중에 `/etc/karmada` 디렉토리를 생성해야 하므로, root 권한이 필요
    
    따라서 이번엔 `sudo` 로 실행:
    
    ```bash
    sudo kubectl karmada init --etcd-storage-mode=hostPath
    ```
    
    다만, `sudo` 환경에 kubeconfig가 없으면 문제가 되니까, kubeconfig를 root도 쓸 수 있게 해줘야 함:
    
    ```bash
    # root 홈에 kubeconfig 설정
    sudo mkdir -p /root/.kube
    sudo cp /etc/kubernetes/admin.conf /root/.kube/config
    sudo chown root:root /root/.kube/config
    ```
    
    그 다음에 `sudo kubectl karmada init ...` 실행하면 정상 동작
    
3. 멤버 클러스터 등록
    - karmadactl CLI를 이용해 멤버 클러스터1, 2 등록 ⇒ push mode
  
  ### [실험 구성]

**공통 워크로드: Nginx Deployment**

- 기본 Deployment 정의 (replica 2, containerPort 80)
- 모든 케이스에서 이 리소스를 기반으로 karmada가 배포를 관리

1. case 1: 특정 클러스터 1개에만 배포
2. case 2: 모든 클러스터에 배포
3. case 3: 특정 라벨/조건 클러스터만 선택
4. 추가
   - cluster 이름 + 라벨 조합 -> 비용 최적화 + 고가용성 균형
   - 원본 Deployment 변경 반영 -> 정책 반영/업데이트 용이성
   - 리소스 삭제 후 복구 -> 정책 신뢰성 및 장애 대응 확인


ArgoCD와의 연계
GitOps 방식으로 배포가 자동화되는 걸 확인
GitHub -> ArgoCD -> Karmada -> member cluster
