From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri, 23 Aug 2019 16:08:20 +0200
Subject: [Intel-wired-lan] 
 =?utf-8?q?=5BPATCH=5D_ethernet=3A_Delete_unnec?=
 =?utf-8?q?essary_checks_before_the_macro_call_=E2=80=9Cdev=5Fkfree=5Fskb?=
 =?utf-8?b?4oCd?=
In-Reply-To: <af1ae1cf-4a01-5e3a-edc2-058668487137@web.de>
References: <af1ae1cf-4a01-5e3a-edc2-058668487137@web.de>
Message-ID: <4ab7f2a5-f472-f462-9d4c-7c8d5237c44e@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

in this patch, there is one piece that looked better before. (see below)

Removing the 'if (skb)' is fine, but concatening everything in one 
statement just to save 2 variables and a few LOC is of no use, IMHO, and 
the code is less readable.

just my 2c.


CJ


diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d3a0b614dbfa..8b19ddcdafaa 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2515,19 +2515,14 @@ static int bcmgenet_dma_teardown(struct 
bcmgenet_priv *priv)
 ?static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 ?{
 ???? struct netdev_queue *txq;
-??? struct sk_buff *skb;
-??? struct enet_cb *cb;
 ???? int i;

 ???? bcmgenet_fini_rx_napi(priv);
 ???? bcmgenet_fini_tx_napi(priv);

-??? for (i = 0; i < priv->num_tx_bds; i++) {
-??????? cb = priv->tx_cbs + i;
-??????? skb = bcmgenet_free_tx_cb(&priv->pdev->dev, cb);
-??????? if (skb)
-??????????? dev_kfree_skb(skb);
-??? }
+??? for (i = 0; i < priv->num_tx_bds; i++)
+ dev_kfree_skb(bcmgenet_free_tx_cb(&priv->pdev->dev,
+????????????????????????? priv->tx_cbs + i));

 ???? for (i = 0; i < priv->hw_params->tx_queues; i++) {
 ???????? txq = netdev_get_tx_queue(priv->dev, priv->tx_rings[i].queue);
