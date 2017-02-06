From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:43 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 06/11] i40e: remove redundant check
	for fd_tcp_rule when restoring filters
In-Reply-To: <20170206223846.31052-1-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
Message-ID: <20170206223846.31052-7-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40e_fdir_filter_restore re-adds all existing filters, which already
checks when adding a TCPv4 filter to disable ATR. We don't need to make
the check twice, so remove this redundant code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Ia0b0690e23523915199d601494557def135c9d7f
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8414973cebef..a079c5bf1744 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5608,12 +5608,6 @@ static int i40e_up_complete(struct i40e_vsi *vsi)
 	if (vsi->type == I40E_VSI_FDIR) {
 		/* reset fd counters */
 		pf->fd_add_err = pf->fd_atr_cnt = 0;
-		if (pf->fd_tcp_rule > 0) {
-			pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
-			if (I40E_DEBUG_FD & pf->hw.debug_mask)
-				dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 exist\n");
-			pf->fd_tcp_rule = 0;
-		}
 		i40e_fdir_filter_restore(vsi);
 	}
 
-- 
2.12.0.rc0.151.g8a5726c42288

