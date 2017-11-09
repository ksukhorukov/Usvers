# USVERS

* Ruby version

2.4.2

* System dependencies

PostgreSQL

* Database setup

``rake db:setup``

* Run

``rails s``

* Mobile API

```
curl -X POST -F 'user[name]=test' -F 'user[email]=test@test.com' -F 'user[avatar]=@/tmp/ava.jpg' -F 'user[password]=passwd' -F 'user[password_confirmation]=passwd' http://localhost:3000/users.json
{"id":6,"name":"test","email":"test@test.com","created_at":"2017-11-09T13:53:01.937Z"}

curl -X POST -F 'session[email]=test@test.com' -F 'session[password]=passwd' http://localhost:3000/sessions.json 
{"status":"ok","authentication":"b8d06b18d606eccb1271caef21659b5a9ef3531f"}

curl -X GET -H 'Authentication: b8d06b18d606eccb1271caef21659b5a9ef3531f' http://localhost:3000/users.json
[{"id":6,"name":"test","email":"test@test.com","created_at":"2017-11-09T13:53:01.937Z"}]

curl -X GET -H 'Authentication: b8d06b18d606eccb1271caef21659b5a9ef3531f' http://localhost:3000/users/6.json
{"id":6,"name":"test","email":"test@test.com","created_at":"2017-11-09T13:53:01.937Z"}

curl -X PUT -H 'Authentication: b8d06b18d606eccb1271caef21659b5a9ef3531f'  -F 'user[name]=my_new_name' -F 'user[password]=passwd' -F 'user[password_confirmation]=passwd' http://localhost:3000/users/6.json 
{"id":6,"name":"my_new_name","email":"test@test.com","created_at":"2017-11-09T13:53:01.937Z"}
```
