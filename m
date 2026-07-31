Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2EFC5516F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 19:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81D6341083;
	Fri, 31 Jul 2026 19:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qy0Ktvk_I87s; Fri, 31 Jul 2026 19:27:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D44AA41002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785526061;
	bh=P/71Eqm6eZkyzzsysSAa7b8sFQPr1CSpNZAPUkARlTM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mb01N4CSVZVYA0pjrqHVJZ23TU9zOiaelfw8IfDo6wF7cWdxrIredRmyAxjdo8otG
	 aBA4uBOZDv7he4Tx03oCDp4RyW/cC9t9Qx96az+VRKa7jqYdLAEqWYwivdT8JzsIOi
	 P4ZK8TeoXYA9ygujSPkn9GRt6Hoda5p51K16FRmc7nkwoDU2IYa/+1T1D/9YvfjpKk
	 oDijt/J72GCJ+ala3u8XXJzhfjvPjU2+rD0hSi9fJy5xwzK0AcdsMZctnXTB7B7Vpx
	 MD87CvDvnAVcWzt0Yf+O8FXmhAyztQFyYGeEE5l/P2V78ueEvk9/I0Tj2L89hts36e
	 pTtw2rD1ItRfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D44AA41002;
	Fri, 31 Jul 2026 19:27:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C6AF326F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 19:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8B0660644
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 19:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HravtzS8MMeZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 19:27:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DF9C660641
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF9C660641
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF9C660641
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 19:27:39 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81062fdeaf5so34431157b3.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526059; x=1786130859;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/71Eqm6eZkyzzsysSAa7b8sFQPr1CSpNZAPUkARlTM=;
 b=SIWnfJ0l6F6Ipq9DYofU8oqP1/MdmO+qP547YW11+4ACazuShxqLZniycSWiQtY2Kr
 myUmvmH0QoG9MZRQFajnlmxAJQXohH2dKXOMY9Vf0xXTdjND8IQmvSLRl5mLHzA62Oaq
 lZyp+f/0EhfWJExQwCp+7BOm6r210vRQmLoq6bR+CRXr4e7Ox+8C07rZR1kM5c+RFXbc
 R4RNk+7UrSPRKxBN/iSmDjzHSuSG3s16ODPAAQTM7gTtRq5uaoLk9R7vYzZ3MZqF8/ll
 AExxi8O37nBtOzlUiGwmkV6d2rn3O2y4PZMYNKh0oGMAo8MQtni83aU/vD/0YqeR1s2g
 nYNQ==
X-Gm-Message-State: AOJu0YzX8aiF9MKGzhRsz54zCDaco5pzspFZ40TR/4CBSALsoq29M2e5
 GwMHOfcI99luTk1Tu7sT5zAVeyyYcoQ7qoKsN8eaC5ha79uy7bHENkNY
X-Gm-Gg: AR+sD10B8YGVKE+DyIH3uqW+GqzMJJNJHuLp6YenAU/ZnZffWlTIeX9AGZd/2zt0ASf
 USaH1B8hDmyZGxTDvg09QmvIHEL1Ot9n4hL7jdWGPFsZyaYXHVrhhhA+QydWGWGMQYqUkZuMguN
 +k2aS7LbC9DAD7F+0FOvDqdKPhtf5rL3F9Kjpi9UgAmCrOJDo9D8RKL1L45Q86Eem6Yx9c6q+9i
 1E3PMyAbLchLZ4a7krRic0MtYsS8NgYzT4RzZVXBD6+3OeW/01PjBHxsXAiH/NXUGBccGb0zfOu
 HLSaX0FsWaUOr4K5fsFm9CxEM1C1u6cjG2qUz9nCedHdAQOgNaAEMU1ZM1NWx04wP9Z8bkc3CX2
 YeLWz0HCK3DU1s467rCJmS36BtFc9bUs8MQGpStbYSJdLAGLFtqLvSxQKgDrU+JQHl/Y4H0Pe6d
 iRRVQzJmbbG755PndN855NuxjTQTSmU3pNcvXaDWNN1IxyyDQEuIyFGgOuqLRmkA==
X-Received: by 2002:a05:690c:b86:b0:81e:4acb:c0a with SMTP id
 00721157ae682-81fd4d31d4bmr14405067b3.2.1785526058615; 
 Fri, 31 Jul 2026 12:27:38 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fcd164474sm13204967b3.48.2026.07.31.12.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 12:27:38 -0700 (PDT)
Message-ID: <e62e8603-a61d-489c-8df0-2c9ff98a1c02@gmail.com>
Date: Fri, 31 Jul 2026 15:27:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matt Vollrath <tactii@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260731124109.99065-1-tactii@gmail.com>
 <7e9a5228-d257-4adb-b472-b110f60e3618@intel.com>
Content-Language: en-US
In-Reply-To: <7e9a5228-d257-4adb-b472-b110f60e3618@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785526058; x=1786130858; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P/71Eqm6eZkyzzsysSAa7b8sFQPr1CSpNZAPUkARlTM=;
 b=kwb1Co1lX66BSHFbY0gBXszblZgF/FmqBMJzOw6t6FiuiX/MApcpGXrvGWvMxU/1hH
 DYgkzmkdhZ5EDBZ3D4dIDv7cGKO/V8dfLXMWkjFSTCLYvOyUkMQjVcdygHQ/YRmo74Yv
 tjpZyt2/TAN1RMnRaJPEV6O+AimmYegKzceK9etEPS5mcC8EHF3c6XQjOW83e3Ynf0PT
 g+n4Fe+7FgYr9tmDyM4DXDnkQntayMH1rN8Gh/LAeq/SNLry53XAYuMZfe+cBT3wQUCe
 6WnEj+uIpx3SjJU8I6/eqsLucRWbEA59FlexpPBk6+0jVHyJZt9tdnUuVEe4UUZSCS3p
 TjCw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kwb1Co1l
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/3] iavf: defer loading
 netmem_desc
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

On 7/31/26 11:13, Alexander Lobakin wrote:
> From: Matt Vollrath <tactii@gmail.com>
> Date: Fri, 31 Jul 2026 08:41:06 -0400
> 
>> In a few places libeth and the iavf driver inspect which page pool is
>> attached to a netmem_ref. This forces an immediate load of the
>> netmem_desc struct for each buffer in the Rx loop.
>>
>> Defer or eliminate these loads of netmem_desc from the driver fast path
>> by using the page_pool ref in the first cache line of iavf_ring instead.
> 
> I was thinking of this when implementing the current design, but:
> 
> Do you have any data to prove this actually helps performance?

The optimization was profile-driven, but not on an iavf. I was working on
a libeth port of e1000e, because I'm an obsessive optimizer, and this quirk
of the interface fell out. I'm working with a Xeon E3-1240 v3 and I218-V.

With a mirror of the changes in this patch series, on my platform, it's a
net zero overall change in Rx performance. This is not surprising, because
the cold read is just deferred until later. The time saved in
eth_type_trans (where the payload is first read) is instead spent in
skb_gro_receive and pool puts.

The additional thing that does make an improvement, which was omitted from
this series, is prefetching netmem_desc early in the loop. This makes about
22 cycles/packet, 3% difference.

I left it where it is because I don't have hardware to perf this on, and
didn't know if anyone would even be interested in looking at something that
I can't produce data for on the actual hardware. For iavf the prefetch
would be conditional, only when the EOP flag is set, because in this case
netmem_desc will always be needed either for GRO merge or pool put.

I can't guarantee that this will be worth 3% on an iavf platform. In any
case, it'll be a couple weeks before I can work on this again.

> 
>>
>> There are only two paths out of the Rx loop where netmem_desc needs to
>> be consumed:
>> * The "very rare" case of libeth_rx_sync_for_cpu calling
>>    libeth_rx_recycle_slow and indicating that there was no data. This
>>    could be similarly factored out, but not by this series.
>> * GRO merging a frame into an existing aggregate stream. In this case,
>>    the cold load of netmem_desc may overlap the payload prefetch started
>>    by iavf_build_skb, which is now no longer dependent on netmem_desc to
>>    start.

I see now this isn't right, anything going to GRO will end up back in the
pool in the same iteration, and netmem_desc will be loaded. It just
happens later.

> 
> Thanks,
> Olek

