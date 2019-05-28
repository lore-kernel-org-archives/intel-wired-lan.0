From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 May 2019 10:59:17 -0700
Subject: [Intel-wired-lan] [next PATCH S6 3/7] i40e: fix incorrect function
 documentation comment
In-Reply-To: <20190528175921.30534-1-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
Message-ID: <20190528175921.30534-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 439c35f0c581..11394a52e21c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -140,8 +140,7 @@ static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
  * @ptp: The PTP clock structure
  * @delta: Offset in nanoseconds to adjust the PHC time by
  *
- * Adjust the frequency of the PHC by the indicated parts per billion from the
- * base frequency.
+ * Adjust the current clock time by a delta specified in nanoseconds.
  **/
 static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
-- 
2.19.2

