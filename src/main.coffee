
map = new google.maps.Map document.getElementById('map'),
	center:
		lat: -34.397,
		lng: 150.644
	zoom: 8

util = new MapUtill {map}

google.maps.event.addListenerOnce map, 'idle', ->

	p1 = new google.maps.LatLng 45.5983128 ,8.8172776
	p2 = new google.maps.LatLng(45.4355729, 9.169236)
	bounds = new google.maps.LatLngBounds p1, p2

	#draw rectangle
	rectangle = new google.maps.Rectangle
		bounds: bounds
		map: map
		strokeColor: 'red'
		fillOpacity: 0

	dimentions = ['left','right','bottom','top']
	$el = {}
	dimentions.map (item) ->
		$el[item] =
			panel: $ ".panel__#{item}"
			input: $ "#input-#{item}"

	change = ->
		offset = {}
		val = ($el) -> parseInt($el.val(), 10) || 0
		dimentions.map (dim) ->
			v = offset[dim] = val $el[dim].input
			if dim == 'left' || dim == 'right'
				$el[dim].panel.width v
			else
				$el[dim].panel.height v
			$el[dim].input.next().text "#{v} px"

		util.fitBounds bounds, offset


	change()

	$('input').on 'input', change





#	fitOffset bounds




#
#	b2 = testBounds bounds,
#		offsetTop: 0
#		offsetLeft: 0
#		offsetRight: 0
#		offsetBottom: 20
#
#	rectangle = new google.maps.Rectangle
#		bounds: b2
#		map: map
#		strokeColor: 'blue'
#		fillOpacity: 0
#
#	map.fitBounds b2

#	google.maps.event.addListenerOnce map, 'idle', ->
#
#		zoom = map.getZoom()
#		scale = Math.pow 2, zoom
#
#		centerPoint = bounds.getCenter()
#		marker = new google.maps.Marker
#			label: 'C'
#			map: map,
#			position:centerPoint
#
#		new google.maps.Marker
#			map: map,
#			label: 'A'
#			position: testCenter centerPoint, 0, -200/2



#		projection = map.getProjection()
#		topRight = projection.fromLatLngToPoint map.getBounds().getNorthEast()
#		bottomLeft = projection.fromLatLngToPoint map.getBounds().getSouthWest()
#
#
#		point = projection.fromLatLngToPoint bounds.getCenter()
#
#		posLeft = (point.x - bottomLeft.x) * scale
#		posTop = (point.y - topRight.y) * scale
#		console.log posLeft, posTop, bottomLeft.toString()
#
#
#		$point = $ "<div class='point'></div>"
#		$point.css
#			left: posLeft
#			top: posTop
#		$('.container').append $point





		# 1) fit bounds
		# 2) calc height
		#3) fit againe
#
#
#
#		window.p = projection = map.getProjection()
#
#
#		center = bounds.getCenter()
#		pointA = projection.fromLatLngToPoint(center)
#		world = project center
#
#
#		pixelCoordinate = new google.maps.Point(
#			Math.floor(world.x ),
#			Math.floor(world.y ))
#
#
#		console.log pointA.x , pointA.y, pixelCoordinate.toString()
#
#
#
#
#
#		#projection.fromPointToLatLng()
#
#		point = new google.maps.Point 100, 100
#		console.log point.toString()
#
#
#		markerPosition = projection.fromPointToLatLng point
#
#
#		console.log markerPosition.toString()
#
#		marker = new google.maps.Marker
#			position: markerPosition,
#			map: map

#	map.panTo markerPosition

	#aPoint = proj.fromLatLngToPoint latlng
	#	aPoint.x = aPoint.x + offsetX / scale
	#	aPoint.y = aPoint.y + offsetY / scale
	#	lnew = proj.fromPointToLatLng aPoint


#	widthOfPanel = 450;
#	degreesPerPx = (360 / (Math.pow(2, zoom))) / 256



	#marker = new google.maps.Marker({
	#	position: myPlace,
	#	map: map})

	#.extend p1
	#.extend p2
