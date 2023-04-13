Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28CBC77B6C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Apr 2023 02:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3826B60F0D;
	Thu, 13 Apr 2023 02:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3826B60F0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681352681;
	bh=i7ZKgq0sNOmUhEeZA029SROiQhBYKptmKHNjf4Y008g=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ndTyCd8HBeqEqcdbjr9aSs06j4WA7IzYbsS/Z45XUBNzmTn8QJvQT/54R6nsYcW3y
	 RNNL0WTVYVUF6iqtGdP2W8V34Wujf60wliqhibSa4o8Si8LmaEqJTV+f3cE/UmYgBR
	 p/0uvpaL583SmEO6Vv/Gcus/FGj/U5oGl0tmt8xVoxsnzcB2hx1Oo4rPb8M2Hmhpbm
	 pQa8MzDarSeV0mXqp6bDYsHJawWhg2xnaIFOvVaQiODx2Ey1NPFI67Ni100tJjmxtG
	 jMeQrc21CCSePLKKr9KQ6AWQJ2BedX2ZXb9+4ofKGiAymUllJ+zPQUTeLXcaV619mw
	 uJ+VFtO5F6x5A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bW9irbs4vTnv; Thu, 13 Apr 2023 02:24:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FA8B60F8C;
	Thu, 13 Apr 2023 02:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FA8B60F8C
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 209F81BF3DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Apr 2023 02:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED75681764
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Apr 2023 02:24:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED75681764
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qoFRmjR7DxlM for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Apr 2023 02:24:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0739C81754
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0739C81754
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Apr 2023 02:24:37 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B643262F50;
 Thu, 13 Apr 2023 02:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89856C433EF;
 Thu, 13 Apr 2023 02:24:35 +0000 (UTC)
Date: Wed, 12 Apr 2023 19:24:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <20230412192434.53d55c20@kernel.org>
In-Reply-To: <d2585839-fcec-4a68-cc7a-d147ce7deb04@intel.com>
References: <20230411011354.2619359-1-pavan.kumar.linga@intel.com>
 <ZDb3rBo8iOlTzKRd@sashalap>
 <643703892094_69bfb294a3@willemb.c.googlers.com.notmuch>
 <d2585839-fcec-4a68-cc7a-d147ce7deb04@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1681352676;
 bh=6y4rjV1Zy8gYgCldDco9axyg7nVERe53kB5JNbiAsEg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dwArQt8QqPNybMbhnhpQCHX5UemciAiYoQ8gT4QWQvTHrjruYo8Axee2738mLBaLf
 wWq2q6aPG0lL6yjO/CyWifLKDdpsCARjsH6f6uvHi2/SWvf+oMqd2Yfh0xE37WTmSY
 1rBkCR2sJhWdDzJ6K/Qa1rfIcvYTn7lX9lsVZORzBzE3wME7HyPj4NReaNLOoWN9rR
 pbP8QSzDkpcZJxeFoVrZ2TEaki9ES9KDOoaWZSbXWayGuc2lz8fY1dotl5A77439Uf
 M+dGwa+RIFd61iSxx6WR3/nwvGf5UfJxu0rD7MZ8sxR2wuBPVsvTmeIBeBSDumtGe7
 PgiXJcGlW2JNw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=dwArQt8Q
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 00/15] Introduce Intel
 IDPF driver
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
Cc: Sasha Levin <sashal@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, pabeni@redhat.com,
 netdev@vger.kernel.org, willemb@google.com, jesse.brandeburg@intel.com,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, decot@google.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 12 Apr 2023 19:03:22 -0500 Samudrala, Sridhar wrote:
> On 4/12/2023 2:16 PM, Willem de Bruijn wrote:
> > Sasha Levin wrote:  
> >> On Mon, Apr 10, 2023 at 06:13:39PM -0700, Pavan Kumar Linga wrote:  
> >> How will this work when the OASIS driver is ready down the road?
> >>
> >> We'll end up with two "idpf" drivers, where one will work with hardware
> >> that is not fully spec compliant using this Intel driver, and everything
> >> else will use the OASIS driver?
> >>
> >> Does Intel plan to remove this driver when the OASIS one lands?
> >>
> >> At the very least, having two "idpf" drivers will be very confusing.  
> > 
> > One approach is that when the OASIS v1 spec is published, this driver
> > is updated to match that and moved out of the intel directory.  
> 
> Yes. We don't want to have 2 idpf drivers in the upstream kernel.
> It will be an Intel vendor driver until it becomes a standard.
> Hope it will be OK to move the driver out of the intel directory when 
> that happens.

As I said previously in [0] until there is a compatible, widely
available implementation from a second vendor - this is an Intel
driver and nothing more. It's not moving anywhere.

I think that's a reasonable position which should allow Intel to ship
your code and me to remain professional.

[0] https://lore.kernel.org/all/20230403163025.5f40a87c@kernel.org/
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
