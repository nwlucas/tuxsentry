defmodule Facts.CPU.InfoStat do
  @derive [Poison.Encoder]
#  @type t :: %TuxSentry.Facts.CPU.InfoStat{cpu: integer, vendor_id: binary, family: binary, model: binary,
#    stepping: integer, physical_id: binary, core_id: binary, cores: integer, model_name: float, mhz: float,
#     cache_size: integer, flags: list, microcode: binary}
  defstruct [
    :cpu,
    :vendor_id,
    :family,
    :model,
    :stepping,
    :physical_id,
    :core_id,
    :cores,
    :model_name,
    :mhz,
    :cache_size,
    :flags,
    :microcode
  ]

end
