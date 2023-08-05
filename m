Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13955EB64DD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Aug 2023 08:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89E1E80C1E;
	Sat,  5 Aug 2023 08:04:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89E1E80C1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691222687;
	bh=ZfRiREY+co7IHkyoKrjUEB/zYXiFWlypwRonZFoGL1k=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9Xka1DZd3rk4HUFEw5p/6cpTWxTD3xHvaV6uBVVQiZ1cg+D3pZPyiLN0SIHO+cmsd
	 GzcSqXDMbjJJayCgFG6dbNFjC3aDJ3yEr5/GK1pVsXX1IvG+t1c3TQLGp9p+8sk48M
	 qnhQTwWGTOLROUlBt1cJXtz0P0ENELWLZoft1epO1GkM4hAN/y9czuVLzB8537mPAA
	 0y3ThHPQbY6kp/0h437PRkXvyu7vef/vLuGkN1Qr43dHamP6adi3rbKExnXjQ8IQ93
	 3H0r2khX/ZwmDKT20HDwxCmO99+iBMbyzq+E0oJy6WxIrNxv2Y8WkvtN5lwCxd/i9k
	 VO+tK95n5qyAA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ySazU5QuqyWb; Sat,  5 Aug 2023 08:04:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72D7D81514;
	Sat,  5 Aug 2023 08:04:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72D7D81514
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 7D1F71BF303
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Aug 2023 08:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0DFB411C6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Aug 2023 08:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0DFB411C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SF04ttTXRtz6 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Aug 2023 08:03:59 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A79C041505
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Aug 2023 08:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A79C041505
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8FAB8602E6;
 Sat,  5 Aug 2023 08:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8361EC433C8;
 Sat,  5 Aug 2023 08:03:56 +0000 (UTC)
Date: Sat, 5 Aug 2023 10:03:54 +0200
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <ZM4CajvI1uNYRNf0@vergenet.net>
References: <20230803151347.23322-1-przemyslaw.kitszel@intel.com>
 <ZM0MlhZduLVa6YZV@kernel.org>
 <385c8607-bc52-af0b-829a-5b058f4a152d@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <385c8607-bc52-af0b-829a-5b058f4a152d@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1691222638;
 bh=ysdwb2f9JBYVRhXs8E7OHn6011Cc8W/DnSqtWah111w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=InQWLTmImug2DrZP2/oD68GklkjvTF0cKUnTgVhR3IixzMrN+y0dbw34eA33DzfoZ
 LUHDqNHOCYlJnAB5O8c2BN3CM0RPkX8olq8xpJvou3FTmLtkWi3L0Y5jHTPzHmSsXw
 0w3dW9XfdYNtbvgczGlnHQ4OPxFVVtbqE46Uf1vodWnCNdOSMiZvUDJjkFpu7hSKZE
 vvmLTlQwGygX3sDOKIBBPEhBGAUlA8EmwJNZPqdgJPiu1t1wd0FfzE7Kq2If4gcnfL
 TowUArw6YrwjCcVXSqINm6R5+49v4pbfcQY8pbiim11rbbFhe3kWS/jaKjKp/lt79m
 RyGoEbv0IsXQA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=InQWLTmI
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: split
 ice_aq_wait_for_event() func into two
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Aug 04, 2023 at 04:54:48PM +0200, Przemek Kitszel wrote:
> On 8/4/23 16:35, Simon Horman wrote:
> > On Thu, Aug 03, 2023 at 11:13:47AM -0400, Przemek Kitszel wrote:
> > > Mitigate race between registering on wait list and receiving
> > > AQ Response from FW.
> > > 
> > > ice_aq_prep_for_event() should be called before sending AQ command,
> > > ice_aq_wait_for_event() should be called after sending AQ command,
> > > to wait for AQ Response.
> > > 
> > > struct ice_aq_task is exposed to callers, what takes burden of memory
> > > ownership out from AQ-wait family of functions.
> > > 
> > > Embed struct ice_rq_event_info event into struct ice_aq_task
> > > (instead of it being a ptr), to remove some more code from the callers.
> 
> see [1] below
> 
> > > 
> > > Additional fix: one of the checks in ice_aq_check_events() was off by one.
> > 
> > Hi Przemek,
> > 
> > This patch seems to be doing three things:
> > 
> > 1. Refactoring code, in order to allow
> > 2. Addressing a race condition
> 
> those two are hard to split, perhaps some shuffling of code prior to actual
> 2., eg [1] above.

Sure, that is a reasonable point.

> > 3. Correcting an off-by-one error
> 
> That's literally one line-fix, which would be overwritten/touched by next
> patch then.

True. But it also a bit hard to find in the current setup.
Anyway, I don't feel particularly strongly about this,
it was more a point for consideration.

> > All good stuff. But all complex, and 1 somewhat buries 2 and 3.
> > I'm wondering if the patch could be broken up into smaller patches
> > to aid both review new and inspection later.
> 
> Overall, I've started with more patches locally when developing that, and
> with "avoid trashing" principle concluded to squash.
> Still, I agree that next attempt at splitting would be beneficial, will post
> v3.
> 
> > 
> > The above notwithstanding, the code does seems fine to me.
> > 
> > > Please note, that this was found by reading the code,
> > > an actual race has not yet materialized.
> > 
> > Sure. But I do wonder if a fixes tag might be appropriate anyway.
> 
> For this off-by-one, (3. on your list) sure.
> 
> For the race (2.), I think it's not so good - ice_aq_wait_for_event() was
> introduced to handle FW update that is counted in seconds, so the race was
> theoretical in that scenario. Later we started adding new usages to
> (general, in principle) waiting "API", with more to come, so still worth
> "fixing".

Understood.

I think this does make me lean towards 3. being better off a separate patch.
But it's your call.

> > > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Anyway, let's see what v3 will bring :)

:)
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
