Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905BCF36B96
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 00:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EC6582B5E;
	Fri, 10 Apr 2026 00:33:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqkxclQUls3L; Fri, 10 Apr 2026 00:33:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E954F82ACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775781235;
	bh=sBoqYaddh3B9neU97+9gXWbck2g6i5pr5OTt9Fq9NGQ=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3HWpuRnkMjZvN6am+COyawq9MDP/6vbbImK+sxV1XQ7UJLg+r7tJ4W5FX4ogYxsB3
	 rFpE/bPjpZ1Ms9oS69hIhKxvUkMkwsKG/1kmMw9mpSCzJWEAqFWQSMpQbhu4PmA4BF
	 yuz599jBk/FYpJd/c2BPYoueIqRQ7B502hwOLXcjXfzV5KnZfPrdDsNzNEavJAGGbM
	 K076AHNk0hoIau6Ug2urxRJTVZZGubi7XpcomXbI0BxP5YDtr4rqlo3ROGqP0YcQXT
	 G5f3lJ9PRBX7VZYk4Kk2d6GbuGy9DaF7+zukNp7PJX3QhopQ5e1wIC/XYxrZNHoINO
	 CmVX5KxzvJ84g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E954F82ACD;
	Fri, 10 Apr 2026 00:33:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3E00237
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 00:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D10CF40810
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 00:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hchmot13hO84 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 00:33:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3F80D400B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F80D400B5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F80D400B5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 00:33:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D1D444094;
 Fri, 10 Apr 2026 00:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5DBC4CEF7;
 Fri, 10 Apr 2026 00:33:50 +0000 (UTC)
Date: Thu, 9 Apr 2026 17:33:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20260409173349.61d98cfd@kernel.org>
In-Reply-To: <20260409235122.436749-1-grzegorz.nitka@intel.com>
References: <20260409235122.436749-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775781231;
 bh=sBoqYaddh3B9neU97+9gXWbck2g6i5pr5OTt9Fq9NGQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Cd2fqneSkn29qcgrq9l4VD1aTCDoK9euVWf+4nzYHKUsQVTdPmaZDPqoL0fCmzw3j
 3AjmHBAnoTIEs1zUX/wXwa3Ogih52lJMi4iil4c+W2W9zxWKU1HinXIMtnDdQwN//g
 N7ZYXMGd++q012lUNYvol4rs0QG6jqNvUoipGWmhzXs89JpQdf/dtsJq5AvhX7Vuph
 mAqLFIAg8jfSs+0IcB32IpUHiHmfUOdVtpfS08jDd1J40nouk/czyAMdSFbMdbvqE2
 JVJOfjnLGwErooG4sTx/+JWuOFP5HKBX8sorGIyMGrMGtF4Mw++aLSh7tHRTnOCERi
 EZHf+BaiC9Mtw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Cd2fqneS
Subject: Re: [Intel-wired-lan] [PATCH v6 net-next 0/8] dpll/ice: Add TXC
 DPLL type and full TX reference clock control for E825
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

On Fri, 10 Apr 2026 01:51:14 +0200 Grzegorz Nitka wrote:
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].

I LOVE when someone takes 3 days to respond but then posts the next
version the same day.
