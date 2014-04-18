function validateFiles(inputFile) {
  var maxExceededMessage = "This file exceeds the maximum allowed file size (5 MB)";
  var extErrorMessage = "Only image file with extension: .jpg, .jpeg, .gif or .png is allowed";
  var allowedExtension = ["jpg", "jpeg", "gif", "png"];

  var extName;
  var maxFileSize = $(inputFile).data('max-file-size');
  var sizeExceeded = false;
  var extError = false;

  $.each(<span class="skimlinks-unlinked">inputFile.files</span>, function() {
    if (<span class="skimlinks-unlinked">this.size</span> && maxFileSize && <span class="skimlinks-unlinked">this.size</span> > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = <span class="skimlinks-unlinked">this.name.split('.').pop</span>();
    if ($.inArray(extName, allowedExtension) == -1) {extError=true;};
  });
  if (sizeExceeded) {
    <span class="skimlinks-unlinked">window.alert(maxExceededMessage</span>);
    $(inputFile).val('');
  };

  if (extError) {
    <span class="skimlinks-unlinked">window.alert(extErrorMessage</span>);
    $(inputFile).val('');
  };
}
