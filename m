From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 20 Mar 2017 14:43:02 -0700
Subject: [Intel-wired-lan] [net PATCH] i40e: Do not enable NAPI on q_vectors
	that have no rings
Message-ID: <20170320213859.13451.3294.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

When testing the epoll w/ busy poll code I found that I could get into a
state where the i40e driver had q_vectors w/ active NAPI that had no rings.
This was resulting in a divide by zero error.  To correct it I am updating
the driver code so that we only support NAPI on q_vectors that have 1 or
more rings allocated to them.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

I am submitting this for net, not next-queue since this fixes an issue that
can result in a kernel panic using existing kernel interfaces.

Testing Hints:
	I found the issue this fixes while using sockperf with busy poll.
	Basically all I did is run a test with sockperf in which busy
	polling was running, stopped the test, changed the number of
	queues via "ethtool -L" and the system generated a divide by 0
	error.

 drivers/net/ethernet/intel/i40e/i40e_main.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9df0d86812e7..1e12248a34ba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4440,8 +4440,12 @@ static void i40e_napi_enable_all(struct i40e_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
-		napi_enable(&vsi->q_vectors[q_idx]->napi);
+	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
+		struct i40e_q_vector *q_vector = vsi->q_vectors[q_idx];
+
+		if (q_vector->rx.ring || q_vector->tx.ring)
+			napi_enable(&q_vector->napi);
+	}
 }
 
 /**
@@ -4455,8 +4459,12 @@ static void i40e_napi_disable_all(struct i40e_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
-		napi_disable(&vsi->q_vectors[q_idx]->napi);
+	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
+		struct i40e_q_vector *q_vector = vsi->q_vectors[q_idx];
+
+		if (q_vector->rx.ring || q_vector->tx.ring)
+			napi_disable(&q_vector->napi);
+	}
 }
 
 /**

