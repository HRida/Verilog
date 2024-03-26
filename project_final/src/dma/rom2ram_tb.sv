module rom2ram_tb;

  // Parameters
  parameter DATA_WIDTH = 8;
  parameter DEPTH = 16;
  parameter INIT_FILE = "rom_file.mem";
  parameter DATA_AMOUNT = 16;
  localparam ADDR_WIDTH = $clog2(DEPTH);

  // Signals
  logic clk;
  logic start;
  logic done;
  logic reset;
  logic start_rom;
  logic start_dma;
  logic [DATA_AMOUNT-1:0] data_amt;
  logic [DATA_WIDTH-1:0] matrix_data [DATA_AMOUNT-1:0];

  // Instantiate the unit under test (UUT)
  rom2ram #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .INIT_FILE(INIT_FILE),
    .DATA_AMOUNT(DATA_AMOUNT)
  ) rom2ram_dut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .start_rom(start_rom),
    .start_dma(start_dma),
    .data_amt(data_amt),
    .matrix_data(matrix_data),
    .done(done)
  );

  // Clock process
  always #5 clk = ~clk;  // Toggle clock every 5 time units

  // Test process
  initial begin
    // Initialize signals
    clk = 0;
    start = 0;
    reset = 0;
    data_amt = 16;

    // Wait for a while
    #10;
    // Start the rom-write
    start_rom <= 1;
    // Start the dma
    start_dma <= 1;
    // Start the rom2ram
    start <= 1;
    // Wait for a 100 time units
    #100;

    // Check if done is asserted
    if (!done) begin
      $display("Test failed: done is not asserted.");
    end else begin
      $display("Test passed: done is asserted.");
    end

    // End simulation
    $finish;
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars; //dump all variables
  end

endmodule