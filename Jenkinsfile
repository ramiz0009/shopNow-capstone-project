pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "eu-west-2"
        TFVARS_FILE       = "prod.tfvars"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out Git repository..."
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir('shopnow-infra') {
                    echo "Initializing Terraform..."
                    sh '''
                      terraform init -upgrade
                    '''
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('shopnow-infra') {
                    echo "Validating Terraform files..."
                    sh '''
                      terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('shopnow-infra') {
                    echo "Creating Terraform plan..."
                    sh '''
                      terraform plan -var-file=${TFVARS_FILE} -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('shopnow-infra') {
                    echo "Applying Terraform plan..."
                    sh '''
                      terraform apply -auto-approve tfplan
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Terraform pipeline completed successfully"
        }
        failure {
            echo "❌ Terraform pipeline failed"
        }
    }
}
