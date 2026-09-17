Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E0FC982CF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 12:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F2CC80FB0;
	Thu, 17 Sep 2026 12:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KX7mZ7bKDwh5; Thu, 17 Sep 2026 12:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 641FC80FA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789648705;
	b=IW8r8+imFZaGCPueR0ucSICABlFHpi2GyQvTqQWaaahtLge6OvY3ULR4EoFZuHeGaHEL
	 s4tOc4CY+qjbUQMF0FlZLad7Sqwl497gCl8FakCH/qKjeamohRjTtlnx+RZuO8PSzvwer
	 4xdp9CTX7CJfY7iRHDTuCdeNjyiq/0wkG8EqT844frpPvw8cYRzuxop86ovbheBORFory
	 kH9ThX14ptlgtGDqvxmLlzm+MlyAGm1lc1qgWPefsS4shtRcSWtJ9t81zKGSOzNirGkoI
	 SqfXQb1yAvUOvU6za6XDzlxBvwy/AmQPcVIAQ6y4BkyyEp3TViRG+pJlTGkrlvSRHXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789648705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xiw6JD0mGbruaKRYNthmS3f5yAzK9ERtaAMH4k9HdGY=;
	b=XEt3TbiyB6SPA8NP8lq+8mrkVF2qcCK85V6Lo/0LIdpyq0uEXLUEKB1M80U9JJWPXdyp
	 pBRWA7EB4Ybi9z47nN5rm6jXJV9W+6wK7EbK+EQDfrcjHNUYfupTlDAdK/2GIQf2+Q2fs
	 kCMlvy41Pib3z8uuyOyzHC+cfcCnE0+b0YzowHWiqqq4WBlXGSVUQW9+HqEDYi/x61jQD
	 8fVXL2Z8zwx6VmZaO1YJeAST7xFRQLFeRu2FtCGIh24SWSWLKFleJCHoArRhwF3xo6KCA
	 vrkIFDDnVaR1azeiBsSqKrl/k6SdEJTpDreUIuIaBBJJRbHYXG4E+gjzuahhs2n07zQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789648705;
	bh=xiw6JD0mGbruaKRYNthmS3f5yAzK9ERtaAMH4k9HdGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKGkN97xmeS288XEhMeEEacf9oIZ9HgdgTYujJVm0GnS5asAcT4PUsQbyVc941gy8
	 d/ACkTxFCbDFWxOCehlYIrcTbCGOm7jCe8+tKjVaP7/Kfvh4jB91+xRMA8Jf5hsUY2
	 mpSmFHRbWqSpF9gG7Y7OY0QpZYdDxuOjeizF41DX6jSzAvhMJH+UmVgoCoLN0D5K+/
	 ZsBsbDLnjEUwuoq0n80Rpk8mvaGNS2jB1cNHYm4B2/Sd8abSQwmZZOyIctfuAbDsV9
	 pMccD/v2sG8EeQi4QFaSsKvT/N351tnVba0cDwLxO6US5nm6N2iwv4XZqYz1CRUlyC
	 KgRNyhMqMZIHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 641FC80FA6;
	Thu, 17 Sep 2026 12:38:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DC0829B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 12:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BA2D40367
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 12:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jMd1jkjkFike for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 12:38:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A2F0D40355
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789648702;
 b=kRT+fLi6Cv5MFYUk1GyEpmg/rHfP4I3/JP0bMZhNuY/Lj31KcQCbpRRyBObhHcRQfbSX
 K1nKzawSOsWzRN11DUDKmZ+JsRuTXSNAYnxHnF6zLdGmwJWBX3j5I5vW6YEDhyo1o7+g8
 YEJIsSMNJRepKhszP67oyaJDZERndcZ0hD0TYCn0XQ74MUpHWp7FAvjNgI3hMOkb3UXBK
 65jemYk+j5X/oag8ptx2+6a1c23Uh8j5ddtQkVfT6MkT/GV+celUAr6fbJ5j98L8+BIQ6
 0pZUKcc3VPwLh8EfRHKCFPiBwt3rXTgZ+wRRiT/C5CrlZE9vTLa+xwpdo8yXFqPguAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789648702;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=xiw6JD0mGbruaKRYNthmS3f5yAzK9ERtaAMH4k9HdGY=;
 b=aIKxXcR0g3e4PfruWf85Yq9w0OX5QD6LeDtd2fa4mhrZqKlEM1QcN63v0UM7eyAz5RgG
 ggxbkOqKp2EQbdfkuMDzfp88HFVXp3fUQgZV3xcabUioQgFpmFBtR/eKwJHEo+TnF6kOo
 SMqt+1Ua7tHJLoCHzjPY0qADNS1TURAtZINXYzBs5VSEo8yPFK53i7xY2W/gFMXprbRSU
 ey+rXMWGNI1guOi1zh+JMFJO+m27cCBDDTOClj5c/LRT3XKHcAssjcjmXjGMDe3bYv8fh
 3+y8lXeoPNDiXx0N+g5VVQpOUaWUlDDU+CPLH/XC0AR/I9k2TWi5k6lsAu7ruk5zjsg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=o2Wqq+MH; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=o2Wqq+MH
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2F0D40355
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 12:38:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C3F341B0C;
 Thu, 17 Sep 2026 12:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500631F000FF;
 Thu, 17 Sep 2026 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789648701;
 bh=xiw6JD0mGbruaKRYNthmS3f5yAzK9ERtaAMH4k9HdGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=o2Wqq+MHA4VOMPU24ZCaSfBTukzLme9ZVKB31gBnMPSV7RoCjjNUQKiNwezqjU5Sm
 tsOg3xImOwPmTXVcv1iLqGjSa4o9yDB54hp9RBmlck6zzcDL3xAg24TmWbkHOH/juO
 kGtmMERt2h88HcMMItasXlCIJghvMCJAXC98Ceb/u4IeLmzFqQ/UdzdQwsRkOuiFXz
 0GYbq3voAkaFQdQVnHXfpIgJ3vnN1ClkQH6jAmc42QDDI5EtuXr6MFX2eLu7tHk9Ij
 PMmpnaMSji3eSqBQTqEqn+HzsrqwlZBHHFtLFRp1TvjoNXuSnV6upH1N/286DRDgUZ
 VyvqG+4bA7bwQ==
Date: Thu, 17 Sep 2026 13:38:15 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
 Kiran Patil <kiran.patil@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/2] ice: fix TC flower filter priority
 violations
Message-ID: <20260917123815.GD51261@horms.kernel.org>
References: <20260916144130.2699902-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916144130.2699902-1-poros@redhat.com>
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

On Wed, Sep 16, 2026 at 04:41:28PM +0200, Petr Oros wrote:
> Two fixes for TC flower offload in the legacy switch mode. Both
> address the same user visible failure, all traffic on a port silently
> disappears after installing a filter chain that mixes offloadable and
> non offloadable filters.
> 
> The first fix covers filters matching on ip_proto alone. The driver
> never programmed the protocol lookup, so a filter like "ip_proto udp
> action drop" was installed in hardware as a match on eth_type ipv4 and
> dropped every IPv4 packet.
> 
> The second fix covers the interaction between software only filters and
> offloaded drop filters. The E810 switch gives drop rules absolute
> precedence over forwarding rules regardless of recipe priority, so a
> lower priority drop offloaded into hardware overrides any higher
> priority filter that stayed in software. The driver now tracks filters
> it could not offload and refuses to offload a drop filter that would
> bypass one of them, keeping the drop functional in software instead.
> 
> Tested on E810 with the OS default and comms DDP packages, including
> the original reproducer from the report, L2TPv3 pass and drop chains
> with and without session ID matching, and a shared block bound to two
> PF ports.
> 
> ---
> v2:
> - track one entry per cookie and filter_dev pair so a shared block
>   bound to multiple devices is protected on every binding, and the
>   delete path drops one entry per DESTROY invocation (sashiko review
>   via Simon Horman)
> - collect Reviewed-by from Aleksandr Loktionov on patch 1
> 
> v1: https://lore.kernel.org/all/20260910154824.3603687-1-poros@redhat.com/

Thanks for the update.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

