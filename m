Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30143EE6B6F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Feb 2026 02:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFBC660B79;
	Sat,  7 Feb 2026 02:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h8gTkXj4xr-M; Sat,  7 Feb 2026 02:57:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A18B460767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770433062;
	bh=wpf1uTnvVQgnq4kwJb7evm3NJckKxEIO0pdHq5+8na4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o7Ea86u+CnbC+RNgrkhxROkcOrVD5eYoPAVkuBZ2IKuL67MVFGYw44sGEh689Q+oY
	 EdkrJg3vanHUiIS4emxCRKYnguMMvL5i7ILy36WoSeI/tm52WEq+vJfIjeNgQ2BK9a
	 u0HKhaA3Rvzyz+j2FKvRivQ9/rC4I7emdEecsAMFK7PKdDJPIMGzQOXRybeKmcNpxK
	 qgaEPaZguiTLo8QygA5nUvO71H07joYaHjocSZ11sdPh5iOfTfGoSSmDQVvgY95URb
	 7o15IWzcF6f9nM2n+jYRpFEJciu1n0KyIdl1wD/USoxTodDpxPKHhGl47I1z11FhQ5
	 NYONIVkfnFQNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A18B460767;
	Sat,  7 Feb 2026 02:57:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5684173
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 02:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A94660767
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 02:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoG0N-HEmd2u for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Feb 2026 02:57:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BAE9D60731
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAE9D60731
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAE9D60731
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 02:57:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C011E6001A;
 Sat,  7 Feb 2026 02:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30CAC116C6;
 Sat,  7 Feb 2026 02:57:36 +0000 (UTC)
Date: Fri, 6 Feb 2026 18:57:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, <bpf@vger.kernel.org>,
 "Claudiu Manoil" <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>, "Bastien Curutchet
 (eBPF Foundation)" <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, "Ricardo
 B. =?UTF-8?B?TWFybGniiJrCrnJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Toke
 Hoiland-Jorgensen" <toke@redhat.com>, <imx@lists.linux.dev>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-kselftest@vger.kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260206185735.787fb0e5@kernel.org>
In-Reply-To: <aYWoBRmt-lcM_JkG@soc-5CG4396X81.clients.intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-7-larysa.zaremba@intel.com>
 <20260205005901.gnju3zmqimtgeu2b@skbuf>
 <20260204173401.282899d0@kernel.org>
 <20260205122953.lscemcctayrvszdu@skbuf>
 <aYSP344FT-JlylwY@soc-5CG4396X81.clients.intel.com>
 <20260205124638.hxzvjiocephzlrk3@skbuf>
 <aYSZw4wbd-nvLTuD@soc-5CG4396X81.clients.intel.com>
 <20260205134046.pggwyosutj7ggi4i@skbuf>
 <20260205175408.30ab72a1@kernel.org>
 <aYWoBRmt-lcM_JkG@soc-5CG4396X81.clients.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770433058;
 bh=fEJXLRawPbdCf3xetPQEnbQsr9d6YyTUk64NobkmyKw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oPkt7rGC0FvsPX3scZHiX4yFkazHdSma2rHcjUNE+XplJnIuJIH+g0x3qT0JrSqP0
 e+KSmkhZHKOonSFsWFXjIEHIvSv58IFC1Tpr0o1uCEVxru8ZL6DbGmwhh1uUSSwVXg
 l8U1urkkBbTwCEEvcsRgFEkis0kn+wl7Yy33vxPtsQcLb9F7BSPCTrfp6f3UWBfEtt
 LOTYxIx8iHCD75aQc344YfRivo7h5oi2ynwyXCJVlE4WaAkJnbCbTaQy66xB5Yz1SK
 C+zNBEb/vygekFf+kZ9j2c6PI+3ZP0++LJaOYsxEnBfSIMeqZEviymfulgtLZvpJde
 JcW6+CxRddl1Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oPkt7rGC
Subject: Re: [Intel-wired-lan] [PATCH bpf 6/6] net: enetc: use truesize as
 XDP RxQ info frag_size
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

On Fri, 6 Feb 2026 09:36:21 +0100 Larysa Zaremba wrote:
> > FWIW my feeling is that instead of nickel and diming leftover space 
> > in the frags if someone actually cared about growing mbufs we should
> > have the helper allocate a new page from the PP and append it to the
> > shinfo. Much simpler, "infinite space", and works regardless of the
> > driver. I don't mean that to suggest you implement it, purely to point
> > out that I think nobody really uses positive offsets.. So we can as
> > well switch more complicated drivers back to xdp_rxq_info_reg().
> 
> As Vladimir has mentioned, if the driver does not use header split, frags will 
> have a tailroom of a size of skb_shared_info, so tail growing does work in 
> practice.
> 
> Allocating a page_pool buffer (given XDP queue has one attached) is certainly an 
> option, although I am not sure if anyone needs it. Furthermore, growing tail 
> would still fail for a single-buf case.

sbuf is a different code path, sbuf has precise frame_sz per frame,
not a single value in rxq, no? Don't mean to argue, just making sure
my mental model is correct ;)
