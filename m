Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4367C3DA4A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Aug 2024 14:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 93D9640529;
	Thu,  1 Aug 2024 14:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FHFVzELoFRzZ; Thu,  1 Aug 2024 14:23:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DAC140373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1722522219;
	bh=Iq41YRN9NLyT6KF0VccYpXs9qj+oJ6LdrFr0JOAYHPI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=EkCIGAESSHzqXr2VUHBz6BV+CQa3G7SOdkWvGK6wavUry0VNQjQVP/lBUFPIrD0B/
	 kcFtKUbfKCWqt5k7MuKdsPId5F7vp0DFjjjycM0fFpwVbTpExQFKlEm+OLne5NQo3y
	 FBENPs1JDndBNp1Ic4uy63HjZgrx1cj+42rkiDKpARmyhaxdTqLSXi4enBN2ybGh28
	 fuDtEFDGsZZ8z4G945wDucVa+AvkGw7h3SFiF5mN+CNa4lUDmLHzvFaDpOX1xdZNqW
	 VIbkW3/ZThvryRYxzNiLFkFv3bkMQswNS/p4F5haBCSm6JtSm/56sZE5RMxPwg3I4K
	 T7yEwbB1wNwQQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DAC140373;
	Thu,  1 Aug 2024 14:23:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 49B6F1BF47E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Aug 2024 14:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 372D360616
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Aug 2024 14:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TiWwwTRFmiBx for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Aug 2024 14:23:37 +0000 (UTC)
X-Greylist: delayed 1009 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 01 Aug 2024 14:23:36 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0475560615
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0475560615
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:237:300::1; helo=chamillionaire.breakpoint.cc;
 envelope-from=fw@strlen.de; receiver=<UNKNOWN> 
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2a0a:51c0:0:237:300::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0475560615
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Aug 2024 14:23:36 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
 (envelope-from <fw@strlen.de>)
 id 1sZWRt-0000qM-5i; Thu, 01 Aug 2024 16:06:33 +0200
Date: Thu, 1 Aug 2024 16:06:33 +0200
From: Florian Westphal <fw@strlen.de>
To: Moon Yeounsu <yyyynoom@gmail.com>
Message-ID: <20240801140633.GA2680@breakpoint.cc>
References: <20240801134709.1737190-2-yyyynoom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801134709.1737190-2-yyyynoom@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=strlen.de
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: use ip_hdrlen() instead of
 bit shift
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Moon Yeounsu <yyyynoom@gmail.com> wrote:
> There's no reason to use bit shift to find the UDP header.
> It's not intuitive and it reinvents well-defined functions.
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 360ee26557f7..07c4cf84bdf3 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5731,7 +5731,7 @@ static int e1000_transfer_dhcp_info(struct e1000_adapter *adapter,
>  		if (ip->protocol != IPPROTO_UDP)
>  			return 0;
>  
> -		udp = (struct udphdr *)((u8 *)ip + (ip->ihl << 2));
> +		udp = (struct udphdr *)((u8 *)ip + ip_hdrlen(skb));

This helper needs skb_network_header being set up correctly, are you
sure thats the case here?  ip pointer is fetched via data + 14 right
above, so it doesn't look like this would work.
