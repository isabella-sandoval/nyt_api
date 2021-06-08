class SearchesController < ApplicationController

def index
    @searches = Search.all
    render json: @searches
end

def show
    @search = Search.find_by(id: params[:id])
    render json: @search
end

def fetch_data
    params.permit(:author, :publisher, :description, :title, :sort)

    sql_string = ""
    querie_string = ""
    sort_by = params[:sort] ? params[:sort].downcase : "title"

    if(params[:author].present?)
      sql_string += " OR "if(sql_string.length > 1)
      sql_string += "lower(author) LIKE '%#{params[:author].downcase}%'"

      querie_string += "&"if(sql_string.length > 1)
      querie_string += "author=#{params[:author].downcase}"
    end

    if(params[:publisher].present?)
      sql_string += " OR "if(sql_string.length > 1)
      sql_string += "lower(publisher) LIKE '%#{params[:publisher].downcase}%'"

      querie_string += "&"if(sql_string.length > 1)
      querie_string += "publisher=#{params[:publisher].downcase}"
    end

    sql_string = "SELECT * FROM searches WHERE #{sql_string} ORDER BY #{sort_by}"
    results = Search.find_by_sql(sql_string)

    #low level caching
    # Rails.cache.fetch()
    #check db
    if results.present?
        render json: results
    else
    #fetch from api 
    response = RestClient.get("https://api.nytimes.com/svc/books/v3/lists/best-sellers/history.json?#{querie_string}&api-key=#{ENV["API_KEY"]}")
    books_array = JSON.parse(response)["results"]

    books_array.each do |book|
        Search.create(title: book["title"], description: book["description"], author: book["author"], publisher: book["publisher"])
    end
        render json: response
    end

    end

end
