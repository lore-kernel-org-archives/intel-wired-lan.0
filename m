Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DB606A31D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=00VVeTLG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ke7wnBA2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CF4F60AA6;
	Fri, 30 Oct 2026 04:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2_A8V6Jd-4u9; Fri, 30 Oct 2026 04:54:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9757260667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336048;
	b=hRqeiH/NcJfp31QItpvNz/OMuQcjJtjEXk2EtGEU/hFaSHh72njAKAt2wwRk2S7H5wv3
	 3gv6n0gubeYTFKN7wGnOZY/rkvb1puXLWKY85sGaF5YPujZSqJmBPNPOKhNtCKfAsKBqD
	 WFdBBsUD/S1RXaPJ3TG85/Y3YfA8oY5OfVhAn1KjNQ37XYnmgdZJUKxdsWcG++YZSEcim
	 4e1xJRG9bBtY5pv28kJq3IE09eZgssX2Zqw3ORMrgriM8+172QRnVMVJcvtNSvdNsxcsi
	 DOcT9CjBWpIUhXLuvT96NeXcM7sWDFfuInxg4Di+y5A3XNcO00As4iu/GL/EGlzMVyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=nLBjb4F3OeLFw5lNrBCe2Q7rzGMDWKNlWqk4bpqN4kA=;
	b=XWX8G57WAXpUrH/7+XvDD2ZHpRPUMZZOujmgsyC6FTlk/LxJUjWsUnKUZFwpQNWM9uQZ
	 F3oz2vzT6UgyppyN64rozeAJOguV3SEL2RF8+m1xhd0TUcl5AvwzKlIoStnDZ8vJLAXu5
	 I+aLrOwam/75bEJNOFt67bSM+HJjaxVG148H7bJAs1QSdyzfB6Be2Snz/IYKvruVGbNpm
	 Ux+5yzQl7/i2hij2Au0fjDraYv7RYXSqRArNJlJhVZ+zIpfQcNo01/jw3/DV9JzudMp/1
	 oVezLtRyYeFoskses7slwiRqijNQ9A8fe6T+djN3T5pH3Y5gH27CqGB+HzFWnJU4SHQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336048;
	bh=nLBjb4F3OeLFw5lNrBCe2Q7rzGMDWKNlWqk4bpqN4kA=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=00VVeTLGxuLih8HTb7UfkySNzdMTS+lcE6jOROBaRkElrr5HMVk9ph5Km8Kiz25fN
	 F4Ir14f3pZAh8LKEWJhWLAt2ADANeaz0Elj5QNz3VjbIH7bqCXf8mp+3S+duVn1axy
	 MzRtdobQzfCT86FpxZBlKtd2DauvxGpBQYOfVclr9iAi6fuN4nG/ml4oliyMtH4IBI
	 UuCAy/XF1Rsp66ASaRITFOdRFano0+JOasLbgg4Vobra8caHmKqsEPDTOBO/W6/3OB
	 1EXmHgTPm1GA/Ipxda0qv9clf742E/RXWlNS7f77CmPq1r62B1XlJJT5p+1Zyqo2d+
	 qxdYUk+hc9mHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9757260667;
	Fri, 30 Oct 2026 04:54:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 01BD9D38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7114810BA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fajCQf-6R1g1 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B3F9810A8
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336046;
 b=rR1kgQWJQs5Uiab7PY0SaI9562ycNTrGH2YdvOZD38UkTAf2qhLMLuP9mrWXRO9GRvcc
 FKyB8jYajFqUqtkYwUaat90NWwtlDbDie1DTHbmrCcev2HYIZ73QIG+bQv08u05GzgtDW
 JV++yEF/P2159s8XgzVRKgbVLy2MN+eDrDRXHIOX4WOvI6xbQBiE7uR8yvz+Wd9Vqss7+
 oqJsxcNuTboHhX7IBNi/K7SxZL1NZB1gaCP8AvT0+DtYoKResqgGNBy1GqpFW+6gvkdWx
 vYSip0XKvvQQODoX22mReJxPQcW2zs9J0kynz1cFrf9+eOuaH/J0YVKyhPSo9xAjSww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336046;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=nLBjb4F3OeLFw5lNrBCe2Q7rzGMDWKNlWqk4bpqN4kA=;
 b=U9BWHL02+abyYSuL9gGDX6a9mR0k5YDCsza+P+lACbpv1xmGJmVw+FnFA+wDYAeDFNnT
 zHoVH5m5vN9KQV+9u1YoVZrvdQpYuIXJgZZMB0xpI++bbWxO1duxanDPwaulGY2Xsq9Gm
 uLNIPTSjS2U9xwdLd9L1rltfr3D9pukE2Ia+42plPHXCfrUkV2gho5qFobYOrvjMyazM1
 HoP3oI1BeWDRRSLgwQ+j6OSDMHnYLL9lMrXNSvjKkhcrECGsGXVRGYYQov9wOi+gEzXXg
 vd8rS6+RTlhtiSeiHt5OTGDmu9/dX5ZvHzosicri0mBDezAbah25PFqbgbx1caAvysA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ke7wnBA2; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ke7wnBA2
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B3F9810A8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 615A240551;
 Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5891F000C1;
 Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336045;
 bh=nLBjb4F3OeLFw5lNrBCe2Q7rzGMDWKNlWqk4bpqN4kA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Ke7wnBA236mNSRXZoUBZN5M0ix8EvZqZPlI9FvenYRXS5AFXKSxbe8oM18KczDdex
 MeMFvwCgIybL3YYbVzWA8uusizXa7Cd4fYSTxN37FIQlOyJwMjjuZpiU2Wc4+IZLJ/
 2FcZftDT45T7NyrgI5lm5hc7javr52oQ4dLZKQsKrE7UGga5gFGteJsys3Q8Euoc02
 4rELEbezkVXrOFjSMhZuaH8t5bBEWsRIDkprRe6xDDtvXAcCcGwh0quwGNppzts/Gh
 0sggRL971Mg2WRTa5Avr160uQjs58pW9EKAKZfbkS92cgwkxz8iizDbugYauWrKrxa
 T6bY9XxzGgQIQ==
Message-ID: <sashiko-outbox-190400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 net-next 6/9] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org
In-Reply-To: <20260508034912.4082520-7-rkannoth@marvell.com>
References: <20260508034912.4082520-7-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:04 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Undocumented logic change in `rvu_npc_install_allmulti_entry`.
--

commit 905a3173f74be8db2d23362cf0c4656c9ea8d645
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: cn20k: Coordinate default rules with NIX LF lifecycle

This commit adds a new flag NIX_LF_DONT_FREE_DFT_IDXS to prevent the AF
from freeing CN20K default NPC rule indexes during PF hw reinit or teardown.
It also updates rvu_mbox_handler_nix_lf_alloc to improve error handling.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/driver=
s/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -990,7 +990,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, =
u16 pcifunc, int nixlf,
>  	u16 vf_func;
> =20
>  	/* Only CGX PF/VF can add allmulticast entry */
> -	if (is_lbk_vf(rvu, pcifunc) && is_sdp_vf(rvu, pcifunc))
> +	if (is_lbk_vf(rvu, pcifunc) || is_sdp_vf(rvu, pcifunc))

Is this logic change intended to be part of this commit?

The commit message focuses on coordinating default rules with the NIX LF
lifecycle, but this silently changes the condition from a logical AND to a
logical OR. While this appears to correctly fix a bug where the condition
could never be true (since a device cannot simultaneously be both an LBK VF
and an SDP VF), including an undocumented bug fix in a patch about a
different topic obscures the commit's intent.

Should this be split into a separate patch, or explicitly mentioned in the
commit message?

>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508034912.4082=
520-1-rkannoth@marvell.com?part=3D6
