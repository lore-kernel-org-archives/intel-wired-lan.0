From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Mon, 27 Jul 2015 12:04:41 -0700
Subject: [Intel-wired-lan] [PATCH V2 07/12] ixgbe: Clear I2C destination
	location
In-Reply-To: <20150727190244.104300.81756.stgit@mdrustad-wks.jf.intel.com>
References: <20150727190244.104300.81756.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150727190441.104300.76106.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Clear the destination location for I2C data initially so that
the received data will not be affected by previous attempts.
This could have returned wrong data in certain retry sequences.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index d334011f09d1..174e75b6b6d4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -2014,6 +2014,7 @@ static s32 ixgbe_clock_in_i2c_byte(struct ixgbe_hw *hw, u8 *data)
 	s32 i;
 	bool bit = false;
 
+	*data = 0;
 	for (i = 7; i >= 0; i--) {
 		ixgbe_clock_in_i2c_bit(hw, &bit);
 		*data |= bit << i;

