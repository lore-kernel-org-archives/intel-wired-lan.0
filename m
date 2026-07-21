Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5C9C44529
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 15:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10ACC40875;
	Tue, 21 Jul 2026 15:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-SbgaCpHlxW; Tue, 21 Jul 2026 15:27:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBB3E40877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784647652;
	bh=u4TeXif3XA0edOu5Wg4bLz8wX2a3RQrUFGCChfCYTAI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3uOn/wF8ssIfrUfdEp8J/o+T6dehg0uVSZR/Nkzz+4uVUznY6KJv8xIv90wyMQD/p
	 rV+iDxRZ8eqT5FwZOviB997t1XY6J7MkW8E0op8fPoJUsuZUIGzlrhhokDzAV2icb2
	 K5FaXvoJOzBlpjNnUL9UZ9ZDM0MlN5zR5f1t48hAQpxrqxsQkPZC2jLepfzSPnnxf/
	 eDawZEt9qE7O575MLfAiTNLTz+JldoaXg5i8tM5UsihFbdPUoyJm8VTfr1JZlfHYwN
	 qu6e9qdXqVqwKdtIoBN69+4rTvWIuI8VKpa1ba4zLlks8pPoc+fMdRyKbQtgocjrIm
	 9NAkC6POmKqMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBB3E40877;
	Tue, 21 Jul 2026 15:27:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23644109F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 15:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 158F240164
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qf2snI6KxmZp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 15:27:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6FE1B40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FE1B40071
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6FE1B40071
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 15:27:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6696643A6F;
 Tue, 21 Jul 2026 15:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADAF1F00A3A;
 Tue, 21 Jul 2026 15:27:29 +0000 (UTC)
Date: Tue, 21 Jul 2026 08:27:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin
 <deliran@verdict.gg>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <20260721082728.74142e6c@kernel.org>
In-Reply-To: <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784647650;
 bh=u4TeXif3XA0edOu5Wg4bLz8wX2a3RQrUFGCChfCYTAI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=igXyWV2gARFCsyTb5BOcsDN/NU4C6Tf+kBJtZazDmZj8BBcbTRDGFCFcyaMmILHsY
 QqOey/xYnRYOCVqSPDAUNArqve8bTEvNwmd9iE0TzAJT5JKrHTjIJm1qQ2ufXT6zMc
 mLnc7TB/2eN7mCk6wip5ta6L228/AjxK+adP/CgeLYhYs4ZWCcrQ/nuMans0RNf89A
 wuqRj18TyGw8K9tUR/URpr2LeV5R42JtNFmnrfBUqPI++TcFf39dIRx7agqCna5QJ2
 94B5fOaMl0dgzAKVyMBO7g3v0N4n8aE71TIwB7tGH/vBqPDxc+3oMg5wo7wfuVT5lb
 H0hckyjPPn1/A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=igXyWV2g
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

On Mon, 20 Jul 2026 12:32:55 -0700 Stanislav Fomichev wrote:
> > > (although for gve I might be wrong, there is also gve_rx_skb_csum that only
> > > does UNNECESSARY).
> > > 
> > > I'd wait for Jakub to chime in, but it feels like we should just document
> > > what we currently do as a recommended approach: for the drivers
> > > that support COMPLETE, do not report it when the bpf program is attached.
> > > Both NONE and UNNECESSARY are ok.  
> > 
> > I am not completely sure the UNNECESSARY case is different from the COMPLETE
> > one. What are we supposed to do if the driver reports UNNECESSARY and the ebpf
> > program modifies some fields covered by the rx-checksum?  
> 
> For unnecessary, I think the safe expectation is that the bpf program
> will update the value of the checksum in the packet if it touches the data?

Documenting as expected behavior which no driver currently follows 
is a bit silly. I thought the ask was to sketch out the plan of
explicitly updating/invalidating the checksum even if we don't
implement it today?

> > > Also, did you run this test on real HW? NIPA now has HW tests, maybe it
> > > makes sense to route this series via net-next to get the real coverage?  
> > 
> > What about splitting this series and have two different series:
> > - bpf-next: add xdp rx kfunc and related selftest
> > - net-next: add kselftest for the driver expected behaviour.
> > 
> > What do you think?  
> 
> I'd post everything to net-next to get the HW coverage. Once you get all
> the acks we can ask the maintainers' guidance.

+1, and please add proper tests for the real drivers exercising the
kfunc with traffic (would be good to try to send a non-TCP/UDP frame
to try to cajole the driver into using COMPLETE).
