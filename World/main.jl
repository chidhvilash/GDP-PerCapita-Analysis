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

# ╔═╡ c7df3890-c5f0-11eb-0ef8-d5f1224128ed
begin
	using CSV
	using DataFrames
	using Plots
	using GLM
	using PlutoUI
	using Statistics
end

# ╔═╡ 45f5bb32-1451-4fa6-9d94-1f1e6078e478
md"# GDP PerCapita Income Analysis and Prediction using Linear Regression"

# ╔═╡ 5ae1d16f-5e5b-4bee-8fa4-e16291e04069
md"## Packages used:"

# ╔═╡ 57589c61-1a9e-4463-8fb4-d716d748265d
md"## Read the data using CSV and DataFrames: You can find the Dataset form [here](https://github.com/chidhvilash/GDP-per-capita-Linear-Regression/tree/main/Dataset)"

# ╔═╡ fd2070bf-e385-4c8b-aec6-5d70218407a2
data = CSV.read("D:\\Workspace\\Machine Learning\\GDP Analysis\\All country\\Data\\World_GDP_2020.csv",DataFrame)

# ╔═╡ 1dc9ec31-b8bf-45ee-af9b-bc34b5d95605
md"**NOTE:**Missing values are replaced with median value of the GDP"

# ╔═╡ 048b3f49-fc6a-4627-8456-e03d4db386be
md"**Lets analyse the data of India,USA and Canada**"

# ╔═╡ 59bf180e-e4dc-4088-b671-0f255e04b8e7
begin	
	plot(data.year,data.IND,title="Indian vs USA vs Canada",yaxis="GDP",xaxis="years")
	plot!(data.year,data.CAN,colour="red")
	plot!(data.year,data.USA,colour="green")
end

# ╔═╡ 3e0bc932-ea9a-4102-b117-1aa844b3271b
md"**To make this notebook Interactive I have added more additional stuff to it like selecting countries, Input value to predict etc.... You can even do directly without creating a alternate arry as below.**"

# ╔═╡ c0548b0e-5a96-4ab5-b784-2be5a247377e
coun = ("ABW	AFG	AGO	ALB	AND	ARB	ARE	ARG	ARM	ASM	ATG	AUS	AUT	AZE	BDI	BEL	BEN	BFA	BGD	BGR	BHR	BHS	BIH	BLR	BLZ	BMU	BOL	BRA	BRB	BRN	BTN	BWA	CAF	CAN	CEB	CHE	CHI	CHL	CHN	CIV	CMR	COD	COG	COL	COM	CPV	CRI	CSS	CUB	CUW	CYM	CYP	CZE	DEU	DJI	DMA	DNK	DOM	DZA	EAP	EAR	EAS	ECA	ECS	ECU	EGY	EMU	ERI	ESP	EST	ETH	EUU	FCS	FIN	FJI	FRA	FRO	FSM	GAB	GBR	GEO	GHA	GIB	GIN	GMB	GNB	GNQ	GRC	GRD	GRL	GTM	GUM	GUY	HIC	HKG	HND	HPC	HRV	HTI	HUN	IBD	IBT	IDA	IDB	IDN	IDX	IMN	IND	INX	IRL	IRN	IRQ	ISL	ISR	ITA	JAM	JOR	JPN	KAZ	KEN	KGZ	KHM	KIR	KNA	KOR	KWT	LAC	LAO	LBN	LBR	LBY	LCA	LCN	LDC	LIC	LIE	LKA	LMC	LMY	LSO	LTE	LTU	LUX	LVA	MAC	MAF	MAR	MCO	MDA	MDG	MDV	MEA	MEX	MHL	MIC	MKD	MLI	MLT	MMR	MNA	MNE	MNG	MNP	MOZ	MRT	MUS	MWI	MYS	NAC	NAM	NCL	NER	NGA	NIC	NLD	NOR	NPL	NRU	NZL	OED	OMN	OSS	PAK	PAN	PER	PHL	PLW	PNG	POL	PRE	PRI	PRK	PRT	PRY	PSE	PSS	PST	PYF	QAT	ROU	RUS	RWA	SAS	SAU	SDN	SEN	SGP	SLB	SLE	SLV	SMR	SOM	SRB	SSA	SSD	SSF	SST	STP	SUR	SVK	SVN	SWE	SWZ	SXM	SYC	SYR	TCA	TCD	TEA	TEC	TGO	THA	TJK	TKM	TLA	TLS	TMN	TON	TSA	TSS	TTO	TUN	TUR	TUV	TZA	UGA	UKR	UMC	URY	USA	UZB	VCT	VEN	VGB	VIR	VNM	VUT	WLD	WSM	XKX	YEM	ZAF	ZMB	ZWE")

# ╔═╡ b61a5400-6667-4500-ae24-a30118c8930f
coun1 = split(coun,"\t")

# ╔═╡ 5c5d200f-5177-4850-b097-35228bb8ec3d
md"**Please select the country name for the analysis and Prediction**
$@bind country Select(coun1)
"

# ╔═╡ 4b9f6d4d-bcc1-4512-ab04-919dcbe70e15
md"**Scatter plot of selected countries GDP**"

# ╔═╡ ef6b4555-187e-44aa-9736-97842f7908ff
scatter(data[:,country],yaxis="GDP",xaxis="years",title="Scatter Plot of $country")

# ╔═╡ e22edf5a-3c8a-42b3-8eb5-9a6843e5e5f7
md"**Below table provides us the year and GDP of the selected country**"

# ╔═╡ e5c3a93f-4221-4746-9c72-aed3382c9829
data2 = (y=float(data.year),z = data[:,country])

# ╔═╡ 912c2ce5-9e9c-437c-81a9-68402a687d42
md"**Now let us replace missing values with median of the entire GDP value of that country**"

# ╔═╡ e9d842ee-2020-498b-9ccb-51ce7d417807
replace!(data2.z, missing => median(skipmissing(data2.z)))

# ╔═╡ 13fee9d5-5c4f-4aa3-a99a-15387d3c8418
md"**Now Let us find the Coefficents: Intercept and Slope**"

# ╔═╡ 79b94b7c-2d2e-474f-82c8-e421fcb7b984
reg = fit(LinearModel,@formula(z~y),data2)

# ╔═╡ e34d411c-1569-4bc1-9489-7c27cc71125b
md"**Now let us predict the Line**"

# ╔═╡ 61f49974-7a0d-4083-b714-4e0f942f22d2
linear_regression = predict(reg)

# ╔═╡ a80795ec-1d90-4aa4-a557-e92955302f56
md"**As you can see below the we have the plot of predicted line and the scatter plot of the given dataset**"

# ╔═╡ 2c13d909-78c1-4dbe-8de5-5c6ca3b95791
begin
	scatter(data2.y,data2.z,label="Scatter Plot")
	plot!(data2.y,linear_regression,label="Predicted Line")
end

# ╔═╡ 9c093e8a-142e-4f18-a7ba-2cc2fdf6c8e0
md"**Select year for future prediction**: $@bind yr NumberField(2020:2100)"

# ╔═╡ e86667e0-50a7-4ffa-a9f5-e0304148f179
md"**Predicted GDP of $country in year $yr:** "

# ╔═╡ 99a505e6-6e5b-4c13-a59c-64ae1bdc9c24
pGDP = coef(reg)[2] * yr + coef(reg)[1]

# ╔═╡ 5d1c7d64-fa5b-482a-b3fb-700ba2190c11


# ╔═╡ Cell order:
# ╟─45f5bb32-1451-4fa6-9d94-1f1e6078e478
# ╟─5ae1d16f-5e5b-4bee-8fa4-e16291e04069
# ╠═c7df3890-c5f0-11eb-0ef8-d5f1224128ed
# ╟─57589c61-1a9e-4463-8fb4-d716d748265d
# ╠═fd2070bf-e385-4c8b-aec6-5d70218407a2
# ╟─1dc9ec31-b8bf-45ee-af9b-bc34b5d95605
# ╟─048b3f49-fc6a-4627-8456-e03d4db386be
# ╠═59bf180e-e4dc-4088-b671-0f255e04b8e7
# ╟─3e0bc932-ea9a-4102-b117-1aa844b3271b
# ╟─c0548b0e-5a96-4ab5-b784-2be5a247377e
# ╟─b61a5400-6667-4500-ae24-a30118c8930f
# ╟─5c5d200f-5177-4850-b097-35228bb8ec3d
# ╟─4b9f6d4d-bcc1-4512-ab04-919dcbe70e15
# ╠═ef6b4555-187e-44aa-9736-97842f7908ff
# ╟─e22edf5a-3c8a-42b3-8eb5-9a6843e5e5f7
# ╠═e5c3a93f-4221-4746-9c72-aed3382c9829
# ╟─912c2ce5-9e9c-437c-81a9-68402a687d42
# ╠═e9d842ee-2020-498b-9ccb-51ce7d417807
# ╠═13fee9d5-5c4f-4aa3-a99a-15387d3c8418
# ╠═79b94b7c-2d2e-474f-82c8-e421fcb7b984
# ╟─e34d411c-1569-4bc1-9489-7c27cc71125b
# ╠═61f49974-7a0d-4083-b714-4e0f942f22d2
# ╟─a80795ec-1d90-4aa4-a557-e92955302f56
# ╠═2c13d909-78c1-4dbe-8de5-5c6ca3b95791
# ╟─9c093e8a-142e-4f18-a7ba-2cc2fdf6c8e0
# ╟─e86667e0-50a7-4ffa-a9f5-e0304148f179
# ╠═99a505e6-6e5b-4c13-a59c-64ae1bdc9c24
# ╟─5d1c7d64-fa5b-482a-b3fb-700ba2190c11
