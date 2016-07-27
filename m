From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 27 Jul 2016 12:02:33 -0700
Subject: [Intel-wired-lan] [next PATCH S40-V2 04/12] i40evf: add missing
	rtnl_lock() around i40evf_set_interrupt_capability
In-Reply-To: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469646161-30024-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The function calls netif_set_real_num_(tx|rx)_queues, both of which
should be done only under rntl lock. Unfortunately the
i40evf_init_task did not hold the rtnl_lock as necessary. This patch
adds the locking needed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Ib72a21c3ce22b71a226b16f9bbe0f5f8cc3e849b
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 600fb9c..d1d4a65 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1420,7 +1420,9 @@ int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter)
 {
 	int err;
 
+	rtnl_lock();
 	err = i40evf_set_interrupt_capability(adapter);
+	rtnl_unlock();
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"Unable to setup interrupt capabilities\n");
-- 
2.4.11

