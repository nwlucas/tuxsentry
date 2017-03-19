defmodule Facts.CPU.InfoStat do
  @derive [Poison.Encoder]

  @type t :: %Facts.CPU.InfoStat{
    cpu: integer,
    vendor_id: binary,
    family: binary,
    model: binary,
    stepping: integer,
    physical_id: binary,
    core_id: binary,
    cores: integer,
    model_name: float,
    mhz: float,
    cache_size: integer,
    flags: list,
    microcode: binary
    }

  defstruct [
    cpu: 0,
    vendor_id: "",
    family: "",
    model: "",
    stepping: 0,
    physical_id: "",
    core_id: "",
    cores: 0,
    model_name: 0.0,
    mhz: 0.0,
    cache_size: 0,
    flags: [],
    microcode: ""
  ]
end
