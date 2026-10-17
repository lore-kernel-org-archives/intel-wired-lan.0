Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1195CCF2C4
	for <intel-wired-lan@archiver.kernel.org>; Sat, 17 Oct 2026 13:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C3876062D;
	Sat, 17 Oct 2026 13:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omY8mPdRufwv; Sat, 17 Oct 2026 13:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9A45D60640
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242499;
	b=YO8mCBIDpj6wzivkFqwfRYp2Q0+uPyCVWphR7Me/CF3i4+eek7eXEM6vmG7ayMf83NiH
	 6z/4cOM+Q6lEVtNab3b+yaWItH03i4V7/qzKRBRrsmHldHGJxzQRrm9RvBXEIc7s9ww2I
	 IOhwzUUjMa13cVp2EDiFrb/042Cv7V+qI0JifGCmkEed+pW68cY0/fZ/eSM6CIgRi52HQ
	 zlc4V8XBn9m4xMfEh1KjlVh+GT9eOkvP+qOeWtv4BuFeLhk5pc74MC1+o+i0w2QOJP0Co
	 UFdLYd7olTQHCZVujM8kNb9bxZcIn0XuSwcGLxy5ObgxATf7f+03vJbaEqV2VpMSPhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=L2V2SByTHcg/cn8dvb1Y8mEdGphz2UCq7xAMykSmshI=;
	b=HFmlTh/MtoZgk7C1TgviMgO9U5O+rLZqWuOixwLNQlRq8nhuvZqmjpeWFhGdGpn1Vwvn
	 On6Wlj51v4Fx2B0JSEsj94Kaiy77fL7J2F4hRMTtoi4zQJUql68F+qdSGofY5mu9mg75I
	 nU0G1+zZ8G54k2hQV62GPQamuV+F9RhRUMK23lmnzI2Zk0RFbRwQwVaKIcECH+lI4NAg5
	 urAReikeWsIvdwf1exH88twzRtn3LHcIICSLo199jtbQRnbavxY0XmwQiqoleMCZSUyxh
	 7jMh2Nq9QhgoSIT2OnbM23jH2VtnXjPfks31Q7KZ9HZ0lPKzTt5ymYvI0LgZhdKu86w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgJZHiRU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792242499;
	bh=L2V2SByTHcg/cn8dvb1Y8mEdGphz2UCq7xAMykSmshI=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ShhHt9BysU9GI1IdgrZsZj/4cO/10PnNfR8o4K/32i3ndGNrIkQLgIYra7undT5ct
	 lj7OqoZftk9y/dyIwVH87JnVTEWW03XcLoWuw+IGgo/ISr5uv+QplXIf+7Pzh8eeOk
	 LtKqxtY8V/oZC+oLfhgzEQIhG5sbxkXwqSn7L4lT3V6mhLAMrh0r+ZRfiVMvsPxOB0
	 CP36C0qfqxfQZ/D0jkzoRsdCjF/PQWl4f1OhJyHOHBThToNAOKpDfguyaZVZ1QhEts
	 kVSR+7+k2rAR97bVXpGlAReugi8fXRBxxRvbE8qcx8ujeQQyO79O1epRBaBtMmAdW6
	 vXR3wrs+PpaSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A45D60640;
	Sat, 17 Oct 2026 13:08:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EEEC61
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 13:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D93A760640
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 13:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mviG0LbKfTDd for <intel-wired-lan@lists.osuosl.org>;
 Sat, 17 Oct 2026 13:08:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF5D26062D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792242497;
 b=SNmGPjv0B9JZQUuyOEa7KdED/gJWe7Am8P5OEVgKFDcKfnX4G3wHbeA1wymslwibxuFi
 vQ1J3Bv99fiJfKTFLBk1sdMk1C3b2GfwV86/7kGncbzRM/kDFZyqO7u8v417k8QLBCL7Y
 wM3qyOK+8tE2sLqhEiO2BfnmiwhEVSz3MViRpXzfk+9UavodptGKWMUJKu7TKGvmxG+ne
 fRK8f5N2VX2WMIq9WE7EjqorMG2i2OFVR/7ZVQu167KypuVEv10+ywQ1XWKPK+u3xbkCx
 FBDmkcZ9+HyBjTq/r7q91Tlbti5cpGQGbMRZVlo9AkizfgIWDJQlSR/el2njn5heV1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792242497;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=L2V2SByTHcg/cn8dvb1Y8mEdGphz2UCq7xAMykSmshI=;
 b=kyKbpDXL9e8cgEFTu33jjFGcCSWM20JmGmlAV3HyuNeThYSdLLfdwwYQnm3qzpjcCNiu
 g+u/DLiZPEXOUqQTV+3VJmAKhT0Lm3ZBtiTYuyYXC0x5xZ9aZcBtNASMOBGSr49oaDPS9
 yDBIHZNmLaKo5IqiKXWGR/FxXcdEPFUx3/7IgKmY0NAlskB0P1JDa39wngmycJsc5qYRq
 j0wuQI/6GZu5BPeICczuQM5ghx1MmwvpS3r+CYRL/kpnrdUTX8irQkege6c8C5xcDg3bo
 BlXeyAgrIB/bWLups+Soq3rleeEXuzriZ98nq8UmJ2tnNudZiPJoEtyZJAXtEjBbZ1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hgJZHiRU; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hgJZHiRU
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF5D26062D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 13:08:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3A9B43730;
 Sat, 17 Oct 2026 13:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31511F000C4;
 Sat, 17 Oct 2026 13:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792242495;
 bh=L2V2SByTHcg/cn8dvb1Y8mEdGphz2UCq7xAMykSmshI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=hgJZHiRUxQXcw2kdI/9eTjXE/1pP/qg3fB709B6iHpoUWgSv69dXrvBrGVSULZ5Bt
 vHiUNJ+/KgZTSaWCUCHjblTgjMD59zgPF5NZ0UJZj5BIrPplA3P5WMr8r8YgjT65+G
 l3injKe8lmL9b10FV98lYEmzbxnPl3Rd62kBwxIQTgvYbT5IchX4gwfk4Fl6rYZln+
 7Yq4j51+GCzfTca3DBeudGEdxRza2F1FrUK1lTXQB7PiD2CNkU1nzMjQOOhZ9NQa/0
 pyhqSE20Bm2uMXpsR12DZ/E7MGD7LZYpajoDi9cQecSL7PWbrPmG7bYgo7o6vXnUqq
 JUwC66D6xWtAA==
Message-ID: <sashiko-outbox-175513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
To: "Vincent Choiniere" <choiniere.vincent@hydroquebec.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
References: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 13:08:15 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net/ice: TOCTOU race in ice_tx_hang_reporter_dump() causing SKB UAF
- [High] ice: out-of-bounds access in ice_tx_hang_reporter_dump() during ri=
ng resize
- [High] devlink: NULL pointer deref in ice_tx_hang_reporter_dump on teardo=
wn
--

commit 9b2375ee849517a745f8e8f71365535e40788bc1
Author: Vincent Choiniere <choiniere.vincent@hydroquebec.com>

ice: fix Tx hang dump using stale tx_buf[0].skb

This commit updates the ice devlink health reporter to read the SKB from the
Tx buffer at the next_to_clean index instead of slot 0. It also adds a type
check to ensure the buffer contains an SKB before dumping it.

Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktion=
ov@intel.com/

> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/ne=
t/ethernet/intel/ice/devlink/health.c
> index 8e9a8a8178d48..059859c36dfb2 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -390,12 +390,15 @@ static int ice_tx_hang_reporter_dump(struct devlink=
_health_reporter *reporter,
>  				     struct netlink_ext_ack *extack)
>  {
>  	struct ice_tx_hang_event *event =3D priv_ctx;
> -	struct sk_buff *skb;
> +	struct sk_buff *skb =3D NULL;
> +	struct ice_tx_buf *tx_buf;
> =20
>  	if (!event)
>  		return 0;
> =20
> -	skb =3D event->tx_ring->tx_buf->skb;
> +	tx_buf =3D &event->tx_ring->tx_buf[event->next_to_clean];

[Severity: High]
Can event->tx_ring->tx_buf be NULL here?

If the interface is concurrently brought down, ice_free_tx_ring() frees the
tx_buf array and sets tx_ring->tx_buf to NULL.

Computing the address with the index offset and then evaluating tx_buf->type
below would trigger a page fault.

[Severity: High]
Could an out-of-bounds access occur if the ring is concurrently resized?

If a user runs ethtool -G to shrink the ring:

CPU1 (ethtool)
ice_set_ringparam()
    ice_free_tx_ring(vsi->tx_rings[i]);
    *vsi->tx_rings[i] =3D tx_rings[i];

CPU2 (Workqueue)
ice_tx_hang_reporter_dump()
    tx_buf =3D &event->tx_ring->tx_buf[event->next_to_clean];

Since event->next_to_clean is cached from the timeout event, couldn't it
exceed the bounds of the newly allocated, smaller tx_buf array?

> +	if (tx_buf->type =3D=3D ICE_TX_BUF_SKB)
> +		skb =3D tx_buf->skb;

[Severity: High]
Could this TOCTOU race happen with NAPI?

If this dump runs in a workqueue without disabling NAPI or taking a Tx queue
lock:

CPU1 (NAPI)
ice_clean_tx_irq()
    napi_consume_skb(tx_buf->skb, napi_budget);
    ...
    tx_buf->type =3D ICE_TX_BUF_EMPTY;

CPU2 (Workqueue)
ice_tx_hang_reporter_dump()
    if (tx_buf->type =3D=3D ICE_TX_BUF_SKB)
        skb =3D tx_buf->skb;
    ...
    if (skb)
        devlink_fmsg_dump_skb(fmsg, skb);

If CPU1 frees the SKB after CPU2 performs the type check, doesn't
devlink_fmsg_dump_skb() end up dereferencing a freed pointer?

>  	devlink_fmsg_obj_nest_start(fmsg);
>  	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
>  	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);

[ ... ]

> @@ -409,7 +412,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_h=
ealth_reporter *reporter,
>  	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
>  	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
>  				     event->tx_ring->count * sizeof(struct ice_tx_desc));

[Severity: High]
Could event->tx_ring->desc also be NULL here if the ring was concurrently
freed?

Since ice_free_tx_ring() doesn't clear tx_ring->count, wouldn't
devlink_fmsg_binary_pair_put() attempt to copy from a NULL desc pointer?

> -	devlink_fmsg_dump_skb(fmsg, skb);
> +	if (skb)
> +		devlink_fmsg_dump_skb(fmsg, skb);
>  	devlink_fmsg_obj_nest_end(fmsg);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-ice-tx-han=
g-dump-v1-1-3df0f5979a51@hydroquebec.com?part=3D1
