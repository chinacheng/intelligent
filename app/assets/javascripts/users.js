jQuery(window).load(function(){

  function get_position(crop){
    $("#position_x").val(crop.x);
    $("#position_y").val(crop.y);
    $("#width").val(crop.w);
    $("#height").val(crop.h);
  }

  $.Jcrop('#user_avatar_medium',{
    setSelect: [20, 20, 150, 150 ],
    maxSize: [300, 300],
    minSize: [100, 100],
    aspectRatio: 1,
    onChange: get_position,
    onSelect: get_position
  });

  $("#cut_avatar_button").live("click",function(){
    if($("#width").val() == "0" || $("#height").val() == "0"){
      $("#cut_message").show();
      return false;
    }
  });

});


