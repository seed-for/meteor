#####################################################
# Schema Design                                     #
#####################################################

@Groups = new Meteor.Collection 'groups'

Schemas.Member = new SimpleSchema
  user:
    type: String
  role:
    type: String
    allowedValues: ['OWNER', 'MEMBER', 'WANNABE']
  joinedAt:
    type: Date
    index: true

Schemas.Group = new SimpleSchema
  owner:
    type: String
    index: true
  name:
    type: String
  type:
    type: String
    allowedValues: ['PUBLIC', 'PRIVATE', 'SECRET']
  createdAt:
    type: Date
    index: true
  description:
    type: String
  background:
    type: Object
    blackbox: true
  featured:
    type: Boolean
    index: true
  secretCode:
    type: String
    index: true
    unique: true
    sparse: true
  members:
    type: [Schemas.Member]
  memberCount:
    type: Number
    defaultValue: 0
  wannabeCount:
    type: Number
    defaultValue: 0

Groups.attachSchema Schemas.Group

#####################################
# Helpers                           #
#####################################

Groups.helpers {}

#####################################
# Publish / Subscribe               #
#####################################

if Meteor.isServer
  Meteor.publish 'groups', ->
    Groups.find {}

if Meteor.isClient
  Meteor.subscribe 'groups'

#####################################
# Allow / Deny                      #
#####################################

Groups.allow
  insert: (userId, doc, fieldNames, modifier) ->
    userId
  update: (userId, doc, fieldNames, modifier) ->
    userId is doc.owner
  remove: (userId, doc, fieldNames, modifier) ->
    userId is doc.owner
