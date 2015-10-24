From: Nicholas Krause <xerofoify@gmail.com>
Date: Sat, 24 Oct 2015 16:29:30 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe:Refactor ixgbe_set_vf_mac to
	include proper error path and return statement
Message-ID: <1445718570-30162-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes the function ixgbe_set_vf_mac to include the proper
path when the call to the function ixgbe_del_mac_filter fails
and we must exit immediately by returning the error code returned
by this particular function call. Further more return
ixgbe_add_mac_filter directly in order to allow callers to be signaled
also when the call to this particular function fails in
ixgbe_set_vf_mac.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 1d17b58..711b451 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -552,11 +552,13 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter,
 			    int vf, unsigned char *mac_addr)
 {
-	ixgbe_del_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
-	memcpy(adapter->vfinfo[vf].vf_mac_addresses, mac_addr, ETH_ALEN);
-	ixgbe_add_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
+	int err;
 
-	return 0;
+	err = ixgbe_del_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
+	if (err)
+		return err;
+	memcpy(adapter->vfinfo[vf].vf_mac_addresses, mac_addr, ETH_ALEN);
+	return ixgbe_add_mac_filter(adapter, adapter->vfinfo[vf].vf_mac_addresses, vf);
 }
 
 static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
-- 
2.1.4

