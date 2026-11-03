Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA3606C55C
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=o1qLrs8Q;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSpLMQ82
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FF7F405B7;
	Tue,  3 Nov 2026 10:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V6TJzH_YXSq1; Tue,  3 Nov 2026 10:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99F4B40575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793703216;
	b=kQM1JCXsCGjifJXvNaxKDsHLCoA7nskYcQTkU0gY6CM3gd+lA/8CewHdRMt9hlEn0uhj
	 MlYN2XemKfGppqjVCIOakaJFp3EqBRf2LHchkAaviVVgJ2I2kK48dgxmbLN5x3na79TSO
	 O1oqBZirbxifyeU+BTOuUuy0dn2s7O9csVDkzvHaiwozZ3tIGYTKE6ZF1bAZsfeQzUXre
	 V4RZNZxtDpuQYJ+xYTspnlWLYPSdjP3/gttsJllIYuZ7lvZ3CfzUGhz4rDClVkACm5WFl
	 gPT+4gtgggrSUxr8W6LxgWUON43NrbWjChNj0m5OmW1BUkwNzovUy7O5NFuMmUUwPOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793703216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=uy8eIkiJKg3oRBVIjw8Q2X3xsmWMv209WoPw23/maKo=;
	b=ILk9r3GFFpF/8lHT0QADX5h1YjSnww97szLrSSWc948efvQ6krWfqeOdXhnrKSwtrmto
	 nBBHjPn8PGT8WzxzTWO6bJTJSzArQn97wUJVg8McIcS24n4y0Jz4L8Ihj4hkOmU0D7h42
	 qPXP/NrcCA0Zn8ipvqeDLwmvzOprmz96uJrjufu0j2eX8c0yMVo8U3OFbZFpVYTiioJn4
	 o9TsbRlJheaCT9cL5dWb1Qum6bEYJ6cdO80ZGLIAfk487nB/As+7gfTUj9lMg/cwkwnT8
	 JbQiTo8mJkLhcOZLxOxzFsH7TVhLHA08TTeLXMQRX22QJzh5o0UvSzMU0wWe1KPH9OQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSpLMQ82;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793703216;
	bh=uy8eIkiJKg3oRBVIjw8Q2X3xsmWMv209WoPw23/maKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=o1qLrs8QoLKQdoZObnKsjhudBrZkx0WtbGUXvJia/VPasq3IgQQ3sR0wCakMJEptg
	 3phddxy/Nw2dAtK6KUYicQxQM6Dk5rYqxzR/t1J5HbKMvZcvnbiIyLgvxSLC9Oe5Hc
	 ZuoNO5siWMhI4mqjGMBcW+WLday0DIF4DXBpqSQozfIl/++79a9yeu5jL41Vrnvgtj
	 +K1hpsR6UbMgAftxHMFb4WvEW9gwBLApz0vyLBur9D1ehgBz6UWnS/4amYAAS5ox1Q
	 BZJiHwRuQNxiCnoi9VU+2iGFYhrdYZ1P7QJOgR2sxpUbRXHzSkybuY1FJmR8bl9FYS
	 dvqeukNOzRDMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99F4B40575;
	Tue,  3 Nov 2026 10:53:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F103E356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6F4C405DE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QF9eayvGWzme for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C32C340575
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793703214;
 b=m/CH0T2QdCVNUdia0aWFzq1L2HXXmCrLlNv5texYqsGX/J5IfNONj9JeEn7kq7OnYodf
 hvLE06RGzjRI4LcuInn9Bmxrl58Kwsi24C/boVDdkrssLww9GH1wg3zUqxriqDfFt3r/r
 oCiMP5Lyf8fU18pYz8ZhyO5bNnVHQDIrSoD3C3S7Pxgqj4hPfzikUHm8A+1LHfwoGwJK5
 Jyy7u2yc12KKbjHQZloUb3GYbF0S6RGldKswOljF1eU4pAxA9fO49ed7t2cq/AmT+FD6n
 ZbAqkzRDD/qUp5wG6UWadb+isE33EM0Nyc5uDSih20a6qgYb/uHtw985DoxxQMxAN9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793703214;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=uy8eIkiJKg3oRBVIjw8Q2X3xsmWMv209WoPw23/maKo=;
 b=r0yrMpnMJaWtSPPyJQIhXtVq/AvFZRZqg8mr/ELL5/l+rS5jCteYew8MkSOA+bhr7XYc
 rIGsT1iw5vFmlcpXovw4djLufVd4WIFsRSZBo+V/LaBW3niWpcupOWagUmLdjL1q3PHy2
 N9utNaRvHvB6qBtGSh1MtK8xCBOQoKqzfjsIyGabdWPNnRNIFqsl2TiQGCEsOXkBPBoij
 j2rPR4W3jGmX97/ka9iIkajogpKamlvgD9Thd3NhlFB5TY8Iqq5ZDAE9lpN2dPNGfwVY3
 jMD/uLq9urmcUYUXt/xHCoiEPfkCArbBlJ2nEmJY3Mx13jCdDse4/2vFh9aclJrUHdw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mSpLMQ82; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mSpLMQ82
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C32C340575
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:53:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 920EA601EF;
 Tue,  3 Nov 2026 10:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C2F1F00919;
 Tue,  3 Nov 2026 10:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793703210;
 bh=uy8eIkiJKg3oRBVIjw8Q2X3xsmWMv209WoPw23/maKo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mSpLMQ82v9lHFdiTjyXMcXTHfNHX3dhb92kOt/m3OBn2l5uxjdZfuWZUB1ojhg3+A
 Y4WONi6kdRrY0r6lGP1d+7wcnfbHIj/t+vRycv2diSiSU9/W3fCeA5KWKvbgr4jjpI
 WApLCgVcsCKxZE8foZ5sqmokZr3FlsZIQ51cxgz2RVfduZwLb+kcWhsoYiZPxfkLYl
 KtofsaFfIje45BV8CcvMISab6hwJe/nA0ZAVsUcmACRDHyV82wMUFCwb42FQTS5eMR
 nVrgbWcsUpAYhC0yH1iGPwZCKU8+IWeIaAsPcY8HdtXKtbRbebd1/WTPNI+N7appWn
 uPiFh4s8Yk0ww==
Message-ID: <sashiko-outbox-195080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/2] igb: only strip Rx timestamp header on the
 first buffer of a frame
To: "Tjerk Kusters" <tkusters@aweta.nl>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261102-igb-rx-ts-fix-v4-2-8785124c5d23@aweta.nl>
References: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
 <20261102-igb-rx-ts-fix-v4-2-8785124c5d23@aweta.nl>
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
- [High] igb: XDP setup and MTU checks in igb_xdp_setup() reject default MT=
U 1500
--

commit e6fdd6185a160da19639b21242c6743c31579ab8
Author: Tjerk Kusters <tkusters@aweta.nl>

igb: only strip Rx timestamp header on the first buffer of a frame

This commit guards the Rx hardware timestamp header strip in
igb_clean_rx_irq() with !skb so that continuation buffers of multi-buffer
frames do not have payload bytes stripped when their payload starts with 8
zero bytes. It relies on the preceding commit in the series to prevent
multi-buffer frames from reaching the XDP path.

Link: https://lore.kernel.org/all/20261028083344.3047350-2-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index 5bf489cd7b066..c4eb9f589fbe7 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9072,8 +9072,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q=
_vector, const int budget)
>  		rx_buffer =3D igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
>  		pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
> =20
> -		/* pull rx packet timestamp if available and valid */
> -		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +		/* pull rx packet timestamp if available and valid; it is only
> +		 * present on the first buffer of a frame
> +		 */
> +		if (!skb &&
> +		    igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {

[Severity: High]
Does the prerequisite buffer size check in the series break attaching and
detaching XDP programs at the default MTU of 1500 on systems with 4 KiB
pages?

When the interface is opened at the default MTU of 1500
(adapter->max_frame_size =3D 1526), igb_open() -> igb_configure() ->
igb_configure_rx() -> igb_set_rx_buffer_len() enables build_skb without
setting the 3 KiB buffer flag:

drivers/net/ethernet/intel/igb/igb_main.c:igb_set_rx_buffer_len() {
	...
	set_ring_build_skb_enabled(rx_ring);

#if (PAGE_SIZE < 8192)
	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
	    IGB_2K_TOO_SMALL_WITH_PADDING ||
	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
		set_ring_uses_large_buffer(rx_ring);
#endif
}

Because adapter->max_frame_size (1526) is not greater than
IGB_MAX_FRAME_BUILD_SKB (1536 - NET_IP_ALIGN, i.e. 1536 or 1534) and
IGB_2K_TOO_SMALL_WITH_PADDING is false with 4 KiB pages, igb_rx_bufsz()
returns IGB_MAX_FRAME_BUILD_SKB:

drivers/net/ethernet/intel/igb/igb.h:igb_rx_bufsz() {
#if (PAGE_SIZE < 8192)
	if (ring_uses_large_buffer(ring))
		return IGB_RXBUFFER_3072;

	if (ring_uses_build_skb(ring))
		return IGB_MAX_FRAME_BUILD_SKB;
#endif
	return IGB_RXBUFFER_2048;
}

However, igb_xdp_setup() checks whether frame_size + IGB_TS_HDR_LEN fits in
igb_rx_bufsz(ring):

drivers/net/ethernet/intel/igb/igb_main.c:igb_xdp_setup() {
	int i, frame_size =3D dev->mtu + IGB_ETH_PKT_HDR_PAD;
	...
	for (i =3D 0; i < adapter->num_rx_queues; i++) {
		struct igb_ring *ring =3D adapter->rx_ring[i];

		if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
			...
			return -EINVAL;
		}
	}
}

At MTU 1500, frame_size + IGB_TS_HDR_LEN is 1526 + 16 =3D 1542, which excee=
ds
IGB_MAX_FRAME_BUILD_SKB (1536 or 1534) and causes igb_xdp_setup() to reject
attaching XDP with -EINVAL. In addition, because igb_xdp_setup() runs this
check even when bpf->prog is NULL, if an XDP program was attached before the
interface was first opened (when ring->flags is 0 and igb_rx_bufsz() returns
2048) or at MTU 3000 before lowering the MTU to 1500, detaching the XDP
program at MTU 1500 also fails with -EINVAL.

Similarly, igb_change_mtu() checks max_frame + IGB_TS_HDR_LEN against
igb_rx_bufsz(ring) using the current ring flags before adapter->max_frame_s=
ize
is updated and igb_set_rx_buffer_len() reconfigures the rings:

drivers/net/ethernet/intel/igb/igb_main.c:igb_change_mtu() {
	...
	if (igb_xdp_is_enabled(adapter)) {
		int i;

		for (i =3D 0; i < adapter->num_rx_queues; i++) {
			struct igb_ring *ring =3D adapter->rx_ring[i];

			if (max_frame + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
				...
				return -EINVAL;
			}
		}
	}
}

If XDP is attached at MTU <=3D 1494 (where 1536-byte build_skb buffers are
used), raising the MTU to 1500..3030 is rejected even though MTUs above 1510
would switch the rings to 3072-byte buffers, whereas lowering the MTU from
3000 to 1500 succeeds and leaves XDP active on 1536-byte build_skb buffers
where it can no longer be detached.

Should igb_set_rx_buffer_len() account for IGB_TS_HDR_LEN (or select 3 KiB
buffers when needed for XDP/PTP), and should igb_xdp_setup() skip the frame
size check when detaching (bpf->prog =3D=3D NULL)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-igb-rx-ts-=
fix-v4-0-8785124c5d23@aweta.nl?part=3D2
