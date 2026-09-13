#!/bin/bash
# CSSのリンクに「中身から計算した版番号」を付ける。
# 中身が変わると番号も変わるので、ブラウザが必ず新しいものを読み込む。
cd "$(dirname "$0")" || exit 1
for css in style.css motion.css; do
  [ -f "$css" ] || continue
  v=$(shasum -a 256 "$css" | cut -c1-8)
  for html in *.html; do
    [ -f "$html" ] || continue
    /usr/bin/sed -i '' -E "s|href=\"${css}(\?v=[0-9a-f]+)?\"|href=\"${css}?v=${v}\"|g" "$html"
  done
  echo "  ${css} → 版番号 ${v}"
done
echo "完了しました。"
