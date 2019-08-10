# yabaker

A tool for quickly creating YAML from templates.

There are many tools for orchestrating kubernetes YAML, such as helm, kustomerize or kaptain. However, they are too heavy for me.

What I want is a tool that can create yaml files based on a set of templates I created. I don't want to learn heavy tools, I don't want this tool to do too much work such as including other files or version management. I just want the tool to be able to search for and replace the variables I set in the template.

Yabaker is such a tool.

## Tuotorial

1. clone this project

    `git clone git@github.com:lanesky/yabaker.git`

2. Run below command to make the shell script executable

    `chmod +x create_yaml.sh`

3. Run below command to create the yaml files from template. The new files will be created into a temp folder at current directory.

    `./create_yaml.sh example/template/ example/dev.conf`

Template files:

```
mysql-pvc.yaml.template
mysql-svc.yaml.template
mysql.yaml.template
wordpress-pvc.yaml.template
wordpress-svc.yaml.template
wordpress.yaml.template
```

Created YAML files:

```
mysql-pvc.yaml
mysql-svc.yaml
mysql.yaml
wordpress-pvc.yaml
wordpress-svc.yaml
wordpress.yaml
```

## Configuration

1. For each variable in the yaml, you need to add double braces. Below is an example.
```
apiVersion: v1
kind: Service
metadata:
  name: mysql
  labels:
    app: mysql
    env: {{env}}
spec:
  type: ClusterIP
  ports:
    - port: 3306
  selector:
    app: mysql
    env: {{env}}
```

2. The conf. file looks as below. What you need to do is to add the variable-value pairs into it.

```
env=dev
mysql.storage.size=20Gi
wordpress.storage.size=20Gi
```