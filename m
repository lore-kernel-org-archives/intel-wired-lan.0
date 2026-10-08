Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BB8CA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9729C408E3;
	Thu,  8 Oct 2026 18:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nehs6OPgvQ-S; Thu,  8 Oct 2026 18:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2DDC408F2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483424;
	b=PPNxgIf0NATd/g9z7r3Ay+EChvSMUA+pYg9y4RpYL/+cSjWEEDqU7dyJkp/xkSvpM8sC
	 BQfzWcw0cWUVLOOHm6nQ9BXdibJNFr0F/asBuo8hEHqawLuT+Iv36cpL2Q1Tv6qSplSKG
	 gYz7Vi5V900n9CVIs+mLefRE5h5JEEiCugv4fSgjynRfWc249nfDMdkfAkP9PU9PUvscX
	 Dhocb7+HaPUxX3VkQ48uu7TWiSFnss+NxiptdXsYx9nazDO8QkTdUg985yTuxQg9oSG+z
	 DtE/GQ8ZF9csg/mfNQtCpjAHzrYWwLnalqAMzoTwcjo4P2BgYtEoduEiEt8B68rWvEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=6E63n4T9KloA5p468HTbUp+pZU0q6o/eLuL3jEt9Tw8=;
	b=MUDj0zU6PvYivZpEBDem/WDoRPPDYd4D/G4NKt8EaEAoeJvR0yUAZ71mF+zTki6nIaaL
	 4g+zHlCUA59QEs4YU6QIDuqlLmBXsy3IZIxBWTDBcWGLxWb631fWqizA1MyZ5J7LCy76f
	 ua+8fAGP72fKMTX+5TZlN9gK88aW8ioZy+JVh5weMxeRbS30O1Mfl/7VNGlXssgi4CScR
	 W48ZPt4cDG1NOpcaygxT7g0QNTagR54s6viu7jdgWq/HBPEDHyli/LdQulPFPb1906B3Y
	 kzTNXKzSjZUa52D0VkppNsU+dHdAIFI9ACfcg2K1Wg+Br5O/9h22DOTMHSQG/kNtfLw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeQeteq+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483424;
	bh=6E63n4T9KloA5p468HTbUp+pZU0q6o/eLuL3jEt9Tw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Q0nbZhC4FzwSh2SpCaXuwa/sqLwXnEqqzbPDX6xT2UEMUwIaj6ZVeHIYry/d2Q9tA
	 vj0MMov3sjNKyA+M0Tf4PJ1tVS1QH75bbbHXsdQheKsRa+JOJMve4og4XZseowtR6y
	 mkBy+y7nHjSn1MxHuiL0N1YtoamKRZjiy5pAThSvLPP3MfnxXL9jhKLPC+AliPvBDh
	 nlHenLB4hxZgqL+Hm6M+b/CxXvz0gZAxTHI5/JwYFClbivC1lIv1GT+2cz9QmeXsZa
	 OUKJpo9IUOcXiYPt1Gwzr00B4gXoggg8kmwcaCliphXxvBtCQthw8HbMN/pg+c/e66
	 EGKOWRh1H3OnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2DDC408F2;
	Thu,  8 Oct 2026 18:17:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE235338
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0600408F0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ER1S8lPmJlHT for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DCBE8408ED
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483421;
 b=VbNvAxewAMyuSJCWmm+UH85t+OvNhaa5aHDM46Q8MgWyHnMKDegiy9k9sA6HZ0eavpbZ
 IPGLwmf6TWfUYyoEkygQw7QfsLO3iRHUAIsod/BS60Krifh+qrKd4RUt0D+Bp67ygSKMA
 vFu9l/xbZm3E491qtAqqNw1IFcBpoR+Q9Mmo/aZLgXQ6RcmuV/WFOD66t/CUBGMtwHvgs
 ZOgALwkPmQ6//wqZvQs4AaL6qBc6lR5xD4dPluAkZBwsjf0MiV2hvF5MGBeQWng257pmd
 XUUspgLByjP9vRkObq1Jv4iielITp9cTM69EmdNHChewNQh5HV6g6jKcQhUxDlrlCnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483421;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=6E63n4T9KloA5p468HTbUp+pZU0q6o/eLuL3jEt9Tw8=;
 b=EjlKlX+O2lhX56HcM7z4BcpHEDEAbQvBLg5zv3AHiUvclKRMTwjH2wp5qGP+NIZK1tjt
 ueHMzjWocgTb7TTNCtSZY+qjVoqOzUB8lr9hSTFPd6bXvzQDnXFRmovhDa0w1Od/jGI/M
 OMaaGbwaN3WsqY5aq44jpZ8gmGnmfm88CO5B8P8ccf7InLHTeQk4TnVoiOHSb810OxUGr
 N9IbBNKNcj5lZxnctufarLiaOS+v4pbO1O07/ijwNaOKbI4XyKEk4gyfScg85vC4pLbZ6
 Ff91lM7A+ICnr0+oqVbFclJxdz2SEz97f8Nt1JyY5IlE+dhDa6DpIkTpjrU0gRcUv8g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZeQeteq+; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZeQeteq+
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCBE8408ED
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95D3560267;
 Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1DD1F00898;
 Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483419;
 bh=6E63n4T9KloA5p468HTbUp+pZU0q6o/eLuL3jEt9Tw8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZeQeteq+guIQvhIIAz6B6SV7mKX/ASaTOP6nYBDTPanuvPyr28b+XQIh7xT+nI6kL
 UPA5y6YgFZ9BcQcm4gci23rVrU/gBJSzvupyy67QaIjVRR3ixDjPH9fl79OQBVB8B+
 OYBqB3CA99yP0p7OjXYDgu7hheb/D36FA7FMcR/eZdYyxieBtqOTeO38ZA5Gcz+rAr
 iGknsCoRj1504l4VVN4lBWi04TUVUAjJuiyymmIUhwnKVQh7LGkdFeTXCOZMbrwiCq
 Y+iclUMcPfHbBTUL2pTavwR056SvYYodXRuf12E0HmcNCdWNa/FD/eaNmkr22vR0Bm
 D0/r+uyimiMwg==
Message-ID: <sashiko-outbox-164447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 7/9] netxen: use pskb_may_pull() to pull excess
 TX frags into the head
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-7-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-7-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:16:58 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] netxen: TX fragment hardware limit bypass due to unstripped 0-le=
ngth fragments
--

commit daf1ad3622d94edcda5ee23317b335a0a1a7de23
Author: Josef Bacik <josef@toxicpanda.com>

netxen: use pskb_may_pull() to pull excess TX frags into the head

This commit replaces a direct call to __pskb_pull_tail() with pskb_may_pull=
()
in the netxen driver's transmit path to pull excess fragments into the head.

> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drive=
rs/net/ethernet/qlogic/netxen/netxen_nic_main.c
> index 67d9bf69f8f29..202deb64ddefb 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> @@ -2045,7 +2045,7 @@ netxen_nic_xmit_frame(struct sk_buff *skb, struct n=
et_device *netdev)
>  			delta +=3D skb_frag_size(frag);
>  		}
> =20
> -		if (!__pskb_pull_tail(skb, delta))
> +		if (!pskb_may_pull(skb, skb_headlen(skb) + delta))

[Severity: Medium]
Does this change bypass the hardware limit for TX fragments by failing to
strip 0-length fragments?

If an SKB is transmitted with more than 14 fragments and the first excess
fragments are 0-length, delta will be 0.=20

The original code handled this by calling __pskb_pull_tail() which strips
0-length fragments even when the length to eat is 0:

net/core/skbuff.c:__pskb_pull_tail() {
	...
	int size =3D skb_frag_size(&skb_shinfo(skb)->frags[i]);

	if (size <=3D eat) {
		skb_frag_unref(skb, i);
		eat -=3D size;
	} else {
	...
}

Because 0 <=3D 0 evaluates to true, the 0-length fragment is successfully
removed and nr_frags is reduced.

However, pskb_may_pull() returns true immediately without modifying the
SKB when requested to pull skb_headlen(skb) + 0 bytes.

This leaves the SKB with frag_count > NETXEN_MAX_FRAGS_PER_TX (14). Will
the driver then program a descriptor chain with more fragments than the
firmware supports?

>  			goto drop_packet;
> =20
>  		frag_count =3D 1 + skb_shinfo(skb)->nr_frags;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D7
