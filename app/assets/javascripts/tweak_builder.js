//Sound Files
var addSound = new Audio("../sounds/add_letter.mp3");
var deleteSound = new Audio("../sounds/remove_letter.mp3")

$(function(){
  $(".word, #items2").sortable({
    connectWith: ".word, #items2 .tweak-character",
    update: function( ) {
      addSound.play();
      completeActionShowSubmit();
    }
  });

  //focus on a letter
  $('.tweak-character.original-character').click(function(){
    $('.tweak-character').removeClass('focus');
    $('#alphabet-container').removeClass('hidden');
    $(this).addClass('focus');
  });


  //add a letter
  $('.tweak-character.addable').click(function(){
    addSound.play();
    var newCharacter = $(this).children('input').val();
    var $focusedCharacter = $('.tweak-character.focus');
    $focusedCharacter.children('input').val(newCharacter);
    $focusedCharacter.children('.character').html(newCharacter);
    $focusedCharacter.removeClass('focus');
    completeActionShowSubmit();

  })

  //press red delete button
  $('.delete-button').click(function(){
    $('.tweak-character.focus').remove();
    deleteSound.play();
    completeActionShowSubmit();

  })
})


function completeActionShowSubmit() {
  $('#alphabet-container').remove();
  $('.tweak-character').removeClass('focus');
  $('.reset-btn').removeClass('hidden');
  $('.description-area').removeClass('hidden').focus();
  $('.submit-button').removeClass('hidden');
  $('.tweak-character').unbind('click');
}



