From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:26:01 -0800
Subject: [Intel-wired-lan] [next PATCH S21 03/14] i40evf: remove duplicate
	string
In-Reply-To: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446852372-25480-4-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

We already print the driver info string in probe, so don't print
it again in init. No need to repeat. No need to repeat.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ief597997f580a8c54d5950e3a84c29f2075be66b
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 33a08f8..9f845fe 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2512,7 +2512,6 @@ static void i40evf_init_task(struct work_struct *work)
 	if (netdev->features & NETIF_F_GRO)
 		dev_info(&pdev->dev, "GRO is enabled\n");
 
-	dev_info(&pdev->dev, "%s\n", i40evf_driver_string);
 	adapter->state = __I40EVF_DOWN;
 	set_bit(__I40E_DOWN, &adapter->vsi.state);
 	i40evf_misc_irq_enable(adapter);
-- 
2.1.0

