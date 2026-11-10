Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1C606A326
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 04:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uMxI5FZU;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bahJoU4F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2822C80D8D;
	Tue, 10 Nov 2026 04:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lVaHjF_UCeH4; Tue, 10 Nov 2026 04:18:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 63EEF80DA8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794284328;
	b=FWVJXwPqIa5AGQetg646lSMyFQILflQ26dvGvJsbYS0HoHADv7VLOChV2DAIc/uJCe5P
	 tLjBgC7tX1LevjakYg0GyuRsB5/d6/kvkPCmw8yBHY+V3blpfMT4mMKZ8vqqkc1KM7oW9
	 DIVtTkmqwWEmPSB3+P/COkqWEoni2uQryagW3Bg8NA/fiU/jmfJ5T/PDNMQKeSPedOGHP
	 KzHLC256GFQEMXKHwnCz1OIJ8GESPIj66FzMX5IkPHbHoAiU/Uab6mnfosyoLPUqQNXvq
	 kCvYMGzKVsA9imJd7lit4mEzGUUgvhwpqqmaNZ8tf5STUBUHMON4e5zBylkYwne4lvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794284328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=FCMfrEanvNuZKrktY3H61P3qHIYd7p2HmCkNinB/LRU=;
	b=enThx1FLZYiNsEUJ3rWFgavWO5hHF1EIlhKnITzbJ5ruQnY5eHJEdVg7JYkn6sXPTxeB
	 efduUL/Cj2nJ2nHtZcjUKs8oC6OGu93FwYDtoTTI4Iwji4BcY4p90cyBfY/smbwYhWam+
	 0SCNCbPaBbt5Hd+2Hlax5LybPpVTRA1WMPxUR4nL2dhGhyOddiuVIaGt2ShTSt9zqHeT5
	 j0KT8ubSJQpQlBguLU/oowG+OOZV3QNhtuElwi6PTSLftYB1u4WOnevVDozwFjw+dk2MU
	 l4LuvvmfqZMuVfi+WK1FrLV+jqdSdKrFScPWcoCrrlXTVK0dSEgXqSSMgrqecOTdSLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794284328;
	bh=FCMfrEanvNuZKrktY3H61P3qHIYd7p2HmCkNinB/LRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=uMxI5FZUxCEIDroNzZakXz7YEGjLlN/85L1h6KbwrEv3qdjl5CJ3mlany+MfsQy7L
	 gKfMZsyP6QSSzmRpxiKEJcqyNZ0bOc1QG4wT8ih8Dip8hSJCl7LCB5LE/Uca1VFHis
	 na2vOHIwYsOV7TaUZi8cqPmQJP4tQyhd7UQhOEbo0lh+9i81vnK9RtmOwD99F8ksS4
	 1cGlO6Vhmb+gC6KfyQXfC1W69144uNhd5dWMoZFXzK6DxEp8jwJyx1OapaLFKw9C6F
	 j9fQXuIrmKAK9twg/vNLL6JhXNNzcvMjUo2J2lFiQh7YKG01C2v/GiTQVhptCbMKBL
	 66JkDQn3sIWDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63EEF80DA8;
	Tue, 10 Nov 2026 04:18:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AC9331F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8732A607FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:18:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Buzx5Tqk-9TO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 04:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F0A66069A
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=bahJoU4F
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F0A66069A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:18:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2916636D4;
 Tue, 10 Nov 2026 04:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9B91F0089F;
 Tue, 10 Nov 2026 04:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794284323;
 bh=FCMfrEanvNuZKrktY3H61P3qHIYd7p2HmCkNinB/LRU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bahJoU4FjVh14oWl9tyP6mySmCdyMcqc+jFvoXghgBKMYPDgYy7JzhgBK9+4Ln04C
 IeoqNM9sBi7SkfQemb8phMj8JCnpzA2MapUImxF0YY3xpKz5fdXVw8kHG2tw8RRGgz
 p/7RHveO/jRXMQj4qjWr1ZEckKnANJ5bsbeorwxqFyzgXJ0sxreMJ9vObvDnjv0RJI
 XeSMKy6bGRmt2AMQ+Kwwr2yEe4nyp4cucFPlr+BoYwLwV6tMmYbJ1BiX6GuP2qBaE2
 yhQKenj/6+vgIAlZCM6ZtyGN0mFEJoUi/C24q2E5IeD1cvmYNId/K1jPI20OtrxUwX
 IE3vGeObfx0Qg==
Message-ID: <sashiko-outbox-206183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 01/15] xdp: reserve an skb core extension area
 after the xdp_frame
To: "Tianyi Gao" <tianyi@cloudflare.com>, bpf@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:18:42 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] xdp: multi-line comment style violation in include/net/xdp.h
--

commit c815cea2f0a60c677b6335d7bc98d4ff8c9346df
Author: Tianyi Gao <tianyi@cloudflare.com>

xdp: reserve an skb core extension area after the xdp_frame

This commit reserves an skb core extension area in the XDP headroom after
struct xdp_frame and updates XDP head, metadata, and pull-data helpers to
preserve it.

Link: https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kern=
el.org/

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f82..c888353425d42 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -81,6 +81,9 @@ enum xdp_buff_flags {
>  	 * XDP program is not attached.
>  	 */
>  	XDP_FLAGS_FRAGS_UNREADABLE	=3D BIT(2),
> +	XDP_FLAGS_HAS_SKB_EXT		=3D BIT(3), /* skb core extension header
> +						   * is valid
> +						   */
>  };

[ ... ]

> @@ -450,6 +464,37 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct x=
dp_buff *xdp)
>  	return xdp_frame;
>  }
> =20
> +/* skb core extensions: RX metadata that an XDP program stores in the
> + * headroom right after the xdp_frame, for the skb that is built later.
> + */

[Severity: Low]
This isn't a bug, but BPF coding style puts the opening /* of multi-line
comments on its own line, with the comment text starting on the next line,
for both XDP_FLAGS_HAS_SKB_EXT and the comment above enum xdp_skb_ext_id.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794281983.gi=
t.tianyi@cloudflare.com?part=3D1
