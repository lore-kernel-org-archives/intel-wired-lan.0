From: Jiri Pirko <jiri@resnulli.us>
Date: Sun, 24 Jun 2018 10:38:38 +0200
Subject: [Intel-wired-lan] [patch net-next 2/3] nfp: handle cls_flower
 command default case
In-Reply-To: <20180624083839.1692-1-jiri@resnulli.us>
References: <20180624083839.1692-1-jiri@resnulli.us>
Message-ID: <20180624083839.1692-3-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@mellanox.com>

Currently the default case is not handled, which with future command
introductions would introduce a warning. So handle it.

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 drivers/net/ethernet/netronome/nfp/flower/offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index c42e64f32333..c0e74aa4cb5e 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -576,9 +576,9 @@ nfp_flower_repr_offload(struct nfp_app *app, struct net_device *netdev,
 		return nfp_flower_del_offload(app, netdev, flower, egress);
 	case TC_CLSFLOWER_STATS:
 		return nfp_flower_get_stats(app, netdev, flower, egress);
+	default:
+		return -EOPNOTSUPP;
 	}
-
-	return -EOPNOTSUPP;
 }
 
 int nfp_flower_setup_tc_egress_cb(enum tc_setup_type type, void *type_data,
-- 
2.14.4

