pipeline {
    agent any

    environment {
        IAAS_CHANGES = 'false'
        LANDSCAPES_CHANGES = 'false'

        // Change the below values to your own values

        // The below value is the path to the service account key file, the environment variable GOOGLE_APPLICATION_CREDENTIALS is used by the terraform to authenticate with the GCP, and the name of the variable is fixed.
        // Refer to the terraform documentation for more information: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#adding-credentials

        GOOGLE_APPLICATION_CREDENTIALS = credentials("gcp_credentials")
        GCP_PROJECT = credentials("gcp_project_id")
        PUB_KEY_PATH = credentials("proj_pub_key")
    }

    stages {

        stage('Initialize') {
            steps {
                echo 'Initializing...'
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                echo 'Checking out the code...'
                checkout scm
            }
        }

        stage('Check Changes') {
            steps {
                script {
                    // give execute permission to the private key

                    sh 'chmod 600 $PUB_KEY_PATH'

                    sh 'git --version'

                    def changes = sh(script: 'git diff --name-only HEAD^ HEAD', returnStdout: true).trim()

                    changes = changes.split('\n')
                    
                    echo "Changes detected in the following files: ${changes}"
                    
                    for (change in changes) {
                        if (change.startsWith('core/iaas')) {
                            IAAS_CHANGES = 'true'
                        } else if (change.startsWith('core/landscapes')) {
                            LANDSCAPES_CHANGES = 'true'
                        }
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    if (IAAS_CHANGES == 'true') {
                        echo 'Changes detected in core/iaas folder, initializing the terraform...'
                        dir('core/iaas') {
                            sh 'terraform init'
                        }
                    } else {
                        echo 'No changes detected in core/iaas folder, skipping the terraform init...'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (IAAS_CHANGES == 'true') {
                        echo 'Changes detected in core/iaas folder, planning the terraform...'
                        dir('core/iaas') {
                            sh 'terraform plan -var-file="prod.tfvars" -var pub_key_path=${PUB_KEY_PATH} -var project=${GCP_PROJECT}'
                        }
                    } else {
                        echo 'No changes detected in core/iaas folder, skipping the terraform plan...'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (IAAS_CHANGES == 'true') {
                        echo 'Changes detected in core/iaas folder, applying the changes to the hyperscaler...'
                        dir('core/iaas') {
                            sh 'terraform apply -auto-approve -var-file="prod.tfvars" -var pub_key_path=${PUB_KEY_PATH} -var project=${GCP_PROJECT}'
                        }
                    } else {
                        echo 'No changes detected in core/iaas folder, skipping the terraform apply...'
                    }
                }
            }
        }
    }
}
