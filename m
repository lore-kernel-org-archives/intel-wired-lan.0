Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D3BCA9EBE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CA8D40850;
	Fri,  9 Oct 2026 21:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jxhLeRJuhpz; Fri,  9 Oct 2026 21:04:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D238640949
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579847;
	b=aOR28nvalr7Lf5L/HlkVePAPtL5YIVkCJJ63fKN0lvcLBocc3EYo5+vyjYGguHeu90UH
	 xOBYHOjEknY55vj4na9yszLU3qhW0wB7jwo9/kElh1wYFYjEMgV9r3OWbjhRckKK5zdne
	 10jncR11fc7fOTps1XKAmB6zqY8v+EnFLgiwn6QrviXpDytBZMrJIWpwKDs+pTqYMH+0J
	 JPSLmFSwyEzwCU8tC6TJ/SpXe9a1v+J4t7QPIjEbIY2RYS5FVTZhl9T6vPxXqtc10vETY
	 p1ms/WxfbBhN3r3q/32EzkuRe75Kyh9UN8MEwIgZsri1X1VqytXIcHGzoY/o/NPMN5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ktw4isPussffvf3zg7H/FNhg2iyZ60DBUB9rlpHNVAU=;
	b=fn5VqYGZH/sr8eDlx4BgtGJU5njHsjhpLHN/qR3ZOzjBiuAWRAEsOVxGES5DRUmktWJb
	 aou7RsukwKmX6FfWHMbhqLs1nBxzoXYPH2gETKb5AASci1S7mbHx4B45Bc2RtTVCrQMNS
	 WxTsxrwLquf0DpH64y62kLE0XG+PMahlYWQOXFPpsZ8PlqLU1MnqzXhgW79Jml2PAefF4
	 8sU8OWUvkjm5y20SHfY/v94ZfBOEhJL0vqkfaH22q8NySFwv/HE8n/fII/KiX5DkKV5B2
	 O6pBdip+o1fWhDb+ltpNkRqEhcNo7px3pM+ELpxiY7Ik9GFHxlZIk6ZM3Zix6XssO/g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="khY/4M0v";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579847;
	bh=ktw4isPussffvf3zg7H/FNhg2iyZ60DBUB9rlpHNVAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=lVYHrqnuF5RVPlAwd/I3i95bbip6jy9/yd4VmJt2kKcgb1NG8E+X4Uum79V2Srv2B
	 3gMZ7dsUJhP16l5dDnEvb2uEL98hmnLrSwa03fuwJ1DTahUbqBETNedf5a3UYysW4i
	 VAmDr4untSgyiptAquFJD7RgXqgomYx+XcB7rdG99Ja7sQee5vFoQS0wG9cpMdbCt3
	 /pN+T4DE0vMc9hmhzyEPxNaWX5TKfDIevYtIsygIz1O+mzDJheiHDh+y5OxFlk1ufU
	 dNyjcK4G9u6wJvsjwJwjyEBj9mxfpquh3tHaTXbnPz5J4ko4uaJqL8HlWe1HsFzDAW
	 5kbDfHMh/t2nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D238640949;
	Fri,  9 Oct 2026 21:04:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89A1375
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BB1040891
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87kJQxqYka5Z for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:04:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B570240850
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579843;
 b=gcL8/X/k+QTCUzV46imH4WqWWM1fMF2v6PXOwev3yjKI7o2USfmWbkX3zleHE32FlyzQ
 aXOn7e+K8czG4KVRBcMZVzh2vW3XDVFxxdxDEHVezF8Z8D1X9yM7E6/kzmwudfsX/Dpzk
 FmqzDbUo+ZxSHJ6cXB29F3YmnfY25MugfD52HC95ItHdMN8gtnIiW1GKoscliRTIIwelD
 J/u4zW1CASkFiPa5TA+DquD2YeYKiHd6mjwWue9NA5JYDX4IDUNhcqBUyb8H9NmkfZ95M
 4jvQGF8q7Ps8IcZYjsr6BMpcwaOHJXdNrAfIqoX7k8ILgYd4CLoF9mY2/mGYYRtkjGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579843;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=ktw4isPussffvf3zg7H/FNhg2iyZ60DBUB9rlpHNVAU=;
 b=rGaApciRihQQF9ujLdP+p4Q0inddUFxYpEmPqMCFEudgCdnGnwi/nIGgX5LigUgLZh5+
 8iBBbZwmNMZdfJsUWBCTzYyEPwun0J2EE7cnCEVQRXZAlzHJpGys35PehOHYew1X2U+DI
 5+J0/RpWU/ubHVEbZtDbo3YQOXWWUEModyl3+U7aPmPcJl19kdVzI7rc7ETuiZIubIQJA
 NxKTi2LctJtpA7wVoh85UfyuYPiPxFcxcmTMWQYyt9BI65BiV6YXm/j2uT4Qp92r58SsQ
 TQOyXG/I5X4FracAEmH58/AW1rVHCHffpUxirBxiv2c7kF2wXdyrtp8g4vvsTPtzcew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="khY/4M0v"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=khY/4M0v
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B570240850
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D15243901;
 Fri,  9 Oct 2026 21:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C8B1F000FF;
 Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579842;
 bh=ktw4isPussffvf3zg7H/FNhg2iyZ60DBUB9rlpHNVAU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=khY/4M0vZjihjUgvzdEMx0Vv02E9P1wrUXeAKuvfbgwlYgOYtz/BwoUv1BGFdZCcQ
 VHLWyJexxFtb5KGJQyXdAvYvCJ+7DEHHYX23OuQZefRBXdVRf0ESZm6qFyIJtB/w7W
 ZmMBK3t2G5544/UYc+YL8TAd1jnge2iv8judqlAOA4Tk5DSK4hnuGpEYoW76HB+7k9
 XkNgRAcnZ6P6/K/DucP7Z2qex8CH77qatIgR0Qk6bFN+cIkz4O7FHu/bLeGSOUEif2
 pOfDe+KIN/ocIsoARu8BrE40sQWv9sQHm4KYMJKxTgIwho31YNBQ+hfHN+Ep4cgHSe
 shc2vZz8Rs3GA==
Message-ID: <sashiko-outbox-166074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 07/10] e1000e: use pskb_may_pull() in the
 82571/2/3 TSO workaround
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-7-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-7-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:04:02 +0000
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

> e1000_xmit_frame() uses __pskb_pull_tail() to pull up to 4 bytes of
> payload into the head when the head holds only the TSO headers.  It
> already checks the result.  Switch to pskb_may_pull(), which takes the
> length the head should end up with and checks it against the skb, so
> this driver no longer calls __pskb_pull_tail() directly.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D7

