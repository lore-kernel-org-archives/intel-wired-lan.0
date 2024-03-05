Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F95C54798
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Mar 2024 19:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54910406F2;
	Tue,  5 Mar 2024 19:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZN2NXLMPJ41i; Tue,  5 Mar 2024 19:54:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C8BB4074A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709668496;
	bh=QE1tVUAsy/hkSSeuCWKZiVp2eupHugxc005RYWzTphk=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pBdf7pPF2GiO+OmC0F5KbIG4FdTOUuWxjJehZTln4uUR63xcaQDtFPn+sxdcDlL2U
	 aUvysovTUB4igk2ms6D8QUsDOYMii5JjBqoF+sPhk5wxTyUXeFyEotHGO4Dbcj72HD
	 RKlpfGm4BJizcHQMiBJkU7tpCOtPivLfzh2TyJAklswMzSD/WLO/J+DZ6cLjiJgagr
	 4AaTHfeG7N+5otgxyyFGF73nj1dn2SA2KRK9d6FGI6TNEU0Fblz15Yi/VYCdxS4DoG
	 wodUjBgVybzPJLuB42fZ/MHL9COJO0o/jQ/VEJNoy756PCj6gNlgkPzIGgV5RFzz8c
	 hb1gT6HRN2Zrg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C8BB4074A;
	Tue,  5 Mar 2024 19:54:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id CBC9D1BF3A4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Mar 2024 19:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B75D882A0B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Mar 2024 19:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3j3Lo56uaD68 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Mar 2024 19:54:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0553682768
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0553682768
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0553682768
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Mar 2024 19:54:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DB3F461575;
 Tue,  5 Mar 2024 19:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71B3C433F1;
 Tue,  5 Mar 2024 19:54:51 +0000 (UTC)
Date: Tue, 5 Mar 2024 11:54:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Message-ID: <20240305115450.577c161e@kernel.org>
In-Reply-To: <ZeJ3u2x3Ihs8WQJn@lzaremba-mobl.ger.corp.intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
 <20240228084745.2c0fef0e@kernel.org> <ZeBMRXUjVSwUHxU-@nanopsycho>
 <20240229072813.5d7614c3@kernel.org>
 <ZeDb8Dr8mBvov9fc@lzaremba-mobl.ger.corp.intel.com>
 <20240301090836.185e3b79@kernel.org>
 <ZeJ3u2x3Ihs8WQJn@lzaremba-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1709668492;
 bh=gntd/YhRPEAN2+Z16W3V+ZZ+Frwia39/RWn+d6a3EcQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lxte8lc0Jppw6kKqg7dMmphrkb66r7fSWpzIBGQScH3qVouaLwS9X4lbSspmbLj7X
 FYpmoJT1SaeEwQCxuNe9cEtjaXBc3KJ12P+rNHpsoDWNOHfypEvo5zJZCY5DhZty+H
 /6BbaHVMHH3mYQWxEwwQuWGX8Ek+ePmHxIi5LXldaVKLpeLR5AHYtH/j6YnkYBuB/V
 lySQnFe27R/KHt23pqZGICCc+/5U0VAR+OyZ2A6/GQ2uPbaQL22Wficrc1Bkf7YvUt
 URX19gVDZ8l8b2a079SeXZwNaXzRPBe/8IUY2BaJl777Rei3mgUexeIEzzHfw0Wm/C
 Gqez787JWGetw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=lxte8lc0
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 0/5] ice: LLDP support for VFs
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
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 linux-kernel@vger.kernel.org, Jakub Buchocki <jakubx.buchocki@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Lukasz Plachno <lukasz.plachno@intel.com>, intel-wired-lan@lists.osuosl.org,
 Pawel Kaminski <pawel.kaminski@intel.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, 2 Mar 2024 01:50:03 +0100 Larysa Zaremba wrote:
> For RX: match on Ethertype and mirror, every trusted VF should be able to scan 
> neighbors.
> 
> For TX this is more complicated and is done not through eswitch, but through 
> modifying security options, so do not think this would work with tc. So private 
> flags are the best option? Our requirements say only a single VSI can transmit 
> LLDP.

It is doable theoretically, tho, right? Driver can detect that all
eswitch VF/PF ports but one have a "drop LLDP" rule and update the
security option correctly?
