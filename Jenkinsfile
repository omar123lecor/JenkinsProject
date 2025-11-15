pipeline {
    agent any

    stages {

        stage('Checkout code') {
            steps {
                echo '📥 Cloning repository...'
                checkout scm
            }
        }
        stage('Start Databases') {
            steps {
                echo '🗄 Starting MySQL and Postgres...'
                sh 'docker compose up -d mysql postgres'
                sh 'echo "Waiting for databases to be ready..."'
                // optional: simple wait, or a better check loop
                sh 'sleep 15'  // waits 15 seconds for containers to initialize
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
