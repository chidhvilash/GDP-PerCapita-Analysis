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

# ╔═╡ 230fdd70-c5ef-11eb-01d9-371bb366387d
begin
	using CSV
	using DataFrames
	using Plots
	using GLM
	using PlutoUI
end

# ╔═╡ 2d3fad52-f1ac-4383-ad78-782c5265148d
data = CSV.read("D:\\Workspace\\Machine Learning\\World GDP Analysis and Prediction\\Data\\World_GDP.csv",DataFrame)

# ╔═╡ 1a4f31a3-5b58-4f4f-8513-a416fd795ad5
scatter(data.year,data.GDP)

# ╔═╡ 79e34de2-59b5-4bdb-b16e-93c64d2010a2
reg = fit(LinearModel,@formula(GDP~year),data)

# ╔═╡ 35d8c82f-d32c-4c2c-8934-280b39761320
linear_regression = predict(reg)

# ╔═╡ 3d4580cb-eb49-4979-9063-60a03c4072b2
begin
	scatter(data.year,data.GDP)
	plot!(data.year,linear_regression)
end

# ╔═╡ 7b0a2af1-148f-42f7-87f6-3a237c00f8cf
md"Enter an year to predict : $@bind y TextField()"

# ╔═╡ 342439a5-e524-40a3-85a7-43a78cf07596
pyear = parse(Int64,y)

# ╔═╡ 75394533-5d15-47c2-9a34-5d98ffd25900
pGDP = coef(reg)[2] * pyear + coef(reg)[1]

# ╔═╡ Cell order:
# ╠═230fdd70-c5ef-11eb-01d9-371bb366387d
# ╠═2d3fad52-f1ac-4383-ad78-782c5265148d
# ╠═1a4f31a3-5b58-4f4f-8513-a416fd795ad5
# ╠═79e34de2-59b5-4bdb-b16e-93c64d2010a2
# ╠═35d8c82f-d32c-4c2c-8934-280b39761320
# ╠═3d4580cb-eb49-4979-9063-60a03c4072b2
# ╠═7b0a2af1-148f-42f7-87f6-3a237c00f8cf
# ╠═342439a5-e524-40a3-85a7-43a78cf07596
# ╠═75394533-5d15-47c2-9a34-5d98ffd25900
