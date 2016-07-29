From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 29 Jul 2016 10:30:06 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: only check Tx queue enablement
	when debugging
Message-ID: <20160729173006.25548.93033.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Following a write the TXDCTL.ENABLE bit is set only when the Tx queue
is actually enabled, which may not happen during the configure phase even
if we waited for it. Make this check debug only since this is causing
confusion with users who notice the warning in dmesg.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7871f53..f687b76 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3224,7 +3224,7 @@ void ixgbe_configure_tx_ring(struct ixgbe_adapter *adapter,
 		txdctl = IXGBE_READ_REG(hw, IXGBE_TXDCTL(reg_idx));
 	} while (--wait_loop && !(txdctl & IXGBE_TXDCTL_ENABLE));
 	if (!wait_loop)
-		e_err(drv, "Could not enable Tx Queue %d\n", reg_idx);
+		hw_dbg(hw, "Could not enable Tx Queue %d\n", reg_idx);
 }
 
 static void ixgbe_setup_mtqc(struct ixgbe_adapter *adapter)

