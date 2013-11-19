class Nextdoorz.Model extends Backbone.Model
  urlRoot: undefined
  paramName: undefined
  is_new: undefined

  getHtmlIdSelector: ()->
    "##{@paramName}_#{@id}"

  collectionsToArrays: (attributes)->true

  arraysToCollections: (attributes)->true

  createCollections: (attributes)->true

  _stringToObjects: (attributes)->
    if attributes.created_at
      attributes.created_at = new Date(attributes.created_at)
    if attributes.updated_at
      attributes.updated_at = new Date(attributes.updated_at)
    true
  _defaultFilters: ['id', 'created_at', 'updated_at']

  _filter: ()->
    model = this
    toFilter = @_defaultFilters.concat model.filtered_fields
    _.each toFilter, (field_name)-> model.unset field_name, silent: true

  toJSON: ()->
    @collectionsToArrays()
    @_filter()
    if @paramName
      jsn = {}
      jsn[@paramName] = _.clone @attributes
    else
      return super
    return jsn

  parse: (response)->
    attributes = super
    @createCollections(attributes)
    @arraysToCollections(attributes)
    @_stringToObjects(attributes)
    attributes

  url: ()->
    url = @urlRoot
    url += '/' + @get 'id' unless @isNew()
    url += '.json'
    unless @page is undefined
      url += '?page=' + @page
    return url

  initialize: ()->
    @parse @attributes


