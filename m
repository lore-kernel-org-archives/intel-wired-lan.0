From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 11:36:18 -0800
Subject: [Intel-wired-lan] [next PATCH S2 09/13] i40e: [NVMUpdate] kernel
 crash after unloading i40e driver
In-Reply-To: <20190206193622.69370-1-alice.michael@intel.com>
References: <20190206193622.69370-1-alice.michael@intel.com>
Message-ID: <20190206193622.69370-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Marczak <piotr.marczak@intel.com>

After NVMUpdate driver is in Recovery Mode and performing reset but
i40e_client is still up. If there is an activity on port which already
is down and its dereference is NULL, client would still dispatch
processing to this PF causing hard kernel crash. This fix prevents
such a situation.

Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c4eb212d794b..8e51a77ac5f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14983,7 +14983,6 @@ static void i40e_remove(struct pci_dev *pdev)
 	 * has been stopped.
 	 */
 	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
-
 	if (pf->flags & I40E_FLAG_SRIOV_ENABLED) {
 		i40e_free_vfs(pf);
 		pf->flags &= ~I40E_FLAG_SRIOV_ENABLED;
-- 
2.19.2

