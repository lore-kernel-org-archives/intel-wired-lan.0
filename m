From: Ken Cox <jkc@redhat.com>
Date: Tue, 15 Nov 2016 13:00:37 -0600
Subject: [Intel-wired-lan] [1/1] ixgbe: test for trust in macvlan
	adjustments for vf
Message-ID: <882304dc5b8489b3293148ebec7c26b328bd4d88.1479236297.git.jkc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There are two methods for setting mac addresses in a Macvlan, that
differentiate themselves in the function macvlan_set_mac_Address.
If the macvlan mode is passthru, then we use the dev_set_mac_address
method, otherwise we use the dev_uc api via macvlan_sync_addresses.
The latter method (which would stem from using any non-passthru mode,
like bridge, or vepa), calls down into the driver in a path that terminates
in ixgbevf_set_uc_addr_vf, which sends a IXGBE_VF_SET_MACVLAN message,
which causes the pf to spawn the noted error message.  This occurs because
it appears that the guest is trying to delete the mac address of the macvlan
before adding another.

The other path in macvlan_set_mac_address uses dev_set_mac_address, which
calls into ixgbevf_set_mac which uses the IXGBE_VF_SET_MAC_ADDR to the
pf to set the macvlan mac address.

The discrepancy here is in the handlers.  The handler function for
IXGBE_VF_SET_MAC_ADDR (ixgbe_set_vf_mac_addr) has a check for
the vfinfo[].trusted bit to allow the operation if the vf is trusted.
In comparison, the IXGBE_VF_SET_MACVLAN message handler
(ixgbe_set_vf_macvlan_msg) has no such check of the trusted bit.

Signed-off-by: Ken Cox <jkc@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 42138be..9021c06 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -934,7 +934,8 @@ static int ixgbe_set_vf_macvlan_msg(struct ixgbe_adapter *adapter,
 		    IXGBE_VT_MSGINFO_SHIFT;
 	int err;
 
-	if (adapter->vfinfo[vf].pf_set_mac && index > 0) {
+	if (adapter->vfinfo[vf].pf_set_mac && !adapter->vfinfo[vf].trusted &&
+	    index > 0) {
 		e_warn(drv,
 		       "VF %d requested MACVLAN filter but is administratively denied\n",
 		       vf);
-- 
2.5.5

