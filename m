From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:44 -0700
Subject: [Intel-wired-lan] [PATCH S43 15/15] ice: Add more Rx errors to
 netdev's rx_error counter
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we are only including illegal_bytes and rx_crc_errors in the
PF netdev's rx_error counter. There are many more causes of Rx errors
that the device supports and reports via Ethtool. Accumulate all Rx
errors in the PF netdev's rx_error counter.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e451120d6632..589bafb601ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4357,7 +4357,13 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 	if (vsi->type == ICE_VSI_PF) {
 		cur_ns->rx_crc_errors = pf->stats.crc_errors;
 		cur_ns->rx_errors = pf->stats.crc_errors +
-				    pf->stats.illegal_bytes;
+				    pf->stats.illegal_bytes +
+				    pf->stats.rx_len_errors +
+				    pf->stats.rx_undersize +
+				    pf->hw_csum_rx_error +
+				    pf->stats.rx_jabber +
+				    pf->stats.rx_fragments +
+				    pf->stats.rx_oversize;
 		cur_ns->rx_length_errors = pf->stats.rx_len_errors;
 		/* record drops from the port level */
 		cur_ns->rx_missed_errors = pf->stats.eth.rx_discards;
-- 
2.20.1

