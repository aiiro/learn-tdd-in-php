package "java-1.8.0-openjdk" do
  action :install
end

execute 'Jenkins.repo'  do
  command "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo"
  action :run
end

execute 'Jenkins rpm'  do
  command "sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key"
  action :run
end

package "jenkins" do
  action :install
end

service "jenkins" do
  action [:enable, :start]
end
