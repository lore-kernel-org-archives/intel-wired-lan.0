From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 10 May 2021 11:38:54 +0200
Subject: [Intel-wired-lan] [PATCH intel-net v2 6/6] igc: add correct
 exception tracing for XDP
In-Reply-To: <20210510093854.31652-1-magnus.karlsson@gmail.com>
References: <20210510093854.31652-1-magnus.karlsson@gmail.com>
Message-ID: <20210510093854.31652-7-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Add missing exception tracing to XDP when a number of different
errors can occur. The support was only partial. Several errors
where not logged which would confuse the user quite a lot not
knowing where and why the packets disappeared.

Fixes: 73f1071c1d29 ("igc: Add support for XDP_TX action")
Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 069471b7ffb0..f1adf154ec4a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2047,20 +2047,19 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
 		break;
 	case XDP_TX:
 		if (igc_xdp_xmit_back(adapter, xdp) < 0)
-			res = IGC_XDP_CONSUMED;
-		else
-			res = IGC_XDP_TX;
+			goto out_failure;
+		res = IGC_XDP_TX;
 		break;
 	case XDP_REDIRECT:
 		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
-			res = IGC_XDP_CONSUMED;
-		else
-			res = IGC_XDP_REDIRECT;
+			goto out_failure;
+		res = IGC_XDP_REDIRECT;
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
 	case XDP_ABORTED:
+out_failure:
 		trace_xdp_exception(adapter->netdev, prog, act);
 		fallthrough;
 	case XDP_DROP:
-- 
2.29.0

