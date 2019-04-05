desc "This task is called by the Heroku scheduler add-on"
task delete_tmps: :environment do
  Picture.where(linked: false).delete_all
  FileUtils.rm_rf Dir.glob("public/uploads/tmp/*")
end