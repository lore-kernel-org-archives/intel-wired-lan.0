From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Thu, 17 May 2018 07:57:56 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 05/12] xdp: add
 MEM_TYPE_ZERO_COPY
In-Reply-To: <20180515190615.23099-6-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
 <20180515190615.23099-6-bjorn.topel@gmail.com>
Message-ID: <20180517075756.52e7f82a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 15 May 2018 21:06:08 +0200
Bj?rn T?pel <bjorn.topel@gmail.com> wrote:

> @@ -82,6 +88,10 @@ struct xdp_frame *convert_to_xdp_frame(struct xdp_buff *xdp)
>  	int metasize;
>  	int headroom;
>  
> +	// XXX implement clone, copy, use "native" MEM_TYPE
> +	if (xdp->rxq->mem.type == MEM_TYPE_ZERO_COPY)
> +		return NULL;
> +

There is going to be significant tradeoffs between AF_XDP zero-copy and
copy-variant.  The copy-variant, still have very attractive
RX-performance, and other benefits like no exposing unrelated packets
to userspace (but limit these to the XDP filter).

Thus, as a user I would like to choose between AF_XDP zero-copy and
copy-variant. Even if my NIC support zero-copy, I can be interested in
only enabling the copy-variant. This patchset doesn't let me choose.

How do we expose this to userspace?
(Maybe as simple as an sockaddr_xdp->sxdp_flags flag?)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
