
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
	new google.maps.Rectangle
		bounds: bounds
		map: map
		strokeColor: 'red'
		fillOpacity: 0

	$el = {}
	['left','right','bottom','top'].map (item) ->
		$el[item] =
			panel: $ ".panel__#{item}"
			input: $ "#input-#{item}"

	change = ->
		offset =
			top: 0
			bottom: 0
			left: 0
			right: 0

		val = ($el) -> parseInt($el.val(), 10) || 0

		#left
		v = offset.left = val $el.left.input
		$el.left.panel.width v
		$el.left.input.next().text "#{v} px"

		#right
		v = offset.right = val $el.right.input
		$el.right.panel.width v
		$el.right.input.next().text "#{v} px"

		#top
		v = offset.top = val $el.top.input
		$el.top.panel.width v
		$el.top.input.next().text "#{v} px"

		#bottom
		v = offset.bottom = val $el.bottom.input
		$el.bottom.panel.width v
		$el.bottom.input.next().text "#{v} px"

		util.fitBounds bounds, offset

	#add input listener
	$('input').on 'input', change

	#update panels and fit map
	change()
