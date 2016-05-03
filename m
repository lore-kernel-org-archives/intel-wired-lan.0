From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:16 -0700
Subject: [Intel-wired-lan] [next PATCH S36 08/12] i40e: Correct UDP packet
	header for non_tunnel-ipv6
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch corrects Rx ptype payload layer for non_tunneled ipv6. It
should be layer 4 for UDP, instead of layer 3.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Change-ID: I9382e4458ab3c4e58f6d2e9f195d5d4ee513805e
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 27c6f9d..422b41d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -696,7 +696,7 @@ struct i40e_rx_ptype_decoded i40e_ptype_lookup[] = {
 	/* Non Tunneled IPv6 */
 	I40E_PTT(88, IP, IPV6, FRG, NONE, NONE, NOF, NONE, PAY3),
 	I40E_PTT(89, IP, IPV6, NOF, NONE, NONE, NOF, NONE, PAY3),
-	I40E_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY3),
+	I40E_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY4),
 	I40E_PTT_UNUSED_ENTRY(91),
 	I40E_PTT(92, IP, IPV6, NOF, NONE, NONE, NOF, TCP,  PAY4),
 	I40E_PTT(93, IP, IPV6, NOF, NONE, NONE, NOF, SCTP, PAY4),
-- 
2.4.11

