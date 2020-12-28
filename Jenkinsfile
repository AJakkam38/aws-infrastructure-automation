
pipeline {

    parameters {
        string(name: 'branchName', defaultValue: 'main', description: 'Github branch name ')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
        options {
                timestamps ()
                ansiColor('xterm')
            }

    stages {

        stage('Plan') {
            steps {
                sh 'terraform init -input=false'
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
                    parameters: [text(name: 'Plan', description: 'Please press Abort or Proceed', defaultValue: 'Please checkout the plan in the Console output')]
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