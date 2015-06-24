From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 24 Jun 2015 13:34:42 -0700
Subject: [Intel-wired-lan] [PATCH net-next rc1 02/10] fm10k: allow creation
	of vlan interfaces even while down
In-Reply-To: <1435178090-25422-1-git-send-email-jacob.e.keller@intel.com>
References: <1435178090-25422-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1435178090-25422-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We re-sync upon going up, so there is little reason to worry about not
syncing immediately with switch. This prevents an error that occurs if
you add a vlan interface while down.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index b2065cb44edc..e1ceb3a2e2cd 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -779,6 +779,12 @@ static int fm10k_update_vid(struct net_device *netdev, u16 vid, bool set)
 	if (!set && vid == hw->mac.default_vid)
 		return 0;
 
+	/* Do not throw an error if the interface is down. We will sync once
+	 * we come up
+	 */
+	if (test_bit(__FM10K_DOWN, &interface->state))
+		return 0;
+
 	fm10k_mbx_lock(interface);
 
 	/* only need to update the VLAN if not in promiscuous mode */
-- 
2.4.3

