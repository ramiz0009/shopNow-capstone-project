pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "eu-west-2"
        TFVARS_FILE        = "prod.tfvars"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir('shopnow-infra') {
                    withAWS(credentials: 'aws-prod', region: "${AWS_DEFAULT_REGION}") {
                        sh '''
                          terraform init -upgrade
                        '''
                    }
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('shopnow-infra') {
                    sh '''
                      terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('shopnow-infra') {
                    withAWS(credentials: 'aws-prod', region: "${AWS_DEFAULT_REGION}") {
                        sh '''
                          terraform plan -var-file=${TFVARS_FILE} -out=tfplan
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                branch "main"
            }
            steps {
                input message: "Approve Terraform Apply to PROD?"
                dir('shopnow-infra') {
                    withAWS(credentials: 'aws-prod', region: "${AWS_DEFAULT_REGION}") {
                        sh '''
                          terraform apply tfplan
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Terraform pipeline completed successfully"
        }
        failure {
            echo "Terraform pipeline failed"
        }
    }
}
