Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C28CC61DA4
	for <intel-wired-lan@archiver.kernel.org>; Sat, 18 Feb 2023 19:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E633D81E40;
	Sat, 18 Feb 2023 19:51:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E633D81E40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676749914;
	bh=ep6TPvCt9d5gqRRbED6ndNM924Ketf6LE2Em3EDmxxc=;
	h=From:Date:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lm5cQzUj5c/fK22kmNIKO0hEfdXbdoEE3ex1mlcjj4pykzkmGsHGJeVzVpbqz0aej
	 T2WGoSaE2iSEUrYxW/DjN67M/aHTeDHRXQY2QHR5WSlErvGGgdqfZ8wsKowR0jMrnZ
	 QqkmvyCwY09VuilOpKzcHyFPD4bmHOKHZThrwo6osI5rsB77vgWeFQu6ayHVShPuXu
	 DW77WCNHjhnkoKJFi6NjNEOq2WqujD9SeZH/JHdhlfzhlbK+4jXxqg7MZ0XZbWvnWz
	 VVhSwHvAEe8MNLTZsp5q66rKFBbgIduf7ub/T6kHsN7+Mdgqh0TfGE/KwO+LTVcy4t
	 V36fpjuKM4qUA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ncc8OmWDroUl; Sat, 18 Feb 2023 19:51:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D388082018;
	Sat, 18 Feb 2023 19:51:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D388082018
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A2B6A1BF575
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Feb 2023 19:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7597A41CA3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Feb 2023 19:51:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7597A41CA3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pAUElS_VufD0 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 18 Feb 2023 19:51:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 246BD41B6E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 246BD41B6E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Feb 2023 19:51:49 +0000 (UTC)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-S0gqxN69NXuYYv3eLifO5w-1; Sat, 18 Feb 2023 14:51:47 -0500
X-MC-Unique: S0gqxN69NXuYYv3eLifO5w-1
Received: by mail-ed1-f72.google.com with SMTP id
 en8-20020a056402528800b004a26cc7f6cbso1508149edb.4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Feb 2023 11:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:references:to
 :content-language:subject:cc:user-agent:mime-version:date:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jx6T743echyIrkeXGF6irLdkrvJq/F4CIpXSF+GVavE=;
 b=OyPRNdHx+GY6x5TAxamw+Aa0blIA0uE8Fs7BihwRAZTq/xak/KKI2Zk1xdypjuf05L
 KEexpmTOokQMhB6ZBy5tNALC99WwUPzx+Yvbl0Z2IupmRLepMCP+LP0sgVFu4zwpJztu
 ZI8UUMmVsCKzOXQz5qHU1e3SYSfH3MvVItcbVCpLD0MbsO7bcwpiQWrRAiP4hklP13H1
 o+f9BhbX79fDMvY1FDgqbjBZWwQAQazH3yJRvP7VUVRA01s0PkN1DdgP/GxMbJq2KAf4
 vPlNzFZzLLWeiq+gqLFyYCbEnNeDszynfE9GjfVwvGYwudwnNJrUA0MvHgH89NqP1cIu
 h0fQ==
X-Gm-Message-State: AO0yUKUBaJ5ZOH1UrZH75ayibNPIWENXYnsxbn4pb5cqG334MHMDBp27
 YNsn70tThbtddcw1M6SXqWm8LimWdqUXMSqL0RZ69mdy2jCn8As8xT4MT8lNpeym3zLF9qO17bg
 zyRrFAyi0cWRu7QlLsJrPIdJRV/X4Fg==
X-Received: by 2002:a17:906:5e42:b0:878:4e5a:18b8 with SMTP id
 b2-20020a1709065e4200b008784e5a18b8mr3925883eju.66.1676749906325; 
 Sat, 18 Feb 2023 11:51:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/3W8hwok4bX5UVtqdvkS2nXqk1Es/q8aSEbc2knNOLLh9wPd7/gg4Y76HMjmnnXmLLc6Knsw==
X-Received: by 2002:a17:906:5e42:b0:878:4e5a:18b8 with SMTP id
 b2-20020a1709065e4200b008784e5a18b8mr3925863eju.66.1676749906043; 
 Sat, 18 Feb 2023 11:51:46 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net.
 [185.107.15.52]) by smtp.gmail.com with ESMTPSA id
 ad24-20020a170907259800b0087bdac06a3bsm3713637ejc.2.2023.02.18.11.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Feb 2023 11:51:45 -0800 (PST)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3bf858ee-d1d1-0ae1-7673-9f9e11e7ca9e@redhat.com>
Date: Sat, 18 Feb 2023 20:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <167656636587.1912541.8039324850101942090.stgit@firesoul>
 <571350f8-3302-abc5-505a-8e5b1f77defe@iogearbox.net>
In-Reply-To: <571350f8-3302-abc5-505a-8e5b1f77defe@iogearbox.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1676749908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jx6T743echyIrkeXGF6irLdkrvJq/F4CIpXSF+GVavE=;
 b=SCB5araboKLlx5p94BugdrY82AahxXcGWerL8mqMagR/ZwTqSdXbioWj+yil564/nDqvhR
 +Bmw/JB2zX+UzALvOWnrP3bo4ORU18bhZ7N2LO4IVpLJEf0VL74vaZ+wkivEuEmxwk1z/0
 SjnNhwbw3QB7r0/HdgdGkFndrlho/LY=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SCB5arab
Subject: Re: [Intel-wired-lan] [PATCH bpf-next V2] igc: enable and fix RX
 hash usage by netstack
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
Cc: pmenzel@molgen.mpg.de, Paolo Abeni <pabeni@redhat.com>,
 martin.lau@kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@google.com>, yoong.siang.song@intel.com,
 brouer@redhat.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


On 17/02/2023 21.59, Daniel Borkmann wrote:
> On 2/16/23 5:52 PM, Jesper Dangaard Brouer wrote:
>> When function igc_rx_hash() was introduced in v4.20 via commit 0507ef8a0372
>> ("igc: Add transmit and receive fastpath and interrupt handlers"), the
>> hardware wasn't configured to provide RSS hash, thus it made sense to not
>> enable net_device NETIF_F_RXHASH feature bit.
>>
>> The NIC hardware was configured to enable RSS hash info in v5.2 via commit
>> 2121c2712f82 ("igc: Add multiple receive queues control supporting"), but
>> forgot to set the NETIF_F_RXHASH feature bit.
>>
>> The original implementation of igc_rx_hash() didn't extract the associated
>> pkt_hash_type, but statically set PKT_HASH_TYPE_L3. The largest portions of
>> this patch are about extracting the RSS Type from the hardware and mapping
>> this to enum pkt_hash_types. This was based on Foxville i225 software user
>> manual rev-1.3.1 and tested on Intel Ethernet Controller I225-LM (rev 03).
>>
>> For UDP it's worth noting that RSS (type) hashing have been disabled both for
>> IPv4 and IPv6 (see IGC_MRQC_RSS_FIELD_IPV4_UDP + IGC_MRQC_RSS_FIELD_IPV6_UDP)
>> because hardware RSS doesn't handle fragmented pkts well when enabled (can
>> cause out-of-order). This results in PKT_HASH_TYPE_L3 for UDP packets, and
>> hash value doesn't include UDP port numbers. Not being PKT_HASH_TYPE_L4, have
>> the effect that netstack will do a software based hash calc calling into
>> flow_dissect, but only when code calls skb_get_hash(), which doesn't
>> necessary happen for local delivery.
>>
>> Fixes: 2121c2712f82 ("igc: Add multiple receive queues control supporting")
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> I presume this should go via net-next, not bpf-next? (Didn't find specific
> dependencies, so moved to patchwork netdev bucket..)

Thanks for letting me/us know.

I posted against bpf-next, because I have patches (for kfunc XDP-hints)
that depend on this patch.  As we are at rc8, netdev maintainers feel
free to simply drop the patch as the patch isn't critical.  I will just
include this patch as part of my kfunc XDP-hints series later.

--Jesper





_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
