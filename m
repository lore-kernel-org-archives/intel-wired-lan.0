Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B7606A31D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZrJ4GMli;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkFMAnbH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0484D605E0;
	Wed, 28 Oct 2026 01:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JsMCy9A03oVu; Wed, 28 Oct 2026 01:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20BDE60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793151029;
	b=KYFCWDBSoy4hV1ld9GGubSnI8zhIpYiMjsQIhPs3JqyoBj7Tli5QUxJLH8I0c5JoycjK
	 mBQdHyyvsWO3sP98HQ2mOcjxuVgTRTfoaIXls5YOhoT3pYBjAP84+pYtnT4UDHHXxDcsk
	 VesDiMp6ryzni6lNMjNQP5qy9HCgiDzYamK7yyoz1ILVVD3C+SR+4wVGx0M69DPOiYiaY
	 nazTpxTpFhuOPppsQ52ktAWprc18g5OZW/d+XDtlCB2Bz83pKFsm0GC9thKcV7rqTjhJL
	 SmVEE3YMhlvFV+LAocdNh+03jRtVABe1E3QXPpW3nFLNW5pN3fPYB81jlCaanFK4M3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793151029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=nfbOCiSQK1EKeTrO8VTyXDv2IZWoWHP20P3spt0AJE4=;
	b=Ytb2Gu14uniJ2LAsyqUDtdIGxtM0nrX65OIkJK/1Y23y/QFQrTaCULhyNz9+THGNoZXY
	 kBrJrDzSBLRJ/5EybjydNZd9qIbrC/U3Gk5VhZDoa/4Mk1MVNv+8L+EamdVCvwObPV8qM
	 cpGOr/xZ/Herlf05CdP7DTb+GtVMIkCT4bj/R5qEr/hJonZIe6Rv8TLHRQP4U5kU5DYlk
	 N8r4sj+yu1O1WwECXZIwrMjWXmxoKu3XbD6Gg14PI/u4XRr0G3zvKmjed/j8YaLP5DHOG
	 crlucmxzU/elxTAHWewER4Q30Zk8lmAg1kdxB53em5yGC/HZLjbtZG1NMQyZUVGAT7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793151029;
	bh=nfbOCiSQK1EKeTrO8VTyXDv2IZWoWHP20P3spt0AJE4=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZrJ4GMliPN/XDMX0afiqbhVEjPrJlojQDuslO9irC7QAEFaP/okFE0mrXjWtsVi5v
	 QLJ35gc+tTL7mCWeGMFB1H3yknSy51ZIr2VCX6ZtBTyKR/Ym8TPlMjTTE+ygZJQogT
	 3PGRfhk1TWR1RX1faQmxEzds1DHUN9DKpWMGYlY2b1hEkHTo1QOqalsWMH22EHXW58
	 pB3Bow8UVYLPRErulHNmZwDtC/eul0HLB2iCLcW9pLROdoc8pB40I81LHWdZWBjuH5
	 E1K36srxS0x6Xdy+7meqzeDxL+FpuOFgZkNdUZE3Ao+NwjsvmeEv6fyf8UDHVHzucZ
	 Vzy7QakAMwZgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20BDE60613;
	Wed, 28 Oct 2026 01:30:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 149824D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 01:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEA3640535
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 01:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qKFhOk177WeD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 01:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4DDD40382
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793151026;
 b=PdsG4tiPMHwX4NSBI542BLgt00kuDQi5nZmMoGRK0ehZ8oX/przowicXybvSwGaq3zCb
 MEOmLqehM2K1tlkJcRBRFO0u9/KSq4LJ9Wk296l4Ua+LWytwTrd/NfWodlFFjderrAApk
 dUwU4011zek5FnqRnrUd/Ef0tojXXjRtLxCMUclsIyNqGOuZVrdfdL2W/fNbbtiKV5/6y
 I6GWam6MhKtkbRx44VvKycdhiwqS3AWlzXqTeg1eLIET+fs0VzsuJ+yZ3yt59ovLG200V
 PXdQ/ATrGCIouuxG07CWC7GVNo3QFCtNQrjNVaEi137f2iYXTKBWdAS6H+kaCZ8BTFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793151026;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=nfbOCiSQK1EKeTrO8VTyXDv2IZWoWHP20P3spt0AJE4=;
 b=c+cIA5IxrBEic6b74aaEdu1sxRu3kYYcYGYMetxnqHxL8TrsyyV4gGCVn9eCBJ7FCZSn
 GOypUb8jBqjusmlBPLqw5P0xt3yK07XThw5Bd2i7B4RkJm2mo36OTjjOY8D5lfqmlHi4b
 wYqgbyKMiP6+4fZ/pzifFBn2/qT20soKBRmBvoRstQteTUGOY3R92gpKX/Om1pllraXxM
 /aQ5KvWHK5NY2tcM8JiB6cBly1ohPbgMa3VOJi8+YOEDe+GP/NtzQXxR4PlDDkW7dp/7E
 c3rY3AtslsyvAd+7wFhlAfRMXW1WJyfKNRWLGlXdK7+/MdwsLO50x8qycToB13Gq83g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NkFMAnbH; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NkFMAnbH
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4DDD40382
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 01:30:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89BAB60136;
 Wed, 28 Oct 2026 01:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05A91F01825;
 Wed, 28 Oct 2026 01:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793151023;
 bh=nfbOCiSQK1EKeTrO8VTyXDv2IZWoWHP20P3spt0AJE4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=NkFMAnbHpJC8lKGyDtxpeS2Lv3WYlZwiaMzAAChsWAl6OajymRyy3VcQPXAtvnu1j
 4Znx9L4Dt1aiVpZl0A2SXoQDpPtDQVAM87e+oFhVBP4kTajLuYJZG302CbpFcRSNBX
 expa4+0gRWp3pZ8eBeqLtZnhcYYwtRfoQKY3UEKI2MaPJKlX17TXI2Cd3gF2/oaIOA
 Zg87LvNbbh8brBAq1Q8P3PoGROYtuZXXnB0YZGQcTIGFfWbE2RIozW3RUPLM7hu/S+
 cjBPa5pnU5Qf86/cebqnB6FJ4UrTR5pMtzqSgJftroN9oc6IMf8VPnL7W14osqp6nh
 22XiO/4QyRpEw==
Message-ID: <sashiko-outbox-187316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net] e1000e: fix Tx descriptor field wrapping
To: "Matt Vollrath" <tactii@gmail.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261027012958.52524-1-tactii@gmail.com>
References: <20261027012958.52524-1-tactii@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:30:22 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] e1000e: missing skb_is_gso() and csum offset check in e1000_featur=
es_check()
--

commit a74dc3b4f983f63146f4b296827445229df8d08e
Author: Matt Vollrath <tactii@gmail.com>

e1000e: fix Tx descriptor field wrapping

This commit adds an ndo_features_check callback to e1000e to disable GSO and
checksum offload when the header length or checksum offset exceeds U8_MAX,
preventing 8-bit field wrapping in e1000_context_desc.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/eth=
ernet/intel/e1000e/netdev.c
> index 6f85dab5c55c5..11714032793ef 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7355,6 +7355,27 @@ static int e1000_set_features(struct net_device *n=
etdev,
>  	return 1;
>  }
> =20
> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> +					      struct net_device *netdev,
> +					      netdev_features_t features)
> +{
> +	unsigned int hdr_len =3D 0;
> +
> +	if (skb_is_gso_tcp(skb))
> +		hdr_len =3D skb_tcp_all_headers(skb);
> +	else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
> +		hdr_len =3D skb_checksum_start_offset(skb) + skb->csum_offset;

[Severity: High]
Should e1000_features_check() check skb_is_gso(skb) before calling
skb_is_gso_tcp(skb), and also verify the checksum offset rather than making
the two checks mutually exclusive?

In include/linux/skbuff.h, skb_is_gso_tcp() only inspects gso_type and notes
that the caller must check skb_is_gso(skb) first:

/* Note: Should be called only if skb_is_gso(skb) is true */
static inline bool skb_is_gso_tcp(const struct sk_buff *skb)
{
	return skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6);
}

Because net/ipv4/tcp_output.c:__tcp_transmit_skb() unconditionally sets
skb_shinfo(skb)->gso_type =3D sk->sk_gso_type on all outgoing TCP packets
(including non-GSO packets where gso_size is 0), every non-GSO TCP packet w=
ill
take the skb_is_gso_tcp(skb) branch and skip the CHECKSUM_PARTIAL branch:

1. For normal non-GSO TCP packets, e1000_tso() returns 0 and e1000_tx_csum()
   only writes css and css + csum_offset (16), but e1000_features_check()
   checks skb_tcp_all_headers(skb) and disables checksum offload early when
   the end of the TCP header exceeds U8_MAX even if tucso fits in u8.

2. If a non-GSO TCP skb is encapsulated in an outer header without setting
   skb->encapsulation (for example, L2TP over UDP in l2tp_xmit_core(), or an
   uncloned non-GSO TCP skb encrypted out-of-place by IPsec ESP in
   esp_output_head() / esp_output_tail()), skb->transport_header points to
   the outer 8-byte UDP or ESP header while gso_type still has
   SKB_GSO_TCPV4/V6 set. Calling skb_tcp_all_headers(skb) reads tcp_hdr(skb=
)->doff
   at offset 12 past the 8-byte header (which can read 4 bytes past skb->ta=
il
   for ESP with a 0-length IV, or read a 0/1 nibble on UDP and allow
   css + csum_offset to wrap u8 tucso in e1000_tx_csum()).

In addition, when __netif_skb_features() invokes ndo_features_check prior to
GSO segmentation, skb_transport_header(skb) can be stale and differ from
skb_checksum_start(skb), as noted in net/core/dev.c:skb_gso_output_max_segs=
():

	/*
	 * The transport offset can be unset or stale, so hdr_len is only taken
	 * from a header at the checksum start.
	 */
	if (!skb_transport_header_was_set(skb) ||
	    skb_checksum_start(skb) !=3D skb_transport_header(skb))
		return 0;

For forwarded IPv6 packets with extension headers (via ip6_rcv_core()) or
inline IPv6 extension header insertion (such as seg6_do_srh(),
ioam6_do_inline(), or rpl_do_srh_inline()), skb->transport_header points to
the first extension header immediately after struct ipv6hdr (offset 54),
whereas skb->csum_start points to the actual TCP header after the extension
headers (which may be past U8_MAX).

In that case, skb_tcp_all_headers(skb) evaluates to at most 54 + 60 =3D 114=
 and
skips the else-if branch, leaving NETIF_F_HW_CSUM and NETIF_F_TSO6 enabled.
Later in validate_xmit_skb() or ipv6_gso_segment(), the transport header is
updated to the real TCP header offset (> U8_MAX), allowing u8 css, tucso, or
hdr_len to wrap in e1000_tx_csum() or e1000_tso().

Would it make sense to guard the TSO check with skb_is_gso(skb) and check
skb->ip_summed =3D=3D CHECKSUM_PARTIAL independently (or compute the TCP he=
ader
length from skb_checksum_start(skb) when skb_is_gso(skb) is true)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027012958.5252=
4-1-tactii@gmail.com?part=3D1
