Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AA2C4451C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 12:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AAE1408E3;
	Tue, 21 Jul 2026 12:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVNC4GY99AaE; Tue, 21 Jul 2026 12:44:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F536408A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784637878;
	bh=pwA3UFYZor+N1ArmTxmdikFz22XbtbK7MIR4NPacbYw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XiM2/pFhdAp+6ZdJnpF/H5zdEwzLKbNHSSCgqVcC1OKkImMD+sNOqro97zgqLJb29
	 KhaP1j3ZoL26b/QYVEEw5zgDPU7oIhJPBDBMxdAAdpZyQhzHqcmz8lmX+Li6XTVCw+
	 Z+PglUqlzVh86PDmnghxAW6Fxk2osepdH4w7iH8vzYBFXwHhAHn+t1wcKNEdyMhZdV
	 cS/GCcmHkv7TM8cOmurmwMUtopZe6dKII5tw4PlNqlDnc+Uo6FyA78juDhboXx1bRV
	 dj/DdkjNvskSPXOVTVPZhMR7+bRMfNMEvHXmvJSeJtVmLYxtPJ4KDbLNIlNJ6mIsRx
	 /QkpIRz4BYH6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F536408A8;
	Tue, 21 Jul 2026 12:44:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E0583EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 12:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C609080843
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 12:44:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NRuMpJstmxpn for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 12:44:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C94F780834
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C94F780834
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C94F780834
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 12:44:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E73B6001A;
 Tue, 21 Jul 2026 12:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B1D1F000E9;
 Tue, 21 Jul 2026 12:44:32 +0000 (UTC)
Date: Tue, 21 Jul 2026 13:44:30 +0100
From: Simon Horman <horms@kernel.org>
To: mohammad heib <mheib@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch
Message-ID: <20260721124430.GH19108@horms.kernel.org>
References: <20260701093830.948756-1-mheib@redhat.com>
 <20260708143601.1491656-1-horms@kernel.org>
 <acb60edf-0be5-4719-8f13-00cdbd1bb491@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acb60edf-0be5-4719-8f13-00cdbd1bb491@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784637875;
 bh=pwA3UFYZor+N1ArmTxmdikFz22XbtbK7MIR4NPacbYw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aWoCV59/86PAXOUlrpyzpQj6+gjLZ/bSFXrM0ox2pB9RVnUDrUyR0wV2FZCU6Xqni
 UPxo/+RPRehqpmwYUUs8JLd+72GfctUg6GfVK1NWuxIBQKZEtcixJiDmdK6QAQP0gv
 bBd+KgeWuFsMCtaL9TW6NWlVwOq9lSx7HRXLXl9YqW9PD4cC79Z4RgcQtZQ3cgAj4H
 8ZCvV55biZNGOLpLAcXKjXnnlu7ZmxRzm1IdWPV6F2jJOz7/vFDwB7P54tWiWFZeds
 OkiDLSspJCJ1w8KzJCq54bIhIVXxApC0MtL2IzP1MeWfoRz96xLY/bx/p3efrsQiZ0
 je+gTjfGIVmww==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=aWoCV59/
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/2] i40e: move ATR sample
 rate from ring to PF level
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

Hi Mohammad,

Likewise, thanks for your response.

On Mon, Jul 20, 2026 at 02:36:52PM +0300, mohammad heib wrote:
> Hi Simon
> Thank you for the review.
> 
> On 7/8/26 5:36 PM, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > i40e: move ATR sample rate from ring to PF level
> > 
> > This commit moves the ATR sample rate configuration from the per-ring level
> > to the PF level. It initializes the sample rate globally during software init
> > and updates the fast path to reference the PF structure.
> > 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > index a04683004a567..4d4d4b07a0f3a 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > [ ... ]
> > > @@ -3454,12 +3454,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
> > >   		ring->xsk_pool = i40e_xsk_pool(ring);
> > >   	/* some ATR related tx ring init */
> > > -	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> > > -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> > > -		ring->atr_count = 0;
> > > -	} else {
> > > -		ring->atr_sample_rate = 0;
> > > -	}
> > > +	ring->atr_count = 0;
> > 
> > [Severity: High]
> > Does removing this per-ring initialization remove the protection against
> > dynamic ethtool flag toggles?
> > 
> > Previously, if the ring was configured while Flow Director ATR was disabled,
> > the ring's sample rate was cached to 0 in i40e_configure_tx_ring(). This
> > prevented descriptor injection even if the PF flag was later toggled on
> > without a ring reset.
> > 
> 
> The per-ring zeroing of atr_sample_rate was redundant. i40e_atr() already
> checks I40E_FLAG_FD_ATR_ENA before it ever looks at atr_sample_rate:
> 
>  /* make sure ATR is enabled */
>   if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
>       return;
> 
>   if (test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
>       return;
> 
>   /* if sampling is disabled do nothing */
>   if (!pf->atr_sample_rate)
>       return;
> 
> 
> When ATR is disabled via ethtool private flags, the function bails out at
> the I40E_FLAG_FD_ATR_ENA check regardless of what atr_sample_rate is set to.
> The flag check is the real protection the per-ring sample rate cache was
> never the thing providing protection against dynamic toggling.

Thanks for the response and sorry for the false-positive.
I agree we can discard this concern.

> > [ ... ]
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > > index 894f2d06d39d0..b36e0fc9b31d2 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > [ ... ]
> > > @@ -2879,7 +2879,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
> > >   		return;
> > >   	/* if sampling is disabled do nothing */
> > > -	if (!tx_ring->atr_sample_rate)
> > > +	if (!pf->atr_sample_rate)
> > >   		return;
> > 
> > [Severity: High]
> > Can this global check lead to a hardware Malicious Driver Detection (MDD)
> > event if ethtool flags are modified dynamically?
> > 
> > If an administrator performs the following sequence:
> > 
> > 1. Disables flow-director-atr via ethtool.
> > 2. Disables ntuple (which resets the ring and sets tx_ctx.fd_ena = 0).
> > 3. Re-enables flow-director-atr.
> > 
> > The final step does not trigger a ring reset, so fd_ena remains 0 in the
> > hardware queue context.
> > 
> > However, I40E_FLAG_FD_ATR_ENA is now true, and pf->atr_sample_rate is
> > globally set to a non-zero value.
> > 
> > Will i40e_atr() now proceed and inject FDIR descriptors into a TX queue
> > that is not configured for FDIR?
> > 
> > If so, does this cause the hardware to trigger an MDD event and hang the
> > TX queue?
> > 
> The scenario you described was already broken before this patch, walking
> through the old code with the same sequence:
> 
>   1. Disable ATR — flag cleared, __I40E_FD_ATR_AUTO_DISABLED set
>   2. Disable ntuple — ring reset happens, i40e_configure_tx_ring() runs with
> ATR off, so ring->atr_sample_rate = 0 and fd_ena = 0
>   3. Re-enable ATR — flag set, no ring reset
> 
> In the old code, ring->atr_sample_rate is stuck at 0 from step 2, so
> i40e_atr() bails out at the sample rate check. That avoids the fd_ena
> problem, but ATR is also silently non-functional
>   — the user re-enabled it but it doesn't actually work until something
> triggers a ring reset.
> 
> This patch changes how that failure looks, instead of silently doing
> nothing, pf->atr_sample_rate is non-zero so i40e_atr() would proceed but the
> root cause is the same:
> toggling ATR via ethtool private flags doesn't trigger a ring reset, so
> fd_ena can be stale.
> 
> Properly fixing this would mean triggering a reset when ATR is re-enabled.
> The reset calls i40e_configure_tx_ring(), which re-evaluates fd_ena based on
> the current flag state so fd_ena would be set to 1 since
> I40E_FLAG_FD_ATR_ENA is now on.
> 
> What do you think about addressing this as a follow-up patch on top of this
> series? Since it's a pre-existing issue, it feels like it belongs as a
> separate fix rather than being mixed into this refactor.

Thanks for the detailed analysis, much appreciated.
I agree we can leave this to be addressed by a follow-up.

