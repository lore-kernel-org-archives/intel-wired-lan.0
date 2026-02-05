Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B6BEA794C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 01:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75B2940CEB;
	Thu,  5 Feb 2026 01:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kh1JwuzvrWlY; Thu,  5 Feb 2026 01:34:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6158F40D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770255247;
	bh=643L/wJXMohSwcMRgDYbimVSq/d/gZBOiRZdIvBwQ4I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PWTvBZTY5BlXSvXHGY3HCc4A/ek/5TJvgaTiblwmHdX2eAUzIzS5NjV/BPCUagHEO
	 FRUOnGG3LHTEaJq8PZKMt1oxgFmhDb08YQ3QKt9K11gIvJB17dFL0H9e5IYhptdKWn
	 I+PDm9Hv31D/WhlhyuMt4nXgk77WGXdLm9gTFJeKOxVSVvMjrHlgQIXVrQH3Qxn+81
	 hL/Z0u0tq11CRpKYSsj1gEEZeYzIMlP5LSC/Q/kzIg9cvy+mqlQ1uI0odu6veQg0/u
	 nyiUIi5cCB1O1nImoV6pYbPwT2vn73oc3H5H3BPTRt1ui6TY8UwgyrhIE9SlxCUUbD
	 LVm5NmXq48guA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6158F40D37;
	Thu,  5 Feb 2026 01:34:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D28CF5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E35440CEA
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I8hVqUeXHREX for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 01:34:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6E29B40CE9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E29B40CE9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E29B40CE9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 01:34:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 917CA43AAD;
 Thu,  5 Feb 2026 01:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE722C4CEF7;
 Thu,  5 Feb 2026 01:34:02 +0000 (UTC)
Date: Wed, 4 Feb 2026 17:34:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
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
 B. =?UTF-8?B?TWFybGniiJrCrnJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260204173401.282899d0@kernel.org>
In-Reply-To: <20260205005901.gnju3zmqimtgeu2b@skbuf>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-7-larysa.zaremba@intel.com>
 <20260205005901.gnju3zmqimtgeu2b@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770255244;
 bh=0u0PVRNuSSgJ24J9RSkTtvGB/Sq3SToazqRzHf3k9oM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JvLrpYKJ+A2rWVs3m/oJxbPk0NKGBV3yMRqt1DguRhcao+2cLLgtrW+isjepeRdRm
 0KBV76gfQqSSxGOhOmvMM/RyLPDWlG9S1kHtvuZWyk6AXt/sEstH8IIJifkP/p6xIB
 BD1m4M+QGdw13h/YVfZwgxp2lTPt0aVOYTVn7ABLW4DNV9iMQ9A41ZZALHaJZNkFBx
 RThyPw3UfVlM+waX3tvsKyhHDU7VmBVhtNfnW38PH68F25bDbuyv+t/Y1Wb2aUrgSb
 SAdRL3rU2JebD0trLF5grO4sIulV/wTIwizO/fIbDW6lGkCaEIYz+l8uUs1BvfX/pc
 Qqeo72b6g/UsA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=JvLrpYKJ
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

On Thu, 5 Feb 2026 02:59:01 +0200 Vladimir Oltean wrote:
> Thanks! This is an extremely subtle corner case. I appreciate the patch
> and explanation.
> 
> I did run tests on the blamed commit (which I still have), but to catch
> a real issue in a meaningful way it would have been required to have a
> program which calls bpf_xdp_adjust_tail() with a very large offset.
> I'm noting that I'm seeing the WARN_ON() much easier after your fix, but
> before, it was mostly inconsequential for practical cases.
> 
> Namely, the ENETC truesize is 2048, and XDP_PACKET_HEADROOM is 256.
> First buffers also contain the skb_shared_info (320 bytes), while
> subsequent buffers don't.

I can't wrap my head around this series, hope you can tell me where I'm
going wrong. AFAICT enetc splits the page into two halves for small MTU.

So we have 

 |                 2k          |             2k              |
  ----------------------------- ----------------------------- 
 | hroom | data | troom/shinfo | hroom | data | troom/shinfo |
  ----------------------------- ----------------------------- 

If we attach the second chunk as frag well have:
  offset = 2k + hroom
  size = data.len
But we use
  truesize / frag_size = 2k
so
  tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
  tailroom = 2k - data.len - 2k
  tailroom = -data.len
  WARN(tailroom < 0) -> yes

The frag_size thing is unusable for any driver that doesn't hand out
full pages to frags?
