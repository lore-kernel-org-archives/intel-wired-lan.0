Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DF4C4828F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Feb 2024 10:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0348242E0B;
	Fri,  9 Feb 2024 10:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9MDYL0fc4x5P; Fri,  9 Feb 2024 10:34:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9508F42DDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707474868;
	bh=AJQy5UGBHzknm5d04QTww9QtDS4v3ipAo1xPHJwfCD8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Oj6SsSAdOD47O7W1K1dv2vSG4pePYQPvSHjucJh8QY9xPZckLhIMmHPDDareoiDwS
	 vIXQVvkyGWSXHaZTc9XLNrXZmaaWnPW2LLESbZOp6XNHMA8UriX5ajdDusUnFqepQn
	 oaLxCD6ZBTGKWgs7FgmB83w55eFZrMB/7XVhUoKjsrTwKOtwMcIvE48qF5zoIZJ76/
	 uazBQ2s7FWx8rjKz+beex7+vHTahDftWc8q/fgVJB+aZoycyShZbn67CGqv3otfeoE
	 MngO1Tx+XHuYASr8iDFYE0WbjBjC8kitWnYWwMNlwNWFBWcpkujbCqxv8IKqsJMgja
	 9KARMSlWWIgsA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9508F42DDB;
	Fri,  9 Feb 2024 10:34:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id C635A1BF31E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Feb 2024 10:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE3A041D41
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Feb 2024 10:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PvmTG7tm2bUy for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Feb 2024 10:34:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BBEC841C75
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBEC841C75
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBEC841C75
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Feb 2024 10:34:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8A87A62063;
 Fri,  9 Feb 2024 10:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0922C433C7;
 Fri,  9 Feb 2024 10:34:22 +0000 (UTC)
Date: Fri, 9 Feb 2024 10:34:20 +0000
From: Simon Horman <horms@kernel.org>
To: Alan Brady <alan.brady@intel.com>
Message-ID: <20240209103420.GD1516992@kernel.org>
References: <20240208004243.1762223-1-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208004243.1762223-1-alan.brady@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1707474864;
 bh=/ip+PIOjx5aTnWVaExLgigrHBVUJrumlV+cWrEQb8pw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OWMkJEvFO51+vQQBv733lcOiUqHYEYNlPL27MGRa5/8y7E8TUFNSq5jwr/7ETs+sk
 UtKpJ9KvDwRQsRWXtmZs5AQlGyJ/3Uf35WCXb1ekKgacUqC1Fh+NgfV+DMrH6LCqS8
 d9g0pn/N4NRCILbbEkA53b6VFMdMvf9esrCivA03d1ou+whWEwy7gIdsaL4XAOGvid
 xzFRmVgKSJJjCAWNtB32ISQCpFGzaTke0Ne50PebYqsgSPC2fndKJIhjo9T8K2tYWt
 17oxT5qR6WQLSmbaeZ5sPydtzUyW20uHv3SfcyG9wa0ozLNkBACPG09NYS4Dos3OV2
 nWvfWktOOrlvQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OWMkJEvF
Subject: Re: [Intel-wired-lan] [PATCH 1/1 iwl-net] idpf: disable local BH
 when scheduling napi for marker packets
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Feb 07, 2024 at 04:42:43PM -0800, Alan Brady wrote:
> From: Emil Tantilov <emil.s.tantilov@intel.com>
> 
> Fix softirq's not being handled during napi_schedule() call when
> receiving marker packets for queue disable by disabling local bottom
> half.
> 
> The issue can be seen on ifdown:
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> 
> Using ftrace to catch the failing scenario:
> ifconfig   [003] d.... 22739.830624: softirq_raise: vec=3 [action=NET_RX]
> <idle>-0   [003] ..s.. 22739.831357: softirq_entry: vec=3 [action=NET_RX]
> 
> No interrupt and CPU is idle.
> 
> After the patch, with BH locks:
> ifconfig   [003] d.... 22993.928336: softirq_raise: vec=3 [action=NET_RX]
> ifconfig   [003] ..s1. 22993.928337: softirq_entry: vec=3 [action=NET_RX]
> 
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

