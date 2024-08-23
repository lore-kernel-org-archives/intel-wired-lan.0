Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7823EC5321E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Aug 2024 16:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D95A81EE2;
	Fri, 23 Aug 2024 16:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOLzzvCUT1nH; Fri, 23 Aug 2024 16:12:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BAF8840FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724429578;
	bh=GDmgzM18AR4kgHWMOqghfxnL7L88TBAxhls9HO35X6Q=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lBN2CC43255qa6vTpC9o/SF8emavOn5GezJq3GCHY77J91UB6oeXlN7q/6FX+O3El
	 q8XRMqHDYmI563xcSTMFgmNmRMUGT/M+BC9+7wX1U56EorXeuDQK6xQ6te9YE5+gCB
	 jI9t5NAq+e91bWhh2s52jPVfaB+tbzMO0QUNO1eHS+WOYo0YO1/Uc+7PXBc2ycdk/9
	 fLxH6cO5QkZDvHdcgaY9G+Tbthx6AP1rlo700JduWDQv7d8G8HG3kRAtWmcPtPsWny
	 pDyJfxfyZgxCBaeBa+N3Yys7ZoxKo5K3gPjQsTwe1pFM3nhht0qkRdTB2EwR4ocu+F
	 ZX3CZ952pMUXg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BAF8840FA;
	Fri, 23 Aug 2024 16:12:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5B54E1BF31F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Aug 2024 16:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47743612F4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Aug 2024 16:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BCo0VhbPsFpm for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Aug 2024 16:12:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A0E5E612F2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0E5E612F2
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0E5E612F2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Aug 2024 16:12:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 80ECB60C2A;
 Fri, 23 Aug 2024 16:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDC9C32786;
 Fri, 23 Aug 2024 16:12:51 +0000 (UTC)
Date: Fri, 23 Aug 2024 17:12:49 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <20240823161249.GV2164@kernel.org>
References: <fa4f19064be084d5e740e625dcf05805c0d71ad0.1724394169.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4f19064be084d5e740e625dcf05805c0d71ad0.1724394169.git.christophe.jaillet@wanadoo.fr>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1724429574;
 bh=dAdbo0TqfFoi5PbDsGhs2vdI5/DTn9XfQXIoKzTq/84=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vM3F3Dae5jX70rFa0kVt/XDabfLLc4fMTbgp5j9oaf32ry38B1Hu5isWTBKZC2kCU
 f/zrbGUMQHmUqrskACQk2rqG/Kvs11n/HeTnLEKQIn2Gd917cp7Qm6Sc6OCaIoa2A4
 qtAhnvHr0pwFIjkD9TgCTrwz59+w2lDritKc1NpDVWlb2g7h4yzGDbZwmI+Ju0oQgO
 jJ4b8Wv3o714WJgS6trAH5i7SCPGWXK6ld5NQA2kKavKFQZdzmErvKkA3pm7Ow07ql
 jibTIEoxOHUr7JP4znu5s+kWDWCzmjrnFkUuZ/Yb1SrwAw+bfvJhhGrkZi8bwoau7P
 S1AMtvj/GcfTA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=vM3F3Dae
Subject: Re: [Intel-wired-lan] [PATCH net-next] idpf: Slightly simplify
 memory management in idpf_add_del_mac_filters()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Aug 23, 2024 at 08:23:29AM +0200, Christophe JAILLET wrote:
> In idpf_add_del_mac_filters(), filters are chunked up into multiple
> messages to avoid sending a control queue message buffer that is too large.
> 
> Each chunk has up to IDPF_NUM_FILTERS_PER_MSG entries. So except for the
> last iteration which can be smaller, space for exactly
> IDPF_NUM_FILTERS_PER_MSG entries is allocated.
> 
> There is no need to free and reallocate a smaller array just for the last
> iteration.
> 
> This slightly simplifies the code and avoid an (unlikely) memory allocation
> failure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>

