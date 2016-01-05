From: Chas Williams <3chas3@gmail.com>
Date: Tue,  5 Jan 2016 17:30:39 -0500
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Extend trust to allow
	guest to set unicast address
Message-ID: <1452033039-18970-1-git-send-email-3chas3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When running certain routing protocols like VRRP, VF guests need the
ability to set the unicast address of the interface.  Extend the new ndo
trust feature to let the hypervisor trust a guest to set/update its own
unicast address.

Signed-off-by: Chas Williams <3chas3@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index eeff3d0..63cff17 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -887,7 +887,7 @@ static int ixgbe_set_vf_mac_addr(struct ixgbe_adapter *adapter,
 		return -1;
 	}
 
-	if (adapter->vfinfo[vf].pf_set_mac &&
+	if (adapter->vfinfo[vf].pf_set_mac && !adapter->vfinfo[vf].trusted &&
 	    !ether_addr_equal(adapter->vfinfo[vf].vf_mac_addresses, new_mac)) {
 		e_warn(drv,
 		       "VF %d attempted to override administratively set MAC address\n"
-- 
2.5.0

