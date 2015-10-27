From: Dan Streetman <dan.streetman@canonical.com>
Date: Tue, 27 Oct 2015 14:27:55 -0400
Subject: [Intel-wired-lan] [PATCHv2] ixgbe: Wait for 1ms, not 1us, after RST
In-Reply-To: <562FBB01.3080901@hurleysoftware.com>
References: <562FBB01.3080901@hurleysoftware.com>
Message-ID: <1445970475-19111-1-git-send-email-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver currently waits 1us after issuing a RST, but the spec
requires it to wait 1ms.  This adds a msleep(1) before polling the
reset bit.

Signed-off-by: Dan Streetman <dan.streetman@canonical.com>
Signed-off-by: Dan Streetman <ddstreet@ieee.org>
---
changes since v1:
 use msleep(1) instead of mdelay(1), per Peter Hurley
 move msleep(1) out of for loop - only msleep once, leave udelay(1)
   inside for loop
 use spec sec title instead of number, per Don Skidmore

 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index 4e75843..02cfa1e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -111,6 +111,13 @@ mac_reset_top:
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, ctrl);
 	IXGBE_WRITE_FLUSH(hw);
 
+	/* From the spec "General Control Registers - Device Control Register":
+	 * "...programmers must wait approximately 1 ms after setting before
+	 *  attempting to check if the bit has cleared or to access (read
+	 *  or write) any other device register."
+	 */
+	msleep(1);
+
 	/* Poll for reset bit to self-clear indicating reset is complete */
 	for (i = 0; i < 10; i++) {
 		udelay(1);
-- 
2.5.0

