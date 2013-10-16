class ResultsController < ApplicationController
  $key

  def hyoji
     @searchWord = params[:searchWord]
     @results = Result.all(:conditions => {:keyword => @searchWord})
     $key = @searchWord
  end

  def csvexport
     require 'csv'
     @results= Result.all
     data = CSV.generate do |csv|
	csv << ["keyword","date",
	   "res1","res2","res3","res4","res5","res6","res7","res8","res9","res10",
	   "res11","res12","res13","res14","res15","res16","res17","res18","res19","res20",
	   "res21","res22","res23","res24","res25","res26","res27","res28","res29","res30"]
	@results.each do |result|
	   # results の結果全部だしてくるので必要な要素のみ書き出しする
	   if result.keyword == $key then
	      csv << [result.regist_date,
		 result.res1,result.res2,result.res3,result.res4,result.res5,
		 result.res6,result.res7,result.res8,result.res9,result.res10,
		 result.res11,result.res12,result.res13,result.res14,result.res15,
		 result.res16,result.res17,result.res18,result.res19,result.res20,
		 result.res21,result.res22,result.res23,result.res24,result.res25,
		 result.res26,result.res27,result.res28,result.res29,result.res30]
	   end
	end
     end

     send_data(data, type: 'text/csv', filename: "#{$key}.csv")
  
     send_mail()

  end

end

  


