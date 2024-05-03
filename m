Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3275C4345F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 May 2024 18:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 631B8404A3;
	Fri,  3 May 2024 18:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gHyopt0vcM9t; Fri,  3 May 2024 18:08:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E58440443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1714759708;
	bh=7krJSqa8wuLXGsELKd69ZwXPLKfylvjCfsQDlS3hK/Y=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XZrJN5IE4xXqTCvzD7UQ+OdDw8vointXsIMG/sSl1pS4AX66h4BAXgncW8r5Fw5nX
	 wNGKZCJcSxmsL63hNRqM4zmcusXobzP8uEO6rdkNLaq0rhY2y8wTX+anhpK2HwPfl1
	 1siqz/DeqmE83X8geeJ2MATEYDbQNc87XCgW0fNrXjRya6j5ANOkigFKw1bBlo+n8Y
	 2C1rS27i24pCV6DRCTHOSV3YFdG6oME2L0OUd8zBn5YbpQPY/iNA8EqQrF6qhzD55o
	 cVVagqg5gIwlHDQ+my1ZVEFc2D1BYIbn+zYbr0xTHudsp1LPJGTs95FqOd/JcGgvf4
	 JaHP23fClb0rw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E58440443;
	Fri,  3 May 2024 18:08:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 232F71BF311
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 May 2024 18:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DF606080A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 May 2024 18:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xde51so3v5W9 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 May 2024 18:08:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.104.135.124;
 helo=mail1.fiberby.net; envelope-from=ast@fiberby.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 74E006079F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74E006079F
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74E006079F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 May 2024 18:08:24 +0000 (UTC)
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
 by mail1.fiberby.net (Postfix) with ESMTPSA id C234D600A2;
 Fri,  3 May 2024 18:08:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by x201s (Postfix) with ESMTP id 5823420146D;
 Fri, 03 May 2024 18:08:04 +0000 (UTC)
Message-ID: <80089193-33e8-4601-bdbc-71d10ff1ab58@fiberby.net>
Date: Fri, 3 May 2024 18:08:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
References: <20240416144331.15336-1-ast@fiberby.net>
 <PH0PR11MB50139E3BE2709C5BE7F4AC78961F2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <PH0PR11MB50139E3BE2709C5BE7F4AC78961F2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=fiberby.net; s=202008; t=1714759701;
 bh=lpjffUs0KsD4f1OIdu+oOs418PzFZ7RJRguA69+8Ufg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Nm2drleWzUli4rPVRzHIxWXPNsM1P7Lh/mZEVcqcpPgnUhoWJdBr/p0F7y3LbVz+a
 4T3o8u8ds+dMOu9SiMtVXNN6U1M/8dna+PH56Vj/GFcwvHK5HmU8BAxhDVnR0/pfg3
 77htbJMnUJyvVyvAKBaAgzTaohiq+SZDxHhec75OsZ2QVs+MOxOZTBCwCG/yknxwT6
 xwemhYv+LxkMeCbLbtVa3UO/P+L0/M+1foLt37LqEcfu4p4YZG/99PZ+hHWt/1M+/2
 sqVqoRuDnKJMkAkDzHfP3hf2Zj6pDZmpquWoDm3YwcjjXAP3UbzdzYu8qDDqhXssLG
 5uQpZiVHj2voQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=fiberby.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=fiberby.net header.i=@fiberby.net header.a=rsa-sha256
 header.s=202008 header.b=Nm2drleW
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: flower: validate
 control flags
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Sujai,

On 5/3/24 5:57 AM, Buvaneswaran, Sujai wrote:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Asbjørn Sloth Tønnesen
>> Sent: Tuesday, April 16, 2024 8:14 PM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Eric Dumazet
>> <edumazet@google.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Asbjørn Sloth Tønnesen <ast@fiberby.net>;
>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> David S. Miller <davem@davemloft.net>
>> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: flower: validate control flags
>>
>> This driver currently doesn't support any control flags.
>>
>> Use flow_rule_has_control_flags() to check for control flags, such as can be
>> set through `tc flower ... ip_flags frag`.
>>
>> In case any control flags are masked, flow_rule_has_control_flags() sets a NL
>> extended error message, and we return -EOPNOTSUPP.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
> 
> Hi,
> 
> I have tested this patch in upstream kernel - 6.9.0-rc5+ and observing no effect while adding tc flow rule with control flags.
> 'Not supported' error is not shown while adding the below tc rule.
> 
> [root@cbl-mariner ~]# tc qdisc add dev ens5f0np0 ingress
> [root@cbl-mariner ~]#
> [root@cbl-mariner ~]# tc filter add dev ens5f0np0 ingress protocol ip flower ip_flags frag/firstfrag action drop

Thank you for testing!

I think the issue you are observing, is because you are missing "skip_sw":
tc filter add dev ens5f0np0 ingress protocol ip flower skip_sw \
	ip_flags frag/firstfrag action drop

Without skip_sw, then the hardware offload is opportunistic,
and therefore the error in hardware offloading doesn't bubble
through to user space.

Without skip_sw, you should still be able to observe a change in
`tc filter show dev ens5f0np0 ingress`. Without the patch you
should see "in_hw", and with it you should see "not_in_hw".

With skip_sw, then the error in hardware offloading causes
the tc command to fail, with the -EOPNOTSUPP error and
associated extended Netlink error message.

Also see Ido's testing for mlxsw in this other thread:
https://lore.kernel.org/netdev/ZiABPNMbOOYGiHCq@shredder/#t

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541
