From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:39:12 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 10/11] i40e: explicitly fail on
	extended MAC field for ethtool_rx_flow_spec
Message-ID: <20170206223913.31525-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Although we will fail the filter later due to checking flow_type which
will have a bogus invalid type, it is possible future refactoring will
remove this hidden failure case. Avoid a possible issue in the future by
explicitly checking the flow type at the start.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-Id: Ia98eb26f7b93ccbe38c7141e8f203ef496fc6598
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index cfe4db974c8e..da36621379cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2733,6 +2733,10 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 
 	fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
 
+	/* Extended MAC field is not supported */
+	if (fsp->flow_type & FLOW_MAC_EXT)
+		return -EINVAL;
+
 	if (fsp->location >= (pf->hw.func_caps.fd_filters_best_effort +
 			      pf->hw.func_caps.fd_filters_guaranteed)) {
 		return -EINVAL;
-- 
2.12.0.rc0.151.g8a5726c42288

