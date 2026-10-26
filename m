Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309C606A31D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uF5+wGmt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0jfaQvy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB54280D43;
	Mon, 26 Oct 2026 06:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ckJ5YoVU8Wi; Mon, 26 Oct 2026 06:52:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C737280D7C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792997544;
	b=C+eP6EtcRV+GUDjdOpnE9xHszHmlhq7F7khk1IpVcnDR/TgDARHyKlgKRXrkKFwYBCko
	 i5ToD69ORw4U84YOCQHNEYV2221elD4bKKcDlX+qoswkPBhmB6EEuN37H7Sim8CPA1N0H
	 03lRj1uiPzqnkwCPDhvFG9WiO78VEkgsh9c+tcbRzDECTCkBgTfixb6qyfvHRIy/a5IIj
	 lD/oR1OVcFKMhdBYbm05zXcvmI8GfEXAk6Kka046gR+9nareXkkYXcE6c6V1db0BkZwLQ
	 fFWVXJ+DziDjGyKBhctbujWN9F2lsxzclxxvygjo5gWAwa/zC2wTJ1HyqRceKvPRMgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792997544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=WlFgFnIJ6H+PFS/md3WjifcK6os996SyL523DySm45I=;
	b=khNoJ03T0RGzUi9J44Fyw5o6HGuUrRgoM4Z+Fl8Fi+o8rC8PUpihJ08XZ18EnMnHlCW0
	 6s5hM6NZTOEeG7RE5M3ChdJRDtKV9ZQ6ncJ8l/QwqLHEoPiSRmeZ7TNsd69UwZMCQULYm
	 dcOi6l7GRTbbtqf2hkIUZCdQgoK71udXXP8dJIVHGiVDT6Af2Bb92TnN6OdwWNodZ1kf0
	 Vt2aApVqP5LaCqGOKfJIF7pv9XlyMK7uZlD/1QgO0+WeqHHNA8S7zeDKgn2FeQMA9O5xK
	 CgegtogOYvWh5oR6bgKzKo6zWPNNBQ++fxppcK8/hujeVBGciuGDJ4OsfXnBVwIhMpw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792997544;
	bh=WlFgFnIJ6H+PFS/md3WjifcK6os996SyL523DySm45I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=uF5+wGmtDrv0N0/ivE4/Baq2n3JMWgZzo9EITJrxyJTfZJFxq8MQCA5/IcXJIezzC
	 7efuiNFH2BuY4JdnfOLNE6XPeZeACHUf0upLozIr+8fHflotKwXV49cVua19seTd2z
	 NeoluskgAQu7wFGuS7yR+YUcT1oSjRNd0pbOVCI+y9K1nilhZecSKYFdHsQwmWS13G
	 n35Bdjr3xI3JBo90Y2DdF5OUg4jc+FQnRAD8Oc9iyJXSMj5pXFGPwOaIsELn0Ywq/U
	 ROiWONlwRxn8s07ceL7aFTJvKG4GKbiyDz/0M4iy2SRGH5Q+XFYnEdmn7QZUDIVYxd
	 5fpEvbVv6W6Ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C737280D7C;
	Mon, 26 Oct 2026 06:52:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4BFE380
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 06:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B61DF400C8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 06:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJbEFZDmcDCY for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 06:52:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9076340049
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792997542;
 b=tQeKKtLVzYvqF3fugoYteg0tP8mstbCf6gVpQl+u0yHEvZMmV4xluzY5QGTYa8Whv0s4
 CVETHAjJPfhDOTxTrcRhpEKzMn7nCrDzQMs4WyFDV3Z9dpzmv5TbAodcNBx6ZjCDQSpsD
 Lgm1nPJ4Q5HPR/WTKQAaPf9nK6taeVM+UaeQSsv9r/YowYMjYuJAEJRt9jXjUNtmS/RO7
 +6bYBcElhltoeZ1V7Z1k4VFlk3S6usvPC1Pof7Z2syUYaIRhKyT94h7jCx009XdhG2R6n
 gxj3uymm/pGZDutxkLZyo54UUZuzY64v4Jfh8sDHYMIzvDgVeimQKeZTubkGtUu7skQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792997542;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=WlFgFnIJ6H+PFS/md3WjifcK6os996SyL523DySm45I=;
 b=abvKzd0ISMJQ6MPxmlnEMZ/8cihQ4Ce8OmaVKmlYjQUY3ziBrUV8mjXeL0A4St3gjIzp
 DJmsY3E1KeNrh0khGChDrvuNGLnhUCIRXn7Mixa848VfsYCc7KF7tkj14lJGOHn0pSaIs
 dFfFlC6SJ18D8bbfDZZ5XjmS4Sl/5S+EGuzab0jocT42X+zEAG6azLTGFlgNAFwlaEv6w
 Zxcgv2D7feorOw2rb/fDeG6vnZVnKcQ5BxahciVCUpg3mVJAmPRUTMaaxw3jX+yWF25G1
 KwqGFF4ite8reeFSWyZ/OR0cWAyJAkhNcJ6UoaLvWCDtZL5tdi1In7fqRUTxnNhPbMQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y0jfaQvy; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y0jfaQvy
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9076340049
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 06:52:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1B42601DE;
 Mon, 26 Oct 2026 06:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627FD1F01825;
 Mon, 26 Oct 2026 06:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792997540;
 bh=WlFgFnIJ6H+PFS/md3WjifcK6os996SyL523DySm45I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y0jfaQvysQzIVWOeMQpkE29ZV2HFvBbwzVX8SszINIZUJppjYFcOvMbsCAO8Rs2el
 fq5xvxgM1Wpk6hvkWWM5L9NQOxRRvDd17/Mn89mhUX5I6pI6oMpN+C12telC5W77i8
 soB1rWVlE2r6nNJ9utvvUkPseMHu222uXkyX+0Q1e8ATnR6O89zss5wLnHdcRBCOXT
 Uwb71djC3kTC03vjpXO+RWHWeaeoETtmQfXdB72NgB0KzdoLcLKUle1Wy06rd+NnR9
 YUqcHL0BB4+ZeFg7QVN6DwFjpHa7lU6TYfGPp9lb0rW7cg9uOOOYFKn6vhdJrhqFYE
 SZ3WidDcfXWkg==
Message-ID: <sashiko-outbox-184616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
To: "Paul Moses" <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261025065154.2037149-1-p@1g4.org>
References: <20261025065154.2037149-1-p@1g4.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 06:52:19 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] igc: off-by-one in TSIP length check in igc_clean_rx_irq() and zc =
variant
--

commit 7b71c87cde8117fd4a451a2a079f34aaf64bd069
Author: Paul Moses <p@1g4.org>

igc: track rx frame boundaries independent of skbs

This commit tracks RX frame boundaries per ring via rx_in_frame so that
inline RX timestamps are stripped only from the first descriptor buffer.
It also rejects unsupported split frames before XDP, drains continuation
descriptors, and updates NAPI budget accounting in both standard and
AF_XDP zero-copy RX paths.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..9ca5558c762c9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c

[ ... ]

> @@ -2635,21 +2635,34 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
>  		dma_rmb();
> =20
>  		rx_buffer =3D igc_get_rx_buffer(rx_ring, size, &rx_buffer_pgcnt);
> +		tsip =3D first && igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP);
> +
> +		if ((!first && !skb) ||
> +		    (first && igc_xdp_is_enabled(adapter) &&
> +		     !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)) ||
> +		    unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> +			if (first)
> +				dev_core_stats_rx_dropped_inc(rx_ring->netdev);
> +			xdp_res =3D IGC_XDP_CONSUMED;
> +			goto xdp_done;
> +		}
> +
>  		truesize =3D igc_get_rx_frame_truesize(rx_ring, size);
> =20
>  		pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
> =20
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (tsip) {
>  			ctx.rx_ts =3D pktbuf;
>  			pkt_offset =3D IGC_TS_HDR_LEN;
>  			size -=3D IGC_TS_HDR_LEN;
>  		}

[Severity: High]
Should the length check in igc_clean_rx_irq() be size <=3D IGC_TS_HDR_LEN
instead of size < IGC_TS_HDR_LEN?

When a first descriptor has IGC_RXDADV_STAT_TSIP set and size =3D=3D
IGC_TS_HDR_LEN, the buffer contains only the 16-byte inline timestamp
header and no packet payload. With size < IGC_TS_HDR_LEN, the check passes
and size -=3D IGC_TS_HDR_LEN leaves size as 0.

If XDP is disabled and this is a non-EOP descriptor followed by a
continuation descriptor of at least 60 bytes (ETH_ZLEN),
igc_construct_skb() or igc_build_skb() creates an skb with zero linear
headlen, and igc_add_rx_frag() attaches the continuation buffer as a paged
fragment where skb->len =3D=3D skb->data_len >=3D 60. Because skb->len >=3D
ETH_ZLEN, igc_cleanup_headers() -> eth_skb_pad() does nothing, and
igc_process_skb_fields() -> eth_type_trans() -> __skb_pull(skb, ETH_HLEN)
then triggers BUG() because skb->len drops below skb->data_len.

If EOP is set on the 16-byte descriptor, size =3D=3D 0 runs XDP on an empty
buffer where XDP_TX calls igc_xdp_xmit_back() ->
igc_xdp_init_tx_descriptor() with a 0-byte length, and normal RX or
XDP_PASS allocates a 0-byte skb that eth_skb_pad() zero-pads to 60 bytes
and hands to napi_gro_receive().

[ ... ]

> @@ -2829,11 +2855,20 @@ static int igc_clean_rx_irq_zc(struct igc_q_vecto=
r *q_vector, const int budget)
>  		dma_rmb();
> =20
>  		bi =3D &ring->rx_buffer_info[ntc];
> +		tsip =3D first && igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP);
> +		eop =3D igc_test_staterr(desc, IGC_RXD_STAT_EOP);
> +
> +		if (!first || !eop || unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> +			if (first)
> +				dev_core_stats_rx_dropped_inc(ring->netdev);
> +			res =3D IGC_XDP_CONSUMED;
> +			goto xdp_done;
> +		}
> =20
>  		ctx =3D xsk_buff_to_igc_ctx(bi->xdp);
>  		ctx->rx_desc =3D desc;
> =20
> -		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (tsip) {
>  			ctx->rx_ts =3D bi->xdp->data;
> =20
>  			bi->xdp->data +=3D IGC_TS_HDR_LEN;

[Severity: High]
Similarly, in igc_clean_rx_irq_zc(), should the check be size <=3D
IGC_TS_HDR_LEN so a 16-byte TSIP descriptor does not result in size =3D=3D 0
after subtracting IGC_TS_HDR_LEN, which would pass a 0-byte xdp_buff to
__igc_xdp_run_prog() and igc_dispatch_skb_zc()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025065154.2037=
149-1-p@1g4.org?part=3D1
