Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D38E9A053
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Feb 2026 17:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1C8C60EC9;
	Thu, 19 Feb 2026 17:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dlTywRUSCZaX; Thu, 19 Feb 2026 17:13:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC42F60E9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771521229;
	bh=mZ+6AezmEtopOITK5v1FArQTlR1bXXA50vyj2gWCt3M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Of/288YP69lXsc44q5OixeBvdWQBOEH9hxRawFfiaDJ/sKlR0mZ1mbFvEhmOB7hHt
	 2yDwwVprPgQP9Q2gwqJa6Zk9yPx1PnzRdmBfKw/m+Ox/IYjXcI6ON0/BtzwnwPeHjq
	 omPII+D5O/rTHDjXTBj8PQIMvv5Nk32456VE8DB1SiWR6gwTL5em+hK4V1I4Lf1/sk
	 TlnFBBaEM9f5mvbMng+6XQxXJWNmZdL0OVbuoZLandHNsf85HZIFmjQIthJzgCP2ez
	 Q4laXffaQhFTgcjCbo4Z85b6853EER+IVSeVekhww9yK/A84GBgmlviSfTzuIK31/h
	 QhWYSo0Qo9uzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC42F60E9D;
	Thu, 19 Feb 2026 17:13:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C73CB206
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 17:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC71C8343F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 17:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TZyIl4MAt0Xs for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Feb 2026 17:13:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BF6C580D44
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF6C580D44
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF6C580D44
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Feb 2026 17:13:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 356E543BA3;
 Thu, 19 Feb 2026 17:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99FFC4CEF7;
 Thu, 19 Feb 2026 17:13:45 +0000 (UTC)
Date: Thu, 19 Feb 2026 09:13:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Message-ID: <20260219091344.1d8517f3@kernel.org>
In-Reply-To: <aZbuWBnmh_SQJyVf@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org> <aZbuWBnmh_SQJyVf@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771521227;
 bh=uSNP3MgJa05tgGcM2PHS+3DfjpvUZxFcp68M0fm6gMw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YBECWMXb0l7YTspH/2A5O3YVGZH6sWYLy8DEUbYHZmd42ojMoLrQlGcLCCJMrL2hh
 x+wP36x5mPRNiQ4YlwXCwC/juipG7QbBpRGokXKhMip0rb+zqeOyz1T/oyqvIsqX39
 0uWM5uc3clsg6rObH0QWpBsHgl6EHjxydLfuQ8y75z5noUysamoKS2gFAR01od1G1Y
 PgTXezyWl0CqUO+nYC9xJ+/p3WCbTnYD1J04ekQmer9tzg7Sw1gmJB6VQvUPRZySKk
 heOGtRDTg2rnD4IQxpqSjHoTGMLaI1R6+dFrvzNnqVQa3aTn6B+/CDnUXAC+onTPQe
 wmiBxtyJ7m7Wg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=YBECWMXb
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v3 1/5] netlink: specs: Add
 XDP RX checksum capability to XDP metadata specs
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

On Thu, 19 Feb 2026 12:04:56 +0100 Lorenzo Bianconi wrote:
> > On Tue, 17 Feb 2026 09:33:56 +0100 Lorenzo Bianconi wrote:  
> > > + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> > > + * values are:
> > > + * ``XDP_CHECKSUM_NONE``
> > > + * ``XDP_CHECKSUM_UNNECESSARY``
> > > + * ``XDP_CHECKSUM_COMPLETE``
> > > + *
> > > + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> > > + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> > > + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE``  
> > 
> > It's fairly common for NICs to report both csum complete and
> > unnecessary. Which one should the driver return in that case?  
> 
> Do you mean what is value for cksum_meta if we do not report csum_level for
> XDP_CHECKSUM_UNNECESSARY/CHECKSUM_UNNECESSARY use-case? (as suggested by
> Stanislav).

More fundamentally whether the API is right.

> My original idea is:
> - if the hw reports CHECKSUM_COMPLETE:
>   - ip_summed = XDP_CHECKSUM_COMPLETE
>   - cksum_meta contains the checksum computed by the hw
> - if the hw reports CHECKSUM_UNNECESSARY
>   - ip_summed = XDP_CHECKSUM_UNNECESSARY
>   - cksum_meta = csum_level <-- Stanislav suggests to drop this one
> - if the hw reports CHECKSUM_NONE
>   - ip_summed = XDP_CHECKSUM_NONE
>   - cksum_meta = 0

Off the top of my head drivers prefer reporting UNNECESSARY when they
have both, and reserve COMPLETE for cases where L4 could not be found
or is incorrect. Why don't we report both? We're using 3 args, we still
have 3 to go. We could turn ip_summed into a bitmap and have explicit
output args for both level and csum complete value?

One more thing I'd like us to at least have a plan for at this stage
is how to deal with COMPLETE + modified packet + XDP_PASS.
Right now some drivers discard COMPLETE when XDP is attached since
they can't be sure if XDP modifies the packet. Other drivers don't
and we end up with bad csum splat. Do we have a recommendation on
the correct behavior? If not - should we have a kfunc to adjust /
discard csum complete explicitly?
