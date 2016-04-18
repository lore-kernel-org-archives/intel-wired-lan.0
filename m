From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 18 Apr 2016 15:39:46 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: fix incorrect index calculation in
	fm10k_write_reta
Message-ID: <20160418223946.30068-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The index calculated when looping through the indir array passed to
fm10k_write_reta was incorrectly calculated as the first part i needs to
be multiplied by 4.

Fixes: 0cfea7a65738 ("fm10k: fix possible null pointer deref after kcalloc", 2016-04-13)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Notes:
    Jeff, this needs to be squashed into "[v1,1/4] fm10k: fix possible null pointer
    deref after kcalloc", and I am sending it this way since you requested I work
    only at the top if the queue for now. I can resend that original
    patch as a v2 if you prefer.

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 9c0d87503977..5c8788427b73 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -983,9 +983,9 @@ void fm10k_write_reta(struct fm10k_intfc *interface, const u32 *indir)
 		/* generate a new table if we weren't given one */
 		for (j = 0; j < 4; j++) {
 			if (indir)
-				n = indir[i + j];
+				n = indir[4 * i + j];
 			else
-				n = ethtool_rxfh_indir_default(i + j, rss_i);
+				n = ethtool_rxfh_indir_default(4 * i + j, rss_i);
 
 			table[j] = n;
 		}
-- 
2.8.1.371.g31c5d55

