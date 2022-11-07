Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878EEC433FE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Nov 2022 12:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A26B400DD;
	Mon,  7 Nov 2022 12:03:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A26B400DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667822593;
	bh=NKqNy7lSiq12+aHfhiyqeGR1BoC21YRFa6YvjmIMu54=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KK9cXyX5xi5rdJwziPZe3CeZgzxUQlH+8vQZocShQMG+tCN1/cQTbsNwtWKPdwIWs
	 BW34dJFmfI9g4f4FeFOWucc91rTzmp7j6coJS3HQYw9/F9v4jmPMV8EIo8K6i6giHB
	 8ijF3IPEMUxjTAU7Jqcyur7TIqyybnN6SHwwlkhsqLSYad+LZK54t1rK1BcLEj544f
	 hVl/gb95r3pUDWI3/zGrpBifw9JM9WK9g0wj1fnmRnc69N8EXc+RwY7Qt6GcwaNe1M
	 Gken3F5B6+cXKUMwZuv8nLnSyyWmtn0AKalrL4JctfOr+SBLyAHFF1GN9i39+X5wyL
	 k6bdqvWf35CeQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWBTjrD4tAe3; Mon,  7 Nov 2022 12:03:12 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09D4F4056F;
	Mon,  7 Nov 2022 12:03:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09D4F4056F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B8EA11BF94B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Nov 2022 12:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C3CF40209
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Nov 2022 12:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C3CF40209
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JpHAomzz5Vji for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Nov 2022 12:03:09 +0000 (UTC)
X-Greylist: delayed 00:05:11 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40B18401D9
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40B18401D9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Nov 2022 12:03:08 +0000 (UTC)
Received: from [192.168.0.54] ([185.35.111.107]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6DnM-1ouCcB2yLY-006h5w; Mon, 07 Nov 2022 12:57:43 +0100
To: Leon Romanovsky <leon@kernel.org>
References: <20221028134515.253022-1-sassmann@kpanic.de>
 <Y2gHqj18Tz66k4ZN@unreal>
From: Stefan Assmann <sassmann@kpanic.de>
Message-ID: <5911b8f9-590b-6e05-646a-c1bc597105d8@kpanic.de>
Date: Mon, 7 Nov 2022 12:57:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y2gHqj18Tz66k4ZN@unreal>
Content-Language: de-DE
X-Provags-ID: V03:K1:2jA52jcwX3fvaQpF2Bsz1IATYQGTCTrCivoSPvLHnqEGSAopT2s
 tU5Txbr7rUfd1fUs7eAEUzAFkG5d0NKHgdG0sf56cMhKuYRmaGDb6qwr9Kl1HtMfKrD9HkT
 ZhE4fX22v/AXdwicCpFwbPFmjzNHX+n3mt0evdqpVQr2Mwf9T2orpq6GV5+Gy9G1rg6UlJ1
 GT2eEwrF/vzkFjqz4qTEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mgYMz0yAcco=:czFn6UEvyruhw+8yjTVFxS
 ZFHzASLuSyKqcFqVGw30sbUcAPKS6pKRSjM59pBL2AAdPG0W+WaJ1Q+mEh208Utv2w+ltDhez
 2QaC4K0ROTUVxCr1MuqetGGXn84/DOpyui6whvyMzEMKxe95RF4cz0/jAD72aoe2J2JL0kKJ0
 6gdY+gka9JcAuzSChA0+q5CofIoR6dZWW+ToaFOj5o87HXxCuVULhqI/c4aYaeRCxlo3B892K
 CEldNXBTWOp2ny/JRqNxhwlPhH7ToKxhCUjBSvpjo+kVSbolljEjOdP7JKzJ3NtjtdXHFC6h6
 7yidtHO2tE0Qmm7AuwDx82mo0OOYqhlBWMPvKkjKvMwUgaiFNE1h1urEhxVliZue1dqx+Mh3N
 i53jViYwJeePITFXRhqq8MmA7RwhSTbrf7h4vihI2gG3uneIdVAjwNh9reQzFyIfiuBNlPO7w
 BYgrfxwvoYixh/ut5MXdGgOrGalx+TAFMGbaySKRZwOVM8NZW+4OKd4DoLIpwl6j78PzomGmM
 8fuXDnWzkRT6uLj/CXo6KF4TsWyP/jnvrbHjWlLXx7i/Gc+HUrgXVJ8I32MUqOiT2BVmOUVij
 TeJfO48GYB/ihFuJ0jXkmOTbH5LLWWbNJxkpfB6iBxH/VeuUihEzwPxqkEexM1UAxu4BLdfHL
 nxQImEHDW96liLHRapBZFEMgnaNnelmobl4/oruScUryFaHbBx9hwg6rZF4D0V9TwmEeW5Haa
 hqP7hS8FxHUN5Kg8MSwHNoIb+o6wk7KNDBSiaJkKPp4nN4kGmRzUqk0CXDwtessnfwgFlgbJ2
 shFNHD9
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

On 06.11.22 20:14, Leon Romanovsky wrote:

> On Fri, Oct 28, 2022 at 03:45:15PM +0200, Stefan Assmann wrote:

>> Add a check to make sure crit_lock is being held during every state

>> transition and print a warning if that's not the case. For convenience

>> a wrapper is added that helps pointing out where the locking is missing.

>>

>> Make an exception for iavf_probe() as that is too early in the init

>> process and generates a false positive report.

>>

>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

>> ---

>>  drivers/net/ethernet/intel/iavf/iavf.h      | 23 +++++++++++++++------

>>  drivers/net/ethernet/intel/iavf/iavf_main.c |  2 +-

>>  2 files changed, 18 insertions(+), 7 deletions(-)

>>

>> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h

>> index 3f6187c16424..28f41bbc9c86 100644

>> --- a/drivers/net/ethernet/intel/iavf/iavf.h

>> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

>> @@ -498,19 +498,30 @@ static inline const char *iavf_state_str(enum iavf_state_t state)

>>  	}

>>  }

>>  

>> -static inline void iavf_change_state(struct iavf_adapter *adapter,

>> -				     enum iavf_state_t state)

>> +static inline void __iavf_change_state(struct iavf_adapter *adapter,

>> +				       enum iavf_state_t state,

>> +				       const char *func,

>> +				       int line)

>>  {

>>  	if (adapter->state != state) {

>>  		adapter->last_state = adapter->state;

>>  		adapter->state = state;

>>  	}

>> -	dev_dbg(&adapter->pdev->dev,

>> -		"state transition from:%s to:%s\n",

>> -		iavf_state_str(adapter->last_state),

>> -		iavf_state_str(adapter->state));

>> +	if (mutex_is_locked(&adapter->crit_lock))

> 

> Please use lockdep for that, and not reinvent it.

> In you case lockdep_assert_held(&adapter->crit_lock).



Lockdep is mostly enabled in debug kernel but I was hoping to get

warnings in production environments as well. As those transitions don't

happen too often it shouldn't hurt performance.



> In addition, mutex_is_locked() doesn't check that this specific function

> is locked. It checks that this lock is used now.



You are correct, this check only triggers if crit_lock is not locked at

all. It would be better to check the lock owner, but I couldn't find an

easy way to do that. Better than no check IMO but we can drop it if you

don't see a benefit in it.



Thanks for the comments!



  Stefan

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
