class Nextdoorz.Views.NewNews extends Nextdoorz.Views.AbstractForm
  template: Nextdoorz.getTemplate('news/form')
  bindings:
    {
    title: '[name=title]'
    content: '[name=content]'
    }
    
  initModel: ()->
    @model ||= new Nextdoorz.Models.News
