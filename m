Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CAFC0015E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 12 Aug 2023 11:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3348408B0;
	Sat, 12 Aug 2023 11:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3348408B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691839244;
	bh=bnqjKBfVkaBzaRJ3UayxqyfkvPyquZXnbfnKRpZDw2U=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FVlcAWSB53oydafYjLLde31a6sE2gBy28Fm0qbGpnEzGbHHlPqFx/215rKMBGz8F9
	 fQ79+r0nqQRdnoeD6CEaEq6ioYIsMY5wJt5zfGhhgxpLK0A44mItmTlgWqzfhG8Ctg
	 P79BRgnLSVVX2CHUb03i1Lbi+7bid1gBySvvVasq/o6zn9Ow5WOJoMJGp7miy8yWif
	 gvNO8VnmOHWeCVDGRdiqR/bhs8YcJXB7/IoB5gYiowEVcprw4q0kgb4mTjRh/u7FHo
	 eNk5zf6IXkYlFqydscBR8G7Y2jPEimOOZ75cPpjHoyFo2NuDhcid8+3Y1dRwCUGqed
	 r1z4dAUpiOzDA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7bOtCsqZZD28; Sat, 12 Aug 2023 11:20:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5937741553;
	Sat, 12 Aug 2023 11:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5937741553
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id BC83C1BF282
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Aug 2023 11:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 645CF60E64
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Aug 2023 11:20:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 645CF60E64
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id reXatTx-Zzmx for <intel-wired-lan@lists.osuosl.org>;
 Sat, 12 Aug 2023 11:20:38 +0000 (UTC)
Received: from out-89.mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0184607C1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Aug 2023 11:20:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0184607C1
Message-ID: <436629d9-dd05-7593-1439-f22c9957485d@linux.dev>
Date: Sat, 12 Aug 2023 12:20:32 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <ZNclEAXpyAFrhCh5@nanopsycho>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZNclEAXpyAFrhCh5@nanopsycho>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1691839234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYo66lOIT+5jOUo4wy3zizk9GdGi3NV1HZ2V22eu1ns=;
 b=jFz/38T66Y6siTMwiAscYuxfkEZaBMIbcW6Q2SYha5VHt/0mhzefJ1jz/KT5yfzz0mCyzN
 dactyUAErLwrNu4EtspM8oujFFvcFRZyCSxKTMcWzmF3wYVS9feK4b5FGU+vM9VaWSDBgm
 htWF0rUREYLroIOqRHZwxsl9zfgyWec=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=jFz/38T6
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/9] Create common DPLL
 configuration API
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
Cc: Bart Van Assche <bvanassche@acm.org>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Milena Olech <milena.olech@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 12.08.2023 07:22, Jiri Pirko wrote:
> Fri, Aug 11, 2023 at 10:03:31PM CEST, vadim.fedorenko@linux.dev wrote:
>> Implement common API for DPLL configuration and status reporting.
>> The API utilises netlink interface as transport for commands and event
>> notifications. This API aims to extend current pin configuration
>> provided by PTP subsystem and make it flexible and easy to cover
>> complex configurations.
>>
>> Netlink interface is based on ynl spec, it allows use of in-kernel
>> tools/net/ynl/cli.py application to control the interface with properly
>> formated command and json attribute strings. Here are few command
>> examples of how it works with `ice` driver on supported NIC:
>>
>> - dump dpll devices
>> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --dump device-get
>> [{'clock-id': 282574471561216,
>>   'id': 0,
>>   'lock-status': 'unlocked',
>>   'mode': 'automatic',
>>   'module-name': 'ice',
>>   'type': 'eec'},
>> {'clock-id': 282574471561216,
>>   'id': 1,
>>   'lock-status': 'unlocked',
>>   'mode': 'automatic',
>>   'module-name': 'ice',
>>   'type': 'pps'}]
>>
>> - get single pin info:
>> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-get --json '{"pin-id":2}'
>> {'clock-id': 282574471561216,
>> 'module-name': 'ice',
>> 'pin-board-label': 'C827_0-RCLKA',
>> 'pin-dpll-caps': 6,
>> 'pin-frequency': 1953125,
>> 'pin-id': 2,
>> 'pin-parent-device': [{'id': 0,
>>                          'pin-direction': 'input',
>>                          'pin-prio': 11,
>>                          'pin-state': 'selectable'},
>>                         {'id': 1,
>>                          'pin-direction': 'input',
>>                          'pin-prio': 9,
>>                          'pin-state': 'selectable'}],
>> 'pin-type': 'mux'}
>>
>> - set pin's state on dpll:
>> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-state":2}}'
>>
>> - set pin's prio on dpll:
>> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-prio":4}}'
>>
>> - set pin's state on parent pin:
>> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-set --json '{"pin-id":13, \
>>                       "pin-parent-pin":{"pin-id":2, "pin-state":1}}'
>>
> 
> For the record, I'm fine with this patchset version now.
> Please merge and make this jurney to be over. Thanks!
> 
Thanks Jiri! We are waiting for Jakub to review the code again and hopefully
merge the code1
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
