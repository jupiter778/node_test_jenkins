pipeline {
    agent any

    environment {
        REPO_URL = "https://github.com/jupiter778/node_test_jenkins.git"
        K8S_NAMESPACE = "default"
        K8S_DEPLOYMENT_PATH = "k8s/deployment.yaml"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git credentialsId: 'token-github-classic',
                    url: "${REPO_URL}",
                    branch: 'main'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    echo "Deploying application to Kubernetes..."
                    kubectl apply -f $K8S_DEPLOYMENT_PATH -n $K8S_NAMESPACE
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    echo "Checking Pods status..."
                    kubectl get pods -n $K8S_NAMESPACE

                    echo "Checking Deployment rollout..."
                    kubectl rollout status deployment/node-test-app -n $K8S_NAMESPACE
                '''
            }
        }
    }
}
