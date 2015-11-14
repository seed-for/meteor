Template.welcome.onCreated ->
  Tracker.autorun ->
    SEO.set
      title: Config.title 'view.welcome.title'
      description: i 'view.welcome.description'
      meta: {}
