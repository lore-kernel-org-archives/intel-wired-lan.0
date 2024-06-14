Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB792C27C6E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Jun 2024 10:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FEBA84252;
	Fri, 14 Jun 2024 10:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lxGBhcqRVso; Fri, 14 Jun 2024 10:35:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B6ED8424C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718361339;
	bh=uSaWlQXseTFs/B6Tan7OjRCGhFNuESSd8LnmWizpdjg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=K3N5bmpkE0VuXqw82foW35U/yBs1UZY4D7qP+UuTl5UFVTcSb3AV2nl2MrpF5HgBP
	 IsyxwJ1svMCo5sLv7xZID81jK+aCW3UKFpuFoNKZAOSgmrysyEobrQZsDn6LFGXeS5
	 dtOeAoqAcFRy2FX9UjybAezLYjuJlqzFCD5Jn2J+H5ALcyNTMW3ElHsCp1uw7wAhND
	 a/LNEZBjry8XIQaWD6iNZlmQmUj+2O8hrXWjWN59SoBqFwyWPgdDp0a062s1qIYllP
	 ijoRb4ejX11qP3vUvNRGQ+ZQN7OFxQcY4nLBt2qhGUwiufUpLN6Ep0TXwi9EGTy/mO
	 0OBCx+Jc0vywQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B6ED8424C;
	Fri, 14 Jun 2024 10:35:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 073A81BF33E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E80DA40182
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgjXqqFqW2qF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Jun 2024 10:35:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0445740129
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0445740129
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0445740129
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:35:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A83D361EF8;
 Fri, 14 Jun 2024 10:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B0C2BD10;
 Fri, 14 Jun 2024 10:35:33 +0000 (UTC)
Date: Fri, 14 Jun 2024 11:35:31 +0100
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20240614103531.GA8447@kernel.org>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
 <20240606224701.359706-4-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606224701.359706-4-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718361335;
 bh=nmbY+YrSTZFPVTA1p0a3HbRHJgnxgNGMOb8cyV6ZNrg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NMOttC+p1sLncB5MngCgxwOxznz/W1nhBecTQZSwBq/ZJ0nhWrGQW3iA9Wr37yBf6
 SpGG2Im4aksxrK18YsyNdt4aZSrTWcuWrS3wf6+O0pc5UhM/I/YsHa1wC8cosq88tD
 hYg8vYZapLLqMFzSOqxjMe57TBvED4mKxyWqoCLR5rQmiDmetsY5eDJaVLFULy9PH1
 dG5nrzXeGNzWL71veELbFA+4aFVKMlNtojQS0VnNzmJuzMDxSE2csOGugSjxMzBqfi
 9wFdeM/HW4RJF2B0XZ4AXDoy5TdTkY/KKaSCZuLXxaDQ1k+OwMtq4jakH7Ire+zDGT
 /6uROvWxzPzew==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NMOttC+p
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/5] ice: add tracking of
 good transmit timestamps
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
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, corbet@lwn.net,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jun 06, 2024 at 03:46:57PM -0700, Jesse Brandeburg wrote:
> As a pre-requisite to implementing timestamp statistics, start tracking
> successful PTP timestamps. There already existed a trace event, but
> add a counter as well so it can be displayed by the next patch.
> 
> Good count is a u64 as it is much more likely to be incremented. The
> existing error stats are all u32 as before, and are less likely so will
> wrap less.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Hi Jesse,

The minor nit below notwithstanding, this looks good for me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 3af20025043a..2b15f2b58789 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -253,6 +253,7 @@ struct ice_ptp {
>  	struct ptp_clock *clock;
>  	struct hwtstamp_config tstamp_config;
>  	u64 reset_time;
> +	u64 tx_hwtstamp_good;

nit: There should be an entry for @tx_hwtstamp_good added to the Kernel doc
     for this structure.

Also, not strictly related to this patch, but related to Kernel doc.
It would be very nice, IMHO, if some work could be done to add
Return: sections to Kernel docs for the ice and moreover Intel Wired
Ethernet drivers. These are flagged by kernel-doc -none -Wall,
which was recently enabled for NIPA. And there are a lot of them.

>  	u32 tx_hwtstamp_skipped;
>  	u32 tx_hwtstamp_timeouts;
>  	u32 tx_hwtstamp_flushed;
> -- 
> 2.43.0
> 
> 
