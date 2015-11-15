#####################################################
# Schema Design                                     #
#####################################################

@Posts = new Meteor.Collection 'posts'

Schemas.Comment = new SimpleSchema
  user:
    type: String
  comment:
    type: String
  createdAt:
    type: Date
    index: true
  photos:
    type: [Object]
    blackbox: true
  files:
    type: [Object]
    blackbox: true

Schemas.Post = new SimpleSchema
  owner:
    type: String
    index: true
  group:
    type: String
    index: true
    sparse: true
  title:
    type: String
  createdAt:
    type: Date
    index: true
  description:
    type: String
  background:
    type: Object
    blackbox: true
  photos:
    type: [Object]
    blackbox: true
  files:
    type: [Object]
    blackbox: true
  comments:
    type: [Schemas.Comment]
  commentCount:
    type: Number
    defaultValue: 0

Posts.attachSchema Schemas.Post

#####################################
# Helpers                           #
#####################################

Posts.helpers {}

#####################################
# Publish / Subscribe               #
#####################################

if Meteor.isServer
  Meteor.publish 'posts', ->
    Posts.find {}

if Meteor.isClient
  Meteor.subscribe 'posts'

#####################################
# Allow / Deny                      #
#####################################

Posts.allow
  insert: (userId, doc, fieldNames, modifier) ->
    userId
  update: (userId, doc, fieldNames, modifier) ->
    userId is doc.owner
  remove: (userId, doc, fieldNames, modifier) ->
    userId is doc.owner
