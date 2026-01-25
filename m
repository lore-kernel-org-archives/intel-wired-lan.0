Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBBFE63CBF
	for <intel-wired-lan@archiver.kernel.org>; Sun, 25 Jan 2026 19:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B33D60B09;
	Sun, 25 Jan 2026 19:15:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZJhDjKp4DS1; Sun, 25 Jan 2026 19:15:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAA8960AC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769368517;
	bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
	h=To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FHdTimpTC/xOB2kRFbBQ8xAnkviWDwTpLlmq+bnyeBPhss57KiAT3D8StLQ4XvaHQ
	 jqiEOJjGq2hntip9yib+22Fe11Pe6UYKKyC6WNxckp+OHbmMQDKwLJ5Ju0Rz6roju0
	 i6e7KUWatVm1s7vJRIcVxGzQY0nWFkEIwsR2TCfG0T8SKz2ODGmfSADrGTc5KFOdEQ
	 CnstF8AIeCLqQx1np45sbtdDFkR4Zy9S+eLWt/IvbpH1wfoeP3fBMLTkFNAwtw7K8p
	 axe3Ji0TeZHWiV7vBiXEAl8iw77enVOUx3lTEySXhBDXrGJivB4Q6bby831HHKlMeE
	 By8R/krWkTqPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAA8960AC7;
	Sun, 25 Jan 2026 19:15:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4267C35C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Jan 2026 19:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24CD0406C5
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Jan 2026 19:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bsVm5RmSxhMl for <intel-wired-lan@lists.osuosl.org>;
 Sun, 25 Jan 2026 19:15:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=jakub@cloudflare.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 279DE406BB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 279DE406BB
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 279DE406BB
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Jan 2026 19:15:14 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b87677a8abeso586736966b.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Jan 2026 11:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769368513; x=1769973313;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
 b=nZYhXLsJHQsKuq1COae1iKSEkFgtyHbNBTTpOxVqp6tnv5lxTcd9hWroeTI97kphb2
 kD6h4BpLuxQmjc7J1Fw0DHKrxbvr8bGqEzx6Aq/cDPXIq/G9MVuclFZaXpv88MVDal7m
 6AkHxwaw088sTrbpJjseHE8lxiHozEljyG8y6cwhDxjNKUSd3Q+HQ1//jveSwhBpYCIe
 o77iipgaQGDOyYDWjHtiMT8bWPkXF53DtKL4VRzPYQ4MUQ876mZ8Zza7dPaqkTt79NJW
 yZEuBzzP/JBaFLRmmrkTjT799toeOie5yrdNBD7M6rEb6ow4tf5vCBvYKb4w4oCsK683
 /Yjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPQ5/x5C61P7r6VoyeNbxT8rEuZtDYLSFXqPofeY/RmbG7OsxlDH0E1fvXYzbeCPsrqG+EYmndOCRZM5Gf/U0=@lists.osuosl.org
X-Gm-Message-State: AOJu0Ywdocbts61FDy6mEbvy/Ax7gxPvBuRXegvdegYwX6UbrUW4kkKp
 fC6JoUp2+pRb48Lb+BVmh2fJY8AZCZvOygnKRnL2TqDeUJU3imeWLbPZQzWpO0R0KxA=
X-Gm-Gg: AZuq6aJKMZplbphglaH5vyxA//3lqJK+vSntg1BRiexRRzWUB38PVM/NTUDRkRIFhvW
 Obtgjo5hf77OcyLpHjbfLufly51Mq1f/0BjE0bE7JZHJcOW/3TDDaD1HL4DvfIKRzlZ03mcbS+D
 tFbCa3xbC8XwdJXgD3OPRnsYVfk8MkYhVHk9Vmg5HfcTNVFMh40iBK0kDSvEYR3I6JaUOM6Eqb8
 xFx2mNf0nK0f3fW2pJkjOz0J2T0OCFGqh6tFwMLPdso2sqzcIJZHrIRJN58ROthu+iq8Sq+4X18
 kO5PLtaGItxJ46RvzXZofVpMDuz8lSiGWgFWxW61Wq2YWS1EHo2otdEEZqmgk3ViLGUKKTQbD9P
 q2zBkr17DI/9H5u8gLcVURxBCVQNdEmbYquLT4XuRlCITnbXtbHC+VIyJATymYxN53NopiXcQx3
 1m6js=
X-Received: by 2002:a17:907:96a9:b0:b88:60d2:11b8 with SMTP id
 a640c23a62f3a-b8d0a83048dmr155054466b.4.1769368512869; 
 Sun, 25 Jan 2026 11:15:12 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b75d669sm494078966b.51.2026.01.25.11.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:15:12 -0800 (PST)
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,  Tariq Toukan
 <tariqt@nvidia.com>,  Mark Bloch <mbloch@nvidia.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
 intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
 kernel-team@cloudflare.com,  Jakub Kicinski <kuba@kernel.org>,  Amery
 Hung <ameryhung@gmail.com>
In-Reply-To: <ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev> (Martin KaFai
 Lau's message of "Thu, 22 Jan 2026 12:21:21 -0800")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org> <87bjixwv41.fsf@cloudflare.com>
 <ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev>
Date: Sun, 25 Jan 2026 20:15:11 +0100
Message-ID: <878qdltsg0.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1769368513; x=1769973313;
 darn=lists.osuosl.org; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
 b=GThwZ2yFtc04yxgzoVc/nbFEHHND2VDNWHNcT3WBG52hsBzOJ8mJ2UFNMLciziIHG5
 fHLlAdL9OswDlmgHNkn8W6KIXRqDzAxlamM0gBA5RFYoLyOFd0qj8RE7VyPBMIXFRc8H
 3OBXP1qT04NUz6QRq1YGiUON1U5d478Mazbk/IVNAeVaeePANre1QIUqvjGq6yJXnUtR
 qXVUSTlrsp3qE3k8S4BZrEei0dGjZtW3PMoSKaYoGUHDWbjwzU+RPp3OJ74UNNiEUR3m
 3u2wAAMTkNvW+Ga6bTF3rSlpzXjPMee5T5ybzCfjFYn1BTYMIoO4xLV+1lBEisjb6YwW
 Vg+A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=GThwZ2yF
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
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
From: Jakub Sitnicki via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Jakub Sitnicki <jakub@cloudflare.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 22, 2026 at 12:21 PM -08, Martin KaFai Lau wrote:
> On 1/13/26 4:33 AM, Jakub Sitnicki wrote:
>> Good point. I'm hoping we don't have to allocate from
>> skb_metadata_set(), which does sound prohibitively expensive. Instead
>> we'd allocate the extension together with the skb if we know upfront
>> that metadata will be used.
>
> [ Sorry for being late. Have been catching up after holidays. ]
>
> For the sk local storage (which was mentioned in other replies as making skb
> metadata to look more like sk local storage), there is a plan (Amery has been
> looking into it) to allocate the storage together with sk for performance
> reason. This means allocating a larger 'struct sock'. The extra space will be at
> the front of sk instead of the end of sk because of how the 'struct sock' is
> embedded in tcp_sock/udp_sock/... If skb is going in the same direction, it
> should be useful to have a similar scheme on: upfront allocation and then shared
> by multiple BPF progs.
>
> The current thinking is to built upon the existing bpf_sk_local_storage usage. A
> boot param decides how much BPF space should be allocated for 'struct
> sock'. When a bpf_sk_storage_map is created (with a new use_reserve flag), the
> space will be allocated permanently from the head space of every sk for this
> map. The read (from a BPF prog) will be at one stable offset before a sk. If
> there is no more head space left, the map creation will fail. User can decide if
> it wants to retry without the 'use_reserve' flag.

Thanks for sharing the plans.

We will definitely be looking into ways of eliminating allocations in
the long run. With one allocation for skb_ext, one for
bpf_local_storage, and one for the actual map, it seems unlikely we will
be able to attach metadata this way to every packet. Which is something
we wanted for our "label packet once, use label everywhere" use case.

I'm not sure how much we can squeeze in together with the sk_buff.
Hopefully at least skb_ext plus a pointer to bpf_local_storage.

I'm also hoping we can allocate memory for bpf_local_storage together
with the backing space for the map, which update triggers the skb
extension activation.

Finally, bpf_local_storage itself has a pretty generous cache which
blows it up. Maybe the cache could be a flexible array, which could be
smaller for skb local storage.

All just ideas ATM. Initial RFC won't have any of these optimizations.
