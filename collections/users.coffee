#####################################################
# Schema Design                                     #
#####################################################

@Users = Meteor.users
@User = -> Meteor.user.bind Meteor.user

Schemas.Profile = new SimpleSchema
  name:
    type: String
  birthday:
    type: Date
    optional: true
  avatar:
    type: Object
    blackbox: true
  background:
    type: Object
    blackbox: true

Schemas.User = new SimpleSchema
  username:
    type: String
    regEx: /^[a-z0-9A-Z_]{4,16}$/
    optional: true
    index: true
    unique: true
    sparse: true
  emails:
    type: [Object]
    optional: true
  'emails.$.address':
    type: String
    regEx: SimpleSchema.RegEx.Email
  'emails.$.verified':
    type: Boolean
  createdAt:
    type: Date
    index: true
  profile:
    type: Schemas.Profile
  services:
    type: Object
    optional: true
    blackbox: true
  roles:
    type: [String]
    blackbox: true
    optional: true

Users.attachSchema Schemas.User

#####################################
# Helpers                           #
#####################################

Users.helpers
  email: ->
    @emails?[0]?.address

#####################################
# Publish / Subscribe               #
#####################################

if Meteor.isServer
  Meteor.publish 'users', ->
    Users.find {}

if Meteor.isClient
  Meteor.subscribe 'users'

#####################################
# Allow / Deny                      #
#####################################

Users.allow
  update: (userId, doc, fieldNames, modifier) ->
    userId is doc._id
  remove: (userId, doc, fieldNames, modifier) ->
    userId is doc._id
