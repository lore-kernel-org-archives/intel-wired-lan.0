From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:27:56 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: X540 thermal warning interrupt not
	a GPI
Message-ID: <20150808232756.95142.85947.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The X540 thermal interrupt (IXGBE_EIMS_TS) is not an SDP, so it
doesn't need to be enabled in ixgbe_setup_gpie(). In fact the
value is simply not for the GPIE register at all.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9d302cbd813d..fb5528d5ace9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4916,9 +4916,6 @@ static void ixgbe_setup_gpie(struct ixgbe_adapter *adapter)
 		case ixgbe_mac_82599EB:
 			gpie |= IXGBE_SDP0_GPIEN_8259X;
 			break;
-		case ixgbe_mac_X540:
-			gpie |= IXGBE_EIMS_TS;
-			break;
 		default:
 			break;
 		}

