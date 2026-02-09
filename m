Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9B4E7E0C3
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Feb 2026 10:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B99A083332;
	Mon,  9 Feb 2026 10:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 09-Q7C6Ae5YL; Mon,  9 Feb 2026 10:44:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A988A83323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770633851;
	bh=S2IQbg3EuRQv0ZXMFr8IH+0gBnowsk1pZP6YBjPZW0Y=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cG9BtJyXbze564Rm52vFjNsE7CIGcmRKKMSfHjkvHVkgMjg40KXx4qkjFwiq+8MKh
	 bCCxZ6sOKfgM31rvMRA7ECPaNOIctsSr8SLt9gqwJTgFKnjjcwoH0oYTbUiz5bs94i
	 z36yhEvq92ryzpjuRmRWZcZu6w3dRXFQHAuhzEt/bdfj7e7ieX6/CnrYr2H4jEWhTY
	 T6mVDqZQ3YeaCF3Xs8zYW7UEMzWajncnkO89PblxFva1G1kOr2QH3G8QF+3WHDcQ02
	 US1Mp5Eh8EL1u5i122/wD11a2bEvh9y9BY9IrkAgYkZYeT/KX2olxK69wk58yOZTea
	 qAA+YFp9aYJTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A988A83323;
	Mon,  9 Feb 2026 10:44:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0628B1A9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Feb 2026 10:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC907400F6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Feb 2026 10:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vyVqsPb7WITj for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Feb 2026 10:44:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=91.218.175.188;
 helo=out-188.mta0.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 506954019E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 506954019E
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 506954019E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Feb 2026 10:44:05 +0000 (UTC)
Message-ID: <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
Date: Mon, 9 Feb 2026 10:43:55 +0000
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
References: <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260209090621.GiZqTiMJ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1770633841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2IQbg3EuRQv0ZXMFr8IH+0gBnowsk1pZP6YBjPZW0Y=;
 b=YF/F6hZm/vwgeSDSvzouBC+ViBsrDG5LVxECAjdUZ+4Y3hs8dbRL8f8Lr5tjYqTkk00wkv
 PosVz6iUp/Jn28OlZEuFTuPBqz+G630U2vfAjLh+TgLm0SDYkADmydApFbXUsIqB1nJx0A
 oeeMw2q5as0j1+UKj2WfNjXh/URoB7Y=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=YF/F6hZm
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
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

On 09/02/2026 09:06, Sebastian Andrzej Siewior wrote:
> On 2026-02-08 11:25:40 [-0500], Willem de Bruijn wrote:
>>>>> But it's more like a question to maintainers whether it is acceptable
>>>>> way of "fixing" drivers or it's no-go solution
>>>>
>>>> Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.
>>>
>>> Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET_RAW all TX
>>> timestamps are silently dropped.
>>
>> Are you referring to sysctl_tstamp_allow_data?
>>
>> That is enabled by default.
> 
> Yes. If so, then we don't need the check below which requires
> sk_callback_lock.
> 
> Are SIOCSHWTSTAMP the legacy users or the ones which do not set
> OPT_TSONLY?
> 
> I would suggest to move the CAP_NET_RAW check to the point where
> timestamping is getting enabled.
> Also if ndo_hwtstamp_set is the preferred method of getting things done,
> I could check how many old ones are can be easily converted…

Looks like you are mixing things. SIOCSHWTSTAMP/ndo_hwtstamp_set are HW
configuration calls while OPT_TSONLY is socket option, which is setup 
via setsockopt, you can find points searching for
SOF_TIMESTAMPING_OPT_TSONLY in the sources, basically
sock_set_timestamping() is the function to check

> 
>>> To receive these timestamps users have to get
>>> CAP_NET_RAW permission, and it will work with the updated logic as well...
> 
> Sebastian

