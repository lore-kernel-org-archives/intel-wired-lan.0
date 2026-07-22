Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE19C4453A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 18:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69DE780DF9;
	Wed, 22 Jul 2026 18:00:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDplEikL9KXo; Wed, 22 Jul 2026 18:00:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A450080DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784743238;
	bh=HnNlfSj3fIGtu585qe6eLWjGneo6zvxtz8A2jHYq8n0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GaDfh75H9HPV1vEgywJ82Llvl0gWOp0ivMPRRWJZ2UEj8oThAvNDWVEV1OGvF4TUs
	 0qfPt/dUBfIEyvimxQnB3/GPhwjqGYvWU3tMw5UOEugf6WsMxXYtFzRHvoFwcH790D
	 XzCtsrHRyWMQ66+A2phRi42CxZOKow8ZyMQpNdqRjnqtWypiqz/KeLJnQzxcNCx4tx
	 8ioEPNRWT6rX7RaHMuv6uWpk+9HRB6zpucu4jGDF+UtJ2PrHJz9wYFCxq/krLnRQL5
	 EVE2iCrGmyf+WhEu4iMaVQRRp8tFd0izC8ZTg+DfHD3cDS6DPMTd1BvhZ1m67B5JR0
	 KjgbB9EzadFwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A450080DE8;
	Wed, 22 Jul 2026 18:00:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 09709313
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 18:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF2F080DD0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 18:00:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ng-m0sQyhOJz for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 18:00:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::1;
 helo=mail-pz2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 160AF80DDC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 160AF80DDC
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 160AF80DDC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 18:00:35 +0000 (UTC)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-c9fcd903839so6167861a12.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 11:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784743235; x=1785348035;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HnNlfSj3fIGtu585qe6eLWjGneo6zvxtz8A2jHYq8n0=;
 b=j6gEzwON4puP8cmiJyCijKxWVu8KWX+IW9Dg5RJC6Y1Vczlmu+ad0CfbwCIvVxwHRN
 gy0A7jJ5NCxyvChDIpM9ZGEzUFx81SlBK9Ae3twaupltY+/L/7N0GSouTq/iMd8vwMxf
 zEk+378S+3ZKaVXAISzHVBJtHcvG7Bq5RzehbnTCtJQE2QWp/wRoMS/mjvJrZcsocJ/s
 ElVsbxoRuSeZavpeKFy5kGD+O7HRV1/bJ5E1tc4pfwchI9R8vwONRkDeK4iHqo32MxjT
 5COqsPSDHKSgUHIqcRZ9Tx8MAKpHMO+hDXr7zg4kJBHEX1qKJFE5BkTM7ehtTzcF5PKI
 7pnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWY1rMsxJFeWMDX/GfAeqrwH4xgloVK/qw8HgZG/qFPBvSK09qM3AnHZoftqBQ1g4yaBv9kzJPlvUVoTiSAzg=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxOf8IzsRmUHYCrifCUNOcwmcnAN/+pd6PuQHSS6ZvJl+08q5DB
 mztixHJrzPJEOQA3usgbDbHWXhuMB4RxZB3mQtK+TXWrjcvt7tGJ7d1X
X-Gm-Gg: AR+sD12cVnUxy7bnwZlE6fRBXw70RprgFzqbUulBu0wAErK1dCM75mwaQqoB+7NvkVw
 dJIG73OWQTSVaKfTdYze6uGygjxy6+UkVLw0h397d4S7Srn+r6lUCEUH8mqkZTLQXjVgBuStWah
 6UcQz7evq7t8Rd+bTiFdzt1BWIIvKHmof+TeGHNDFpqoPxPRPy+vCaVMMUHBC3oA2lISDtyvSHQ
 v76VqqCnhhqtAlJu81DNuLx+nHfdDvqj2YVL/8WZjaSANxn2dfuA3ktLrVQIpoNNSHvL8+sRCGW
 is+73GaMHe9lIrEZY5BKByEnTxOAKSgqQMLA3oaZCak+QE/yFDjk7qFyZuMhbIRHv5aYp04nNBU
 iNFv0tBBupK/PxQ56t4SKROInIQthavckJzUpRST8/4ZxeXf3Gp93XSPJhCPkU4R8K5AyYQ==
X-Received: by 2002:aa7:8744:0:b0:84e:89a:b8ed with SMTP id
 d2e1a72fcca58-84e089ab9d8mr6443533b3a.70.1784743234973; 
 Wed, 22 Jul 2026 11:00:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e17266107sm1750442b3a.17.2026.07.22.11.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:00:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:00:07 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <amEEEohxmC8hkBvY@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
 <20260721082728.74142e6c@kernel.org>
 <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
 <20260721183256.6f49d6e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721183256.6f49d6e1@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784743235; x=1785348035; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HnNlfSj3fIGtu585qe6eLWjGneo6zvxtz8A2jHYq8n0=;
 b=FmEVVO6uV4vWDU9sRhhvZuxu5DMH/T4q17QPnvEo1odu/R/EXE+oueFdWswgtZO4BF
 rfHao9xz+/jcj8XOGE0+om7ut1eWKVZ4naGenuOizGo3mBqzPgR38S49Z6SbWiz5+cNG
 MPQHbbFkbtu0QXqq+WSOKHoiZvzgXsdbc6cf9nfKixWmo9mhbyglnlN891M3sFZisHOA
 gQgxWH/PivMsuRK6fpKNMloKuXv274ZfCCbuX3uYf3MduFUQubinpOGCa+WA0ggao9ht
 v08dIKPni7mdhVyYx6ILoX3lhE43u1tpD+uRd9l+nS+a615DNaWCbtOSa3A/O+mWwIV8
 s7Rw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FmEVVO6u
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v5 8/8] selftests: net: add
 test for XDP_PASS skb checksum invalidation
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

On 07/21, Jakub Kicinski wrote:
> On Tue, 21 Jul 2026 16:03:37 -0700 Stanislav Fomichev wrote:
> > > > For unnecessary, I think the safe expectation is that the bpf program
> > > > will update the value of the checksum in the packet if it touches the data?  
> > > 
> > > Documenting as expected behavior which no driver currently follows 
> > > is a bit silly. I thought the ask was to sketch out the plan of
> > > explicitly updating/invalidating the checksum even if we don't
> > > implement it today?  
> > 
> > This is about current drivers that only report UNNECESSARY with xdp: the xdp
> > prog has to maintain in-packet checksum if it changes the payload. I think
> > it's a fair assumption?
> 
> What about decap? If we decap the header that device validated 
> as UNNECESSARY there's no possibility of maintaining the checksum
> (by which IIUC you mean correcting it in along the payload changes).
> 
> I think we'd need some API to "decrement the csum level" ?
> Or some heuristic in the drivers to decrement if the head moved
> by at least len(IP+UDP) into the packet ?

True :-/ I guess one more case to document?

> > In terms of documentation, here is what I have on my side, lmk if that makes
> > sense, roughly:
> > 
> > - TODAY
> >   - some drivers (correctly) disable reporting COMPLETE when XDP is attached
> >     - the xdp program has to modify the packet checksum value if it
> >       changes the payload
> >   - some drivers (incorrectly?) report COMPLETE for xdp-to-skb path -> unsafe,
> >     needs to be fixed
> >     - updating the payload doesn't update skb->csum, so the safest
> >       option right now is to only do UNNECESSARY with xdp for all drivers
> 
> Yes, that sounds fair.
> 
> >   - the hw test needs to make sure that the csum is either
> >     NONE or UNNECESSARY, and will error out on COMPLETE
> 
> Driver can report COMPLETE to XDP, just not to the stack.
> I think we can use a tracepoint (bpftrace) or attach in TCP
> to check the skb state?

No strong opinion on this, it seems easier to report the same to both
xdp and bpf (at least initially)
