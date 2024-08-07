pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhubv1'
        DOCKER_IMAGE_NAME = 'my-docker-app'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY = 'docker.io'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_TAG}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS_ID}", url: "${DOCKER_REGISTRY}"]) {
                        docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_TAG}").tag("${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}")
                        docker.image("${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}").push("${DOCKER_TAG}")
                    }
                }
            }
        }
        
        stage('Cleanup') {
            steps {
                script {
                    sh 'docker system prune -f'
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker system prune -f'
            }
        }
    }
}

