Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E596C27C6E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Jun 2024 06:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A940B60B57;
	Thu, 13 Jun 2024 06:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DxAJSPZBMlgw; Thu, 13 Jun 2024 06:24:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B07560857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718259875;
	bh=ggWtUz970+22vIg8AApyNoSovE25dgcCqbLcSQYA7ss=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FG8oI4dphdFviMB1leu+mgivq9pM8oPK07slQe26WOfyzF+CHQj0hLGh/k2Khs+F1
	 XJBnqE3sFDJ9jYkvflZz/i9CxFGYtKrqDR2px2DqlkJA+FRG0kVPArpMKgzVb8rvst
	 ImCIjepQmMVvjdG51feeDJuP47UviiI/8oJy16fNLvFL54fPAHlES0vkqag5yScBFX
	 YMr/4QI/Ou9GFzxtB5+XQLGz17Q9tQXIP/EBA2TLi1O7pih0N2IhE+7h+h6fWa9bhn
	 J/Dy7ew+nDrj+dMe+ZkD0av3O5pYJOUYGBxDWw27ONfrlfk/omCDopPwrdTdKiy++u
	 3WFIESaCvZx7A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B07560857;
	Thu, 13 Jun 2024 06:24:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id A81061BF35C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jun 2024 06:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9497540167
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jun 2024 06:24:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uSk9DSOTDaU4 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Jun 2024 06:24:32 +0000 (UTC)
X-Greylist: delayed 75357 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 13 Jun 2024 06:24:31 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EEDAA400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEDAA400D3
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEDAA400D3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jun 2024 06:24:31 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:24:26 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Message-ID: <20240613062426.Om5bQpR3@linutronix.de>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
 <87sexi2b7i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sexi2b7i.fsf@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1718259867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggWtUz970+22vIg8AApyNoSovE25dgcCqbLcSQYA7ss=;
 b=dmey8kFzxUJnouRynx6sLFJpldCURUSbiAiTajD5k03Q4UVlytx1xxnIn3XTPR0EtmtCY5
 sNlouWWXpsh3vM+dmn6zTud75A8P87N+6GQxMkJTrRkhR3qr4HV/V5U2SP/cEFmADRfT2o
 BwSH073nFXG5eYFFrTrGGKSEs66RuckkOrTlP1CDHLFimOUy71PWm69uFcXCIRLsSTIV9c
 O64Dqu9nEtbpS/gSHVHIc1nu7lYPAE+BIDtJlcTZrsiy50sGM03eva9Nh0BYg2wKdEb8uI
 vU8gtKUQV8cfk9CPwwgDzYftLaoOOJpuF1kKwmBZ1QUhNDxz4nEqNtDryyfGEQ==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1718259867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggWtUz970+22vIg8AApyNoSovE25dgcCqbLcSQYA7ss=;
 b=77i2TfOncktpUw7ZTTtHDJja9aripZJhBwDzcQvqkEB7y/2Rlrz4kkx/yZdcHAO1ct6gcn
 pY3REh8SpInUnSDA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dmey8kFz; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=77i2TfOn
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: Get rid of spurious
 interrupts
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
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Kurt Kanzenbach <kurt@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2024-06-12 12:49:21 [-0700], Vinicius Costa Gomes wrote:
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 305e05294a26..e666739dfac7 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -5811,11 +5815,23 @@ static void igc_watchdog_task(struct work_struct *work)
> >  	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
> >  		u32 eics = 0;
> >  
> > -		for (i = 0; i < adapter->num_q_vectors; i++)
> > -			eics |= adapter->q_vector[i]->eims_value;
> > -		wr32(IGC_EICS, eics);
> > +		for (i = 0; i < adapter->num_q_vectors; i++) {
> > +			struct igc_ring *rx_ring = adapter->rx_ring[i];
> > +
> > +			if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
> 
> Minor and optional: I guess you can replace test_bit() -> clear_bit()
> with __test_and_clear_bit() here and below.

That are two steps, first test+clear is merged into one and then __ is
added. The former is doable but it will always lead to a write operation
while in the common case the flag isn't set so it will be skipped.
Adding the __ leads to an unlocked operation and I don't see how this is
synchronized against the other writes. In fact, nobody else is doing it.

Sebastian
