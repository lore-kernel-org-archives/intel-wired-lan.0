Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC5606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MYIAFE0D;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=meng.ding@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=HQQZot2Z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 884274060F;
	Mon, 16 Nov 2026 03:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8yfSBQw4OKSg; Mon, 16 Nov 2026 03:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F60840602
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794799392;
	b=iC4JMZgx2490xpDpenurt+bLzbOBmEycxxRsT3aOZAf5LwKsVNOorFNn6vrL52JGZ1h5
	 +GNc9CXyncZg3XDqCehgrrFTBHFGaFnjfw9XTcXoTRnj0ACktP5a7MIFla098YUoa6Zdk
	 TSjPbjh/bw4e2e/U9P8KiJUfQdPw4eaMdjZJe/o1mekSYEo4VUvx5TnvAliVfTIV1eH0I
	 5Kx19ZEuDoyntC+YNBwkfTkgysydAUB07V0lGlJw8yoO+Im1Zxm8cPtfw9iLkdaQG0NL5
	 c+F01/wYa0yMgELjDePw9O1ogNYeAgc6R+/VGJ5DFn1evWFIz87FkS4s8sak9WMJB8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794799392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vuaY7FImZE75sRdiBasv0Tsa2qzXujkTJsfP+X+hpsE=;
	b=UUoixrFq82/UsYqMHSoPrb+oAt5batQ7DQDeKCaiCZZIH40nC4oQYwBLCdUEs94hitT+
	 IgI2DrQR5qp/xxclJ9EgbJkANJS0M2EiZ8MfI3uV0P0oPiKFfJudUB6bP0WEm0JQ9pyno
	 jEKNGme5qeFFz7Uik+mv+CMVo4IyYtd+TdtH7hF9WXU1v1O7EHuKbz/hA1XbkEfNKVZN3
	 JOsVbLGbJ1VVEwJq8xf9yMbJ/iAHyzC7wDhfFN0eB8xR7sP8bQRSLF9XnoXXM37xAacNk
	 +rCQb4uI11Jka7D8JSVRj0a0e9t/XyXnOaNT80fE+Se7Leoi6CY1NscnbBFdM+0LgTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794799392;
	bh=vuaY7FImZE75sRdiBasv0Tsa2qzXujkTJsfP+X+hpsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MYIAFE0D0lf/EuzbDgX7i5KqkrhHkKLO+Z1F2/OKf756Cct/xgJRsoYY0q76Tx6XB
	 xwyzYLfAE40aZsWP8ZphXwbyYIEn+LF/Xp36RIWbEiPRYmDotIITIugqehCrvvGRmc
	 lH+6CCGL4RwIauu3RVtH95mdKZQ6kQQANOGFlZSxVqsK+NYKnzP/+o3zKLnzFPnNAg
	 g0lMRNiMRe78cfpJDRLWZDz49rQTT+rmVMtCiv0ot+ylb4mr7JtAam+7I3jNtGVaRm
	 pbQAd5LBB1CV4+m8GkezKtaNK1fZ1Fb9Glcj6qMQ3uHqAhDysYsmDYI4Ab0JRGfgiv
	 4HHicNL3JGHKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F60840602;
	Mon, 16 Nov 2026 03:23:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE1364A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 03:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A71EB6060E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 03:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEkLdBfYsZZg for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 03:23:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A41DE6060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-1335312-202611160323025d4b5ad0e600020733-6q3uzm@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=meng.ding@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=HQQZot2Z
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A41DE6060D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 03:23:05 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202611160323025d4b5ad0e600020733
 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 04:23:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=vuaY7FImZE75sRdiBasv0Tsa2qzXujkTJsfP+X+hpsE=;
 b=HQQZot2Z8h36ijQln+msDhv9gcSYj5SfMiT/N6XRhq1xugtUNdMn/fUxA9qBarw0//j8Na
 Qp5FuiVGhxMPO9cC993IMWDRG3jL5qroVt1jz0dpBcib5J1XqAsug55FaOn/UyJlwDW3+4/Z
 SnqUPMfUPAFyJz26D8x3C+E+NxXIWN8DlZk93cowvaGSNioXssPo/2gJc+UIv9QXzmXIx35U
 NMhKnIdWTs+/JSI01xzO9af0qK0O6sX7kqp73KReA2Smg8mZnL2c/2jAK8tKE3YieXUoBvbc
 ix9Kc3VFdeZvjHKk09TilgE806fp1YWk96vwKdP6iRMZZyoFc6l9hW+w==;
Date: Mon, 16 Nov 2026 11:22:46 +0800
From: Ding Meng <meng.ding@siemens.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Paul Moses <p@1g4.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com, Jason Xing
 <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <tuwyyxeexvnd4ckncfhdg3grlh2xd6d2rym7vhx2uzdspjopmk@quzaz3gdurlz>
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <20261110134539.12d860ef@kernel.org>
 <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
 <Fhn2gT70aJ-2_eak73NBZYuXuKtVb64PoD8VQ9jwm-S-K0RhZilAg9iwSBJ0RlaiSrRvM1vPw1aHvGPjcktu9GmdBuvFk9244-q2IVOrFu0=@1g4.org>
 <1ab53072-b9ee-464b-b5b3-cbb578059b49@engleder-embedded.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ab53072-b9ee-464b-b5b3-cbb578059b49@engleder-embedded.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1335312:519-21489:flowmailer
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 09:59:17PM +0100, Gerhard Engleder wrote:
> On 13.11.26 09:29, Paul Moses wrote:
> > 
> > > 
> > > Then, drivers that use deferred timestamp conversion (e.g. igc, engleder) must
> > > specify a busy poll dependency if they want to obtain the original net
> > > device upon consuming the skb. However, this dependency is far from
> > > obvious, and annotating it for future features of this kind will be very
> > > hard to discover.
> > 
> > The "deferred timestamp conversion" was incomplete is what I'm saying.
> > 
> > This started with 97dc7cd92ac6, 0abb62b68252 and 069b142f5819 were built upon
> > it, so maybe Gerhard should decide the path forward?
> 
> The deferred timestamp conversion is a niche feature for TSN to solve
> the working clock / global time problem in TSN networks. IMO there is
> no need to make it working as soon as igc or tsnep drivers are enabled.
> It would be ok to fall back to normal vclock behavior like all other
> drivers if CONFIG_NET_RX_BUSY_POLL=n. For me it is ok that NETCONSOLE
> is not possible for PREEMPT_RT in combination with this feature.
> 
> There are already so many things to consider to get TSN working. To
> not enable NETCONSOLE on PREEMPT_RT for deferred timestamp conversion
> would be just one of many.
> 
> @Ding Meng: Do you actually need the NETCONSOLE in this combination?
> On productive systems likely not these days due to CRA.
> 
> Gerhard
OK, understand. Thanks for your comments, Gerhard. Actuallly, we solved
this issue by disabling netconsole and enabling busy poll. This is
indeed a quite rare scenario, but when it happens, it is a bit difficult
to figure out that this was the root cause.

Ding Meng
