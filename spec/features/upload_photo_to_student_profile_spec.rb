require 'spec_helper'

feature 'Uploading Student Photos', %q{
  I am a teacher adding a Student
  I would like to upload a Photo
  in order to remember the student's face.} do

  scenario 'teacher should successfully upload a photo'
  scenario 'teacher can unsuccessfully upload a photo based on file type'
  scenario 'The teacher can successfully preview the photo'

end
