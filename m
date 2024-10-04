Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42475CF8552
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Oct 2024 14:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06B726109E;
	Fri,  4 Oct 2024 14:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEkO9okTiGCC; Fri,  4 Oct 2024 14:14:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2822761091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1728051287;
	bh=9sNAz/5CFb2TTqh0qTWpjuN4PPCKAxzyJUBED4aMgXg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SE2hcLfpvr0NascRFlcRcUYfr5MYu3skoZCTrZCFe4Ky369sXMAZUMLTAnDeixo7s
	 7DktRQPHvOVhlIdq4lD1B8/+lIknlO/r9DHP2sGWkhDp8DxFUHPy6BVD6dBDhOldAf
	 zpqrIxHmDBgazb20oNDWauAHumohKMw5Orft7CbL1eIbTk6/6Cotp6yw27mghVA4+U
	 0Vf1omvGn2fTxZ+2Fvy0pECxzTUmC+EDd6ubK1y2Ci4d4VuZFHmaF2CLUpKqmK0/Eg
	 6/IrVNmLW9pjWIBSjuB88fAxtQ3nq/6EG9ceNzI9oxkPkzZKrIZfgIpO/xVDMVtJi/
	 P/StD2eZ579Ig==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2822761091;
	Fri,  4 Oct 2024 14:14:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 8948D1BF82C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Oct 2024 14:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77C1A820A3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Oct 2024 14:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mj7MqDswekm9 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Oct 2024 14:14:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=hawk@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 658CF8209E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 658CF8209E
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 658CF8209E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Oct 2024 14:14:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EEF0B5C5C25;
 Fri,  4 Oct 2024 14:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77342C4CEC6;
 Fri,  4 Oct 2024 14:14:37 +0000 (UTC)
Message-ID: <75fb1dd3-fe14-426c-bc59-9a582c4b0e8d@kernel.org>
Date: Fri, 4 Oct 2024 16:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Arthur Fabre <afabre@cloudflare.com>, Daniel Xu <dxu@dxuuu.xyz>,
 Stanislav Fomichev <stfomichev@gmail.com>
References: <871q11s91e.fsf@toke.dk> <ZvqQOpqnK9hBmXNn@lore-desk>
 <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby> <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk> <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk> <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby> <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
 <D4N2N1YKKI54.1WAGONIYZH0Y4@bobby>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <D4N2N1YKKI54.1WAGONIYZH0Y4@bobby>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1728051282;
 bh=a0FW3Un9oocR9lC9J0t0H1CeCWGgStzo+JYKJIbrt5g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cpcoFps6/hDg0PoAmKcH01HCVor4KZ63LJwLDfaewkNIY89u6Gw8LQ9s9hbZ3c8vs
 GOPXzoUGqf4iTEZ1Cnw7dhnfG+HA0xqqZ73RYE2Vw6nJiOSX3d0FmHbSBwMhjX796F
 Mf/PdG7lc2pEJ8ebH3CAf2vx2yss1aIUpK08x0vcwdXNgwrmt4GHwu2AJqa3OJCo9D
 qnmS1ycP3OgbEyaYyCIMZ7twcfA7KHMgOJ+hPFuwXbgCCuUqOLqc5w+JqIvG9C9Eri
 qlc/8eJVjt/7ftVZnbeiFGhdELG4FqWpHJFg98w+aw+aePBYE4EJkHJsI34HvgAQLW
 kR6j16Vo+yOyA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cpcoFps6
Subject: Re: [Intel-wired-lan] [RFC bpf-next 0/4] Add XDP rx hw hints
 support performing XDP_REDIRECT
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
Cc: mst@redhat.com, jasowang@redhat.com, ast@kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, Jakub Sitnicki <jakub@cloudflare.com>,
 daniel@iogearbox.net, kernel-team <kernel-team@cloudflare.com>,
 przemyslaw.kitszel@intel.com, john.fastabend@gmail.com, sdf@fomichev.me,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 Lorenzo Bianconi <lorenzo@kernel.org>, Yan Zhai <yan@cloudflare.com>,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 tariqt@nvidia.com, Alexander Lobakin <aleksander.lobakin@intel.com>,
 mcoquelin.stm32@gmail.com, bpf@vger.kernel.org, saeedm@nvidia.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 04/10/2024 15.55, Arthur Fabre wrote:
> On Fri Oct 4, 2024 at 12:38 PM CEST, Jesper Dangaard Brouer wrote:
>> [...]
>>>>> There are two different use-cases for the metadata:
>>>>>
>>>>> * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
>>>>>     few well known fields, and only XDP can access them to set them as
>>>>>     metadata, so storing them in a struct somewhere could make sense.
>>>>>
>>>>> * Arbitrary metadata used by services. Eg a TC filter could set a field
>>>>>     describing which service a packet is for, and that could be reused for
>>>>>     iptables, routing, socket dispatch...
>>>>>     Similarly we could set a "packet_id" field that uniquely identifies a
>>>>>     packet so we can trace it throughout the network stack (through
>>>>>     clones, encap, decap, userspace services...).
>>>>>     The skb->mark, but with more room, and better support for sharing it.
>>>>>
>>>>> We can only know the layout ahead of time for the first one. And they're
>>>>> similar enough in their requirements (need to be stored somewhere in the
>>>>> SKB, have a way of retrieving each one individually, that it seems to
>>>>> make sense to use a common API).
>>>>
>>>> Why not have the following layout then?
>>>>
>>>> +---------------+-------------------+----------------------------------------+------+
>>>> | more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
>>>> +---------------+-------------------+----------------------------------------+------+
>>>>                   ^                                                            ^
>>>>               data_meta                                                      data
>>>>
>>>> You obviously still have a problem of communicating the layout if you
>>>> have some redirects in between, but you, in theory still have this
>>>> problem with user-defined metadata anyway (unless I'm missing
>>>> something).
>>>>
>>
>> Hmm, I think you are missing something... As far as I'm concerned we are
>> discussing placing the KV data after the xdp_frame, and not in the XDP
>> data_meta area (as your drawing suggests).  The xdp_frame is stored at
>> the very top of the headroom.  Lorenzo's patchset is extending struct
>> xdp_frame and now we are discussing to we can make a more flexible API
>> for extending this. I understand that Toke confirmed this here [3].  Let
>> me know if I missed something :-)
>>
>>    [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
>>
>> As part of designing this flexible API, we/Toke are trying hard not to
>> tie this to a specific data area.  This is a good API design, keeping it
>> flexible enough that we can move things around should the need arise.
> 
> +1. And if we have an API for doing this for user-defined metadata, it
> seems like we might as well use it for hardware metadata too.
> 
> With something roughly like:
> 
>      *val get(id)
> 
>      set(id, *val)
> 
> with pre-defined ids for hardware metadata, consumers don't need to know
> the layout, or where / how the data is stored.
> 
> Under the hood we can implement it however we want, and change it in the
> future.
> 
> I was initially thinking we could store hardware metadata the same way
> as user defined metadata, but Toke and Lorenzo seem to prefer storing it
> in a fixed struct.

If the API hide the actual location then we can always move things
around, later.  If your popcnt approach is fast enough, then IMO we
don't need a fixed struct for hardware metadata.

--Jesper
