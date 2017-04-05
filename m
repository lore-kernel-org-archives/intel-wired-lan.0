From: Alice Michael <alice.michael@intel.com>
Date: Wed,  5 Apr 2017 07:50:59 -0400
Subject: [Intel-wired-lan] [next S66 v2 07/11] i40e: remove
	I40E_FLAG_NEED_LINK_UPDATE
In-Reply-To: <20170405115103.67374-1-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
Message-ID: <20170405115103.67374-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The I40E_FLAG_NEED_LINK_UPDATE was never used. Remove the flag
definitions.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: If59d0c6b4af85ca27281f3183c54b055adb439a4
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 drivers/net/ethernet/intel/i40evf/i40evf.h  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 110ef42..ef64dc6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -389,7 +389,6 @@ struct i40e_pf {
 #define I40E_FLAG_MSIX_ENABLED			BIT_ULL(3)
 #define I40E_FLAG_RSS_ENABLED			BIT_ULL(6)
 #define I40E_FLAG_VMDQ_ENABLED			BIT_ULL(7)
-#define I40E_FLAG_NEED_LINK_UPDATE		BIT_ULL(9)
 #define I40E_FLAG_IWARP_ENABLED			BIT_ULL(10)
 #define I40E_FLAG_CLEAN_ADMINQ			BIT_ULL(14)
 #define I40E_FLAG_FILTER_SYNC			BIT_ULL(15)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index da9f0be..87dff1b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11087,7 +11087,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&pf->service_task, i40e_service_task);
 	clear_bit(__I40E_SERVICE_SCHED, &pf->state);
-	pf->flags |= I40E_FLAG_NEED_LINK_UPDATE;
 
 	/* NVM bit on means WoL disabled for the port */
 	i40e_read_nvm_word(hw, I40E_SR_NVM_WAKE_ON_LAN, &wol_nvm_bits);
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index d61ecf6..35ded19 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -205,7 +205,6 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_IN_NETPOLL			BIT(4)
 #define I40EVF_FLAG_IMIR_ENABLED		BIT(5)
 #define I40EVF_FLAG_MQ_CAPABLE			BIT(6)
-#define I40EVF_FLAG_NEED_LINK_UPDATE		BIT(7)
 #define I40EVF_FLAG_PF_COMMS_FAILED		BIT(8)
 #define I40EVF_FLAG_RESET_PENDING		BIT(9)
 #define I40EVF_FLAG_RESET_NEEDED		BIT(10)
-- 
2.9.3

