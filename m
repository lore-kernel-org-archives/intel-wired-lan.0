Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDD606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vIag8bqV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs/mCGaT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 095A0809CA;
	Mon, 23 Nov 2026 11:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bb3-_4KcF4Zz; Mon, 23 Nov 2026 11:59:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C64C809CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795435152;
	b=tK0BNGjwvz8Rskw2U7CphBjHTqBBTQkutWSm8meO29QWC0F7aoH6PzpDuLTdqwbTxp/B
	 Wb5rU5x3aLw/aJ0kcgdiajeACMUy+h2ESb71DwA+gREVZKsBX1uiYTYmvK1Gi7mRMzm0R
	 auAtLjlZyi0kCWk307CD/f4tDffNcdhbzPb7vk/d6bhWoRRbLYlkZiV8ip/Vne11LWWHQ
	 nbGgVdA2Rt40XxbKOts8GuCcGSvVk1BC7h/qCC+gbdi91wRIKuXci392vKDDObC+t8ixd
	 2p5zSPLhMdtlRCQhO7OMaQqWhi/FSwGwmkd0TuyKondyPR3PoQQ7lwV+fIoBOMcCEnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795435152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sf4JJJGBV0EyT4t00qNZQoxRzVlWI1dxPYmLnfaYzGo=;
	b=m2CJj7ymjPxYXWBZE9l/hHuDtrqPfeUcNH199p/ATXMxlqvYLltVAyVkGt70Ada2mLd4
	 Ol9EoC6TUVRO7cCxOubxI2pF85lw7W6kiRY22r2OiHKf1VZoKxVaa+2nOy5jUiODsZEB4
	 tmNQ8PadApfhoYOukjxr+u54nteu20xON9MBKNg4ZhySwQ1X2oYcOXZ9SvMvguuubGQDh
	 uYSkMy4PVSqQmXb5j5qLo1c+AmsEY5DSlvc1CqnVccoQZYw/cDzmoUa3HULNybppiNcd8
	 WYkAFw+Dmw2n4SjbVllRnvrOlpNn+grfv9MrV5/zBdMJ0+n0GkK4SwAENjdIp25LQzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vs/mCGaT";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795435152;
	bh=Sf4JJJGBV0EyT4t00qNZQoxRzVlWI1dxPYmLnfaYzGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vIag8bqVzMWwy51eshkYu42NoKC5CedDPKW8KlDgobnVJuzcoihBQg5JeRk6dkefT
	 NXGymS5A1TqKnt6zdJmrW0AieLTw0IU9eXpviC9O2SyjNv+jeUJYXv9rfjguw4sxZ6
	 pqbV42F1YaRahP1P0RqDEA6rYHEO4RH16sA/saRGPxVRpme7xTh6C8n9k1cmLi/QhG
	 Ab8GL3GXbAustMj80CGq7nmmykvwFUV1olvtGbyID2XZy7DAPQjbKiCZbyylkumz6Q
	 76AXDzImR4pQhk4HFyMmhUF45mT/fxltYJe3sxR5mWlb+LxZFaAUuFd8ulh/vLaZsB
	 4r+8BVzh78WJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C64C809CE;
	Mon, 23 Nov 2026 11:59:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEF81759
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 11:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94CB8809CE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 11:59:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1nq6L0nKg_m for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 11:59:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03311809CA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=bjorn@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Vs/mCGaT
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03311809CA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 11:59:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EA37E41A41;
 Mon, 23 Nov 2026 11:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AFE1F000C4;
 Mon, 23 Nov 2026 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795435147;
 bh=Sf4JJJGBV0EyT4t00qNZQoxRzVlWI1dxPYmLnfaYzGo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Vs/mCGaTGkJpPGx0uRpe8gfEdkNxiacZpBgrWmSxhGehKbk50ZswGlQTn3jV78lvH
 3MFVGU+IYzCqD5hS+IvM3uFgPVW7FSqR1DHd77B477CP0ZsuDIjQZSZCBMr23nSGxC
 biO6SDmvLY1wn08f/XmHRsX7WanHTYvZ3fK4O0+Zwx+Hs0PNIkd4JdKEWarGSjfunJ
 +WRzQ2ku2Ccy+vgJpoRDpMb8CeuGKAgxwTv7V2dREJyTdcUGsgVckpFH7SldLG767d
 psSCRYo45wzde3q0oLVxvCfxCL0YxTbDe/S1xF4NCjMeKqeKmrDgTnz2WSXiwHsbAd
 c52hfOb5HGO3Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 1/5] xsk: add USO support for skb path
In-Reply-To: <20261119165340.1071525-2-magnus.karlsson@intel.com>
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-2-magnus.karlsson@intel.com>
Date: Mon, 23 Nov 2026 12:59:03 +0100
Message-ID: <877bi321yw.fsf@all.your.base.are.belong.to.us>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Magnus Karlsson <magnus.karlsson@intel.com> writes:

> diff --git a/net/xdp/Makefile b/net/xdp/Makefile
> index 30cdc4315f42..b6109e0e5547 100644
> --- a/net/xdp/Makefile
> +++ b/net/xdp/Makefile
> @@ -986,12 +990,62 @@ static void xsk_drop_skb(struct sk_buff *skb)
>  	xs->skb =3D NULL;
>  }
>=20=20
> +static int xsk_skb_uso(struct sk_buff *skb)
> +{
> +	struct xsk_tx_uso_info uso =3D {
> +		.metadata.request =3D {
> +			.gso_size =3D skb_shinfo(skb)->gso_size,
> +			.csum_start =3D skb_transport_offset(skb),
> +			.network_offset =3D skb_network_offset(skb),
> +		},
> +		.header_len =3D skb_transport_offset(skb) + sizeof(struct udphdr),
> +		.len =3D skb->len,
> +	};
> +	int depth, err;
> +
> +	/* Best effort: a bond or team device can change type while the pool
> +	 * is bound, also after this check.
> +	 */

What would be the effect of that? Would it make sense to be more
restrictive?

> @@ -999,18 +1053,43 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>=20=20
>  	meta =3D buffer - pool->tx_metadata_len;
>  	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
> -		return -EINVAL;
> +		goto err;
> +
> +	if (flags & XDP_TXMD_FLAGS_USO) {
> +		u16 nhoff =3D READ_ONCE(meta->request.network_offset);
> +		u16 offset =3D READ_ONCE(meta->request.csum_offset);
> +		u16 thoff =3D READ_ONCE(meta->request.csum_start);
> +		u16 size =3D READ_ONCE(meta->request.gso_size);

Instead of all these READ_ONCE, maybe snapshot (as in patch 3) here as
well?

> @@ -1021,6 +1100,9 @@ static int xsk_skb_metadata(struct sk_buff *skb, vo=
id *buffer,
>  	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
>=20=20
>  	return 0;
> +
> +err:
> +	return flags & XDP_TXMD_FLAGS_USO ? -EOVERFLOW : err;

Seems error prone? Better to set the proper error further up, or am I
missing something?


Bj=C3=B6rn
