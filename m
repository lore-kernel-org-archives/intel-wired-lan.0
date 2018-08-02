From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:36 -0700
Subject: [Intel-wired-lan] [next PATCH S94 13/13] i40e: set vsi->netdev to
 NULL after free_netdev()
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-13-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

After adding a special case for recovery mode in i40e_remove
we have forgotten to set vsi->netdev to NULL after calling free_netdev()
on it. This patch fixes that.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e46f8ab..4300483 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14337,6 +14337,7 @@ static void i40e_remove(struct pci_dev *pdev)
 		 */
 		unregister_netdev(vsi->netdev);
 		free_netdev(vsi->netdev);
+		vsi->netdev = NULL;
 
 		goto unmap;
 	}
-- 
2.9.5

