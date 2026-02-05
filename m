Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF4DEA794D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 01:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F075240631;
	Thu,  5 Feb 2026 01:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKe9-IY9K323; Thu,  5 Feb 2026 01:26:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19B23405F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770254794;
	bh=1yC1aJCKUXQvAvWWVWGB5xU8/o9lSJk787lz6+ORpPE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=klx6Hnk7oCKTz/tI5fO/bAd8IyF0Zw+q9/ULLoqJt5pi/ZjgbWC5vxG7PXlisi75a
	 EukvQSyzVgeKUWOl2BYIq/SumYo4cXjLt0KhzBu5vE8bhmkxzMW7kXnkU1fttSd0P5
	 u3KxuM1oDm1tPRbwkvwQ/Y4ymPqMOGUIsDYcwkzwuYSL3dKIxnOjHo4yJ9XIjdr3i0
	 IkQ3d/6MdShac0VWEVzZPAP9b7BKXjdPAA1KioxqES62uj+nB/TtNGGjv3Lku55kXP
	 p3L9wzvnmL1oxbzWrXHKAHMWOfThA4yPkuDmJg1NbkPKT2/IZN8JL9Qsn6g+EijXRW
	 zI/j4no0mpQzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19B23405F3;
	Thu,  5 Feb 2026 01:26:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 979A3F5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 887B740143
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h7vmBTWE7Ljc for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 01:26:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DCA2C40090
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCA2C40090
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCA2C40090
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:26:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BB4D160010;
 Thu,  5 Feb 2026 01:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7CDC4CEF7;
 Thu,  5 Feb 2026 01:26:29 +0000 (UTC)
Date: Wed, 4 Feb 2026 17:26:28 -0800
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
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260204172628.165ac4c8@kernel.org>
In-Reply-To: <20260203105417.2302672-1-larysa.zaremba@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770254791;
 bh=hjxysTPajKK2FZ1aXORytluX1M7dwqbn4j8lWHCg0/c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GbBGR8QZRyQf1w+JGOdQufOHYIHqbhaclPKXQu+FPwVTQlYMbyJh4dsZ74ICk/u7i
 Yi+pqPsc7cWmSM5hwMlBzL2YH49kB5Bi+douYUfQnDepKf0Tr0ba2hOrn3+gGd87i4
 I25scu4d1CtYK+hfjhOWyuOqbBmZkY+nvlq9TbMSChhO2tpFji4BLg/oNoLVtGIOf5
 rHvFNsMv28+kKOAaOp+nh+43wyIFQ4TmylYSR17lufX08UxgD5ACPRVUmB1WM3iIaH
 wV7D/1DSzi7r5DprXmNxWWz3xon3gs3HJOvy6uMbc+7QJ9t/+S0WxqhZo8qouhkizf
 tJaDadsu0gvZg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GbBGR8QZ
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

On Tue,  3 Feb 2026 11:53:28 +0100 Larysa Zaremba wrote:
> Many ethernet drivers report xdp Rx queue frag size as being the same as
> DMA write size. However, the only user of this field, namely
> bpf_xdp_frags_increase_tail(), clearly expects a truesize.

truesize may not be the most fortunate term.
truesize is how much memory we charge to the skb (for memory management)
which may relate to frag size in strange ways for strange HW :S
I don't have a great term, but I have a feeling truesize already
confuses driver developers.

Note two our xdp.py tests covers tail adjust, I wonder if it would have
caught this for you. Looking at Intel's results the XDP tests don't run
due to missing BTF. Could you work with Adrian to address that?
