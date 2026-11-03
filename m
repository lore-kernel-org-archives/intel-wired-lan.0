Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B811606A324
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9aot+aum;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=e/9ukaL9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 251AE404F8;
	Tue,  3 Nov 2026 01:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Toe3Hk3aNPBx; Tue,  3 Nov 2026 01:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 29F0C40540
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793667930;
	b=SMjc30KIRJg3lpxKj0/zY0EvvZYMBDvppYYUfirG3pB6mCo93buEMOYvxILrPqhtojHh
	 kIMKLFL7BiPpWHbttfai2Vjs8kEnrqmUhVadmZUlg5uNh4AvIkmCYnmrD8IA1OXFxcrKq
	 5tO0xxgoYXq3cqoajaEhRE6WiJ5csX131VszsAcyqGdWAIYl9/AJ/4oaBhi+nNu7SjNE5
	 uXi7hTg+0Na3bidIuuD+YSIloO/tF2NrBv0R/L4suiKOKz8EnNYuKqmgc2JVakaqxGj18
	 7hC5TQI8k/73uI4uU4DFY9PLYgxVq3e1y9KZCb3iA7gYY29uZzpGtT5jr+K5WtbOgKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793667930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NnkY2DC4h5FBOyoy0W5E18s80gLOkDFUVQgHeLoHd8E=;
	b=fVNN6oc+zZHzx9ejfOMbZFCxz9idQN3n84pfmXkr2IhP+NxZPfMMGh9dEN/Lj5FBvA7B
	 S7S6816iHb01xgsYhMD/7t2ODeNZkxKTyyNjZMijeDrFKIhN+2mhxf9zut/zlCxuWpTVw
	 mRpAAMPK03Ke1R0zAUu+yoSfzwau9opFl2PvQvrTG3Onef7mx6zDNh03PgZHWzyF9pGSE
	 MMSSOOuBLrirBMn/RlDMNoAZHKlq+9f0NIVGxKIFsOBuo0MbIvjoezS3xJ1eh+vP3CRhW
	 8OrvVIs76IAldUllIGmY55okeaXY58FT3d4EBHMlJZRd7xQloWhof8oWRY2dXCN13QQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793667930;
	bh=NnkY2DC4h5FBOyoy0W5E18s80gLOkDFUVQgHeLoHd8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9aot+aumf14IRGAtBr4oeGs61mrwHswpslsgicgrk0SpK6syHo3Qrx5JqHwsWZj+Q
	 OQ8kuRuMSj+GG5zeQXS92wNGq9ZeshvB5fb0MRndJmx4I6wR+uqcSNbjAbLcvQKywU
	 pHCPkmHExbDdFCrs7EB/Cwyf7PmLUXYzReMlJjC3r+UX7AdBHaK6yK5xfbqOD16L3B
	 p6YvBHzpVwqVaJ0vlwJJGJhzTx2G+6KLAEgJ/FDNPrMgQR9xSzHQ39NeEKvnlHdcxd
	 TcJ/DZ6MJF960wX9eJSYUNvcAyIEC9sqYGA7okl5uhAxOFzkly009oX5HkYlyzyURH
	 4UAS45AH9CrVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29F0C40540;
	Tue,  3 Nov 2026 01:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2814F4BC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 01:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F2E580D16
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 01:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WqZZcp3y2l18 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 01:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F5A580D0B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793667928;
 b=o8Rgh3yrlEFghYJwBLc7JeIY9LphdwzcuKM9z7zTuBq3Dp+dZbNaIF56Pj/ks989Jw1Y
 EkMI98uBnBrE4KMdPhdH7ZxIuN9vxud2IoeE+mt55KkUYOyu7Dv/qIGCxmEp/vH0b85bF
 jTwd7VyXIsqDmq4JyOeXye/+zHmYdXs273GnKgZ0kL+qRw+ECeFWoxqRtakYOSOEPPLx7
 76HkV9iPN8ayg3OLccAlH1jcYN8LEJN8zoIAan7D+6tuCEoIR1kVA+RhK2H8r3rlfK4uj
 +TIPh6iIH5/4zn66i2YqD/QO6j6zrvWcpo6E0kDqbiyvqJ29AJZb8z+gVGdsAQ4dCgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793667928;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=NnkY2DC4h5FBOyoy0W5E18s80gLOkDFUVQgHeLoHd8E=;
 b=nin9dpRbS00H8jEZM57Op/LW/SVYbnmOlOMw8WD4D2jmH8rmdUsZdV9/NjNUa/iivJus
 hBRnHT6PyOm5XmhBIMWMv5uXJH253fayJQaZBF3Ld/LcBV8RbIrrD+wrDPaef/jYCSvXJ
 ytychgMrJvFgxM8naCdWswiSYQjGXtXcF4kNZQ5HDx4v276Q5DWhEOkLexcjHgqYmQxrj
 f+V/T16x4FMix1ydHhd30Q0IeGhfTasZa/07Fth7VhVfZJDpf5C2NaSYQaytBvH5xWVFl
 07SjYSR/HhpNzq9QYgrpxehfVZxYQhZeV5MLG/sR6I4oG391eMT5ylBlvdmWIKTzFag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b="e/9ukaL9"; 
 arc=none smtp.remote-ip=220.197.31.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=e/9ukaL9
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F5A580D0B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 01:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=NnkY2DC4h5FBOyoy0W5E18s80gLOkDFUVQgHeLoHd8E=;
 b=e/9ukaL97NDmYYjkYbJ2lppAzZJJpoIN8WYST4O2xCvwRvYr/jKxzr1EHd3e7q
 L+SgsdeQvSPpcsI1vXxbBPT9DnL1geaVB8XwSxvSaWJKgSZLvxdyBo8AL2iOflTV
 0GjrkICSxCSXGB5sfCQL/Q0E5SUUmQFmDXqVpp4OWl60A=
Message-ID: <7f3b08fb-8eec-4ff1-a696-f8a1b3df7b45@126.com>
Date: Tue, 3 Nov 2026 09:04:55 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
To: Jacob Keller <jacob.e.keller@intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20261028090455.2291659-1-xiaolinkui@126.com>
 <c4c4833b-b0e9-4d79-9e7b-7db9eee67535@intel.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <c4c4833b-b0e9-4d79-9e7b-7db9eee67535@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD3d3k3M+lqJRVrCg--.32589S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4UCryDZFyfJw1DAr1kZrb_yoW5ZF1xpa
 y5CFyYkrs8tr13Ka97X3W8Ar98Kan7tay5WFyYyw15A3s8uFyxCrykKrW8uay0q3ykGw1j
 qrn8Zw1xGan8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBvvxmrpMzuB5gAA3K
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jake,

Thank you for applying the patch and for the review.

On 2026/11/3 06:15, Jacob Keller wrote:
> On 10/28/2026 2:04 AM, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> e1000e_config_hwtstamp() stores the requested configuration in
>> adapter->hwtstamp_config right after the rx filter has been
>> translated, but the two register writes that follow are verified by
>> reading the registers back and each of them can fail with -EAGAIN.
>>
>> When one of them does, the driver is left holding a configuration the
>> hardware never accepted:
>>
>>   - e1000e_hwtstamp_get() hands it back to user space, so an
>>     application that reads the configuration back is told that
>>     hardware time stamping is in effect while it is not;
>>
>>   - e1000e_systim_reset() re-applies it after every reset, including
>>     the ones the watchdog triggers, and keeps failing;
>>
>>   - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
>>     filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
>>     time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
>>     are eventually dropped by e1000e_tx_hwtstamp_work() with a
>>     "clearing Tx timestamp hang" warning.
>>
>> Cache the configuration only once both registers have been verified,
>> so that adapter->hwtstamp_config always describes what the hardware
>> is programmed with.
>>
> 
> Any idea why this got marked as patch 2 out of 5? This doesn't appear on
> either netdev or iwl with any other patches.
Regarding your question about the "2/5" marking: it was an oversight on 
my end. I generated this fix from a local branch that contained other 
commits, and `git format-patch` automatically added the series 
numbering. The patch is indeed a standalone fix and was not intended to 
be part of a series posted elsewhere.

I'll make sure to use a proper invocation for single patches going forward.

Thanks again for your time and for taking this fix into the Intel Wired 
LAN tree.

Best regards,
Linkui
> 
> I'm going ahead and applying it to Intel Wired LAN regardless, since the
> fix looks good.
> 
> Thanks,
> Jake
> 
>> Fixes: 62d7e3a2d006 ("e1000e: Validate hwtstamp_config completely before applying it")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 35f5590228eb..7ae33273734f 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -3715,8 +3715,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>>   		return -ERANGE;
>>   	}
>>   
>> -	adapter->hwtstamp_config = *config;
>> -
>>   	/* enable/disable Tx h/w time stamping */
>>   	regval = er32(TSYNCTXCTL);
>>   	regval &= ~E1000_TSYNCTXCTL_ENABLED;
>> @@ -3763,6 +3761,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>>   	er32(RXSTMPH);
>>   	er32(TXSTMPH);
>>   
>> +	adapter->hwtstamp_config = *config;
>> +
>>   	return 0;
>>   }
>>   

