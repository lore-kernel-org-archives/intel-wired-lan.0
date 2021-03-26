From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 25 Mar 2021 17:38:33 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 10/11] ixgbe: use checker safe
 conversions
In-Reply-To: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
Message-ID: <20210326003834.3886241-11-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ixgbe hardware needs some very specific programming for
certain registers, which led to some misguided usage of ntohs
instead of using be16_to_cpu(), as well as a home grown swap
followed by an ntohs. Sparse didn't like this at all, and this
fixes the C=2 build, with code that uses native kernel interface.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Warning Details:
.../ixgbe/ixgbe_82599.c:1660:20: warning: cast to restricted __be16
.../ixgbe/ixgbe_82599.c:1660:20: warning: cast to restricted __be16
.../ixgbe/ixgbe_82599.c:1660:20: warning: cast to restricted __be16
.../ixgbe/ixgbe_82599.c:1660:20: warning: cast to restricted __be16
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index e324e42fab2d..58ea959a4482 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -1514,8 +1514,7 @@ static u32 ixgbe_get_fdirtcpm_82599(union ixgbe_atr_input *input_mask)
 #define IXGBE_WRITE_REG_BE32(a, reg, value) \
 	IXGBE_WRITE_REG((a), (reg), IXGBE_STORE_AS_BE32(ntohl(value)))
 
-#define IXGBE_STORE_AS_BE16(_value) \
-	ntohs(((u16)(_value) >> 8) | ((u16)(_value) << 8))
+#define IXGBE_STORE_AS_BE16(_value) __swab16(ntohs((_value)))
 
 s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 				    union ixgbe_atr_input *input_mask)
@@ -1651,13 +1650,13 @@ s32 ixgbe_fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 	IXGBE_WRITE_REG_BE32(hw, IXGBE_FDIRIPDA, input->formatted.dst_ip[0]);
 
 	/* record source and destination port (little-endian)*/
-	fdirport = ntohs(input->formatted.dst_port);
+	fdirport = be16_to_cpu(input->formatted.dst_port);
 	fdirport <<= IXGBE_FDIRPORT_DESTINATION_SHIFT;
-	fdirport |= ntohs(input->formatted.src_port);
+	fdirport |= be16_to_cpu(input->formatted.src_port);
 	IXGBE_WRITE_REG(hw, IXGBE_FDIRPORT, fdirport);
 
 	/* record vlan (little-endian) and flex_bytes(big-endian) */
-	fdirvlan = IXGBE_STORE_AS_BE16((__force u16)input->formatted.flex_bytes);
+	fdirvlan = IXGBE_STORE_AS_BE16(input->formatted.flex_bytes);
 	fdirvlan <<= IXGBE_FDIRVLAN_FLEX_SHIFT;
 	fdirvlan |= ntohs(input->formatted.vlan_id);
 	IXGBE_WRITE_REG(hw, IXGBE_FDIRVLAN, fdirvlan);
-- 
2.30.2

