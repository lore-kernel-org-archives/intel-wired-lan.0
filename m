Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE000EA794B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Feb 2026 22:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7190C608EA;
	Wed,  4 Feb 2026 22:57:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VpNW1wyS1gIF; Wed,  4 Feb 2026 22:57:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 244D7608A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770245855;
	bh=qBt8lt8bM7kV+Zu3BUC89Q+Zy75+2GMxIq581jsCjw8=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6EYHFv/QJ8Ff/4KOa23HNnQdF/+qhLdF6Gsr9/G+dJgfNTcWaD4L7SfG6QtxZRNjE
	 Fi86g9N5g1XYtn1KLPQqxv5bvoxVI6CtTaP16giKLRYXgBIrXli1xLzAdg4Uyi7yFK
	 nuK6pNbKI4W6WxIVdbLRbAqXjBMZ+U5qn2zcjEqRNMhixbituBQ9+63r0L3jT+ME85
	 RpLzL3zPFGYIukjhFmhKgWWkKmNYc3RGJO23hsd9u32/7HKCN9kV9ckWYCY5+cbyjL
	 Q2pFn00uZYz0p1twcZs0dlPRkQRZnJ63fFAeweWLLN5Z+mrK3OxqDW1T9dpZq1SHxt
	 W7BQuAv7dgxrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 244D7608A4;
	Wed,  4 Feb 2026 22:57:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 046A4F5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 22:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D92AE83F58
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 22:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EIDr7ix-t2fZ for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Feb 2026 22:57:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:203:375::b0; helo=out-176.mta1.migadu.com;
 envelope-from=martin.lau@linux.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0EE0483F56
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EE0483F56
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b0])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EE0483F56
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 22:57:31 +0000 (UTC)
Message-ID: <e7d4ff92-232c-4683-b235-aa1d75374be1@linux.dev>
Date: Wed, 4 Feb 2026 14:57:13 -0800
MIME-Version: 1.0
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, Larysa Zaremba <larysa.zaremba@intel.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kernelxing@tencent.com>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, Eelco Chaudron <echaudro@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260203105417.2302672-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1770245845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBt8lt8bM7kV+Zu3BUC89Q+Zy75+2GMxIq581jsCjw8=;
 b=HK44WUzMaWM8Rka/qoHOX77lnm8HDdtPBUdxnIbURLPeP2r0edD3WlO/hdKyb1NXjirVyV
 pTe9xU5s/rVYN8o8hce9VmqHqNZjTP4UW8FX/adILp4kA6iRHmrjC83/cHcmr0FmdMzX9u
 i7Yk3SOnv+meqKNARN6qxrWNqJ2IvVU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=HK44WUzM
Subject: Re: [Intel-wired-lan] [PATCH bpf 0/6] Address XDP frags having
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

On 2/3/26 2:53 AM, Larysa Zaremba wrote:
> Larysa Zaremba (6):
>    xdp: produce a warning when calculated tailroom is negative
>    ice: fix rxq info registering in mbuf packets
>    ice: change XDP RxQ frag_size from DMA write length to truesize
>    i40e: use truesize as XDP RxQ info frag_size
>    idpf: use truesize as XDP RxQ info frag_size
>    net: enetc: use truesize as XDP RxQ info frag_size
> 
>   drivers/net/ethernet/freescale/enetc/enetc.c |  2 +-
>   drivers/net/ethernet/intel/i40e/i40e_main.c  |  5 ++--
>   drivers/net/ethernet/intel/ice/ice_base.c    | 26 ++++++--------------
>   drivers/net/ethernet/intel/ice/ice_xsk.c     |  3 +++
>   drivers/net/ethernet/intel/idpf/xdp.c        |  2 +-
>   net/core/filter.c                            |  3 ++-

Jakub, can you help to take it to the net tree? Thanks.
