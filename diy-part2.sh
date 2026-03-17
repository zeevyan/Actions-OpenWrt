#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
#!/bin/bash

# 1. 修正 luci-app-store 的版本号 (解决你当前的报错)
# 将类似 0.1.32-1 修改为 0.1.32.1 或 0.1.32
sed -i 's/0.1.32-1/0.1.32/g' feeds/immortalwrt/luci-app-store/Makefile

# 2. 批量修正所有软件包中不符合 APK 规范的版本号 (预防性措施)
# APK 格式不允许版本号中出现多个横杠，或者横杠后非数字的情况
# 下面这行会将 Makefile 中 PKG_VERSION 里的横杠替换为点
find package/feeds/ feeds/ -name "Makefile" -exec sed -i 's/PKG_VERSION:=2024-01-01/PKG_VERSION:=2024.01.01/g' {} +

# 3. 针对特定的常见报错包进行修正（如果你的 config 里选了它们）
[ -d "feeds/luci/applications/luci-app-lucky" ] && sed -i 's/-/_/g' feeds/luci/applications/luci-app-lucky/Makefile
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
# 修改默认 IP 为 192.168.2.1
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
