def credentialId = 'CREDENCIAL AWS'

pipeline {

    agent {
        node {
            label 'master'
        }
    }

    options {
        buildDiscarder logRotator(
                    daysToKeepStr: '16',
                    numToKeepStr: '10'
            )
    }
    
    
    stages {

        stage('Validate Terraform setup') {
            when {
                branch 'main' 
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: "${credentialId}", secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        script{
                            echo "credentialId: $credentialId"
                            echo "Validating Terraform..."
                            sh 'terraform -v'
                            sh 'terraform init'  
                        }
                }
            }
        }

        stage('Validate infraestructure') {
            when {
                branch 'main' 
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: "${credentialId}", secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                
                    echo "Validating infra..."
                    sh 'terraform validate' //use -check-variables=false when version <=0.11
                }
            }
        }
        
        stage('Provision infrastructure') {
            when {
                branch 'main' 
            }
            steps {    
                script{
                    
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: "${credentialId}", secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                            echo "--------- Executing Terraform apply plan main... ------------"
                            sh 'terraform workspace select main || terraform workspace new main'
                            sh 'terraform init'
                            sh 'terraform plan -var-file=environment/main/env.main.tfvars -out=plandev'
                            sh 'terraform apply planmain' 
                        }             

                }
            }
        }
    }
    post { 
        always { 
            cleanWs()
        }
    }
}