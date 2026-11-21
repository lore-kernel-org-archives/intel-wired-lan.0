Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF8606A320
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xBDUQs2m;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gtzL7uqE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8854860615;
	Sat, 21 Nov 2026 18:57:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pyxY3VjhBnuv; Sat, 21 Nov 2026 18:57:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D40526061F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795287451;
	b=ZNzyjJ+P/nYn4v+bWHoQXuY8OLnXQjIFyEF9QpbO3y1MQSFjGhRS0ytUdoJehp5mzJOL
	 o492NrSxwBNFa2yHcRI7YCo4AQkyBIY/FLbUcXB2pqxqws/WmPOwHM4cC1YMERkjENW1a
	 KxtkvzW4jQMBLfJ/2q4CNCbWBDCkLhA/E6Ry+r4IfU1HmOrKPYBKRBe+FM9NvME5TvSLA
	 yIEx1nxu7WxdzvJzilcMhPHHKXqDb1fMiiBTD1df50zP9J+6xdBnkusuZJLoizye+Xtp7
	 KdZ15TJi4rR6RJfUmN0xrPd0ZBB1tDfT/Bli3uPbAtWVrJxuDGmOyR03bgC9tY9Mrog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795287451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OvcsXvmxV2NpAo9swbfL9baT0D2RJxOhrkhotTqp33Q=;
	b=VrixXKs8XnaU8tG8V5UOLOiUcjQfyFwKwF6cBg+Dx1Q9OLQHVdpPhlhH76mYmiCUNJP6
	 NDRSJRBRPNbp3MWEvm820CCGN1SzDrD6WVCxEHjqfHpog0C401lTVzfacB3bhC0lEROVw
	 WV9nABjbiKQuMUzEo9zUMDVsvYQlkK8ksR9oYNBbKGTPx71sS1t449Ezup99VHdU7MYDe
	 zuoPXER4/LjEZjSB28cpomYSCXKyJX57t4Wtnq8gPldpx7KjmCb0ccPgC1Rr/2Hk/5+wQ
	 ChjrDdg1xAlch9IQlFlm8sBLOvTxwH+hV6lZtl+swhXSPfMx0ZmJ/Hs9wD/J2jwpNhQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795287451;
	bh=OvcsXvmxV2NpAo9swbfL9baT0D2RJxOhrkhotTqp33Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBDUQs2moqzji/T7sMQFMHjluqqRK1r0cE5vUuxPVWEPA5BHI3tkHFpmZF0wBHuSC
	 /yJ1TSkZ+ivuR4FD8Crxg6EgYEg2uE8Wo1/+lcYRaaBALDqCen1nFEY+ntsb9SpXkc
	 KidBMA/7KXcukYqoF5xapbubPVrY16JsgO+NLwJeEZVr9/CJj8d8oq76YdopU8Jks1
	 A4TPUeLwP+1JfiNKaINxgMoBDuOvP9eTyK6szlbGTR7gZecejJ8JMRRTRONABw9+RR
	 Yz+Yp/sQiiKFJWGMP+LE5auztNTo7eNDWZaigBIWntvoN5eWODNCyXmb43GGfxXPeX
	 VnGwzUq3ySjFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D40526061F;
	Sat, 21 Nov 2026 18:57:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8222915D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 18:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 682A040081
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 18:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3w1dSq6-35F7 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 18:57:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5B23C40012
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=156.67.10.101
X-Greylist: delayed 2664 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 21 Nov 2026 18:57:28 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=gtzL7uqE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B23C40012
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=OvcsXvmxV2NpAo9swbfL9baT0D2RJxOhrkhotTqp33Q=; b=gtzL7uqEKmM9OrMI93aDbnJ9HN
 2wLP4MitspVQNyArBz+0yD9qGUwJCH+1foNqGriPr/E2bd7sKENPlNy6giHx0pcasgvLpbe/ufoU/
 3l6m1ENOXkMvanQzoPOUW1Yc5oaN5fL0u7CzivgwcBpYm6z1M5skvI0kcVLqubf1umXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1xUpZy-000TbP-0O; Sat, 21 Nov 2026 19:12:50 +0100
Date: Sat, 21 Nov 2026 19:12:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, matttbe@kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH iwl-next 0/3] igb: Align the flow-control behaviour with
 ethtool's specs
Message-ID: <4efeed7c-da91-4886-9af9-67c1df07bcca@lunn.ch>
References: <20261121103613.166611-1-maxime.chevallier@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121103613.166611-1-maxime.chevallier@bootlin.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 11:36:09AM +0100, Maxime Chevallier wrote:
> Hi,
> 
> This series makes a few changes in IGB's ethtool flow-control
> configuration to align it with the ethtool expectations.
> 
> This was found while upgrading the board farm that runs the stmmac netdev
> CI tests. I've upgraded the HW and I'm now using a bunch of I350-T4 PCIe
> cards (running igb) as peers for my tests. Since then, the flow-control
> tests have started failing:

Yah! The tests are doing what they are supposed to do. I don't expect
too many problems with devices using phylink/phylib. It is all the
drivers which roll their own which get is wrong.

	Andrew
