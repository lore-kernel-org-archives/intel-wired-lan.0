From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  4 Mar 2016 15:37:46 -0800
Subject: [Intel-wired-lan] [PATCH v6 0/2] fix ethtool statistics patches
Message-ID: <1457134668-19142-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series fixes the ethtool patches on Jeff's next-queue. First, I
fixed a bug in the fm10k ethtool stat helpers which had assumed the
allocated memory was already zeroed. The new code assumes it is not, and
always rights 0s. In addition, I fixed Bruce's comment about the
newline. Since I had to change the first patch, I rebased them both
against the top of Jeff's queue and merged some of the code. The first
patch in this series now handles the per-queue stats, while the second
patch does the work to remove the incorrect support for
debug-statistics.

The first patch is a direct replacement for 1256b40cb7b4 ("fm10k: add
helper functions to set strings and data for ethtool stats", 2016-03-04)

The second patch is a direct replacement for 2d6c14d75442 ("fm10k:
cleanup fm10k stats and remove debug-statistics", 2016-03-04)

The interdiff between the previous version of these patches and the
current version of the patches (to help with review) is:

diff --git c/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c w/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 3941b80ab2d2..a41a35082ddb 100644
--- c/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ w/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -130,7 +130,6 @@ static const struct fm10k_stats fm10k_gstrings_queue_stats[] = {
 				FM10K_NETDEV_STATS_LEN + \
 				FM10K_MBX_STATS_LEN)
 
-
 static const char fm10k_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Mailbox test (on/offline)"
 };
@@ -246,9 +245,10 @@ static void fm10k_add_ethtool_stats(u64 **data, void *pointer,
 	unsigned int i;
 	char *p;
 
-	/* simply skip forward if we were not given a valid pointer */
 	if (!pointer) {
-		*data += size;
+		/* memory is not zero allocated so we have to clear it */
+		for (i = 0; i < size; i++)
+			*((*data)++) = 0;
 		return;
 	}
 
Jacob Keller (2):
  fm10k: add helper functions to set strings and data for ethtool stats
  fm10k: remove remove debug-statistics support

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 259 +++++++++--------------
 1 file changed, 100 insertions(+), 159 deletions(-)

-- 
2.7.1.429.g45cd78e

