
// Declarative Pipeline

pipeline {

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')

    }

   agent  any
        options {
                timestamps ()
                ansiColor('xterm')
            }
            
    stages {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', \
                            accessKeyVariable: 'AWS_ACCESS_KEY_ID', \
                            credentialsId: 'AWS_CREDENTIALS', \
                            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                
            stage('checkout') {
                steps {
                    script{
                            dir("terraform")
                            {
                                git "git@github.com:AJakkam38/aws-infrastructure-automation.git"
                            }
                    }
                }
            }

            stage('Plan') {
                steps {
                    sh 'terraform init -input=false'
                    sh 'terraform workspace new ${environment}'
                    sh 'terraform workspace select ${environment}'
                    sh 'terraform plan -input=false -out tfplan'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
            }
            
            stage('Approval') {
                when {
                    not {
                        equals expected: true, actual: params.autoApprove
                    }
                }

                steps {
                    script {
                        def plan = readFile 'tfplan.txt'
                        input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                    }
                }
            }

            stage('Apply') {
                steps {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

  }