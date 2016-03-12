From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 11 Mar 2016 17:07:39 -0800
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: Correct length check for round
	up
In-Reply-To: <20160312010538.130154.49237.stgit@mdrustad-wks.jf.intel.com>
References: <20160312010538.130154.49237.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160312010739.130154.13649.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function ixgbe_host_interface_command actually uses a multiple
of word sized buffer to do its business, but only checks against
the actual length passed in. This means that on read operations it
could be possible to modify locations beyond the length passed in.
Change the check to round up in the same way, just to avoid any
possible hazard.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index dfdb1149b6fd..decc6f0a560c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3557,7 +3557,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, u32 *buffer,
 	if (buf_len == 0)
 		return 0;
 
-	if (length < (buf_len + hdr_size)) {
+	if (length < ((buf_len + 3) & ~3) + hdr_size) {
 		hw_dbg(hw, "Buffer not large enough for reply message.\n");
 		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
 	}

