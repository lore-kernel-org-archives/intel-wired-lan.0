From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 02 Nov 2015 17:09:35 -0800
Subject: [Intel-wired-lan] [next PATCH 02/11] ixgbe: Fix SR-IOV VLAN pool
	configuration
In-Reply-To: <20151103005850.28233.63113.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
Message-ID: <20151103010935.28233.72294.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The code for checking the PF bit in ixgbe_set_vf_vlan_msg was using the
wrong offset and as a result it was pulling the VLAN off of the PF even if
there were VFs numbered greater than 40 that still had the VLAN enabled.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 31de6cf7adb0..61a054ace56d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -887,10 +887,10 @@ static int ixgbe_set_vf_vlan_msg(struct ixgbe_adapter *adapter,
 			bits = IXGBE_READ_REG(hw, IXGBE_VLVFB(reg_ndx * 2));
 			bits &= ~(1 << VMDQ_P(0));
 			bits |= IXGBE_READ_REG(hw,
-					       IXGBE_VLVFB(reg_ndx * 2) + 1);
+					       IXGBE_VLVFB(reg_ndx * 2 + 1));
 		} else {
 			bits = IXGBE_READ_REG(hw,
-					      IXGBE_VLVFB(reg_ndx * 2) + 1);
+					      IXGBE_VLVFB(reg_ndx * 2 + 1));
 			bits &= ~(1 << (VMDQ_P(0) - 32));
 			bits |= IXGBE_READ_REG(hw, IXGBE_VLVFB(reg_ndx * 2));
 		}

