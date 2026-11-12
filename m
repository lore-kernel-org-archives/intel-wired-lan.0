Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6E606A324
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=BulE/gYf;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=meng.ding@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=RTxMQDBd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EEEB40ACD;
	Thu, 12 Nov 2026 04:34:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkBS1RGQG3UN; Thu, 12 Nov 2026 04:34:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 198E940ABE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794458064;
	b=W3QgyQW/F0GaQ/U+8dgTGv/aAMWGCeeKsmDcmTDVymFgG1LZulStrd8/Pa1f+/wN+Quz
	 DNIm24xyzSaptENlopa7gnbiy9alUrRhxt71VHsqtMSMOj3llMjEm1RmzAgaizYZvyGps
	 SifDA4bh2WrcAaLISB+QsI6bniC2SqWmnRRJo6aX64LUaAKsdfmLjmJ6f2uPWkbR2PeIJ
	 OI1q+nMG1jMC7BBiJML83sOltZnr7aJXnut6gBDt0oOIb2wA3Zgs3jrPIEvV2AW+A71TI
	 AkhaO4hNZKSxzUWxFAwz2Yab9fY9qPWL9lehXnI48JPbm8khmWOFT/oPxPtdleLxh9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794458064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RARPdGFOpymjJpoSOvkZ7QwTFzh+akN3FwghGunS9+o=;
	b=XL/OG8HLr1OlxWbLQKiScYX9vgHzUYYb6dRHvWFDV9rgzhhkYJ7+L/ylrQq6+TNZQa3F
	 HsWzvAG6jynBrm+8G5QvUgUIAodJtDJeiwVn41ssFUbr5TrcRjitkfLTqicmZi/aP0pg3
	 F/Elx8yaejscjpUi7mr0ljb+f0cs8Woz1vJqHt4em/pk/17AYrDGtYEJcGKaAIrsHsfQL
	 8v1SHD1bt4DhITkjd23xdnJbWoB/y5RmIwFUWg8xQ+VdFQ+cd51/AOkYvTXdZPdtI0BiH
	 SzTWQlF98NY0fdRG5YPvjAAdF+beCFsVvmePvGDNWAYJN2ULgrB5c1xgLxFZQ6gSjqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794458064;
	bh=RARPdGFOpymjJpoSOvkZ7QwTFzh+akN3FwghGunS9+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BulE/gYfCtsypLiKJ8csc4KWnji7SveUrDum598t8CsmeKb4HgFFNNKKyQ0Ttk0ST
	 lF+lF8085tXUCzRuF4VFAQJ5IGJwzx0t26XUIR8ti38MiPljw2zrN9xkEoVGqOAQ2c
	 Rac0NXGTwvSO69PfZSw+lZRbKkneJ3FZQKA5eFjbG8DOYpD0uV8FgH0lzs96CWlZ41
	 gh3ILec050q+uE9F61mmwcMXZ+ZDSPYo1Zhx/VRAQQtSdFgrpRQmtm4Hd5J00VSUQT
	 P1APHEhWEvTjuaXB8hnLU0B/cBtwnWRuqRqUTz20J1f2qLvv8Pt/C99Mb8RFUMK+M3
	 zziQbTnF6OiSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 198E940ABE;
	Thu, 12 Nov 2026 04:34:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 13D681399
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 04:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0510F608C7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 04:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bofIevBqWha2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 04:34:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61701608B6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-1335312-20261112043415d3e15fbfa3000207cc-7ilqcy@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=meng.ding@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=RTxMQDBd
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61701608B6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 04:34:18 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20261112043415d3e15fbfa3000207cc
 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 05:34:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=RARPdGFOpymjJpoSOvkZ7QwTFzh+akN3FwghGunS9+o=;
 b=RTxMQDBdADI8ovC2WPdHk/BquO6khlSuF/w9iJcD14LD1Q/WpUmD52lDbgUHOzR5ne8BGx
 xCEGlCZSb8N8GeM+3SZ8ztY9hRyIaQu6eK8NDmnUChRlwn7RaCA5KQLXdUi3bWCYD/v0j9Er
 /y2kK8taxTDcxmeMbgUTUn9xl4JesRDDVenzYKIzl0o6n2plX6JNtgzJirgu2LsONLMGnRAD
 UbJ/SKwBojpF7Tapnv9vACFg5zO8S3SYm3iI5lHU2q56ZZptBjrTTtyUVEYT9RhdiJT5Re7Y
 AgilNrGtYvJZS+iVdSKVNWIIYdbiE1ekVZEso+vnZuctJFKZ3g+33oTQ==;
Date: Thu, 12 Nov 2026 12:33:57 +0800
From: Ding Meng <meng.ding@siemens.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com, p@1g4.org,
 gerhard@engleder-embedded.com, Jason Xing <kerneljasonxing@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <20261110134539.12d860ef@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261110134539.12d860ef@kernel.org>
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

On Tue, Nov 10, 2026 at 01:45:39PM -0800, Jakub Kicinski wrote:
> On Thu,  5 Nov 2026 15:16:08 +0800 Ding Meng wrote:
> > +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> > +  enabled and the driver is using NAPI. This hidden configuration is
> > +  selected automatically by busy-poll support and by drivers that need
> > +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> > +  use deferred timestamp conversion must select it so the networking
> > +  stack can find the device and call its timestamp callback even when
> > +  busy polling is disabled. The struct contains also two other fields,
> > +  but they are reserved and undefined.
> 
> Just take napi_id from under CONFIG_NET_RX_BUSY_POLL instead of
> complicating everyone's lives.
> -- 
> pw-bot: cr

When BUSY_POLL is n under PREEMPT_RT && NETCONSOLE, igc fails to get RX
hardware timestamps.

Then, drivers that use deferred timestamp conversion (e.g. igc, engleder) must
specify a busy poll dependency if they want to obtain the original net
device upon consuming the skb. However, this dependency is far from
obvious, and annotating it for future features of this kind will be very
hard to discover.

Configuring the skb napi ID separately
from busy poll seems cleaner and more reasonable.
