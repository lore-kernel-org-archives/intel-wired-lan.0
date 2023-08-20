Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3298EE49A5
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Aug 2023 18:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33475818C2;
	Sun, 20 Aug 2023 18:54:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33475818C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692557658;
	bh=IIlVZhbQQtDhnYJMUgSSW16XNnG1HyKRcoPEy8anvOw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GDYyA3DA4TpffkgdxGzxZZwHVekF/GSPKBO5p2vnvplMQXADT1kbh4lLDzjeQASUb
	 5ZmvF4yQsORNf6UWV4+6uKEjAjzllqjBkc16ZbSS3mpoMnzRNz5mGlQ5Dw1nfwskTm
	 3M3maMXlobA03/mJM1/y1aD17Q8Z8VhmvFxvD6E6aRL86EhIW0Wy90Kn5zenx61Dwo
	 1kEtuav91O2BSnvISX2mszVJ9aCu8dglMekQhQCpel6MQO7zwCrUef4P5U4K0Q1UsW
	 b+Bi/T7JK0SctWBdYZX0/OrqDz4gljtyaqlbalcgOI/uAT7eXVkYzFt2af52XfxPlJ
	 nhn/DaGv8amQg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AQKaGPmlPHiN; Sun, 20 Aug 2023 18:54:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 335408188A;
	Sun, 20 Aug 2023 18:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 335408188A
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id ADE591BF425
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Aug 2023 18:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 924644157B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Aug 2023 18:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 924644157B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pqtM-FK_3_2J for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Aug 2023 18:54:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 06EB641578
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Aug 2023 18:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06EB641578
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qXnYs-004dOc-TM; Sun, 20 Aug 2023 20:54:06 +0200
Date: Sun, 20 Aug 2023 20:54:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Message-ID: <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230819093941.15163-1-paul.greenwalt@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=CfYHLWu8DTM4h6GppFVa08EJK0iarySCgG915li2Snk=; b=gatwpHwV0p5xAQJtoaRmIgZP+V
 LsVYyd5OQPJHFFzpHC6YmotTG1qO3ywNsMlgHmnc4dCiHfhlD3EGxD18NEcJJvSpwYTx37tEERbBk
 mwcCGJkbnwGIO0svfxi/1Pk/XA8xC/YFG1MlqoSFWXHpYyKvJcKJLXg8axpO7qeYv9V4=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=gatwpHwV
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 aelior@marvell.com, manishc@marvell.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, Aug 19, 2023 at 02:39:41AM -0700, Paul Greenwalt wrote:
> The need to map Ethtool forced speeds to  Ethtool supported link modes is
> common among drivers. To support this move the supported link modes maps
> implementation from the qede driver. This is an efficient solution
> introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
> maps on module init") for qede driver.
> 
> ethtool_forced_speed_maps_init() should be called during driver init
> with an array of struct ethtool_forced_speed_map to populate the
> mapping. The macro ETHTOOL_FORCED_SPEED_MAP is a helper to initialized
> the struct ethtool_forced_speed_map.

Is there any way to reuse this table:

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy-core.c#L161

Seems silly to have multiple tables if this one can be made to work.
It is also used a lot more than anything you will add, which has just
two users so far, so problems with it a likely to be noticed faster.

	Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
