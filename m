From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:15 -0700
Subject: [Intel-wired-lan] [next PATCH S36 07/12] i40e: change Rx hang
	message into a WARN_ONCE
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Use WARN_ONCE in order to highlight the issue, but don't display
a warning every time. The user should be able to see the ethtool counter
we created if necessary to see how often it is occurring.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I40c4ea159819b64a7d33b7f5716749089791533a
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index a1b878a..ed39cba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -289,9 +289,7 @@ void i40e_ptp_rx_hang(struct i40e_vsi *vsi)
 		rd32(hw, I40E_PRTTSYN_RXTIME_H(3));
 		pf->last_rx_ptp_check = jiffies;
 		pf->rx_hwtstamp_cleared++;
-		dev_warn(&vsi->back->pdev->dev,
-			 "%s: clearing Rx timestamp hang\n",
-			 __func__);
+		WARN_ONCE(1, "Detected Rx timestamp register hang\n");
 	}
 }
 
-- 
2.4.11

