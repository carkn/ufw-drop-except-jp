#!/bin/bash
sh /etc/ufw/ufw_drop_except_jp/drop_except_jp.sh > /etc/ufw/after.init.drop_except_jp
systemctl restart ufw