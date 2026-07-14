export const person = {
  name: 'Stefanos Stathatos',
  title: 'DevOps Engineer',
  location: 'Athens, Greece',
  summary:
    'DevOps Engineer with 8 years of experience specializing in automation, cloud services, and CI/CD pipelines. Proficient in Docker, Kubernetes, AWS, and Jenkins, with a proven track record of improving operational efficiency and collaboration. Experienced in managing production environments and enhancing deployment processes.',
  email: 'st.stathatos@gmail.com',
  github: 'https://github.com/sstathatos',
  linkedin: 'https://www.linkedin.com/in/stefanos-stathatos-43081016a/',
  cvFile: '/stefanos-stathatos-cv.pdf',
};

export interface Job {
  company: string;
  url?: string;
  role: string;
  where: string;
  from: string;
  to: string;
  bullets: string[];
}

export const experience: Job[] = [
  {
    company: 'Nespresso via Amaris',
    role: 'DevOps Engineer',
    where: 'Remote',
    from: 'Nov 2024',
    to: 'Present',
    bullets: [
      'Deployed and maintained Jenkins on Kubernetes, leveraging dynamic pod-based agents to provide scalable CI/CD infrastructure capable of supporting dozens of pipelines running concurrently across multiple engineering teams.',
      'Designed and implemented Jenkins pipelines to automate complex database operations and operational workflows, standardizing CI/CD processes to improve efficiency and reduce human error across production activities.',
      'Deployed and maintained Grafana monitoring stacks on Kubernetes (OCI), integrating Prometheus and database exporters to provide centralized observability, production dashboards, alerting, and metrics visualization.',
      'Developed and maintained Ansible playbooks for the database squad and contributed Infrastructure as Code (IaC) automation to the organization’s central Ansible Automation Platform (AAP) code repository.',
    ],
  },
  {
    company: 'Earth Science Analytics',
    url: 'https://www.earthanalytics.ai/',
    role: 'DevOps Engineer',
    where: 'Athens',
    from: 'Nov 2019',
    to: 'Nov 2024',
    bullets: [
      'Designed and automated deployment processes using CI/CD pipelines with Jenkins, supporting an internal team of developers and significantly boosting productivity.',
      'Orchestrated deployment and management of a SaaS web application designed for the oil and gas industry with Kubernetes in test, QA and production environments.',
      'Deployed and managed a Django application with a MySQL database, supporting machine learning computations, in both Azure Kubernetes Service (AKS) and Amazon Elastic Kubernetes Service (EKS), ensuring high availability and scalability.',
      'Developed Python-based automation leveraging AWS, Azure, and GCP APIs to provision and manage cloud infrastructure for machine learning workflows and deployments.',
      'Provisioned infrastructure deployment in both AWS and Azure environments using Terraform, improving efficiency and consistency.',
      'Reduced infrastructure costs by 30% using Infracost for cost analysis and optimization.',
      'Implemented cloud security best practices by incorporating private subnets, bastion hosts, and security groups.',
      'Used ArgoCD to implement GitOps by synchronizing Git repositories with Kubernetes clusters, ensuring declarative and version-controlled deployments.',
      'Monitored and maintained web SaaS application performance using Kubernetes-native tools and Prometheus/Grafana for observability.',
    ],
  },
  {
    company: 'Earth Science Analytics',
    url: 'https://www.earthanalytics.ai/',
    role: 'Backend Developer',
    where: 'Athens',
    from: 'Nov 2018',
    to: 'Nov 2019',
    bullets: [
      'Designed and implemented containerization strategy using Docker.',
      'Developed unit tests to validate individual components and functions within RESTful API and database.',
    ],
  },
];

export const skills: { category: string; items: string[] }[] = [
  { category: 'Orchestrators', items: ['Kubernetes'] },
  { category: 'Cloud', items: ['AWS', 'Azure', 'GCP'] },
  { category: 'CI/CD', items: ['Jenkins', 'ArgoCD', 'GitHub Actions'] },
  { category: 'Containerization', items: ['Docker'] },
  { category: 'IaC', items: ['Terraform', 'Ansible'] },
  { category: 'Monitoring', items: ['Grafana', 'Prometheus', 'ELK'] },
  { category: 'Languages', items: ['Python', 'Bash'] },
  { category: 'Databases', items: ['MySQL', 'PostgreSQL'] },
  { category: 'OS & VCS', items: ['Linux', 'Git'] },
];

export const certifications = [
  { name: 'AWS Certified Solutions Architect – Associate', issuer: 'Amazon Web Services' },
  { name: 'Certified Kubernetes Administrator (CKA)', issuer: 'The Linux Foundation' },
];

export interface Project {
  name: string;
  description: string;
  tech: string[];
  url?: string;
  badge?: string;
}

export const projects: Project[] = [
  {
    name: 'This platform',
    description:
      'The site you are reading runs on infrastructure built from scratch: two Hetzner servers imported into Terraform, a 2-node k3s cluster joined over a private network, ingress-nginx with Let’s Encrypt TLS, and every workload deployed declaratively through ArgoCD from a single Git repository.',
    tech: ['Terraform', 'k3s', 'ArgoCD', 'Helm', 'GitHub Actions', 'Cloudflare'],
    url: 'https://github.com/sstathatos/sstathatos.dev',
    badge: 'live',
  },
  {
    name: 'shop-devops',
    description:
      'A microservices e-shop built as a DevOps deep-dive: FastAPI services communicating over RabbitMQ, deployed to Kubernetes with Helm and ArgoCD, with Vault for secrets and a full Prometheus/Grafana observability stack.',
    tech: ['Kubernetes', 'Helm', 'ArgoCD', 'RabbitMQ', 'Vault', 'Prometheus'],
    url: 'https://github.com/sstathatos/shop-devops',
  },
  {
    name: 'Live infrastructure dashboard',
    description:
      'A public, read-only Grafana dashboard of this very cluster — request rate, latency, per-node CPU and memory, pod restarts. Coming soon.',
    tech: ['Grafana', 'Prometheus', 'kube-prometheus-stack'],
    badge: 'coming soon',
  },
];

export const education = {
  school: 'Technical University of Crete',
  url: 'https://tuc.gr',
  degree: 'BSc-MSc, Electrical and Computer Engineering',
};

export const languages = [
  { name: 'English', level: 'Fluent' },
  { name: 'German', level: 'Basic' },
];
