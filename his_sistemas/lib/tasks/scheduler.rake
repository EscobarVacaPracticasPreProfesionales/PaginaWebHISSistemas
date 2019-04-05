desc "This task is called by the Heroku scheduler add-on"
task delete_tmps: :environment do
  Picture.where(linkked: false).delete_all
  FileUtils.rm_rf Dir.glob("#{Rails.root}/tmp/uploads/*")
end