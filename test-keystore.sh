#!/bin/bash

# 测试 Android Keystore 密码的脚本
# 使用方法: ./test-keystore.sh /path/to/keystore.jks

set -e

if [ $# -eq 0 ]; then
    echo "用法: $0 <keystore.jks路径>"
    echo "示例: $0 ~/my-keystore.jks"
    exit 1
fi

KEYSTORE_PATH="$1"

if [ ! -f "$KEYSTORE_PATH" ]; then
    echo "❌ 错误: 找不到文件: $KEYSTORE_PATH"
    exit 1
fi

echo "🔐 测试 Android Keystore 密码"
echo "================================"
echo ""

# 提示输入密码
read -sp "请输入 KEYSTORE 密码: " KEYSTORE_PASS
echo ""
read -sp "请输入 KEY 别名: " KEY_ALIAS
echo ""
read -sp "请输入 KEY 密码: " KEY_PASS
echo ""
echo ""

# 测试 1: 验证 keystore 密码
echo "📋 测试 1: 验证 KEYSTORE 密码..."
if keytool -list -v -keystore "$KEYSTORE_PATH" -storepass "$KEYSTORE_PASS" > /dev/null 2>&1; then
    echo "✅ KEYSTORE 密码正确"
else
    echo "❌ KEYSTORE 密码错误"
    exit 1
fi

# 测试 2: 验证 key 别名和密码
echo ""
echo "📋 测试 2: 验证 KEY 别名和密码..."
if keytool -list -v \
    -keystore "$KEYSTORE_PATH" \
    -storepass "$KEYSTORE_PASS" \
    -alias "$KEY_ALIAS" \
    -keypass "$KEY_PASS" > /dev/null 2>&1; then
    echo "✅ KEY 别名和密码正确"
else
    echo "❌ KEY 别名或密码错误"
    exit 1
fi

# 测试 3: 显示证书信息
echo ""
echo "📋 测试 3: 显示证书信息..."
keytool -list -v \
    -keystore "$KEYSTORE_PATH" \
    -storepass "$KEYSTORE_PASS" \
    -alias "$KEY_ALIAS" \
    -keypass "$KEY_PASS" | grep -E "(别名|Alias name|有效期|Valid from|证书指纹|Certificate fingerprints)"

echo ""
echo "✅ 所有测试通过！"
echo ""
echo "📝 你的配置信息："
echo "   KEYSTORE 路径: $KEYSTORE_PATH"
echo "   KEY 别名: $KEY_ALIAS"
echo "   KEYSTORE 密码: ✅ 正确"
echo "   KEY 密码: ✅ 正确"

