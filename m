From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 12 Apr 2017 13:21:06 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbevf: Fix errors in retrieving
	RETA and RSS from PF
In-Reply-To: <20170412202107.55834-1-anthony.l.nguyen@intel.com>
References: <20170412202107.55834-1-anthony.l.nguyen@intel.com>
Message-ID: <20170412202107.55834-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Mailbox support for getting RETA and RSS is available for only 82599 and
x540; a previous patch reversed the logic and these adapters were
returning not supported.

Also, the NACK check in ixgbevf_get_rss_key_locked() was checking for the
command IXGBE_VF_GET_RETA instead of IXGBE_VF_GET_RSS_KEY.

This patch corrects both issues by correcting the logic and checking for
the right command.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 8a5db9d..b6d0c01 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -333,7 +333,7 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	switch (hw->api_version) {
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
-		if (hw->mac.type >= ixgbe_mac_X550_vf)
+		if (hw->mac.type < ixgbe_mac_X550_vf)
 			break;
 	default:
 		return -EOPNOTSUPP;
@@ -399,7 +399,7 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	switch (hw->api_version) {
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
-		if (hw->mac.type >= ixgbe_mac_X550_vf)
+		if (hw->mac.type < ixgbe_mac_X550_vf)
 			break;
 	default:
 		return -EOPNOTSUPP;
@@ -419,7 +419,7 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	msgbuf[0] &= ~IXGBE_VT_MSGTYPE_CTS;
 
 	/* If the operation has been refused by a PF return -EPERM */
-	if (msgbuf[0] == (IXGBE_VF_GET_RETA | IXGBE_VT_MSGTYPE_NACK))
+	if (msgbuf[0] == (IXGBE_VF_GET_RSS_KEY | IXGBE_VT_MSGTYPE_NACK))
 		return -EPERM;
 
 	/* If we didn't get an ACK there must have been
-- 
2.9.3

