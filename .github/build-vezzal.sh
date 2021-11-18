docker pull vezzal/vezzal:v1
docker run -id --name update-vezzal vezzal/vezzal:v1 bash | exit
docker cp -a $GITHUB_WORKSPACE/testcases update-vezzal:/vezzal
docker commit update-vezzal vezzal/vezzal:v1
docker stop update-vezzal
docker push vezzal/vezzal:v1
