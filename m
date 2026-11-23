Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43757606A32D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ScqKWgES;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1vyvdgA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2169780C64;
	Mon, 23 Nov 2026 13:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3vwwJP0QVLGe; Mon, 23 Nov 2026 13:59:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2116080C35
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442384;
	b=ZdYUtyfdMDy8iZw2Y0WVt5reDWpuV6luwwDxzqmiXU3+sFW9gWGxZyJzrqbxoKrXYSnR
	 ijw7JCTeIpd7nruXNMWSnu3p6RXsdO1+hAx6e4L8wH60Otd+vLKBMLfOMUQgkrB+O8t/4
	 cc7CGSAGmUZsL8FV/IvLgpwVcokgYMl8gzUbvVwr16saAOdCy94cBugM9wZVPaau+USoh
	 9qG5lSs4apGlGlSgZb6n6FSb6qrj7eM1ynL/KSRR1poHuuXf0ec7XJaF7cZw9u+8EeAy1
	 h/tMBfsBIXcJKYnx9RWCcxeJoT99MLo3cwVqDsyTv0vFJzsq7VwsCxL7qqHpG6iOVuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tlfO4B45EC9cuyRt8phU696ACnOeHZNE/KodroKLqGY=;
	b=Xlr98rnLIgutoPGbImF3j1t1RUY9ufFsKV6BStzDwh59oUhGANUbLx33qnLzUXfgSz8Y
	 4PZLm0toa8RWKi3Y7+kAejXILhthhYXQ1cWLB1Kq0T053NqoDQDSIH7Yv91ZkN46EW5ua
	 btkONLtC7HsFuLxTKzHjOtHgFumxs8aaGZtgkGUjN9VkJuSdHrtVMm/bU8pQgPvLdWn0m
	 90Ky4TbF0RHbQrSj95tt5ltd3VLKRuSUCXAavev0Ko3G68ijaEBOaE9I6DtKLa3o4OPfu
	 8Jn4BRec6DNrKiWPeFBQT3eWgCIOzMMW17VidpJkMmZ2q7OQVUvnTRSitE4QgLJrLXQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795442384;
	bh=tlfO4B45EC9cuyRt8phU696ACnOeHZNE/KodroKLqGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ScqKWgESdNGpo9Vq0CMlNOv5TMSvpB+XecjGsOxpFyJQSzPxbMCzkbnXfs/mugBF+
	 o420bmq/cRWBhUiPLX0wAJLRVygQMKydUBm/IEYtAwAe+3pK+l0Zu+O2sWiYa5cEp3
	 Y/LweGacqAJ59J+Tbg42cyHj85yxYUBvAIyC/e6ptBWMQsVn7FaEoJYIaRLUVc6a5L
	 q7h5RRXvWnuiFjyLKaTifcBagXYJGtJIDkptztpe91XZeFUd6pSqk3NamJE9YudRhc
	 noYWsVItBJ+5JbZdWZna8HWBRCjsvzY4rJfLleYPzJQ9jL+UBlBmsZoKFmIo9A9lFG
	 tFN+YRMeqt8NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2116080C35;
	Mon, 23 Nov 2026 13:59:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D4154371
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 13:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C65804052B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 13:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XE1f4naSK4-q for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 13:59:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89E1140567
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Y1vyvdgA
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89E1140567
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 13:59:41 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8b68e59ab33so2408493b3a.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 05:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795442381; x=1796047181; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tlfO4B45EC9cuyRt8phU696ACnOeHZNE/KodroKLqGY=;
 b=Y1vyvdgAzkZN7h4ZnDaUzknUgaKynE21gSVsv+WuS73A+HWdni+pb0Uy0hH3aKDrcS
 xPyxuWFSBlit1M3EEQV17dNyNDsB5ItfJb8YMjS3k/RHzg2gD9aUc9vcuZGIPQwZrBTf
 MEqQoV7pLTtxVD2tcf4lNv1Pcq7CyXoDks6hfgkT1w2D9id5VUQZWj1SQv1jqiU3tjVh
 ygdfWJTTkG53A6GrfmTJFwXI4XVspYiC7pIyKcV8z+S2rPdMbzTykwalN50eAA7RQyJO
 R/6CcYbN4nXdy7eU4pgB2XCGYmVquKKNmrEJl5NA/rjFdsfgnP+rwbet++rbMgzmCy8H
 FAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442381; x=1796047181;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tlfO4B45EC9cuyRt8phU696ACnOeHZNE/KodroKLqGY=;
 b=NitnVUxv7md044aTL7aRvrbh/LPeKftIU+skiZVTj786TSa5GVfUv02LhvYZ+eew60
 ImA23+/r2aEJriyUSgfRceQUcsbnSz652M6ei5zauf2DzHcw2sz9fpnrLLJVanTdSXt8
 m4m+Exr1tODrdWWC4Z9VYOMX2A/UUFDG6GEwmNSIsAl4Tm2xPpTQ2tonPiOCrRS518uz
 lRPPCURUuBoIi1KAFgvTpFQk1j4M2q9L27QBxu2RzFRZYVGYEapPhuA//BCi7JkEv8jC
 py7rc6jSLtT05/+8SB3/6M/GkwD/F1ED2Rehd4eqtRBoPD6vOCVYwDoSSnPJKWrAPCNv
 FsfA==
X-Forwarded-Encrypted: i=1;
 AL+hErGOwVGLMeb2wWIKXEOroyel72Pgue0w5VMkNIqi8YhzaRbYIgvVuTlkR9FBeb9nughB0dq48jzqJdwxpWUB1fs=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/J3mb4/x+4tThkyjvctsTeUx8odyVgmAzl8fmQhWaAf9sr29gS
 xqGtlL+UOavAn3CpfYnROeHEXUScADbAI21rNHxrEuIpfj9JtJnWjB6F9w/o4ZYXANf3BVDCHFn
 3cnRxcuE1/l0cGKqGdFDLYaHgPGVFbuA=
X-Gm-Gg: AZFdTZfnNfTKklKX070N9/G6KAx0z8+7D6aHCWJDtijuAVDnduHAORPKF+w+g3+0Bgm
 eKwVHBtAb6EedSOCqyZSyXj3YEFegq2gfOtg9X2dTRHFGPjTHaCf4Wc4FhKdoodFex0rOajTW4I
 c1JEWuAvhoqktIvMmr+LTSMFp3lQ8AnvK/POBOIXtC74626SATPIOOmStMxRTU52aGBmvxCljWx
 zu4PQTXYLR3FD1z2XfRwu8oXnIff6oThoTFcGMamyrvHrx9XvARH58eiLr38tmPwCzBm4bVckhd
 IZdQ/TU9O0Khyz7uNuqfSn90GqoBn4CmPimxiyHa0V0nKSQ/ELs/u7hKIsl/HZzNs8I0V/qjtID
 Xloqpklu2UGqWacVnYg2TzPMMHMBVjPHNCACT
X-Received: by 2002:a05:6a00:984:b0:8bf:e028:7864 with SMTP id
 d2e1a72fcca58-8c87663e154mr11101894b3a.0.1795442380482; Mon, 23 Nov 2026
 05:59:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-4-magnus.karlsson@intel.com> <awBXmCqkMKxsc+9i@boxer>
 <CAJ8uoz2tKthHN6MHUJoixtjzkGqJR0ukdJCWRG0_2_J11PN_uw@mail.gmail.com>
 <awQBgefjtxMdZYWg@boxer>
In-Reply-To: <awQBgefjtxMdZYWg@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 23 Nov 2026 14:59:27 +0100
X-Gm-Features: Aa3M54r-NCsZ4ZM4AX2tCeJg_MUvFpna-XwzlPMyitDwRzQ8QlsFoNm6MG0GkWA
Message-ID: <CAJ8uoz3rJ3saU3eErZVYRQnCckggEjDAY9EV05yqdX8vy5dP=g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] xsk: ice: add USO zero-copy support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org,
 sdf@fomichev.me, 
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
 horms@kernel.org, bjorn@kernel.org, kerneljasonxing@gmail.com, 
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 10:04, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Nov 23, 2026 at 09:40:37AM +0100, Magnus Karlsson wrote:
> > On Fri, 20 Nov 2026 at 15:22, Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, Nov 19, 2026 at 05:53:38PM +0100, Magnus Karlsson wrote:
> > > > Add UDP Segmentation Offload (USO) for AF_XDP zero-copy and impleme=
nt
> > > > it in the ice driver. Drivers advertise support with tmo_supports_u=
so,
> > > > which is reported to user space as the tx-uso-zc netdev XSK feature=
.
> > > >
> > > > The core exports xsk_tx_uso_parse() and xsk_tx_uso_prepare_headers(=
) for
> > > > drivers, which snapshot, validate and prepare the packet header, an=
d
> > > > xsk_tx_invalid_descs() for accounting dropped requests. Drivers wit=
hout
> > > > tmo_supports_uso keep handling a USO request as invalid metadata, s=
o
> > > > xsk_tx_metadata_request() ignores the packet's metadata. As in copy
> > > > mode, requests that produce more than one datagram also need
> > > > NETIF_F_GSO_UDP_L4 on the device.
> > > >
> > > > Packet headers are copied into kernel-owned memory before they are
> > > > validated and handed to the NIC, so that user space cannot change t=
hem
> > > > afterwards. ice keeps a DMA-mapped header slot for every two
> > > > descriptors of the XDP Tx ring, as a USO packet takes at least a
> > > > context and a header descriptor. The slots hold only header bytes a=
nd
> > > > are allocated page by page to avoid a large contiguous
> > > > allocation. They belong to the ring: they are allocated when a pool
> > > > that can carry USO requests is assigned to the ring, and freed with
> > > > the ring. They therefore follow XDP attach and detach, ring rebuild=
s
> > > > and netdev unregistration rather than the pool. Only the copied hea=
der
> > > > bytes are synced for the device. With fewer XDP rings than CPUs,
> > > > queues share XDP rings and would share their slots, so no slots are
> > > > allocated and USO requests are ignored for now, though support for
> > > > this could be added as a separate patch set in the future. tx-uso-z=
c
> > > > is still reported in this case, as documented. The slots are only
> > > > set up when an XDP program is attached. If they cannot be allocated
> > > > when a ring is reconfigured, the ring keeps its pool without USO an=
d a
> > > > warning is logged, while a bind fails.
> > > >
> > > > When the slots exist, ice_xmit_zc() processes descriptors one packe=
t
> > > > at a time. A USO packet gets a context and a header descriptor, the=
n
> > > > shares the data-descriptor loop with ordinary packets. The Tx budge=
t
> > > > reserves worst-case descriptors per packet. The per-packet path is =
used
> > > > for every pool with a Tx metadata area that can carry USO requests,
> > > > whether or not it sends them. Other pools keep the existing batched
> > > > fast path. Both paths share the budget, tail, stats and wakeup
> > > > handling. If the Tx ring cannot hold a maximum-size packet in this
> > > > worst case, such a packet could never be peeked and Tx would stall,=
 so
> > > > no header slots are allocated, USO requests are ignored and a warni=
ng
> > > > is logged. The pool flag is not cleared, as the pool may still fall
> > > > back to copy mode. This is only possible when PAGE_SIZE is 64K and =
the
> > > > Tx ring is set to its minimum size.
> > > >
> > > > Packets that exceed the hardware limits are dropped and counted in
> > > > tx_invalid_descs through the new xsk_tx_invalid_descs() helper. The=
ir
> > > > completions are deferred behind in-flight descriptors to keep the
> > > > completion ring in order. Packets without USO are dropped as well i=
f
> > > > they would exceed the eight buffers, which is possible when chunks
> > > > larger than a data descriptor are split. A batch from the shared-um=
em
> > > > fallback can end inside a packet. That packet is dropped, and so is
> > > > its remainder in the next batch.
> > > >
> > > > On completion, a buffer of the existing fast path still stands for =
one
> > > > completion, so that path writes nothing to tx_buf[] and struct
> > > > ice_tx_buf keeps its size. Buffers of the USO path carry an explici=
t
> > > > completion count in a union with fields that zero-copy rings do not=
 use.
> > > > USO header slots, deferred drops and buffers split into several
> > > > descriptors are tracked with a per-ring counter, so ordinary traffi=
c
> > > > keeps the fast cleanup path. The header slot of a context descripto=
r is
> > > > found from its position in the ring.
> > > >
> > > > The descriptors are built with the descriptor builders that the
> > > > previous patch added for ice_tso().
> > > >
> > > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>
> > > > +/* Returns the number of packets queued on the ring. */
> > > > +static u32 ice_xmit_zc_metadata(struct ice_tx_ring *ring, struct x=
sk_buff_pool *pool,
> > > > +                             u32 count, unsigned int *total_bytes)
> > > > +{
> > > > +     struct xdp_desc *descs =3D pool->tx_descs;
> > > > +     u32 i =3D 0, packets =3D 0;
> > > > +
> > > > +     /* Drop the rest of a packet whose start was dropped in an ea=
rlier batch. */
> > > > +     if (unlikely(ring->xsk_drain)) {
> > > > +             while (i < count && ring->xsk_drain)
> > > > +                     ring->xsk_drain =3D !xsk_is_eop_desc(&descs[i=
++]);
> > > > +             ice_xsk_drop_packet(ring, pool, i);
> > > > +     }
> > > > +
> > > > +     while (i < count) {
> > > > +             u32 cmd =3D 0, offset =3D 0, skip =3D 0, slot_offset;
> > > > +             u32 len =3D descs[i].len, nr =3D 1;
> > > > +             struct ice_xsk_uso_page *page;
> > > > +             struct xsk_tx_uso_info info;
> > > > +             int uso;
> > > > +
> > > > +             while (!xsk_is_eop_desc(&descs[i + nr - 1]) && i + nr=
 < count)
> > > > +                     len +=3D descs[i + nr++].len;
> > > > +             /* The shared-umem fallback can end a batch inside a =
packet. */
> > >
> > > No, it can not... or at least the intent was not to. the shared umem
> > > fallback has been written in a way that it also calls
> > > xskq_cons_read_desc_batch() which is supposed *not* to expose incompl=
ete
> > > multi-buffer packet.
> > >
> > > Is that a special case where you don't set XDP_USE_SG but packets are=
 not
> > > linear due to USO, or what?
> > >
> > > I wouldn't like to propagate the draining disease down to drivers. We=
've
> > > put enough of convoluted code onto layer above, let us address it the=
re if
> > > there's something missing?
> >
> > You are right. This should not be here in the driver. I will fix it in
> > the core instead.
> >
> > At some point we really need to simplify the skb multi-buffer path.
> > Always gives me a headache.
>
> skb mbuf is not a victim here :P regardless I agree on rewrite.
>
> >
> > > I'm gonna cut the review here and keep the comments I had so far.
> > >
> > > > +             if (unlikely(!xsk_is_eop_desc(&descs[i + nr - 1]))) {
> > > > +                     ice_xsk_drop_packet(ring, pool, nr);
> > > > +                     ring->xsk_drain =3D true;
> > > > +                     break;
> > > > +             }
> > > > +             page =3D ice_xsk_uso_slot(ring, ring->next_to_use, &s=
lot_offset);
> > > > +             uso =3D xsk_tx_uso_parse(pool, &descs[i], nr, &info,
> > > > +                                    page->addr + slot_offset + NET=
_IP_ALIGN);
> > > > +             if (uso < 0 || (!uso && !ice_xsk_bufs_fit(pool, &desc=
s[i], nr)) ||
> > > > +                 (uso && ice_xsk_xmit_uso_hdr(ring, &descs[i], nr,=
 &info,
> > > > +                                              &cmd, &offset))) {
> > > > +                     ice_xsk_drop_packet(ring, pool, nr);
> > > > +                     i +=3D nr;
> > > > +                     continue;
> > > > +             }
> > > > +             if (uso) {
> > > > +                     skip =3D info.header_len;
> > > > +                     *total_bytes +=3D (info.gso_segs - 1) * skip;
> > > > +                     packets +=3D info.gso_segs - 1;
> > > > +             }
> > > > +             ice_xsk_xmit_descs(ring, pool, &descs[i], nr, skip, c=
md, offset);
> > > > +             *total_bytes +=3D len;
> > > > +             packets++;
> > > > +             i +=3D nr;
> > > > +     }
> > > > +     return packets;
> > > > +}
> > > > +
> > > > +/**
> > > > + * ice_xsk_setup_metadata - register AF_XDP Tx metadata operations
> > > > + * @netdev: net_device
> > > > + */
> > > > +void ice_xsk_setup_metadata(struct net_device *netdev)
> > > > +{
> > > > +     static const struct xsk_tx_metadata_ops ops =3D {
> > > > +             .tmo_supports_uso =3D true,
> > > > +     };
> > > > +
> > > > +     netdev->xsk_tx_metadata_ops =3D &ops;
> > > > +}
> > > > +
> > > >  /**
> > > >   * ice_xmit_zc - take entries from XSK Tx ring and place them onto=
 HW Tx ring
> > > >   * @xdp_ring: XDP ring to produce the HW Tx descriptors on
> > > > @@ -801,9 +1222,9 @@ static void ice_fill_tx_hw_ring(struct ice_tx_=
ring *xdp_ring,
> > > >  bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_poo=
l *xsk_pool)
> > > >  {
> > > >       struct xdp_desc *descs =3D xsk_pool->tx_descs;
> > > > -     u32 nb_pkts, nb_processed =3D 0;
> > > > +     u32 nb_pkts, nb_processed =3D 0, packets;
> > > >       unsigned int total_bytes =3D 0;
> > > > -     int budget;
> > > > +     u32 budget, cost =3D 1;
> > > >
> > > >       ice_clean_xdp_irq_zc(xdp_ring, xsk_pool);
> > > >
> > > > @@ -811,26 +1232,38 @@ bool ice_xmit_zc(struct ice_tx_ring *xdp_rin=
g, struct xsk_buff_pool *xsk_pool)
> > > >           !netif_running(xdp_ring->vsi->netdev))
> > > >               return true;
> > > >
> > > > -     budget =3D ICE_DESC_UNUSED(xdp_ring);
> > > > -     budget =3D min_t(u16, budget, ICE_RING_QUARTER(xdp_ring));
> > > > +     /* Reserve worst-case descriptors for each potential USO pack=
et. */
> > > > +     if (xdp_ring->xsk_uso_pages)
> > > > +             cost =3D ice_xsk_uso_desc_cost(xsk_pool);
> > > > +     budget =3D min_t(u32, ICE_DESC_UNUSED(xdp_ring) / cost,
> > > > +                    ICE_RING_QUARTER(xdp_ring));
> > > >
> > > >       nb_pkts =3D xsk_tx_peek_release_desc_batch(xsk_pool, budget);
> > > >       if (!nb_pkts)
> > > >               return true;
> > > >
> > > > -     if (xdp_ring->next_to_use + nb_pkts >=3D xdp_ring->count) {
> > > > -             nb_processed =3D xdp_ring->count - xdp_ring->next_to_=
use;
> > > > -             ice_fill_tx_hw_ring(xdp_ring, xsk_pool, descs, nb_pro=
cessed,
> > > > -                                 &total_bytes);
> > > > -             xdp_ring->next_to_use =3D 0;
> > > > -     }
> > > > +     if (xdp_ring->xsk_uso_pages) {
> > > > +             packets =3D ice_xmit_zc_metadata(xdp_ring, xsk_pool, =
nb_pkts,
> > >
> > > nit: could we stick to 'pkts'
> > >
> > > > +                                            &total_bytes);
> > > > +     } else {
> > > > +             if (xdp_ring->next_to_use + nb_pkts >=3D xdp_ring->co=
unt) {
> > > > +                     nb_processed =3D xdp_ring->count - xdp_ring->=
next_to_use;
> > > > +                     ice_fill_tx_hw_ring(xdp_ring, xsk_pool, descs=
, nb_processed,
> > > > +                                         &total_bytes);
> > > > +                     xdp_ring->next_to_use =3D 0;
> > > > +             }
> > > >
> > > > -     ice_fill_tx_hw_ring(xdp_ring, xsk_pool, &descs[nb_processed],
> > > > -                         nb_pkts - nb_processed, &total_bytes);
> > > > +             ice_fill_tx_hw_ring(xdp_ring, xsk_pool, &descs[nb_pro=
cessed],
> > > > +                                 nb_pkts - nb_processed, &total_by=
tes);
> > > > +             packets =3D nb_pkts;
> > > > +     }
> > > >
> > > > -     ice_set_rs_bit(xdp_ring);
> > > > -     ice_xdp_ring_update_tail(xdp_ring);
> > > > -     ice_update_tx_ring_stats(xdp_ring, nb_pkts, total_bytes);
> > > > +     /* Metadata packets may all have been dropped. */
> > > > +     if (packets) {
> > > > +             ice_set_rs_bit(xdp_ring);
> > > > +             ice_xdp_ring_update_tail(xdp_ring);
> > > > +             ice_update_tx_ring_stats(xdp_ring, packets, total_byt=
es);
> > > > +     }
> > > >
> > > >       if (xsk_uses_need_wakeup(xsk_pool))
> > > >               xsk_set_tx_need_wakeup(xsk_pool);
> > > > @@ -939,12 +1372,7 @@ void ice_xsk_clean_xdp_ring(struct ice_tx_rin=
g *xdp_ring)
> > > >       while (ntc !=3D ntu) {
> > > >               struct ice_tx_buf *tx_buf =3D &xdp_ring->tx_buf[ntc];
> > > >
> > > > -             if (tx_buf->type =3D=3D ICE_TX_BUF_XSK_TX) {
> > > > -                     tx_buf->type =3D ICE_TX_BUF_EMPTY;
> > > > -                     xsk_buff_free(tx_buf->xdp);
> > > > -             } else {
> > > > -                     xsk_frames++;
> > > > -             }
> > > > +             xsk_frames +=3D ice_clean_xsk_buf(xdp_ring, tx_buf);
> > > >
> > > >               ntc++;
> > > >               if (ntc >=3D xdp_ring->count)
> > >
> > > I think we could pull out core enablement for zc uso out of this patc=
h
> > > maybe?
> >
> > What do you mean with "core" here? Core as in AF_XDP core, or
> > preparatory stuff to the ice driver?
>
> I meant xsk core as preceding patch and ice changes here would only play
> in its own mud + make use of introduced api before. This would reduce siz=
e
> of this patch.

Will put it in a separate patch. Bj=C3=B6rn commented on this too.
