Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD03C0015E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 18:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B88E404FE;
	Tue, 15 Aug 2023 18:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B88E404FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692123925;
	bh=/KtQEfXfUiZYcKB+dUy5AH+k2DPqsU0ExCSgC8bckw4=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KRIMFIRdJRhhjafLJmQtDY6688taPmX4XN2DBDR6IYR3SynBSLBSNze82zMZSdpxi
	 i0m94X6bjT8zXa4cWNZ/5H0L1DVifLJJWlgGDPvGndRQLylGafCff0/ZrDucFvhIIW
	 /jBHCelNdSftwvIIB8XePeb6ruxcMV1jt42PkXilOkBJRQhXvrBlBBhYo+ufbXfjL0
	 5WI3QeSJDJl7Kbl3pmsMtBIsXxx+MiNMOqRqhF1hbnbh7ucHTlq5MYBH4it9ZkIu3X
	 u04XdMpJhj6fZijQvnljPXs/CWEIi1eBaMfkjvm7Et92Hxkf0nWxKCl34PHiQresHd
	 prOcQd8mRar0A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jRT9tRyKA0iy; Tue, 15 Aug 2023 18:25:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4AFB405B2;
	Tue, 15 Aug 2023 18:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4AFB405B2
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1321A1BF422
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE8C58148F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:25:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE8C58148F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x09Cc8dq3a6h for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 18:25:22 +0000 (UTC)
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E55C4813EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 18:25:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E55C4813EB
Message-ID: <51cc24cb-13d7-7352-db25-bb5f10baa830@linux.dev>
Date: Tue, 15 Aug 2023 19:25:12 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-5-vadim.fedorenko@linux.dev>
 <20230814202441.349586b4@kernel.org>
 <d5c30de7-df89-18dd-3ad8-a5d99c1e7108@linux.dev>
 <20230815095519.76d06274@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230815095519.76d06274@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1692123918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmnrvXvdD8lgpuFR05ob4D/kjINcLJM401vTSVLXNrM=;
 b=fRteu83GGLzHE57G2311l51six8Q6p2BxtX/kymFzDXHnCHF1u6j9gAVhn25BW4pFsySlP
 y0qqD0gp3iqhCN64N/S/StnIjr3lkQpxEr2a8OdBUaO28dbKBDCT6FFJVgLocaE7ON10r8
 EVGMAAFJcp2OkdbE/CyN1dTXIJOYe6A=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=fRteu83G
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 4/9] dpll: netlink: Add
 DPLL framework base functions
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 15/08/2023 17:55, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 16:18:16 +0100 Vadim Fedorenko wrote:
>> On 15/08/2023 04:24, Jakub Kicinski wrote:
>>> On Fri, 11 Aug 2023 21:03:35 +0100 Vadim Fedorenko wrote:
>>>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>>>> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>>>> +		struct dpll_device *dpll = ref->dpll;
>>>> +
>>>> +		if (!ops->frequency_set)
>>>> +			return -EOPNOTSUPP;
>>>> +		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>>>> +					 dpll, dpll_priv(dpll), freq, extack);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		__dpll_pin_change_ntf(pin);
>>>> +	}
>>>
>>> only one freq is reported in get, AFAICT, so why send a notification
>>> after each ref is updated?
>>
>> The pin can be technically connected to several DPLLs and app may watch
>> for the specific DPLL messages only. We would like to inform all users
>> on any DPLL which has this pin connected to.
> 
> How does this end up looking in the notifications?
> __dpll_pin_change_ntf() only takes the pin object, from a quick read
> it seems like it will generate the same notification multiple times.

Oops... yeah, will move the notification outside of the loop.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
