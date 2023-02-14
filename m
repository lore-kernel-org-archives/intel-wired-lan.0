Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C74C636D4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Feb 2023 01:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E27DB60FCE;
	Tue, 14 Feb 2023 01:24:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E27DB60FCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676337846;
	bh=TkJzYo8LMAPmZ+vxD8xhDEyG1DyFVGi0cdap3JOubHw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MH3hVsKrI71gA5M1MUNMUm15dfWcFAsPkmZAoGoogAeXA2q1wfItnlFl9bMgT3kk/
	 D1fGYYrEeXv5ixVhYqVf48zF01I3XqosmOMkxZ/dXEDs/Wzj+m7qb++3X/dbjXpj9r
	 qgpmCEhiNcPutewRLnaiCrAzgcu8rqHXuNfZWXfzrnedJAsMKiD2KV+G2v2uRBIcOh
	 GU3JvUUA0x290gmWdUMsvCaKDjNOqAU26B+CbXKrQYd/wafSeg3OS7iO3WNAycvOFW
	 Pl1vhRJ2LIb7g4eK+FXjbvq01EKZg/97R6GtyjdACYteuB79VKwp1Nj9JbfJ+qc13A
	 LRD0B2/kI4QaA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z04l70PtiEZ5; Tue, 14 Feb 2023 01:24:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43F4B6103E;
	Tue, 14 Feb 2023 01:24:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43F4B6103E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DD41E1BF2FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 01:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C25DE6103E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 01:24:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C25DE6103E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e9EG1QHhw_cL for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Feb 2023 01:24:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEF0160FCE
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEF0160FCE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 01:24:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0F357B819F0;
 Tue, 14 Feb 2023 01:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D1CC433EF;
 Tue, 14 Feb 2023 01:23:59 +0000 (UTC)
Date: Mon, 13 Feb 2023 17:23:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, anthony.l.nguyen@intel.com
Message-ID: <20230213172358.7df0f07c@kernel.org>
In-Reply-To: <b564473cdefc82bda9a3cecd3c15538a418e8ad2.1675941199.git.lorenzo@kernel.org>
References: <b564473cdefc82bda9a3cecd3c15538a418e8ad2.1675941199.git.lorenzo@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1676337839;
 bh=4Mg73KO/6cnO9s5+bxHqJ1nhg+DkXONIRoBCiQYuFG0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S0lPTVdGcQq9UEpG0S0VSKk9ZppZ3KQwdSZj/Ms7UKIJW3dJxOXlL2P46ZpIjW5eZ
 ikOl8h6gjob9d0EPAepUN1T3JiQ7r69KQld79rn/ZowE7yfah0E5cWFTw1gIx/6rJ5
 1kUoDiLg0fXFY52HcFLZFTkvd1dq6HIc9esTkJJVOA8ivxBxg//DLb9EfrYnPGGuPk
 KZ/Wkem38AYw1nG3pJPskZpirWOAVwmcuWuRqjCikP2UYGtFuKeKn0ypMQYHoAHIbo
 H8RuR5uwS2oQoKMaRdLtJ98MpSbqAtS4KRpXFn6yu+HD6VwT3zNNF+GFtA07e4xDi5
 rvY8je6ksYrnw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=S0lPTVdG
Subject: Re: [Intel-wired-lan] [PATCH bpf-next] ice: update xdp_features
 with xdp multi-buff
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
Cc: daniel@iogearbox.net, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, jesse.brandeburg@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu,  9 Feb 2023 12:17:25 +0100 Lorenzo Bianconi wrote:
> Now ice driver supports xdp multi-buffer so add it to xdp_features.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Let me take this one in directly the same as the other xdp_feature
follow ups.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
