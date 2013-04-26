class ResultsController < ApplicationController
  $key

  def hyoji
     @hoge = params[:hoge]
     @results = Result.all(:conditions => {:keyword => @hoge})
     $key = @hoge
  end

  def csvexport
     require 'csv'
     @results= Result.all
     data = CSV.generate do |csv|
	csv << ["keyword","date","res1","res2","res3"]
	@results.each do |result|
	   csv << [result.regist_date, result.res1, result.res2, result.res3]
	end
     end
     send_data(data, type: 'text/csv', filename: "#{$key}.csv")
  end

end
