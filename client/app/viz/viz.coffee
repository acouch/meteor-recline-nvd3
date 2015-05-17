Router.route('/viz/:_id'
  waitOn: ->
    return [
      Meteor.subscribe('viz')
    ]
  data: -> Models.Viz.findOne(@.params._id)
  template: "viz"
  controller: 'Controllers.BaseController'
)

Template.viz.onCreated ->
  instance = Template.instance();
  options = [
    {name: "CSV", key: "csv"}
    {name: "Google Spreadsheet", key: "gdocs"}
  ]
  instance.step = ReactiveVar(instance.data.step);
  instance.options = ReactiveVar(options);
  instance.ready = ReactiveVar(false);

  this.autorun ->
    step = instance.step.get();

    subscriptions = Meteor.subscribe("viz", step);

    if (subscriptions.ready())
      instance.ready.set(true)
    else
      instance.ready.set(false)
    return

Template.viz.helpers(
  bombs: -> Template.instance().bombs()
  isReady: -> Template.instance().ready().get()
  step: -> Template.instance().step.get()
  options: -> Template.instance().options.get()
  step1: ->
    step = Template.instance().step.get()
    console.log(step)
    if step == 1
      console.log("step is 1")
      true
    else
      console.log("step is 2")
      false
)

Template.viz.events(
  'click #next': (event, instance) ->
    event.preventDefault()
    step = instance.step.get()
    step += 1
    instance.step.set(step)
    Models.Viz.update(@_id, {
      $set:
        {step}
    })

  'click #prev': (event, instance) ->
    event.preventDefault()
    step = instance.step.get()
    step -= 1
    instance.step.set(step)
    Models.Viz.update(@_id, {
      $set:
        {step}
    })

  'focusout #url': (event, instance) ->
    console.log(event)
    options = [
      {name: "buts", key: "csv"}
      {name: "Google Spreadsheet", key: "gdocs"}
    ]
    instance.options.set(options)
)
