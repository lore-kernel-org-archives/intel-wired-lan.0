Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D448606A324
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9ANk4h4N;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdXlvmxq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAFBC6068A;
	Thu, 19 Nov 2026 14:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rxq97ZEotdPC; Thu, 19 Nov 2026 14:59:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E07ED6069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795100384;
	b=NYwTo+/PWiJHF0XJGDovb0dswXfqHcV+xjGGGdTMcL1zLd562G7EV7FOLiiADDfXOoaa
	 obPpx0tu14NcjnUbDTPyIBcBhgP1H3X7o70WvnbpgWDVWc0rLo5cwOW75WOPz1OQCYXcD
	 hSxFMXw2Ih35m/edIHEkTLhE0UWIu7yY9mEmnZSneuAeNnJwJWNrtajqVqu9lHLbUMOn7
	 wL7JMP/3y1Zy5GpHMLv68dJ6Rt1pO6dn52keyDC6ZTmL+tOyha8b8TV690vDGGGqhnQGZ
	 bhQpC6RxpI63Geibkb002jtueMqYKOi7jFy6UpzA5m6P2g8QkSxI6AWXoiBacewHPhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795100384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=3TBizdxQySqNH7i18xvqIkRXWVHyEW1zVHezDmk2LYg=;
	b=mYJ2sPcnESEBLHryYX1MPQ8hfWE3odgfHhakRwCKZ3fHQO+R3MtJFgCmxlE5xG9NM7PT
	 Q6uuFimNAHwjGZSodMU3VKIQe3Wh0Jia883JDphI3VyiAm4RkI4qZlfTH94Bv/0iKabmm
	 6Pff30JmvS1lEKtKb106v+HsAyZEMu9sBG1CaDDacIFtaniWakM+mmonV4LXWGoe9gI7u
	 iCC0ll2fj9FbE/AsA2CFHys0LR5I3hwz6DZ8jJ9vsMHCtxWULqW2R4xVEF5VbdpwQWUch
	 9HzZPMBwRhnqpenX6I7FyZfw8m4aeAKZCuryNEFpfUw9GdHR1fWRWApxLQdtjHBbi4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdXlvmxq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795100383;
	bh=3TBizdxQySqNH7i18xvqIkRXWVHyEW1zVHezDmk2LYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=9ANk4h4NykEo1hFQOMLEyJJLExVeYWfhuU2LRsuQAgGMOn3WLo9ybcseHwk+oeeE/
	 D7zzNatNzlZyDuzyLPMxneIn4K5qPqfY6HzMoH6C5bavMAZ04nId1WJDUFeW9v193i
	 TlBVrzbmKSufR3o/PyGq8mQ1wgNKTkoZXqJrc24q0PdFQuPPfGbnMakmO9wlI5CXK7
	 OSU/LdpG4p5nuouBtqvd/sqKAZOnvEWRrWLtHHaoDGCQTo65Rp+dnTb50uLNNCiyCU
	 lRx7cpjkhR3RRECtf4/oy8u2GGG7b1nhW5blHCRZw1/q76DKB5E8F+eOJoJYMlSCM0
	 98q1Z5Gye4rPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E07ED6069A;
	Thu, 19 Nov 2026 14:59:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C58C1C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70D8F6069A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1KWIWajnoEPw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:59:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 77BC56068A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NdXlvmxq
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77BC56068A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:59:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B019543CBD;
 Thu, 19 Nov 2026 14:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A14B1F000C4;
 Thu, 19 Nov 2026 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795100380;
 bh=3TBizdxQySqNH7i18xvqIkRXWVHyEW1zVHezDmk2LYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NdXlvmxqzcBZI3IBuJ6B6nP5nNxL2hQURbb21V631T04LPqcjj+La3MHglTAGoiaA
 ogL6F2bu+5+WWkQUVbmyPF7e6ADt3/8yvJEADzVcLcK6EMQb0QPAd5wJDWxodvantz
 GSLne8v2yyzpXv3S6c8k0JZIYTBHC22xrCS5KJuGRp6WDLi6rQWwAvbeNl0uG01mXX
 QEJ4pUFgb1RDGBcmnTm+qlOseRdAcAM/ibZdbu5OEmrJnyqqFDi1byc1GcADi9P7Sg
 ChwU+OA4qKLvaDXsvZwrAllkVqHu/sxuqRDYc/T5EEnJ3pyDlMFhHvH37xbaoa0DXs
 6w/fW2kVH8KMA==
Message-ID: <sashiko-outbox-223332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/5] xsk: ice: add USO zero-copy support
To: "Magnus Karlsson" <magnus.karlsson@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261119141032.1070446-4-magnus.karlsson@intel.com>
References: <20261119141032.1070446-1-magnus.karlsson@intel.com>
 <20261119141032.1070446-4-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:59:39 +0000
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

commit fb6d44af668d56b22c97560cb76b6bdaca838144
Author: Magnus Karlsson <magnus.karlsson@intel.com>

xsk: ice: add USO zero-copy support

This commit adds UDP Segmentation Offload (USO) support for AF_XDP
zero-copy transmission and implements it in the ice driver using per-ring
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
Can ice_tx_xsk_pool() free ring->xsk_uso_pages while the ring is still
active and holds in-flight ICE_TX_BUF_XSK_USO descriptors?

When a queue vector has more than one XDP ring (vsi->num_q_vectors <
vsi->num_xdp_txq, for example after reducing queues with ethtool -L),
ice_map_xdp_rings() prepends multiple XDP rings to q_vector->tx, so
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
NULL) -> ice_xsk_free_uso_slots() on the unstopped
vsi->rx_rings[qid]->xdp_ring.  This frees the noncoherent DMA pages while
hardware is still transmitting from them, and zeroes
ring->xsk_uso_slots_per_page and ring->xsk_uso_pages so the next
ice_clean_xsk_buf() -> ice_xsk_uso_slot() divides by zero and dereferences
NULL.

Also, when a pool is disabled while the VSI is down, ice_xsk_pool_setup()
skips ice_qp_ena(), and ice_xsk_pool_disable() does not free the USO slots
that ice_xsk_pool_enable() allocated on vsi->rx_rings[qid]->xdp_ring.

> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ether=
net/intel/ice/ice_xsk.c
> index 0c1ce3e86a45b..7fa1127480b66 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
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
Can a multi-descriptor packet on the shared-UMEM fallback path bypass the
ICE_MAX_BUF_TXD limit here?

When multiple sockets share a UMEM without XDP_UMEM_SG_FLAG,
xsk_tx_peek_release_desc_batch() falls back to
xsk_tx_peek_release_fallback(), which peeks descriptors through
xsk_tx_peek_desc() without enforcing pool->xdp_zc_max_segs on
XDP_PKT_CONTD chains.  ice_xmit_zc_metadata() gathers up to count
descriptors into one packet of nr descriptors.  When pool->chunk_size <=3D
ICE_MAX_DATA_PER_TXD_ALIGNED, ice_xsk_bufs_fit() returns true without
checking nr <=3D ICE_MAX_BUF_TXD, so ice_xsk_xmit_descs() emits more than 8
data descriptors for a single non-USO packet and triggers a hardware MDD
event on the Tx queue.

For USO packets on the same fallback path, neither xsk_tx_uso_parse() nor
ice_xsk_uso_fits() checks nr <=3D pool->xdp_zc_max_segs (ice_xsk_uso_fits()
resets buffers =3D 1 at each segment boundary), allowing a USO packet to
exceed xdp-zc-max-segs descriptors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119141032.1070=
446-1-magnus.karlsson@intel.com?part=3D3
