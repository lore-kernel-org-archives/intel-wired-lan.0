From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 08:22:11 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 10/13] i40e: Fix kdump failure
Message-ID: <20171227132211.24019-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

kdump fails in the system when used in conjunction with Ethernet driver
X722/X710. This is mainly because when we are resource constrained i.e.
when we have just one online_cpus, we are enabling VMDq and iWARP. It
doesn't make sense to enable them with just one cpu and starve kdump
for lack of IRQs.

So don't enable VMDq or iWARP when we just have a single cpu.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3c3cdcd..4493652 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11115,13 +11115,13 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	    pf->hw.aq.fw_maj_ver >= 6)
 		pf->hw_features |= I40E_HW_PTP_L4_CAPABLE;
 
-	if (pf->hw.func_caps.vmdq) {
+	if (pf->hw.func_caps.vmdq && num_online_cpus() != 1) {
 		pf->num_vmdq_vsis = I40E_DEFAULT_NUM_VMDQ_VSI;
 		pf->flags |= I40E_FLAG_VMDQ_ENABLED;
 		pf->num_vmdq_qps = i40e_default_queues_per_vmdq(pf);
 	}
 
-	if (pf->hw.func_caps.iwarp) {
+	if (pf->hw.func_caps.iwarp && num_online_cpus() != 1) {
 		pf->flags |= I40E_FLAG_IWARP_ENABLED;
 		/* IWARP needs one extra vector for CQP just like MISC.*/
 		pf->num_iwarp_msix = (int)num_online_cpus() + 1;
-- 
2.9.5

