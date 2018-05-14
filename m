From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 14 May 2018 11:16:16 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: fix MAC address changes
 through ixgbevf_set_mac()
In-Reply-To: <20180514181449.26797.30080.stgit@localhost6.localdomain6>
References: <20180514181449.26797.30080.stgit@localhost6.localdomain6>
Message-ID: <20180514181616.26797.73490.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set hw->mac.perm_addr in ixgbevf_set_mac() in order to avoid losing the
custom MAC on reset. This can happen in the following case:

>ip link set $vf address $mac
>ethtool -r $vf

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 9a939dc..0830411 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4164,6 +4164,7 @@ static int ixgbevf_set_mac(struct net_device *netdev, void *p)
 		return -EPERM;
 
 	ether_addr_copy(hw->mac.addr, addr->sa_data);
+	ether_addr_copy(hw->mac.perm_addr, addr->sa_data);
 	ether_addr_copy(netdev->dev_addr, addr->sa_data);
 
 	return 0;

