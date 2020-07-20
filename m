From: linmiaohe <linmiaohe@huawei.com>
Date: Mon, 20 Jul 2020 16:27:41 +0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: use eth_zero_addr() to clear mac
 address
Message-ID: <1595233661-13699-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Miaohe Lin <linmiaohe@huawei.com>

Use eth_zero_addr() to clear mac address insetad of memset().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index d05a5690e66b..6e9097a0a36f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -783,7 +783,7 @@ static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter,
 		memcpy(adapter->vfinfo[vf].vf_mac_addresses, mac_addr,
 		       ETH_ALEN);
 	else
-		memset(adapter->vfinfo[vf].vf_mac_addresses, 0, ETH_ALEN);
+		eth_zero_addr(adapter->vfinfo[vf].vf_mac_addresses);
 
 	return retval;
 }
-- 
2.19.1

