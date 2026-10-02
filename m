Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881DECA5FC4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51C1681150;
	Fri,  2 Oct 2026 09:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id esxlgqEoQKSd; Fri,  2 Oct 2026 09:14:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8A4CA8115D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790932495;
	b=auDCYuW0INOVS2O3NJ5u0D7pFiXgcrwGoaoLGHc5wg021/0xfDOEtbxVmC/PMUZLLpxs
	 Ag77vxmwqxgOwzzxpNblypCeSPd/f2oEfyzBhwLeIGzEt2Ye6qtVs14wkwjmvCYGvRLgN
	 VOwQAdGWufGRTuEzu6C2tB8scrwtTA7uqnENaEw16Ww7JX7LZEgfgliLTAQkUJaNNLvRr
	 xU/H9csA/NxbHVZIi6B4hcScQ5Q4dTZ+BNphKDkDfmHPJmg4k2Kfzbsh4QPblOJTbUiTE
	 fYhS6ptVfwLR06In1duR8/sxYI2m+GgWhWMYCvkejoRyUQKMjszqZhgeTJefuYH4m/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790932495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=n9XPVzmamJ9SFi/utHDiLl0mrcfA1+JtJQXHpWb3o4U=;
	b=L+CR9zUzsi7o29kk0RXz8YGWYU5z0Sj0cJUrVNRUNj3j7vF8X5jnu5W60UbI4k5MC1Cr
	 ILgGZIfTZ77d9zSYojnH6u8vdh7H8xmTm+wjqwU81sn0KKyKrZlrM5GBqF42MxUcl5dhE
	 DNvhQRiit2WcjP1UtYe14uXrLxIzmNrPWKVkZL62pO7OLZmNi724MTEBwL9sem+JyNg4Z
	 4jEOvV2A/8qXv5E3z4/5h0/19vIbq1WrJnP+KUT+8WtAXV4EEEe77FpBQeTp2t6Fucgyp
	 teUNwAEOYXH/msts46H/OAiah0Jgrr7Qp3mwbeae4PFL4PTxFGwAjpiHs5AbQJBtsww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790932495;
	bh=n9XPVzmamJ9SFi/utHDiLl0mrcfA1+JtJQXHpWb3o4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ped2uwEHV2P3jK/5nxQmHT5dSmtR4yIn/Yu3mYHf26oBUceGAY68LnTvzX0bv16+1
	 OdmScOtL+Tgu4AjQL+2Z0nXplhfMG9ynxS+bfMK4FqjnUtw+eQIF072J63G9mhIwZN
	 q4j959YZuEVYVDja6+XfsCLVseHnXXJQz7bJ88adhhzVtYjHlxD/fdAgShaG9Y9nnF
	 qqrbUwhUNgYfqRpqO5JqweQrmp8VMSr1omjVa7SnvQA8Vwp/PuBXPdXBXyS3ymKugz
	 Cx4LoRJQrbFP/pPMxn0IOixZHF/deK8NkpZokDCQW7PoSVA2ZZ9jqdDTEU+2sc0p7J
	 3iCCwPVapwrBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A4CA8115D;
	Fri,  2 Oct 2026 09:14:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D91783AC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB5DD40CAC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1tTEbooNAb-6 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E1D9D40BF0
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790932492;
 b=H9GZkeT76KvxZKC5kKItM8q0GblbdVNTvNlx9L8/LWK+1BMJIV3IYc6fAmK/0aNO0dy6
 O9mFRF37AYCrrP6HsXDEJK8VakeGKiAjkl4lgKzapcRMQhNbwJ62Yh7Lfx79aqVu4CRbq
 DHF5mhGP/1EZKlKBEaE/VDDaFgnQXPYWlHQwOMPrkxUIlc0S1mQFtuB1tp8UGmmFAxd3Y
 pfH79Oe4EwmzlU0vXnPUU9jYCUAzUqjN1cpG2UvpeaUdRazpYSuEaEqohWB0sU7xlUNvH
 ec39BhfhjG2OgY82kHC0gi8IYPMUZNZ3eFRXb7vasDwrb/nFZcKhYwDnCodMvtf5Gyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790932492;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Reply-To:
 To:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date:Message-Id;
 bh=n9XPVzmamJ9SFi/utHDiLl0mrcfA1+JtJQXHpWb3o4U=;
 b=IyMzjFZHVBkkcCoG78RyrcgAgGowMpqNYt3Hxyc9cJAQoFZFZQbGOnrmPvAbTw7k/lJG
 xyT1eJST5i+RTIrcRGVJyggpNGDZjaPY3FBWq2XsMx+dUN8w2XJMHbVYZM8wpsB63WrF/
 1vUqR+ydtxVp4FVvtP7iPEglJ7s6WYjg3mWTu/q3dFhXmriMjY43Za8LlxX1MOub0r+1j
 g/xQ6ad0xtuT8cPfk2t3r6AjGl2Hz+dr9/F/MPrcIv35glP9Bfyyt8DrEiEp1zkm2lAds
 Up2E+qtZDh47xn9xBp6XYlEnJj10YcvUNl2479fS64GuGVb0/74sdbpMVtFSm99DUnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EEahz5Nj; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=EEahz5Nj
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1D9D40BF0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8AF860A6A;
 Fri,  2 Oct 2026 09:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0911F00893;
 Fri,  2 Oct 2026 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932489;
 bh=n9XPVzmamJ9SFi/utHDiLl0mrcfA1+JtJQXHpWb3o4U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EEahz5Nj+zMjRDGaJzTrt/4iq1bOhqMLFzGVZ2+IoN2ODPjnT6Xy6zevlL0xTh3AM
 9kabDeQMi+jheU1Wea8uAdqJAe5K/LUZPY8m4c0FkaXSbXL1KTKlhfMN+Wjq4zB4TY
 /9yP9sRUvvD5kp7e87XPaB00IHYmhwynS3mYNpRB6zIm7N5oCdqAGD3os7Nm0AKF2p
 HM2KSFJKNwmfQwgwSvXn0CIVOqUtmomEmKVBvrJ1DKoRFrncm3hwVn6XJNzG7YJhdg
 eO+BVwFtIgf7khY7KfXLP8xiF+iPWZcy1syRdICbVWG/00rsjQTtQG3VQgg82EYQGT
 oHW2J9d/Y/D6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] module: Remove obsolete __MODULE_STRING()
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-hwmon@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 linux-modules@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:48 +0000
Message-Id: <20261002091448.DB0911F00893@smtp.kernel.org>
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

> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Remove __MODULE_STRING() now that all remaining uses have been replaced
> directly with __stringify().
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-str=
ing-v2-0-fc7438acaf4d@suse.com?part=3D3

