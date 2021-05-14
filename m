From: Matteo Croce <mcroce@linux.microsoft.com>
Date: Fri, 14 May 2021 20:39:54 +0200
Subject: [Intel-wired-lan] [PATCH net-next 3/3] vhost_net: use XDP helpers
In-Reply-To: <20210514183954.7129-1-mcroce@linux.microsoft.com>
References: <20210514183954.7129-1-mcroce@linux.microsoft.com>
Message-ID: <20210514183954.7129-4-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Matteo Croce <mcroce@microsoft.com>

Make use of the xdp_{init,prepare}_buff() helpers instead of
an open-coded version.

Also, the field xdp->rxq was never set, so pass NULL to xdp_init_buff()
to clear it.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/vhost/net.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index df82b124170e..6414bd5741b8 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -744,11 +744,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	if (copied != len)
 		return -EFAULT;
 
-	xdp->data_hard_start = buf;
-	xdp->data = buf + pad;
-	xdp->data_end = xdp->data + len;
+	xdp_init_buff(xdp, buflen, NULL);
+	xdp_prepare_buff(xdp, buf, pad, len, true);
 	hdr->buflen = buflen;
-	xdp->frame_sz = buflen;
 
 	--net->refcnt_bias;
 	alloc_frag->offset += buflen;
-- 
2.31.1

