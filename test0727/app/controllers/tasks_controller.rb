# -*- encoding: utf-8 -*-
class TasksController < ApplicationController
  def index
     #@tasks = Task.all(:conditions => {:done => false},:order=>"due_date")
     @task = Task.new
     @tasks = Task.all(:conditions => {:done => false},:order=>"due_date")
  end

  def done
     @task = Task.new
     @tasks = Task.where(:done => true).order("due_date")
     render :action => 'index'
  end
 
  def create
     @task = Task.new(params[:task])
     @tasks = Task.all(:order=>"due_date")

     # 重複登録をさせないように
     # 　登録名のリストアップ
     regist_word_list= [] # Array型変数
     @tasks.each do |task|
	regist_word_list.push(task.name)
     end
     # 　重複があればなにもしない
     if regist_word_list.index(@task.name)
	# 警告メッセージくらいはだしたい
     else
	@task.save
     end

     redirect_to :tasks
  end

  def finish
     @task = Task.find(params[:id])
     @task.update_attribute(:done, false)
  
     #if @task.done == true then
     #	@task.update_attribute(:done, false)
     #else
     #	@task.update_attribute(:done, true)
     #end
     redirect_to :back
  end

  def unfinish
     @task = Task.find(params[:id])
     @task.update_attribute(:done, true)
     redirect_to :back
  end

  def delete_word_from_db
     @task = Task.find(params[:id])
     Task.delete(@task.id)
     redirect_to :back
  end

  def googleSearch
     # 検索ワードの取得
     @task = Task.find(params[:id])
     puts @task.name
     keyword = "%s" % [@task.name]
     escaped_keyword = CGI.escape(keyword)
     res_title = []

     # 検索結果　一ページ目（10個程度取得）
     url_path = "http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&q=#{escaped_keyword}"
     count_now = 0
     next_url_path, count_now, res_title = googleSearchFunction(url_path, count_now, res_title)

     count_max = 30
     # 検索結果　count_max分検索結果を取得
     while count_now <= count_max do
	next_url_path, count_now, res_title = googleSearchFunction(next_url_path, count_now, res_title)
     end

     #--- 検索結果の保存
     today=Time.now
     t = today.strftime("%y/%m/%d")

     regist_result = Result.new(:keyword=>keyword, :regist_date =>t ,
				:res1=>res_title[0],
				:res2=>res_title[1],
				:res3=>res_title[2],
				:res4=>res_title[3],
				:res5=>res_title[4],
				:res6=>res_title[5],
				:res7=>res_title[6],
				:res8=>res_title[7],
				:res9=>res_title[8],
				:res10=>res_title[9],
				:res11=>res_title[10],
				:res12=>res_title[11],
				:res13=>res_title[12],
				:res14=>res_title[13],
				:res15=>res_title[14],
				:res16=>res_title[15],
				:res17=>res_title[16],
				:res18=>res_title[17],
				:res19=>res_title[18],
				:res20=>res_title[19],
				:res21=>res_title[20],
				:res22=>res_title[21],
				:res23=>res_title[22],
				:res24=>res_title[23],
				:res25=>res_title[24],
				:res26=>res_title[25],
				:res27=>res_title[26],
				:res28=>res_title[27],
				:res29=>res_title[28],
				:res30=>res_title[29])
     regist_result.save

     puts res_title

     #render :action => 'results.html.erb'
     redirect_to :back
  end

end

def googleSearchFunction(url_path, count_now, res_title)
   # スクレイピングによる検索
   # 引数
   # urL_path   検索ページのURL
   # count_now　現在の検索結果
   # res_title　検索結果のタイトル
   #
   # 返り値
   # 次のページのURL
   # 処理終了後の検索結果数
   #

   #results = GoogleCustomSearch.search('google')

   #     results.pages.each do |result|
   #	puts result.title
   #	puts result.url
   #	puts result.description
   #     end
   #keyword = "ruby"

   #---------------------------
   #res = open("http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&q=#{escaped_keyword}")
   res = open(url_path)
   doc = Nokogiri.HTML(res)

   doc.search("div#search ol li").each_with_index do |li,idx|
      href = ""
      html = ""
      link = ""

      li.search("h3 a").each do |alink|
	 href = alink.attribute("href")
	 URI.parse(href).query.split(/&/).each do |str|
	    strs = str.split(/=/)
	    link = strs[1] if strs[0] == "q"
	 end
	 html = alink.inner_html
      end

      next if "#{href}" !~ /^\/url/
	 #puts "idx: #{idx+1}"
	 #puts "domain: #{link.split("/")[2]}"
	 #puts "link: #{link}"
	 #puts "html: #{html}"
	 #puts ""


	 res_title[count_now] ="#{html}"
      #puts "#{res_title[i]}"
      #puts ""

      count_now = count_now+1

   end

   #--- 次のページのURL ----
   nextpage_url=""
   doc.search("div#foot td").each do |str|
      if str.text.include?("次へ") then
	 nextpage_url = "http://www.google.co.jp" + str.search("a").attribute("href").text
      end
   end

   return nextpage_url, count_now, res_title
end

