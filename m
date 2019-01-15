From: Kazimierczak, Krzysztof <krzysztof.kazimierczak@intel.com>
Date: Tue, 15 Jan 2019 09:19:03 +0000
Subject: [Intel-wired-lan] [PATCH bpf] xsk: Check if a queue exists during
 umem setup
Message-ID: <A2709E16AE7E444B9FD2D20EF44E15072BC9B039@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From 6cbcfa3d0909bc27af0be6122dc6bfbfa4c9269e Mon Sep 17 00:00:00 2001
From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
Date: Thu, 10 Jan 2019 20:29:02 +0100
Subject: [PATCH bpf] xsk: Check if a queue exists during umem setup

In the xdp_umem_assign_dev() path, the xsk code does not
check if a queue for which umem is to be created exists.
It leads to a situation where umem is not assigned to any
Tx/Rx queue of a netdevice, without notifying the stack
about an error. This affects both XDP_SKB and XDP_DRV
modes - in case of XDP_DRV_ZC, queue index is checked by
the driver.

This patch fixes xsk code, so that in both XDP_SKB and
XDP_DRV mode of AF_XDP, an error is returned when requested
queue index exceedes an existing maximum.

Fixes: c9b47cc1fabca ("xsk: fix bug when trying to use both copy and zero-copy on one queue id")
Reported-by: Jakub Spizewski <jakub.spizewski@intel.com>
Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
---
 net/xdp/xdp_umem.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index a264cf2accd0..d4de871e7d4d 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -41,13 +41,20 @@ void xdp_del_sk_umem(struct xdp_umem *umem, struct xdp_sock *xs)
  * not know if the device has more tx queues than rx, or the opposite.
  * This might also change during run time.
  */
-static void xdp_reg_umem_at_qid(struct net_device *dev, struct xdp_umem *umem,
-				u16 queue_id)
+static int xdp_reg_umem_at_qid(struct net_device *dev, struct xdp_umem *umem,
+			       u16 queue_id)
 {
+	if (queue_id >= max_t(unsigned int,
+			      dev->real_num_rx_queues,
+			      dev->real_num_tx_queues))
+		return -EINVAL;
+
 	if (queue_id < dev->real_num_rx_queues)
 		dev->_rx[queue_id].umem = umem;
 	if (queue_id < dev->real_num_tx_queues)
 		dev->_tx[queue_id].umem = umem;
+
+	return 0;
 }
 
 struct xdp_umem *xdp_get_umem_from_qid(struct net_device *dev,
@@ -88,7 +95,10 @@ int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
 		goto out_rtnl_unlock;
 	}
 
-	xdp_reg_umem_at_qid(dev, umem, queue_id);
+	err = xdp_reg_umem_at_qid(dev, umem, queue_id);
+	if (err)
+		goto out_rtnl_unlock;
+
 	umem->dev = dev;
 	umem->queue_id = queue_id;
 	if (force_copy)
-- 
2.17.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

