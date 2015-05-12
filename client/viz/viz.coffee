Router.route('/viz/:_id'
  waitOn: ->
    return [
      Meteor.subscribe('viz')
    ]
  data: -> Models.Viz.findOne(@.params._id)
  template: "vizTemplate"
  controller: 'Controllers.BaseController'
)


Template.vizTemplate.helpers(
  counter: -> Session.get("viz");
  getClass: ()->
    if @date >= loadedDate
      "newly-clicked"
)

Template.vizTemplate.events(
  'click button': (event) ->
    event.preventDefault()
    date = new Date()
    wtf = 'wtf'
    Models.Clicks.update(@_id, {
      $set:
        {wtf, date}
    })
)
