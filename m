Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400E606C544
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Iz0GiwcF;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2pme1Sa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86DDF80799;
	Tue,  3 Nov 2026 10:53:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLjYKyRmdjQB; Tue,  3 Nov 2026 10:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 880C1807F5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793703214;
	b=R7073U9usI0ONieTxGf3I48VIwgNRGsnanPvEUd6Ph1C1rIfCAecCKDSiSx7il1+SOc+
	 szm9JxTTqQPmQgPD7JKDPwipmqQ51hTD1JsPIAfyTuVBcNucAPpm+3q+Lb2zgQEMPIXkX
	 B6Rud+DsLY0Om+54Z1h+K13mbojRYst53dxUX5nGlP3fBe7Dr0yIO0p9uFc9R7UQLqxlt
	 oM9eDlg7o6992QL3XDtcIsKbiGK+VMoeZi5rMFwTQuCTwzYN+iSkVaVqBS0s4jxryy+Rd
	 DH8KhuShkXF2aN53Cb4v0hK7QNhlrNiXlbkAOI9a2cdMVTVuOiOnf+Q41e0zrLGSuUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793703214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Qr2V+qHU2UOD6fHIZYRQn7qc2o8VFoSQ9/JvWaW4Sns=;
	b=TsIkU3cF/nCF2iGgxMLs2IgveC6OtLldHFWytg2cftGiq2vy96qq3JT2/4Ykp/wWdBqh
	 BZKY68MpYW5EWjZD3YVdgpXlvUZMH5i+7nekvMvD2COMHIE0Rda+GqOTG4ZSS+hADriuS
	 LScd2b5rxACq0VF+78sM9S3hZ5r6QGR2Yf7k1g2iJ3Ix32idEQpJfkLxrplkz3sboOoFz
	 +sovHzbVNj2av/xhRn2LhQu5vDFhNMddq/4715qttXHRyPIff8uk4ywdH4A06qmcI+POV
	 EkUxGuQwjhJuKiu+Dz5VASamWEbTso17BpGSM5r1jAw2GE+s7ZxCxJ1DgXPIloh8D7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2pme1Sa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793703214;
	bh=Qr2V+qHU2UOD6fHIZYRQn7qc2o8VFoSQ9/JvWaW4Sns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Iz0GiwcF1sQd6PCjRcepehxnUyN0igsMPHPGYLiCqvbu3vrRUl8B49vG7AUCBS/FH
	 xbDtTPCO+4/yLk/Jit9ie/iDWDzEVdQbk6waOkrQzL13S3NHk9BZYVczf4/82LXbDG
	 QHWy5C4Iogs9FgVBKzi7OyQffvzUwc9ZvZCj7kmzQ6rCaIHmmgErtlB2pScg2JU2A5
	 ps2LvWLhuYx+47V/J6TNJGErZa0ppNkD5qgwruKXfpt7/VckD3m5guehzg4xoZVj17
	 KmqYtHqtOSPze0cIL+cnB8Hmp8rbpTPWT35dPo4iajYqgEsZ43cV4XjaYF4zSkKa3+
	 Gi4J6Oj0/5diA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 880C1807F5;
	Tue,  3 Nov 2026 10:53:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78C47235
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A47A806F6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uz6oP0FhdhsZ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6A31080DEE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793703211;
 b=Zegu4umac2oJvtOW2knu6ur0Qz2FTO65Lbcx9OspqfMwUNfSyg/QF25KxkuzrqJOK6cs
 WxYHSylLol0WtrWA0u0U+llqGAV4uj0T+pktCFcmBZ2b2faf5DaBTj/rEP/MmPXHxrg6n
 8de6VA4Rcr6fOlmtKLfZ2oDpw00RO4D35Z4mkhla+qNOKQakPsd3hnxmim1YRBFI3NzIG
 G3kM8XZVr8Yl4KCU8VlUpVU5/r5e1J3ZQPxD0CIIT7+qbpTbTSLmwdwgHeZszs8QG574P
 DlBdvb17O9ICBbO/K0HUpsNO9eZRmrw/DSbTGLZsD15Q+6CWa3AbAYSF61LdgWR7gag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793703211;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=Qr2V+qHU2UOD6fHIZYRQn7qc2o8VFoSQ9/JvWaW4Sns=;
 b=Qir/HEF7DLResItv+fyJ8v23YnL6tZzGN4UQZa1QG1InF4hdkyi52DDZCZqxJnpeP5W/
 gh3AySECA7SV3ijCbe75dHXqYT73WRlUwR6nXtbdtAeAEYaAJrzzBKoTaFVtDQUQeQfhA
 D5DhaIaapCZbLJFF06SolBJytgAjZHY3Au3Oyp2QcPunlKHporc8ju9hXZ8okoY/QffUy
 UFiaRGYGPFGbhWH+maiYEteU9GHQrv/hZr/ylQLXhkl2QlNU0+J98Z00G0dF6As+HMaRB
 4mNI0+gCZay9Kehi96nRc9wZmzHOJatYYSjYgC7EICXR5V3XzDeyTFqR4bRPKxD3Xew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y2pme1Sa; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y2pme1Sa
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A31080DEE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:53:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB19860008;
 Tue,  3 Nov 2026 10:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6CB1F000C1;
 Tue,  3 Nov 2026 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793703209;
 bh=Qr2V+qHU2UOD6fHIZYRQn7qc2o8VFoSQ9/JvWaW4Sns=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y2pme1Saigz5xM05W/qjk8RHMacnp5EQlxtdFCy3bhW2mQGRq1hIM9RIMUy+qayQs
 YtlMZq2bjWR8HEodnV7Nndj/hSGLEfsv0vT4OUdx8nt7KZ3MrELAUo7LpCv8agGapX
 LLkj7Zs4MoRK4Uboz9fuNRZdPGlr2hgOtAF7j1uV6JY3dRe8q19EggANi6M7pus2QS
 OHANOruOJfWEwBSynk/3GCUFOTUWcZF9ZzMTeXgnPziIZJhshFitAXF4oVp4fUCv6C
 tymoP6ZQuj0uu6MMMsBcdKA60S1fxWxd092b55LW3lI/6fGVnQxa2bmhFBa2DKZWbR
 a9054x7uZtwsQ==
Message-ID: <sashiko-outbox-195079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/2] igb: do not let XDP frames span more than
 one Rx buffer
To: "Tjerk Kusters" <tkusters@aweta.nl>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
References: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
 <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:53:29 +0000
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] igb: XDP attach and detach fail at default 1500 MTU in igb_xdp_set=
up()
--

commit 61b7cd576e8dfdc92f82c2f3538eaf2928658b79
Author: Tjerk Kusters <tkusters@aweta.nl>

igb: do not let XDP frames span more than one Rx buffer

This commit limits the maximum receive packet length in RLPML and VMOLR to
adapter->max_frame_size while XDP is enabled so received frames cannot span
multiple Rx buffers. It also accounts for the 16-byte inline Rx timestamp
header (IGB_TS_HDR_LEN) when checking if the frame size fits in igb_rx_bufs=
z()
during XDP setup and MTU changes.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index ce91dda00ec0e..5bf489cd7b066 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2894,11 +2894,13 @@ static int igb_xdp_setup(struct net_device *dev, =
struct netdev_bpf *bpf)
>  	bool running =3D netif_running(dev);
>  	bool need_reset;
> =20
> -	/* verify igb ring attributes are sufficient for XDP */
> +	/* verify igb ring attributes are sufficient for XDP, leaving room
> +	 * for the inline Rx timestamp header
> +	 */
>  	for (i =3D 0; i < adapter->num_rx_queues; i++) {
>  		struct igb_ring *ring =3D adapter->rx_ring[i];
> =20
> -		if (frame_size > igb_rx_bufsz(ring)) {
> +		if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
>  			NL_SET_ERR_MSG_MOD(bpf->extack,
>  					   "The RX buffer size is too small for the frame size");
>  			netdev_warn(dev, "XDP RX buffer size %d is too small for the frame si=
ze %d\n",
> [ ... ]
> @@ -6713,7 +6725,7 @@ static int igb_change_mtu(struct net_device *netdev=
, int new_mtu)
>  		for (i =3D 0; i < adapter->num_rx_queues; i++) {
>  			struct igb_ring *ring =3D adapter->rx_ring[i];
> =20
> -			if (max_frame > igb_rx_bufsz(ring)) {
> +			if (max_frame + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
>  				netdev_warn(adapter->netdev,
>  					    "Requested MTU size is not supported with XDP. Max frame size i=
s %d\n",
>  					    max_frame);

[Severity: High]
Does adding IGB_TS_HDR_LEN to the igb_rx_bufsz(ring) check in
igb_xdp_setup() and igb_change_mtu() break XDP at the default MTU of 1500
on systems with PAGE_SIZE < 8192?

In drivers/net/ethernet/intel/igb/igb.h, the constants are:

    IGB_ETH_PKT_HDR_PAD =3D ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2) =3D 26
    IGB_TS_HDR_LEN =3D 16
    IGB_MAX_FRAME_BUILD_SKB =3D IGB_RXBUFFER_1536 - NET_IP_ALIGN (1536 or 1=
534)

At the default MTU of 1500, frame_size (and adapter->max_frame_size) is
1500 + 26 =3D 1526. When the interface is opened via
igb_open() -> igb_configure() -> igb_configure_rx() -> igb_set_rx_buffer_le=
n():

    set_ring_build_skb_enabled(rx_ring);

#if (PAGE_SIZE < 8192)
    if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
        IGB_2K_TOO_SMALL_WITH_PADDING ||
        rd32(E1000_RCTL) & E1000_RCTL_SBP)
            set_ring_uses_large_buffer(rx_ring);
#endif

Because 1526 <=3D IGB_MAX_FRAME_BUILD_SKB, ring_uses_large_buffer(ring) is
not set while ring_uses_build_skb(ring) is set, so igb_rx_bufsz(ring)
returns IGB_MAX_FRAME_BUILD_SKB (1536 or 1534):

static inline unsigned int igb_rx_bufsz(struct igb_ring *ring)
{
#if (PAGE_SIZE < 8192)
    if (ring_uses_large_buffer(ring))
            return IGB_RXBUFFER_3072;

    if (ring_uses_build_skb(ring))
            return IGB_MAX_FRAME_BUILD_SKB;
#endif
    return IGB_RXBUFFER_2048;
}

When igb_xdp_setup() or igb_change_mtu() then checks:

    if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring))

1526 + 16 =3D 1542 > 1536, causing XDP attach at MTU 1500 to fail with
-EINVAL on a running interface.

Furthermore, because igb_xdp_setup() runs this check even when bpf->prog is
NULL, if an XDP program was attached while the interface was down (when
ring->flags is 0 and igb_rx_bufsz(ring) returns 2048) and the interface is
then brought up at MTU 1500, subsequent attempts to detach or replace the
XDP program at MTU 1500 will also fail with -EINVAL.

Also, in 2 KiB build_skb mode, igb_skb_pad() computes the buffer offset as
SKB_WITH_OVERHEAD(IGB_RXBUFFER_2048) - IGB_MAX_FRAME_BUILD_SKB, leaving
only IGB_MAX_FRAME_BUILD_SKB (1536) bytes before skb_shared_info. If a
1526-byte frame arrives with a 16-byte inline timestamp, wouldn't the 1542
bytes written by the DMA engine overflow into skb_shared_info unless 3 KiB
buffers are selected or IGB_MAX_FRAME_BUILD_SKB accounts for
IGB_TS_HDR_LEN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-igb-rx-ts-=
fix-v4-0-8785124c5d23@aweta.nl?part=3D1
