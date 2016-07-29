From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 29 Jul 2016 10:30:16 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: only check Tx queue
	enablement when debugging
In-Reply-To: <20160729173006.25548.93033.stgit@localhost6.localdomain6>
References: <20160729173006.25548.93033.stgit@localhost6.localdomain6>
Message-ID: <20160729173016.25548.28505.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Following a write the VFTXDCTL.ENABLE bit is set only when the Tx queue
is actually enabled, which may not happen during the configure phase even
if we waited for it. Make this check debug only since this is causing
confusion with users who notice the warning in dmesg.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 8d4f535..4044608 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1612,7 +1612,7 @@ static void ixgbevf_configure_tx_ring(struct ixgbevf_adapter *adapter,
 		txdctl = IXGBE_READ_REG(hw, IXGBE_VFTXDCTL(reg_idx));
 	}  while (--wait_loop && !(txdctl & IXGBE_TXDCTL_ENABLE));
 	if (!wait_loop)
-		pr_err("Could not enable Tx Queue %d\n", reg_idx);
+		hw_dbg(hw, "Could not enable Tx Queue %d\n", reg_idx);
 }
 
 /**

