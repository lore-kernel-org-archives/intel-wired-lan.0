Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB554C43327
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jun 2026 15:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C103981A65;
	Tue, 30 Jun 2026 15:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4zoo7gC0ZYAp; Tue, 30 Jun 2026 15:19:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E1AA81E58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782832755;
	bh=dvgyW8X4QaOk9VN18ZFlTY30npYMh5LShKDCXGOsMxM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zkWfaKnRDUmipZjMjZG5YO2P6/GqEsGqBQM5LusQgSDrNihXChpyRjzwp2uxRaJGA
	 Sltivi0zn4VeiJGd6iGjErlY86s7FATZIeae8b+QMW0XjoH95mWKpvRNtVFYt010gR
	 AF6XIXtV/qFS9nLVxnbV8xfPsAh4QWJ/Q3gFDe7woPv6ctykebuqc2xogen9A5AhgR
	 VXtTpXK44nHmb8o1SMm5mADz24JN65v7GwQn/kO5Ocvh6TNo/RZZlieHTFhW7ExUL/
	 wosjc9iWp1I2VA8fOL2Y9+QRqs1095OPcwR5gmgNlqNWxOYz1z637FEMIhIUg1nbw8
	 940AfMSg3WChg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E1AA81E58;
	Tue, 30 Jun 2026 15:19:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 42FAC149
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 14:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2151482977
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 14:40:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZidQchkflgt6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jun 2026 14:40:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8623480839
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8623480839
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8623480839
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 14:40:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8F40601C1;
 Tue, 30 Jun 2026 14:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097601F000E9;
 Tue, 30 Jun 2026 14:40:36 +0000 (UTC)
Date: Tue, 30 Jun 2026 17:40:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Brian Norris <briannorris@chromium.org>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Manish Chopra <manishc@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sudarsana Kalluru <skalluru@marvell.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 b43-dev@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
 libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-net-drivers@amd.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <akPVYpzxwP8CIQxu@kernel.org>
References: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
 <20260630072344.159b5d99@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630072344.159b5d99@kernel.org>
X-Mailman-Approved-At: Tue, 30 Jun 2026 15:19:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782830441;
 bh=dvgyW8X4QaOk9VN18ZFlTY30npYMh5LShKDCXGOsMxM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UaRdoyQZ1fTRKLAcvtRM8pCPos/hNLQhMFDTOXBDrPIVVOLNJRA7cU6ka14RHMRFR
 qWpfgLvKeAkf3XDjCuN2u6VoExWRrn+k9PHdw1xwsfaFYRW6apiRDH/bzW3S/vPXox
 NDxnR8QhAiI/zPphXPkt1KolvI83eq3Oxp7pH6P8fycRjVpGLO0mOiNQvzLLw+uZ8w
 WRnUBYhp2jcwsX+8wxOOiEB4mT754vZ1T4aD/zr4L6UdrtAvPeJdD/EC+QwUvwBkRC
 yr2g0tFvuReybfsvjS3lYxCtUKPjJPqHyXPEmCx9cYMHhnzg+aQfCesR1JnXw5Gekk
 GQ0tpKu3Pqrmg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UaRdoyQZ
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/8] drivers/net: replace
 __get_free_pages() with kmalloc()
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

On Tue, Jun 30, 2026 at 07:23:44AM -0700, Jakub Kicinski wrote:
> On Tue, 30 Jun 2026 13:59:19 +0300 Mike Rapoport (Microsoft) wrote:
> >  drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c    |  6 +--
> >  drivers/net/ethernet/intel/ice/ice_gnss.c         |  5 +-
> >  drivers/net/ethernet/sfc/mcdi.c                   |  7 +--
> >  drivers/net/ethernet/sfc/siena/mcdi.c             |  7 +--
> >  drivers/net/wireless/broadcom/b43/debugfs.c       | 12 ++---
> >  drivers/net/wireless/broadcom/b43legacy/debugfs.c | 11 ++--
> >  drivers/net/wireless/marvell/libertas/debugfs.c   | 39 ++++++--------
> >  drivers/net/wireless/marvell/mwifiex/debugfs.c    | 62 ++++++++++-------------
> >  drivers/net/wireless/ti/wlcore/main.c             | 14 +++--
> 
> You gotta split this, wireless and ethernet go via separate trees.

Sure.

> BTW cocci also suggests folding in a memset, IDK if it's worth it.

Same churn, less lines :)
 
> drivers/net/wireless/broadcom/b43legacy/debugfs.c:217:8-15: WARNING: kzalloc should be used for buf, instead of kmalloc/memset
> -- 
> pw-bot: cr

-- 
Sincerely yours,
Mike.
