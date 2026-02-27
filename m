Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C5A104891D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Feb 2026 23:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D60C38148A;
	Fri, 27 Feb 2026 23:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3Rb1wOnHOrs; Fri, 27 Feb 2026 23:32:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE37481432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772235156;
	bh=pE/WkHibMahveIB6Gg1XiQ/l8aiTIZhOpMT4mEMqZY0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zMgEkZ7GYl1Ct1AsALZPZlBeYV2KPZY6ri9jVB5m1PrqUit3dMOsSongdQgRji+2n
	 4l0uGt/3qIlTl8SEQrdZtGMaefuPue/XxVaKdUWJLn2qROoZo3xsbmh8T5MLACoB4c
	 klWEK7LTC+qGoh2qkANgm+G6THgniEVY/bLm9DLt/7w8yYvLa0/RoaS2W+eXOh8lPP
	 b8oulk5OGmHPolEa2VHKcOUjzkh9I+lIMh/IoWZC21fFzTxOC/SnD3eE8zfNJMwmqY
	 3owz9j0x2T5TZB9bscmvblRPJzAzYlqzz6ScSWfwotvS8RTV/E+136MGmbWqn9cQtV
	 Mw4fc/wWA1Bgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE37481432;
	Fri, 27 Feb 2026 23:32:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0B8E1F3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 23:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C238440BFF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 23:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAjjNaDXt6Fd for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Feb 2026 23:32:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 253F040BC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 253F040BC0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 253F040BC0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Feb 2026 23:32:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8083A40750;
 Fri, 27 Feb 2026 23:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECDFC116C6;
 Fri, 27 Feb 2026 23:32:32 +0000 (UTC)
Date: Fri, 27 Feb 2026 15:32:31 -0800
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
Message-ID: <20260227153231.78d16b69@kernel.org>
In-Reply-To: <aaGaaExy63bGa7Or@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org> <aZbuWBnmh_SQJyVf@lore-desk>
 <20260219091344.1d8517f3@kernel.org> <aZyKWoxnywXKWth9@lore-desk>
 <20260223151845.06db43b0@kernel.org> <aaGaaExy63bGa7Or@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772235153;
 bh=Gl9pmWCL2mZ3Wj2qs5uUBK7sBEzBWHxCsN6KpmSpLyE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bYtorbVy8qSlQjd7l1kWdzABNB9LzHi1Yio+QUGF124fthAQR4f7N7zIWocCokrSH
 6HaBhcp86x89uxkTA+TomGUmaAKGghBTTfUj6NahDiwWzUslVXL08VjcFnQDBOg/Io
 jyBIrRLIllBPatXEVoiFJHXpmt5KhzPtf+D0Re3hGlhYRxI1cD5E/n8MIHPmo6nQnx
 lTGii9JUO/lCUBoJsSz3jzYhokGuvhV8Zl6U5EpX+Z9QTXz7gvLD+4IP0br6nhQbR5
 k932/+YF5E7zJZSNex52AGGP6IAizHjxsVGjkKr7/ZWJWRMQfK/pYEtaLaZqXXc5tK
 K/alACU4cz6Ng==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bYtorbVy
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

On Fri, 27 Feb 2026 14:21:44 +0100 Lorenzo Bianconi wrote:
> > > At the moment there is no way to store the csum value we got running
> > > bpf_xdp_metadata_rx_checksum() in order to be consumed during
> > > xdp_buff/xdp_frame to skb conversion (this info can just be consumed in the
> > > ebpf program bound to the NIC) but  
> > 
> > I think the scope here is much narrower than the xdp_buf to xdp_frame
> > to skb conversion. We are just pass information between the program and
> > driver which owns xdp_buff. Very similar to your new xmo.
> > 
> > We could either tell the driver to discard the csum complete or even
> > add a helper to "adjust" the the csum value. Similar to the helper
> > we have to adjust the csum in TC / skb context.  
> 
> IIUC, for the CSUM_COMPLETE case, we want to add a kfunc used to update (or
> invalidate) the checksum value (if the packet has been modified by the eBPF
> program bounded to the NIC) and report the updated checksum to the driver if
> the XDP verdict is XDP_PASS. Correct?
> 
> I guess we could have two approaches here:
> - Write the new checksum value into the xdp_metadata area (if available)
>   where the driver can load it and update the checksum value before
>   allocating the skb.
>   The main downside of this approach is we need modify each driver.
> - Add a new xmo callback used to set the checksum value and report it
>   from the eBPF program into a specific memory area provided by the driver
>   (e.g. DMA descriptor) that is used to build the skb.
>  
> What do you think?

Exactly. The invalidation is easier 'cause using a single bit in the
flags should be uncontroversial. If we want to be able to repair /
provide the csum complete then we have to pick one of the two options
you outlined. As you may suspect from previous discussions I favor 
the latter. But we'd probably have to have a PoC with either one and
see where the consensus falls.

Actually, thinking about it more, I guess this is not just a
CSUM_COMPLETE issue. XDP_PASS will also risk reporting invalid
UNNECESSARY to the stack (e.g. when XDP stripped a UDP tunnel
which which the NIC compute the UNNECESSARY but the packet inside
the tunnel has an invalid csum).

> Moreover, since we already have this issue upstream, do you think
> this new feature must be part this series or can we do it with a
> follow-up patch/series?

We don't have to add the kfunc to adjust / invalidate the csum.
But we should document how the drivers are expected to behave until
such kfunc exists and we should add a selftest that checks the
documented expectation.
