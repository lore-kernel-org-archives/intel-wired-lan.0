Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4610FCA9ED1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 11:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C92DA403F9;
	Mon, 12 Oct 2026 11:37:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAFc1rn1rXWP; Mon, 12 Oct 2026 11:37:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A696402F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791805042;
	b=RxEI6ajsIEGX7VHqzNZP3lc5dkud/+tHlMO/HUC3z/f49aV5d9rho9cAK9IdWat/VJFk
	 T4kV4Wr1W9LkM8XAI2onbpxUaF1TCWa3lFcbwCinB+HdcTCN0a4dOLMD5di8ezwK0yUAO
	 2gsEDXsbvilkl0CVhu1zCE913T4cyx/yxab/Z6RHIuJe4XNcdRI/k/QzkXFAbdc8Eitqs
	 UJy/xSQUYUcXpkaNCzdqZaOFNM86yJXn7XzBXfD3E+8yyXZ/7BzkLX89gR2WdWlbZmVTh
	 hnVI2u7tRxcLMS/++yQ77xU/xxOEv7bHZvyFPX2ZuNTHMq6i5DHkL/xbQ+RKCvgNW2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791805042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=lUHlc+jM+U+AIodoo3PJ/Gaj0BpzBHwEW2r/Px3wQyI=;
	b=d9ayEH1ohq0II+sdAkgDM9tYL51VWOtlGviBIff83pSmYXMVufmYH0zz3+k9Y3dEgqey
	 FxJQgiA/f91aa/5ehA1I2sKUvsVA0y1Q543E6cYN4XIw09SvaYO3QvbWPrcKpHArlTCuu
	 GclC7tkSkHguIsV3EderoobSc7/7vpAyTE5KuYEj9QLaFp4HQT1CrM2CaOAiBHn3nggrb
	 myxYszhnOh3RbfzPm4Mizo2mOt2VMaQFAVOSkoEtwZv5dkcvrrCraBAKQLiA2GG0ZwvVh
	 tPuutLJhNv3MlaC1YEEDtF6RcMJ3Xh/wgWnRf9Oc25AP9PbK4yKhGn5oFQAdz+w7gDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791805042;
	bh=lUHlc+jM+U+AIodoo3PJ/Gaj0BpzBHwEW2r/Px3wQyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=R5rCooyjIr88v+mMBaFXwGuwPBoL2mcLoJu0+aDRaW/Im5ubDKtu0AuVMVK3f5bAI
	 n1qdQZoXcgZvvpCOvPA9dZhY9d5ETFF760cMncBEVfwzYqEro8wTtDllsHVvXpomtk
	 oUhdofdWA24lrnPy4FSpdzuMayKk1uD6KVKQamKFp1MQsgSU4S4xqqatvKXkcOF7NI
	 nkTb8Fi4FTi3e9W2yS+X9dhQ657diYixXTFqZ0eytfccXvRDOkVolmBjj1aT+lg5m1
	 falHbwExTqNFo+MGD98X5WYv+3QtKNEvkbtAjSxDVlvdmH8UoXFv013lsblfSQwmqm
	 zWbC3ppt9YrCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A696402F4;
	Mon, 12 Oct 2026 11:37:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 81147380
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 11:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66CFE40182
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 11:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CVsDgZBqB6um for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 11:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 873E940076
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791805039;
 b=QzcJDcg0PAAlzR3NPKf+SbyphAGCeDmPMKnxZtcDiIC+Xpdn4ETlWHYJRGthMR4srJXh
 s9ro5YwhT1CnMZfTBU1KlLoj93NjiivZQQKcjn/FqBgW1hLKsKnIOlHsgjDkVBvS3+KXL
 ZqZy7iF+sUlXdrPF7jJgQbhkFKkpktL6s/kEybCfX0hsMHBbT9Ox7rtNMriL2PkKlL7O2
 mOxcNOfTozLjdCszaD5mWdiQmSA/waGWKTznZDCBGd0YfZYZQJBuXnjuyfTgoOEPeF6RB
 97ijmNs6V33KyATzS2M+XsrP5g+BwzJ2/5P2vGr68mWsfEJlsvlJdOZJlVbGDy8xRSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791805039;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=lUHlc+jM+U+AIodoo3PJ/Gaj0BpzBHwEW2r/Px3wQyI=;
 b=bLrJm+4j1ikRw6yWWXp3y62Oc5lzfcmXx+zLXfjquXjKJ1sCndF0c/gWgo0UdqDLQ/pY
 MtSQHhhEmH+4NtPt30nNDbmaOaAjI19TbzgFtLQSpu/ZjYh0RyE3S1nw+z28UglqcFgZL
 oA9LrplTyxdVWOm2q0pT6NW3toaiUEhEIg6layE8IbMWhKM7zfCK75YAY9j1S2g4VwhDf
 bHi/IJ6ib8YhqKAFq78BeslvxFHgrmYNUFQkR/NwSnJQpwLf+9qfCC9mHcOrCh+e/1KSg
 TwSbIMSBk6eqCBHvnoeMMWd/6vzfEqvrR6JQiJy02p11LPrrr9QmhDVbiIyYdmAHycA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Ja8Jt3/o"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ja8Jt3/o
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 873E940076
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 11:37:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC50C60229;
 Mon, 12 Oct 2026 11:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C9C1F0089B;
 Mon, 12 Oct 2026 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791805036;
 bh=lUHlc+jM+U+AIodoo3PJ/Gaj0BpzBHwEW2r/Px3wQyI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ja8Jt3/oqJELSxoIckmDKv5FqWNcqsYWCJP4WeEO+W3Bk4n6iNKMAalhzZqH7p0MM
 o4pFjgfHoCzptEkZ/y2WY1zQldV10TMHuefFsEPwz9CltyWVZVeDKW+PmSBKEbj7tb
 Rk4n8eTSN9lCyVWj3HGQGC9tmERmjORzoIICM0AbpxxaAz2zwj/1J81QPjwo6kW28P
 xs0Luee69UiA8IVzxnhgkck55JQGO5Q7YDFNVq01fdU2ht0BkP7S2NIb0HO5ooy/fC
 yN5GegECtSUEb9TrS95CK+AlK3fA+ZSBQ68dryv17aUNviPp9NWXUEwfkpgk4TotUQ
 3agHtkK7BaHwg==
Message-ID: <sashiko-outbox-168021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] ice: correct PTP register access debug messages
To: "Alok Tiwari" <alok.a.tiwari@oracle.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261011113545.16718-1-alok.a.tiwari@oracle.com>
References: <20261011113545.16718-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 11:37:15 +0000
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
- [Low] ice: missing trailing newline in debug message for threshold write =
failure
--

commit 3dfc5e0655da8eeda86700792eb12011c421ed4e
Author: Alok Tiwari <alok.a.tiwari@oracle.com>

ice: correct PTP register access debug messages

This commit updates the debug message for PHY_VENDOR_TXLANE_THRESH to
report a write failure rather than a read failure. It also intends to fix
newline placement in PHY register read and threshold write failure
messages.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/et=
hernet/intel/ice/ice_ptp_hw.c
> index 3a41c711e751b..289e0b3ef6ae9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -1529,7 +1529,7 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw =
*hw, u8 port)
>  	err =3D ice_write_xpcs_reg_eth56g(hw, port, PHY_VENDOR_TXLANE_THRESH,
>  					ICE_ETH56G_NOMINAL_THRESH4);
>  	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to read VENDOR_TXLANE_THRESH, statu=
s: %d",
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to write VENDOR_TXLANE_THRESH, stat=
us: %d",
>  			  err);

[Severity: Low]
In ice_phy_cfg_parpcs_eth56g(), is this missing a newline at the end of the
format string? The commit message indicates that it fixes newline placement
for the threshold write failure message, but the modified format string
still lacks a trailing newline when ice_write_xpcs_reg_eth56g() fails while
updating PHY_VENDOR_TXLANE_THRESH. Should a \n be appended to the string
here?

>  		return err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011113545.1671=
8-1-alok.a.tiwari@oracle.com?part=3D1
