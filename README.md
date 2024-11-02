# ufw-drop-except-jp
国外からのアクセスをufwでブロックする  
# 手順
## ufwの設定変更
1. /etc/ufw/before.rules ファイルのCOMMITの前に以下3行を追加する
```
:DROP_EXCEPT_JP - [0:0]
-A DROP_EXCEPT_JP -j ACCEPT
-A ufw-before-input -j DROP_EXCEPT_JP
# don't delete the 'COMMIT' line or these rules won't be processed
COMMIT
```
  
2. /etc/ufw/after.init ファイルに以下を記述する
```
start)
    # typically required
    /etc/ufw/after.init.drop_except_jp
    ;;
stop)
    # typically required
    iptables -F DROP_EXCEPT_JP
    ;;
```

3. /etc/ufw/after.init に実行権限を与える
```
chmod +x /etc/ufw/after.init
```
※ after.init は実行権を与えなければいけない

## スクリプトの配置
/etc/ufw 以下にufw_drop_execpt_jpを配置する
```
cp -R ./ufw_drop_execpt_jp /etc/ufw
```
配置後、実行権を与える
```
chmod +x /etc/ufw/ufw_drop_execpt_jp/drop_except_jp.sh
```

## ufwへの反映
```
sh /etc/ufw/ufw_drop_except_jp/drop_except_jp.sh | tee /etc/ufw/after.init.drop_except_jp > /dev/null
systemctl restart ufw
```

## cronへ登録
```
cp ./cron.daily/iplist_update.sh /etc/cron.daily/
chmod +x /etc/cron.daily/iplist_update.sh
chown root. /etc/cron.daily/iplist_update.sh
```
