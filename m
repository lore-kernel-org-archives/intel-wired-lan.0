Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BD6EA794C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 01:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37EC240DA1;
	Thu,  5 Feb 2026 01:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-v4RWhVSt2F; Thu,  5 Feb 2026 01:23:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A10640D6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770254608;
	bh=HOrbGJrybssgRjSRyhXevDMliHyT7lZRsTZ1gYLRHc8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=srwTk07KmRoR8MwzeBTe1Ak0ppVinBiRXUWEOfu1lfr8xvqk9piE3qK6H2BgcLPTe
	 YS2jvFkCkFl1A2rYRT4UPKwqbSHSryzBCRrgdesoRRPbN9UCgllRolzk7NT38LrjGK
	 Au3FlPL1avBpWytseHn9qm7Kv+CobxPW8F7phY2N6OxYFAukchH3wGZme7jonc7JBi
	 AvAu/pSfbP7Z1cSB3c6Ycac++vgJM8Kx7iNVU15PChsG+3ATPzlAk5nC/Q4zFF/zTq
	 kys0aeNiktz6li5kc29lmk+qkju8Kyw2Uk4V7Hf7IojnuoqU9JMmJjdM3vFPiYdhxx
	 34ebmrKKdIGvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A10640D6C;
	Thu,  5 Feb 2026 01:23:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED6CA173
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDE6660A3A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ll1OGpFcvJ_f for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 01:23:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 267EE607B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 267EE607B6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 267EE607B6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:23:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F370160010;
 Thu,  5 Feb 2026 01:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B535EC4CEF7;
 Thu,  5 Feb 2026 01:23:21 +0000 (UTC)
Date: Wed, 4 Feb 2026 17:23:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
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
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260204172320.0cf0259c@kernel.org>
In-Reply-To: <e7d4ff92-232c-4683-b235-aa1d75374be1@linux.dev>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <e7d4ff92-232c-4683-b235-aa1d75374be1@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770254603;
 bh=dbbWH00AN9nxQSpcSlC8OhEK9W93kMW4Kq/rZuG81/E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Uy6IkTgR8XWjTCd6f2j73ACmERhNylK2D/W1b8L3PcvbVq3lMwSx5aHO9+WtsRFeC
 4BcINPYnCAyOYJt6dKizKPlRAocw9j8KABcmEHvf5m64XbnIRcZfaY24uXIYDLyiU/
 1MpcO2NLy4X2BUbrXtWyUox0LjVskACBUNwA7vMRFfQr14i5lEvTtzRW4V7ttZdSBD
 40K8I+B0x7mIol1mtAUvWCtBH4U4MwSOpf4Um5wObb37pb7TmO29OEd5H15Xfa9IFj
 34rIBWL/KXZC6AgrVAWnBTQP4kXztdUCLqqux9Qi3sbaL20bM6AEcLFboL+n2iSnqa
 WtRPy8pzOAgDA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Uy6IkTgR
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

On Wed, 4 Feb 2026 14:57:13 -0800 Martin KaFai Lau wrote:
> On 2/3/26 2:53 AM, Larysa Zaremba wrote:
> > Larysa Zaremba (6):
> >    xdp: produce a warning when calculated tailroom is negative
> >    ice: fix rxq info registering in mbuf packets
> >    ice: change XDP RxQ frag_size from DMA write length to truesize
> >    i40e: use truesize as XDP RxQ info frag_size
> >    idpf: use truesize as XDP RxQ info frag_size
> >    net: enetc: use truesize as XDP RxQ info frag_size
>
> Jakub, can you help to take it to the net tree? Thanks.

Will do. I think I also have some questions, first, tho :)
