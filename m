Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A21C3DA6F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Aug 2023 20:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68C368120C;
	Wed, 23 Aug 2023 20:58:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68C368120C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692824333;
	bh=npI7R117WjVcoSYEaiyRJdJ+/bcroG2PPdgc/Q9cFQU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=InARQdpS4gxrLNbUX8owWUtqK1kXFTL9f3267bDSYxryWDT7fFkGbtR6MwS4/VJfe
	 qoU686qOG8lVq2o/WgLCwPbPYSb/5l7c73t7gI+i1L1GYVYVPCNuSEn73eKuC1TXlW
	 urVhCWcP5eJ+O03rA5aphGjHkrxGEON1TlfUn+sMMF25rTPYCp9G93sxvkJTaSmG/B
	 ffC7/xs9cN5mNFwUiHjyg2Y590afWRSi5LB1MN3akqOuByp9ykUUSJGXRN/XO07Z5P
	 TiR2HVIQGNys0KmXXBKAScnNw+f3ZsVlfYPCC9rk8YqfKMcPkW/Kf0taeylUJkr73V
	 soYes7tEEE6Hg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DkHMq3O410YG; Wed, 23 Aug 2023 20:58:52 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52F1E80F55;
	Wed, 23 Aug 2023 20:58:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52F1E80F55
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6D90D1BF2BE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Aug 2023 20:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4497480F55
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Aug 2023 20:58:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4497480F55
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YksUZ2-jFf84 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Aug 2023 20:58:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E095B80F22
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Aug 2023 20:58:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E095B80F22
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qYuw8-004vK3-1y; Wed, 23 Aug 2023 22:58:44 +0200
Date: Wed, 23 Aug 2023 22:58:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <f001eed4-82ba-4d14-86af-9b0d9c79d708@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
 <e676df0e-b736-069c-77c4-ae58ad1e24f8@intel.com>
 <ZOZISCYNWEKqBotb@baltimore>
 <59906319-6171-da5b-ca78-4ab423b1cc92@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <59906319-6171-da5b-ca78-4ab423b1cc92@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=vnGt/uJjkVve4zeCbfMTEK9g+SKJJZVyPBn7TFnEgLA=; b=GDpPkDAH8gbbrDLJP5pqKRse16
 YtDJkpmLbXxx45AEoILsuhep++VaQm5xrf3OeZ44TbCfA/IeNjYaqzeFu0KHNfymWMHHiNBPAe5bL
 C9NjRSe4vAr+74epVsbhRrce3bXDd8RQR6XOkGqNUFmC563zeOATgqNmhhm2Ukvo7tD4=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=GDpPkDAH
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/9] ethtool: Add forced
 speed to supported link modes maps
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
Cc: manishc@marvell.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, aelior@marvell.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> it would be nice to reuse the same mapping that is common everywhere. I
> suspect the PHY code already has some mechanism to support device
> specific since not all PHYs support all link modes either....

phydev->supported is initialised with all the link modes a PHY
supports. The MAC driver when gets a chance to remove any it does not
support,

phylink has similar concepts, the MAC, PHY, and SFP declare what they
each support and then it all gets combined to resolve to a link mode,
to use.

So it should be possible to make this generic with the help of the MAC
driver indicating a mask of what is actually supports.

       Andrew

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
