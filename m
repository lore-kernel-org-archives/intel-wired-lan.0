Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2BDE7E352
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 09:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C7D140CCC;
	Fri,  3 Apr 2026 09:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkXJ5zqiKcYw; Fri,  3 Apr 2026 09:11:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C53140CA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775207506;
	bh=o1UjQHKuXo7LS5/5fejLpQfU5dX6DJXfYC6l2YDTPL4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KU7NFCqTs9h1KShQkBH+rlxinVKSEZ3DfYW0Qc2TpDVZmzs+OXj4lhHN0g0csVRcL
	 VGfd6bXiKH3V9IHZCsnrT/ZXYwEFTlsDsEr3rFB0tqR+GER0ivaZTg4L1bRjlSlzjU
	 Iwq3DkjqNsFpu1kBw/RHol6Ac57eNJJ0dqK5wa+/WYYL25WwDGevFXEGW3+1h/FRmy
	 /ffmFmy1y4HPCQPwCnnvyB84yzBBZA7Ypn7Lw6XxR9WxH3+6hI1/pOwXiNxTtIMiYL
	 rR+OsnLzbaR+CSFWHKG+kml5Y0ed4ky5xr0pW4gl8oMZ8nLEnfE8DogquQ9Ji1L2ks
	 KwNyKir1wWJYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C53140CA9;
	Fri,  3 Apr 2026 09:11:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 97C4D1F3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 09:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D84340CA9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 09:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_4l649qXEd2 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 09:11:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C399740C8E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C399740C8E
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C399740C8E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 09:11:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 49C4140ADA;
 Fri,  3 Apr 2026 09:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2C7C4CEF7;
 Fri,  3 Apr 2026 09:11:41 +0000 (UTC)
Date: Fri, 3 Apr 2026 10:11:39 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260403091139.GF11973@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-2-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775207503;
 bh=MmlIaJ9yGTrDk4ESaEPt7Z8bs3ConO2uqtUwszGU+PE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s12bb9vbP27D3eJbosHTzPM+rbUdqvFaupKZwRdx+nfqwiNvPSyIcA6h6ufTn/aYS
 6swWGMhyOzRBBvc6CwqSpA+sDZ9G2RBUF+mPnvViwoWnvTElg36YqhsRn1sD3B0uwY
 UFJYTW/Kz9YlTSoC9YRUBjQhT+TvBEKW+Zo8eSh0GYQQvO98gWNuPfaKwmujQMJ/dl
 i6IshMP9CZYu39WtOZjoRhKVUwS1B9gt2IM+F1JuYyfWHwHx8y0xrCTXt+N/t+486F
 6SUctRg2xq+kWXs72KrcwcNHLEs3yVrL31bcYWMJHa6Bb3ovh9d90NijuAhI0ti2+5
 onBGlf7YzDoJA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=s12bb9vb
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix locking around
 wait_event_interruptible_locked_irq
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

On Fri, Mar 27, 2026 at 08:23:25AM +0100, Aleksandr Loktionov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Commit 50327223a8bb ("ice: add lock to protect low latency interface")
> introduced a wait queue used to protect the low latency timer interface.
> The queue is used with the wait_event_interruptible_locked_irq macro, which
> unlocks the wait queue lock while sleeping. The irq variant uses
> spin_lock_irq and spin_unlock_irq to manage this. The wait queue lock was
> previously locked using spin_lock_irqsave. This difference in lock variants
> could lead to issues, since wait_event would unlock the wait queue and
> restore interrupts while sleeping.
> 
> The ice_read_phy_tstamp_ll_e810() function is ultimately called through
> ice_read_phy_tstamp, which is called from ice_ptp_process_tx_tstamp or
> ice_ptp_clear_unexpected_tx_ready. The former is called through the
> miscellaneous IRQ thread function, while the latter is called from the
> service task work queue thread. Neither of these functions has interrupts
> disabled, so use spin_lock_irq instead of spin_lock_irqsave.
> 
> Fixes: 50327223a8bb ("ice: add lock to protect low latency interface")
> Cc: stable@vger.kernel.org
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20250109181823.77f44c69@kernel.org/
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>
