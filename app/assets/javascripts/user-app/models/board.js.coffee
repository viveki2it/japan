class Nextdoorz.Models.Board extends Nextdoorz.Model
  urlRoot: '/boards'
  paramName: 'board'
  page: undefined
  is_new: false

  defaults:
    user_id: if Context.current_user then Context.current_user.id else undefined

  createCollections: (attributes)->
    attributes.category_parents ||= new Nextdoorz.Collections.CategoryParents()
    attributes.categories ||= new Nextdoorz.Collections.Categories()
    attributes.tags ||= new Nextdoorz.Collections.Tags()
    attributes.tag_groups ||= new Nextdoorz.Collections.TagGroups()
    attributes.stores ||= new Nextdoorz.Collections.Stores()
    attributes.district_ids ||= []
    attributes

  arraysToCollections: (attributes)->
    cCategories = attributes.categories
    aCategoryAttributes = _.map attributes['category_ids'], (id)-> Nextdoorz.Cache.Categories.get(id).attributes
    cCategories.reset aCategoryAttributes

    cCatParents = attributes.category_parents
    parent_ids = _.uniq(cCategories.map (cat)->cat.get('parent_id'))
    aCatParentAttributes = _.map parent_ids, (id)-> Nextdoorz.Cache.CategoryParents.get(id).attributes
    cCatParents.reset aCatParentAttributes

    cTags = attributes.tags
    aTagAttributes = _.map attributes['tag_ids'], (id)-> Nextdoorz.Cache.Tags.get(id).attributes
    cTags.reset aTagAttributes

    cTagGroups = attributes.tag_groups
    tag_group_ids = _.uniq(
      cTags.map (tag)->
        ids = tag.get('group_id')
        if ids is null 
          return 
        # Not sure if it's needed...
        if ids.length > 1
          ids.filter(Number) 
        return ids
    )
    
    aTagGroupAttributes = _.map(tag_group_ids, 
      (id)-> 
        if Nextdoorz.Cache.TagGroups.get(id) is undefined
          return
        Nextdoorz.Cache.TagGroups.get(id).attributes
    )

    cTagGroups.reset aTagGroupAttributes
    
    aProductsAttributes = attributes.products
    attributes.products = new Nextdoorz.Collections.Products aProductsAttributes

    aDealsAttributes = attributes.deals
    attributes.deals = new Nextdoorz.Collections.Deals aDealsAttributes

    aNewsAttributes = attributes.news
    attributes.news = new Nextdoorz.Collections.News aNewsAttributes

    aStoresAttributes = attributes.stores
    attributes.stores = new Nextdoorz.Collections.Stores aStoresAttributes

    attributes

  collectionsToArrays: ()->
    @attributes['category_ids'] = @get('categories').map((cat)-> cat.id)
    @attributes['tag_ids'] = @get('tags').map((cat)-> cat.id)

  afterParentCategoryChange: ()->
    @_purgeOrphanCategories()
    @_purgeOrphanTags()
    @_populateChildlessParentCategories()
    @_populateChildlessCategories()

  afterCategoryChange: ()->
    @_purgeOrphanTags()
    @_purgeChildlessParentCategories()
    @_populateChildlessCategories()

  afterTagChange: ()->
    @_purgeChildlessCategories()
    @_purgeChildlessParentCategories()

  _purgeOrphanCategories: ()-> # removes orphan categories (without parents)
    category_parent_ids = @get('category_parents').map((catp)-> catp.id)
    orphans = []
    subcats = @get('categories')
    subcats.each (subcat)->
      if ! _.contains category_parent_ids, subcat.get('parent_id')
        orphans.push subcat
    for orphan in orphans
      do (orphan)->
        subcats.remove orphan
    this

  _purgeOrphanTags: ()-> # removes orphan tags (without categories)
    category_ids = @get('categories').map((cat)-> cat.id)
    orphans = []
    tags = @get('tags')
    tags.each (tag)->
      if ! _.contains category_ids, tag.get('category_id')
        orphans.push tag
    for orphan in orphans
      do (orphan)->
        tags.remove orphan
    this

  _populateChildlessParentCategories: ()-> # if a selected parent category has no selected category, select them all
    that = this
    parents_ids = @get('category_parents').map((catp)->  catp.get('id'))
    filled_parents_ids = _.uniq(@get('categories').map (cat)-> cat.get('parent_id'))
    childless_parents_ids = _.difference parents_ids, filled_parents_ids

    for catp_id in childless_parents_ids
      do (catp_id)->
        for subcat in Nextdoorz.Cache.Categories.models when subcat.get('parent_id') is catp_id
          do (subcat)->
            that.get('categories').add subcat.attributes
    this

  _populateChildlessCategories: ()-> # if a selected category has no selected tags, select them all
    that = this
    categories_ids = @get('categories').map((cat)->  cat.get('id'))
    filled_categories_ids = _.uniq(@get('tags').map (cat)-> cat.get('category_id'))
    childless_categories_ids = _.difference categories_ids, filled_categories_ids

    for cat_id in childless_categories_ids
      do (cat_id)->
        for tag in Nextdoorz.Cache.Tags.models when tag.get('category_id') is cat_id
          do (tag)->
            that.get('tags').add tag.attributes
    this

  _purgeChildlessParentCategories: ()-> # if a selected parent category has no selected category, remove the parent category
    that = this
    parents_ids = @get('category_parents').map((catp)->  catp.get('id'))
    filled_parents_ids = _.uniq(@get('categories').map (cat)-> cat.get('parent_id'))
    childless_parents_ids = _.difference parents_ids, filled_parents_ids

    while to_remove = that.get('category_parents').find((pcat)-> _.contains(childless_parents_ids, pcat.get('id')))
      that.get('category_parents').remove to_remove
    this

  _purgeChildlessCategories: ()-> # if a selected category has no selected tags, remove the category
    that = this
    categories_ids = @get('categories').map((cat)->  cat.get('id'))
    filled_categories_ids = _.uniq(@get('tags').map (cat)-> cat.get('category_id'))
    childless_categories_ids = _.difference categories_ids, filled_categories_ids

    while to_remove = that.get('categories').find((cat)-> _.contains(childless_categories_ids, cat.get('id')))
      that.get('categories').remove to_remove
    this

  filtered_fields: ['category_parents', 'categories',
      'tags', 'tag_groups', 'products', 'deals', 'news', 'stores',
      'paginated_deals', 'paginated_products', 'paginated_news']


#
# category_parents
# |
# +-> categories
#     |
#     +-> tags
#
#
# tag_groups
# |
# +-> tags
#