Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80566CE7A88
	for <intel-wired-lan@archiver.kernel.org>; Sun, 24 Sep 2023 14:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06D4840524;
	Sun, 24 Sep 2023 14:51:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06D4840524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695567076;
	bh=xMIo9KH8I3LBF90Ebr6slwYRI2yh4rFj5fn3BZtIKO0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=cuu/uuRGKsGoPZjxGjehAgqoronPhG3xZC1ZFGvBu4edWI7I0vPgUTsTFNd7YVEUo
	 aJt55d2ui4uU4HLcX5TDpcAYNfbNBtf/TGBfoABbpLHQTQLrygkCQBqVXJ0iMooTeQ
	 UFR6ofMDW7fkhtsrjTqtUGKN0eum0h6+s8YbVQflHSYehJj4mdHT0zFSQU2AMkjoUp
	 pdQXWD9F2mO4AvuX2WVegJngIOKD3sMa+KjO4qe9/8dsdPJfWbURZbEeTBJmUHOUeM
	 PCg0ps67uj6XLMFjdV0DTtKTBDg85U59/C8Plbt6szmwYnxOVGqdaEit883jXwAvPi
	 bm06t2A3A3X3w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHe7RDci7W1K; Sun, 24 Sep 2023 14:51:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAC1A404FF;
	Sun, 24 Sep 2023 14:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAC1A404FF
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id A6F8C1BF2E3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 24 Sep 2023 14:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7ED104064A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 24 Sep 2023 14:51:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7ED104064A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jp01OrzHmgDC for <intel-wired-lan@lists.osuosl.org>;
 Sun, 24 Sep 2023 14:51:11 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7181400D7
 for <intel-wired-lan@lists.osuosl.org>; Sun, 24 Sep 2023 14:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7181400D7
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qkQRs-007M2R-St; Sun, 24 Sep 2023 16:51:04 +0200
Date: Sun, 24 Sep 2023 16:51:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <04bc5392-24da-49dc-a240-27e8c69c7e06@lunn.ch>
References: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
 <40c11058-5065-41f0-bf09-2784b291c41b@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <40c11058-5065-41f0-bf09-2784b291c41b@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=wF8VAQkHm9aN8DanZcHbvC5q8/HPij/Ar/JZNa+ORCY=; b=RTqDnomTBtd2RJjAH6CSlzlyJR
 mM3J05j5rKGOIUKzu+LzLyMrzbEoweDsd9CMM8umrdgK/E0oz3efGS8TI/y/b8xj5aFiCwqfUODXZ
 q/+FY6X2lJVedqkfhRe5gruEv8YWPwFeXTzc2wDFizkPBRho56On09v97AbAC3UqrtzI=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=RTqDnomT
Subject: Re: [Intel-wired-lan] [PATCH] [iwl-net] Revert "igc: set TP bit in
 'supported' and 'advertising' fields of ethtool_link_ksettings"
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
Cc: dumazet@google.com, netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, "lifshits,
 Vitaly" <vitaly.lifshits@intel.com>, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Prasad Koya <prasad@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, Sep 24, 2023 at 10:09:17AM +0300, Neftin, Sasha wrote:
> On 22/09/2023 19:38, Prasad Koya wrote:
> > This reverts commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2.
> > 
> > After the command "ethtool -s enps0 speed 100 duplex full autoneg on",
> > i.e., advertise only 100Mbps speed to the peer, "ethtool enps0" shows
> > advertised speeds as 100Mbps and 2500Mbps. Same behavior is seen
> > when changing the speed to 10Mbps or 1000Mbps.
> > 
> > This applies to I225/226 parts, which only supports copper mode.
> > Reverting to original till the ambiguity is resolved.
> > 
> > Fixes: 9ac3fc2f42e5 ("igc: set TP bit in 'supported' and
> > 'advertising' fields of ethtool_link_ksettings")
> > Signed-off-by: Prasad Koya <prasad@arista.com>
> 
> Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> 
> > ---
> >   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > index 93bce729be76..0e2cb00622d1 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > @@ -1708,8 +1708,6 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
> >   	/* twisted pair */
> >   	cmd->base.port = PORT_TP;
> >   	cmd->base.phy_address = hw->phy.addr;
> > -	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
> > -	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);

This looks very odd. Please can you confirm this revert really does
make ethtool report the correct advertisement when it has been limited
to 100Mbps. Because looking at this patch, i have no idea how this is
going wrong.

	Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
