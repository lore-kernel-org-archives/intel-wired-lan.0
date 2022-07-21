Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F4CCA485
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Jul 2022 23:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2671460BC4;
	Thu, 21 Jul 2022 23:53:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2671460BC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658447583;
	bh=cGN4qL0CwB51kon+SSCJD2p2MUjtROPvU7WhA84ExFs=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=b3UUdsyOhbDI5crEbvQbgb+pp6QxUtKI9fD5bhcG5IRQK8iQl2dT5wS2sopcLt3FB
	 EGSkip2xHxM/+MKWCizc5mZ4vlPrp7RI+Acs3vjkRhZXL9UoyYC0iDMX162kwC8b9d
	 Rdh0pAHONHLMyMfywQ/JhoolvJ7/fsxMJL3aeV/SpG4l8euUytZPrOyQ5/GrcjSuc5
	 tPLGL/ZOEXbiXzB2+zPHxYE96xvfY3I1o87SlDJAYDOQn3jL8EJMZy5y0MCfPucmap
	 CsW7b+bA4GWmULcrJUCm+MvN+mz/atANCYfOV7WFN761+lSs/GChupi9g11UwXCAsj
	 DO9ogOAZJurng==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FVPbhTXPXBL3; Thu, 21 Jul 2022 23:53:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4500860BFD;
	Thu, 21 Jul 2022 23:53:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4500860BFD
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9800E1BF340
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 23:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FAC5403AA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 23:53:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FAC5403AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iemCxWlDRvra for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Jul 2022 23:52:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E7C24023F
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E7C24023F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 23:52:59 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1CDB661EA4;
 Thu, 21 Jul 2022 23:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190D3C341C0;
 Thu, 21 Jul 2022 23:52:57 +0000 (UTC)
Date: Thu, 21 Jul 2022 16:52:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <20220721165256.02f83fe8@kernel.org>
In-Reply-To: <20220721211451.2475600-1-jacob.e.keller@intel.com>
References: <20220721211451.2475600-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1658447577;
 bh=yK/2aQwcTmWjKegD+naXKwpgN28c2N1Wm1Ikhzqp8T0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=a6ar49SmtZ+Qeblvh9vslHjtBhAxbfKiw+TqxcyzG8PgVwW26AjXOrZ2XqyZUKGRR
 4rbeEk5nmqWSiikSqCu/CLmf37QWXMLVBJCjBrpi+zQeYvQVWF1hEiDOCx9cJho4mS
 X/Ax02+tUpj5o2R7/p57KDmIRr3rFT0gpOqtBDdSPTxkl2QuqGjX1YW19utgQUARuV
 ejfMzr4YNovBmx9figGcqP0zx+DEMk6OZYowmFA4wnkHP5JJba3wAL2O93o5J5R5TW
 umXAqAk6kAih+uwefwoKnqwcgmSZifwEHgtZS1OQAF1kqPQC5kSs/NmO2JxjNP0FSx
 QYHLqH2MNP0mg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=a6ar49Sm
Subject: Re: [Intel-wired-lan] [net-next v2 0/2] devlink: implement dry run
 support for flash update
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
Cc: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, linux-doc@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>,
 intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 21 Jul 2022 14:14:45 -0700 Jacob Keller wrote:
> This is a re-send of the dry run support I submitted nearly a year ago at
> https://lore.kernel.org/netdev/CO1PR11MB50898047B9C0FAA520505AFDD6B59@CO1PR11MB5089.namprd11.prod.outlook.com/

You confused patchwork, please post user space in separate thread:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#how-do-i-post-corresponding-changes-to-user-space-components

Tomorrow:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#i-have-received-review-feedback-when-should-i-post-a-revised-version-of-the-patches
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
