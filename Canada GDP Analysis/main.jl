### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 1a5c4360-c5ec-11eb-073d-8dc280b34894
begin
	using CSV
	using DataFrames
	using GLM
	using Plots
	using PlutoUI
end

# ╔═╡ abf556e0-810d-443c-87b1-d0f95f9c080d
data = CSV.read("D:\\Workspace\\Machine Learning\\Canada GDP Analysis\\Data\\canada_gdp.csv",DataFrame)

# ╔═╡ 02178664-f416-4505-932a-019ca57f17cb
scatter(data.year,data.GDP)

# ╔═╡ e6a9282e-b580-4fd4-bb16-e83a8e5e0105
reg = fit(LinearModel,@formula(GDP~year),data)

# ╔═╡ b55b5c14-5761-4297-8f56-c1a6fb86e67c
linear_regression = predict(reg)

# ╔═╡ 5c0c577a-3571-4d5f-90da-c5c94942673a
begin
	scatter(data.year,data.GDP)
	plot!(data.year,linear_regression)
end

# ╔═╡ e8c03cd5-12a6-45d3-80b4-20feae154e32
md"Enter a year to predict: $@bind y TextField()"

# ╔═╡ d383695f-5bb5-4b8b-8876-d856405ec8aa
pyear = parse(Int64,y)

# ╔═╡ fbb51392-e820-4317-9334-e0c722d9a423
pGDP = coef(reg)[2]*pyear+coef(reg)[1]

# ╔═╡ Cell order:
# ╠═1a5c4360-c5ec-11eb-073d-8dc280b34894
# ╠═abf556e0-810d-443c-87b1-d0f95f9c080d
# ╠═02178664-f416-4505-932a-019ca57f17cb
# ╠═e6a9282e-b580-4fd4-bb16-e83a8e5e0105
# ╠═b55b5c14-5761-4297-8f56-c1a6fb86e67c
# ╠═5c0c577a-3571-4d5f-90da-c5c94942673a
# ╠═e8c03cd5-12a6-45d3-80b4-20feae154e32
# ╠═d383695f-5bb5-4b8b-8876-d856405ec8aa
# ╠═fbb51392-e820-4317-9334-e0c722d9a423
