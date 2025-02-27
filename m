Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B955CC19F2E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 27 Feb 2025 16:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C641606A8;
	Thu, 27 Feb 2025 16:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0GBBtayPmWFz; Thu, 27 Feb 2025 16:08:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5158606D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740672486;
	bh=CND/AWjqWtefCR2+bz8yg6Rc6Qum2wM65PkiDHxFQKA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lmZeKr44YnaGjErBHPejDKYtRtpLukSQ42ajhS/5RS+mmCogmL0PQ1Gm3kpfgJFvS
	 iZToLnF0vYtNZeqbm15Gg+X/j1CibDtev6JYVwqB1OW04rv9s8+Ym65sQNopW4kdYx
	 P70qGV1DQoFN3kDxs1ukgkfd4ELOd+V28s8SuEDckMTEHp5mGtI9JkKAwhtXDt851N
	 zdMfDP9Y0Ca/jALvwSm2uYXOU4nKJwTcADtQZuHaDM2iGgaAtRQYebYkpPZQKb9wAe
	 VyC8i0xuOrAaCQ6BEVMGaw/fuRcnXv9MKr97Tu2uZ8CpMQdH7GPsp7edOwfxOeibvW
	 KunUoZqwE4CvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5158606D6;
	Thu, 27 Feb 2025 16:08:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F371A711
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Feb 2025 16:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0CC480CC5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Feb 2025 16:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gf5gk2VaEm9J for <intel-wired-lan@lists.osuosl.org>;
 Thu, 27 Feb 2025 16:08:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3FBB280CAA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FBB280CAA
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FBB280CAA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Feb 2025 16:08:04 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1tngQT-000e7u-Fr; Thu, 27 Feb 2025 17:07:53 +0100
Date: Thu, 27 Feb 2025 17:07:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=CND/AWjqWtefCR2+bz8yg6Rc6Qum2wM65PkiDHxFQKA=; b=fZ0Z6IUwpZBeYWfehdeZd8LTTq
 fWrQj/7RaPs53mZOEgMIB+pGKvLf8bb6zvQgPHHJ45OOSIGB0Gze9Nws3AX7jY94oQPYdg1qQ0uQs
 T1009zcHl7phWIDtAD7WrLJEiSbTGf1n5C8nWsteHhn4GohocKhajcus+RHV5/8iDH4E=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=fZ0Z6IUw
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Link flap workaround option
 for false IRP events
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

> >> +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);
> >
> > Please add some #define for these magic numbers, so we have some idea
> > what PHY register you are actually reading. That in itself might help
> > explain how the workaround actually works.
> >
> 
> I don't know what this register does I'm afraid - that's Intel knowledge and has not been shared.

What PHY is it? Often it is just a COTS PHY, and the datasheet might
be available.

Given your setup description, pause seems like the obvious thing to
check. When trying to debug this, did you look at pause settings?
Knowing what this register is might also point towards pause, or
something totally different.

	Andrew
