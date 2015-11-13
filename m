From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri, 13 Nov 2015 15:47:06 -0800
Subject: [Intel-wired-lan] [next PATCH S22 06/14] i40evf: check rings before
	freeing resources
In-Reply-To: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
References: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1447458434-4555-7-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If the driver gets unloaded during reset recovery, it's possible
that it will attempt to free resources when they're already free.

Add a check to make sure that the tx and rx rings actually exist
before dereferencing them to free resources.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I4d2b7e9ede49f634d421a4c5deaa5446bc755eee
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index fb170b3..451c5f0 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2034,6 +2034,9 @@ void i40evf_free_all_tx_resources(struct i40evf_adapter *adapter)
 {
 	int i;
 
+	if (!adapter->tx_rings)
+		return;
+
 	for (i = 0; i < adapter->num_active_queues; i++)
 		if (adapter->tx_rings[i].desc)
 			i40evf_free_tx_resources(&adapter->tx_rings[i]);
@@ -2102,6 +2105,9 @@ void i40evf_free_all_rx_resources(struct i40evf_adapter *adapter)
 {
 	int i;
 
+	if (!adapter->rx_rings)
+		return;
+
 	for (i = 0; i < adapter->num_active_queues; i++)
 		if (adapter->rx_rings[i].desc)
 			i40evf_free_rx_resources(&adapter->rx_rings[i]);
-- 
2.1.0

