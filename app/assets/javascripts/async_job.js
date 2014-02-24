$(document).ready(function(){
	$(".job-container").on("click", function() {
		var jobURL = "/jobs/" + $(this).attr("datajobid") + "/edit"
		$.ajax({url:jobURL}).done(function(data){
			$("#ajaxContainer").html(data)
		})
	});
});