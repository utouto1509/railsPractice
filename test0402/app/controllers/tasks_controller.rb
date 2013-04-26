class TasksController < ApplicationController
  def index
     @task = Task.new
     @tasks = Task.all(:conditions => { :done => false }, :order => "due_date")
  end
   
  def done
     @task = Task.new
     @tasks = Task.where(:done => true).order("due_date")
     render :action => 'index'
  end

  def create
     @task = Task.new(params[:task])
     @task.save
     redirect_to :tasks
  end

  def finish
     @task = Task.find(params[:id])
     if @task.done == true then
     	@task.update_attribute(:done, false)
     else
     	@task.update_attribute(:done, true)
     end
     redirect_to :back
  end

  def googleSearch
     @task = Task.find(params[:id])
     puts @task.name

     #results = GoogleCustomSearch.search('google')

#     results.pages.each do |result|
#	puts result.title
#	puts result.url
#	puts result.description
#     end
     #keyword = "ruby"
     
     #---------------------------
     
     keyword = "%s" % [@task.name]
     escaped_keyword = CGI.escape(keyword)

     res = open("http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&q=#{escaped_keyword}")
     doc = Nokogiri.HTML(res)
     i=0
     res_title = []
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

	if i < 3 then
	   res_title[i] ="#{html}"
	   #puts "#{res_title[i]}"
	   #puts ""
	end
	i=i+1

     end

     #---------------------------
     
     #---------------------------
     regist_result = Result.new(:keyword => keyword, :res1 => res_title[0], :res2 => res_title[1],  :res3 => res_title[2])
     regist_result.save
     #---------------------------
     
     #render :action => 'results.html.erb'
     redirect_to :back
  end

end
