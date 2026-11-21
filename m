Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EC606A33C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CwD46cQ9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dust6dA8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E2626063A;
	Sat, 21 Nov 2026 11:11:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8xijuIjHrVZ; Sat, 21 Nov 2026 11:11:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 75C0C60666
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795259479;
	b=PXNZH0RIrhIfldgeJAIfkIcuOhTspTaSpHkH+0WTh5GobVfiGLmT6Cv9rRao1fo8w1ci
	 dFaSfbpYu/wefUkJukjmvLrzWhNNsedCwXFU2wgDtZBmrO48EwckFcUB6q1oTeteX8Pms
	 Yoyrnlv1ea6oyb1+Xawv0OgJ6aRY433uN/y1l0xjMGX9xtF7lIG7bc4kjDc5fd1QV3Kk0
	 x4+0V6xP8q8zaFoUkvGbly5fUFlG9Lljp4gqPnlmSN9C93ctwYMWO9XVtDJH0GIvvMVcI
	 XL0g7Msk5dcs2dVCYT2i+/gb/84g0AAxK7tAO29EpT1nB7Wv6OjD8XzX01uHkE8zuFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795259479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=cK3JihZerztUyBM2JSM9EgYoPbV4Tqmf9dDJvzkXLF0=;
	b=B+oS/i5V+MQY6f4PzvoutJub64RgEd7HEddszD6XzhO8lw5Jk32buEkeplkm4wGI9zKh
	 U5mnCeG4vPyqMk29yPZ+wx2cXC2XT9/5lj/LSY5vJzxsB+UBj43JoKbODPBoDvdzFwGnG
	 fVtoIErigE14VH+xQHJtM3p4MKFTsVNWy1ZeQTlOcU9GJaVWCHIN1fD2XXs/uIm2SX01K
	 Jjyao6CobGWRA1sUqlyu7ha20rpSHJktdAuvJC7Vz/quG64FuXPOZ8qCydpRdbfQhC5+g
	 OaqE4Cl4sG6foMAFTv4mw0iRTwb85bBv5vJWXHfhTzHRBOGwzkcJEYp95k//E7N4ggg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795259479;
	bh=cK3JihZerztUyBM2JSM9EgYoPbV4Tqmf9dDJvzkXLF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=CwD46cQ9uUhTPwWN3BBLZgXme+qh/Z67MfktfVFVl0oJ0b2wxJGN8kscRD7MTtNzn
	 EJlIsP5SK+lt62ugdflKxg2nGO8Xc43JIVwJox5s8BwCbaDhlPa/dGrYhezpjhAxPP
	 WoOoEq37gInP8JfxUcYSY3B5tiHhZ0ekspdnuR8SAOKmW2p+IyUY1L2Dc7eTggPPef
	 L0fGHUeRfqau1/Hx0E+1xWhdPnysfTqCRU8e4vUOxUr/qynPCF8/2pqjxeuJ+8sRSz
	 x9k0YATTX4whsYLIfIzLTHDY4WlYs2e4216Ut38rEXwlY5+ayK76Y5NxyAXebh2EpW
	 lYGlLlMymqq1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75C0C60666;
	Sat, 21 Nov 2026 11:11:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D14481AB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 11:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE9358149A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 11:11:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSNo5PY9Z4iW for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 11:11:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9ECE68148D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dust6dA8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9ECE68148D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 11:11:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5135345E4B;
 Sat, 21 Nov 2026 11:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE4D1F000D2;
 Sat, 21 Nov 2026 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795259475;
 bh=cK3JihZerztUyBM2JSM9EgYoPbV4Tqmf9dDJvzkXLF0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dust6dA8DuNWsx/obqW7RBDFRaN3bBxz+jUK5Fe97tRAfXz/rN87uCgn45EitvIF4
 mBVBJGuf0XeNoDsVZ5qK14LWsQDRvPSUs/aCRpVAxneFYUckCqnQn+IQKmMhwnrVXj
 Y+cTpSOJxQrroh2VUWF1MA98ILX07R2jfFT3leYNKWPbgzMFUKvk84Qai2/jpf3kVR
 M5mXpCuYjdk/wz5fq264NoWqWvofvxG8oW1DT7knInlLMD6gUfqmg682KAXs5Ur+vY
 3k/regM8tJGSlE7dwN/q17RFCp+gZNtzHtrCwFrqwBw9rWRJ1i9OGGRNDkd4LSzF8/
 PWIIj6VD/0VMg==
Message-ID: <sashiko-outbox-226971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 1/3] igb: do not let XDP frames span more than
 one Rx buffer
To: "Tjerk Kusters" <tkusters@aweta.nl>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
 <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:11:14 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] igb: missing IGB_TS_HDR_LEN room in 2 KiB build_skb buffers
  with XDP
--

commit 91c56c1d76e1bd0d76622dd294c28474abad9f0e
Author: Tjerk Kusters <tkusters@aweta.nl>

igb: do not let XDP frames span more than one Rx buffer

This commit limits RLPML and VMOLR to the configured maximum frame size whi=
le
XDP is attached, accounts for the inline Rx timestamp header when checking =
if
a frame fits in one Rx buffer, and prevents rx-all or legacy-rx changes from
bypassing those limits.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index ce91dda00ec0e..5f1a5e2240e64 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c

[ ... ]

> @@ -2886,6 +2946,27 @@ static int igb_setup_tc(struct net_device *dev, en=
um tc_setup_type type,
>  	}
>  }
> =20
> +/* Check that a frame fits in one Rx buffer together with the inline Rx
> + * timestamp header, for the buffer size igb_set_rx_buffer_len() selects.
> + * The ring flags are only updated when the rings are configured, so they
> + * are not used here. For build_skb rings the frame is limited to
> + * IGB_MAX_FRAME_BUILD_SKB, which is below the 2 KiB hardware buffer size
> + * even with the header.
> + */
> +static bool igb_xdp_frame_fits(struct igb_adapter *adapter, int max_fram=
e)
> +{
> +#if (PAGE_SIZE < 8192)
> +	if (!(adapter->flags & IGB_FLAG_RX_LEGACY)) {
> +		if (max_frame <=3D IGB_MAX_FRAME_BUILD_SKB &&
> +		    !IGB_2K_TOO_SMALL_WITH_PADDING)
> +			return true;

[Severity: High]
Can a frame with an inline Rx timestamp overflow into skb_shared_info on a
2 KiB build_skb buffer?

Although IGB_MAX_FRAME_BUILD_SKB + IGB_TS_HDR_LEN fits inside the 2048-byte
hardware buffer size in SRRCTL, DMA on a build_skb buffer starts at
IGB_SKB_PAD and must leave SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
bytes at the end of the 2 KiB slice:

drivers/net/ethernet/intel/igb/igb.h:igb_skb_pad() {
    ...
	else
		rx_buf_len =3D IGB_RXBUFFER_1536;

	/* if needed make room for NET_IP_ALIGN */
	rx_buf_len -=3D NET_IP_ALIGN;

	return igb_compute_pad(rx_buf_len);
}

Because igb_skb_pad() sets IGB_SKB_PAD to
SKB_WITH_OVERHEAD(IGB_RXBUFFER_2048) - IGB_MAX_FRAME_BUILD_SKB without
reserving IGB_TS_HDR_LEN (16 bytes), only IGB_MAX_FRAME_BUILD_SKB bytes are
available between the DMA start offset and skb_shared_info.

When hardware Rx timestamping is enabled (E1000_RXDADV_STAT_TSIP) and RLPML
or VMOLR allows frames up to max_frame_size (or IGB_MAX_FRAME_BUILD_SKB), t=
he
MAC strips the 4-byte FCS and prepends the 16-byte timestamp, writing
wire_len + 12 bytes from IGB_SKB_PAD.  A frame with wire_len between
IGB_MAX_FRAME_BUILD_SKB - 11 and IGB_MAX_FRAME_BUILD_SKB (for example at MTU
1500..1510) pushes xdp.data_end up to 12 bytes past
SKB_WITH_OVERHEAD(IGB_RXBUFFER_2048).  On XDP_PASS, igb_build_skb() ->
napi_build_skb() zeroes skb_shared_info over the end of the payload and
__skb_put() advances skb->tail past skb->end, triggering skb_over_panic() on
a later skb_put() or skb_copy(); on XDP_TX or XDP_REDIRECT,
xdp_update_frame_from_buff() hits XDP_WARN and drops the frame.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-igb-rx-ts-=
fix-v7-0-63b03045978e@aweta.nl?part=3D1
