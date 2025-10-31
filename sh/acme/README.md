# acme.sh 申请证书使用

## 申请证书
### HTTP模式(可实现单域名自动续期)
`acme.sh --issue -d "*.domain.com" --webroot /usr/local/docker/nginx/cert --force`

### DNS手动模式
`acme.sh --issue --dns -d "*.domain.com" --yes-I-know-dns-manual-mode-enough-go-ahead-please`

### DSN解析
申请后,会返回待验证的DNS信息,去域名服务商解析下

## 验证证书
`nslookup -q=txt _acme-challenge.x.domain`

## 生成证书(DNS)


### 手动验证
域名记录解析完成之后, 重新生成证书

`acme.sh --renew --dns -d "*.domain.com" --yes-I-know-dns-manual-mode-enough-go-ahead-please`

### 自动验证（DNS API）
支持泛域名自动续期,推荐使用


acme支持运营商: https://github.com/acmesh-official/acme.sh/blob/master/dnsapi


## 安装证书
`acme.sh --install-cert -d "*.domain.com" --key-file [key文件安装路径] --fullchain-file [crt文件安装路径] --reloadcmd "docker restart nginx"`

## 查询证书
`acme.sh --info -d domain.com`

## 删除证书
`acme.sh  --remove  -d '*.domain.com'`

## 证书自动续期
 
### 以vim打开crontab
`export EDITOR=vim`


`crontab -e`

### 自动续期输出日志
`56 * * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /root/.acme.sh/acme.sh.log 2>&1`

`crontab  -l`

