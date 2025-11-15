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

        stage('Run dbt models') {
            steps {
                echo '🧱 Running dbt run...'
                sh 'docker compose run --rm dbt'
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
