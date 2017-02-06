From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:42 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 05/11] i40e: exit ATR mode only when
	adding TCP/IPv4 filter succeeds
In-Reply-To: <20170206223846.31052-1-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
Message-ID: <20170206223846.31052-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move ATR exit check after we have sent the TCP/IPv4 filter to the ring
successfully. This avoids an issue where we potentially update the
filter count without actually succeeding in adding the filter. Now, we
only increment the fd_tcp_rule after we've succeeded. Additionally, we
will re-enable ATR mode only after deletion of the filter is actually
posted to the FDIR ring.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
Change-ID: If5c1dea422081cc5e2de65618b01b4c3bf6bd586
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8924ee6e7773..5756139636ff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -285,23 +285,6 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 	ip->saddr = fd_data->src_ip;
 	tcp->source = fd_data->src_port;
 
-	if (add) {
-		pf->fd_tcp_rule++;
-		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
-		    I40E_DEBUG_FD & pf->hw.debug_mask)
-			dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 flow being applied\n");
-		pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
-	} else {
-		pf->fd_tcp_rule = (pf->fd_tcp_rule > 0) ?
-				  (pf->fd_tcp_rule - 1) : 0;
-		if (pf->fd_tcp_rule == 0) {
-			if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
-			    I40E_DEBUG_FD & pf->hw.debug_mask)
-				dev_info(&pf->pdev->dev, "ATR re-enabled due to no sideband TCP/IPv4 rules\n");
-			pf->auto_disable_flags &= ~I40E_FLAG_FD_ATR_ENABLED;
-		}
-	}
-
 	fd_data->pctype = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
 	ret = i40e_program_fdir_filter(fd_data, raw_packet, pf, add);
 	if (ret) {
@@ -321,6 +304,23 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 				 fd_data->pctype, fd_data->fd_id);
 	}
 
+	if (add) {
+		pf->fd_tcp_rule++;
+		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
+		    I40E_DEBUG_FD & pf->hw.debug_mask)
+			dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 flow being applied\n");
+		pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
+	} else {
+		pf->fd_tcp_rule = (pf->fd_tcp_rule > 0) ?
+				  (pf->fd_tcp_rule - 1) : 0;
+		if (pf->fd_tcp_rule == 0) {
+			if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
+			    I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "ATR re-enabled due to no sideband TCP/IPv4 rules\n");
+			pf->auto_disable_flags &= ~I40E_FLAG_FD_ATR_ENABLED;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.12.0.rc0.151.g8a5726c42288

