<h1>testing-vm</h1>

<h2>Introducing:</h2>
THis VM is for change services with various version of docker containers. You can change service version and recreate only that you changed or all at once. You can use images, Dockerfiles or together both.   Change containers and services is fast and simple.

<h2>Use:</h2>
To run virtual machine go into default directory and write:
<b>sudo vagrant up<b>

Then you run virtual machine, you need go inside:
<b>sudo vagrant ssh<b>

Then you inside machine, you can run first box in default directory ongr with command:
<b>sudo fig up -d<b>

If all good you can check with command:
<b>sudo docker ps<b>

Now you need go into elasticsearch directory if you want run ElasticSearch box. In file fig.yml you can change version of ElasticSearch, like example:
image: barnybug/elasticsearch:<b>1.3.2<b>

Then you change version, run command: <b>fig up -d elasticsearch</b> it will be recreate container and run with yours version.
