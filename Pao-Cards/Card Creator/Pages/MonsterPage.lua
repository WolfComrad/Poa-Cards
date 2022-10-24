local http = require("socket.http")
local ltn12 = require"ltn12"
local json = require "dkjson"
local body = {}



response = table.concat(body)

local suit = require 'suit'
local Scene = {}

local typebox = {text = "typebox"}
local effectbox = {text = "effectbox"}
local rarebox = {text = "rarebox"}
local classbox = {text = "classbox"}

local name = {text = ""}
local hp = {text = ""}
local damage = {text = ""}
local class = {text = ""}
local effect = {text = ""}
local rarity = {text = ""}
local ctype = {text = ""}

local image
function Scene.load()
end

function Scene.update(dt)
    ctype = {text = "Monster"}
    suit.layout:reset(100,0)

    suit.Label("Monster card Creater", {align = "center"}, suit.layout:row(200,50))

    suit.layout:row(200,15)

    suit.Label("What is the name?", {align = "left"}, suit.layout:row(200,14))

    suit.layout:row(200,0)

    if suit.Input(name, suit.layout:row(200,30)).hovered then

        suit.Label(name.text, {align = "left"}, suit.layout:col())

    end
    suit.layout:reset(100,109)

    suit.layout:row(200,25)


  suit.Label("What is the health?", {align = "left"}, suit.layout:row(200,14))

   suit.layout:row(200,0)

   if suit.Input(hp, suit.layout:row(200,30)).hovered then

       suit.Label(hp.text, {align = "left"}, suit.layout:col())
    
    end
    suit.layout:reset(100,178)

   suit.layout:row(200,25)

    suit.Label("What is the damage?", {align = "left"}, suit.layout:row(200,14))

    suit.layout:row(200,0)

    if suit.Input(damage, suit.layout:row(200,30)).hovered then

        suit.Label(damage.text, {align = "left"}, suit.layout:col())

    end
    suit.layout:reset(100,247)

    suit.layout:row(200,25)


    suit.Label("What is the card class?", {align = "left"}, suit.layout:row(200,14))

    suit.layout:row(200,0)

    suit.Checkbox(classbox, {align='right'}, suit.layout:row(20,20))

   if classbox.checked then
    rows = suit.layout:rows{pos = {310,260}, min_height = 300,
    {100, 30},
    {100, 30},
    {100, 30},
    {100,30},
}
    option1 = suit.Button("Tank", {align="left", font = smallerFont}, rows.cell(1))

    if option1.hit then
        class = {text = "Tank"}
    end    
    option2 = suit.Button("Support", {align="left", font = smallerFont}, rows.cell(2))

    if option2.hit then
        class = {text = "Support"}
    end 
    option3 = suit.Button("Damage", {align="left", font = smallerFont}, rows.cell(3))

    if option3.hit then
        class = {text = "Damage"}
    end    
    option4 = suit.Button("Healer", {align="left", font = smallerFont}, rows.cell(4))

    if option4.hit then
        class = {text = "Healer"}
    end 
   end
    suit.layout:reset(100,316)

    suit.layout:row(200,25)

    suit.Label("What is the effect?", {align = "left"}, suit.layout:row(200,14))

    suit.layout:row(200,0)

    suit.Checkbox(effectbox, {align='right'}, suit.layout:row(20,20))

   if effectbox.checked then
    rows = suit.layout:rows{pos = {310,350}, min_height = 300,
    {100, 30},
    {100, 30},
    {100, 30},
    {100, 30},
    {100, 30},
}
    effect1 = suit.Button("Damge", {align="left", font = smallerFont}, rows.cell(1))
    if effect1.hit then
        effect = {text = effect.text .. " Damage"}
    end 

    effect2 = suit.Button("Damage buff", {align="left", font = smallerFont}, rows.cell(2))
    if effect2.hit then

        effect = {text = effect.text .. " Damage buff"}
    end 

    effect3 = suit.Button("Defensive", {align="left", font = smallerFont}, rows.cell(3))
    if effect3.hit then
        effect = {text = effect.text .. " Defensive"}
    end 

    effect4 = suit.Button("Defense buff", {align="left", font = smallerFont}, rows.cell(4))
    if effect4.hit then
        effect = {text = effect.text .. " Defense buff"}
    end 

    effect5 = suit.Button("Healing", {align="left", font = smallerFont}, rows.cell(5))
    if effect5.hit then
        effect = {text = effect.text .. " Healing"}
    end 
   end
    suit.layout:reset(100,375)

    suit.layout:row(200,25)


    suit.Label("What is the rarity?", {align = "left"}, suit.layout:row(200,14))

    suit.layout:row(200,0)

    suit.Checkbox(rarebox, {align='right'}, suit.layout:row(20,20))

   if rarebox.checked then
    rows = suit.layout:rows{pos = {310,400}, min_height = 300,
    {100, 30},
    {100, 30},
    {100, 30},
    {100, 30},
}
    rare1 = suit.Button("Normal", {align="left", font = smallerFont}, rows.cell(1))
    if rare1.hit then
        rarity = {text = "Healing"}
    end 

    rare2 = suit.Button("Rare", {align="left", font = smallerFont}, rows.cell(2))
    if rare2.hit then
        rarity = {text = "Healing"}
    end 

    rare3 = suit.Button("Lengendary", {align="left", font = smallerFont}, rows.cell(3))
    if rare3.hit then
        rarity = {text = "Healing"}
    end 

    rare4 = suit.Button("Special", {align="left", font = smallerFont}, rows.cell(4))
    if rare4.hit then
        rarity = {text = "Healing"}
    end 
   end

    suit.layout:reset(100,430)

    suit.layout:row(200,25)

    if suit.Button("Back", suit.layout:row(70,50)).hit then
        SM.load("MenuPage")
        SM.unload("MonsterPage")
    end

    suit.layout:col(60,50)
    
    if suit.Button("Submit", suit.layout:col(70,50)).hit then
        print(name.text)
        print(hp.text)
        print(damage.text)
        print(class.text)
        print(effect.text)
        print(rarity.text)
        print(ctype.text)

        local request_body = { cardName = name.text, CardType = ctype.text, cardEffect = effect.text} --the json body
        request_body = json.encode(request_body)
        local res, code, headers, status = http.request {
            method = "POST",
            url = "http://127.0.0.1:8002/createCard",
            source = ltn12.source.string(request_body),
            headers = {
                ["content-type"] = "application/json",
                ["content-length"] = string.len(request_body)
            },
            sink = ltn12.sink.table(response_body)
        }
        response = table.concat(body)
        
    end
end

function Scene.draw()
    love.graphics.setBackgroundColor(0.8, 0, 0, 0)
    suit.draw()
end

function love.textinput(t)
	-- forward text input to SUIT
	suit.textinput(t)
end

function love.keypressed(key)
	-- forward keypresses to SUIT
	suit.keypressed(key)
end

function love.filedropped(file)
	file:open("r")
	local data = file:read()
	print("Content of " .. file:getFilename() .. ' is')
	print(data)
	print("End of file")
end

return Scene