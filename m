From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:55 -0400
Subject: [Intel-wired-lan] [next PATCH S17 06/11] i40e: Fix for Tools
	loopback test failing after driver load
In-Reply-To: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443464220-148318-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes a problem where our Tools MAC Loopback test, after
driver unbind would fail.  This was because the hw was configured
for multiqueue and unbind operation did not clear this configuration.
The problem is fixed by resetting this configuration in i40e_remove.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I130c05138319182ed1476d3a0b5222d6a6320af9
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2ecc6df..bc48be4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10642,6 +10642,7 @@ err_dma:
 static void i40e_remove(struct pci_dev *pdev)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
+	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret_code;
 	int i;
 
@@ -10649,6 +10650,10 @@ static void i40e_remove(struct pci_dev *pdev)
 
 	i40e_ptp_stop(pf);
 
+	/* Disable RSS in hw */
+	wr32(hw, I40E_PFQF_HENA(0), 0);
+	wr32(hw, I40E_PFQF_HENA(1), 0);
+
 	/* no more scheduling of any task */
 	set_bit(__I40E_DOWN, &pf->state);
 	del_timer_sync(&pf->service_timer);
-- 
1.9.3

