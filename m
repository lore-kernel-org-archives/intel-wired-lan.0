Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB9606A31F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6g8L973w;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7+8dYqn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4130E40651;
	Sat, 28 Nov 2026 14:22:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IB7bP8HoZyex; Sat, 28 Nov 2026 14:22:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 649544067A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795875745;
	b=Oa1ErVheq8Ba+Wkd8NWnGzgmkjKwqqdG0pCnExUNX0OBVLlqZd5qJFZm6ksM02q+vL+6
	 2GkrbwV9q3jXZUEyLrkghYZveeCnHG+w2aW+ncA1Sqo9sDu7Ea3GXpZAM8V33t/rJBMNR
	 rjJDOJr49FLKSNWspLH6WWXF2N0yySmIuuBpZKV+zqihNyorivzG8OTgmDOTLsDswNh2C
	 NyjUtXCvfCoNf7LRcXSxMr8yciaG7PG/HMYs9hziGN37unY8hNErRYZ9bLXIz436UfKa2
	 KmDrAAC/QGSCVpxfX/na3fV3wkm8Og3xzVjwLZiHfiUlQdgF1IF22o6xcV7eEAeflsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795875745;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=zA60fx3IDAE8Dcc+270qACwgvqzyyGYtP65z/Qgip7I=;
	b=Rn1r0AXiCkPhZlZf8B+KVoxO0dG4iX8E0Zi95/7HRi/0EyLwbTnyGPsRZ5FZzsApSshA
	 O1r9hikSyHZDST5mgShDqE3IKQKNOITtJVUeQy9Vw1oHH+ELvxYtzmIIS8/JCuYFyZouZ
	 ZtM3HG3kONv0qWyLST9juVaXH98Nl25HN3gnVEGJOqdsviQMzVbJdiF4R83Ry64UCQ84/
	 jRJ29//ciV9JLlAAoD1banejIiBuhWRS4rDL1swSi8RFvKuIfWTwxAX1rLyXscHQFpJsh
	 jwydk8DrQ8RlGdp43SwGYuAW8SPvetD4r4+qZHIPRGHpBzuu6umzgEu+ycxUO6IcIBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795875745;
	bh=zA60fx3IDAE8Dcc+270qACwgvqzyyGYtP65z/Qgip7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=6g8L973wJ5PlRuVjocu4wg6uPdIyMCsLEgOFVNG0+TjXFI7+pqMSsMgcBvHJc8QNU
	 C59dYRHrfhERrb+dLWDhzVLr3fIE+QEjgpp6GiVun+90PbowsllEwRHXXKLV/+J+yo
	 dyYPYJuEv6wsiTmRnTpVQgrV6EBmK8NVSYLZq9MVC69o2+CJ0aFg/yH0fq9giccOjO
	 xblMh3/wRyhf2iOMAo5HB6PhDxT7EbWHUum2gU1WfAiZrBs94dCFKWuBsSU97DHy33
	 L7uRPCwZv/580l0OVV3eDkv8C9iKtmekOG3bWHklQbvoDgdbfZFs4C8StwW/HEjxTV
	 n3s7bjFb5gcCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 649544067A;
	Sat, 28 Nov 2026 14:22:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 210B23D9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 14:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 073F36063A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 14:22:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yf6gnHV4wpwk for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 14:22:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C28CE6063E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=C7+8dYqn
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C28CE6063E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 14:22:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C16E14055C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 14:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856D11F00893;
 Sat, 28 Nov 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795875741;
 bh=zA60fx3IDAE8Dcc+270qACwgvqzyyGYtP65z/Qgip7I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C7+8dYqngDhIs24Azo9MdWwjsL+YLKViw/ThP6D3G0rz+YV7KxvkaOxg4fUOiTU2f
 PEkCsSA7NMpBrdv+fbd8mSmonbmTfoMRnS6amiqqfRuv9NHfRQ/pxKF4dxSCamzS4l
 pP52qHrGdrXc2jKgBa+p2/Ns6k8jfxqg2sORhj08lbOq5ryTdABRqv6N2y7IDysz5p
 3WnuclfKdxZDHhtPdaRBnn5aCGoCiSQFcwoOHqnaZAfbz/aC8D8heoq1F50TIC72j3
 8MXUAxHopMc503S+X69nXmyldkXAllr3PSjAJrr6BrBu3C81uCkBiExQEm/vT9cpQM
 hXY/tKGIm8SLw==
Message-ID: <sashiko-outbox-238767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/3] xsk: Keep the shared info of zero-copy buffers
 in kernel memory
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261127142131.3527737-3-bjorn@kernel.org>
References: <20261127142131.3527737-1-bjorn@kernel.org>
 <20261127142131.3527737-3-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 14:22:21 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Critical] xsk: skb_shinfo() buffer overflow in
  xdp_build_skb_from_zc() on XDP_PASS
- [Medium] xsk: lost XDP_FLAGS_SINFO_EXT flag on buffer reuse in
  buf_to_xdp()
--

commit 8a374e24c8b71b5be821eeab702cf5c5a6b0a6c4
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

xsk: Keep the shared info of zero-copy buffers in kernel memory

This commit moves the skb_shared_info of AF_XDP zero-copy RX buffers from
the UMEM chunk tailroom into struct xsk_buff_pool and drops the tailroom
reservation from the chunk and headroom limits.

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f82..68dc9caacfa93 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
[ ... ]
> @@ -178,17 +189,26 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned cha=
r *hard_start,
> =20
>  /* Reserve memory area at end-of data area.
>   *
> - * This macro reserves tailroom in the XDP buffer by limiting the
> - * XDP/BPF data access to data_hard_end.  Notice same area (and size)
> - * is used for XDP_PASS, when constructing the SKB via build_skb().
> + * This reserves tailroom in the XDP buffer by limiting the XDP/BPF data
> + * access to data_hard_end.  Notice same area (and size) is used for
> + * XDP_PASS, when constructing the SKB via build_skb(). Buffers with
> + * %XDP_FLAGS_SINFO_EXT keep the shared info elsewhere and reserve none.
>   */
> -#define xdp_data_hard_end(xdp)				\
> -	((xdp)->data_hard_start + (xdp)->frame_sz -	\
> -	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> +static __always_inline void *xdp_data_hard_end(const struct xdp_buff *xd=
p)
> +{
> +	u32 tailroom =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	if (xdp->flags & XDP_FLAGS_SINFO_EXT)
> +		tailroom =3D 0;
> +	return xdp->data_hard_start + xdp->frame_sz - tailroom;
> +}

[Severity: Critical]
Can xdp_build_skb_from_zc() overflow the allocated skb buffer and overwrite
skb_shinfo(skb) on XDP_PASS?

With XDP_FLAGS_SINFO_EXT removing the skb_shared_info tailroom reservation
from xdp_data_hard_end() and xsk_pool_get_rx_frame_size(), packet data in a
zero-copy buffer can now extend all the way to xdp->data_hard_start +
xdp->frame_sz.  However, xdp_build_skb_from_zc() still allocates the skb
buffer using truesize =3D xdp->frame_sz:

net/core/xdp.c:xdp_build_skb_from_zc() {
	...
	u32 len =3D xdp->data_end - xdp->data_meta;
	u32 truesize =3D xdp->frame_sz;
	...
	data =3D page_pool_dev_alloc_va(pp, &truesize);
	if (unlikely(!data))
		goto out;

	skb =3D napi_build_skb(data, truesize);
	if (unlikely(!skb)) {
		page_pool_free_va(pp, data, true);
		goto out;
	}

	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);

	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
	...
}

Because napi_build_skb() carves SKB_DATA_ALIGN(sizeof(struct skb_shared_inf=
o))
out of the end of truesize, any zero-copy frame whose headroom plus
LARGEST_ALIGN(len) reaches into the last 320 bytes of xdp->frame_sz (such
as any multi-buffer head buffer on ice or idpf, or a buffer using the larger
UMEM headroom now permitted by xdp_umem_reg()) will copy past skb->end into
skb_shinfo(skb) and potentially past data + truesize into adjacent memory.

> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index a40ad3f90f13c..fc22314e72c4e 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
[ ... ]
> @@ -226,8 +213,10 @@ static inline void xsk_buff_set_size(struct xdp_buff=
 *xdp, u32 size)
>  	xdp->data =3D xdp->data_hard_start + XDP_PACKET_HEADROOM;
>  	xdp->data_meta =3D xdp->data;
>  	xdp->data_end =3D xdp->data + size;
> -	/* Frags flag is cleared when the frags of a head are released */
> -	xdp->flags &=3D XDP_FLAGS_HAS_FRAGS;
> +	/* Frags flag is cleared when the frags of a head are released. The
> +	 * shared info flag stays, see xp_set_rxq_info().
> +	 */
> +	xdp->flags &=3D XDP_FLAGS_HAS_FRAGS | XDP_FLAGS_SINFO_EXT;
>  }

[Severity: Medium]
Can an xdp_buff_xsk lose XDP_FLAGS_SINFO_EXT permanently when recycled after
virtio_net processes a mergeable multi-buffer RX packet?

xp_set_rxq_info() sets XDP_FLAGS_SINFO_EXT once at queue setup, and both
xp_alloc() and xsk_buff_set_size() only mask xdp->flags with &=3D rather th=
an
setting the bit.  In virtio_net, buf_to_xdp() clears xdp->flags on follow-on
buffers before xsk_append_merge_buffer() frees them back to the pool:

drivers/net/virtio_net.c:buf_to_xdp() {
	...
	if (first_buf) {
		xsk_buff_set_size(xdp, len);
	} else {
		xdp_prepare_buff(xdp, xdp->data_hard_start,
				 XDP_PACKET_HEADROOM - vi->hdr_len, len, 1);
		xdp->flags =3D 0;
	}
	...
}

When that buffer is later reallocated as a head buffer, XDP_FLAGS_SINFO_EXT
remains cleared, causing xdp_get_shared_info_from_buff() to point back into
the UMEM chunk tailroom and xdp_data_hard_end() to subtract sizeof(struct
skb_shared_info) again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127142131.3527=
737-1-bjorn@kernel.org?part=3D2
