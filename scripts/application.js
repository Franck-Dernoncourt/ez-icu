// Generated by CoffeeScript 1.6.2
(function() {
  var Patient, bush, franck, kamran, mohammad, obama, putin, robin, sortByBed, sortByName, testPatients, zuckerberg;

  Patient = (function() {
    function Patient(data) {
      this.name = data.name;
      this.age = data.age;
      this.sex = data.sex;
      this.ethnicity = data.ethnicity;
      this.address = data.address;
      this.importantAllergies = data.importantAllergies;
      this.allergies = data.allergies;
      this.history = data.history;
      this.bed = data.bed;
      this.visitInformation = data.visitInformation;
      this.otherMedications = data.otherMedications;
      this.portraitFilename = data.portraitFilename;
      this.status = data.status;
      this.prescriptions = data.prescriptions;
      this.dosages = data.dosages;
    }

    Patient.prototype.nextDosage = function() {
      var d, upcomingDoses, _i, _len, _ref;

      _ref = this.dosages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        d = _ref[_i];
        if (d.givenTime === null) {
          upcomingDoses = d.scheduledTime;
        }
      }
      return moment(Math.min(upcomingDoses));
    };

    Patient.prototype.firstName = function() {
      return this.name.split(" ")[0];
    };

    Patient.prototype.lastName = function() {
      return this.name.split(" ")[1];
    };

    Patient.prototype.listItem = function() {
      return $("<li></li>").html(_.template($("#list-item-template").html(), {
        patient: this
      }));
    };

    Patient.prototype.patientDocument = function() {
      return $("<div></div>").html(_.template($("#patient-document-template").html(), {
        patient: this
      }));
    };

    return Patient;

  })();

  kamran = new Patient({
    name: "Kamran Khan",
    age: 21,
    sex: "Male",
    ethnicity: "South Asian, White",
    address: "3 Ames St.,<br />Cambridge, MA. 02142",
    importantAllergies: [],
    allergies: ["pollen"],
    history: ["Family history of hypertension", "Family history of hyperglycemia", "Toncilectomy <em> 12 December 2008</em>"],
    otherMedications: ["Daily aspirin <em>100mg/day</em>"],
    visitInformation: ["Admitted with chest pain <em>2 days ago</em>", "In ICU after suspected cardiac arrest <em>14 hours ago</em>"],
    prescriptions: [
      {
        medication: "Aspirin",
        dosage: "100mg",
        frequency: moment.duration(1, 'hours'),
        start: moment().subtract('hours', 2).add('minutes', 2),
        end: moment().add('hours', 1).add('minutes', 2)
      }
    ],
    dosages: [
      {
        medication: "Aspirin",
        dosage: "100mg",
        scheduledTime: moment().add('minutes', 2),
        givenTime: null
      }, {
        medication: "Aspirin",
        dosage: "100mg",
        scheduledTime: moment().subtract('hours', 1).add('minutes', 2),
        givenTime: moment().subtract('hours', 1).add('minutes', 2)
      }, {
        medication: "Aspirin",
        dosage: "100mg",
        scheduledTime: moment().subtract('hours', 2).add('minutes', 2),
        givenTime: moment().subtract('hours', 2).add('minutes', 2)
      }
    ],
    bed: 3,
    portraitFilename: "kamran.jpg"
  });

  robin = new Patient({
    name: "Robin Deits",
    age: 23,
    sex: "Male",
    ethnicity: "White",
    address: "1 Main St.,<br />Cambridge, MA. 02142",
    importantAllergies: ["penicillin"],
    allergies: [],
    otherMedications: ["<em>Patient not on any other medications</em>"],
    visitInformation: ["Admitted with head trauma <em>1 day ago</em>", "In ICU after suspected cerebral hemorrhage <em>3 hours ago</em>"],
    history: ["Family history of hypertension"],
    prescriptions: [
      {
        medication: "Morphine",
        dosage: "100mg",
        frequency: "Every 2 hours <em>Q2H</em>",
        start: "15 minutes ago <em>1 dosage given</em>",
        end: "in 3 hours, 45 minutes <em>4 dosages remaining</em>"
      }, {
        medication: "Naproxen",
        dosage: "30mg",
        frequency: "Every 24 hours <em>Q1D</em>",
        start: "9 hours ago <em>1 dosage given</em>",
        end: "in 6 days, 15 hours <em>7 dosages remaining</em>"
      }
    ],
    dosages: [
      {
        medication: "Morphine",
        dosage: "100mg",
        scheduledTime: "in 45 minutes",
        done: false
      }, {
        medication: "Naproxen",
        dosage: "30mg",
        scheduledTime: "in about 15 hours",
        done: false
      }, {
        medication: "Morphine",
        dosage: "100mg",
        scheduledTime: "15 minutes ago",
        done: true
      }, {
        medication: "Naproxen",
        dosage: "30mg",
        scheduledTime: "9 hours ago",
        done: true
      }
    ],
    nextDosage: "in 45 min.",
    status: "ok",
    bed: 7,
    portraitFilename: "robin.jpg"
  });

  mohammad = new Patient({
    name: "Mohammad Ghassemi",
    age: 24,
    sex: "Male",
    ethnicity: "Middle Eastern, White",
    address: "100 Mass Ave.,<br />Cambridge, MA. 02139",
    importantAllergies: [],
    allergies: [],
    otherMedications: ["Daily Lipitor <em>35mg/day</em>", "Daily Catapres <em>50mg/day</em>"],
    visitInformation: ["Admitted with difficulty breathing <em>2 days ago</em>"],
    history: ["Family history of hypertension", "Appendectomy <em>5 May 2002</em>"],
    prescriptions: [
      {
        medication: "Aspirin",
        dosage: "100mg",
        frequency: "Every hour <em>Q1H</em>",
        start: "2 hours ago <em>2 dosages given</em>",
        end: "in 57 minutes <em>2 dosages remaining</em>"
      }
    ],
    dosages: [
      {
        medication: "Aspirin",
        dosage: "100mg",
        scheduledTime: "3 minutes ago",
        done: false
      }, {
        medication: "Aspirin",
        dosage: "100mg",
        scheduledTime: "1 hour, 3 minutes ago",
        done: true
      }, {
        medication: "Aspirin",
        dosage: "100mg",
        scheduledTime: "about 2 hours ago",
        done: true
      }
    ],
    nextDosage: "3 min. ago",
    status: "alert",
    bed: 5,
    portraitFilename: "mohammad.jpg"
  });

  franck = new Patient({
    name: "Franck Dernoncourt",
    age: 24,
    sex: "Male",
    ethnicity: "White",
    address: "120 Mass Ave.,<br />Cambridge, MA. 02139",
    importantAllergies: ["aspirin", "naproxen"],
    allergies: ["peanuts (mild)"],
    otherMedications: ["Daily Fenofibrate <em>45mg/day</em>", "Twice-daily Lovenox <em>20mg/day, 10mg q12h</em>"],
    visitInformation: ["Admitted with difficulty breathing <em>2 days ago</em>"],
    history: ["Family history of hyperglycemia"],
    prescriptions: [
      {
        medication: "Morphine",
        dosage: "100mg",
        frequency: "Every 2 hours <em>Q2H</em>",
        start: "54 minutes ago <em>1 dosage given</em>",
        end: "in 3 hours, 6 minutes <em>4 dosages remaining</em>"
      }, {
        medication: "Naproxen",
        dosage: "30mg",
        frequency: "Every 24 hours <em>Q1D</em>",
        start: "9 hours ago <em>1 dosage given</em>",
        end: "in 6 days, 15 hours <em>7 dosages remaining</em>"
      }
    ],
    dosages: [
      {
        medication: "Morphine",
        dosage: "100mg",
        scheduledTime: "in 6 minutes",
        done: false
      }, {
        medication: "Naproxen",
        dosage: "30mg",
        scheduledTime: "in about 15 hours",
        done: false
      }, {
        medication: "Morphine",
        dosage: "100mg",
        scheduledTime: "54 minutes ago",
        done: true
      }, {
        medication: "Naproxen",
        dosage: "30mg",
        scheduledTime: "9 hours ago",
        done: true
      }
    ],
    nextDosage: "in 6 min.",
    status: "warning",
    bed: 9,
    portraitFilename: "franck.jpg"
  });

  putin = $.extend({}, kamran);

  putin.name = "Vladamir Putin";

  putin.ethnicity = "White";

  putin.address = "Russia";

  putin.portraitFilename = "putin.jpg";

  putin.age = 60;

  putin.bed = 11;

  obama = $.extend({}, mohammad);

  obama.name = "Barack Obama";

  obama.ethnicity = "Black";

  obama.address = "The White House";

  obama.portraitFilename = "obama.jpg";

  obama.age = 51;

  obama.bed = 12;

  bush = $.extend({}, robin);

  bush.name = "George Bush";

  bush.ethnicity = "White";

  bush.address = "New Haven, CT";

  bush.portraitFilename = "bush.jpg";

  bush.age = 66;

  bush.bed = 15;

  zuckerberg = $.extend({}, franck);

  zuckerberg.name = "Mark Zuckerberg";

  zuckerberg.ethnicity = "White";

  zuckerberg.address = "Menlo Park, CA";

  zuckerberg.portraitFilename = "zuckerberg.jpg";

  zuckerberg.age = 28;

  zuckerberg.bed = 13;

  testPatients = [kamran];

  sortByName = function() {
    var $list, listItems;

    $list = $("#patients");
    listItems = $list.children("li").get();
    listItems.sort(function(a, b) {
      var aVal, bVal;

      aVal = $(a).find("h2.name").text();
      bVal = $(b).find("h2.name").text();
      if (aVal < bVal) {
        return -1;
      }
      if (aVal > bVal) {
        return 1;
      }
      return 0;
    });
    return $list.append(listItems);
  };

  sortByBed = function() {
    var $list, listItems;

    $list = $("#patients");
    listItems = $list.children("li").get();
    listItems.sort(function(a, b) {
      var aVal, bVal;

      aVal = parseInt($(a).find(".bed-number").text(), 10);
      bVal = parseInt($(b).find(".bed-number").text(), 10);
      if (aVal < bVal) {
        return -1;
      }
      if (aVal > bVal) {
        return 1;
      }
      return 0;
    });
    return $list.append(listItems);
  };

  $(function() {
    var patient, _i, _len;

    $("#sort-by-name").click(function(event) {
      event.stopPropagation();
      event.preventDefault();
      if ($(this).hasClass("active")) {
        return;
      }
      $("#sort-by-bed").removeClass("active");
      $(this).addClass("active");
      return sortByName();
    });
    $("#sort-by-bed").click(function(event) {
      event.stopPropagation();
      event.preventDefault();
      if ($(this).hasClass("active")) {
        return;
      }
      $("#sort-by-name").removeClass("active");
      $(this).addClass("active");
      return sortByBed();
    });
    for (_i = 0, _len = testPatients.length; _i < _len; _i++) {
      patient = testPatients[_i];
      patient.listItem().data({
        patient: patient
      }).appendTo("#patients");
    }
    sortByName();
    $(document).on("click", ".not-implemented", {}, function(event) {
      event.stopPropagation();
      event.preventDefault();
      return $("#flash-message").stop().hide().slideDown(100).delay(1000).fadeOut(500);
    });
    $(document).on("focus", ".date-time-picker-input", {}, function() {
      return $(this).siblings(".date-time-picker").slideDown(200);
    });
    $(document).on("blur", ".date-time-picker-input", {}, function() {
      return $(this).siblings(".date-time-picker").slideUp(200);
    });
    $(document).on("click", ".input", {}, function(event) {
      event.stopPropagation();
      event.preventDefault();
      return $(this).find("input").focus();
    });
    $(document).on("click", ".remove-new", {}, function(event) {
      event.stopPropagation();
      event.preventDefault();
      return $(this).parents("tr").remove();
    });
    $(".done").click(function(event) {
      event.stopPropagation();
      event.preventDefault();
      return $(this).parents("tr").addClass("done");
    });
    $(".undo").click(function(event) {
      event.stopPropagation();
      event.preventDefault();
      return $(this).parents("tr").removeClass("done");
    });
    $(".add-prescription").click(function(event) {
      var $newRow, $table;

      event.stopPropagation();
      event.preventDefault();
      $table = $(this).parents(".prescription").find("table.prescriptions");
      $newRow = $table.find(".new-template").clone().removeClass("new-template");
      return $newRow.appendTo($table.find("tbody")).hide().slideDown(200);
    });
    $(".medication-tabs a").click(function() {
      var tabName;

      if ($(this).hasClass("active")) {
        return;
      }
      $(this).parents(".medication-tabs").find("a").removeClass("active");
      $(this).addClass("active");
      tabName = $(this).data("tab");
      return $(this).parents(".medication").find(".medication-content > div").slideUp(100, function() {
        return $(this).filter("." + tabName).slideDown(100);
      });
    });
    $(".medication-tabs a[data-tab=overview]").click();
    $(".listing").click(function() {
      var $li;

      $li = $(this).parents("li");
      if ($li.hasClass("active")) {
        $li.removeClass("active");
        $li.find(".medication").slideUp(200);
        $("#add-patient").removeClass("secondary");
        return $("#patient-document").stop().slideUp(200, function() {
          return $("body").removeClass("patient-selected");
        });
      } else {
        $("#patients > li.active").removeClass("active");
        $("#patients > li .medication").slideUp(200);
        $li.addClass("active");
        $li.find(".medication").slideDown(200);
        $("body").addClass("patient-selected");
        $("#add-patient").addClass("secondary");
        return $("#patient-document").stop().fadeOut(100, function() {
          $("#patient-document").html($li.data("patient").patientDocument());
          return $("#patient-document").fadeIn(300);
        });
      }
    });
    $("#patients > li .medication").slideUp(10);
    return $("#number-of-patients .count").text(testPatients.length);
  });

}).call(this);
