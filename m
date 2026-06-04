Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B1DCD6E57
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Jun 2026 01:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E14584882;
	Thu,  4 Jun 2026 01:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wz6dcIFsP0NZ; Thu,  4 Jun 2026 01:30:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8814E84865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780536641;
	bh=QGiIv2EogEHFCZ6gLG2NuS35JHQ8K9sawD/XXjwoGF0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3KKTe1mGuZQyWle0QUOIVVICTbGs5qLEWOto788QVZ4NF3FbqT9N68lxLVWKDAmR9
	 QWZW/60jdTLXLVKakNbpB+Sj7kJmAXqY1tr+mkZ61LIS1Yv9UDbYybZWaoEBy3uKWo
	 rrArwU+e+ts+dzOUKxKIEUPSQn0mdxqhW7cWOz9hO/V4e2+9KtkcA+sT/RNnV0fCNZ
	 7i6nr3Q243F+GV8RQWP8k/H551rJcg9Xsd68Xz0guvbwJlq6TjSnUX7sY10RVh12Om
	 Ds3ckEMOMQS6dRh5kMp6porPlnBOKn473DfH0pZ30Yp3J1Kcf5x+s4q2+uXB35awxC
	 ZSfidcwjNcpbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8814E84865;
	Thu,  4 Jun 2026 01:30:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A0E33192
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jun 2026 01:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89C3684865
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jun 2026 01:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LlI36WPoy4RI for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Jun 2026 01:30:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DF10A8482B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF10A8482B
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF10A8482B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jun 2026 01:30:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7C39401BF;
 Thu,  4 Jun 2026 01:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40C41F00893;
 Thu,  4 Jun 2026 01:30:36 +0000 (UTC)
Date: Wed, 3 Jun 2026 18:30:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20260603183036.7c4762d2@kernel.org>
In-Reply-To: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1780536637;
 bh=QGiIv2EogEHFCZ6gLG2NuS35JHQ8K9sawD/XXjwoGF0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=mDXMH5T+YgYjpWjeRD9wgaNvXS+A9PsVLasvd3/bHaBsfDJpmwoIC6+SxyE6T4jc9
 FKSTZuH8YzcVuGuxLHf6SGTHraEQTvY/vwfbGSe66Yin1QwmFaHdQKY4I5dLiuqvZR
 O3z9MmlO8QnjkahcqgmBvTsXzeGqtanyd6BsUevMZxZu0g1cn0WcIURVUIVsZsaWBC
 DWS3c6ng2vdLM+3FR+N7TfhrCNncFBy4bVxr3eNpLVRqgIHjGPZd9HRvgUYWI67wR4
 L4N1B27UGhpI93qDtmqoRd9kR6R59ZT4Mk/WtIwjXroHHYS85fqkthPi1lVxHFVxze
 kIy/MCgZlQXdg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mDXMH5T+
Subject: Re: [Intel-wired-lan] [PATCH v12 net-next 0/8] dpll/ice: Add
 generic DPLL type and full TX reference clock control for E825
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
Cc: ivecera@redhat.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 edumazet@google.com, netdev@vger.kernel.org, richardcochran@gmail.com,
 donald.hunter@gmail.com, linux-kernel@vger.kernel.org,
 arkadiusz.kubalewski@intel.com, Prathosh.Satish@microchip.com,
 andrew+netdev@lunn.ch, intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 29 May 2026 16:26:20 +0200 Grzegorz Nitka wrote:
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].

I dug into 3 of the issues reported by Claude here and I think all
are really preexisting. But I don't see why we wouldn't fix those
first, and have a clean AI scan. Please send the fixes ASAP if you
have them, if they are trivial they may make it for tomorrow's PR.
-- 
pw-bot: cr
