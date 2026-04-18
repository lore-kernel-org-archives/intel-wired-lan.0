Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA77F99C8E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 18 Apr 2026 19:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CA8780F3D;
	Sat, 18 Apr 2026 19:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3SOy3GNEeZln; Sat, 18 Apr 2026 19:26:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C528280F22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776540369;
	bh=Zgo17xfkAIdR2A8xb/CQQeq2ygVWHbmUq6Z63yxq2S8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fr3QxwzsAOxY3315+WS+DzPTwjuDwcdkpxwQI85mvi+w9PBQ37UD7m8qsXrLnFuQO
	 iv7YM4ED94AEDOYfYs7a4I9XahlQl7PHfvazdEhfkNnqDSuuIqKsVpegLaIbTGik1c
	 gZuoCiYaqT+d8rwkSK4gq0gyOobBekEBiEF+ercE1oDFJXT4t+IzHOS/ekhu3XHDwy
	 0OH2g3Gtjf6r2L0L9qWnU78R9E0GcvKrjUZgn2+Di8u132yxLrOD+Az6hmsNfkYcWg
	 z6+9xjb+k9qqZOAeqxs2mkotm1WGW+8Ad270r+FK1YY6+tUyuVDlRAhnhKGrtgQGqJ
	 GbW0+sfHaapYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C528280F22;
	Sat, 18 Apr 2026 19:26:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FC98347
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Apr 2026 19:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1580960BC0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Apr 2026 19:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kQLmizJCR-T8 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 18 Apr 2026 19:26:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5AC3860BB8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AC3860BB8
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AC3860BB8
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Apr 2026 19:26:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7374E60145;
 Sat, 18 Apr 2026 19:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B9C2BCB3;
 Sat, 18 Apr 2026 19:26:04 +0000 (UTC)
Date: Sat, 18 Apr 2026 12:26:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>
Message-ID: <20260418122603.06d12715@kernel.org>
In-Reply-To: <IA0PR11MB7378CF62D86454916AE8F9D79B202@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
 <20260406192312.0f7a2760@kernel.org>
 <IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260409181041.395a0c37@kernel.org>
 <IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260410133812.4cf9b090@kernel.org>
 <IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
 <20260414145835.07fbe355@kernel.org>
 <IA0PR11MB737842E2098D0952A8BA1FE29B222@IA0PR11MB7378.namprd11.prod.outlook.com>
 <20260416082751.04782987@kernel.org>
 <IA0PR11MB7378FF7BF4EA32C1F89372C19B232@IA0PR11MB7378.namprd11.prod.outlook.com>
 <20260416180447.1a3c5c87@kernel.org>
 <IA0PR11MB7378CF62D86454916AE8F9D79B202@IA0PR11MB7378.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776540365;
 bh=N6BBecO9cG16wcouNfFoexu4GIU7PV9h4BUU/bLKA5I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KWkCmBh/IXy2bwCc9rqIyI6Ug+caXS8YQZDDCNwKMhhhrBW2E1knxKyzwKofn5O1Z
 bn+a6EHUxVpN0fMce1Jzc+gO8dTodl382YbcJHLSk+jgj1w0mW+6CMtzEIvcmBROEH
 Ok4Xjf5ZWhjEBkIOdRQ/dol+mLmOb3pyX2FAV8pStk0HfgMijO67aMsl8AlVWgUVFJ
 P4EDoZOfv2Dt9iEG1IX7k1KBN4fKc5HIZc19xVL1qyNiF83OpKkeiLao0YmQmIwYzA
 JSPzMey2IPJlaGPREjeUBPF0rbnoozB2tcngF95fG+NBKRAh5mogHAHmVZENUfHkye
 m2+jf2nPmTWhg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=KWkCmBh/
Subject: Re: [Intel-wired-lan] [PATCH v5 net-next 0/8] dpll/ice: Add TXC
 DPLL type and full TX reference clock control for E825
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 17 Apr 2026 12:22:05 +0000 Kubalewski, Arkadiusz wrote:
> >> I was thinking that this is more like a purpose specific DPLL device, if
> >> someone would want something similar we would have to review it, right?  
> >
> >We would if it was a Ethernet MAC PLL, but if someone wanted to expose
> >whether some random PLL in their ASIC locks - are we adding a new type
> >for each one of those?  
> 
> Yes, that was the implicit intention within those patches, if other purpose
> specific PLL would have to be present for whatever HW design and user
> control over it would be required, then that would be the easiest to
> maintain in the long term? Multiple types and each have own function/purpose.
> 
> It would be good as long as there is one PLL for a function per board, once
> there could be multiple ones for single function, we would have to add some
> enumeration (labels, etc.)

Defer on adding identifiers. User knows which driver and bus device
spawned the pll and more importantly what the pin topology is.
Naming in the kernel is rarely a good idea.

> >> It depends, TX clock has one of external pins connected to external
> >> DPLL,
> >> but second is a board-level pin with ability to provide some external
> >> clock signal, the user would have to determine that purpose just based
> >> on the topology of one of the pins, which seems a bit problematic?
> >> I.e. if at some point there would be HW with only external non-DPLL
> >> connected pins?  
> >
> >Not sure I follow, TBH. To me the function of the "MAC PLL" is fairly
> >obvious from the fact that it has a pin exposed via rtnetlink. So it's
> >obviously a DPLL which can drive the Tx clock?
> 
> I am lost a bit now too. You mean clock recovery pin? And EEC type dpll?
> In this solution the 'MAC'/EEC is external and it doesn't drive TX clocks
> directly.

MAC == "tspll" == TXC in this series. On Grzegorz's diagram the new PLL
was in the MAC, which makes sense since it's a pll in the same ASIC as
the MAC.

I'm saying that the function of that pll is obvious since its pin will
plug into the netdev / rtnetlink.

> >It's the function / relation / linking to the EEC DPLL that may not
> >be obvious. But user can see how the pins connect they can get some
> >LLM to draw a diagram of a live system.. et voila :)
> 
> Yes, correct it would work for this particular HW, but adding a variant
> without a external EEC-connected pin in the picture would be problematic
> to understand 'generic' dpll purpose, pointing to the labels later.

The function of the "MAC/tspll" is still obvious. The clarity of the
external PLL is not helped by naming the "MAC/tspll".

> Just to make it clear. I believe that generic type dpll could be used in
> any HW and for any purpose, so after all each such usage could possibly
> introduce entropy and confusion on the user side.
> 
> But if you are fine with that, then sure, we can live with generic
> purpose dpll.

Considering all the imperfect options - generic / unnamed type would be
my preference.
