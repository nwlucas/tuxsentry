defmodule Facts.CPU.TimesStat do
  @derive [Poison.Encoder]
  defstruct [
    :cpu,
    :user,
    :system,
    :idle,
    :nice,
    :iowait,
    :irq,
    :softirq,
    :steal,
    :guest,
    :guest_nice,
    :stolen,
  ]
end
