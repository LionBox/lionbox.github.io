$('#exampleModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var recipient = button.data('whatever') // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this)
  modal.find('.modal-title').text('New message to ' + recipient)
  modal.find('.modal-body input').val(recipient)
})

// needs to be a string for jquery.cookie
var postId = '1'; 

$(function()
{
	// initialize kudos
	$("figure.kudoable").kudoable();
	// check to see if user has already kudod
	// fyi cookies do not work when you are viewing this as a file
	if($.cookie(postId) == 'true') {
		// make kudo already kudod
		$("figure.kudoable").removeClass("animate").addClass("complete");

		// your server would take care of the proper kudos count, but because this is a
		// static page, we need to set it here so it doesn't become -1 when you remove
		// the kudos after a reload
		$(".num").html(1);
	}	

	// when kudoing
	$("figure.kudo").bind("kudo:active", function(e)
	{
		console.log("kudoing active");
	});

	// when not kudoing
	$("figure.kudo").bind("kudo:inactive", function(e)
	{
		console.log("kudoing inactive");
	});

	// after kudo'd
	$("figure.kudo").bind("kudo:added", function(e)
	{
		var element = $(this);
		// ajax'y stuff or whatever you want
		console.log("Kodo'd:", element.data('id'), ":)");

		// set cookie so user cannot kudo again for 7 days
		$.cookie(postId, 'true', { expires: 7 });
	});

	// after removing a kudo
	$("figure.kudo").bind("kudo:removed", function(e)
	{
		var element = $(this);
		// ajax'y stuff or whatever you want
		console.log("Un-Kudo'd:", element.data('id'), ":(");

		// remove cookie
		$.removeCookie(postId);
	});
});
