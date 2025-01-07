import matplotlib.pyplot as plt
import numpy as np
from matplotlib import font_manager

from IPython.core.magic import register_line_magic
@register_line_magic
def r(line):
  get_ipython().run_line_magic('run', ' -i ' + line)
del r
