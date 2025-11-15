pipeline {
    agent any

    stages {

        stage('Checkout code') {
            steps {
                echo '📥 Cloning repository...'
                checkout scm
            }
        }


        stage('Run ETL') {
            steps {
                echo '🚀 Running ETL...'
                sh 'docker compose run --rm etl'
            }
        }


    }
}
