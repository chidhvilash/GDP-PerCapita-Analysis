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

# ╔═╡ 5856fdbe-c5e9-11eb-33d0-2d17b97b572c
begin
	using CSV
	using DataFrames
	using GLM
	using PlutoUI
	using Plots
end

# ╔═╡ b3b94edc-fd96-4403-bdc7-a1f5af651d6c
data = CSV.read("D:\\Workspace\\Machine Learning\\Indian GDP Analysis and Prediction\\Data\\Indian_gdp.csv",DataFrame)

# ╔═╡ e1c7d649-9922-4897-998f-f401ecb88158
scatter(data.year,data.GDP)

# ╔═╡ b2c5ec62-314f-4cd4-a7bc-b6e353c64398
reg = fit(LinearModel, @formula(GDP ~ year), data)

# ╔═╡ 97eb7071-cf68-4801-918d-53f9157a9f44
linear_regression = predict(reg)

# ╔═╡ a5de798c-aae2-452e-930b-6716c739b108
begin
	plot(data.year,linear_regression)
	scatter!(data.year,data.GDP)
end

# ╔═╡ 2fa71a79-93fa-43a8-9ee7-12fddeb5f971
md"Enter an year to predict GDP : $@bind y TextField()"

# ╔═╡ 6b671101-053c-4136-b3b7-37674655cccf
pyear = parse(Int64,y)

# ╔═╡ 22fa2415-d9d7-4c91-a235-0c94340d7f51
pGDP = coef(reg)[2]*pyear+coef(reg)[1]

# ╔═╡ Cell order:
# ╠═5856fdbe-c5e9-11eb-33d0-2d17b97b572c
# ╠═b3b94edc-fd96-4403-bdc7-a1f5af651d6c
# ╠═e1c7d649-9922-4897-998f-f401ecb88158
# ╠═b2c5ec62-314f-4cd4-a7bc-b6e353c64398
# ╠═97eb7071-cf68-4801-918d-53f9157a9f44
# ╠═a5de798c-aae2-452e-930b-6716c739b108
# ╠═2fa71a79-93fa-43a8-9ee7-12fddeb5f971
# ╠═6b671101-053c-4136-b3b7-37674655cccf
# ╠═22fa2415-d9d7-4c91-a235-0c94340d7f51
