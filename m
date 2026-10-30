Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443B606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Pro5UB2O;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbxDs/H0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 271178108A;
	Fri, 30 Oct 2026 19:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QbgPYeMDgHFs; Fri, 30 Oct 2026 19:00:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53FA4810AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793386859;
	b=BKSCt8LMiMqkVvoVB7NeP+E59RgC1d172Bnh6yLGcpl1GTZSCsdeIGSeXa8n+w+SuQPO
	 a1JzoNtTilLUnyH5r3qJZHA9FkMzWmud/8cuQ9SuTfQMhxoDZelSqAlMbrCMb0lKlmO/U
	 FHtqPXhPAm28R21Yo1ssrhZtJOVI3TO6cCDRhBQB8DqrlWhk01J88U1JlIuyJDr3Qt8iG
	 W7mBzk6HVcjxeMj3vyhJF73yEE3iam6CmEIBj4Xqq8/A73bBL6XfwO5P4b+CbeI1IAsvv
	 Lq0Xw3tPwsBtKvaiRyDtWCVxzqADMBOp5PLdDZ7SpZw7lJBXiwnkPB4EEYT3K6C5SlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793386859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
	b=R/h7OncszPvYAeE6NNu35Z7cIsK5IblwBXoJTTm+XpHRV7YOzgHiZR8hq2TEs9lXFTtN
	 oyGSwRCuuUtZ/x4jc01udoHEYHQoHYnbRP7mpSyIpkqwWHk3nfkET00SD+NAo05Ffxp9T
	 pKSOgdu8zmuENpFVMTcHVetxNLrU9ztOHPk+JPUUCT5A8tJmMfBWcK88xtAtFJVEwHZxE
	 lvKjO4XKVLAw83y5mLpatoRzWCobdXEKmDQqs9tlSRqKhYhiCGlUmQU2+TCj6sBJd3Upi
	 sj5mhcEvCyP8PfVrUJUh5CEsVdqgCmVMSW/ArBiboOwP3O+NegthkSoDiqHKiDU370Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793386859;
	bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pro5UB2OqtER0Fc9xb8LqnHpsxUehDyo67eC1oasHEc+V/4xi6mDOARUAc3rKQH1p
	 dRx5VL1uEJ97Q1J35VUn/bAN82E9XMxE8TBFUVrOt909vk2nNfYzKPOuTFYgpYeaUQ
	 JQd7umCx0Nz+ULTkyHxlekn/e/BMhkJkLlsxKL0TIeJh+maHv4Y9VOKQCCgDXUUyO4
	 kHRxJqnZre27PSnDjdz9Spn9rcwLt0ovncRutRF91T2jgfcG3i5M5pdcCElEFG9HcE
	 XtDPYBBzEr1idQ8orGv1PA4yvpcloVK5Fc7drxmwJELrrHi9KXDkWMigb1ozYxKyef
	 BcnvD0xCwNw7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53FA4810AC;
	Fri, 30 Oct 2026 19:00:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BBE154BC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 19:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD81640574
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 19:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8yHa1Q9h4RJE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 19:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BE80140083
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793386857;
 b=KMUgts20//P71a7eb5W6RD6HJH2QjfN7ZAwAmLidOBloFJ917Ia0fpl8X4OryTx/kHOI
 eXH6ZY1Z+wc2d1mOH66NEAdFiUvXrNEZtPl6E1EOe/RwgEUVAPwbNUi+GkeQ8e3F01Y5L
 GIlw6P4JRIOomWQBaKxAy8EI0hDAhNuA8mkl4Jd20Dwiqqtrqq8XJ01AmKaXlupgjrJ1s
 VoZ2cVwDChsPdDhn0dkp2lkCmlw0FBjAadfgGwqU0CxgY61Kxv5naO+DKVh/Ywnwg5M0j
 3qF4j4JuvatzaJw5VN29N7x0UhWqhXk5sDK91XtQyvACPr1oU9nsKZYKIUpssAShw1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793386857;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
 b=VvNeLGB6FvTa1MfCHtcVncCKEIBArumrEOenLAYZ+LIBa220knjT6r0XsBmEddTXnq2A
 57yPZOIv+5r6m71/L2r5C2qJvXspdb8qkN2buGEXNRgjVn1k43xbPuihKhDHMrjm9Fyde
 Y6q9DYuWuH6Mti4MYaroiHohVavYsoDGlmdJSNy0I5cHMlerrG06sucOc29Vzm4ISOs8I
 vV4Npi2dTdV9aIFWeFNcIutH5ZEXKN9j9O0ZgpOuW7FdzxsqRX56Uk7ENEzLeBLTTRHFs
 0EB+zs+AJIr1LcS5sMHkVu8hvadj840JLiVTgCDPyWmzDlvbVXeSSARiSRVjaRi2biw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="gbxDs/H0"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=gbxDs/H0
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE80140083
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 19:00:56 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6dd4f3f696aso503631eaf.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793386855; x=1793991655; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
 b=gbxDs/H042j9j79h+h3lkrhuBmQvkuhGG3F4NfTxdUcLGn4OMWWuXwcjMeQ5fKvtJo
 gN8pu1GtYVUB5SESzafoljK0HWRoGbjoZyAGLNoS/wHrA0u5lIyshuLEIYDf7cqgE3V8
 9Xr3YCxFqLtGR8/jvxPpWyDY9TDlPTjF/Xqa89iXZmobRVgIIc/qAtMgd27EqbKOy62P
 +Q/kE9DuTLPvbEOIgUXqvpBjLSipOwVmJcutqZSQdP0Ve6M9klNCK2xaODcRj/JLjKO/
 Z0Do1EtTgTMnCGWIUCxIeruaqfudP+qYiplPjiQfckdc40OWD/rbmUTu/YJhvpdnHDD9
 kUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386855; x=1793991655;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sYbpWh7nY0Ldr96oHy9KeCWVuTXwP2borKAL2I9qoDE=;
 b=y8CLiDo1yB1ZKGDfZ0ixRJuso0zfejHAirsmdltO/8St2ufetNJpYHc/wiuSm3+3Ne
 P/LrHzFOEG3yz6nZ1i7GgOXktTy4Rab7VJATRPi/ue56L9sWwjCTVLg1MUK5YWuTSHkr
 EJVpfnMfWh1OAo5FAfxi0KTuuiChmlhSJH8wNqlcNYOn8iAcPmjoDxWiqggXFGvWES0E
 6BlcVN6kadG0QX2baJQLgIOm1fWmkEfs3uzdDzip8RDGDafTr0i8+Wl46oFUET2ckSCJ
 AsZr33uEo4sh+JFL+lLUuxLhQkNWuBWdyFmNFZudUfEpDwtF0YGss9kmGce8D/QAwdYj
 nULA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2ORe9qJMa11zu3H8noyFnHFbKIA8POx4Z+TQXxF84ThLrAd3z+MyAu8gd8DJ7XsrMGie3xeC1pbchUeGIBJw=@lists.osuosl.org
X-Gm-Message-State: AFq9FYIVD7NxwDySe1ouvzpoeF/Mha/8DhL45NWNVusQlV3p1DFgUcp/
 M7AiouMalR+NHzXM4TzOseCTD1llWtYwuxquy2y8zjPgqClUhXyxIyu0
X-Gm-Gg: AYBFou1XyBfRYwJOds3TyYcyq0PiVvc75VdB+LeG4hMqHYRATfbQfxTMA8kNKqUZVf8
 obo3jeolCCGC0Ew0j5EKqoA2q7TZRcGamNeCAFZwq8jwQYWppsc675ddmrJ6OpnizX115Ehh8Dn
 v03HlFI1JhixAaqAShjBePqG1duE8NTiIiVlC54djoMVIx+vdW4JSy3uB97NxESTFGfR/MT9Ltc
 rtc6F4cFZbGuESkbpZqN8qR6OqL1NbH025hv1QpytMi9p66A1VD7qXO6AxcNbgsG1s1R+g+GBN/
 ShCRXYkWYhlih3yVY/fFK/HCcc5smPWLKdcvShHJx1RMSDdY24drTW3peKioVWB27ghE8BCUPjE
 myqGb75iDZj6d6975r5yk6wabdHTeR5p3pi1q/1SrSusZ5yuA6hGNhDMUDgtwnJQoi3QpJ88v1l
 uZciGVvwedaPyzN6xMZ/U+4PzpEsaHRkgjKef2n8wdA94JufjIoPTa6ivYIXBqm2G0NmP3OzMEy
 UAajJ8lumkAccsmWCBij48GWcZriZn3ScOvEep6L7R7OfLYp8yNhXfrMqcMRYxBbtnFx+XCgu1V
 VGHJlD0yn6FZkkmpFstYQ9PrM2ZWumfzOhSWEuhBNitVYnVn+3TPAJoYE3a3m0324uoE17GVYaX
 43N1pDrsPekJBMHqMGA==
X-Received: by 2002:a05:6820:8582:10b0:6d7:3933:461d with SMTP id
 006d021491bc7-714f29a29a7mr1457363eaf.51.1793386855141; 
 Fri, 30 Oct 2026 12:00:55 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316:4bf6:e4d9:c6ae:de64?
 ([2600:6c5c:6b00:316:4bf6:e4d9:c6ae:de64])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f3190fe6sm2430468eaf.14.2026.10.30.12.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 12:00:54 -0700 (PDT)
Message-ID: <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
Date: Fri, 30 Oct 2026 15:00:51 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matt Vollrath <tactii@gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Alexander H Duyck <alexander.duyck@gmail.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andre Brait <andrebrait@gmail.com>,
 stable@vger.kernel.org
References: <20261028170239.28606-1-tactii@gmail.com>
 <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 12:47, Alexander H Duyck wrote:
> On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
>> When an skb arrives at the driver and the header length exceeds the u8
>> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
>> are sent to the card. If TSO is enabled, some header lengths will cause
>> the card to hang.
>>
>> This was reproduced on an I218-V with an unprivileged Python script.
> 
> Can you elaborate on what the script did to trigger this? I am
> wondering if it can even get there with a valid frame supported by the
> interface since most of these e1000e parts don't support tunnels and
> such.

I will send you the script OOB. To be clear, this is a security fix,
not a correctness fix for rarely used paths. The rules say I have to
post the fix publicly because an LLM found it in a
function-by-function scan.

> Also did it have separate cases for the CSUM vs the GSO? I would
> suspect this is more a CSUM issue than a GSO issue.

I have only reproduced hardware hang when TSO is enabled on the nic.
Otherwise it likely just mangles the packet, but I have not confirmed
that.

>> Fix it by disabling GSO and checksum offload when the header length (and
>> checksum offset) would exceed the field widths. Compensate for a
>> software-inserted VLAN tag.
>>
>> Because of a quirk in the ordering of ndo_features_check, the skb's
>> transport_header field may be stale. If the skb carries
>> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
>> no reliable interface, so don't offload it.
>>
>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> 
> I am pretty sure this Fixes tag is bogus. This is the introduction of
> the e1000e driver which was in 2007. The ndo_features_check didn't
> exist until 2014 sometime after that if I am not mistaken.

My understanding is the Fixes tag should point at the commit where the
bug was introduced. A comment on the Cc: stable tag indicates how far
back the fix can backport. I didn't bother because this patch should
apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.

> Much of the complexity that enabled frames to build up massive headers
> wasn't until much later when the network tunnels and OVS started being
> added.

The repro script should work back to 4.10.

>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 6f85dab5c55c5..370776657d100 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *netdev,
>>   	return 1;
>>   }
>>   
>> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
>> +					      struct net_device *netdev,
>> +					      netdev_features_t features)
>> +{
>> +	/* Do not offload packets whose header lengths exceed the u8 fields
>> +	 * in the descriptor.
>> +	 */
>> +	unsigned int hdr_len = 0;
>> +
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>> +		const struct tcphdr *th = (const void *)skb_checksum_start(skb);
>> +
>> +		hdr_len = skb_checksum_start_offset(skb);
>> +		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
>> +			hdr_len += __tcp_hdrlen(th);
>> +		else
>> +			hdr_len += skb->csum_offset;
>> +	} else if (skb_is_gso(skb)) {
>> +		/* Work around untrustworthy header offsets in this case. */
>> +		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>> +	}
> 
> Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
> the frame must not be TCP/UDP GSO since for those normally the checksum
> and offsets should be populated. Have you identified cases where we are
> seeing TCP/UDP GSO w/o the checksum being set up?

It looks like this particular case is never reached by normal traffic.
It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
hostile or niche setup.

When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields are
used for csum instead, or left zeroed.

The transport_header field is unreliable when a packet is being routed,
so you would need to parse the packet from the top to find where the
transport header ends.

Rather than walk all the headers for hdr_len, it seemed prudent to just
categorically deny offload for these exceptional cases. I could be
convinced otherwise.

>  From what I can tell it looks like the only valid cases for it not to
> be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
> FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
> anyway.

FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e

>> +
>> +	if (skb_vlan_tag_present(skb) &&
>> +	    !vlan_hw_offload_capable(features, skb->vlan_proto))
>> +		hdr_len += VLAN_HLEN;
>> +
>> +	if (hdr_len > U8_MAX)
>> +		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>> +
>> +	return features;
>> +}
>> +
>>   static const struct net_device_ops e1000e_netdev_ops = {
>>   	.ndo_open		= e1000e_open,
>>   	.ndo_stop		= e1000e_close,
>> @@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
>>   #endif
>>   	.ndo_set_features	= e1000_set_features,
>>   	.ndo_fix_features	= e1000_fix_features,
>> -	.ndo_features_check	= passthru_features_check,
>> +	.ndo_features_check	= e1000_features_check,
>>   	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
>>   	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
>>   };
>>
>> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5

