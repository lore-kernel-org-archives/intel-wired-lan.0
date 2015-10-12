From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 12 Oct 2015 10:56:00 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: fix spoofed packets with
	random MAC
In-Reply-To: <20151012175551.13894.37989.stgit@localhost6.localdomain6>
References: <20151012175551.13894.37989.stgit@localhost6.localdomain6>
Message-ID: <20151012175600.13894.26059.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If ixgbevf is loaded while the corresponding PF interface is down
and the driver assigns a random MAC address, that address can be
overwritten with the value of hw->mac.perm_addr, which would be 0 at
that point.

To avoid this case we init hw->mac.perm_addr to the randomly generated
address and do not set it unless we receive ACK from ixgbe.

Reported-by: John Greene <jogreene@redhat.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    1 +
 drivers/net/ethernet/intel/ixgbevf/vf.c           |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 03ee46b..e2d07da 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2667,6 +2667,7 @@ static int ixgbevf_sw_init(struct ixgbevf_adapter *adapter)
 		dev_info(&pdev->dev, "Assigning random MAC address\n");
 		eth_hw_addr_random(netdev);
 		ether_addr_copy(hw->mac.addr, netdev->dev_addr);
+		ether_addr_copy(hw->mac.perm_addr, netdev->dev_addr);
 	}
 
 	/* Enable dynamic interrupt throttling rates */
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 427f360..61a98f4 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -117,7 +117,9 @@ static s32 ixgbevf_reset_hw_vf(struct ixgbe_hw *hw)
 	    msgbuf[0] != (IXGBE_VF_RESET | IXGBE_VT_MSGTYPE_NACK))
 		return IXGBE_ERR_INVALID_MAC_ADDR;
 
-	ether_addr_copy(hw->mac.perm_addr, addr);
+	if (msgbuf[0] == (IXGBE_VF_RESET | IXGBE_VT_MSGTYPE_ACK))
+		ether_addr_copy(hw->mac.perm_addr, addr);
+
 	hw->mac.mc_filter_type = msgbuf[IXGBE_VF_MC_TYPE_WORD];
 
 	return 0;

