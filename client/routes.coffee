Route = FlowRouter.group {}

Route.route '/',
  name: 'welcome'
  action: (params, queryParams) ->
    BlazeLayout.render 'welcome'
