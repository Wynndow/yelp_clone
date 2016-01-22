$(document).ready(function() {

  $('.endorsements-link').on('click', function(event){
      event.preventDefault();
      var endorsementCount = $(this).siblings('.endorsements_count');
      console.log(this.text);
      console.log(this.siblings);
      console.log(endorsementCount);

      console.log(endorsementCount);
      $.post(this.href, function(response){
        endorsementCount.text(response.new_endorsement_count);

    });
  });
});
