#!/usr/bin/python

import sys
import os

class ResourceFamily:

    def __init__(self, family_name, target_height):
        self.family_name = family_name
        self.target_height = target_height


families = [
    ResourceFamily("", 180), #default

    ResourceFamily("-round-240x240", 180),
    ResourceFamily("-round-218x218", 163),
    ResourceFamily("-round-218x218", 163),

    ResourceFamily("-semiround-215x180", 135),

    ResourceFamily("-rectangle-200x265", 200),
    ResourceFamily("-rectangle-200x400", 200),
    ResourceFamily("-rectangle-205x148", 110),
    ResourceFamily("-rectangle-240x400", 200),
    ResourceFamily("-rectangle-148x205", 153),

    ResourceFamily("-tall-148x205", 153),
]

input_dir = './assets/'
output_dir_template = './resources{0}/drawables/'

for family in families:
    absolute_output_dir = os.path.abspath(output_dir_template.format(family.family_name))
    if not os.path.exists(absolute_output_dir):
        os.makedirs(absolute_output_dir)
    absolute_input_dir = os.path.abspath(input_dir)
    if family.family_name != "":
        cmd = 'cp {0} {1}'.format(absolute_input_dir + "/" + "drawables.xml", absolute_output_dir)
        os.system(cmd)
    for file in os.listdir(input_dir):
        if file.endswith(".svg"):
            file_name = os.path.splitext(file)[0]
            input_file = absolute_input_dir + "/" + file
            output_file = absolute_output_dir + "/" + file_name + ".png"
            cmd = 'inkscape -z -e {0} -h {1} {2}'.format(output_file, family.target_height, input_file)
            os.system(cmd)