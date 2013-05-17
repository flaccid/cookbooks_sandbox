rightscale_marker :begin

repo "default" do
    destination '/var/www'
    action node[:repo][:default][:perform_action].to_sym
    app_user node[:app][:user]
    repository node[:repo][:default][:repository]
    persist false
end

rightscale_marker :end