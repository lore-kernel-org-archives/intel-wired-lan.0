Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1849C54E68
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Mar 2024 14:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F232403FC;
	Thu, 21 Mar 2024 14:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MiGb7cxxgEpm; Thu, 21 Mar 2024 14:53:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A879F40430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711032808;
	bh=2r4kmlwH724Y4qI43//rL/0kpwyX9e5Eqqy+Tzlxna4=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kyX+v27yekgzxBOcPiamqyVciLWx7sia5/rWXH5kDFtNCDA3qE9T3u+VrhizC7/6N
	 snoYfFiQQMZTrwjNLWihdy3xe6Owzdh0aEpPKEWqEdyzUsipxG9RZ4Gz+yo8lm+vpf
	 16eR39eA8WuEPbOePOd7QsWyJoShsqGCFJB8XaYk3KuCTmr8UfsWaByPLmO5+018ig
	 6emega1Vih56yT1Noe+ItHsQwO2FKEiYEuLgrsc9ew5WMROEUKM/z92DIoakPVX96V
	 icXowl9+h1+W+iZVUQUzcn2KUfUm2o7Nh6moBRC9RyN5K6iHdcwtLByl2dn+I7370A
	 4i+8Do480ekdw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id A879F40430;
	Thu, 21 Mar 2024 14:53:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8A3321BF575
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Mar 2024 14:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74E31400F9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Mar 2024 14:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2nCaquOT3EX7 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Mar 2024 14:53:26 +0000 (UTC)
X-Greylist: delayed 98655 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 21 Mar 2024 14:53:25 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EBA40400F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBA40400F5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EBA40400F5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Mar 2024 14:53:25 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
To: lakshmi.sowjanya.d@intel.com, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
In-Reply-To: <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
 <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
Date: Thu, 21 Mar 2024 15:53:22 +0100
Message-ID: <87le6bhc0t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1711032802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2r4kmlwH724Y4qI43//rL/0kpwyX9e5Eqqy+Tzlxna4=;
 b=Bo1mXDrdv9XN9ZfmeP7xgJh41zMLO8nOEsx6Tq0pqTkcVSOjDALigxXRNqQR8I0ICkjnfE
 jKO/rVkdvlpkv5QW3DdVSUE4ZpI6JNA5PUc3upt94pt9Nne/B2u264SiabjnUjwD2L0TvP
 nviHQ1omFuOg+DMG4rX7W/RNABhShvvJfJ6ph9bQLYwJbxU4c3B+hFv6o3gbZL6IO1et4L
 Ea2A6wYiuyQJAU+QkrkR+1uaIIBGH4tu9wPipDWhkzBy9amAzqt4KSNAnaeYkgXyRKtEan
 ZKOg7m+zHEJ3/7TT611E4X5nrcCwVRrIumMmrk9MKxUMp7ci7AOVlnh1U81J0g==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1711032802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2r4kmlwH724Y4qI43//rL/0kpwyX9e5Eqqy+Tzlxna4=;
 b=72pv6KOlbz95mP5aFQ19r1gYUoZf8dUWfzAVreSPhDIR2yaW8/hAvL1hmsHdgv1+EU9W0K
 esvYdHhzFZEGnZDg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Bo1mXDrd; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=72pv6KOl
Subject: Re: [Intel-wired-lan] [PATCH v5 02/11] timekeeping: Add function to
 convert realtime to base clock
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
Cc: linux-doc@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
 alexandre.torgue@foss.st.com, perex@perex.cz, basavaraj.goudar@intel.com,
 thejesh.reddy.t.r@intel.com, christopher.s.hall@intel.com, x86@kernel.org,
 joabreu@synopsys.com, peter.hilber@opensynergy.com,
 intel-wired-lan@lists.osuosl.org, subramanian.mohan@intel.com,
 linux-sound@vger.kernel.org, lakshmi.sowjanya.d@intel.com,
 andriy.shevchenko@linux.intel.com, netdev@vger.kernel.org, pandith.n@intel.com,
 eddie.dong@intel.com, mcoquelin.stm32@gmail.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Mar 19 2024 at 18:35, lakshmi.sowjanya.d@intel.com wrote:
> +bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	unsigned int seq;
> +	u64 delta;
> +
> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +		delta = (u64)treal - tk->tkr_mono.base_real;
> +		if (delta > tk->tkr_mono.clock->max_idle_ns)
> +			return false;

I don't think this cutoff is valid. There is no guarantee that this is
linear unless:

       Treal[last timekeeper update] <= treal < Treal[next timekeeper update]

Look at the dance in get_device_system_crosststamp() and
adjust_historical_crosststamp() to see why.

> +		*cycles = tk->tkr_mono.cycle_last + convert_ns_to_cs(delta);
> +		if (!convert_cs_to_base(cycles, base_id))
> +			return false;
> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(ktime_real_to_base_clock);

Looking at the usage site:

> +static bool pps_generate_next_pulse(struct pps_tio *tio, ktime_t expires)
> +{
> +	u64 art;
> +
> +	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art)) {
> +		pps_tio_disable(tio);

I'm pretty sure this can happen when there is sufficient delay between
the check for (now - expires < SAFE_TIME_NS) and the delta computation
in ktime_real_to_base_clock() if there is a timerkeeper update
interleaving which brings tkr_mono.base_real in front of expires.

Is that intentional and correct?

If so, then it's inconsistent with the behaviour of the hrtimer
callback:

> +		return false;
> +	}
> +
> +	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
> +	return true;
> +}
> +
> +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
> +{
> +	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
> +	ktime_t expires, now;
> +
> +	guard(spinlock)(&tio->lock);
> +
> +	expires = hrtimer_get_expires(timer);
> +	now = ktime_get_real();
> +
> +	if (now - expires < SAFE_TIME_NS) {
> +		if (!pps_generate_next_pulse(tio, expires + SAFE_TIME_NS))
> +			return HRTIMER_NORESTART;
> +	}

This safe guard does not care about time being set. I'm not familiar
with the PPS logic, but is it expected that the pulse pattern will be
like this:

         

    ---|-----|-----|-----|----------------->
       P     P  ^        P
                |
        clock_settime(CLOCK_REALTIME, now - 2 seconds)         
        
        Obviously the pulse gap will be as big as the time is set
        backwards, which might be way more than 2 seconds.
        

    ---|-----|-----|-----|----------------->
       P     P  ^  P     P
                |
        clock_settime(CLOCK_REALTIME, now + 2 seconds)         

I don't see anything in this code which cares about CLOCK_REALTIME being
set via clock_settime() or adjtimex().

Aside of that I have a question about how the TIO hardware treats this
case:

   ktime_real_to_base_clock(expires, &art);

-> GAP which makes @art get into the past

   pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);

Will the hardware ignore that already expired value or just emit a pulse
immediately? In the latter case the pulse will be at a random point in
time, which does not sound correct.

Thanks,

        tglx
