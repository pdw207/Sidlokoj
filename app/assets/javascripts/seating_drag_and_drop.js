
    function addHideButton(){

      $('#hide').click(function(e) {
          e.preventDefault();
          $('#sidebar').hide( "slow");
          $('#seating').attr('class', "small-12 columns");
      });
    }

    function addListeners(){
      var dragSrcEl;
      var students = document.querySelectorAll('.photo-draggable');
      [].forEach.call(students, function(student) {
        // Source
        student.addEventListener('dragstart', handleDragStart, false);
        student.addEventListener('dragend', handleDragEnd, false);
        //Target
        student.addEventListener('dragenter', handleDragEnter, false);
        student.addEventListener('dragleave', handleDragLeave, false);
        student.addEventListener('dragover', handleDragOver, false);
        student.addEventListener('drop', handleDrop, false);

      });
    };



    // Set the source to null
    var dragSrcEl = null

    function handleDragStart(e) {
      this.style.opacity = '0.4';
      dragSrcEl = this;
      e.dataTransfer.effectAllowed = 'move';
      e.dataTransfer.setData('text/html', this.innerHTML);
    }

    function handleDragOver(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }

      e.dataTransfer.dropEffect = 'move';

      return false;
    }


    function handleDragEnd(e) {
      this.style.opacity = '1.0';

    }


    function handleDrop(e){
      if (e.stopPropagation) {
        e.stopPropagation();
      }
      if (dragSrcEl != this) {
        // Set  Photos on drop
        var sourcePhoto = dragSrcEl.src;
        var targetPhoto = this.src;

        this.src = sourcePhoto;
        dragSrcEl.src = targetPhoto;


        //Update target so can swap
        var $sourceDataId = $(dragSrcEl).attr("data-student-id");
        var $targetDataId = $(this).attr("data-student-id");


        updateStudentId($targetDataId, dragSrcEl);
        updateStudentId($sourceDataId, this);

        // Update hidden Form & source form
        updateSeatForm(this);
        updateSeatForm(dragSrcEl);

      }
    }
    function updateStudentId(dataId, object) {
      if (typeof(dataId) === 'undefined'){
        $(object).attr( "data-student-id","");
      }
      else{
        $(object).attr( "data-student-id", dataId );
      }
    }
    function updateSeatForm(form) {
      var studentId = $(form).attr('data-student-id')
      var seatNumber = $(form).attr('data-seat')
      var selectFormId = '#course_enrollments_attributes_'  + seatNumber + '_student_id'
      $(selectFormId).val(studentId)
    }

    function handleDragEnter(e){
      e.preventDefault();

      // If object is not original object then...
      if (dragSrcEl != this) {
        console.log('enter')
      }

    }
    function handleDragLeave(e){
      e.preventDefault();
      console.log("leave");
    }

