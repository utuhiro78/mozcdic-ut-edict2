#! /usr/bin/env ruby
# coding: utf-8

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: Apache License, Version 2.0

require 'nkf'

`rm -f edict2`
`wget -N http://ftp.edrdg.org/pub/Nihongo/edict2.gz`
`gzip -dk edict2.gz`

# Mozc の一般名詞のID
id_mozc = "1843"

filename = "edict2"
dicname = "mozcdic-ut-edict2.txt"

# edict2 を読み込む
file = File.new(filename, "r")
	lines = file.read.encode("UTF-8", "EUC-JP")
	lines = lines.split("\n")
file.close

# 確認用に UTF-8 で出力
dicfile = File.new("edict2_utf8.txt", "w")
	dicfile.puts lines
dicfile.close

l2 = []
p = 0

lines.length.times do |i|
	# 全角スペースで始まるエントリはスキップ
	if lines[i][0] == "　" ||
	# 名詞のみを収録
	lines[i].index(" /(n") == nil
		next
	end

	s = lines[i].split(" /(n")[0]

	# 表記と読みに分ける
	if s.index(" [") == nil
		# カタカナ語には読みが付与されていないので、表記から読みを作る。
		# 表記または読みが複数ある場合は、それぞれ最初のものだけを採用する。
		# ブラックコーヒー;ブラック・コーヒー /(n) black coffee/EntL1113820X/
		hyouki = s.split(";")[0]
		yomi = hyouki
	else
		# 表記または読みが複数ある場合は、それぞれ最初のものだけを採用する。
		# 暗唱;暗誦;諳誦 [あんしょう;あんじゅ(暗誦,諳誦)(ok)] /(n,vs,vt) recitation/reciting from memory/EntL1154570X/
		s = s.split(" [")
		yomi = s[1].split(";")[0]
		yomi = yomi.sub("]", "")
		hyouki = s[0].split(";")[0]
	end

	hyouki = hyouki.split("(")[0]
	yomi = yomi.split("(")[0]
	yomi = yomi.tr(" ・=", "")

	# 読みが2文字以下の場合はスキップ
	if yomi[2] == nil ||
	# 表記が1文字の場合はスキップ
	hyouki[1] == nil ||
	# 表記が26文字以上の場合はスキップ。候補ウィンドウが大きくなりすぎる
	hyouki[25] != nil
		next
	end

	# 読みのカタカナをひらがなに変換
	yomi = NKF.nkf("--hiragana -w -W", yomi)
	yomi = yomi.tr("ゐゑ", "いえ")

	# 表記の全角英数を半角に変換
	hyouki = NKF.nkf("-m0Z1 -W -w", hyouki)

	l2[p] = [yomi, id_mozc, id_mozc, "8000", hyouki]
	l2[p] = l2[p].join("	")
	p = p + 1
end

lines = l2
l2 = []

# 重複する行を削除
lines = lines.uniq.sort

dicfile = File.new(dicname, "w")
	dicfile.puts lines
dicfile.close
