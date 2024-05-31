# 一、优化数据类型

在MySQL中不同的数据类型长度不同，在磁盘上所需要的存储空间也不同，如果数据库中使用不合理的数据类型，会造成很大的空间浪费，并且在数据插入与读取时，也会造成MySQL的性能低下。

-   更小的数据类型更好

如果没有特殊情况，尽量使用可以正确保存数据的最小数据类型，因为更小的数据类型在插入和读取数据时更快，占用的内存更小，CPU处理的周期也会更短。

-   使用简单的数据类型

在设计数据表时，尽量为字段设计简单的数据类型。例如能使用整型就不要使用字符串类型，因为字符串类型的比较规则更复杂，需要将字符串转化为`ANSI`码后再进行比较。

-   避免使用NULL

在没有特殊情况下，尽量将字段的类型限制为NOT NULL。软功字段允许为NULL，会使得索引、插入与更新数据变得复杂。因为在可以为NULL的列建立索引时，在使用索引时，每个索引记录都会使用一个额外的空间来记录索引列是否为NULL，并且在InnoDB存储引擎中，需要单独使用一个字节的存储空间来存储NULL值。在实际情况中可以设置默认值，例如为“”、0等。

  


# 二、删除重复索引和冗余索引

重复索引：索引名称不同，索引字段相同

冗余索引：索引最左边的部分列是重复的

```sql
mysql> show create table t_goods \G;
*************************** 1. row ***************************
       Table: t_goods
Create Table: CREATE TABLE `t_goods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `t_category_id` int DEFAULT NULL,
  `t_category` varchar(30) DEFAULT NULL,
  `t_name` varchar(50) DEFAULT NULL,
  `t_price` decimal(10,2) DEFAULT NULL,
  `t_stock` int DEFAULT NULL,
  `t_upper_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_category_name` (`t_category_id`,`t_name`),
  KEY `category_part` (`t_category`(10)),
  KEY `stock_index` (`t_stock`),
  KEY `t_upper_time_index` (`t_upper_time`),
  KEY `name_index` (`t_name`),
  KEY `category_name_index` (`t_category`,`t_name`),
  KEY `category_name_index2` (`t_category`,`t_name`),
  KEY `name_stock_index` (`t_name`,`t_stock`),
  KEY `category_name_index3` (`t_category` DESC,`t_name`),
  CONSTRAINT `foreign_category` FOREIGN KEY (`t_category_id`) REFERENCES `t_goods_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.01 sec)
```

例如在这张数据表中，`category_name_index`和`category_name_index2`索引是重复索引。这两个索引的字段完全相同。`name_index`和`name_stock_index`索引是冗余索引，因为`name_stock_index`索引中包含了`name_index`索引的字段。为什么`category_name_index3`不是重复索引呢，因为`category_name_index3`索引的`t_category`字段的顺序不同。

# 三、反范式设计

数据库设计中三大范式要求尽可能减少冗余字段，使数据库设计看起来更简单、优雅。

但是完全的遵循数据库的三大范式来设计数据库，会导致很多表之间产生很多的依赖关系，规范越高，表之间的依赖关系越多这样会导致在查询数据时，数据表之间的频繁连接，造成数据查询的性能低下。

在实际情况下，对于查询较多的夏天来说，应根据实际业务对数据库进行反范式化设计，适当的增加冗余字段，提高数据的查询效率。

需要注意的是，在增加冗余字段时，需要考虑数据的一致性问题，也就是说，当数据表A中的某个字段发生变化时，对应数据表B中也应该将相应的数据修改。

  


# 四、增加中间表

如果数据库中存在经常需要关联查询的数据表，则可以为关联查询的数据表建立一个中间表，中间表中存储多个数据表关联查询的结果数据，将对多个数据表的关联查询转化为对中间表的查询，提高查询效率。

例如创建部门表和员工表

```sql
create table t_department(
id int not null primary key auto_increment,
name varchar(30) not null default ""
);

create table t_employee(
id int not null primary key auto_increment,
name varchar(30) not null default "",
join_data DATE,
bobby varchar(100),
department int not null
)；
```

`t_employee`数据表通过`department`字段与`t_department`数据表之间进行关联。

  


使用联表查询

```sql
mysql> explain select e.name as employee_name,d.name as department_name from t_employee e left join t_department d on e.department=d.id \G;
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: e
   partitions: NULL
         type: ALL
possible_keys: NULL
          key: NULL
      key_len: NULL
          ref: NULL
         rows: 1
     filtered: 100.00
        Extra: NULL
*************************** 2. row ***************************
           id: 1
  select_type: SIMPLE
        table: d
   partitions: NULL
         type: eq_ref
possible_keys: PRIMARY
          key: PRIMARY
      key_len: 4
          ref: goods.e.department
         rows: 1
     filtered: 100.00
        Extra: NULL
2 rows in set, 1 warning (0.01 sec)
```

创建中间表，存储连接查询的信息

```sql
create table t_employee_tmp(
employee_id int not null,
employee_name varchar(30),
department_name varchar(30)
);
```

将联表查询信息导入中间表

```sql
insert into t_employee_tmp
(employee_id,employee_name,department_name)
select e.id as employee_id,e.name as employee_name,d.name as department_name
from t_employee as e left join t_department as d
on e.department =d.id;
```

查询中间表中的数据集

```sql
mysql> explain select * from t_employee_tmp \G;
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: t_employee_tmp
   partitions: NULL
         type: ALL
possible_keys: NULL
          key: NULL
      key_len: NULL
          ref: NULL
         rows: 1
     filtered: 100.00
        Extra: NULL
1 row in set, 1 warning (0.00 sec)
```

这时候只需要查询中间表的数据就可以了，不需要再进行联表查询，并且如果在中间表的查询中，适当添加索引，会更明显的提升效率。

# 五、分析数据表

当使用`ANALYZE TAVLE`来分析数据表时，MYSQL会自动为数据表添加一个只读的锁，此时，只能对数据表中的数据进行读取操作而不能进行写入和更新操作。

```sql
mysql> analyze table  t_goods;
+---------------+---------+----------+----------+
| Table         | Op      | Msg_type | Msg_text |
+---------------+---------+----------+----------+
| goods.t_goods | analyze | status   | OK       |
+---------------+---------+----------+----------+
1 row in set (0.05 sec)

mysql> analyze table  t_goods \G;
*************************** 1. row ***************************
   Table: goods.t_goods
      Op: analyze
Msg_type: status
Msg_text: OK
1 row in set (0.01 sec)
```

| Table    | 当前分析的数据表的名称                                                    |
| -------- | -------------------------------------------------------------- |
| Op       | 当前执行的操作                                                        |
| Msg_type | 输出结果信息的类型，包括status(状态)、info(信息)、note(注意)、warning(警告)、erroe(错误) |
| Msg_test | 结果信息                                                           |

# 六、检查数据表

当使用`CHECK TABLE`语句检查数据表时，MySQL会自动为数据表添加读锁。

```sql
 check table t_goods\G；
+-------------+-------+----------+-----------------------------------+
| Table       | Op    | Msg_type | Msg_text                          |
+-------------+-------+----------+-----------------------------------+
| goods.goods | check | Error    | Table 'goods.goods' doesn't exist |
| goods.goods | check | status   | Operation failed                  |
+-------------+-------+----------+-----------------------------------+
2 rows in set (0.02 sec)

mysql> check table t_goods\G
*************************** 1. row ***************************
   Table: goods.t_goods
      Op: check
Msg_type: status
Msg_text: OK
1 row in set (0.01 sec)
```

# 七、优化数据表

`OPTIMIZE TABLE`语句主要用来优化删除和更新数据造成的文件碎片。使用时，会自动添加读锁。

```sql
mysql> optimize table t_goods \G;
*************************** 1. row ***************************
   Table: goods.t_goods
      Op: optimize
Msg_type: note
Msg_text: Table does not support optimize, doing recreate + analyze instead
*************************** 2. row ***************************
   Table: goods.t_goods
      Op: optimize
Msg_type: status
Msg_text: OK
2 rows in set (0.13 sec)
```

注意，只能优化数据表中的Varchar、Blob或Text类型字段。

# 八、拆分数据表

如果一个表的字段数量比较多，某些字段的查询效率非常低。这样的字段在数据量非常大时，会严重影响数据表的性能，可以将这些字段分离出来形成新的表。

## 1、垂直拆分

```sql
mysql> show create table t_user \G;
*************************** 1. row ***************************
       Table: t_user
Create Table: CREATE TABLE `t_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `phone` varchar(14) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `hobby` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)
```

从分析可以看到，其中最常使用的是username和pasword，其他字段数据查询的频率非常低，此时可以将表拆分为两个表t_user、t_user_detail。

```sql
mysql> show create table t_user_puls \G;
*************************** 1. row ***************************
       Table: t_user_puls
Create Table: CREATE TABLE `t_user_puls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.01 sec)


mysql> show create table t_user_detail \G;
*************************** 1. row ***************************
       Table: t_user_detail
Create Table: CREATE TABLE `t_user_detail` (
  `user_id` int NOT NULL,
  `phone` varchar(14) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `hobby` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)
```

这里使用索引字段将两个表进行关联，如果只需要查询用户名和密码，就可以大大提高效率。

## 2、水平拆分

主要拆分的数据。例如将10行数据拆分为5行5行。主要用于增加数据库的存储容量。例如，根据一定的规则将数据表中的一部分数据存储到一张数据表中，另一部分存储到其他数据表中。