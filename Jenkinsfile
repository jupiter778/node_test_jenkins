pipeline {
    agent any

    environment {
        REPO_URL         = "https://github.com/jupiter778/node_test_jenkins.git"

        LOCAL_IMAGE_NAME = "myapp"
        LOCAL_TAG        = "latest"

        // GitHub Container Registry (GHCR)
        GHCR_USER        = "jupiter778"
        GHCR_REPO        = "node_test_jenkins"
        GHCR_IMAGE       = "ghcr.io/${GHCR_USER}/${GHCR_REPO}:${LOCAL_TAG}"

        // KCMO Registry (ตัวอย่าง)
        KCMO_REGISTRY    = "registry.kcmo.com"
        KCMO_REPO        = "myteam/myapp"
        KCMO_IMAGE       = "${KCMO_REGISTRY}/${KCMO_REPO}:${LOCAL_TAG}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git credentialsId: 'token-aws', url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                echo "Building Docker Image..."
                docker build -t ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} .
                '''
            }
        }

        stage('Tag Image') {
            steps {
                sh '''
                echo "Tagging images..."
                docker tag ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} ${GHCR_IMAGE}
                docker tag ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} ${KCMO_IMAGE}
                '''
            }
        }

        stage('Login to GitHub Container Registry') {
            steps {
                withCredentials([string(credentialsId: 'ghcr-token', variable: 'GHCR_TOKEN')]) {
                    sh '''
                    echo "Login to GHCR..."
                    echo $GHCR_TOKEN | docker login ghcr.io -u ${GHCR_USER} --password-stdin
                    '''
                }
            }
        }

        stage('Push to GitHub Container Registry') {
            steps {
                sh '''
                echo "Pushing to GHCR..."
                docker push ${GHCR_IMAGE}
                '''
            }
        }

        stage('Login to KCMO Registry') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'kcmo-registry',
                        usernameVariable: 'KCMO_USER',
                        passwordVariable: 'KCMO_PASS'
                    )
                ]) {
                    sh '''
                    echo "Login to KCMO Registry..."
                    echo $KCMO_PASS | docker login ${KCMO_REGISTRY} -u $KCMO_USER --password-stdin
                    '''
                }
            }
        }

        stage('Push to KCMO Registry') {
            steps {
                sh '''
                echo "Pushing to KCMO Registry..."
                docker push ${KCMO_IMAGE}
                '''
            }
        }
    }
}
