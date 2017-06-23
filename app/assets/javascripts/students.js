
var func =(function() {
    $('.change_assit').click(function(){
        $.ajax({
            type: "PUT",
            dataType: "json",
            url: "/assistances/"+$(this).data('assist_id')+"/change_assist",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            success: function(data){
                if (data.attend){
                    $('#'+data.id).css("background-color", "#88ff88");
                    $('#'+data.id).text('yes');

                }
                else{
                    $('#'+data.id).css("background-color", "#ff8888");
                    $('#'+data.id).text('no');
                }
            }
        });
    });

});

$(document).on('turbolinks:load', func);
