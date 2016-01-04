From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:11 -0800
Subject: [Intel-wired-lan] [next PATCH S26 11/12] i40e: avoid large memcpy
	by assigning struct
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-12-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Assign the i40e_pf structure directly instead of using a large memcpy,
which avoids a sparse warning and lets the compiler optimize the copy
since it knows the size of the structure in advance.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Change-ID: I17604e23be2616521eb760290befcb767b52b3f7
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 10744a6..2c0848f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -185,9 +185,11 @@ static ssize_t i40e_dbg_dump_write(struct file *filp,
 		if (i40e_dbg_prep_dump_buf(pf, buflen)) {
 			p = i40e_dbg_dump_buf;
 
-			len = sizeof(struct i40e_pf);
-			memcpy(p, pf, len);
-			p += len;
+			/* avoid use of memcpy here due to sparse warning
+			 * about copy size.
+			 */
+			*((struct i40e_pf *)p) = *pf;
+			p += sizeof(struct i40e_pf);
 
 			len = (sizeof(struct i40e_aq_desc)
 					* pf->hw.aq.num_asq_entries);
-- 
2.1.0

