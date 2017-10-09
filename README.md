# 部署说明
## 部署前配置修改及数据库初始化
1. 运行
*doc/初始化.sql*
1. 修改application.properties中数据库相关配置
```
spring.datasource.driver-class-name=oracle.jdbc.driver.OracleDriver
spring.datasource.url=jdbc\:oracle\:thin\:@127.0.0.1\:1521\:orcl
spring.datasource.username=kettle
spring.datasource.password=kettle
```
hibernate不能自动识别数据库类型则需要制定类型
```
spring.jpa.database-platform=org.hibernate.dialect.Oracle10gDialect
```

## 部署&运行
> 这里只提供说明tomcat如何运行作为参考

1. run maven install（会生产target目录）
1. 配置tomcat，指定项目路径为target目录下生成的
*项目名-版本*
的文件夹或者.war即可
1. 运行tomcat
