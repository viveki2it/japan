Nextdoorz.Initializers.ProfileWizard = ()->
  @store = new Nextdoorz.Models.Store {id: Context.current_user.store_id }
  @store.fetch(success:(store)->
    if store.attributes.wizard_step
      wizard = new Nextdoorz.Views.ProfileWizard model: store
      wizard.render()
  )