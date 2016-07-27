From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 27 Jul 2016 12:02:32 -0700
Subject: [Intel-wired-lan] [next PATCH S40-V2 03/12] i40e: reset RX csum
	error stat with other pf stats
In-Reply-To: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469646161-30024-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

When we are resetting the pf stats we should also reset the RX csum
error stat.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I7af5ee0ec81a10f6deee1a7b8c2082ea068ef620
---
Testing Hints: Make sure the port.rx_csum_bad stat resets in ethtool
after a pfr.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2cf9d5b..77a35cf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -527,6 +527,7 @@ void i40e_pf_reset_stats(struct i40e_pf *pf)
 			pf->veb[i]->stat_offsets_loaded = false;
 		}
 	}
+	pf->hw_csum_rx_error = 0;
 }
 
 /**
-- 
2.4.11

