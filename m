Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E11C6FD1C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Mar 2023 21:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FEA3408D5;
	Thu, 23 Mar 2023 21:02:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FEA3408D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1679605371;
	bh=EmvFG7JOnBSpeHe0A1XjNfvqXAgN6b5u5xNV0uwboM0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ItmWBTkW+5pX2MkWrQlkpaeEalMNY6V7cexDev2M61ox8+l24VoyJBPtl8RpYyvBi
	 xsop9pONvJqysnw2WYwLgkLRvB7DktjzfqKtXt7wwIJjAVUZsPbdhMBz2oOmrnYI5l
	 YbvMF3WBhVekjYVyu6Voke9qSti+weDqT+ZN4plBI3Cfj1BX2qGvtvk0jw0NOOCJ3J
	 weQYVrDTZdN5mg5LPOlHdALfkRyskOSN9JB93dN1P96tvXL9W96F4w30LvckHVE3y9
	 GA+zTLEk06/E2WBqlDB4VxLq0niO+ymOECrPKXOJBOsDGrnO6rexyCEe1SxA81iyCQ
	 Ybz6M0JqL4EOg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4ROuCD86WEQ; Thu, 23 Mar 2023 21:02:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8706C4031D;
	Thu, 23 Mar 2023 21:02:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8706C4031D
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 913881BF3B9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Mar 2023 21:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69E9284189
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Mar 2023 21:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69E9284189
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FMUYPRBtPTOS for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Mar 2023 21:02:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E51768417A
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E51768417A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Mar 2023 21:02:46 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1pfS4r-008Era-Mu; Thu, 23 Mar 2023 22:02:29 +0100
Date: Thu, 23 Mar 2023 22:02:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <fccbd0cc-f760-4f1a-8830-64a245b228dc@lunn.ch>
References: <20230322233028.269410-1-kuba@kernel.org>
 <06d6a33e-60d4-45ea-b928-d3691912b85e@lunn.ch>
 <20230322180406.2a46c3bd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230322180406.2a46c3bd@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=v41Uzc7Rv9i7N0Yv5b15xyHNDj7bAPZv3i2XxSJR6x8=; b=GvYu4i6/0P+gHXG681mxJIsx+L
 IEgiIwKX/U+JbluHp2VX5fw69HOEdwDPTcgyNPfaoWrFjOvP2m/JIUkHqKBJT5gvaVXjJ+r7BKiIb
 m7DcHTTi2Uvd3Aon2DeyzKfNSEB7YvX2XaXEGqn4ruEr1Yw1u42hZW8OR2UPd522UmoE=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=GvYu4i6/
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/3] net: provide macros for
 commonly copied lockless queue stop/wake code
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
Cc: willemb@google.com, netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, michael.chan@broadcom.com, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Mar 22, 2023 at 06:04:06PM -0700, Jakub Kicinski wrote:
> CC: maintainers, in case there isn't a repost
> https://lore.kernel.org/all/20230322233028.269410-1-kuba@kernel.org/
> 
> On Thu, 23 Mar 2023 01:35:34 +0100 Andrew Lunn wrote:
> > On Wed, Mar 22, 2023 at 04:30:26PM -0700, Jakub Kicinski wrote:
> > > A lot of drivers follow the same scheme to stop / start queues
> > > without introducing locks between xmit and NAPI tx completions.
> > > I'm guessing they all copy'n'paste each other's code.
> > >
> > > Smaller drivers shy away from the scheme and introduce a lock
> > > which may cause deadlocks in netpoll.  
> > 
> > I notice there is no patch 0/X. Seems like the above would be good
> > material for it, along with a comment that a few drivers are converted
> > to make use of the new macros.
> 
> Then do I repeat the same text in the commit? Or cut the commit down?
> Doesn't that just take away information from the commit which will
> show up in git blame?
> 
> Having a cover letter is a good default, and required if the series 
> is a larger change decomposed into steps. But here there is a major
> change and a bunch of loose conversions. More sample users than
> meaningful part.
> 
> LMK what your preference for splitting this info is, I'm unsure.

We do seem to have a policy of asking for a 0/X. And it is used for
the merge commit. That is my real point. And i don't see why the text
can be repeated in the merge commit and the individual commits.

    Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
