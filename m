From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Wed, 23 Sep 2020 14:11:25 -0400
Subject: [Intel-wired-lan] [PATCH v2 3/4] i40e: limit msix vectors based on
 housekeeping CPUs
In-Reply-To: <20200923181126.223766-1-nitesh@redhat.com>
References: <20200923181126.223766-1-nitesh@redhat.com>
Message-ID: <20200923181126.223766-4-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In a realtime environment, it is essential to isolate unwanted IRQs from
isolated CPUs to prevent latency overheads. Creating MSIX vectors only
based on the online CPUs could lead to a potential issue on an RT setup
that has several isolated CPUs but a very few housekeeping CPUs. This is
because in these kinds of setups an attempt to move the IRQs to the limited
housekeeping CPUs from isolated CPUs might fail due to the per CPU vector
limit. This could eventually result in latency spikes because of the IRQs
that we fail to move from isolated CPUs.

This patch prevents i40e to create vectors only based on online CPUs by
using hk_num_online_cpus() instead.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2e433fdbf2c3..fcb6fa3707e0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5,6 +5,7 @@
 #include <linux/of_net.h>
 #include <linux/pci.h>
 #include <linux/bpf.h>
+#include <linux/sched/isolation.h>
 #include <generated/utsrelease.h>
 
 /* Local includes */
@@ -11002,7 +11003,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 	 * will use any remaining vectors to reach as close as we can to the
 	 * number of online CPUs.
 	 */
-	cpus = num_online_cpus();
+	cpus = hk_num_online_cpus();
 	pf->num_lan_msix = min_t(int, cpus, vectors_left / 2);
 	vectors_left -= pf->num_lan_msix;
 
-- 
2.18.2

