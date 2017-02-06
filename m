From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:44 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 07/11] i40e: reset fd_tcp_rule count
	when restoring filters
In-Reply-To: <20170206223846.31052-1-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
Message-ID: <20170206223846.31052-8-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since we're about to reprogram the filters, we need to ensure that the
fd_tcp_rule count is correctly reset to 0. Otherwise, we will keep
a stale count that does not accurately reflect the number of programmed
TCPv4 filters.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a079c5bf1744..14a79e5f6857 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3320,6 +3320,9 @@ static void i40e_fdir_filter_restore(struct i40e_vsi *vsi)
 	if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
 		return;
 
+	/* Reset FDir counters as we're replaying all existing filters */
+	pf->fd_tcp_rule = 0;
+
 	hlist_for_each_entry_safe(filter, node,
 				  &pf->fdir_filter_list, fdir_node) {
 		i40e_add_del_fdir(vsi, filter, true);
-- 
2.12.0.rc0.151.g8a5726c42288

