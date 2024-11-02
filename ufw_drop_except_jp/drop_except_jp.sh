#!/bin/sh
IPTABLES=iptables

# 日本のIPリストをダウンロード
wget -q -N http://nami.jp/ipv4bycc/cidr.txt.gz
gunzip -q -f -c cidr.txt.gz > cidr.txt

if [ -f cidr.txt ]; then
  # チェインをクリア
  echo $IPTABLES -F DROP_EXCEPT_JP

  # プライベートネットワークからのアクセスを許可
  #echo $IPTABLES -A DROP_EXCEPT_JP -s 192.168.1.0/24 -j RETURN

  # 日本のIPアドレスからのアクセスを許可
  sed -n 's/^JP\t//p' cidr.txt | while read address; do
  echo $IPTABLES -A DROP_EXCEPT_JP -s $address -j RETURN
  done

  # その他すべての接続を拒否
  echo $IPTABLES -A DROP_EXCEPT_JP -j DROP
fi
