Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C375AF327C8
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Apr 2026 09:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EF2E612B4;
	Tue, 21 Apr 2026 09:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30YcXuqhHdiE; Tue, 21 Apr 2026 09:03:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A08AB612B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776762184;
	bh=1kyyDE5e21bYjmPhVqkHNcLYxbJ0U27DltQ/VHT5LJQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0LGsSdycmzXXYPg/cl0ROXp461/zhlRFg+2OIwwUfydbZNGxSHnlqYUfDFxSISNYX
	 d2zex9lYk5dgoqvIbtUy1gpvcwQyiWd+tP/WQaewDXQBxs7v3t0vf9s+l0bfQ8bgxX
	 yCDpyA0qDaDXHrybN9kjjSXo5Os6XX5UQDUp7E1x3JPuHCn0L9WaEMwH/qH/dhzy1E
	 y7B08Xa+K5LuND060+g/mhZ58If0e4+hHow/ztssz8a84qvwC3QnnDcSgq9Hj1I3KC
	 VuDqTYfH+Uxe+86SX9f6GzNrriX3EY1yl2IasWy/uYgF+kZ9KMSUEM5mE4dOj8lm03
	 V1AafDXyvRNAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A08AB612B1;
	Tue, 21 Apr 2026 09:03:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 97FFF24D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Apr 2026 09:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8640183DCD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Apr 2026 09:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQZgHZDVh_uj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Apr 2026 09:03:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E370783DCC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E370783DCC
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E370783DCC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Apr 2026 09:03:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B02F44116;
 Tue, 21 Apr 2026 09:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765E9C2BCB0;
 Tue, 21 Apr 2026 09:02:58 +0000 (UTC)
Date: Tue, 21 Apr 2026 10:02:54 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Mitch Williams <mitch.a.williams@intel.com>,
 Aaron Brown <aaron.f.brown@intel.com>,
 Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com
Message-ID: <20260421090254.GW280379@horms.kernel.org>
References: <cover.1776426683.git.poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776426683.git.poros@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776762182;
 bh=IEJ6LJnEjNWGmodZMyE/CMbkC0WeFWjPZXCMP+gk6s4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bnewWg7W3/r/Kjb34Nql+lE28RpJVx1afI7U0D99UBjTN1wp2NN30jql1O0453c0D
 NFoVBA6S7RvR9pGxh/77ExoEs9T1sLUBbMxLW+MPc36qXBw31iC1waBnKSAWgyDViQ
 HtEByGWAc+9Aen/GA5IkIZkcXc39d+M4QALGaDyyTf4Rynqhj7/ycvzjbYliZWhWZL
 zGiEiICZt8crX+5PUdCd4qp4N2tPvAYdT1MY59PcVJyPmtpUHWAhfx0Gq4fG4SurWD
 yUPSIaQimQ0io9qZkpvYxqYa1dQ+SpcqGe5O5vIyNzdPvjRJYPRvM4HmmH9Jdc8uYY
 Iqu6m77CV2iug==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bnewWg7W
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 0/4] iavf: fix VLAN filter
 state machine races
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

On Fri, Apr 17, 2026 at 04:29:41PM +0200, Petr Oros wrote:
> The iavf VLAN filter state machine has several design issues that lead
> to race conditions between userspace add/del calls and the watchdog
> task's virtchnl processing.  Filters can get lost or leak HW resources,
> especially during interface down/up cycles and namespace moves.

...

Hi Petr,

Sashiko has a bit to say about this patch.
I'd appreciate it if you could look over that.

In particular, the feedback on patches 2 and 3 may warrant
some updates to this patchset, while I think 4 is more
in the realm of possible future work.
