Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48364C52D7C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Aug 2024 15:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD3C18175F;
	Tue, 13 Aug 2024 15:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAuyYzdx-DIl; Tue, 13 Aug 2024 15:02:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA21B81763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723561370;
	bh=s1p2+5HGmT6uC5ZKwYp1agA+hLlWRfdOVnAhqAU68Ok=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fhrITGw0edlG5qa+efFzre08KETAEHYlKV6xMHiraqaJJzQSC85jsLImmjpmUbZsj
	 2KqFcH7qFnx1McsSpeM+4SRzq4HgxLYYAhAZoMuNqxU4unBIDJm9wq1FwOKUUj3eqT
	 8lFnpxLfNVQYMS321AvKWMcEfKfAOh+jGuR3WbllLoFJzQB09576SjkbVbFQRbTaN3
	 kc7LdlelHfPQqaDi5rqJqRKkNcSe0wrARCeqqPAQo0XDOCrLFRPk1GW6jwtxRdvOGV
	 CSB0IbzjXXvdBe9CUHZtxLiriOe/13eAR90iL2jUDd0tkfkVJArYFWiKpBrQ7K1fQO
	 9CkCrtYvxKN4Q==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA21B81763;
	Tue, 13 Aug 2024 15:02:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id BBB3D1BF488
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Aug 2024 15:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B546060865
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Aug 2024 15:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 56UCG-3lJudr for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Aug 2024 15:02:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DD68960861
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD68960861
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD68960861
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Aug 2024 15:02:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1175861707;
 Tue, 13 Aug 2024 15:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F96C4AF09;
 Tue, 13 Aug 2024 15:02:46 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:02:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Message-ID: <20240813080245.5e5c6657@kernel.org>
In-Reply-To: <20240813041253.GA3072284@maili.marvell.com>
References: <20240810002302.2054816-1-vinicius.gomes@intel.com>
 <20240813041253.GA3072284@maili.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1723561366;
 bh=vREXw95kYwA8kvX2/ZrNdGxcYOka4556U6NGc0ogOv8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QZnbD1n6ChEq3x8FTN0TOlAP6p66S+0lVOlM38aTYOcqaKNVeVGjLFtLLtnLTaiG3
 Bp+u37/fFiCPvPKz2MtFcrfcHHjrvkOo871/a7RYsuWVVX7FrOi6xyHTlLwevXAjMO
 Xnkp8wxINZTOxhQexh4UHxbQxlIXes2AJM3xNtmp9tzPJ/VpYk80RpIhATIaK7/XNm
 CKUiHfPbgaAS4V7TyrOzzv7xesdeOZREvYxrKXX9JHa4VmYk2yCRVqMZ+7gdETZps6
 I6LH/ixzl1kZei6FJYxrU7jhUa2nbNS3FmL1OJCVg16PlqM+KqOjbm/PLGPcuaLn1L
 ZW+xXVyK+J3Rw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=QZnbD1n6
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igb: Fix not clearing
 TimeSync interrupts for 82580
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
Cc: sasha.neftin@intel.com, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 netdev@vger.kernel.org, richardcochran@gmail.com, kurt@linutronix.de,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 daiweili@gmail.com, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, anthony.l.nguyen@intel.com,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 13 Aug 2024 09:42:53 +0530 Ratheesh Kannoth wrote:
> On 2024-08-10 at 05:53:02, Vinicius Costa Gomes (vinicius.gomes@intel.com) wrote:
> > @@ -6960,31 +6960,48 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
> >  static void igb_tsync_interrupt(struct igb_adapter *adapter)
> >  {
> >  	struct e1000_hw *hw = &adapter->hw;
> > -	u32 tsicr = rd32(E1000_TSICR);
> > +	u32 ack = 0, tsicr = rd32(E1000_TSICR);  
> nit: reverse xmas tree.

Please read the last paragraph below and disseminate this information
among your colleagues at Marvell.

  Reviewer guidance
  -----------------
  
  Reviewing other people's patches on the list is highly encouraged,
  regardless of the level of expertise. For general guidance and
  helpful tips please see :ref:`development_advancedtopics_reviews`.
  
  It's safe to assume that netdev maintainers know the community and
  the level of expertise of the reviewers. The reviewers should not be
  concerned about their comments impeding or derailing the patch flow.
  
  Less experienced reviewers are highly encouraged to do more in-depth
  review of submissions and not focus exclusively on trivial or
  subjective matters like code formatting, tags etc.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#reviewer-guidance
