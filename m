From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 14 May 2018 11:16:11 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: force VF to grab new MAC on
 driver reload
In-Reply-To: <20180514181449.26797.30080.stgit@localhost6.localdomain6>
References: <20180514181449.26797.30080.stgit@localhost6.localdomain6>
Message-ID: <20180514181611.26797.30030.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Do not validate the MAC address during a reset, unless the MAC was set on
the host. This way the VF will get a new MAC address every time it reloads.

Remove the "no MAC address assigned" message since it will get spammed on
reset and it doesn't help much as the MAC on the VF is randomly generated.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 2649c06..6f59933 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -854,14 +854,11 @@ static int ixgbe_vf_reset_msg(struct ixgbe_adapter *adapter, u32 vf)
 
 	/* reply to reset with ack and vf mac address */
 	msgbuf[0] = IXGBE_VF_RESET;
-	if (!is_zero_ether_addr(vf_mac)) {
+	if (!is_zero_ether_addr(vf_mac) && adapter->vfinfo[vf].pf_set_mac) {
 		msgbuf[0] |= IXGBE_VT_MSGTYPE_ACK;
 		memcpy(addr, vf_mac, ETH_ALEN);
 	} else {
 		msgbuf[0] |= IXGBE_VT_MSGTYPE_NACK;
-		dev_warn(&adapter->pdev->dev,
-			 "VF %d has no MAC address assigned, you may have to assign one manually\n",
-			 vf);
 	}
 
 	/*

