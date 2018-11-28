From: Yang Xiao <YangX92@hotmail.com>
Date: Wed, 28 Nov 2018 12:24:17 +0000
Subject: [Intel-wired-lan] [PATCH] intel: ice: Do not enable NAPI on
 q_vectors that have no rings
Message-ID: <HK0PR01MB2163357339526D3645190770ADD10@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Young Xiao <YangX92@hotmail.com>

If ice driver has q_vectors w/ active NAPI that has no rings,
then this will result in a divide by zero error. To correct it
I am updating the driver code so that we only support NAPI on
q_vectors that have 1 or more rings allocated to them.

See commit 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors
that have no rings") for detail.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 333312a..9cc988a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2563,8 +2563,12 @@ static void ice_napi_enable_all(struct ice_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
-		napi_enable(&vsi->q_vectors[q_idx]->napi);
+	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
+
+		if (q_vector->rx.ring || q_vector->tx.ring)
+			napi_enable(&q_vector->napi);
+	}
 }
 
 /**
@@ -2931,8 +2935,12 @@ static void ice_napi_disable_all(struct ice_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
-		napi_disable(&vsi->q_vectors[q_idx]->napi);
+	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
+
+		if (q_vector->rx.ring || q_vector->tx.ring)
+			napi_enable(&q_vector->napi);
+	}
 }
 
 /**
-- 
2.7.4

