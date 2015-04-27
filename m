From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:20 -0400
Subject: [Intel-wired-lan] [net-next S5 13/15] i40e: Refine an error message
	to avoid confusion
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-14-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Change a warning message to indicate what may have really happened when
the init_shared_code call fails.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I616ace40fed120d0dec86dfc91ab2d7cde466904
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1b73979..10b495f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9749,7 +9749,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = i40e_init_shared_code(hw);
 	if (err) {
-		dev_info(&pdev->dev, "init_shared_code failed: %d\n", err);
+		dev_warn(&pdev->dev, "unidentified MAC or BLANK NVM: %d\n",
+			 err);
 		goto err_pf_reset;
 	}
 
-- 
1.9.3

