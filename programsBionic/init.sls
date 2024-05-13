git:
  pkg.installed

gimp:
  pkg.installed

nginx:
  pkg.installed

snapd:
  pkg.installed
    
vscode:
  cmd.run:
    - name: sudo snap install code --classic
    - unless: snap list code
    
postman:
  cmd.run:
    - name: sudo snap install postman
    - unless: snap list postman

eclipse:
  cmd.run:
    - name: sudo snap install eclipse --classic
    - unless: snap list eclipse

chromium:
  cmd.run:
    - name: sudo snap install chromium
    - unless: snap list chromium
micro:
  cmd.run:
    - name: sudo snap install micro --classic
    - unless: snap list chromium

/etc/nginx/sites-available/testisivu:
  file.managed:
    - source: "salt://programsBionic/testisivu"
    - watch_in:
      - service: "nginx.service"

/etc/nginx/sites-enabled/default:
  file.absent:
    - watch_in:
      - service: "nginx.service"

/etc/nginx/sites-enabled/testisivu:
  file.symlink:
    - target: "../sites-available/testisivu"
    - watch_in:
      - service: "nginx.service"

/home/vagrant/public_html/index.html:
  file.managed:
    - source: "salt://programsBionic/index.html"
    - user: vagrant
    - group: vagrant
    - makedirs: True
    - Replace: False

nginx.service:
  service.running