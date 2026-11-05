Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCB606A329
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VssbamS9;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0s9R5+V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25D1580FA9;
	Thu,  5 Nov 2026 08:04:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIIskeHME7zr; Thu,  5 Nov 2026 08:04:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 41EBD81062
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793865852;
	b=bA3eVflIUg6KU/ckc8V7HZl5ub+gTvO3V1vaDapjN5Cq+gcB4wqOqPhsUtQwS71piohs
	 ajaVn+la4ticSXCFRJl1ndNLrwBSKKtrJNXQE1zmzlxVbbu4HazoskeH0oxsJdpeaQVcF
	 vwoQ1ihLL2nySAwI8NyoqhU2wTb0GXutEGYr0TjWqpXiNot2nJhNmHZzpZ3a3oEnNmL10
	 oBObpmCM5VFhxmtT/w8KgimO1EMFzxiFRqSWPC1HH69cVcebc48ROsj8w7qXP+YsQYk41
	 Ck0QF3/G4p7TuDm9ZAsBCJaQlauUFq9RnsTjiGhMpe2s/HOoEl1LqIdytIP/6yCwiRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793865852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q/IVcg5Dvv6LOmALB64d6dD3OE6L0hYQ//UPgDGID20=;
	b=Rs1Ct0nKqQcDXVSS+pplgG+3WRq9ZKaX7PCeIBvjCHRXYMs8CPsej8VVKV8H3hvsHD8d
	 W9814rOzXHFAq4bqBRZLQcApjA2s9aW4b38bmp7dq1+O6ZXOvQDWOZYiZkwy/7s4dpt5I
	 vOYZbEO1Fc720TzgMkoWevZC9C7LRQ0VKEexrkCp8RiI+Whj4VLYqapkoq2GUwlNePFpj
	 BPn38mmtaHx4memNLMMSM09pWrp5AZjpRE77DebMv5EWpXwk0cc7JgdKwA6EX8q95tvA6
	 2fIBNvtYtJaZJb+Cver6Qz+p8TaVV+kSJemLa2M8I8m28tMgsXdmXkZdPNkK4Xt9B9A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793865852;
	bh=q/IVcg5Dvv6LOmALB64d6dD3OE6L0hYQ//UPgDGID20=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VssbamS9nsqsZjmUEU4qVsOcIgHkmi+IvLa5hsEBHdbwsBCVErvG31nb2o/k0coS+
	 9IxMG9/7Z4mLzlousMqgU6mIhkUXxfGAOsRV5kZXZk58c28J6sTcX/1anV9X6aMpEp
	 boXwohQTnn0Fo5Dl2Ls0jkFs2zb6e+BDMh93nS0PKlMZPVbhLHvKnZs6ZUppMLInDb
	 ml9Au5kMqlsgHkyBJfQU5ECW+R2qmiQoLSVFCs/g55gIix7+LuW2wDZ6nMKJnd9To+
	 EN3aMh3o6lbhrHqO8vc8Eacz/uG+oa2n1UbY7IO5gQy/zRjkJ53qvXki+tN7bFDPUN
	 1H/lYMkMaonnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41EBD81062;
	Thu,  5 Nov 2026 08:04:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5550F31F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 08:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AFC0606D3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 08:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YT3hVlyfsvtp for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 08:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B87E6061C
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=bot+bpf-ci@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=i0s9R5+V
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B87E6061C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 08:04:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DE33601DE;
 Thu,  5 Nov 2026 08:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C4C1F000C1;
 Thu,  5 Nov 2026 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793865847;
 bh=q/IVcg5Dvv6LOmALB64d6dD3OE6L0hYQ//UPgDGID20=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=i0s9R5+VoRkAyQcEkiiUSRvQre+yA4sOH9fDaHC0EOsXo37zcoE9Pu93SmqW5y6M9
 75jwKmAN9cwZB2AEDjBioMQU9MJ5tzC5d0tYeDbV565Fjhw8S3rZYG+MkzTgeorTT+
 4UMSo0iYWRRvbFNzsX3Vt9vWRu9PKes66PuVrqq79ybHVRb1WR8VgtrqTUM0cLNXrJ
 MoF9QMHIooi5VprLbqzXWN7/JlqNxYcejkoO9vpHEh4nA+2OXJ0GElPA1Ko3ZzMX9m
 JTIy/SvOw0ysGRZQyJxCgCAGeXiC1mDX545zFGFkBkHl3uzf+8CAlPBPGa/uvfengH
 nhP60WqCq3guQ==
Content-Type: multipart/mixed; boundary="===============1261712251123050467=="
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <4c0a0855167cac39dcf8b1c103d0f98a8898a14866daf9b97a127698bb1ea0b9@mail.kernel.org>
In-Reply-To: <20261105071706.7043-1-meng.ding@siemens.com>
References: <20261105071706.7043-1-meng.ding@siemens.com>
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
From: bot+bpf-ci@kernel.org
To: meng.ding@siemens.com, netdev@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, rostedt@goodmis.org,
 mhiramat@kernel.org, daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, richardcochran@gmail.com
Cc: florian.bezdeka@siemens.com, jan.kiszka@siemens.com, wq.wang@siemens.com,
 p@1g4.org, gerhard@engleder-embedded.com, meng.ding@siemens.com,
 kerneljasonxing@gmail.com, horms@kernel.org, skhan@linuxfoundation.org,
 rdunlap@infradead.org, mathieu.desnoyers@efficios.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 08:04:07 +0000 (UTC)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1261712251123050467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> net: mark skb NAPI IDs independently of busy polling

TL;DR: Commit message only: it blames e68b6e50fa35 for gating skb NAPI IDs on
busy polling, but that gating predates it; 97dc7cd92ac6 introduced the
dependency. Suggests rewording.

>     net: mark skb NAPI IDs independently of busy polling
>
>     Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
>     added support for deferring RX timestamp conversion to
>     ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
>     uses the skb's NAPI ID to find the device that owns the timestamp
>     cookie and invoke its callback.
>     Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
>     gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
>     when busy polling is disabled, the skb may not carry a usable NAPI ID.
>     The device lookup then fails, so the driver callback is not invoked.
>     get_timestamp() falls back to hwtstamp, which does not contain the
>     converted timestamp, resulting in an incorrect RX hardware timestamp.
>     Record skb NAPI IDs independently of busy-poll support to support
>     drivers that use deferred timestamp conversion and future driver
>     features that need to look up a device by its NAPI ID.
>     Signed-off-by: Ding Meng <meng.ding@siemens.com>
>     Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

This isn't a bug, but is e68b6e50fa35 the right commit to name here?

Before that commit, __skb_mark_napi_id() / skb_mark_napi_id() was already
inside '#ifdef CONFIG_NET_RX_BUSY_POLL' with an empty stub in the #else
branch, and struct sk_buff already had napi_id under
'#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)'.  That gating
goes back to 8b80cda536ea ("net: rename ll methods to busy-poll").

e68b6e50fa35 only moved the socket-side sk_mark_napi_id() out of the ifdef
block and added sk_mark_napi_id_once().  Both act on sk->sk_napi_id, not on
the skb.

It is also about six years older than 97dc7cd92ac6, so the message reads as
if a later change broke the deferred-timestamp lookup.  In fact
get_timestamp() has depended on a busy-poll-only skb field (skb_napi_id()
returns 0 when CONFIG_NET_RX_BUSY_POLL=n) since 97dc7cd92ac6 added it.

Could the message say that the skb NAPI ID was always busy-poll-only and
that 97dc7cd92ac6 started depending on it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41989099174
--===============1261712251123050467==--
