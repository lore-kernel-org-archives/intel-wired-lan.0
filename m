From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 12 May 2017 11:38:10 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] ixgbevf: Resolve warnings for
	-Wimplicit-fallthrough
In-Reply-To: <20170512183810.26185-1-anthony.l.nguyen@intel.com>
References: <20170512183810.26185-1-anthony.l.nguyen@intel.com>
Message-ID: <20170512183810.26185-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Additions to gcc 7 now warn whenever a switch statement falls through
implicitly.  This patch adds explicit fall through comments to address the
following warnings:

drivers/net/ethernet/intel/ixgbevf/vf.c: In function ?ixgbevf_get_reta_locked?:
drivers/net/ethernet/intel/ixgbevf/vf.c:336:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (hw->mac.type < ixgbe_mac_X550_vf)
      ^
drivers/net/ethernet/intel/ixgbevf/vf.c:338:2: note: here
  default:
  ^~~~~~~
drivers/net/ethernet/intel/ixgbevf/vf.c: In function ?ixgbevf_get_rss_key_locked?:
drivers/net/ethernet/intel/ixgbevf/vf.c:402:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (hw->mac.type < ixgbe_mac_X550_vf)
      ^
drivers/net/ethernet/intel/ixgbevf/vf.c:404:2: note: here
  default:
  ^~~~~~~

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index b6d0c01..0c25006 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -335,6 +335,7 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	case ixgbe_mbox_api_12:
 		if (hw->mac.type < ixgbe_mac_X550_vf)
 			break;
+		/* fall through */
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -401,6 +402,7 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	case ixgbe_mbox_api_12:
 		if (hw->mac.type < ixgbe_mac_X550_vf)
 			break;
+		/* fall through */
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.9.3

