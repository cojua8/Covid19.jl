using HTTP
using JSON
using JSONTables
using DataFrames
using Dates

const api = "https://api.covid19api.com/"
const dformat = DateFormat("yyyy-mm-ddTHH:MM:SSZ")

function paisesSlugs()
    countries = HTTP.get(api * "countries")
    return Dict(jsontable(countries.body))
end

function getData(p::String, s::String)
    r = HTTP.get(api * "total/dayone/country/" * p * "/status/" * s)
    rDf = DataFrame(jsontable(r.body))
    rDf.Date = Date.(rDf.Date, dformat)
    return rDf
end



muertos(pais::String) = getData(pais, "deaths")
contagiados(pais::String) = getData(pais, "confirmed")
recuperados(pais::String) = getData(pais, "recovered")
