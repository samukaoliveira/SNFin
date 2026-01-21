pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-actions-token')
        OWNER = 'samukaoliveira'
        REPO  = 'SNFin'
        WORKFLOW_FILE = 'ci.yml'
        BRANCH = 'master'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Disparar GitHub Actions') {
            steps {
                sh '''
                  curl -s -X POST \
                    -H "Authorization: Bearer $GITHUB_TOKEN" \
                    -H "Accept: application/vnd.github+json" \
                    https://api.github.com/repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_FILE/dispatches \
                    -d '{
                      "ref": "'$BRANCH'",
                      "inputs": {
                        "reason": "triggered by jenkins"
                      }
                    }'
                '''
            }
        }

        stage('Aguardar GitHub Actions') {
            steps {
                sh '''
                  set -e

                  echo "⏳ Aguardando GitHub Actions iniciar..."

                  sleep 10

                  MAX_ATTEMPTS=60
                  SLEEP_TIME=20
                  ATTEMPT=1

                  while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
                    echo "🔎 Tentativa $ATTEMPT/$MAX_ATTEMPTS"

                    RESPONSE=$(curl -s \
                      -H "Authorization: Bearer $GITHUB_TOKEN" \
                      -H "Accept: application/vnd.github+json" \
                      "https://api.github.com/repos/$OWNER/$REPO/actions/runs?event=workflow_dispatch&branch=$BRANCH")

                    RUN_ID=$(echo "$RESPONSE" | jq -r '.workflow_runs[0].id')
                    STATUS=$(echo "$RESPONSE" | jq -r '.workflow_runs[0].status')
                    CONCLUSION=$(echo "$RESPONSE" | jq -r '.workflow_runs[0].conclusion')

                    if [ "$RUN_ID" = "null" ]; then
                      echo "⚠️ Workflow ainda não iniciou"
                      sleep $SLEEP_TIME
                      ATTEMPT=$((ATTEMPT+1))
                      continue
                    fi

                    echo "🆔 Run: $RUN_ID | Status: $STATUS | Conclusion: $CONCLUSION"

                    if [ "$STATUS" = "completed" ]; then
                      if [ "$CONCLUSION" = "success" ]; then
                        echo "✅ GitHub Actions finalizou com sucesso"
                        exit 0
                      else
                        echo "❌ GitHub Actions falhou: $CONCLUSION"
                        exit 1
                      fi
                    fi

                    sleep $SLEEP_TIME
                    ATTEMPT=$((ATTEMPT+1))
                  done

                  echo "❌ Timeout aguardando GitHub Actions"
                  exit 1
                '''
            }
        }
    }

    post {
        success {
            echo "🎉 Jenkins finalizado — GitHub Actions OK"
        }
        failure {
            echo "🚨 Jenkins falhou — GitHub Actions com erro"
        }
    }
}
