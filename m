Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BDCC53200
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 15:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 666B660602;
	Wed, 29 Jul 2026 15:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lhciTnfyoaNQ; Wed, 29 Jul 2026 15:27:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EF25605FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785338847;
	bh=cj+4lhJ1n3MPXSWyH7rhu8SAlhn7g60qkPpqBkN1LkU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NZU8lnZ8DZu88Eex2vOok/ffclbEemrV81oxTYhAAHh3C0XxRDzWRUYBVhVA4cjxI
	 vqhXPB4ZZHtsaDfI3s0mGKhZpzgRCmI5jATnZNxnox3eTTq8RTOmOEDBxGA2GB/2FC
	 OX9ncPV74dC5emfGlja/N69ZbblhTJiQgAQrrWi+0qtPBxwEXLcStfY6gWS60PlAmD
	 h+Xq96wFVM7VCvjaruArXuZo2qdQy3qh7doovy39nXCXtz5L3meMdp20IQFGy5ai5k
	 mWCLtUjcRjQDhKyr07bKSSqNrwOwqObT1pMtQRMHx3DVxV9v0bv3p7RVWD2PGj4zyK
	 bWlbjo+6lglJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EF25605FD;
	Wed, 29 Jul 2026 15:27:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BBCE442A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 15:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD78E80C2A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 15:27:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLn8CLJ7BZYf for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 15:27:23 +0000 (UTC)
X-Greylist: delayed 1617 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 29 Jul 2026 15:27:23 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6CD4E80C25
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CD4E80C25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CD4E80C25
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 15:27:23 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wp5lQ-00Epyj-Pb; Wed, 29 Jul 2026 17:00:08 +0200
Date: Wed, 29 Jul 2026 17:00:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: Seongjun Hong <hsj0512@snu.ac.kr>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <a422c52e-27de-4c10-93ca-4e82e7cbc517@lunn.ch>
References: <20260729080100.2057448-1-hsj0512@snu.ac.kr>
 <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=cj+4lhJ1n3MPXSWyH7rhu8SAlhn7g60qkPpqBkN1LkU=; b=y8V5FrxLXtgatI3vzZOlycuMlS
 7suQUYWoaafeHW/0gFBD8zc8hZVhrQHG9Jgmt8NmPFca/zB1LHxytHT2x6qAFTB9yhrQe3xjEgLOz
 s+QKtdiA15SKTjfNV32Nuj4eHNmrBJDZGipieU3o8owHHiK/aYGasgSRtxgbGAPiGsAU=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=y8V5FrxL
Subject: Re: [Intel-wired-lan] [PATCH] e1000: drop dead switch statements in
 configure_tx/rx
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

> I see the point, but as the code is quite old and its extensive development
> period passed long time ago, i believe value of such cosmetic patches is
> rather questionable.

It might be worth looking at the history of this code and see why it
is this way. Sometimes odd code like this is actually a bug of some
sort, maybe a merge conflict resolution which want wrong.

      Andrew
