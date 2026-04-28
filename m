Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36DFFF8868
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 09:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 727A1411B9;
	Tue, 28 Apr 2026 09:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJtWuWMMDv9I; Tue, 28 Apr 2026 09:18:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7297141198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777367927;
	bh=CfB5tuzgswNgcsSHADF2fIdUxCeUXfohJsD6S60ChhI=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sieBn4rcJoQz2yoHC26aUWNhbMCFwC6K0TWho17/ogxOeNDCJrntO9m22gNCFX93s
	 BfQJMvcysXG5eBtEk7tpRLfNjga6/tYJMB1iu9Lq5Lgbgj0b/2dBUAkdk2KL4tjx66
	 K8G5qPD7q/n7XWwnASfdDozq0Rf4sz3z2FD8b3rT4KjtwfeBxawtPMypjP6gHFsnKI
	 VQeyaVlcdssCQ5PGT2rDxMmAAeHam/KIsuRIFug4UuGaj0KweuTQBj/XJuI1EO2vKS
	 sqoIOFbM1BIr2GTxLgAyQ+GpTapKW+vK0C5eA1Eh+mcZuH+VTVcA3af1zq3kPMHLOV
	 Pq2RT1ZUR4WHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7297141198;
	Tue, 28 Apr 2026 09:18:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2474A1B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A9C841194
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:18:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnNJOIiK4EfW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 09:18:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 80A8041198
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80A8041198
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80A8041198
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:18:41 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 899634C4431022;
 Tue, 28 Apr 2026 11:18:00 +0200 (CEST)
Message-ID: <091fa6fa-0f1d-40b3-9c32-8401306f0e66@molgen.mpg.de>
Date: Tue, 28 Apr 2026 11:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Kohei Enju <kohei@enjuk.jp>
References: <20260424030345.1140665-1-aaron.ma@canonical.com>
 <0d1ef57c-7ab6-4ed1-bc11-323aeeb12eac@molgen.mpg.de>
 <CAJ6xRxUEcbadApMg0i7ngcqYMUacrGNvCrUZ96sqkW22TsC7iA@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAJ6xRxUEcbadApMg0i7ngcqYMUacrGNvCrUZ96sqkW22TsC7iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in
 ice_resume()
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

Dear Aaron,


Thank you for your reply.

Am 28.04.26 um 09:53 schrieb Aaron Ma:
> On Mon, Apr 27, 2026 at 6:13 PM Paul Menzel wrote:

>> Am 24.04.26 um 05:03 schrieb Aaron Ma via Intel-wired-lan:
>>> ice_resume() schedules an asynchronous PF reset and returns
>>> immediately. The reset runs later in ice_service_task(). If
>>> userspace tries to bring up the net device before the reset
>>> finishes, ice_open() fails with -EBUSY:
>>>
>>>     ice_resume()
>>>       ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>>>     ...
>>>     ice_open()
>>>       ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>>>     ...
>>>     ice_service_task()
>>>       ice_do_reset()
>>>         ice_rebuild()               # clears ICE_PFR_REQ, too late
>>>
>>> Reproduced on E800 series NICs during suspend/resume with irdma
>>> enabled, where the aux device probe widens the race window.
>>
>> Please document, how you reproduced it, and also paste possible messages
>> by Linux or NetworkManager, so that people can easily search for the commit.
> 
> The error message is "can't open net device while reset is in progress"
> I can add it in v3 if you like.

Yes, that’d be great.

>   > > Wait for the reset to complete before returning from ice_resume().
>>
>> Please mention the delay length in the commit message.
> 
> The timeout is 10 * HZ (10 seconds), matching the existing usage in
> ice_devlink_info_get() for the same ice_wait_for_reset() call. In
> practice the wait completes in ~300ms.

I often wonder, where the delay values come from. Maybe mention, that 
you copied it.

>>> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>> ---
>>> v2: reword comment to clarify best-effort semantics (Kohei Enju)
>>>
>>>    drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>>> index 5f92377d4dfc2..a81eb21ea87c1 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>> @@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
>>>        /* Restart the service task */
>>>        mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
>>>
>>> +     /* Best-effort wait for the scheduled reset to finish so that the
>>> +      * device is operational before returning. Without this, userspace
>>> +      * (e.g. NetworkManager) may try to open the net device while the
>>> +      * asynchronous reset is still in progress, hitting -EBUSY.
>>> +      */
>>> +     ret = ice_wait_for_reset(pf, 10 * HZ);
>>
>> Why not pass a delay in micro/milliseconds?
> 
> ice_wait_for_reset() takes jiffies — that's the existing API.

It’s recommended to use `msecs_to_jiffies()` to make it HZ invariant.

>>> +     if (ret)
>>> +             dev_err(dev, "Wait for reset failed during resume: %d\n", ret);
>>
>> Mention the delay?
> 
> Good point. I'll include the timeout in the error message in v3.

Awesome.

[…]


Thanks,

Paul
