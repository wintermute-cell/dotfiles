local spr = app.activeSprite
if not spr then return app.alert("There's no active sprite") end

local layer = app.activeLayer
if not layer then return app.alert("There's no active layer") end

local cel = layer:cel(app.activeFrame)
if not cel then return app.alert("The layer has no cel in the current frame") end

local img = cel.image:clone()

local function calcTrimmedBounds(image)
    local left, top, right, bottom = image.width, image.height, 0, 0

    for x = 0, image.width - 1 do
        for y = 0, image.height - 1 do
            if image:getPixel(x, y) ~= Color{ a=0 } then
                if x < left then left = x end
                if x > right then right = x end
                if y < top then top = y end
                if y > bottom then bottom = y end
            end
        end
    end

    if left > right or top > bottom then return nil end
    return { x = left, y = top, width = right - left + 1, height = bottom - top + 1 }
end

local bounds = calcTrimmedBounds(img)
if not bounds then return app.alert("The layer is empty or fully transparent") end

local trimmedImg = Image(bounds.width, bounds.height, img.colorMode)
trimmedImg:drawImage(img, -bounds.x, -bounds.y)

local function saveImage(trimmedImage)
    local dlg = Dialog("Save Trimmed Image")
    dlg:file{
        id = "filepath",
        title = "Save the trimmed image:",
        open = false,
        save = true,
        filetypes = { "png" },
        filename = layer.name .. ".png"
    }
    dlg:button{
        text = "Save",
        onclick = function()
            local path = dlg.data.filepath
            if path then
                trimmedImage:saveAs(path)
                dlg:close()
            end
        end
    }
    dlg:button{ text = "Cancel", onclick = function() dlg:close() end }
    dlg:show{ wait = false }
end

saveImage(trimmedImg)

