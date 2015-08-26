From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:08 -0400
Subject: [Intel-wired-lan] [next PATCH S11 02/15] i40e: enable WoL operation
	if config bit show WoL capable
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

The driver was disabling Wake-on-LAN by default and waiting for the user
to expressly turn it on.  This patch has the driver turning on WoL from
the start if enabled in the hardware config, which matches the behavior
of our other drivers.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I43faedb907f8ba4d1a61b72a7c86072b97af12b1
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7b41e1a..28ab759 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9876,6 +9876,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	static u16 pfs_found;
+	u16 wol_nvm_bits;
 	u16 link_status;
 	int err = 0;
 	u32 len;
@@ -10093,8 +10094,12 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pf->flags |= I40E_FLAG_NEED_LINK_UPDATE;
 	pf->link_check_timeout = jiffies;
 
-	/* WoL defaults to disabled */
-	pf->wol_en = false;
+	/* NVM bit on means WoL disabled for the port */
+	i40e_read_nvm_word(hw, I40E_SR_NVM_WAKE_ON_LAN, &wol_nvm_bits);
+	if ((1 << hw->port) & wol_nvm_bits || hw->partition_id != 1)
+		pf->wol_en = false;
+	else
+		pf->wol_en = true;
 	device_set_wakeup_enable(&pf->pdev->dev, pf->wol_en);
 
 	/* set up the main switch operations */
-- 
1.9.3

