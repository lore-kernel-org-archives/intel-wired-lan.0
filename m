Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26191C5DF7E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 13:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D994F608D4;
	Tue, 18 Aug 2026 13:07:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id absuRByaDfQY; Tue, 18 Aug 2026 13:07:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20F04608C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787058467;
	bh=ymjN3A5TV9tH2vf/q6v+bffQUMuHkQcoIeSyDrLpCK4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cq4N2rHKrpRVraaQjPdLQtkKKL6l72q1RWdwlAkaetheOM9VNxJRkeAU5L6L3+5VF
	 wlTbsrDqZeYNepa7ZZKXrds+OoYaXHrMh8+XHaS+yS4HGhiisoLdgT0gW7p/adljWR
	 PyNkSpqjNgJORVp/02VUp217y6SpQLU3xZC/bzgiAd+40YHeFj3+rQYAp6944JMQ/d
	 QGSZfuF7QSqolaAwxsCb/+Xg22qcV8kfCm6DMyviSbNRwr0/vT+1Ihkzm+qpZOVarN
	 IhCMplMsxZc5OWaLcCl9sqITBXP96DZT+sAnQx6Pj6Mk82BOMbVfoCU4iU1Sy3SdY/
	 ueFEnCrCVr2zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20F04608C0;
	Tue, 18 Aug 2026 13:07:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85352194
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 13:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7764B400EC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 13:07:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKqfIX1hETze for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 13:07:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 97D8340057
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97D8340057
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Itd6t3Zu
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97D8340057
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 13:07:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9726541206;
 Tue, 18 Aug 2026 13:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9721F000E9;
 Tue, 18 Aug 2026 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787058463;
 bh=ymjN3A5TV9tH2vf/q6v+bffQUMuHkQcoIeSyDrLpCK4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Itd6t3Zupk5SGVQhH+msEcITlwXzTA+d/1y8Gb5E0QU9qbDj3j/lyRJkL3/eLSWVz
 lQBMOJnzfXUPqKVOeekeDoAIJTFHkoOEmgo78vxeORQvgEqowibfTydnjFlAHkr7FN
 udS5VtCcyZDMFKXjbAel2fi1r5D1EePzLOrcMaYoCThrcdYiu5vUAdl9MkTsC2XDd2
 sLyANdbEHz8rv5qH/27ULU8TKZg+Gq/BBzKRAqj5CwvousDheLjlxiyf/N2wKZDxq/
 OgUyrnXRHJ06m9kSpcMr2o0mecx7WJBkX6Bor6Xivp+lV00+CIud2+m2S3pKNrDCga
 zum7IignQZBdQ==
Date: Tue, 18 Aug 2026 14:07:38 +0100
From: Simon Horman <horms@kernel.org>
To: Shivani Gupta <shivani07g@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Message-ID: <20260818130738.GF265046@horms.kernel.org>
References: <20260815010815.91898-1-shivani07g@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815010815.91898-1-shivani07g@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] igb: Reject hwtstamp requests
 when PTP is unavailable
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

On Sat, Aug 15, 2026 at 01:08:15AM +0000, Shivani Gupta wrote:

...

> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c

...

> @@ -1378,6 +1384,25 @@ void igb_ptp_init(struct igb_adapter *adapter)
>  		return;
>  	}
>  
> +	/* Initialize all state used by the PHC and timestamping paths before
> +	 * registering either interface. INIT_WORK() only initializes the work
> +	 * item; no work is queued until timestamping is enabled.
> +	 */
> +	spin_lock_init(&adapter->tmreg_lock);
> +	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
> +
> +	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> +		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> +				  igb_ptp_overflow_check);
> +
> +	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
> +	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> +
> +	/* Initialize the hardware clock before ptp_clock_register() makes its
> +	 * callbacks visible. The overflow work is started after registration.
> +	 */
> +	igb_ptp_reset(adapter);
> +
>  	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
>  						&adapter->pdev->dev);
>  	if (IS_ERR(adapter->ptp_clock)) {

Hi Shivani,

There is an AI-generated review of this patch available at
https://sashiko.dev/#/patchset/20260815010815.91898-1-shivani07g%40gmail.com

Of that review the following item stands out to me.
I would appreciate it if you could look over it in particular.

  Does this code leave the hardware interrupt unmasked if ptp_clock_register()
  fails?

  The call to igb_ptp_reset() unconditionally unmasks the Time Sync hardware
  interrupt. If ptp_clock_register() fails, adapter->ptp_clock is set to NULL,
  but the hardware state is not reverted.

  If a hardware interrupt occurs, igb_tsync_interrupt() is called:

  igb_tsync_interrupt()
      if (adapter->ptp_caps.pps)
          ptp_clock_event(adapter->ptp_clock, &event);

  Will this result in a NULL pointer dereference when adapter->ptp_clock is
  passed to ptp_clock_event()?

...
