class Prescription extends Backbone.Model
  defaults:
    medication: ""
    dosage: ""
    interval: null
    startTime: moment()
    endTime: moment()

  initialize: ->
    @set 'doses', []
    time = @get('startTime').clone()
    while time <= @get 'endTime'
      @get('doses').push new Dose
        prescription: @
        scheduledTime: time.clone()
        givenTime: null
      time.add(@get 'interval')


class Dose extends Backbone.Model
  defaults:
    prescription: null
    scheduledTime: null
    givenTime: null
  given: ->
    @get('givenTime') != null


class Patient extends Backbone.Model
  defaults:
    name: "Anonymous"
    age: 0
    sex: ""
    ethnicity: ""
    address: ""
    importantAllergies: []
    allergies: []
    history: []
    otherMedications: []
    visitInformation: []
    prescriptions: []
    dosages: []
    bed: 0
    portraitFilename: ""

  firstName: ->
    @get('name').split(" ")[0]

  lastName: ->
    @get('name').split(" ")[1]

  doses: ->
    doses = _.flatten [prescription.get 'doses' for prescription in @get 'prescriptions']
    _.sortBy doses, (dose) -> dose.get 'scheduledTime'

  mostRecentDoseGiven: ->
    givenDoses = _.filter @doses(), (dose) -> dose.given()
    if givenDoses.length > 0
      return givenDoses[givenDoses.length - 1]
    else
      return null

  giveAllPastDoses: ->
    for dose in @doses()
      if dose.get('scheduledTime') < moment()
        dose.set 'givenTime', dose.get('scheduledTime')

  numUpcomingDoses: ->
    _.filter(@doses(), (dose) -> not dose.given()).length

  nextDose: ->
    nextDoses = _.filter @doses(), (dose) -> not dose.given()
    if nextDoses.length > 0
      return nextDoses[0]
    else
      return null

  status: ->
    if this.nextDose() is null or this.nextDose().get('scheduledTime') > moment().add(5, 'minutes')
      'ok'
    else if this.nextDose().get('scheduledTime') > moment()
      'warning'
    else
      'alert'


class PatientList extends Backbone.Collection
  localStorage: new Backbone.LocalStorage("patients")
  model: Patient

class PatientListView extends Backbone.View
  el: $('#patients')

  initialize: ->
    _.bindAll @
    @collection = new PatientList
    @collection.bind 'add', @appendPatient
    @patientListItemViews = []

  rerender: ->
    for patientListItemView in @patientListItemViews
      patientListItemView.rerender()
    @

  appendPatient: (patient) ->
    patientListItemView = new PatientListItemView
      model: patient

    @patientListItemViews.push patientListItemView
    $(@el).append patientListItemView.render().el


class PatientListItemView extends Backbone.View
  tagName: 'li'

  initialize: ->
    $(@el).data 'patient', @model
    @doseRowViews = []

  render: ->
    $(@el).html _.template $("#list-item-template").html(), {patient: @model}
    @rerender()
    @

  rerender: ->
    $(@el).find('.doses tbody').empty()
    for dose in @model.doses()
      doseRowView = new DoseRowView
        model: dose
      @doseRowViews.push doseRowView
      $(@el).find('.doses tbody').append doseRowView.render().el

    $(@el).find(".listing")
      .html _.template $("#patient-listing-template").html(), {patient: @model}
    
    $(@el).find(".administration-list")
      .html _.template $("#administration-list-template").html(), {patient: @model}
    
    $(@el).find(".prescriptions-list")
      .html _.template $("#prescriptions-list-template").html(), {patient: @model}

    $(@el).find(".prescription .prescriptions tbody tr:not(.new)").remove()
    $(@el).find(".prescription .prescriptions tbody")
      .prepend _.template $("#prescriptions-table-template").html(), {patient: @model}

    @setNextDose()
    @

  setNextDose: ->
    if @model.nextDose()
      $(@el).data 'next-dose', @model.nextDose().get('scheduledTime').valueOf()
    else
      $(@el).data 'next-dose', null

  removePrescription: (event) ->
    $tr = $(event.target).parents("tr")
    prescriptionIndex = $tr.index()
    console.log $tr
    $tr.remove()
    @model.get('prescriptions').splice prescriptionIndex, 1
    @rerender()

  addPrescription: (event) ->
    $tr = $(event.target).parents("tr")
    @model.get('prescriptions').push new Prescription
      medication: $tr.find(".medication-input").val()
      dosage: $tr.find(".dosage-input").val()
      interval: moment.duration(parseInt($tr.find(".frequency-input").val(), 10), 'hours')
      startTime: moment($tr.find(".start-input input").val())
      endTime: moment($tr.find(".end-input input").val())
    $tr.remove()
    @rerender()

  events:
    'click .remove-existing': 'removePrescription'
    'click .add-new': 'addPrescription'


class PatientDocumentView extends Backbone.View
  el: $('#patient-document')
  renderPatient: (patient) ->
    $(@el).html _.template $("#patient-document-template").html(), {patient: patient}
    @


class DoseRowView extends Backbone.View
  tagName: 'tr'

  render: ->
    $(@el).html _.template $("#dose-row-template").html(), {dose: @model}
    if @model.given()
      $(@el).addClass('done')
    else
      $(@el).removeClass('done')
    @

  done: ->
    @model.set 'givenTime', moment()
    @render()

  undo: ->
    @model.set 'givenTime', null
    @render()

  remove: ->
    $(@el).remove()

  events:
    'click .done': 'done'
    'click .undo': 'undo'


# Set up some static test patients:
kamran = new Patient
  name: "Kamran Khan"
  age: 21
  sex: "Male"
  ethnicity: "South Asian, White"
  address: "3 Ames St.,<br />Cambridge, MA. 02142"
  importantAllergies: []
  allergies: ["pollen"]
  history: [
    "Family history of hypertension"
    "Family history of hyperglycemia"
    "Toncilectomy <em> 12 December 2008</em>"
  ]
  otherMedications: [
    "Daily aspirin <em>100mg/day</em>"
  ]
  visitInformation: [
    "Admitted with chest pain <em>2 days ago</em>"
    "In ICU after suspected cardiac arrest <em>14 hours ago</em>"
  ]
  prescriptions: [
    new Prescription
      medication: "Aspirin"
      dosage: "100mg"
      interval: moment.duration(1, 'hours')
      startTime: moment().subtract(2, 'hours').add(2, 'minutes')
      endTime: moment().add(1, 'hours').add(2, 'minutes')
  ]
  bed: 3
  portraitFilename: "kamran.jpg"

robin = new Patient
  name: "Robin Deits"
  age: 23
  sex: "Male"
  ethnicity: "White"
  address: "1 Main St.,<br />Cambridge, MA. 02142"
  importantAllergies: ["penicillin"]
  allergies: []
  otherMedications: [
    "<em>Patient not on any other medications</em>"
  ]
  visitInformation: [
    "Admitted with head trauma <em>1 day ago</em>"
    "In ICU after suspected cerebral hemorrhage <em>3 hours ago</em>"
  ]
  history: [
    "Family history of hypertension"
  ]
  prescriptions: [
    new Prescription
      medication: "Morphine"
      dosage: "100mg"
      interval: moment.duration(2, 'hours')
      startTime: moment().subtract(15, 'minutes')
      endTime: moment().add(4, 'hours').subtract(15, 'minutes')
  ]
  bed: 7
  portraitFilename: "robin.jpg"

mohammad = new Patient
  name: "Mohammad Ghassemi"
  age: 24
  sex: "Male"
  ethnicity: "Middle Eastern, White"
  address: "100 Mass Ave.,<br />Cambridge, MA. 02139"
  importantAllergies: []
  allergies: []
  otherMedications: [
    "Daily Lipitor <em>35mg/day</em>"
    "Daily Catapres <em>50mg/day</em>"
  ]
  visitInformation: [
    "Admitted with difficulty breathing <em>2 days ago</em>"
  ]
  history: [
    "Family history of hypertension"
    "Appendectomy <em>5 May 2002</em>"
  ]
  prescriptions: [
    new Prescription
      medication: "Aspirin"
      dosage: "100mg"
      interval: moment.duration(1, 'hours')
      startTime: moment().subtract(2, 'hours').add(11, 'minutes')
      endTime: moment().add(4, 'hours').add(11, 'minutes')
  ]
  bed: 5
  portraitFilename: "mohammad.jpg"

franck = new Patient
  name: "Franck Dernoncourt"
  age: 24
  sex: "Male"
  ethnicity: "White"
  address: "120 Mass Ave.,<br />Cambridge, MA. 02139"
  importantAllergies: ["aspirin", "naproxen"]
  allergies: ["peanuts (mild)"]
  otherMedications: [
    "Daily Fenofibrate <em>45mg/day</em>",
    "Twice-daily Lovenox <em>20mg/day, 10mg q12h</em>"
  ]
  visitInformation: [
    "Admitted with difficulty breathing <em>2 days ago</em>"
  ]
  history: [
    "Family history of hyperglycemia"
  ]
  prescriptions: [
    new Prescription
      medication: "Morphine"
      dosage: "100mg"
      interval: moment.duration(2, 'hours')
      startTime: moment().subtract(54, 'minutes')
      endTime: moment().add(4, 'hours').subtract(54, 'minutes')
    new Prescription
      medication: "Naproxen",
      dosage: "30mg",
      interval: moment.duration(24, 'hours')
      startTime: moment().subtract(9, 'hours')
      endTime: moment().add(6, 'days').subtract(9, 'hours')
  ]
  bed: 9
  portraitFilename: "franck.jpg"

# Some test data:
testPatients = [kamran, robin, franck, mohammad]
franck.giveAllPastDoses()
mohammad.giveAllPastDoses()
kamran.giveAllPastDoses()

# Sorting methods:
sortByName = ->
  $list = $("#patients")
  listItems = $list.children("li").get()
  listItems.sort (a, b) ->
    aVal = $(a).find("h2.name").text()
    bVal = $(b).find("h2.name").text()
    return -1 if aVal < bVal
    return  1 if aVal > bVal
    return  0
  $list.append listItems

sortByBed = ->
  $list = $("#patients")
  listItems = $list.children("li").get()
  listItems.sort (a, b) ->
    aVal = parseInt $(a).find(".bed-number").text(), 10
    bVal = parseInt $(b).find(".bed-number").text(), 10
    return -1 if aVal < bVal
    return  1 if aVal > bVal
    return  0
  $list.append listItems

sortByUrgency = ->
  $list = $("#patients")
  listItems = $list.children("li").get()
  listItems.sort (a, b) ->
    aVal = $(a).data("next-dose")
    bVal = $(b).data("next-dose")
    return -1 if aVal < bVal
    return  1 if aVal > bVal
    return  0
  $list.append listItems


# On document ready:
$ ->
  # Backbone View setup:
  patientListView = new PatientListView
  #patientListView.collection.fetch()
  if patientListView.collection.length == 0
    patientListView.collection.create patient for patient in testPatients

  setInterval ->
    patientListView.rerender()
    _.each patientListView.collection.models, (patient) ->
      patientListView.collection.sync 'update', patient
    console.log '.'
  , 2000
  sortByName()

  patientDocumentView = new PatientDocumentView
  
  # Add sort handlers:
  $("#sort-by-name").click (event) ->
    event.stopPropagation()
    event.preventDefault()
    return if $(this).hasClass "active"
    $("#sort-by-bed").removeClass "active"
    $("#sort-by-urgency").removeClass "active"
    $(this).addClass "active"
    sortByName()

  $("#sort-by-bed").click (event) ->
    event.stopPropagation()
    event.preventDefault()
    return if $(this).hasClass "active"
    $("#sort-by-name").removeClass "active"
    $("#sort-by-urgency").removeClass "active"
    $(this).addClass "active"
    sortByBed()

  $("#sort-by-urgency").click (event) ->
    event.stopPropagation()
    event.preventDefault()
    return if $(this).hasClass "active"
    $("#sort-by-bed").removeClass "active"
    $("#sort-by-name").removeClass "active"
    $(this).addClass "active"
    sortByUrgency()

  # Not implemented notice:
  $(document).on "click", ".not-implemented", {}, (event) ->
    event.stopPropagation()
    event.preventDefault()
    $("#flash-message").stop().hide().slideDown(100).delay(1000).fadeOut(500)

  # Custom input focus
  $(document).on "click", ".input", {}, (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(this).find("input").focus()

  # Remove new row:
  $(document).on "click", ".remove-new", {}, (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(this).parents("tr").remove()

  # Button handlers:
  $(document).on "click", ".add-prescription", {}, (event) ->
    event.stopPropagation()
    event.preventDefault()
    $table = $(this).parents(".prescription").find("table.prescriptions")
    $newRow = $table.find(".new-template").clone().removeClass "new-template"
    $newRow.find(".date-time-picker-input").datetimepicker
      hourGrid: 4
      minuteGrid: 10
    $newRow.find(".date-time-picker-input").datetimepicker 'setDate', new Date
    $newRow.appendTo($table.find "tbody").hide().slideDown 200

  # Tab handling:
  $(document).on "click", ".medication-tabs a", {}, (event) ->
    return if $(this).hasClass "active"
    $(this).parents(".medication-tabs").find("a").removeClass "active"
    $(this).addClass "active"
    tabName = $(this).data "tab"
    $(this).parents(".medication")
      .find(".medication-content > div")
      .slideUp 100, ->
        $(this).filter(".#{tabName}").slideDown 100

  # Patient handling:
  $(document).on "click", ".listing", {}, (event) ->
    $(this).siblings(".medication").find(".medication-tabs a[data-tab=overview]").click()
    $li = $(this).parents "li"
    if $li.hasClass "active"
      $li.removeClass "active"
      $li.find(".medication").slideUp 200
      $("#add-patient").removeClass "secondary"
      $("#patient-document").stop().slideUp 200, ->
        $("body").removeClass "patient-selected"
    else
      $("#patients > li.active").removeClass "active"
      $("#patients > li .medication").slideUp 200
      $li.addClass "active"
      $li.find(".medication").slideDown 200
      $("body").addClass "patient-selected"
      $("#add-patient").addClass "secondary"
      $("#patient-document").stop().fadeOut 100, ->
        patientDocumentView.renderPatient $li.data('patient')
        $("#patient-document").fadeIn 300

  # Add count:
  $("#number-of-patients .count").text testPatients.length
