#!/usr/bin/env python3
#
# pull facts from postconf, return in yaml for puppet
#
import subprocess
import yaml

postconf_cmd = '/usr/sbin/postconf'

# feed postconf output into a list
postconf_output = subprocess.Popen(postconf_cmd,shell=True,stdout=subprocess.PIPE,encoding='utf8',text=True)

# init dictionary, including the name so that the yaml outputs like we want
pocketprotector_postconf = {'pocketprotector_postconf': {}}

# feed list into dictionary
for subprocess_config in postconf_output.stdout:
    postconfvar = subprocess_config.split(" = ")[0]
    # if var length is longer than 1, the split above failed, which means the value is set to null, i.e. ignore it for now
    if len(postconfvar.split()) == 1:
        postconfval = subprocess_config.split(" = ")[1].strip()
        #print("pocketprotector_postconf['pocketprotector_postconf'][" + postconfvar + "] = " + postconfval)
        # feed parts into dictionary
        pocketprotector_postconf['pocketprotector_postconf'][postconfvar] = postconfval

print(yaml.dump(pocketprotector_postconf))