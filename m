Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF26EEB7ED7
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Mar 2026 11:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E9B9812C3;
	Wed,  4 Mar 2026 11:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQIhz3MJF902; Wed,  4 Mar 2026 11:43:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE8F581281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772624608;
	bh=DTcZCdONX3KmlChow/JbVOTEHm3osMmIN3MSgKchrkw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0aHZsVsFEHjbKNyHJfmb4ftwllA0/8D0kKBoMzKPojkLCdmoWSp3ttpsQrnO4ipQd
	 uJCTgrHhaVKGsMT73Lp4pn1ZrV4SuyV6b8SYSLs0Ac891/jRnEL7F2fz4O9oR79EFn
	 rcKFfL1QerPFa1dur1rtCSSIFTanp3lGe221+qs1amWRfOGnKGvQbNECzLQ0e921fk
	 yuxuoXPLMJ24fmF/q1UNqTjMt3hYM3B9kwYvuEdUSMosISnRPQlcxsZ8//hxkNstpW
	 tGn81EKfTrtdGMARg3dzKI5IBHn+Gmy6TxqotkQJNii/EaUtyK5vNhtx1W26mBmXoO
	 T+7zD/juJwcQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE8F581281;
	Wed,  4 Mar 2026 11:43:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A5751EB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 11:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27D778126A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 11:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TnjbrKQcVS-f for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Mar 2026 11:43:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 89ED68125B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89ED68125B
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89ED68125B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 11:43:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 84F9343627;
 Wed,  4 Mar 2026 11:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC93C19423;
 Wed,  4 Mar 2026 11:43:22 +0000 (UTC)
Date: Wed, 4 Mar 2026 11:43:19 +0000
From: Simon Horman <horms@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Airlie <airlied@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org,
 David Laight <david.laight.linux@gmail.com>
Message-ID: <20260304114319.GI71509@kernel.org>
References: <20260302011159.61778-1-ynorov@nvidia.com>
 <20260302011159.61778-5-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302011159.61778-5-ynorov@nvidia.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772624606;
 bh=RdeQxpM446a30snr6DksUquAKJ3HbafVGgNp+XRn85U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SXOmIPJbVZrOiDQdxxHApj/MW4tElG/4y1VDKOns6EUYefWrdr3Nr/hORg0FG/nKl
 sf1jwiYbcTZbeo7mP4eRySpZJ31b4r6vFlDZoXwGsaYxUbLpzcmLCpyPBnaQMF2w6D
 zSU46tKdc/tDIq/9Axq5QIFsmPRUOfKWlu4Ek0SCjV2XwQQi5WJbOW0k2GOs11f74U
 HNyTzaWEX5p6CpRYLaPACt5i/fuBO1I2z9ZS7nlX24pj9dCw8AZa5ERaK5bSsLmVrP
 zWxfSaQ2ripq1cTH+j0Ox0ed/JrZaAKczpFk/forHoP1khftNCM5CvekS5OYqimc8h
 OnrLrF99lt4nw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SXOmIPJb
Subject: Re: [Intel-wired-lan] [PATCH v2 4/4] drm/xe: switch
 xe_pagefault_queue_init() to using bitmap_weighted_or()
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, Mar 01, 2026 at 08:11:58PM -0500, Yury Norov wrote:
> The function calls bitmap_or() immediately followed by bitmap_weight().
> Switch to using the dedicated bitmap_weighted_or() and save one bitmap
> traverse.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

It's not entirely clear to me why this patch is included in a patchset
for the ice driver.

And it's also not clear to me why, but allmodconfigs - fo4 at least x86_32
and x86_64 - fail with this patch applied to net-next [1].

ERROR: modpost: "__bitmap_weighted_or" [drivers/gpu/drm/xe/xe.ko] undefined!

[1] 2b12ffb66955 ("net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout")
