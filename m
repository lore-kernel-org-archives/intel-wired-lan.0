From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 09 Sep 2015 13:37:33 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Check for setup_internal_link
	method
Message-ID: <20150909203733.12141.60303.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Only call the internal_setup_link method when it is provided. This
check is required for newer version parts.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index add6e96b93ea..d3e3e50acf11 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1572,7 +1572,7 @@ static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 	if (status)
 		return status;
 
-	if (lsc)
+	if (lsc && phy->ops.setup_internal_link)
 		return phy->ops.setup_internal_link(hw);
 
 	return 0;

