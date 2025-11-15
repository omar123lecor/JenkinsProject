pipeline {
    agent any

    stages {



        stage('Run ETL') {
            steps {
                sh 'docker compose run --rm etl'
            }
        }

        stage('Run dbt Transformations') {
            steps {
                sh 'docker compose run --rm dbt run'
            }
        }

        stage('Run dbt Tests') {
            steps {
                sh 'docker compose run --rm dbt test'
            }
        }
    }
}
