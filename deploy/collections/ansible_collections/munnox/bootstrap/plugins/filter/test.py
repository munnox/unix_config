# Inferred from https://github.com/ansible/ansible/blob/devel/lib/ansible/plugins/filter/core.py
# These filters can be used via the following playbook
# - name: Run Test on target
#   hosts: "{{ playbook_groups | default('localhost') }},!disabled"
#   vars:
#     key_list:
#       - 'id_ed25519'
#       - 'id_ed25519.pub'
#   tasks:
#     - name: Test the filter from munnox.bootstrap
#       ansible.builtin.debug:
#         msg: |
#           Test:
#           {{ key_list | munnox.bootstrap.munnox_test_to_yaml }}
#
#           {{ key_list | munnox.bootstrap.munnox_test_show_environment( key_list, hostvars.keys() | list, ansible_facts.keys() | list ) | to_nice_yaml }}

from ansible.module_utils._text import to_bytes, to_native, to_text
from ansible.errors import AnsibleError, AnsibleFilterError, AnsibleFilterTypeError
from ansible.utils.display import Display
from ansible.parsing.yaml.dumper import AnsibleDumper
import yaml
import uuid

from jinja2.filters import pass_environment

display = Display()

# Almost the same just changed via 'uuidgen'
UUID_NAMESPACE_ANSIBLE = uuid.UUID('CBB94019-031C-493F-A914-53872ECEA878')

# Simple filter basically does what to_yaml does from the
# core to show the principles and import system.
def munnox_test_to_yaml(a, *args, **kw):
    '''Make simple test filter'''
    default_flow_style = kw.pop('default_flow_style', None)
    try:
        transformed = yaml.dump(a, Dumper=AnsibleDumper, allow_unicode=True, default_flow_style=default_flow_style, **kw)
    except Exception as e:
        raise AnsibleFilterError("to_yaml - %s" % to_native(e), orig_exc=e)
    return to_text(transformed)

#https://jinja.palletsprojects.com/en/3.0.x/api/#jinja2.Environment
@pass_environment
def munnox_test_show_environment(environment, a, *args, **kw):
    '''Make simple test filter to show jinja environment'''
    env = {
        "env": list(dir(environment)),
        'args': args,
        'kw': kw,
        'env.getitem([a,b], 0)': environment.getitem(['a','b'], 0)
    }
    return env

class FilterModule(object):
    ''' Ansible core jinja2 filters '''

    def filters(self):
        return {
            'munnox_test_to_yaml': munnox_test_to_yaml,
            'munnox_test_show_environment': munnox_test_show_environment,
            # debug
            'type_debug': lambda o: o.__class__.__name__,
        }