Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC06ECD983
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 16:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1203640ABE;
	Thu,  5 Feb 2026 16:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oH_rs_tfgecu; Thu,  5 Feb 2026 16:27:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5762E40A2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770308841;
	bh=ET/qeIEpwmI/Es2elWLSYLqXMVH7pqog+cxAo+h7unM=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MCapSgOMvJwt+1Hzvy8SFq7Xn7qdecuk8EMI2kV1MYCZhPD5CcAKw9sYg/IpF1RSM
	 LP+DUnlIK20crOa4ir1YT5oTUlNVukWCDcJ2HqQ31WM1P9YrTUCgPrc7KO4+qi0z8Z
	 GW74Aq32ayeV549nNjhzOZz8+eVZNa+qxm4f3YXcJCzG40yl+dAatJipBFgorVlBU6
	 D3/pmYwf6khXDgKf/CCoH+URRQcHHAP8ljE/UYoZLepIBFii2/KBFisRW0nQIE+Xb7
	 CFhpbTtzuAzkr7NeiaSiNmblcya+q+B6ey+gI8Qxo6YNjqR4ogp5A1hUB9/uotthof
	 93xMz02EW/DWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5762E40A2A;
	Thu,  5 Feb 2026 16:27:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5F6417A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D14B860EA3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DGWYVal8U7_4 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 16:27:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.186;
 helo=out-186.mta1.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B022260B13
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B022260B13
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [95.215.58.186])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B022260B13
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:27:16 +0000 (UTC)
Message-ID: <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
Date: Thu, 5 Feb 2026 16:27:03 +0000
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260205145104.iWinkXHv@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1770308828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ET/qeIEpwmI/Es2elWLSYLqXMVH7pqog+cxAo+h7unM=;
 b=BeTe8UR1CL3v7CzRECCoz4879yHxH8spUWym3MIX+VYLz/P/y3rXxHSDBxMVnCyGqA+Ix8
 g9Fh+B4lgqMmtuIOQiSsruwLH48OsRuEUzzrnRm8D03KbfoO3qlP+2z6RjOIWZ5o4LZ08r
 q5ewL6Vp32VAGbWCY7l5UM3+34J9F/w=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=BeTe8UR1
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

On 05/02/2026 14:51, Sebastian Andrzej Siewior wrote:
> On 2026-02-05 11:56:44 [+0000], Vadim Fedorenko wrote:
>> On 05/02/2026 10:37, Loktionov, Aleksandr wrote:
>>> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep
>>
>> Hmm... that actually means we have some drivers broken for RT kernels if
>> they are processing TX timestamps within a single irq vector:
>> - hisilicon/hns3
>> - intel/i40e (and ice probably)
>> - marvell/mvpp2
>>
>> For igb/igc/i40e it's still OK to process TX timestamps directly in
>> MSI-X configuration, as ring processing has separate vector, right?
> 
> The statement made above is not accurate. Each and every driver does
> request_irq() and here on PREEMPT_RT you can freely acquire spinlock_t.
> 
> But !RT looks problematic…
> 
> __skb_tstamp_tx() invokes skb_may_tx_timestamp() which should exit early
> most of the time due to the passed bool (which is true) or
> sysctl_tstamp_allow_data which is true. However, should both be false
> then it tries to
> 	read_lock_bh(&sk->sk_callback_lock);
> 
> where lockdep will complain because this lock is now acquired with
> disabled interrupts.
> 
> The function will attempt do free the fresh/ cloned skb in error case
> via kfree_skb(). Since it is fresh skb, sk_buff::destructor is NULL and
> the warning in skb_release_head_state() won't trigger.
> 
> So the only thing that bothers me is the read_lock_bh() in
> skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
> the same CPU.

Alright. Now you make me think whether we should enforce OPT_TSONLY
option on socket which doesn't have CAP_NET_RAW? Then we can get rid of 
this check, and in case sysctl was flipped off - drop TX timestamps as
it's done now?

