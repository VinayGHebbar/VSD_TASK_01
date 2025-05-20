module top (
  output wire rgb1_red,
  output wire rgb1_green,
  output wire rgb1_blue,
  output wire rgb2_red,
  output wire rgb2_green,
  output wire rgb2_blue,
  input wire uart_rx
);

  wire int_clk;
  reg [7:0] rx_data;
  reg rx_data_ready;
  reg receiving;
  reg [3:0] bit_cnt;
  reg [15:0] clk_cnt;
  reg [7:0] rx_shift_reg;
  reg uartrx_sync_0, uartrx_sync_1;

  // Internal oscillator
  SB_HFOSC #(.CLKHF_DIV("0b10")) u_SB_HFOSC (
    .CLKHFPU(1'b1),
    .CLKHFEN(1'b1),
    .CLKHF(int_clk)
  );

  // Sync uart_rx to internal clock
  always @(posedge int_clk) begin
    uartrx_sync_0 <= uart_rx;
    uartrx_sync_1 <= uartrx_sync_0;
  end

  wire rx_falling_edge = (uartrx_sync_1 == 1'b1) && (uartrx_sync_0 == 1'b0);

  localparam CLK_FREQ = 12000000;
  localparam BAUD = 115200;

  // UART Receiver
  always @(posedge int_clk) begin
    if (receiving) begin
      if (clk_cnt == 0) begin
        clk_cnt <= CLK_FREQ / BAUD - 1;
        bit_cnt <= bit_cnt + 1;

        if (bit_cnt == 0) begin
          // Start bit (ignored)
        end else if (bit_cnt <= 8) begin
          rx_shift_reg <= {uartrx_sync_1, rx_shift_reg[7:1]};
        end else begin
          receiving <= 0;
          rx_data <= rx_shift_reg;
          rx_data_ready <= 1;
        end
      end else begin
        clk_cnt <= clk_cnt - 1;
      end
    end else begin
      rx_data_ready <= 0;
      if (rx_falling_edge) begin
        receiving <= 1;
        clk_cnt <= CLK_FREQ / (BAUD * 2); // half-bit delay
        bit_cnt <= 0;
      end
    end
  end

  // Color registers
  reg [2:0] rgb1_color = 3'b000;
  reg [2:0] rgb2_color = 3'b000;
  reg [23:0] blink_counter = 0;
  reg blink_state = 0;

  always @(posedge int_clk) begin
    blink_counter <= blink_counter + 1;
    if (blink_counter == 24'd6_000_000) begin // ~0.5s at 12MHz
      blink_state <= ~blink_state;
      blink_counter <= 0;
    end
  end

  // Handle received data
  always @(posedge int_clk) begin
    if (rx_data_ready) begin
      case (rx_data)
        "r": begin rgb1_color <= 3'b100; rgb2_color <= 3'b100; end // Red
        "g": begin rgb1_color <= 3'b010; rgb2_color <= 3'b010; end // Green
        "b": begin rgb1_color <= 3'b001; rgb2_color <= 3'b001; end // Blue
        "c": begin rgb1_color <= 3'b011; rgb2_color <= 3'b011; end // Cyan (G+B)
        "m": begin rgb1_color <= 3'b101; rgb2_color <= 3'b101; end // Magenta (R+B)
        "y": begin rgb1_color <= 3'b110; rgb2_color <= 3'b110; end // Yellow (R+G)
        "w": begin rgb1_color <= 3'b111; rgb2_color <= 3'b111; end // White (R+G+B)
        default: begin rgb1_color <= 3'b000; rgb2_color <= 3'b000; end // OFF
      endcase
    end
  end

  // Output assignments with blinking
  assign rgb1_red   = blink_state ? rgb1_color[2] : 0;
  assign rgb1_green = blink_state ? rgb1_color[1] : 0;
  assign rgb1_blue  = blink_state ? rgb1_color[0] : 0;

  assign rgb2_red   = blink_state ? rgb2_color[2] : 0;
  assign rgb2_green = blink_state ? rgb2_color[1] : 0;
  assign rgb2_blue  = blink_state ? rgb2_color[0] : 0;

endmodule
