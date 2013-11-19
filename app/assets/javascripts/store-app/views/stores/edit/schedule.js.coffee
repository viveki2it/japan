class Nextdoorz.Views.StoreEditSchedule extends Backbone.View

  modelBinder: new Backbone.ModelBinder()

  template: Nextdoorz.getTemplate('stores/edit/schedule')

  events:
    'click .step3-show-schedule-afternoon': "showScheduleAfternoon"
    'click .step3-show-close': 'setCloseDay'
    'click .step3-show-open': 'setOpenDay'
    'focus input[type="text"]': 'autocompleteHour'
    'click input[type="text"]': 'selectAllText'
    'click .save': 'submitModel'

  timeConverter: (direction, value)->
    res = ''
    if direction == "ModelToView"
      date = new Date(value)
      min = date.getUTCMinutes()
      if min < 10
        min = '0' + min
      res = "#{date.getUTCHours()}:#{min}"
    else
      date = new Date("2000-01-01T00:00:00Z")
      items = value.split(':')
      date.setUTCHours parseInt items[0], 10
      date.setUTCMinutes parseInt items[1], 10
      res = date
    res

  bindings: undefined

  initialize: ()->
    findIdx = (tab, value) ->
      for i, v of tab
        if v is value
          return i
      null

    days =  ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]

    @model.attributes.schedule_items = _.sortBy @model.attributes.schedule_items, (item) ->
      findIdx days, item.day

    @model.bind "change", ->

    binds = {}
    for i in [0..6]
      binds['schedule_items.' + i + ".start_at"] =
        selector: '[id=' + days[i] + '_start]'
        converter: @timeConverter
      binds['schedule_items.' + i + ".end_at"] =
        selector: '[id=' + days[i] + '_end]'
        converter: @timeConverter
      binds['schedule_items.' + i + ".pause_start_at"] =
        selector: '[id=' + days[i] + '_pause_start]'
        converter: @timeConverter
      binds['schedule_items.' + i + ".pause_end_at"] =
        selector: '[id=' + days[i] + '_pause_end]'
        converter: @timeConverter
    @bindings = binds
    @render()

  render: ()->
    @$el.html @template @model.attributes.schedule_items
    @$el.modal()
    @$el.find('[data-timepicker=true]').timepicker showPeriodLabels: false
    @modelBinder.bind @model, @$el, @bindings
    @$el.on 'hidden', =>
      @$el.remove()
    for i, v of @model.attributes.schedule_items
      if v.pause_start_at?
        $(".step3-schedule-afternoon", $("#" + v.day)).show().css('display', 'inline-block')
        $('.step3-show-schedule-afternoon', $("#" + v.day)).hide()
      if v.status is "close"
        $('.step3-close', $("#" + v.day)).show()
        $('.step3-open', $("#" + v.day)).hide()
    this

  prepare: ()->
    @model


  showScheduleAfternoon: (e)->
    day = $(e.currentTarget).parents('.span9')
    $('.step3-schedule-afternoon', day).css('display', 'inline-block')
    $('.step3-show-schedule-afternoon', day).hide()
    $("#" + $(day).attr('id') + "_pause_start").attr('value', '12:00').trigger("change")
    $("#" + $(day).attr('id') + "_pause_end").attr('value', '13:00').trigger("change")
    return false

  setCloseDay: (e)->
    day = $(e.currentTarget).parents('.span9')
    $('.step3-close', day).show()
    $('.step3-open', day).hide()
    dayId = $(e.currentTarget).attr('name')
    @model.attributes.schedule_items[dayId].status = "close"
    return false

  setOpenDay: (e)->
    day = $(e.currentTarget).parents('.span9')
    $('.step3-close', day).hide()
    $('.step3-open', day).show()
    dayId = $(e.currentTarget).attr('name')
    @model.attributes.schedule_items[dayId].status = "open"
    return false

  autocompleteHour: (e)->
    availableTags = [
      "0:00",
      "0:15",
      "0:30",
      "0:45",
      "1:00",
      "1:15",
      "1:30",
      "1:45",
      "2:00",
      "2:15",
      "2:30",
      "2:45",
      "3:00",
      "3:15",
      "3:30",
      "3:45",
      "4:00",
      "4:15",
      "4:30",
      "4:45",
      "5:00",
      "5:15",
      "5:30",
      "5:45",
      "6:00",
      "6:15",
      "6:30",
      "6:45",
      "7:00",
      "7:15",
      "7:30",
      "7:45",
      "8:00",
      "8:15",
      "8:30",
      "8:45",
      "9:00",
      "9:15",
      "9:30",
      "9:45",
      "10:00",
      "10:15",
      "10:30",
      "10:45",
      "11:00",
      "11:15",
      "11:30",
      "11:45",
      "12:00",
      "12:15",
      "12:30",
      "12:45",
      "13:00",
      "13:15",
      "13:30",
      "13:45",
      "14:00",
      "14:15",
      "14:30",
      "14:45",
      "15:00",
      "15:15",
      "15:30",
      "15:45",
      "16:00",
      "16:15",
      "16:30",
      "16:45",
      "17:00",
      "17:15",
      "17:30",
      "17:45",
      "18:00",
      "18:15",
      "18:30",
      "18:45",
      "19:00",
      "19:15",
      "19:30",
      "19:45",
      "20:00",
      "20:15",
      "20:30",
      "20:45",
      "21:00",
      "21:15",
      "21:30",
      "21:45",
      "22:00",
      "22:15",
      "22:30",
      "22:45",
      "23:00",
      "23:15",
      "23:30",
      "23:45",
    ];
    $(e.currentTarget).autocomplete
      source: availableTags
      delay: 0
      close: (e, ui) ->
        $(this).trigger("change")

  selectAllText: (e)->
    $(e.currentTarget).select()

  submitModel: (e)->
    e.preventDefault()
    @model.save {},
      beforeSend: ()->
        $('.save', @$el).hide()
        $('.ajax-loader', @$el).show()
      error: ()->
        $('.save', @$el).show()
        $('.ajax-loader', @$el).hide()
      success: (response)->
        location.reload()