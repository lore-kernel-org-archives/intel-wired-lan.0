From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Wed, 03 Jun 2015 18:53:17 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: Fix missing braces after if
	statement
Message-ID: <20150604015219.2895.80478.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While reviewing the code I noticed that one of the commits added an if
statement followed by a for loop, but the if statement was missing the
braces around the loop.  This change corrects the coding style error.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 4b9d9f88af70..a9670e00cf03 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -143,12 +143,13 @@ static void fm10k_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 			p += ETH_GSTRING_LEN;
 		}
 
-		if (interface->hw.mac.type != fm10k_mac_vf)
+		if (interface->hw.mac.type != fm10k_mac_vf) {
 			for (i = 0; i < FM10K_PF_STATS_LEN; i++) {
 				memcpy(p, fm10k_gstrings_pf_stats[i].stat_string,
 				       ETH_GSTRING_LEN);
 				p += ETH_GSTRING_LEN;
 			}
+		}
 
 		for (i = 0; i < interface->hw.mac.max_queues; i++) {
 			sprintf(p, "tx_queue_%u_packets", i);

