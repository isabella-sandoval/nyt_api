class SearchesController < ApplicationController

def index
    @searches = Search.all
    render json: @searches
end

def show
    @search = Search.find_by(id: params[:id])
    render json: @search
end

def home
    render html:'Hey there! Please see the README for instructions'
end

def fetch_data
    params.permit(:author, :publisher, :description, :title, :sort)
    
    sql_string = ""
    query_string = ""
    sort_by = params[:sort] ? params[:sort].downcase : "title"
    
    inputs = [:author, :publisher]
    
    inputs.each do |input|
        if(params[input].present?)
            sql_string += " OR "if(sql_string.length > 1)
            sql_string += "lower(#{input}) LIKE '%#{params[input].downcase}%'"
            
            query_string += "&"if(sql_string.length > 1)
            query_string += "#{input}=#{params[input].downcase}"
        end
    end
    
    sql_string = "SELECT * FROM searches WHERE #{sql_string} ORDER BY #{sort_by}"
    results = Search.find_by_sql(sql_string)
    

    cached_results = Rails.cache.read("#{sql_string}")
    #check cache
    if cached_results
        render json: cached_results
        
    #check db
    elsif results.present?
        render json: results
        Rails.cache.write("#{sql_string}", results)

    #fetch from api 
    else
    response = RestClient.get("https://api.nytimes.com/svc/books/v3/lists/best-sellers/history.json?#{query_string}&api-key=#{ENV["API_KEY"]}")
    books_array = JSON.parse(response)["results"]

    books = books_array.each do |book|
        Search.create(title: book["title"], description: book["description"], author: book["author"], publisher: book["publisher"])
    end
        render json: books
    end

    end

end
