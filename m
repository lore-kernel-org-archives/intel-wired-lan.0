Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05186C79FB7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 00:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7773B4076A;
	Thu, 10 Sep 2026 00:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6MD3UsNn1R2; Thu, 10 Sep 2026 00:50:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E4066407E9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789001444;
	b=PkPFbIN3IJrasC4vlSQHDg6JfGPWLG/C/0jTL2hvLbzqfhGee5f7bkFuYRnDd3nbqp+A
	 Cw84yQk/OwqgvIOFTlA3HZOOiumGaFjOljBBVVLdtJhraCwCRQ3BwFG7W4ixoey3/4jK9
	 lEHWhhu+pfuNzwxjqn5oXTyUU9kZLaoF3rWkOClULfwELAvPv7XpGO1Kc7u+k1etye4iB
	 28ywKe6RZWSQ47pj8fsuStT/Ia5WymhOdDU5q7tUT6o2admgWkhrO9dL7RQ1SmXKMWtV+
	 ZEvADIm8RruoFeS2Awcd1aYBdQSLLnvljep/E6sHTg2LqQEIgmFna0de9gjoHAMIQIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789001444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AUSqn64YUdfo6g8K8mt+IbHKto1e+nIlwSperkdCI9k=;
	b=iZM37JNC+cTMUgKzz31AbSY0Pn0f+A51IsJ/4omdOUnLK9bg/a0++KS/adgnXSoLqW/l
	 lHeU0pCOm2SkXFCUts8mh3TmJ3i5YWaTNqyQE9QFgkWd4PA4cQkH5NpWZQ4tII2SGiKpp
	 nxMoKPHMZE+NC61QwmMNm/DGJWzDE9qoNzUq+L4AN8ol+mlwIGYKPYwd9dlt1q6Hldkb7
	 OdKAhItP6hun+JuZ0NuY05V5qtmPJBQFz1GpR2pP9eGmDWigWLUpANYtsrdALrCndDyBE
	 FOWFeuQMTTjwfQ9TOetLaqPjVOl7rJiYlBV/7apieRSAWKYmXmtyWXPcsddaNl3P6OA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789001443;
	bh=AUSqn64YUdfo6g8K8mt+IbHKto1e+nIlwSperkdCI9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wftcToj2/086tkev20pmM+n0LJ8EMXlUNoXhENm2nQVsykM09h73z8dug5sd5XTn6
	 KDmq762wnTL4zUcArK77e+aYz9UuuLL389yiwFLOMq/QolBZpWLyEG9x4qil8vx0JH
	 OwwPGtVgU1fKgvKMlj8LpuHVABDn6WGBwjwbZ122Sesj/AmZ+nLhJfPCKEczCqN5UD
	 0jNSOUHxg6FGgHQE9DIidaApXofSOkmCqliUWzF5GhkvzMxSOJIHXCPil7zY04I7YT
	 6vcfefDoPmbepjsnaU4l1TrZ8E+b3wxkAGJCYet5NqvOQalHoqQ9G6J1nPXUiu7RIU
	 0Z5Ee7Xy1SVRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4066407E9;
	Thu, 10 Sep 2026 00:50:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B080014C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 00:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DA0C4005A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 00:50:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVajDXART2o9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 00:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C4EBA40059
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789001442;
 b=D9EJW+BnkAN2/VcYKGK/11Wkjfjgw3poH2JwaYE4VnVn49YpmBxv1W3xQCA9DGqHXJdr
 qZZ9uwRJzIVksTsne1zoIny/Fu8rZyoe42ZKtyBRlsCXQxw4D4BQsWcWd9r84sgG9pW5t
 gHgxBz2xJuIzLovjhO/wnhO6fxOdihrOm6GF/jBYG6DbkgUGvsjYA1v31e85D7ecXQYRa
 manulZcgIGk1PaNOAlxdo06Z6tZS76fwZd9EbfosBhnjFk52mZy5mGxzphy4damdubjcN
 L8v5jmIPsJ2zrwBUjUzmyIU3ORIh0mWmkJTlPv96xKeVKfvLTFtPMkUAFJ4OOAuqmVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789001442;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=AUSqn64YUdfo6g8K8mt+IbHKto1e+nIlwSperkdCI9k=;
 b=kpHpf3xN2Th2ucZ1qFfPVLeivQ9XdsTVI/Qh695zQ13+iy9uTwNYJtcLaKg+E6NckC5k
 wVZpe+HmBAAGRXRlZqMfmwK0DlageS7KkrqZqDyOSRU6CMo3PPf5EZJeY60101+rDim5R
 xBCGPulS1R9AMJJiHjbbT8fKuwkO9UxIoEwMtZMBzanrnO0qEeszyROf4TgkxRzKKrxcs
 71cln7wy8C6zQW5Uea3T+cX2ZE+Be4J17A2SFaK/RX3Qr9mhsIm6QY4Lzfls4XJlay/xT
 qVPnAZPKf/M7l9qRTz/7MLL/PQLHNRPqg8nXoNFyLEumt+YaIfoJfkHw9g+yvvY7x/Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bVH16en9; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bVH16en9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4EBA40059
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 00:50:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CD5F408FD;
 Thu, 10 Sep 2026 00:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79931F000FF;
 Thu, 10 Sep 2026 00:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789001440;
 bh=AUSqn64YUdfo6g8K8mt+IbHKto1e+nIlwSperkdCI9k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bVH16en9C+TaBgytEXWkNqD0miCCc7zQ1X565iWLbt0QuEbUwxMDup8KnJAR7FFIt
 BASBRwhllvvAeDud2fXaposD7XIStImzOp8cs2LzcSPO8PlPkOZtfg1U9pesVvlH8P
 oKXt80H3Gc+qpyu+cgqn9A0ghj6VrJBdNTa0KruTzQHm/8ioNFYuTOX8FDuhshuq9H
 UDvIifoW1z7CS7PUUBO/983IR/0dGKzNRJ84qGEmRdCGUwq2hINR6FgDWQK/cYX6cz
 WKAhihb9IorrrB9iOMsdp1i7xmRbi9YvpwgLbEf0/d/11IVoGB8qBzCRmZPbAOyV4y
 BnFp4aWaRd5cA==
Date: Wed, 9 Sep 2026 17:50:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Hemanth Selam <hemanth.selam@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
Message-ID: <20260909175039.5149a58e@kernel.org>
In-Reply-To: <e798b454-1f26-4502-a705-9e32dedcdcb6@intel.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
 <e798b454-1f26-4502-a705-9e32dedcdcb6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 9 Sep 2026 14:07:25 -0700 Tony Nguyen wrote:
> On 9/7/2026 2:54 AM, Hemanth Selam wrote:
> > Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
> > misspelling list in scripts/spelling.txt.  Comments only, no code
> > changes.
> > 
> > v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> > maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> > each subject now names the component it touches instead of "net:".  The
> > series is rebased onto that tree; the diff is unchanged.  
> 
> Thanks for the changes; looks good. However...
> 
> netdev maintainers: Everything looks good to me and since there's no 
> testing to be done. Did you want to take this directly?
> 
> If so,
> 
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

SGTM, probably saves everyone a little bit of time if we take directly
