From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:45 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 08/11] i40e: don't re-enable ATR
	when flushing filters if SB has TCP4/IPv4 rules
In-Reply-To: <20170206223846.31052-1-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
Message-ID: <20170206223846.31052-9-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When flushing and replaying FDIR filters, it is possible we would
disable ATR, and then re-enable it even though we should have kept
it disabled due to existing TCP/IPv4 filters. Fix this by checking
whether we have TCP4/IPv4 filters before re-enabling.

Alternatively, we could instead restore ATR and then replay filters,
however, this would cause us to rapidly enable and then disable ATR in
some cases.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Dayanand, Avinash <avinash.dayanand@intel.com>
Reviewed-by: Brady, Alan <alan.brady@intel.com>
Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
Change-ID: I076e4cc1e4409bce7f98f3c213295433a4ff43d8
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 14a79e5f6857..e06c7b785fd8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6369,7 +6369,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 	} else {
 		/* replay sideband filters */
 		i40e_fdir_filter_restore(pf->vsi[pf->lan_vsi]);
-		if (!disable_atr)
+		if (!disable_atr && !pf->fd_tcp_rule)
 			pf->auto_disable_flags &= ~I40E_FLAG_FD_ATR_ENABLED;
 		clear_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state);
 		if (I40E_DEBUG_FD & pf->hw.debug_mask)
-- 
2.12.0.rc0.151.g8a5726c42288

