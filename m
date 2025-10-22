Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCD3CCD1BB
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Oct 2025 14:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 736E8409F2;
	Wed, 22 Oct 2025 14:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OPFM3iz7_C0N; Wed, 22 Oct 2025 14:38:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF82C409F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1761143923;
	bh=/coiQbSe12Q5krk1URbQ26p769UEH0Xgzk14Hhsx2zs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dclOLuHB+UDSIiiHqMTuydOfIYy3+29rUle3WhtSzFGyCH/TniWKppmVpArJWZlJf
	 yQE9Dr/AZ9nUnfeXPNQzqrsXTPe6S7tzvbsBJB0s0YTET5rJRUJW1d7b08bntOMRWv
	 F+TQohfonJBArsmI2T34Bges7pEZrJS0gevm1M95j5kUOBc1ZnXIKcK41kK92kx8cR
	 lmfIjcbxaV5GBmlh3EXfUVlFcNuepYFa1Vj5axS5sggpnY4vrCWZpGW8pPP3zenU7m
	 9iR3FNWKThyjnkJzqSoTL+aj7o9P4HnWS/lsitG5ofHsVsgG7ZK3ssDY7bl7YZLpVk
	 EPBaZZlK0D3Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF82C409F1;
	Wed, 22 Oct 2025 14:38:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAD3970A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Oct 2025 14:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC1F383626
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Oct 2025 14:38:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pMKRlYLX8Qre for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Oct 2025 14:38:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0BFA283265
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BFA283265
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BFA283265
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Oct 2025 14:38:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6448860209;
 Wed, 22 Oct 2025 14:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABF9C4CEE7;
 Wed, 22 Oct 2025 14:38:37 +0000 (UTC)
Date: Wed, 22 Oct 2025 15:38:36 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com
Message-ID: <aPjsbGYDtohQaAy7@horms.kernel.org>
References: <20251021184108.2390121-1-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021184108.2390121-1-alok.a.tiwari@oracle.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1761143920;
 bh=5OLoP/JafLChQU6zqWjThxLWCd9/hPsGnsvrMaiR+CA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P+h/Ls+RjFImMpD83TtltRkQ6BrDJ/DcEnv8tD0j6ZZo7s06PmTY/gCZtQTzepef+
 YwUzY/7FslYtyZ8PII1aamj7oujylD7o7GX1U2s6VKWSot+Oqpf0qLGwcFpKth608J
 6dCAABdcDK6E3ksU/9cTrLdwM12GFpVMzz7Y/qn4P+rOEDwGr/SPhPl0oeitGMG4XA
 WeWEakHkh8mim9F0Km7cnAJCaRDUzpIzgbp7OK5+1SHuIyO1vTR6cUvFeRmA5GRV+U
 D4wZG+tNlQVIni1DjWxYwdxgKLljKoUurUyNy8+R8T2Jwyg1jll+tK/yDYbv8IZoIM
 9XWDyFmwtxUZA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P+h/Ls+R
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] idpf: correct queue
 index in Rx allocation error messages
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

On Tue, Oct 21, 2025 at 11:40:54AM -0700, Alok Tiwari wrote:
> The error messages in idpf_rx_desc_alloc_all() used the group index i
> when reporting memory allocation failures for individual Rx and Rx buffer
> queues. The correct index to report is j, which represents the specific
> queue within the group.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...
