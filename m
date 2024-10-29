Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E135D3A670
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Oct 2024 16:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B90380D16;
	Tue, 29 Oct 2024 16:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jO24RHca4k2c; Tue, 29 Oct 2024 16:17:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 994BC80B0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1730218643;
	bh=ezYmkGlGSx9edqpDHAZhMKqx6HNJfpqrUbm2d+S7mr4=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QhZ21VjgxvTDJwDmRzAgv5dDak1quPjGywWQztsR5YpO4Qj18/0L9NYMeDmrD/F2e
	 2A9AlO8qOwy0yZBJnv1ikwW1cz8NAsOCRjBRUt2zCLAPwRe1/il0HpxjdGeStRK//m
	 hTVnRWsKhG/TBkKJECXWBUrKcA1POKKnbG46sbh8UQm1MmLXFUK0zPX/S+PHHtunzU
	 OSfKbTGf8tNTz3mAKPtouxMppTbICs/umASERo9MoPQb0TLtwQwUSUbELjThpvwwRg
	 sbhM3GQi9E8yRcuaU9OV5IAs5q0+Vrc95xWejyhA0rP4zvsK+OHlq3LfPiAIci0UO7
	 fZxXouZpmeWHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 994BC80B0D;
	Tue, 29 Oct 2024 16:17:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 186C2496C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Oct 2024 16:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED85440211
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Oct 2024 16:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ipsC6N7jKhGq for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Oct 2024 16:17:20 +0000 (UTC)
X-Greylist: delayed 16725 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 29 Oct 2024 16:17:19 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 541C44020C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 541C44020C
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.173;
 helo=out-173.mta1.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 541C44020C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Oct 2024 16:17:19 +0000 (UTC)
Message-ID: <54b8ad89-5bac-475f-b655-942c7e6d60a2@linux.dev>
Date: Tue, 29 Oct 2024 16:17:10 +0000
MIME-Version: 1.0
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "richardcochran@gmail.com" <richardcochran@gmail.com>
References: <20241028204755.1514189-1-arkadiusz.kubalewski@intel.com>
 <8899c12f-bc2f-49d3-bded-e838ac18fef8@linux.dev>
 <MN2PR11MB4664B05DF435E9731B7877419B4B2@MN2PR11MB4664.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <MN2PR11MB4664B05DF435E9731B7877419B4B2@MN2PR11MB4664.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1730218636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezYmkGlGSx9edqpDHAZhMKqx6HNJfpqrUbm2d+S7mr4=;
 b=E/xw3gBXRwoTD0j72Z0gRttCAx/mBKPcUud+4+geDwH4Eqs2A22gzw4CMWwQ/d46Eujxzj
 XSiKYbbnpgoWi1vhUpx4wE+nD6GUlCrdGSgsBnwTe2qqOjnVDwJCKRKQVqmnxWa27+cXqL
 YvXvTTothAJxiUTRN6UULge45yvhhCA=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=E/xw3gBX
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 0/2] ptp: add control over
 HW timestamp latch point
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

On 29/10/2024 15:56, Kubalewski, Arkadiusz wrote:
>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Sent: Tuesday, October 29, 2024 12:30 PM
>>
>> On 28/10/2024 20:47, Arkadiusz Kubalewski wrote:
>>> HW support of PTP/timesync solutions in network PHY chips can be
>>> achieved with two different approaches, the timestamp maybe latched
>>> either in the beginning or after the Start of Frame Delimiter (SFD) [1].
>>>
>>> Allow ptp device drivers to provide user with control over the timestamp
>>> latch point.
>>>
>>> [1] https://www.ieee802.org/3/cx/public/april20/tse_3cx_01_0420.pdf
>>
>> I just wonder should we add ethtool interface to control this feature.
>> As we are adding it for phy devices, it's good idea to have a way to
>> control it through eth device too. WDYT?
> 
> Seems doable, I guess somehow expand the controllability being added right
> now with this series:
> https://lore.kernel.org/netdev/20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com/#r
> Or some other idea?

Yeah, the series mentioned correlates with your work, that's why I asked 
about it.
It would be great to be sure that the interface you are proposing can be
reused or somehow combined with the series.
