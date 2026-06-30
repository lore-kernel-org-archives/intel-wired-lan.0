Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC383C43327
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jun 2026 22:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 940B840802;
	Tue, 30 Jun 2026 22:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVt73vrMiyyM; Tue, 30 Jun 2026 22:50:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEB5F40786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782859825;
	bh=4/7TjGJiqZagTrJvi7kpMXuVrILhpW7k/6RtBUpwu6w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6zV5HChCImxOVOWE7K6w23oxjmiYztgsH1rkA4y0F3GHsC86IQlgNpEiX2XgqFpXA
	 gLBMmzxbkd/a06DKO4VP6d5sSBaMyRamQbWdaHuH+ejma5THBT9YYFDhcXavuFpK2C
	 8hnoRKADuCg38s2bOPW/8f6UyunGESkZooyzoqmYynhRIivDQYwcWeUGw5t6/v6iJT
	 ACRz+LmaZ7RZ80pSLTdtFiLeuvQ+xNoPaftgXh9bIMGGwCY1uyuVTe+YdHjQDS5FSY
	 qMhSyznHl2rVF5/eep514DpDFOnkn3nn54VQoSZtzL1nHY6A/nmM/rT/y5uNAqtiqf
	 9OaVO2rboNtyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEB5F40786;
	Tue, 30 Jun 2026 22:50:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D717F149
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 22:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2BBF605EE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 22:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvGJJfOG_4RP for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jun 2026 22:50:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D796E605DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D796E605DF
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D796E605DF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 22:50:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28685413AA;
 Tue, 30 Jun 2026 22:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA26F1F000E9;
 Tue, 30 Jun 2026 22:50:22 +0000 (UTC)
Date: Tue, 30 Jun 2026 15:50:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <leszek.pepiak@intel.com>
Message-ID: <20260630155022.27c9a271@kernel.org>
In-Reply-To: <35ccefb4-a588-4556-87c0-ade880eaa8d6@intel.com>
References: <20260627095400.3c3d9f80@kernel.org>
 <35ccefb4-a588-4556-87c0-ade880eaa8d6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782859823;
 bh=4/7TjGJiqZagTrJvi7kpMXuVrILhpW7k/6RtBUpwu6w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=nbS240E4fkTexZ4KVCGleDZ6Ui7AHYGBZBuASvkTzuaeSIbLK1nSTFFQ/yDpAjjZg
 hj8N4tVcDPKDNeqKTPUPVyLv62PEEdI5l1fPkXhcumUuUlEzii30PgKS4JDe4/3hZB
 Go6hwcMA2VWjQsfmQiPY6Jr+WT/Ud6sL15ntoANXHAdqm/MOoQvyV6520L/4xFqcgq
 so4pbCqCnWcwgrBeUG777l9Wl2vwe2CD0nEEUNVoUxYXwHRtJTYuxCJ1LOPT8KH4HL
 bnW3wkCkQfukIBzjLmqWjr9We7pKuBqWCBE7pCKz4QE6uBjqs+pBQdWAIWX3Q6Db5f
 Vmkx8igg4Or6Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nbS240E4
Subject: Re: [Intel-wired-lan] [TEST] intel: low timeout
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

On Tue, 30 Jun 2026 14:56:02 +0200 Pielech, Adrian wrote:
> On 6/27/2026 6:54 PM, Jakub Kicinski wrote:
> > Hi!
> > 
> > Some of the tests need more than 5min, could you increase the timeout
> > in the runner to 10 or 15min? Looks like it's hard-killing tests right
> > now after 2min:
> > 
> > https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/xdp.py/stdout
> > 
> > which leaks config across tests:
> > 
> > https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/irq.py/stdout
> > 
> > BTW the JSON reports the timed out tests as pass.  
> 
> Hi Jakub,
> 
> I've increased timeout to 10 minutes per test run. It seems to help with 
> XDP tests score.

Great, thank you!

> I'll later take a look on default behavior of runner in case of timeouts.

default behavior == pass/fail status for the test?
