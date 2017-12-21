From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 21 Dec 2017 10:21:23 -0800
Subject: [Intel-wired-lan] [PATCH next-queue] ixgbe: no ipsec offload for
 82598
Message-ID: <1513880483-18733-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Don't try to set up ipsec offload on the oldest part of
the ixgbe family.

Suggested-by: Yanjun Zhu <yanjun.zhu@oracle.com>
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 424dbf7..12c7132 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -863,6 +863,9 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
 	struct ixgbe_ipsec *ipsec;
 	size_t size;
 
+	if (adapter->hw.mac.type == ixgbe_mac_82598EB)
+		return;
+
 	ipsec = kzalloc(sizeof(*ipsec), GFP_KERNEL);
 	if (!ipsec)
 		goto err1;
-- 
2.7.4

