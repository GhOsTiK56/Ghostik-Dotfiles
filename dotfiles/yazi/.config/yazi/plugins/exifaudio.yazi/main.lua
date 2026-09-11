local M = {}

function GetPath(str)
	local sep = "/"
	if ya.target_family() == "windows" then
		sep = "\\"
	end
	return str:match("(.*" .. sep .. ")")
end

function Exiftool(...)
	local child = Command("exiftool")
		:arg({
			"-q",
			"-q",
			"-S",
			"-Title",
			"-SortName",
			"-TitleSort",
			"-TitleSortOrder",
			"-Artist",
			"-SortArtist",
			"-ArtistSort",
			"-PerformerSortOrder",
			"-Album",
			"-SortAlbum",
			"-AlbumSort",
			"-AlbumSortOrder",
			"-AlbumArtist",
			"-SortAlbumArtist",
			"-AlbumArtistSort",
			"-AlbumArtistSortOrder",
			"-Genre",
			"-TrackNumber",
			"-Year",
			"-Duration",
			"-SampleRate",
			"-AudioSampleRate",
			"-AudioBitrate",
			"-AvgBitrate",
			"-Channels",
			"-AudioChannels",
			tostring(...),
		})
		:stdout(Command.PIPED)
		:stderr(Command.NULL)
		:spawn()
	return child
end

function Mediainfo(...)
	local file, cache_dir = ...
	local template = cache_dir .. "mediainfo.txt"

	local child = Command("mediainfo")
		:arg({
			"--Output=file://" .. template,
			tostring(file),
		})
		:stdout(Command.PIPED)
		:stderr(Command.NULL)
		:spawn()

	return child
end

function M:peek(job)
	local cache = ya.file_cache(job)
	if not cache then
		return
	end

	local cache_dir = GetPath(tostring(cache))

	local status, child = pcall(Mediainfo, job.file.url, cache_dir)
	if not status or child == nil then
		status, child = pcall(Exiftool, job.file.url)
		if not status or child == nil then
			local err = ui.Line({ ui.Span("Make sure exiftool is installed and in your PATH") })
			local p = ui.Text(err):area(job.area):wrap(ui.Wrap.YES)
			ya.preview_widget(job, { p })
			return
		end
	end

	local limit = 200
	local i, metadata = 0, {}

	repeat
		local _, event = child:read_line()
		if event == 1 then
			return
		elseif event ~= 0 then
			break
		end

		local line = child:read_line()
		i = i + 1

		if i > job.skip and line then
			local title, value = Prettify(line)
			if title ~= "" and value ~= "" then
				table.insert(
					metadata,
					ui.Line({
						ui.Span(title):bold(),
						ui.Span(value),
					})
				)
				table.insert(metadata, ui.Line({}))
			end
		end
	until i >= limit

	--------------------------------------------------------------------
	-- ОБЛОЖКА: левый верхний угол
	--------------------------------------------------------------------
	local cover_width = math.floor(job.area.w * 0.72)
	local cover_height = math.floor(job.area.h * 0.55)

	local cover = ui.Rect({
		x = job.area.x,
		y = job.area.y,
		w = cover_width,
		h = cover_height,
	})

	--------------------------------------------------------------------
	-- ТЕКСТ: под обложкой
	--------------------------------------------------------------------
	local text_area = ui.Rect({
		x = job.area.x,
		y = job.area.y + cover_height + 1,
		w = job.area.w,
		h = math.max(0, job.area.h - cover_height - 1),
	})

	local p = ui.Text(metadata):area(text_area):wrap(ui.Wrap.YES)
	ya.preview_widget(job, { p })

	if self:preload(job) then
		ya.image_show(cache, cover)
	end
end

function Prettify(metadata)
	local substitutions = {
		Sortname = "Sort Title:",
		SortName = "Sort Title:",
		TitleSort = "Sort Title:",
		TitleSortOrder = "Sort Title:",
		ArtistSort = "Sort Artist:",
		SortArtist = "Sort Artist:",
		Artist = "Artist:",
		ARTIST = "Artist:",
		PerformerSortOrder = "Sort Artist:",
		SortAlbumArtist = "Sort Album Artist:",
		AlbumArtistSortOrder = "Sort Album Artist:",
		AlbumArtistSort = "Sort Album Artist:",
		AlbumSortOrder = "Sort Album:",
		AlbumSort = "Sort Album:",
		SortAlbum = "Sort Album:",
		Album = "Album:",
		ALBUM = "Album:",
		AlbumArtist = "Album Artist:",
		Genre = "Genre:",
		GENRE = "Genre:",
		TrackNumber = "Track Number:",
		Year = "Year:",
		Duration = "Duration:",
		AudioBitrate = "Bitrate:",
		AvgBitrate = "Average Bitrate:",
		AudioSampleRate = "Sample Rate:",
		SampleRate = "Sample Rate:",
		AudioChannels = "Channels:",
	}

	for k, v in pairs(substitutions) do
		metadata = metadata:gsub(k .. ":", v, 1)
	end

	local t = {}
	for s in metadata:gmatch("([^:]+)") do
		table.insert(t, s)
	end

	local title, value = "", ""
	if t[1] then
		title = t[1] .. ":"
		value = table.concat(t, ":", 2)
	end

	return title, value
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		ya.manager_emit("peek", {
			tostring(math.max(0, cx.active.preview.skip + job.units)),
			only_if = tostring(job.file.url),
		})
	end
end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	local mediainfo_template = [[
General;"\
$if(%Track%,Title: %Track%,)\
$if(%Track/Sort%,Sort Title: %Track/Sort%,)\
$if(%Title/Sort%,Sort Title: %Title/Sort%,)\
$if(%TITLESORT%,Sort Title: %TITLESORT%,)\
$if(%Performer%,Artist: %Performer%,)\
$if(%Performer/Sort%,Sort Artist: %Performer/Sort%,)\
$if(%ARTISTSORT%,Sort Artist: %ARTISTSORT%,)\
$if(%Album%,Album: %Album%,)\
$if(%Album/Sort%,Sort Album: %Album/Sort%)\
$if(%ALBUMSORT%,Sort Album: %ALBUMSORT%)\
$if(%Album/Performer%,Album Artist: %Album/Performer%)\
$if(%Album/Performer/Sort%,Sort Album Artist: %Album/Performer/Sort%)\
$if(%Genre%,Genre: %Genre%)\
$if(%Track/Position%,Track Number: %Track/Position%)\
$if(%Recorded_Date%,Year: %Recorded_Date%)\
$if(%Duration/String%,Duration: %Duration/String%)\
$if(%BitRate/String%,Bitrate: %BitRate/String%)\
"\
Audio;"Sample Rate: %SamplingRate%\
Channels: %Channel(s)%"
]]

	local cache_dir = GetPath(tostring(cache))
	fs.write(Url(cache_dir .. "mediainfo.txt"), mediainfo_template)

	local output = Command("exiftool")
		:arg({
			"-b",
			"-CoverArt",
			"-Picture",
			tostring(job.file.url),
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not output then
		return false
	end

	return fs.write(cache, output.stdout) and true or false
end

return M
