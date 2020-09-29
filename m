From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 29 Sep 2020 14:01:56 -0500
Subject: [Intel-wired-lan] [PATCH][next] ice: Replace one-element array with
 flexible-array member
Message-ID: <20200929190156.GA25604@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use ?flexible array members?[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in
struct ice_res_tracker, instead of a one-element array and use the
struct_size() helper to calculate the size for the allocations.

Also, notice that the code below suggests that, currently, two too many
bytes are being allocated with devm_kzalloc(), as the total number of
entries (pf->irq_tracker->num_entries) for pf->irq_tracker->list[] is
_vectors_ and sizeof(*pf->irq_tracker) also includes the size of the
one-element array _list_ in struct ice_res_tracker.

drivers/net/ethernet/intel/ice/ice_main.c:3511:
3511         /* populate SW interrupts pool with number of OS granted IRQs. */
3512         pf->num_avail_sw_msix = (u16)vectors;
3513         pf->irq_tracker->num_entries = (u16)vectors;
3514         pf->irq_tracker->end = pf->irq_tracker->num_entries;

With this change, the right amount of dynamic memory is now allocated
because, contrary to one-element arrays which occupy at least as much
space as a single object of the type, flexible-array members don't
occupy such space in the containing structure.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Built-tested-by: kernel test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice.h      | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 65583f0a1797..a4c84faa36d6 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -164,7 +164,7 @@ struct ice_tc_cfg {
 struct ice_res_tracker {
 	u16 num_entries;
 	u16 end;
-	u16 list[1];
+	u16 list[];
 };
 
 struct ice_qs_cfg {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2297ee7dba26..f6a7a23615eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3500,9 +3500,9 @@ static int ice_init_interrupt_scheme(struct ice_pf *pf)
 		return vectors;
 
 	/* set up vector assignment tracking */
-	pf->irq_tracker =
-		devm_kzalloc(ice_pf_to_dev(pf), sizeof(*pf->irq_tracker) +
-			     (sizeof(u16) * vectors), GFP_KERNEL);
+	pf->irq_tracker = devm_kzalloc(ice_pf_to_dev(pf),
+				       struct_size(pf->irq_tracker, list, vectors),
+				       GFP_KERNEL);
 	if (!pf->irq_tracker) {
 		ice_dis_msix(pf);
 		return -ENOMEM;
-- 
2.27.0

