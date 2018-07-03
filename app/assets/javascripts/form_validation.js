// ensure that the user entered percentages for tillage practices or rotation practices for crops adds up to exactly 100%. 
$("#update-crop-practices-button").on('click', function(e) {
  var t1 = parseInt($("#no_tillage").val()) > 0 ? parseInt($("#no_tillage").val()) : 0;
  var t2 = parseInt($("#intensive_tillage").val()) > 0 ? parseInt($("#intensive_tillage").val()) : 0;
  var t3 = parseInt($("#reduced_tillage").val()) > 0 ? parseInt($("#reduced_tillage").val()) : 0;
  var r1 = parseInt($("#following_corn").val()) > 0 ? parseInt($("#following_corn").val()) : 0;
  var r2 = parseInt($("#following_soybeans").val()) > 0 ? parseInt($("#following_soybeans").val()) : 0;
  var sumOfTillageValues = t1 + t2 + t3;
  var sumOfRotationValues = r1 + r2;

  if (sumOfTillageValues != 100) {
    alert('Your tillage practices must add up to 100%.\n ' + t1 + '% + ' + t2 + '% + ' + t3 + '% = ' + sumOfTillageValues + '%.');
    e.preventDefault();
    e.stopPropagation();
  }
  if (sumOfRotationValues != 100) {
    alert('Your rotation practices must add up to 100%.\n ' + r1 + '% + ' + r2 + '% = ' + sumOfRotationValues + '%.');
    e.preventDefault();
    e.stopPropagation();
  }
});
