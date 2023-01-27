Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3932EC61DB3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Jan 2023 07:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C20B640182;
	Fri, 27 Jan 2023 07:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C20B640182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674804788;
	bh=QCYwjlXPxEthJXVnhSzCVF8z7Qmr6s6FV+OyGPDvyjU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dl+0OGwLg4MD38bu8OAif2UtqGaGMBCjk+pzqQUp3MeXNZLeIZhzd0W3kWRK/zV9e
	 HkhIjVZngMLHCHTPkcVHMdRcgHQy0xqK57LdkwmI0kNmrrm2Oc+k3pGQsGnEPUgpFU
	 uU2VUzq7ls3vgG2brEDAS6NRABJcCPAPs6JFqAKp98wWXp1gCw0HDrBAZLphO8Ro6K
	 lKjdqO5HQoazax11h/To+5gXkt7IZ2+IoMOjPNYsZK/bkmyLFeetMq4Qw96H8XHWBg
	 Rgf5UMyikLsqI5khI4xOiWKR01cKmCoZ+VAD6/wJlOzb9MZEPye0K51W0rZUuV8H1J
	 mm8wRAZuEA/EA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYqtp9yB-V5z; Fri, 27 Jan 2023 07:33:06 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8785C402BC;
	Fri, 27 Jan 2023 07:33:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8785C402BC
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B74431BF37E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 07:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CB9B402BC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 07:33:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7CB9B402BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id caH5g6qi_8gv for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Jan 2023 07:33:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 940ED40182
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 940ED40182
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 07:33:03 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CDB0261A04;
 Fri, 27 Jan 2023 07:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FFCC433D2;
 Fri, 27 Jan 2023 07:33:01 +0000 (UTC)
Date: Fri, 27 Jan 2023 08:32:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Natalia Petrova <n.petrova@fintech.ru>
Message-ID: <Y9N+K5OPa9eBqxXn@kroah.com>
References: <20230126135555.11407-1-n.petrova@fintech.ru>
 <20230126135555.11407-2-n.petrova@fintech.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230126135555.11407-2-n.petrova@fintech.ru>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=linuxfoundation.org; 
 s=korg; t=1674804782;
 bh=jU3Cs9zLmll07aFt2hD5OAowkoOa3yd1i19yHqBSKd8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yE/mKuS4NDxmcx0lSvqJPW6q+PyrbhxFzoeB0TVWheyRbmTt95EaKPpa2gojNXAvD
 7sTETj9A/4WeqNjOQdxaVY/LmDvFlyJ504ikz9/ar/mtdEImqJr9nrA3TyIwz9aKrO
 p47IX4MVBE3+qSbbGV2mdzc1BrZjj+IGJtOuAtRM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=yE/mKuS4
Subject: Re: [Intel-wired-lan] [PATCH 5.10 1/1] i40e: Add checking for null
 for nlmsg_find_attr()
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
Cc: lvc-project@linuxtesting.org, intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 26, 2023 at 04:55:55PM +0300, Natalia Petrova wrote:
> The result of nlmsg_find_attr() 'br_spec' is dereferenced in
> nla_for_each_nested(), but it can take null value in nla_find() function,
> which will result in an error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
