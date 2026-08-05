Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4061AC55822
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 09:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6649606C6;
	Wed,  5 Aug 2026 09:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iSx1pehyNP0i; Wed,  5 Aug 2026 09:49:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2512460652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785923377;
	bh=NojVNnVq91doXEpC4NRBIsbrB0D73g+roZrJn17Ay9E=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PnGj/TPWHz2g0G765BYFmlNcZxJZww4f54U0wp7n+31PBDfcrlrNS3xbb6KJLLPUC
	 xOwd+THJ35bEj9BZdmm0Fp15OJ/QTSaQh8SAKW9FsoGkMzHMDlp4cWMhFPYwyg26x+
	 WEIRgEQ2EEaH3cnt6J9Mxi8CfgOCRRkWrnpKoJWszDU8kJaezksQQrEvRhtHGBuXKV
	 1xVQwA6pZvK6AIRRyAZFgAc41abvV7GauWi+iIDVzZEqID+DwCj3VWnn3H5GMMBZ5I
	 kbh3O4wplRjr+cm46btdz2T28mB//8JhOGrIFHTufplmmLnhIpSGJWeK9naMH/XHiZ
	 F1byY5vCvwCTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2512460652;
	Wed,  5 Aug 2026 09:49:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 65EF4397
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 09:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BF0A80807
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 09:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3upZWnugzm4q for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 09:49:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=91.218.175.174;
 helo=out-174.mta0.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CA686807F7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA686807F7
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [91.218.175.174])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA686807F7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 09:49:33 +0000 (UTC)
Message-ID: <0ba725ce-93a2-4616-a854-f1ff95e7bdd7@linux.dev>
Date: Wed, 5 Aug 2026 10:49:23 +0100
MIME-Version: 1.0
To: luoxuanqiang <xuanqiang.luo@linux.dev>, intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
 <dce23bb6-138b-4a53-9447-26e81c86c292@linux.dev>
 <ea295e13-6a35-4ce5-b289-f9f37b67dcf8@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ea295e13-6a35-4ce5-b289-f9f37b67dcf8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785923369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NojVNnVq91doXEpC4NRBIsbrB0D73g+roZrJn17Ay9E=;
 b=QNgzYa4bm3diyOBpVbd5u43+x85Lio3jnTMvn5AkRodwQXVqZSFCUdjiF/OsXE3AeM8CZt
 p2Zj7FbghA3UU1LZfNj7fJBScs5nBG2Mpy+tjoL50NifnD4Sj8llBodJxscMSqwfkAfGqU
 IkNJtc1EQB65xJIB7AjuNVWr4MpI6bk=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=QNgzYa4b
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] i40e: fix races in PTP
 external timestamp work handling
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

On 05/08/2026 08:13, luoxuanqiang wrote:
> 
> 在 2026/8/5 05:33, Vadim Fedorenko 写道:
>> On 24/07/2026 10:34, xuanqiang.luo@linux.dev wrote:
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/ 
>>> net/ethernet/intel/i40e/i40e_ptp.c
>>> index ff62b5f2c8150..fd51ab8c10c20 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>>> @@ -169,6 +169,17 @@ static void i40e_ptp_extts0_work(struct 
>>> work_struct *work)
>>>       ptp_clock_event(pf->ptp_clock, &event);
>>>   }
>>>   +/**
>>> + * i40e_ptp_init_work - Initialize PTP work for a PF
>>> + * @pf: Board private structure
>>> + *
>>> + * Initialize work which must remain valid for the lifetime of the PF.
>>> + */
>>> +void i40e_ptp_init_work(struct i40e_pf *pf)
>>> +{
>>> +    INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
>>> +}
>>> +
>>
>> why do you need extra function for a single line of code? why cannot 
>> you put it into i40e_ptp_init?
>>
>>
> Thanks for pointing this out.
> 
> i40e_ptp_init() is also called from the reset/rebuild path:
> 
>    i40e_service_task()
>      -> i40e_reset_subtask()
>        -> i40e_reset_and_rebuild()
>          -> i40e_rebuild()
>            -> i40e_setup_pf_switch()
>              -> i40e_ptp_init()
> 
> Putting INIT_WORK() there would reinitialize the work item during reset or
> recovery. If the work is pending or running, this races with the workqueue,
> resets its bookkeeping, and breaks the workqueue's non-reentrance
> guarantee.

ok, but then this driver has bigger problem. the same i40e_ptp_init()
re-inits tmreg_lock mutex and ptp_rx_lock spinlock. While latter might
be ok during reset (hopefully no traffic processed while the nic is in
reset), tmreg_lock mutex can be used for adjfine/adjtime/gettimex64/
settime64 callbacks as ptp device is still visible to user space.

I believe ptp part of the driver has to be redesigned properly.

> 
> The work item is therefore initialized once per PF from i40e_sw_init().
> The helper also keeps the work callback private to i40e_ptp.c.





