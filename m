From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  7 Apr 2016 08:21:22 -0700
Subject: [Intel-wired-lan] [PATCH v1 3/4] fm10k: fix fm10k_add_ethtool_stats
	to zero memory
In-Reply-To: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
References: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460042483-16169-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ethtool API does not guarantee zero'd memory, so we need to zero the
stats we skip instead of just skipping them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Notes:
    Testing-hints:
      Ensure that the queue stats don't show random memory values, but always zero
      if they are unused.
    
    Unfortunately, somehow Dave Miller pulled an incorrect version of the original
    for this patch, so this is a follow-on fixup which brings back the bug fix.

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index b4870b8ad0bd..9c0d87503977 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -243,9 +243,10 @@ static void fm10k_add_ethtool_stats(u64 **data, void *pointer,
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
 
-- 
2.8.1.102.ga49ec4a

