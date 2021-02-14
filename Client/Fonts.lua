Fonts = {
	{Name = "Chalet Comprimé", Font = 4, Category = "Normal"},
	{Name = "Chalet", Font = 0, Category = "Normal"},
	{Name = "Sign Painter", Font = 1, Category = "Handwritten"},
	{Name = "Pricedown", Font = 7, Category = "Misc"},
}

FontCategories = {"Normal", "Handwritten", "Graffiti", "Misc"}
CategorizedFonts = {}

local AddonFonts = {
	--Normal
	{"ArialNarrow", "Arial Narrow", "Normal"},
	{"Lato", "Lato", "Normal"}, 
	-- Handwritten
	{"Inkfree", "Inkfree", "Handwritten"},
	{"Kid", "Kid", "Handwritten"},
	{"Strawberry", "Strawberry", "Handwritten"},
	{"PaperDaisy", "Paper Daisy", "Handwritten"},
	{"ALittleSunshine", "A Little Sunshine", "Handwritten"},
	{"WriteMeASong", "Write Me A Song", "Handwritten"},
	-- Graffiti
	{"BeatStreet", "Beat Street", "Graffiti"},
	{"DirtyLizard", "Dirty Lizard", "Graffiti"},
	{"Maren", "Maren", "Graffiti"},
	-- Misc
	{"HappyDay", "Happy Day", "Misc"},
	{"ImpactLabel", "Impact Label", "Misc"},
	{"Easter", "Easter", "Misc"},
}

function CreateFonts()
	-- Lets register the fonts from the files.
	for k,v in pairs(AddonFonts) do
		RegisterFontFile(v[1])
		local Id = RegisterFontId(v[2])
		table.insert(Fonts, {Name = v[2], Font = Id, Category = v[3]})
	end
	-- Lets steup our tables needed for the GUI.
	for k,v in pairs(FontCategories) do
		CategorizedFonts[v] = {}
		Menu[v] = 1
	end
	-- Lets categorize our fonts into their tables.
	for k,v in pairs(Fonts) do
		v["Base"] = k
		table.insert(CategorizedFonts[v.Category], v)
	end
end