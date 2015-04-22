From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 22 Apr 2015 14:40:31 -0700
Subject: [Intel-wired-lan] [PATCH 2/8] [TRIVIAL] freescale: remove incorrect
	copied comment
In-Reply-To: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1429738837-25158-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The comment in question is word-for-word copied from ixgbe, and clearly
has no meaning in freescale's driver. (it even says 'return an error'
when the code clearly does not). Remove the comment as it is obviously
incorrect and not applicable to the code as it is today.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index a583d89b13c4..5d4fac76b1a0 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -505,12 +505,6 @@ int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr)
 		break;
 
 	default:
-		/*
-		 * register RXMTRL must be set in order to do V1 packets,
-		 * therefore it is not possible to time stamp both V1 Sync and
-		 * Delay_Req messages and hardware does not support
-		 * timestamping all packets => return error
-		 */
 		fep->hwts_rx_en = 1;
 		config.rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
-- 
2.1.0

