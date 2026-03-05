Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8BCEFCE43
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Mar 2026 02:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64E51608CB;
	Thu,  5 Mar 2026 02:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVMibDODBONg; Thu,  5 Mar 2026 02:55:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D388A608FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772679337;
	bh=AS003hYPMKVNDBZvHRWuPlXHnvYEF5VFOEacKtuMb3E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9S1TBaH4Xz2d20/0N8/YTz8rKqpV/QbR1pQQpWdWWOefyg0aHGWJ2xpTIP/isLnE
	 3RO6N2mzWXcgcm3CzEJpvug9aAiqlVSRJHyarIdYopAg9SVdWqVQokxf4WyEGwzmC7
	 camQM/euUkIWSXDXwRIqBBMnmX7hJ1TDnvg7qA8+XAJcVLwZp4ghcCG6tZ3f/q4ZGO
	 VrKUcN5CUmLmRNhP0NcLSF6vroIn+kjcV1YRwc4tGgnLlV0tEJdxnRaeO15NIF0ndu
	 HXrFLmB2/YREJYvHEm0KVwL61ZsHkWc5u6vJMMgob1N1xcuCvltGr9TkCdxiZpT6BL
	 WbHkkEMXMT03w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D388A608FC;
	Thu,  5 Mar 2026 02:55:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA8FA223
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 02:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC595608FC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 02:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQ1b162yMdlO for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Mar 2026 02:55:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 246A4608CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 246A4608CB
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 246A4608CB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 02:55:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 88F6D404ED;
 Thu,  5 Mar 2026 02:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2664C4CEF7;
 Thu,  5 Mar 2026 02:55:32 +0000 (UTC)
Date: Wed, 4 Mar 2026 18:55:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, "Bastien Curutchet (eBPF Foundation)"
 <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, "Ricardo
 B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Message-ID: <20260304185531.4f49fda4@kernel.org>
In-Reply-To: <20260302161723.858616-1-larysa.zaremba@intel.com>
References: <20260302161723.858616-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772679334;
 bh=4d7y/xjgWSGuhuezCdtH2976xfIP6uASlpXYDBGcWGw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pYK7YM4m0fnSsQAyhefMcDaOBvn8Y9c20FaOvCpYggIpa60A8z3EWxFyPSfPRL9FU
 REN3e4tRWW1m7oG26k1oqS+4aO937R4czODpAvvERAsyQWEQMzozLXDSJml7d3155z
 jcXg03aXYVxS0lHpCo0e59gkB2hrJHpLLVbwZU5kMt/dzDbqrUe3XWteUg9Db2G9AZ
 7CMUJ2C/mOnC6YdoiPoF+jNUvhw4vyDicAInnAmtwaJ8ckXg8wYOq8SMe7YFrs82cG
 +bU8uWFw2JBclJCUuwTUOm5ex6kn+DfB7sKrnPaJvlby8tgUkH8ayRDaMdRV+ro3nH
 mC/rbafRFsa9A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=pYK7YM4m
Subject: Re: [Intel-wired-lan] [PATCH bpf v4 0/9] Address XDP frags having
 negative tailroom
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

On Mon,  2 Mar 2026 17:17:13 +0100 Larysa Zaremba wrote:
> Aside from the issue described below, tailroom calculation does not account
> for pages being split between frags, e.g. in i40e, enetc and
> AF_XDP ZC with smaller chunks. These series address the problem by
> calculating modulo (skb_frag_off() % rxq->frag_size) in order to get
> data offset within a smaller block of memory. Please note, xskxceiver
> tail grow test passes without modulo e.g. in xdpdrv mode on i40e,
> because there is not enough descriptors to get to flipped buffers.

This was re-assigned to netdev in pw, I presume by BPF maintainers.
But it doesn't apply to net. There's a conflict in ice.
Could you rebase on net and repost?
