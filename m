From: Jason Yan <yanaijie@huawei.com>
Date: Tue, 5 May 2020 15:43:37 +0800
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Use true,
 false for bool variable in __ixgbe_enable_sriov()
Message-ID: <20200505074337.21477-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the following coccicheck warning:

drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:105:2-38: WARNING:
Assignment of 0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 537dfff585e0..d05a5690e66b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -102,7 +102,7 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
 		 * indirection table and RSS hash key with PF therefore
 		 * we want to disable the querying by default.
 		 */
-		adapter->vfinfo[i].rss_query_enabled = 0;
+		adapter->vfinfo[i].rss_query_enabled = false;
 
 		/* Untrust all VFs */
 		adapter->vfinfo[i].trusted = false;
-- 
2.21.1

