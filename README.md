graph TB
    %% External Layer
    subgraph "🌐 Internet & CDN Layer"
        Internet[🌍 Internet Users]
        CDN[📡 IONOS CDN<br/>+ WAF + DDoS Protection]
        DNS[🎯 IONOS DNS<br/>Health Checks & Failover]
    end

    %% Security Layer
    subgraph "🛡️ Security & Certificate Layer"
        CertMgr[🔐 IONOS Certificate Manager<br/>Automated SSL/TLS Lifecycle]
        DDoS[🛡️ IONOS DDoS Protection<br/>Automatic Mitigation]
        NSG[🔥 Network Security Groups<br/>Firewall Rules & ACLs]
    end

    %% Load Balancer Layer
    subgraph "⚖️ Load Balancing Layer"
        ALB[🔄 IONOS Application Load Balancer<br/>Layer 7 + SSL Termination]
        NLB[⚡ IONOS Network Load Balancer<br/>Layer 4 + Health Checks]
    end

    %% Kubernetes Layer
    subgraph "☸️ IONOS Managed Kubernetes Cluster"
        subgraph "🎛️ Control Plane (FREE)"
            K8sAPI[⚙️ Kubernetes API Server]
            K8sEtcd[💾 etcd Cluster]
            K8sScheduler[📋 Scheduler]
            K8sController[🎮 Controller Manager]
        end
        
        subgraph "🏭 Worker Nodes (Multi-AZ)"
            subgraph "📍 AZ-1 (Frankfurt-1)"
                Node1[💻 Worker Node 1<br/>e1-standard-4]
                WP1[🌐 WordPress Pod 1]
                WP2[🌐 WordPress Pod 2]
            end
            
            subgraph "📍 AZ-2 (Frankfurt-2)"
                Node2[💻 Worker Node 2<br/>e1-standard-4]
                WP3[🌐 WordPress Pod 3]
                WP4[🌐 WordPress Pod 4]
            end
            
            subgraph "📍 AZ-3 (Frankfurt-3)"
                Node3[💻 Worker Node 3<br/>e1-standard-4]
                WP5[🌐 WordPress Pod 5]
                WP6[🌐 WordPress Pod 6]
            end
        end
        
        subgraph "🌐 Ingress Layer"
            Ingress[🚪 NGINX Ingress Controller<br/>SSL Termination & Routing]
        end
        
        subgraph "🔧 System Components"
            HPA[📊 Horizontal Pod Autoscaler]
            CA[🔄 Cluster Autoscaler]
            CSI[💽 CSI Driver]
        end
    end

    %% Data Layer
    subgraph "🗄️ Data & Storage Layer"
        subgraph "💾 IONOS Managed PostgreSQL Cluster"
            PGPrimary[🎯 PostgreSQL Primary<br/>Node 1 - Frankfurt-1]
            PGReplica1[📖 PostgreSQL Replica<br/>Node 2 - Frankfurt-2]
            PGReplica2[📖 PostgreSQL Replica<br/>Node 3 - Frankfurt-3]
        end
        
        subgraph "⚡ IONOS In-Memory DB (Redis)"
            RedisPrimary[🎯 Redis Primary<br/>Node 1]
            RedisReplica1[📖 Redis Replica<br/>Node 2]
            RedisReplica2[📖 Redis Replica<br/>Node 3]
        end
        
        subgraph "💾 IONOS Storage Services"
            BlockStorage[📦 Block Storage<br/>High-Performance SSD]
            ObjectStorage[🗂️ Object Storage<br/>S3-Compatible<br/>Media & Backups]
        end
        
        subgraph "🔄 Backup Services"
            BackupService[💾 IONOS Backup Service<br/>Automated + Encrypted]
            DisasterRecovery[🆘 Disaster Recovery<br/>Cross-Region Replication]
        end
    end

    %% Monitoring Layer
    subgraph "📊 Monitoring & Observability"
        subgraph "📈 IONOS Monitoring Service"
            Prometheus[📊 Prometheus<br/>Metrics Collection]
            Grafana[📈 Grafana<br/>Dashboards & Visualization]
        end
        
        subgraph "📋 IONOS Logging Service"
            LogAggregation[📝 Log Aggregation<br/>Centralized Logging]
            LogAnalysis[🔍 Log Analysis<br/>Search & Alerting]
        end
        
        subgraph "🚨 Alerting System"
            AlertManager[🚨 Alert Manager<br/>Smart Routing]
            Notifications[📧 Notifications<br/>Email, Slack, PagerDuty]
        end
    end

    %% DevOps Pipeline
    subgraph "🚀 DevOps & CI/CD Pipeline"
        subgraph "📝 Infrastructure as Code"
            Terraform[🏗️ Terraform<br/>IONOS Provider]
            Ansible[⚙️ Ansible<br/>Configuration Management]
        end
        
        subgraph "🔄 CI/CD Pipeline"
            GitLab[🦊 GitLab CI/CD<br/>Pipeline Automation]
            Helm[⛵ Helm Charts<br/>Application Deployment]
            Registry[📦 IONOS Private Registry<br/>Container Images]
        end
    end

    %% Flow Connections
    Internet --> CDN
    CDN --> DNS
    DNS --> CertMgr
    CertMgr --> DDoS
    DDoS --> NSG
    NSG --> ALB
    ALB --> NLB
    NLB --> Ingress
    
    Ingress --> WP1
    Ingress --> WP2
    Ingress --> WP3
    Ingress --> WP4
    Ingress --> WP5
    Ingress --> WP6
    
    WP1 --> Node1
    WP2 --> Node1
    WP3 --> Node2
    WP4 --> Node2
    WP5 --> Node3
    WP6 --> Node3
    
    Node1 --> K8sAPI
    Node2 --> K8sAPI
    Node3 --> K8sAPI
    
    K8sAPI --> K8sEtcd
    K8sAPI --> K8sScheduler
    K8sAPI --> K8sController
    
    HPA --> K8sAPI
    CA --> K8sAPI
    CSI --> BlockStorage
    
    WP1 -.-> PGPrimary
    WP2 -.-> PGPrimary
    WP3 -.-> PGPrimary
    WP4 -.-> PGPrimary
    WP5 -.-> PGPrimary
    WP6 -.-> PGPrimary
    
    PGPrimary --> PGReplica1
    PGPrimary --> PGReplica2
    
    WP1 -.-> RedisPrimary
    WP2 -.-> RedisPrimary
    WP3 -.-> RedisPrimary
    WP4 -.-> RedisPrimary
    WP5 -.-> RedisPrimary
    WP6 -.-> RedisPrimary
    
    RedisPrimary --> RedisReplica1
    RedisPrimary --> RedisReplica2
    
    Node1 --> BlockStorage
    Node2 --> BlockStorage
    Node3 --> BlockStorage
    
    ObjectStorage --> BackupService
    PGPrimary --> BackupService
    BackupService --> DisasterRecovery
    
    %% Monitoring Connections
    Node1 -.-> Prometheus
    Node2 -.-> Prometheus
    Node3 -.-> Prometheus
    WP1 -.-> Prometheus
    WP2 -.-> Prometheus
    WP3 -.-> Prometheus
    WP4 -.-> Prometheus
    WP5 -.-> Prometheus
    WP6 -.-> Prometheus
    PGPrimary -.-> Prometheus
    RedisPrimary -.-> Prometheus
    
    Prometheus --> Grafana
    LogAggregation --> LogAnalysis
    Prometheus --> AlertManager
    AlertManager --> Notifications
    
    %% DevOps Connections
    Terraform -.-> K8sAPI
    Ansible -.-> Node1
    Ansible -.-> Node2
    Ansible -.-> Node3
    GitLab --> Registry
    Helm --> K8sAPI
    Registry --> Node1
    Registry --> Node2
    Registry --> Node3

    %% Styling
    classDef internetLayer fill:#ff6b6b,stroke:#ee5a52,stroke-width:2px,color:#fff
    classDef securityLayer fill:#4ecdc4,stroke:#44a08d,stroke-width:2px,color:#fff
    classDef loadBalancerLayer fill:#45b7d1,stroke:#96c93d,stroke-width:2px,color:#fff
    classDef kubernetesLayer fill:#667eea,stroke:#764ba2,stroke-width:2px,color:#fff
    classDef dataLayer fill:#f093fb,stroke:#f5576c,stroke-width:2px,color:#fff
    classDef monitoringLayer fill:#4facfe,stroke:#00f2fe,stroke-width:2px,color:#fff
    classDef devopsLayer fill:#fa709a,stroke:#fee140,stroke-width:2px,color:#fff
    
    class Internet,CDN,DNS internetLayer
    class CertMgr,DDoS,NSG securityLayer
    class ALB,NLB loadBalancerLayer
    class K8sAPI,K8sEtcd,K8sScheduler,K8sController,Node1,Node2,Node3,WP1,WP2,WP3,WP4,WP5,WP6,Ingress,HPA,CA,CSI kubernetesLayer
    class PGPrimary,PGReplica1,PGReplica2,RedisPrimary,RedisReplica1,RedisReplica2,BlockStorage,ObjectStorage,BackupService,DisasterRecovery dataLayer
    class Prometheus,Grafana,LogAggregation,LogAnalysis,AlertManager,Notifications monitoringLayer
    class Terraform,Ansible,GitLab,Helm,Registry devopsLayer