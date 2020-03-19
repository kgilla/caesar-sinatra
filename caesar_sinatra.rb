require 'sinatra'
require 'sinatra/reloader'

string = ""
key = ""

def encode(string, key)
  converted = ""
  string.each_byte do |c|
    if c >= 97 && c <= 122
      c = c - 97 + key
      if c > 0
        c = (c % 26) + 97
      else
        while c < 0
          c += 26
        end
        c += 97
      end
      converted << c.chr
    elsif c >= 65 && c <= 90
      c = c - 65 + key
      if c > 0
        c = (c % 26) + 65
      else
        while c < 0
          c += 26
        end
        c += 65
      end
      converted << c.chr
    else
      converted << c
    end
  end 
  return converted
end

get '/' do 
  string = params["string"]
  key = params["key"].to_i
  code = encode(string, key)
  erb :index, :locals => { 
    :code => code
  }
end
