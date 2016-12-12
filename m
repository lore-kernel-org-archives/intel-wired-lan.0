From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:11 -0800
Subject: [Intel-wired-lan] [next PATCH S57 05/11] i40evf: add comment
In-Reply-To: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1481586257-28872-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Add a comment to reduce confusion.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I3d5819c0f3f5174680442ae54398a073d4a61f4f
---
Testing Hints : No code change, just a comment

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 5673dbd..f35dcaa 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2153,6 +2153,11 @@ static int i40evf_close(struct net_device *netdev)
 	adapter->state = __I40EVF_DOWN_PENDING;
 	i40evf_free_traffic_irqs(adapter);
 
+	/* We explicitly don't free resources here because the hardware is
+	 * still active and can DMA into memory. Resources are cleared in
+	 * i40evf_virtchnl_completion() after we get confirmation from the PF
+	 * driver that the rings have been stopped.
+	 */
 	return 0;
 }
 
-- 
2.4.11

