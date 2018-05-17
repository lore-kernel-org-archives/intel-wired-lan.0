From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 17 May 2018 09:08:15 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 05/12] xdp: add
 MEM_TYPE_ZERO_COPY
In-Reply-To: <20180517075756.52e7f82a@redhat.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
 <20180515190615.23099-6-bjorn.topel@gmail.com>
 <20180517075756.52e7f82a@redhat.com>
Message-ID: <CAJ+HfNjwM4GeX2Zt9JuJz5Ld80QEzBZsFV+22E4cw3nmU6sJGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

2018-05-17 7:57 GMT+02:00 Jesper Dangaard Brouer <brouer@redhat.com>:
> On Tue, 15 May 2018 21:06:08 +0200
> Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
>> @@ -82,6 +88,10 @@ struct xdp_frame *convert_to_xdp_frame(struct xdp_buff *xdp)
>>       int metasize;
>>       int headroom;
>>
>> +     // XXX implement clone, copy, use "native" MEM_TYPE
>> +     if (xdp->rxq->mem.type == MEM_TYPE_ZERO_COPY)
>> +             return NULL;
>> +
>
> There is going to be significant tradeoffs between AF_XDP zero-copy and
> copy-variant.  The copy-variant, still have very attractive
> RX-performance, and other benefits like no exposing unrelated packets
> to userspace (but limit these to the XDP filter).
>
> Thus, as a user I would like to choose between AF_XDP zero-copy and
> copy-variant. Even if my NIC support zero-copy, I can be interested in
> only enabling the copy-variant. This patchset doesn't let me choose.
>
> How do we expose this to userspace?
> (Maybe as simple as an sockaddr_xdp->sxdp_flags flag?)
>

We planned to add these flags later, but I think you're right that
it's better to do that right away.

If we try to follow the behavior of the XDP netlink interface: Pick
the "the best mode" when there are no flags. A user would like to
"force" a mode -- meaning that you select, say copy, and getting an
error if that's not supported. Four new flags?

diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 77b88c4efe98..ce1f710847b7 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -22,7 +22,11 @@
 #include <linux/types.h>

 /* Options for the sxdp_flags field */
-#define XDP_SHARED_UMEM 1
+#define XDP_SHARED_UMEM        (1U << 0)
+#define XDP_COPY_TX_UMEM    (1U << 1)
+#define XDP_ZEROCOPY_TX_UMEM    (1U << 2)
+#define XDP_COPY_RX_UMEM    (1U << 3)
+#define XDP_ZEROCOPY_RX_UMEM    (1U << 4)

 struct sockaddr_xdp {
     __u16 sxdp_family;

A better way?




> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
