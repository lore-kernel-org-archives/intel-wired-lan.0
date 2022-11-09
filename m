Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4EFC4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Nov 2022 13:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C18B402E5;
	Wed,  9 Nov 2022 13:24:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C18B402E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668000261;
	bh=8CTu76YG0p4zNekcbzDvEzCtVgM1dlaxu5YspsMwJZY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Pu0noADj0+0ZhUXm4aJJyXwhC2jMcCOVpgcK7mhfD8nL7pEmXD4qFFyXqPphiUhvm
	 yEawi13V8UuyJ5nH32pgsTuxsxo4UM/2a+ekBjmtjCb5Y+7U70phIJIBmo2nh7Xh83
	 SIymdifwl16fU4eOIGIQcjlpA4UL10+DSwLzY2aycOywBsIwiqYx+fvEscUHvt5bG0
	 bN7HLsyM1h0JO4H3iu03Sq2G6lPLHNj7iD6hqrO3TuvX2eixlKBsrNXM5aq0BT3pdb
	 /2VmaLkig0Pxqjop5aNUV2HmsfhcEdB0n+4mfTku1Bubshq5MnUKQyI0osSF80ELbx
	 taO3fm8G2YfYQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id umR5yHAjaB5L; Wed,  9 Nov 2022 13:24:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAAB940B4E;
	Wed,  9 Nov 2022 13:24:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EAAB940B4E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 427731BF3CB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Nov 2022 13:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B8B74176D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Nov 2022 13:24:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B8B74176D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0mOFt1Mp5Q2 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Nov 2022 13:24:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED3AE4174A
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED3AE4174A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Nov 2022 13:24:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B4BF061A8B;
 Wed,  9 Nov 2022 13:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9068C433D6;
 Wed,  9 Nov 2022 13:24:13 +0000 (UTC)
Date: Wed, 9 Nov 2022 15:24:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stefan Assmann <sassmann@kpanic.de>
Message-ID: <Y2up+sLH5qN34msN@unreal>
References: <20221028134515.253022-1-sassmann@kpanic.de>
 <Y2gHqj18Tz66k4ZN@unreal>
 <5911b8f9-590b-6e05-646a-c1bc597105d8@kpanic.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5911b8f9-590b-6e05-646a-c1bc597105d8@kpanic.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1668000255;
 bh=homsu4aZZSL2CrgTZ+4wTVXsspTBzyMgK5ZCSWRPYug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sZs42djn475sZBlrh+zYWjpDJjvhHYDfFQwZLP/YWByxUX+MlSKEMQvC1u7ueLHg6
 wg11s/1SVi352uOnPtYqzcioao51AGKI5dQgwYiajAbm4zNJgSaLc94Dfkyh6v6nMu
 oFpKiidWfkINT4YVYf8SIhSWhlT+8CVQX9caUcm5vf6TYuqjNa05CxoAb+1l9gOMC5
 z9pv/FVRn9xRf47gyhQLgCRm25YoBnCDSljI7HfUsIzmGb0AQz8wgXkIvRougSr4cE
 kxgX9IPluBCkdPyCAatfMpuvnFqcC3sRZN+ekjs097gTyUSoVrIrjMu+dsOTryh0Wx
 8gyiheKFCd08g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=sZs42djn
Subject: Re: [Intel-wired-lan] [PATCH net-next] iavf: check that state
 transitions happen under lock
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 patryk.piotrowski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Nov 07, 2022 at 12:57:42PM +0100, Stefan Assmann wrote:
> On 06.11.22 20:14, Leon Romanovsky wrote:
> 
> > On Fri, Oct 28, 2022 at 03:45:15PM +0200, Stefan Assmann wrote:
> 
> >> Add a check to make sure crit_lock is being held during every state
> 
> >> transition and print a warning if that's not the case. For convenience
> 
> >> a wrapper is added that helps pointing out where the locking is missing.
> 
> >>
> 
> >> Make an exception for iavf_probe() as that is too early in the init
> 
> >> process and generates a false positive report.
> 
> >>
> 
> >> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> 
> >> ---
> 
> >>  drivers/net/ethernet/intel/iavf/iavf.h      | 23 +++++++++++++++------
> 
> >>  drivers/net/ethernet/intel/iavf/iavf_main.c |  2 +-
> 
> >>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> >>
> 
> >> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
> 
> >> index 3f6187c16424..28f41bbc9c86 100644
> 
> >> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> 
> >> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> 
> >> @@ -498,19 +498,30 @@ static inline const char *iavf_state_str(enum iavf_state_t state)
> 
> >>  	}
> 
> >>  }
> 
> >>  
> 
> >> -static inline void iavf_change_state(struct iavf_adapter *adapter,
> 
> >> -				     enum iavf_state_t state)
> 
> >> +static inline void __iavf_change_state(struct iavf_adapter *adapter,
> 
> >> +				       enum iavf_state_t state,
> 
> >> +				       const char *func,
> 
> >> +				       int line)
> 
> >>  {
> 
> >>  	if (adapter->state != state) {
> 
> >>  		adapter->last_state = adapter->state;
> 
> >>  		adapter->state = state;
> 
> >>  	}
> 
> >> -	dev_dbg(&adapter->pdev->dev,
> 
> >> -		"state transition from:%s to:%s\n",
> 
> >> -		iavf_state_str(adapter->last_state),
> 
> >> -		iavf_state_str(adapter->state));
> 
> >> +	if (mutex_is_locked(&adapter->crit_lock))
> 
> > 
> 
> > Please use lockdep for that, and not reinvent it.
> 
> > In you case lockdep_assert_held(&adapter->crit_lock).
> 
> 
> 
> Lockdep is mostly enabled in debug kernel but I was hoping to get
> 
> warnings in production environments as well. As those transitions don't
> 
> happen too often it shouldn't hurt performance.
> 
> 
> 
> > In addition, mutex_is_locked() doesn't check that this specific function
> 
> > is locked. It checks that this lock is used now.
> 
> 
> 
> You are correct, this check only triggers if crit_lock is not locked at
> 
> all. It would be better to check the lock owner, but I couldn't find an
> 
> easy way to do that. Better than no check IMO but we can drop it if you
> 
> don't see a benefit in it.

Yes, please drop it. AFAIK, lockdep doesn't add much overhead while enabled.

Thanks

> 
> 
> 
> Thanks for the comments!
> 
> 
> 
>   Stefan
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
