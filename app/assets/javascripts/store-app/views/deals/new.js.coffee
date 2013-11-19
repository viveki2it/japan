class Nextdoorz.Views.NewDeals extends Nextdoorz.Views.NewProducts
  template: Nextdoorz.getTemplate('deals/form')
  bindings:
    {
    name: '[name=name]'
    description: '[name=description]'
    #slots: '[name=slots]'
    discount_price: '[name=discount_price]'
    normal_price: '[name=normal_price]'
    starts_at: '[name=starts_at]'
    ends_at: '[name=ends_at]'
    }
  initModel: ()->
    @model ||= new Nextdoorz.Models.Deal
    @model.addDefaultVariant()
