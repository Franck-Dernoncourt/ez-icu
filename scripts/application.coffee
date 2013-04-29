# Patient class:
class Patient
  constructor: (data) ->
    @name = data.name
    @age = data.age
    @sex = data.sex
    @ethnicity = data.ethnicity
    @address = data.address
    @importantAllergies = data.importantAllergies
    @allergies = data.allergies
    @history = data.history
    @bed = data.bed
    @visitInformation = data.visitInformation
    @otherMedications = data.otherMedications
    @portraitFilename = data.portraitFilename
    # @nextDosage = data.nextDosage
    @status = data.status
    @prescriptions = data.prescriptions
    @dosages = data.dosages

  nextDosage: ->
    upcomingDoses = d.scheduledTime for d in @dosages when d.givenTime is null
    moment(Math.min(upcomingDoses)).fromNow()


  firstName: ->
    @name.split(" ")[0]

  lastName: ->
    @name.split(" ")[1]

  listItem: ->
    $("<li></li>").html _.template $("#list-item-template").html(), {patient: @}

  patientDocument: ->
    $("<div></div>").html _.template $("#patient-document-template").html(), {patient: @}

# Set up some static test patients:
kamran = new Patient({
  name: "Kamran Khan",
  age: 21,
  sex: "Male",
  ethnicity: "South Asian, White",
  address: "3 Ames St.,<br />Cambridge, MA. 02142",
  importantAllergies: [],
  allergies: ["pollen"],
  history: [
    "Family history of hypertension",
    "Family history of hyperglycemia",
    "Toncilectomy <em> 12 December 2008</em>"
  ],
  otherMedications: [
    "Daily aspirin <em>100mg/day</em>"
  ],
  visitInformation: [
    "Admitted with chest pain <em>2 days ago</em>",
    "In ICU after suspected cardiac arrest <em>14 hours ago</em>"
  ],
  prescriptions: [
    {
      medication: "Aspirin",
      dosage: "100mg",
      frequency: moment.duration(1, 'hours'),
      # frequency: "Every hour <em>Q1H</em>",
      start: moment().subtract('hours', 2).add('minutes', 2),
      # start: "2 hours ago <em>2 dosages given</em>"
      end: moment().add('hours', 1).add('minutes', 2)
      # end: "in 1 hour, 2 minutes <em>2 dosages remaining</em>"
    }
  ],
  dosages: [
    {
      medication: "Aspirin",
      dosage: "100mg",
      scheduledTime: moment().add('minutes', 2),
      # scheduledTime: "in 2 minutes",
      givenTime: null
      # done: false
    },
    {
      medication: "Aspirin",
      dosage: "100mg",
      scheduledTime: moment().subtract('hours', 1).add('minutes', 2),
      givenTime: moment().subtract('hours', 1).add('minutes', 2)
      # scheduledTime: "58 minutes ago",
      # done: true
    },
    {
      medication: "Aspirin",
      dosage: "100mg",
      scheduledTime: moment().subtract('hours', 2).add('minutes', 2),
      givenTime: moment().subtract('hours', 2).add('minutes', 2)
      # scheduledTime: "about 2 hours ago",
      # done: true
    },
  ],
  # nextDosage: "in 2 min.",
  # status: "warning",
  bed: 3,
  portraitFilename: "kamran.jpg"
})

robin = new Patient({
  name: "Robin Deits",
  age: 23,
  sex: "Male",
  ethnicity: "White",
  address: "1 Main St.,<br />Cambridge, MA. 02142",
  importantAllergies: ["penicillin"],
  allergies: [],
  otherMedications: [
    "<em>Patient not on any other medications</em>"
  ],
  visitInformation: [
    "Admitted with head trauma <em>1 day ago</em>",
    "In ICU after suspected cerebral hemorrhage <em>3 hours ago</em>"
  ],
  history: [
    "Family history of hypertension"
  ],
  prescriptions: [
    {
      medication: "Morphine",
      dosage: "100mg",
      frequency: "Every 2 hours <em>Q2H</em>",
      start: "15 minutes ago <em>1 dosage given</em>"
      end: "in 3 hours, 45 minutes <em>4 dosages remaining</em>"
    },
    {
      medication: "Naproxen",
      dosage: "30mg",
      frequency: "Every 24 hours <em>Q1D</em>",
      start: "9 hours ago <em>1 dosage given</em>"
      end: "in 6 days, 15 hours <em>7 dosages remaining</em>"
    }
  ],
  dosages: [
    {
      medication: "Morphine",
      dosage: "100mg",
      scheduledTime: "in 45 minutes",
      done: false
    },
    {
      medication: "Naproxen",
      dosage: "30mg",
      scheduledTime: "in about 15 hours",
      done: false
    },
    {
      medication: "Morphine",
      dosage: "100mg",
      scheduledTime: "15 minutes ago",
      done: true
    },
    {
      medication: "Naproxen",
      dosage: "30mg",
      scheduledTime: "9 hours ago",
      done: true
    },
  ],
  nextDosage: "in 45 min.",
  status: "ok",
  bed: 7,
  portraitFilename: "robin.jpg"
})

mohammad = new Patient({
  name: "Mohammad Ghassemi",
  age: 24,
  sex: "Male",
  ethnicity: "Middle Eastern, White",
  address: "100 Mass Ave.,<br />Cambridge, MA. 02139",
  importantAllergies: [],
  allergies: [],
  otherMedications: [
    "Daily Lipitor <em>35mg/day</em>",
    "Daily Catapres <em>50mg/day</em>"
  ],
  visitInformation: [
    "Admitted with difficulty breathing <em>2 days ago</em>"
  ],
  history: [
    "Family history of hypertension",
    "Appendectomy <em>5 May 2002</em>"
  ],
  prescriptions: [
    {
      medication: "Aspirin",
      dosage: "100mg",
      frequency: "Every hour <em>Q1H</em>",
      start: "2 hours ago <em>2 dosages given</em>"
      end: "in 57 minutes <em>2 dosages remaining</em>"
    }
  ],
  dosages: [
    {
      medication: "Aspirin",
      dosage: "100mg",
      scheduledTime: "3 minutes ago",
      done: false
    },
    {
      medication: "Aspirin",
      dosage: "100mg",
      scheduledTime: "1 hour, 3 minutes ago",
      done: true
    },
    {
      medication: "Aspirin",
      dosage: "100mg",
      scheduledTime: "about 2 hours ago",
      done: true
    },
  ],
  nextDosage: "3 min. ago",
  status: "alert",
  bed: 5,
  portraitFilename: "mohammad.jpg"
})

franck = new Patient({
  name: "Franck Dernoncourt",
  age: 24,
  sex: "Male",
  ethnicity: "White",
  address: "120 Mass Ave.,<br />Cambridge, MA. 02139",
  importantAllergies: ["aspirin", "naproxen"],
  allergies: ["peanuts (mild)"],
  otherMedications: [
    "Daily Fenofibrate <em>45mg/day</em>",
    "Twice-daily Lovenox <em>20mg/day, 10mg q12h</em>"
  ],
  visitInformation: [
    "Admitted with difficulty breathing <em>2 days ago</em>"
  ],
  history: [
    "Family history of hyperglycemia"
  ],
  prescriptions: [
    {
      medication: "Morphine",
      dosage: "100mg",
      frequency: "Every 2 hours <em>Q2H</em>",
      start: "54 minutes ago <em>1 dosage given</em>"
      end: "in 3 hours, 6 minutes <em>4 dosages remaining</em>"
    },
    {
      medication: "Naproxen",
      dosage: "30mg",
      frequency: "Every 24 hours <em>Q1D</em>",
      start: "9 hours ago <em>1 dosage given</em>"
      end: "in 6 days, 15 hours <em>7 dosages remaining</em>"
    }
  ],
  dosages: [
    {
      medication: "Morphine",
      dosage: "100mg",
      scheduledTime: "in 6 minutes",
      done: false
    },
    {
      medication: "Naproxen",
      dosage: "30mg",
      scheduledTime: "in about 15 hours",
      done: false
    },
    {
      medication: "Morphine",
      dosage: "100mg",
      scheduledTime: "54 minutes ago",
      done: true
    },
    {
      medication: "Naproxen",
      dosage: "30mg",
      scheduledTime: "9 hours ago",
      done: true
    },
  ],
  nextDosage: "in 6 min.",
  status: "warning",
  bed: 9,
  portraitFilename: "franck.jpg"
})

putin = $.extend {}, kamran
putin.name = "Vladamir Putin"
putin.ethnicity = "White"
putin.address = "Russia"
putin.portraitFilename = "putin.jpg"
putin.age = 60
putin.bed = 11

obama = $.extend {}, mohammad
obama.name = "Barack Obama"
obama.ethnicity = "Black"
obama.address = "The White House"
obama.portraitFilename = "obama.jpg"
obama.age = 51
obama.bed = 12

bush = $.extend {}, robin
bush.name = "George Bush"
bush.ethnicity = "White"
bush.address = "New Haven, CT"
bush.portraitFilename = "bush.jpg"
bush.age = 66
bush.bed = 15

zuckerberg = $.extend {}, franck
zuckerberg.name = "Mark Zuckerberg"
zuckerberg.ethnicity = "White"
zuckerberg.address = "Menlo Park, CA"
zuckerberg.portraitFilename = "zuckerberg.jpg"
zuckerberg.age = 28
zuckerberg.bed = 13

# testPatients = [kamran, robin, franck, mohammad, putin, obama, bush, zuckerberg]
testPatients = [kamran]

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


# On document ready:
$ ->
  # Add sort handlers:
  $("#sort-by-name").click (event) ->
    event.stopPropagation()
    event.preventDefault()
    return if $(this).hasClass "active"
    $("#sort-by-bed").removeClass "active"
    $(this).addClass "active"
    sortByName()

  $("#sort-by-bed").click (event) ->
    event.stopPropagation()
    event.preventDefault()
    return if $(this).hasClass "active"
    $("#sort-by-name").removeClass "active"
    $(this).addClass "active"
    sortByBed()
  
  # Add the patients:
  for patient in testPatients
    patient.listItem().data({patient: patient}).appendTo "#patients"
  sortByName()

  # Not implemented notice:
  $(document).on "click", ".not-implemented", {}, (event) ->
    event.stopPropagation()
    event.preventDefault()
    $("#flash-message").stop().hide().slideDown(100).delay(1000).fadeOut(500)
  $(document).on "focus", ".date-time-picker-input", {}, ->
    $(this).siblings(".date-time-picker").slideDown 200
  $(document).on "blur", ".date-time-picker-input", {}, ->
    $(this).siblings(".date-time-picker").slideUp 200

  # Custom input focus
  $(document).on "click", ".input", {}, (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(this).find("input").focus()
  $(document).on "click", ".remove-new", {}, (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(this).parents("tr").remove()

  # Button handlers:
  $(".done").click (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(this).parents("tr").addClass "done"
  $(".undo").click (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(this).parents("tr").removeClass "done"
  $(".add-prescription").click (event) ->
    event.stopPropagation()
    event.preventDefault()
    $table = $(this).parents(".prescription").find("table.prescriptions")
    $newRow = $table.find(".new-template").clone().removeClass "new-template"
    $newRow.appendTo($table.find "tbody").hide().slideDown 200

  # Tab handling:
  $(".medication-tabs a").click ->
    return if $(this).hasClass "active"
    $(this).parents(".medication-tabs").find("a").removeClass "active"
    $(this).addClass "active"
    tabName = $(this).data "tab"
    $(this).parents(".medication")
      .find(".medication-content > div")
      .slideUp 100, ->
        $(this).filter(".#{tabName}").slideDown 100

  # Auto-expand "Overview" tab:
  $(".medication-tabs a[data-tab=overview]").click()

  # Patient handling:
  $(".listing").click ->
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
        $("#patient-document").html $li.data("patient").patientDocument()
        $("#patient-document").fadeIn 300
  $("#patients > li .medication").slideUp 10

  # Add count:
  $("#number-of-patients .count").text testPatients.length
