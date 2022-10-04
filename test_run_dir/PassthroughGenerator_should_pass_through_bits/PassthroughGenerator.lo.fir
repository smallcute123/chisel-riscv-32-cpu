circuit PassthroughGenerator :
  module PassthroughGenerator :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<3>
    output io_out : UInt<3>

    io_out <= io_in @[Passthrough.scala 26:10]
