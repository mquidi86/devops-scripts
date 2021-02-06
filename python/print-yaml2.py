import yaml,sys

#Data: |-

yaml_str = "version: 0.2\n\nphases:\n  install:\n    runtime-versions:\n      docker: 18\n  pre_build:\n    commands:\n      - echo Logging in to Amazon ECR...\n      - aws --version\n      - $(aws ecr get-login --region us-west-2 --no-include-email)\n      - REPOSITORY_URI=688655246536.dkr.ecr.us-west-2.amazonaws.com/ea-voltron-tracker\n      - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)\n      - IMAGE_TAG=build-$(echo $CODEBUILD_BUILD_ID | awk -F\":\" '{print $2}')\n  build:\n    commands:\n        - echo Build started on `date`\n        - echo Building the Docker image...\n        - docker build -t $REPOSITORY_URI:latest --rm .\n        - docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$IMAGE_TAG\n  post_build:\n    commands:\n      - echo Build completed on `date`\n      - echo Pushing the Docker images...\n      - docker push $REPOSITORY_URI:latest\n      - docker push $REPOSITORY_URI:$IMAGE_TAG\n      - echo Writing image definitions file...\n      - printf '[{\"name\":\"ea-voltron-tracker\",\"imageUri\":\"%s\"}]' $REPOSITORY_URI:$IMAGE_TAG > imagedefinitions.json\nartifacts:\n    files: imagedefinitions.json\n\n"

data2 = str(sys.stdin.read().rstrip())
print(data2)
#data = yaml.safe_load("\n""" + data2 + "\n""")
print("hola")
#data = yaml.safe_load(str(sys.stdin.read()))
data = yaml.safe_load(data2)
#data = yaml.safe_load(yaml_str)

#print(data)
print(yaml.dump(data))
#print(yaml.dump(sys.stdin.read()))
