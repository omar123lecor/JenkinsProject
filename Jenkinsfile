pipeline {
    agent any

    stages {

        stage('Checkout code') {
            steps {
                echo '📥 Cloning repository...'
                checkout scm
            }
        }

        stage('Run dbt tests') {
            steps {
                echo '🧪 Running dbt tests...'
                sh 'docker compose run --rm dbt test'
            }
        }
    }
}
