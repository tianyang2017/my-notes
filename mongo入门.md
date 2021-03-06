[TOC]

首先从  [下载 MongoDB](http://www.mongodb.org/downloads ) 的最新版本

D:\software>cd MongoDB\Server\3.0\bin

D:\software\MongoDB\Server\3.0\bin> mongod.exe --dbpath "d:\software\MongoDB\Server\3.0\data" 

现在运行的MongoDB，需要打开一个命令提示符，发出以下命令

D:\software\MongoDB\Server\3.0\bin>mongo.exe

### 创建数据库

 use DATABASE_NAME 用于创建数据库。该命令如果数据库不存在，将创建一个新的数据库， 否则将返回现有的数据库。

如果想创建一个数据库名称为 mydb, 使用命令：use mydb

如果想查询数据库列表，那么使用命令 show dbs

所创建的数据库（mydb）不存在于列表中。要显示的数据库，需要至少插入一个文档进去。MongoDB的默认数据库是test。 如果没有创建任何数据库，那么集合将被保存在测试数据库。

db.dropDatabase() 命令用于删除现有的数据库。

### 创建集合

db.createCollection(name, options) 用于创建集合。 在命令中, name 是要创建集合的名称。 Options 是一个文档，用于指定集合的配置


| 字段 | 类型 | 描述 |
| ---- | ---- | ---- |
|capped	|Boolean|	（可选）如果为true，它启用上限集合。上限集合是一个固定大小的集合，当它达到其最大尺寸会自动覆盖最老的条目。 如果指定true，则还需要指定参数的大小。|
|autoIndexID|	Boolean	|（可选）如果为true，自动创建索引_id字段。默认的值是 false.|
|size	|number	|（可选）指定的上限集合字节的最大尺寸。如果capped 是true，那么还需要指定这个字段。|
|max	|number	|（可选）指定上限集合允许的最大文件数。|



db.createCollection("mycol", { capped : true, autoIndexID : true, size : 6142800, max : 10000 } )



 db.collection.drop() 用于从数据库中删除集合。

### 插入文档
将数据插入到MongoDB集合，需要使用MongoDB 的 insert() 方法。

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
要以单个查询插入多个文档，可以通过文档 insert() 命令的数组方式。
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

如果显示结果是格式化的，可以用db.mycol.find().pretty()

要查询基于OR条件的文件，需要使用$or关键字。
```
db.mycol.find(
   {
      $or: [
	     {key1: value1}, {key2:value2}
      ]
   }
).pretty()
```
考虑mycol集合有如下数据。
```
{ "_id" : ObjectId(5983548781331adf45ec5), "title":"MongoDB Overview"}
{ "_id" : ObjectId(5983548781331adf45ec6), "title":"NoSQL Overview"}
{ "_id" : ObjectId(5983548781331adf45ec7), "title":"Yiibai Yiibai Overview"}
```
将其标题“MongoDB Overview”的文件为新标题为“New MongoDB Tutorial”

db.mycol.update({'title':'MongoDB Overview'},{$set:{'title':'New MongoDB Tutorial'}})

默认情况下，MongoDB将只更新单一文件，如果更新多个需要一个参数 'multi' 设置为 true。

db.mycol.update({'title':'MongoDB Overview'},{$set:{'title':'New MongoDB Tutorial'}},{multi:true})

删除所有的文件，其标题为 'MongoDB Overview'

db.mycol.remove({'title':'MongoDB Overview'})

如果有多个记录，并要删除仅第一条记录，然后在 remove()方法设置参数 justOne 。

db.COLLECTION_NAME.remove(DELETION_CRITERIA,1)



### 创建索引字段

是按名称升序排序。若以按降序创建索引，需要使用 -1

db.COLLECTION_NAME.ensureIndex({KEY:1})

db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])

### 建立一个副本集

mongod --port 27017 --dbpath "D:\software\MongoDB\Server\3.0\mongodb\data" --replSet rs0

现在打开启动命令提示符，然后连接到mongod实例，在Mongo的客户端使用命令rs.initiate()来启动一个新的副本集，要检查副本设置配置，则使用命令rs.conf()，要检查副本集发行的状态，使用命令rs.status()

### MongoDB创建备份

备份指定的mongod实例的所有数据库	

mongodump --host yiibai.com --port 27017



mongodump --dbpath /data/db/ --out /data/backup/

此命令将仅备份指定的特定数据库集合

mongodump --collection mycol --db test

### 数据恢复

要恢复备份的MongoDB数据，则使用mongorestore命令。该命令将从备份目录恢复所有的数据。

### 查询修改语句
```
db.mycol.find({},{'name':1,'scriptkey':1,'executetime':1,'lastexecutetime':1,'cachetime':1,'syn':1,'reportfunc':1});

db.mycol.update( {'scriptkey':{$ne:'010'}} ,{ $set : { 'executetime':'23:11:00','lastexecutetime':'2017-05-22 23:11:00',"syn" : null} },false,true );

db.mycol.update( {} , { $set : {"exetype" : null} },false,true );
db.mycol.find({});
db.mycol.find({'scriptkey':{$ne:'010'}});
db.mycol.update({},{$unset:{'syn':''}},false, true);
```