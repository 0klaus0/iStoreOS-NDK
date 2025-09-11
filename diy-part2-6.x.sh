#!/bin/bash
#===============================================
# Description: DIY script for RK3566-JianPian
# File name: diy-part2-rk3566.sh
# Lisence: MIT
# Author: P3TERX (modified by 0klaus0)
#===============================================

# 1. 可選：內核配置微調（目前 6.x 已內建 SATA/USB3/LED 驅動，如無特殊需求保持註解）
# echo "CONFIG_PSI=y
# CONFIG_KPROBES=y" >> target/linux/rockchip/armv8/config-6.6

# 2. 把 DTS/DTSI 拷進內核樹（patch 已打，這裡只是雙保險，可省略）
# cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3566/*.dts* \
#        target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/

# 3. 在 image/armv8.mk 追加我們的盒子定義
cat <<EOF >> target/linux/rockchip/image/armv8.mk

define Device/jianpian_rk3566-tvbox
  DEVICE_VENDOR := JianPian
  DEVICE_MODEL := RK3566-TVBOX
  SOC := rk3566
  UBOOT_DEVICE_NAME := jianpian-rk3566
endef
TARGET_DEVICES += jianpian_rk3566-tvbox
EOF

# 4. 如果自帶了自訂 U-Boot 配置（可選）
# cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/Makefile \
#       package/boot/uboot-rockchip/Makefile
# cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/jianpian-rk3566_defconfig \
#       package/boot/uboot-rockchip/src/configs/
# cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3566/*.dts* \
#       package/boot/uboot-rockchip/src/arch/arm/dts/

# 5. 限速插件（可選，需要的話打開）
# git clone --depth=1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus
