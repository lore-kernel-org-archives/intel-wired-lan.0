From: Michal Maloszewski <michal.maloszewski@intel.com>
Date: Tue, 15 Feb 2022 13:35:51 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix interface init with MSI
 interrupts (no MSI-X)
Message-ID: <20220215133551.330076-1-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the inability to bring an interface up on a setup with
only MSI interrupts enabled (no MSI-X).
Solution is to add a default number of QPs = 1. This is enough,
since without MSI-X support driver enables only a basic feature set.

Fixes: bc6d33c8d93f ("i40e: Fix the number of queues available to be mapped for use")
Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8572993972ef..dfaa56235b60 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1840,6 +1840,9 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 			vsi->num_queue_pairs = vsi->req_queue_pairs;
 		else if (pf->flags & I40E_FLAG_MSIX_ENABLED)
 			vsi->num_queue_pairs = pf->num_lan_msix;
+		else
+			/* We need at least one queue pair for the interface to be usable */
+			vsi->num_queue_pairs = 1;
 	}
 
 	/* Number of queues per enabled TC */
-- 
2.27.0

