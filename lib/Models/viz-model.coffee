Models.Viz = new Mongo.Collection('viz')

if Meteor.isServer
  Meteor.startup ->
    Meteor.publish("viz", ->
      Models.Viz.find({}, {limit: 1000})
    )

    Models.Viz.allow(Rules.allowAll)
    #Models.Clicks.allow(Rules.allowInsertElseRestrictToOwner)
