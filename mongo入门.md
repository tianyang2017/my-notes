[TOC]

���ȴ�  [���� MongoDB](http://www.mongodb.org/downloads ) �����°汾

D:\software>cd MongoDB\Server\3.0\bin

D:\software\MongoDB\Server\3.0\bin> mongod.exe --dbpath "d:\software\MongoDB\Server\3.0\data" 

�������е�MongoDB����Ҫ��һ��������ʾ����������������

D:\software\MongoDB\Server\3.0\bin>mongo.exe

### �������ݿ�

 use DATABASE_NAME ���ڴ������ݿ⡣������������ݿⲻ���ڣ�������һ���µ����ݿ⣬ ���򽫷������е����ݿ⡣

����봴��һ�����ݿ�����Ϊ mydb, ʹ�����use mydb

������ѯ���ݿ��б���ôʹ������ show dbs

�����������ݿ⣨mydb�����������б��С�Ҫ��ʾ�����ݿ⣬��Ҫ���ٲ���һ���ĵ���ȥ��MongoDB��Ĭ�����ݿ���test�� ���û�д����κ����ݿ⣬��ô���Ͻ��������ڲ������ݿ⡣

db.dropDatabase() ��������ɾ�����е����ݿ⡣

### ��������

db.createCollection(name, options) ���ڴ������ϡ� ��������, name ��Ҫ�������ϵ����ơ� Options ��һ���ĵ�������ָ�����ϵ�����


| �ֶ� | ���� | ���� |
| ---- | ---- | ---- |
|capped	|Boolean|	����ѡ�����Ϊtrue�����������޼��ϡ����޼�����һ���̶���С�ļ��ϣ������ﵽ�����ߴ���Զ��������ϵ���Ŀ�� ���ָ��true������Ҫָ�������Ĵ�С��|
|autoIndexID|	Boolean	|����ѡ�����Ϊtrue���Զ���������_id�ֶΡ�Ĭ�ϵ�ֵ�� false.|
|size	|number	|����ѡ��ָ�������޼����ֽڵ����ߴ硣���capped ��true����ô����Ҫָ������ֶΡ�|
|max	|number	|����ѡ��ָ�����޼������������ļ�����|



db.createCollection("mycol", { capped : true, autoIndexID : true, size : 6142800, max : 10000 } )



 db.collection.drop() ���ڴ����ݿ���ɾ�����ϡ�

### �����ĵ�
�����ݲ��뵽MongoDB���ϣ���Ҫʹ��MongoDB �� insert() ������

```
db.mycol.insert({
   _id: ObjectId(7df78ad8902c),
   title: 'MongoDB Overview', 
   description: 'MongoDB is no sql database',
   by: 'yiibai tutorials',
   url: 'http://www.yiibai.com',
   tags: ['mongodb', 'database', 'NoSQL'],
   likes: 100
})
```
Ҫ�Ե�����ѯ�������ĵ�������ͨ���ĵ� insert() ��������鷽ʽ��
```
db.post.insert([
{
   title: 'MongoDB Overview', 
   description: 'MongoDB is no sql database',
   by: 'yiibai tutorials',
   url: 'http://www.yiibai.com',
   tags: ['mongodb', 'database', 'NoSQL'],
   likes: 100
},
{
   title: 'NoSQL Database', 
   description: 'NoSQL database doesn't have tables',
   by: 'yiibai tutorials',
   url: 'http://www.yiibai.com',
   tags: ['mongodb', 'database', 'NoSQL'],
   likes: 20, 
   comments: [	
      {
         user:'user1',
         message: 'My first comment',
         dateCreated: new Date(2013,11,10,2,35),
         like: 0 
      }
   ]
}
])
```

�����ʾ����Ǹ�ʽ���ģ�������db.mycol.find().pretty()

Ҫ��ѯ����OR�������ļ�����Ҫʹ��$or�ؼ��֡�
```
db.mycol.find(
   {
      $or: [
	     {key1: value1}, {key2:value2}
      ]
   }
).pretty()
```
����mycol�������������ݡ�
```
{ "_id" : ObjectId(5983548781331adf45ec5), "title":"MongoDB Overview"}
{ "_id" : ObjectId(5983548781331adf45ec6), "title":"NoSQL Overview"}
{ "_id" : ObjectId(5983548781331adf45ec7), "title":"Yiibai Yiibai Overview"}
```
������⡰MongoDB Overview�����ļ�Ϊ�±���Ϊ��New MongoDB Tutorial��

db.mycol.update({'title':'MongoDB Overview'},{$set:{'title':'New MongoDB Tutorial'}})

Ĭ������£�MongoDB��ֻ���µ�һ�ļ���������¶����Ҫһ������ 'multi' ����Ϊ true��

db.mycol.update({'title':'MongoDB Overview'},{$set:{'title':'New MongoDB Tutorial'}},{multi:true})

ɾ�����е��ļ��������Ϊ 'MongoDB Overview'

db.mycol.remove({'title':'MongoDB Overview'})

����ж����¼����Ҫɾ������һ����¼��Ȼ���� remove()�������ò��� justOne ��

db.COLLECTION_NAME.remove(DELETION_CRITERIA,1)



### ���������ֶ�

�ǰ����������������԰����򴴽���������Ҫʹ�� -1

db.COLLECTION_NAME.ensureIndex({KEY:1})

db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])

### ����һ��������

mongod --port 27017 --dbpath "D:\software\MongoDB\Server\3.0\mongodb\data" --replSet rs0

���ڴ�����������ʾ����Ȼ�����ӵ�mongodʵ������Mongo�Ŀͻ���ʹ������rs.initiate()������һ���µĸ�������Ҫ��鸱���������ã���ʹ������rs.conf()��Ҫ��鸱�������е�״̬��ʹ������rs.status()

### MongoDB��������

����ָ����mongodʵ�����������ݿ�	

mongodump --host yiibai.com --port 27017



mongodump --dbpath /data/db/ --out /data/backup/

�����������ָ�����ض����ݿ⼯��

mongodump --collection mycol --db test

### ���ݻָ�

Ҫ�ָ����ݵ�MongoDB���ݣ���ʹ��mongorestore���������ӱ���Ŀ¼�ָ����е����ݡ�

### ��ѯ�޸����
```
db.mycol.find({},{'name':1,'scriptkey':1,'executetime':1,'lastexecutetime':1,'cachetime':1,'syn':1,'reportfunc':1});

db.mycol.update( {'scriptkey':{$ne:'010'}} ,{ $set : { 'executetime':'23:11:00','lastexecutetime':'2017-05-22 23:11:00',"syn" : null} },false,true );

db.mycol.update( {} , { $set : {"exetype" : null} },false,true );
db.mycol.find({});
db.mycol.find({'scriptkey':{$ne:'010'}});
db.mycol.update({},{$unset:{'syn':''}},false, true);
```