Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B513606A320
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=PPDI1qTS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TT8Vgo5v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65C8660668;
	Fri, 20 Nov 2026 16:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CBF00uaxqwJa; Fri, 20 Nov 2026 16:54:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C7C760698
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795193667;
	b=DK4a4p2LImsUq1ThRHcN4cI137nqcMYg3UPKLIkE3n81JgDHbSWNooR3KgVC72wMkhBH
	 IxLYJbF+WAjNvyClzA873Lhpo6+P6gg86rtV4XMaab8qWB6qHSJSdw72/P0UI3H3hABVJ
	 o0AsojF4VPbTLpURk7JBCqfvClHaJtvlt9Pz1VqYgBFe0pVO1JacKrvahwwh9iIU2/3oy
	 GAES3ADEEu49RCsRAZOelsB4fZnQeudBIcl2JiRT7e7M3P1ikTG0ZaxcGaimPzQ3nUvRP
	 DzPeToos5zOOBez5QvaYIUBAB8VzMlTNQC5sCgZGlfu/Vds1W6wm1TWjhmqGi7eoCKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795193667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jHuT5uo1/jOEvqSbSDz7zbS9tc74oK9BVcDB9wVvyI0=;
	b=tQg7QB31KXIQD+HFvYrJKq/gA8SRtjWvc+grcFgplZ+wOEQGSrBYmvSSLA8dh2KKVX6g
	 /LfDcifaYqqajfCGVt7jYjWnDaurxAlmqqC8yjo3ZekFCcFIK5F7ULuy+Xx2wbMItXQ3Q
	 o3f3vYsG4vD+SJuhczFqrmfrNy2Q95ucUI1Jfcxixs22PzzLg0a8MeamRLbJd2iuch9l4
	 tmhyEy2KQNjOOFXIIqTupuzmQKZFuOSrA7K+/BwbW7S3kwVarrdufqac6XopaFstAvJsY
	 nqVHC0FsCdF52o3mrXijCUc5XnJ/HIy5+s9/26P11XtVrRPaCIrl6yfDEL146N5oP6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795193667;
	bh=jHuT5uo1/jOEvqSbSDz7zbS9tc74oK9BVcDB9wVvyI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=PPDI1qTSANrOaGo0qoJ8SEez+pKXvGuXw9qbvXuX+pcKZja+kCbmBpMW1dsNA+Xze
	 aBr4Cgwg5QtI8vUeZrIwzj/rbDQz0AtUn3L4vjKGcrxA2uJQjxPsOeHVP6w5yyUss8
	 HtKIgoPSqyR5pmeru5q9tjYJLu3ntn9ejgWRoHTuP/knN85kyQH3JKtGRAqLJ51PuK
	 d7bignSyPSzrvIhvuuZtvTEnT6BGMpTnHmEx2aGVTFIy4uljapaXmUfWnRhwtstxME
	 wailv4bGfM4z+H0EFoXa569GuAPppNoCqbOFeY4rtSSCOOPfeyVK0/JbjhtnUWbk84
	 T09+LONdhF7XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C7C760698;
	Fri, 20 Nov 2026 16:54:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 518F4E52
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 16:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 436B94070E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 16:54:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rgcs3wtumT2T for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 16:54:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5285A406F3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TT8Vgo5v
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5285A406F3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 16:54:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 250DF4050C;
 Fri, 20 Nov 2026 16:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D566B1F000CF;
 Fri, 20 Nov 2026 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795193664;
 bh=jHuT5uo1/jOEvqSbSDz7zbS9tc74oK9BVcDB9wVvyI0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TT8Vgo5vhe7bRdsbGbKTaofOh2OIQGRul4K7vdJbEUiffkyPqEA9Y7CGn80YztRYo
 dO2Iy95yJTmoFsfh3Dbheb0ZwNS/gccABgb2xEaXXUetW79Vbb/RDwwafRbhrGcCSH
 K2z9iQV2M5Ia6i8CYb7mftopwDHa6oWO2Btvpi0MOMz9Ua/B2Knaf3TvsUhcR4krh4
 iX5WGWED7tUfZ46sLZ9uIfTFVU+q1+je5WX5oSJmFE+c8JFs+AETSSO1j6e9hjjnXd
 rPTEzy3XJNcMW1MU+LbUD+j4MLRN/xJiZCbIzMMXDbbB9j38FugwajiEPjKakx+hkw
 qMSQqPn82mefA==
Message-ID: <sashiko-outbox-225609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/5] xsk: ice: add USO zero-copy support
To: "Magnus Karlsson" <magnus.karlsson@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261119165340.1071525-4-magnus.karlsson@intel.com>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-4-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 16:54:23 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] ice: xsk: missing descriptor count check in ice_xsk_bufs_fit()
  and USO parse
- [High] ice: xsk: XDP ring mismatch in ice_tx_xsk_pool() frees active
  USO DMA slots
--

commit 68f04de5ef6583147ab705c136de44a0ff2a4e13
Author: Magnus Karlsson <magnus.karlsson@intel.com>

xsk: ice: add USO zero-copy support

This commit adds AF_XDP zero-copy UDP Segmentation Offload (USO) helpers to
the XSK core and implements zero-copy USO in the ice driver using per-ring
DMA-mapped header slots.

> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/=
intel/ice/ice.h
> index 432da05c48c08..e19929b37e110 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -833,16 +833,24 @@ static inline void ice_rx_xsk_pool(struct ice_rx_ri=
ng *ring)
>   * carries a pointer to one of these XDP rings for its own purposes, suc=
h as
>   * handling XDP_TX action, therefore we can piggyback here on the
>   * rx_ring->xdp_ring assignment that was done during XDP rings initializ=
ation.
> + * The ring must be stopped, as its USO header slots are matched to the =
pool.
> + * If they cannot be allocated, the ring keeps the pool without USO.
>   */
>  static inline void ice_tx_xsk_pool(struct ice_vsi *vsi, u16 qid)
>  {
> +	struct xsk_buff_pool *pool;
>  	struct ice_tx_ring *ring;
> =20
>  	ring =3D vsi->rx_rings[qid]->xdp_ring;
>  	if (!ring)
>  		return;
> =20
> -	WRITE_ONCE(ring->xsk_pool, ice_get_xp_from_qid(vsi, qid));
> +	pool =3D ice_get_xp_from_qid(vsi, qid);
> +	if (ice_xsk_cfg_uso_slots(ring, pool))
> +		netdev_warn(vsi->netdev,
> +			    "Failed to allocate USO header buffers, USO requests on queue %u =
are ignored\n",
> +			    qid);
> +	WRITE_ONCE(ring->xsk_pool, pool);
>  }

[Severity: High]
Can ice_tx_xsk_pool() free ring->xsk_uso_pages while
vsi->rx_rings[qid]->xdp_ring is still running with in-flight USO
descriptors?

When vsi->num_q_vectors < vsi->num_xdp_txq (for example after reducing
combined queues with ethtool -L, or when fewer CPUs are online than
possible), ice_map_xdp_rings() maps multiple XDP rings per vector and
vsi->rx_rings[qid]->xdp_ring is not vsi->xdp_rings[qid].  On pool teardown,
ice_xsk_pool_setup() calls ice_qp_dis() and ice_qp_ena(), but ice_qp_dis()
and ice_qp_clean_rings() stop and clean vsi->xdp_rings[qid]:

drivers/net/ethernet/intel/ice/ice_base.c:ice_qp_clean_rings() {
	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
	if (vsi->xdp_rings)
		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
}

ice_qp_ena() then calls ice_tx_xsk_pool() -> ice_xsk_cfg_uso_slots(ring,
NULL) -> ice_xsk_free_uso_slots() on vsi->rx_rings[qid]->xdp_ring while
that ring still has uncleaned ICE_TX_BUF_XSK_USO descriptors in flight.
Aside from unmapping the DMA pages while the NIC may still read them,
ice_xsk_free_uso_slots() zeroes ring->xsk_uso_slots_per_page and clears
ring->xsk_uso_pages, so the next completion in ice_clean_xsk_buf() ->
ice_xsk_uso_slot() divides by zero and dereferences NULL.

Also, if a pool is disabled while ICE_VSI_DOWN is set,
ice_xsk_pool_disable() returns without freeing the USO header slots that
ice_xsk_pool_enable() allocated on vsi->rx_rings[qid]->xdp_ring.

> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ether=
net/intel/ice/ice_xsk.c
> index 0c1ce3e86a45b..7fa1127480b66 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c

[ ... ]

> @@ -791,6 +946,272 @@ static void ice_fill_tx_hw_ring(struct ice_tx_ring =
*xdp_ring,
>  		ice_xmit_pkt(xdp_ring, xsk_pool, &descs[i], total_bytes);
>  }
> =20

[ ... ]

> +/* A buffer longer than one data descriptor is split, so a packet withou=
t USO
> + * can then need more data descriptors than the hardware allows.
> + */
> +static bool ice_xsk_bufs_fit(const struct xsk_buff_pool *pool,
> +			     const struct xdp_desc *descs, u32 nr)
> +{
> +	u32 buffers =3D 0, i;
> +
> +	if (likely(pool->chunk_size <=3D ICE_MAX_DATA_PER_TXD_ALIGNED))
> +		return true;
> +	for (i =3D 0; i < nr; i++)
> +		buffers +=3D DIV_ROUND_UP(descs[i].len,
> +					ICE_MAX_DATA_PER_TXD_ALIGNED);
> +	return buffers <=3D ICE_MAX_BUF_TXD;
> +}

[Severity: High]
Does ice_xsk_bufs_fit() allow a non-USO packet with more than
ICE_MAX_BUF_TXD descriptors through when pool->chunk_size <=3D
ICE_MAX_DATA_PER_TXD_ALIGNED?

When multiple sockets share a UMEM without XDP_UMEM_SG_FLAG,
xsk_tx_peek_release_desc_batch() uses xsk_tx_peek_release_fallback(), which
peeks descriptors via xsk_tx_peek_desc() without enforcing
pool->xdp_zc_max_segs.  In ice_xmit_zc_metadata(), a multi-descriptor chain
with XDP_PKT_CONTD set can therefore accumulate nr > ICE_MAX_BUF_TXD
descriptors into one packet.  With standard 2K or 4K chunks,
ice_xsk_bufs_fit() returns true without checking nr <=3D ICE_MAX_BUF_TXD, a=
nd
ice_xsk_xmit_descs() emits more than 8 hardware descriptors for a single
unsegmented packet, triggering an MDD event on the Tx queue.

For USO packets on that same fallback path, neither xsk_tx_uso_parse() nor
ice_xsk_uso_fits() checks nr <=3D pool->xdp_zc_max_segs either (since
ice_xsk_uso_fits() resets buffers to 1 at each segment boundary).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119165340.1071=
525-1-magnus.karlsson@intel.com?part=3D3
