Router.route('/'
	name: "home"
	controller: 'Controllers.BaseController'
)

backends = [
	{name: "CSV", key: "csv"}
	{name: "Google Spreadsheet", key: "gdocs"}
]

Template.home.helpers(
	backends: -> return backends
)

Template.home.events(
	'click a#next': (event) ->
		url = $("#url").val();
		back = $("#backend").val();

		id = Models.Viz.insert({
			step: 1,
			url: url,
			backend: back
			},
		)
		Router.go('/viz/' + id)
)
