class Nextdoorz.Modules.ContextCache extends Nextdoorz.Module
  initialize: ()->

    aCatParents = _.map Context.category_parents, (attr)-> new Nextdoorz.Models.CategoryParent attr
    Nextdoorz.Cache.CategoryParents = new Nextdoorz.Collections.CategoryParents aCatParents

    aCategories = _.map Context.categories, (attr)-> new Nextdoorz.Models.Category attr
    Nextdoorz.Cache.Categories = new Nextdoorz.Collections.Categories aCategories

    aTagGroups = _.map Context.tag_groups, (attr)-> new Nextdoorz.Models.TagGroup attr
    Nextdoorz.Cache.TagGroups = new Nextdoorz.Collections.TagGroups aTagGroups

    aTags = _.map Context.tags, (attr)-> new Nextdoorz.Models.Tag attr
    Nextdoorz.Cache.Tags = new Nextdoorz.Collections.Tags aTags

    Nextdoorz.Cache.TagGroups.each (tagGroup)->
      cTags = new Nextdoorz.Collections.Tags Nextdoorz.Cache.Tags.where(group_id: tagGroup.id)
      tagGroup.set 'tags', cTags
      if cTags.first()
        tagGroup.set 'category_id', cTags.first().get 'category_id'

    Nextdoorz.Cache.Categories.each (category)->
      cTagGroups = new Nextdoorz.Collections.TagGroups Nextdoorz.Cache.TagGroups.where(category_id: category.id)
      category.set 'tag_groups', cTagGroups

    Nextdoorz.Cache.Categories.each (category)->
      cTags = new Nextdoorz.Collections.Tags Nextdoorz.Cache.Tags.where(category_id: category.id)
      category.set 'tags', cTags

    Nextdoorz.Cache.CategoryParents.each (categoryParent)->
      cCategories = new Nextdoorz.Collections.Categories Nextdoorz.Cache.Categories.where(parent_id: categoryParent.id)
      categoryParent.set 'categories', cCategories

    aBoards = _.map Context.boards, (attr)-> new Nextdoorz.Models.Board attr
    Nextdoorz.Cache.Boards = new Nextdoorz.Collections.Boards aBoards