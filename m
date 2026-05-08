Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D7ECD3436
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 14:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C684261631;
	Fri,  8 May 2026 14:26:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hEHo705e5R5M; Fri,  8 May 2026 14:26:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 23BE36162E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778250408;
	bh=3wNpiS4ugDaedwdUXfX9wOa0RNBzWD4K4bSjiChbX8Y=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uqZwbWnDASozNpI0ffvsTG8XnkvL7CYnZDRIK+VDcmI8Jp0a0cj/pdYyAK+M4t/F5
	 rRHUkjnkfZj2TGNRmOpwHYrFMJDWYRHXy4u+yZGPlZxNSmyIU3XjN+p9guVzIqf6X9
	 VfJ8WubxB3YZJ6tq+NujftYSOYNj9/P+Zh+cQgK29sG08sWVwNlWmGm2uvy2RwpreX
	 tseTWDgo45nK+JGzDYA82OxxB275qi5Axb2RfQceTn2hs6uuyG1wVSRCUyxfMXwoMS
	 8nlRJWiJAo8qQu9xgJ8jSN+Of4Q2zkqyZ8L5hjnMt9esaKzne6CngdBm6erWpO24V3
	 RIcWB19Ghazeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23BE36162E;
	Fri,  8 May 2026 14:26:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D93AE358
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 14:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEF5040E75
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 14:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iTiGxxmKwv3R for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 14:26:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E80F840E63
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E80F840E63
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E80F840E63
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 14:26:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 671B9600AE;
 Fri,  8 May 2026 14:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C65C2BCB0;
 Fri,  8 May 2026 14:26:41 +0000 (UTC)
Date: Fri, 8 May 2026 15:26:39 +0100
From: Simon Horman <horms@kernel.org>
To: aleksander.lobakin@intel.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kohei@enjuk.jp, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20260508142639.GO15617@horms.kernel.org>
References: <20260505152923.1040589-5-aleksander.lobakin@intel.com>
 <20260508140758.1200568-3-horms@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508140758.1200568-3-horms@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1778250404;
 bh=ZiN/EMgSDxuZs/BBhHBaRIIV4dNVOUbLJZU0Kmmg47k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rQpSxrCRYG35baUcJLL8n3SXZsTYcmz30I4/Mfc+xnMtmR9TIV40Hx3P5VvxdFvgX
 ZeQwZ97nz+Yn6DIv31JZRFEQ3pQxajGDvQ9aHZemb2Ef4vLdp0kB22jq0+0uAA8dM/
 ysGOttieaAiiwvLH0KRVNWcE5RCrhONbKQoRN9XHPHj0m7r08IMsxdLBncoCYh2qe4
 hGAC/kOebTq3VQRyjo5bVynAjummKKFQF809hhwy+FBBvkY/w+esf/1zx5wml749q8
 o+i0REg1U5fKNaKxp9LJ6Mn1JZ1NGq1D9wdFF4pBNWWtZX/eAe/Xn434Y2Nw04lwdU
 vJhnOgW+bmCZA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rQpSxrCR
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 4/5] ice: implement Rx
 queue management ops
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

On Fri, May 08, 2026 at 03:08:00PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, the line above should have referenced
https://netdev-ai.bots.linux.dev/sashiko/

There is also a review of this patch available on https://sashiko.dev
Which I plan to forward separately.

...
