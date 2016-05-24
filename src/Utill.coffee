
window.MapUtill = class MapUtill

	constructor: (options) ->
		@map = options.map
		@maxZoom = options.maxZoom || 30

	_calcZoom: (bounds, mapDim) ->
		WORLD_DIM =
			height: 256
			width: 256

		latRad = (lat) ->
			sin = Math.sin(lat * Math.PI / 180)
			radX2 = Math.log((1 + sin) / (1 - sin)) / 2
			Math.max(Math.min(radX2, Math.PI), -Math.PI) / 2

		zoom = (mapPx, worldPx, fraction) ->
			Math.floor(Math.log(mapPx / worldPx / fraction) / Math.LN2)

		ne = bounds.getNorthEast()
		sw = bounds.getSouthWest()

		latFraction = (latRad(ne.lat()) - latRad(sw.lat())) / Math.PI

		lngDiff = ne.lng() - sw.lng()
		lngFraction = if lngDiff < 0 then lngDiff + 360 else  lngDiff / 360

		latZoom = zoom mapDim.height, WORLD_DIM.height, Math.abs latFraction
		lngZoom = zoom mapDim.width, WORLD_DIM.width, Math.abs lngFraction

		Math.min latZoom, lngZoom, @maxZoom

	getMapSize: ->
		width: @map.getDiv().offsetWidth
		height: @map.getDiv().offsetHeight

	offsetPosition: (latlng, offsetX = 0, offsetY = 0) ->
		scale = Math.pow 2, @map.getZoom()
		projection = @map.getProjection()
		point = projection.fromLatLngToPoint latlng
		point.x = point.x + offsetX / scale / 2
		point.y = point.y + offsetY / scale / 2
		projection.fromPointToLatLng point

	setCenter: (latlng, offsetX = 0, offsetY = 0) ->
		@map.setCenter @offsetPosition latlng, offsetX, offsetY

	panTo:  (latlng, offsetX = 0, offsetY = 0) ->
		position = @offsetPosition latlng, offsetX, offsetY
		@map.panTo position

	setZoom: (zoom) ->
		@map.setZoom zoom

	fitBounds: (bounds, options = {}) ->
		left = options.left || 0
		right = options.right || 0
		top = options.top || 0
		bottom = options.bottom || 0

		size = @getMapSize()
		size.width -= right + left
		size.height -= bottom + top

		throw new Error "map with less then #{right + left}" if size.width < 0
		throw new Error "map height less then #{bottom + top}" if size.height < 0

		@setZoom @_calcZoom bounds, size

		offsetX = (right - left) #/ 2
		offsetY = (bottom - top) #/ 2
		@panTo bounds.getCenter(), offsetX, offsetY