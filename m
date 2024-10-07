Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE10CFB453
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Oct 2024 18:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A6FA607CB;
	Mon,  7 Oct 2024 18:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDZvbASVNyra; Mon,  7 Oct 2024 18:48:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82BA2605E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1728326917;
	bh=DxIo6SBDZQXc37oWyxERlpu6l1Wa+ULpd6grGxBigoc=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ym7hJB0zgAn+Hq1XSaWWE6ipj6o6DrYoJCO66X3Tuw499Ya7Avg9WSdGpMY7XS7Zs
	 6YmSwUHjYeFX5wlEBMzEBXC/cUpYT3bas6l6j7tsbZ56p3usy/YeivR2I/OpRDTsDT
	 41Jr21bnWV6Tph41jW9hM8QNOVP4zfKXgTsEDs4DL4Kn8a4N2jNO6O62tpCGmc6gkR
	 P/+FPkpkrDpd/YoX6kS/HZnjW5kG4izREHosTzGkXrabVtYcEol1bXlpnYIHLdFC7i
	 U8PYnCpuD8qYW3QqKR5joWJnZaMjD9tdi6bO2o9Jo7JM3ujx02CwHrv3YqMhRltWcm
	 nRi6kx4peFOTA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82BA2605E5;
	Mon,  7 Oct 2024 18:48:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id C74F41BF34B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Oct 2024 18:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B512D400FF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Oct 2024 18:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEXBJ4FNuxdy for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Oct 2024 18:48:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=stfomichev@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 13179400B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13179400B9
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13179400B9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Oct 2024 18:48:34 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e03a5ed4d7so2442955b6e.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Oct 2024 11:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728326913; x=1728931713;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DxIo6SBDZQXc37oWyxERlpu6l1Wa+ULpd6grGxBigoc=;
 b=DCTjU7ksR5aQC1ROwoQbzoo44hTdKAH6ygSG0tFVvzJuXBeHDwHo/adMowdpfMDYwn
 w6E/Q48vcaf9gA0aci0KQlJdJRPgm8iH8STE4xyI34hONq6cEfGhZQ/87oQKeYw+Gx11
 RvpHj68xioUTavKnB19rUPjY8oWTIR6wYBpH3srS8ZIvVI+38gy+T00SnQIgA0oxTgGc
 lJgziEj+Ut+UgHEcT93kCY+mb0Ir3Idk6bhpLUBbMW0GE3SPyRbKxTN0SnC42ZkAS+dW
 ws2vcCsTzEk/nygv6o95Uq8hxjFMUdfBFlhyg/fo9h9mXIm+v7ybGr/ESM2uM03Cyvnf
 LnOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSDjOldh617HvRFEYK5iQTsuw0kvp2rwYsNZDgaB5YMghMJUOIixbBaCu+Bj71CqhTx0JAAxip4ZjVOWBeH/o=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yyy9d2l/ANHx0fJ+0joWbhJjSQqp4K18/TgMS1YhdTxbK1a00qd
 Hn48sZcYiTk9Csu/L5nEJt7zc/CG/eHlXpGY0pZB1FrmFtYprEg=
X-Google-Smtp-Source: AGHT+IHidoJ5KUJ6/hc4eJOnHC4cWCklIOkHi42bJtWHz6oCLeuYegsjuUpsou49IAVpUwzcvXsFXg==
X-Received: by 2002:a05:6808:2e86:b0:3e0:7005:3f86 with SMTP id
 5614622812f47-3e3c15345a3mr10727871b6e.28.1728326913536; 
 Mon, 07 Oct 2024 11:48:33 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6c4a65esm5253615a12.94.2024.10.07.11.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 11:48:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:48:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Message-ID: <ZwQtAHpg2LB-7en_@mini-arch>
References: <87zfnnq2hs.fsf@toke.dk> <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk> <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby> <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
 <ZwArrsqrYx7IM5tq@mini-arch> <87ldz1edaz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldz1edaz.fsf@toke.dk>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728326913; x=1728931713; darn=lists.osuosl.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DxIo6SBDZQXc37oWyxERlpu6l1Wa+ULpd6grGxBigoc=;
 b=JXa+HNtD20tXdgKxk/4+n2V0K3ke/CgYI5P5qG3SNplhA/1CUMyGTywMsdaVQy0cGO
 f10e1VUG3Fudepy+ciIrJ+bKxL0UConYA40ulyvvpdOdV7TRDnIDYKn5ZUJHNDO4vg0u
 0pml1HoqLUA5I682TEogvTMFMBvcSkHO4JLu12HX+hqNtgckkuwqQU2qLoaZ/hXJiChV
 UayB5DyVVlOtbO0vGyKSOjmDH9kQAoLCqf/XjprcHUAWFkc8+Sd4XMvy1rKpITqCxnQm
 qq88iI09lRIiODVJ/44OinToOnjk1mtqLKx4lodKX7u1H9fWCdJRbgL0vVoxxCXx7IFD
 mNcg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=JXa+HNtD
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
 anthony.l.nguyen@intel.com, Yan Zhai <yan@cloudflare.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, daniel@iogearbox.net,
 kernel-team <kernel-team@cloudflare.com>, przemyslaw.kitszel@intel.com,
 john.fastabend@gmail.com, sdf@fomichev.me, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, pabeni@redhat.com, Lorenzo Bianconi <lorenzo@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, alexandre.torgue@foss.st.com,
 Daniel Xu <dxu@dxuuu.xyz>, Arthur Fabre <afabre@cloudflare.com>,
 netdev@vger.kernel.org, tariqt@nvidia.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>, mcoquelin.stm32@gmail.com,
 bpf@vger.kernel.org, saeedm@nvidia.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 10/06, Toke Høiland-Jørgensen wrote:
> Stanislav Fomichev <stfomichev@gmail.com> writes:
> 
> > On 10/04, Jesper Dangaard Brouer wrote:
> >> 
> >> 
> >> On 04/10/2024 04.13, Daniel Xu wrote:
> >> > On Thu, Oct 03, 2024 at 01:26:08PM GMT, Stanislav Fomichev wrote:
> >> > > On 10/03, Arthur Fabre wrote:
> >> > > > On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
> >> > > > > On 10/02, Toke Høiland-Jørgensen wrote:
> >> > > > > > Stanislav Fomichev <stfomichev@gmail.com> writes:
> >> > > > > > 
> >> > > > > > > On 10/01, Toke Høiland-Jørgensen wrote:
> >> > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> > > > > > > > 
> >> > > > > > > > > > On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> >> > > > > > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> > > > > > > > > > > > 
> >> [...]
> >> > > > > > > > > > > > > 
> >> > > > > > > > > > > > > I like this 'fast' KV approach but I guess we should really evaluate its
> >> > > > > > > > > > > > > impact on performances (especially for xdp) since, based on the kfunc calls
> >> > > > > > > > > > > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
> >> > > > > > > > > > > > > each packet, right?
> >> > > > > > > > > > > > 
> >> > > > > > > > > > > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
> >> 
> >> I really like the *compact* Key-Value (KV) store idea from Arthur.
> >>  - The question is it is fast enough?
> >> 
> >> I've promised Arthur to XDP micro-benchmark this, if he codes this up to
> >> be usable in the XDP code path.  Listening to the LPC recording I heard
> >> that Alexei also saw potential and other use-case for this kind of
> >> fast-and-compact KV approach.
> >> 
> >> I have high hopes for the performance, as Arthur uses POPCNT instruction
> >> which is *very* fast[1]. I checked[2] AMD Zen 3 and 4 have Ops/Latency=1
> >> and Reciprocal throughput 0.25.
> >> 
> >>  [1] https://www.agner.org/optimize/blog/read.php?i=853#848
> >>  [2] https://www.agner.org/optimize/instruction_tables.pdf
> >> 
> >> [...]
> >> > > > There are two different use-cases for the metadata:
> >> > > > 
> >> > > > * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
> >> > > >    few well known fields, and only XDP can access them to set them as
> >> > > >    metadata, so storing them in a struct somewhere could make sense.
> >> > > > 
> >> > > > * Arbitrary metadata used by services. Eg a TC filter could set a field
> >> > > >    describing which service a packet is for, and that could be reused for
> >> > > >    iptables, routing, socket dispatch...
> >> > > >    Similarly we could set a "packet_id" field that uniquely identifies a
> >> > > >    packet so we can trace it throughout the network stack (through
> >> > > >    clones, encap, decap, userspace services...).
> >> > > >    The skb->mark, but with more room, and better support for sharing it.
> >> > > > 
> >> > > > We can only know the layout ahead of time for the first one. And they're
> >> > > > similar enough in their requirements (need to be stored somewhere in the
> >> > > > SKB, have a way of retrieving each one individually, that it seems to
> >> > > > make sense to use a common API).
> >> > > 
> >> > > Why not have the following layout then?
> >> > > 
> >> > > +---------------+-------------------+----------------------------------------+------+
> >> > > | more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
> >> > > +---------------+-------------------+----------------------------------------+------+
> >> > >                  ^                                                            ^
> >> > >              data_meta                                                      data
> >> > > 
> >> > > You obviously still have a problem of communicating the layout if you
> >> > > have some redirects in between, but you, in theory still have this
> >> > > problem with user-defined metadata anyway (unless I'm missing
> >> > > something).
> >> > > 
> >> 
> >> Hmm, I think you are missing something... As far as I'm concerned we are
> >> discussing placing the KV data after the xdp_frame, and not in the XDP
> >> data_meta area (as your drawing suggests).  The xdp_frame is stored at
> >> the very top of the headroom.  Lorenzo's patchset is extending struct
> >> xdp_frame and now we are discussing to we can make a more flexible API
> >> for extending this. I understand that Toke confirmed this here [3].  Let
> >> me know if I missed something :-)
> >> 
> >>  [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
> >>
> >> As part of designing this flexible API, we/Toke are trying hard not to
> >> tie this to a specific data area.  This is a good API design, keeping it
> >> flexible enough that we can move things around should the need arise.
> >> 
> >> I don't think it is viable to store this KV data in XDP data_meta area,
> >> because existing BPF-prog's already have direct memory (write) access
> >> and can change size of area, which creates too much headache with
> >> (existing) BPF-progs creating unintentional breakage for the KV store,
> >> which would then need extensive checks to handle random corruptions
> >> (slowing down KV-store code).
> >
> > Yes, I'm definitely missing the bigger picture. If we want to have a global
> > metadata registry in the kernel, why can't it be built on top of the existing
> > area?
> 
> Because we have no way of preventing existing XDP programs from
> overwriting (corrupting) the area using the xdp_adjust_meta() API and
> data_meta field.

True, but this can be solved with some new BPF_F_XDP_HAS_FRAGS-like
flag (which can reject loading if there is some incompatibility)?
Even in the new KV-metadata world, 2+ programs still need to be
aware of the new method to work correctly. But I do see your point
that it's better to not apply any metadata than apply something
that's corrupt/overridden.

> But in a sense the *memory area* is shared between the two APIs, in the
> sense that they both use the headroom before the packet data, just from
> opposite ends. So if you store lots of data using the new KV API, that
> space will no longer be available for xdp_adjust_{head,meta}. But the
> kernel can enforce this so we don't get programs corrupting the KV
> format.

Ack, let's see how it shapes out. My main concern comes from the
growing api surface where for af_xdp it's one mechanism, for xdp
redirect it's another. And for Jakub's consumption from userspace
it's gonna be another special case probably (to read it out from the
headroom head)? Idk, maybe it's fine as long as each case is clearly
documented.
