pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "eu-west-3"
        TFVARS_FILE       = "prod.tfvars"
    }

    parameters {
        booleanParam(
            name: 'DESTROY_INFRA',
            defaultValue: true,
            description: 'Set to true to destroy infrastructure'
        )
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
                    sh 'terraform init -upgrade'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('shopnow-infra') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression { !params.DESTROY }
            }
            steps {
                dir('shopnow-infra') {
                    sh 'terraform plan -var-file=${TFVARS_FILE} -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { !params.DESTROY_INFRA }
            }
            steps {
                dir('shopnow-infra') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.DESTROY_INFRA }
            }
            steps {
                dir('shopnow-infra') {
                    sh 'terraform destroy -auto-approve -var-file=${TFVARS_FILE}'
                }
            }
        }
    }

    post {
        success {
            script {
                if (params.DESTROY_INFRA) {
                    echo "✅ Terraform DESTROY completed successfully"
                } else {
                    echo "✅ Terraform APPLY completed successfully"
                }
            }
        }

        failure {
            script {
                if (params.DESTROY_INFRA) {
                    echo "❌ Terraform DESTROY failed — check logs"
                } else {
                    echo "❌ Terraform APPLY failed — check logs"
                }
            }
        }

        always {
            echo "ℹ️ Terraform pipeline finished (success or failure)"
        }
    }
}
