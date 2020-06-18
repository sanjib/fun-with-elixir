# CURL

```console
% curl -XPOST http://localhost:4000/pledges -d "name=larry&amount=100"
larry pledged amount 100
% curl -XPOST http://localhost:4000/pledges -d "name=moe&amount=200"
moe pledged amount 200
% curl -XPOST http://localhost:4000/pledges -d "name=curly&amount=300"
curly pledged amount 300
% curl -XPOST http://localhost:4000/pledges -d "name=daisy&amount=400"
daisy pledged amount 400
% curl -XPOST http://localhost:4000/pledges -d "name=grace&amount=500"
grace pledged amount 500
```