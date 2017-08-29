From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:36 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 07/13] i40e: fix merge error
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch removes some code that was accidentally added to
the wrong function with a merge error.  Fixes: c53934c6d1b1
("i40e: fix: do not sleep in netdev_ops")

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1764fd2..85bf225 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1776,11 +1776,6 @@ static void i40e_set_rx_mode(struct net_device *netdev)
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 		vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
 	}
-
-	/* schedule our worker thread which will take care of
-	 * applying the new filter changes
-	 */
-	i40e_service_event_schedule(vsi->back);
 }
 
 /**
-- 
2.9.4

