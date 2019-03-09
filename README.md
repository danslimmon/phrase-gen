# deploying

```
sudo docker build -t phrase-gen .
```

Tag and push to repo.

If using ECS, go to the Service, click Update, select Force New Deployment, and proceed. You may have to manually stop the old task once the new one is deployed.
