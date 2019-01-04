From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  3 Jan 2019 16:49:02 -0800
Subject: [Intel-wired-lan] [net-next 1/1] fm10k: TRIVIAL cleanup of extra
 spacing in function comment
Message-ID: <20190104004902.7632-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function comment for fm10k_iov_msg_msix_pf has an extra space in
a sentence, which is unnecessary.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 8f0a99b6a537..cb4d02629b86 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1148,7 +1148,7 @@ static void fm10k_iov_update_stats_pf(struct fm10k_hw *hw,
  *  @results: Pointer array to message, results[0] is pointer to message
  *  @mbx: Pointer to mailbox information structure
  *
- *  This function is a default handler for MSI-X requests from the VF.  The
+ *  This function is a default handler for MSI-X requests from the VF. The
  *  assumption is that in this case it is acceptable to just directly
  *  hand off the message from the VF to the underlying shared code.
  **/
-- 
2.18.0.219.gaf81d287a9da

