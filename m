From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:34 -0700
Subject: [Intel-wired-lan] [next PATCH S37 04/15] i40e: Add a call to set
	the client interface down
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

We were failing to set the client interface down when we put the vsi
down. Add this call so that the client doesn't get an open called with
no close.

Also remove an un-needed delay. The vf should not be affected at all by
i40e_down.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I1135dffef534bf84e6fed57cf51bcf590e6cfaf7
---
Testing Hints: See HSD
HSD-number: 7662119

 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ad2191c..3439e9f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5186,12 +5186,6 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi)
 		usleep_range(1000, 2000);
 	i40e_down(vsi);
 
-	/* Give a VF some time to respond to the reset.  The
-	 * two second wait is based upon the watchdog cycle in
-	 * the VF driver.
-	 */
-	if (vsi->type == I40E_VSI_SRIOV)
-		msleep(2000);
 	i40e_up(vsi);
 	clear_bit(__I40E_CONFIG_BUSY, &pf->state);
 }
@@ -5234,6 +5228,9 @@ void i40e_down(struct i40e_vsi *vsi)
 		i40e_clean_tx_ring(vsi->tx_rings[i]);
 		i40e_clean_rx_ring(vsi->rx_rings[i]);
 	}
+
+	i40e_notify_client_of_netdev_close(vsi, false);
+
 }
 
 /**
@@ -5943,7 +5940,6 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 		if (I40E_DEBUG_FD & pf->hw.debug_mask)
 			dev_info(&pf->pdev->dev, "FD Filter table flushed and FD-SB replayed.\n");
 	}
-
 }
 
 /**
-- 
2.4.11

