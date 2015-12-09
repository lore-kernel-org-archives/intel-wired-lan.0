From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed,  9 Dec 2015 15:50:30 -0800
Subject: [Intel-wired-lan] [next PATCH S23 10/13] i40evf: null out ring
	pointers on free
In-Reply-To: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1449705033-4968-11-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Since we check these ring pointers to make sure we don't double-allocate
or double-free the rings, we had better null them out after we free
them. In very rare cases this can cause a panic if the driver is removed
during reset recovery.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ib06eb4910a3058275c8f7ec5ef7f45baa4674f96
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index d859045..c7f98e7 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1122,7 +1122,9 @@ static void i40evf_free_queues(struct i40evf_adapter *adapter)
 	if (!adapter->vsi_res)
 		return;
 	kfree(adapter->tx_rings);
+	adapter->tx_rings = NULL;
 	kfree(adapter->rx_rings);
+	adapter->rx_rings = NULL;
 }
 
 /**
-- 
2.1.0

