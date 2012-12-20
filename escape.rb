# -*- coding: UTF-8 -*-
require 'json'

#ディレクトリ内を検索
FILE_PATH="./json/"
FILE_OUT_PATH="./json_new/"


# 半角英数文字だけかどうか判別する
def hankaku?(str)
  return nil if str.nil?
  unless str.to_s =~ /^[ -~｡-ﾟ\s]*$/
    return false
  end
   return true
end


# 日本語文字をエスケープ　ユニコードエスケープする
def escape(str)
  if hankaku?(str) then
  	return str
  end	
  @tmpstr=""
  str.each_codepoint { |cp| @tmpstr = @tmpstr+"\\u" + cp.to_s(16) }
  
  return @tmpstr
end


#ディレクトリ内のjsonファイルを取得し処理する
Dir::glob(FILE_PATH+"*.json").each {|f|
  puts "#{f}: #{File::stat(f).size} bytes"
  puts File::basename(f)

  f = open(f)
  f_contents = f.read
  f.close
  @tmp=""
  f_contents.each_char{|cell|
	@tmp << escape(cell).to_s
  }
  #　ファイル書き込み
  of = File.open(FILE_OUT_PATH+File::basename(f),'w')
  of.puts @tmp
  of.close

}
