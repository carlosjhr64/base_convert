require 'base_convert'
include BaseConvert

# IRB Tools
require 'irbtools/configure'
_ = BaseConvert::VERSION.split('.')[0..1].join('.')
Irbtools.welcome_message = "### BaseConvert(#{_}) ###"
require 'irbtools'
IRB.conf[:PROMPT][:BaseConvert] = {
  PROMPT_I:    '> ',
  PROMPT_N:    '| ',
  PROMPT_C:    '| ',
  PROMPT_S:    '| ',
  RETURN:      "=> %s \n",
  AUTO_INDENT: true,
}
IRB.conf[:PROMPT_MODE] = :BaseConvert
