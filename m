From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 19 Jun 2015 16:37:36 -0700
Subject: [Intel-wired-lan] [net-next 07/10] fm10k: TRIVIAL fix typo in
	fm10k_netdev.c
In-Reply-To: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
References: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434757059-3384-7-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index c173c79373fe..79c0fa2646e7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1048,7 +1048,7 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 					   vid, true, 0);
 	}
 
-	/* update xcast mode before syncronizing addresses */
+	/* update xcast mode before synchronizing addresses */
 	hw->mac.ops.update_xcast_mode(hw, glort, xcast_mode);
 
 	/* synchronize all of the addresses */
-- 
2.4.3

