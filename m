From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 22 Dec 2015 17:09:57 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix write to VLVFB in
	ixgbe_clear_vf_vlans()
Message-ID: <20151223010957.27315.28321.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the write to the VLVFB register in ixgbe_clear_vf_vlans() where
word is the actual offset of the register and not the index for the
IXGBE_VLVFB macro.

This was causing PCI AER errors on my system.

Fixes: 4c7f35f679f592804736f9303051257de2c9f021
("ixgbe: Clean stale VLANs when changing port VLAN or resetting")

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index eeff3d0..fd918da 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -640,7 +640,7 @@ update_vlvf:
 		IXGBE_WRITE_REG(hw, IXGBE_VLVF(i), 0);
 update_vlvfb:
 		/* clear pool bits */
-		IXGBE_WRITE_REG(hw, IXGBE_VLVFB(word), vlvfb);
+		IXGBE_WRITE_REG(hw, word, vlvfb);
 	}
 }
 

