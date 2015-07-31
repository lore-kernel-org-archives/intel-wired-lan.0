From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 30 Jul 2015 17:20:10 -0700
Subject: [Intel-wired-lan] [PATCH V3 06/13] ixgbe: Enable bit-banging mode
	on X550
In-Reply-To: <20150731001845.112031.6979.stgit@mdrustad-wks.jf.intel.com>
References: <20150731001845.112031.6979.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150731002010.112031.42695.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set the bit banging mode in the hardware when performing bit banging
I2C operations on X550. Also control the output enable on both the
clock and data lines.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c |   65 +++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index f342174a4840..d334011f09d1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1940,11 +1940,14 @@ s32 ixgbe_write_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
  *  @hw: pointer to hardware structure
  *
  *  Sets I2C start condition (High -> Low on SDA while SCL is High)
+ *  Set bit-bang mode on X550 hardware.
  **/
 static void ixgbe_i2c_start(struct ixgbe_hw *hw)
 {
 	u32 i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
 
+	i2cctl |= IXGBE_I2C_BB_EN(hw);
+
 	/* Start condition must begin with data and clock high */
 	ixgbe_set_i2c_data(hw, &i2cctl, 1);
 	ixgbe_raise_i2c_clk(hw, &i2cctl);
@@ -1969,10 +1972,15 @@ static void ixgbe_i2c_start(struct ixgbe_hw *hw)
  *  @hw: pointer to hardware structure
  *
  *  Sets I2C stop condition (Low -> High on SDA while SCL is High)
+ *  Disables bit-bang mode and negates data output enable on X550
+ *  hardware.
  **/
 static void ixgbe_i2c_stop(struct ixgbe_hw *hw)
 {
 	u32 i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
+	u32 data_oe_bit = IXGBE_I2C_DATA_OE_N_EN(hw);
+	u32 clk_oe_bit = IXGBE_I2C_CLK_OE_N_EN(hw);
+	u32 bb_en_bit = IXGBE_I2C_BB_EN(hw);
 
 	/* Stop condition must begin with data low and clock high */
 	ixgbe_set_i2c_data(hw, &i2cctl, 0);
@@ -1985,6 +1993,13 @@ static void ixgbe_i2c_stop(struct ixgbe_hw *hw)
 
 	/* bus free time between stop and start (4.7us)*/
 	udelay(IXGBE_I2C_T_BUF);
+
+	if (bb_en_bit || data_oe_bit || clk_oe_bit) {
+		i2cctl &= ~bb_en_bit;
+		i2cctl |= data_oe_bit | clk_oe_bit;
+		IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), i2cctl);
+		IXGBE_WRITE_FLUSH(hw);
+	}
 }
 
 /**
@@ -2032,6 +2047,7 @@ static s32 ixgbe_clock_out_i2c_byte(struct ixgbe_hw *hw, u8 data)
 	/* Release SDA line (set high) */
 	i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
 	i2cctl |= IXGBE_I2C_DATA_OUT(hw);
+	i2cctl |= IXGBE_I2C_DATA_OE_N_EN(hw);
 	IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), i2cctl);
 	IXGBE_WRITE_FLUSH(hw);
 
@@ -2046,15 +2062,21 @@ static s32 ixgbe_clock_out_i2c_byte(struct ixgbe_hw *hw, u8 data)
  **/
 static s32 ixgbe_get_i2c_ack(struct ixgbe_hw *hw)
 {
+	u32 data_oe_bit = IXGBE_I2C_DATA_OE_N_EN(hw);
 	s32 status = 0;
 	u32 i = 0;
 	u32 i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
 	u32 timeout = 10;
 	bool ack = true;
 
+	if (data_oe_bit) {
+		i2cctl |= IXGBE_I2C_DATA_OUT(hw);
+		i2cctl |= data_oe_bit;
+		IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), i2cctl);
+		IXGBE_WRITE_FLUSH(hw);
+	}
 	ixgbe_raise_i2c_clk(hw, &i2cctl);
 
-
 	/* Minimum high period of clock is 4us */
 	udelay(IXGBE_I2C_T_HIGH);
 
@@ -2092,7 +2114,14 @@ static s32 ixgbe_get_i2c_ack(struct ixgbe_hw *hw)
 static s32 ixgbe_clock_in_i2c_bit(struct ixgbe_hw *hw, bool *data)
 {
 	u32 i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
+	u32 data_oe_bit = IXGBE_I2C_DATA_OE_N_EN(hw);
 
+	if (data_oe_bit) {
+		i2cctl |= IXGBE_I2C_DATA_OUT(hw);
+		i2cctl |= data_oe_bit;
+		IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), i2cctl);
+		IXGBE_WRITE_FLUSH(hw);
+	}
 	ixgbe_raise_i2c_clk(hw, &i2cctl);
 
 	/* Minimum high period of clock is 4us */
@@ -2147,13 +2176,20 @@ static s32 ixgbe_clock_out_i2c_bit(struct ixgbe_hw *hw, bool data)
  *  @i2cctl: Current value of I2CCTL register
  *
  *  Raises the I2C clock line '0'->'1'
+ *  Negates the I2C clock output enable on X550 hardware.
  **/
 static void ixgbe_raise_i2c_clk(struct ixgbe_hw *hw, u32 *i2cctl)
 {
+	u32 clk_oe_bit = IXGBE_I2C_CLK_OE_N_EN(hw);
 	u32 i = 0;
 	u32 timeout = IXGBE_I2C_CLOCK_STRETCHING_TIMEOUT;
 	u32 i2cctl_r = 0;
 
+	if (clk_oe_bit) {
+		*i2cctl |= clk_oe_bit;
+		IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), *i2cctl);
+	}
+
 	for (i = 0; i < timeout; i++) {
 		*i2cctl |= IXGBE_I2C_CLK_OUT(hw);
 		IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), *i2cctl);
@@ -2173,11 +2209,13 @@ static void ixgbe_raise_i2c_clk(struct ixgbe_hw *hw, u32 *i2cctl)
  *  @i2cctl: Current value of I2CCTL register
  *
  *  Lowers the I2C clock line '1'->'0'
+ *  Asserts the I2C clock output enable on X550 hardware.
  **/
 static void ixgbe_lower_i2c_clk(struct ixgbe_hw *hw, u32 *i2cctl)
 {
 
 	*i2cctl &= ~IXGBE_I2C_CLK_OUT(hw);
+	*i2cctl &= ~IXGBE_I2C_CLK_OE_N_EN(hw);
 
 	IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), *i2cctl);
 	IXGBE_WRITE_FLUSH(hw);
@@ -2193,13 +2231,17 @@ static void ixgbe_lower_i2c_clk(struct ixgbe_hw *hw, u32 *i2cctl)
  *  @data: I2C data value (0 or 1) to set
  *
  *  Sets the I2C data bit
+ *  Asserts the I2C data output enable on X550 hardware.
  **/
 static s32 ixgbe_set_i2c_data(struct ixgbe_hw *hw, u32 *i2cctl, bool data)
 {
+	u32 data_oe_bit = IXGBE_I2C_DATA_OE_N_EN(hw);
+
 	if (data)
 		*i2cctl |= IXGBE_I2C_DATA_OUT(hw);
 	else
 		*i2cctl &= ~IXGBE_I2C_DATA_OUT(hw);
+	*i2cctl &= ~data_oe_bit;
 
 	IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), *i2cctl);
 	IXGBE_WRITE_FLUSH(hw);
@@ -2207,6 +2249,14 @@ static s32 ixgbe_set_i2c_data(struct ixgbe_hw *hw, u32 *i2cctl, bool data)
 	/* Data rise/fall (1000ns/300ns) and set-up time (250ns) */
 	udelay(IXGBE_I2C_T_RISE + IXGBE_I2C_T_FALL + IXGBE_I2C_T_SU_DATA);
 
+	if (!data)	/* Can't verify data in this case */
+		return 0;
+	if (data_oe_bit) {
+		*i2cctl |= data_oe_bit;
+		IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), *i2cctl);
+		IXGBE_WRITE_FLUSH(hw);
+	}
+
 	/* Verify data was set correctly */
 	*i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
 	if (data != ixgbe_get_i2c_data(hw, i2cctl)) {
@@ -2223,9 +2273,19 @@ static s32 ixgbe_set_i2c_data(struct ixgbe_hw *hw, u32 *i2cctl, bool data)
  *  @i2cctl: Current value of I2CCTL register
  *
  *  Returns the I2C data bit value
+ *  Negates the I2C data output enable on X550 hardware.
  **/
 static bool ixgbe_get_i2c_data(struct ixgbe_hw *hw, u32 *i2cctl)
 {
+	u32 data_oe_bit = IXGBE_I2C_DATA_OE_N_EN(hw);
+
+	if (data_oe_bit) {
+		*i2cctl |= data_oe_bit;
+		IXGBE_WRITE_REG(hw, IXGBE_I2CCTL(hw), *i2cctl);
+		IXGBE_WRITE_FLUSH(hw);
+		udelay(IXGBE_I2C_T_FALL);
+	}
+
 	if (*i2cctl & IXGBE_I2C_DATA_IN(hw))
 		return true;
 	return false;
@@ -2240,10 +2300,11 @@ static bool ixgbe_get_i2c_data(struct ixgbe_hw *hw, u32 *i2cctl)
  **/
 static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
 {
-	u32 i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
+	u32 i2cctl;
 	u32 i;
 
 	ixgbe_i2c_start(hw);
+	i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
 
 	ixgbe_set_i2c_data(hw, &i2cctl, 1);
 

