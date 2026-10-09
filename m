Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98264CA9EC3
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72A58814BE;
	Fri,  9 Oct 2026 21:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvnPolLWFXf0; Fri,  9 Oct 2026 21:04:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B16B1814B1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579848;
	b=FMa96fc9TjMBaSY1qEEFn9JIVXezrMEWXHJC7rKyCJvl0XgOOS4ZLxhRpWVHL9ONR4sU
	 5lQEfKpcH/G4zRaZuMWHDoK2xMS6wf7BTkfCsUxyh+RGVqpnQYtzl/JUvFhqoxA45b/wE
	 bMNmJdRB5nDb0uhj7Y9Blu/7u/qf+1DrpEnqxWp6Orceq9JXZ/kTRjKkt3qPhxgagMCrD
	 eug6lqgvnvCB3RqBjRF6wMhhGWx63YaiHnIqRvtXlk40u2+ls/PPu0uICst4Cx7njEUa2
	 S+FV/xLDqGvbPQ9sDQM3JjGF6LW0pMy2lTtrdgfyDdSIh0rMixytZzWG9K2Gty7k4jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=JRexz9Q2fxs/thx2XS+PjoYVg8EBojt+iaReWmzmF5M=;
	b=CH83cyHRApc3hbLr7gG2roSlKIwjdMeflUI9nnmdkDvEsNUra0Ed3QDNDzEaOsLr4upR
	 QshoEv0Yzep5TkB3tXw3+5XHVlh33ZzwgFxV92+CLBGw2iCFN6Krh/099hGLvOSOj3/YH
	 ZFQXNY9UoX3QFaUNYRfkyBStdBYQ98r8maMDRlmiQ5EmVHuMU4GenujDOCj+kSK9+F1v5
	 NuNP8/3bLGmyJc7QdvYjOgZa+XQwcOaBehXZ2fDHf1QZNpB/StcgfotTsDOhJ0USL858I
	 8cdxDO7Q1tmbm9I3rQeFgxItpa7rrluZz0ijvRmQYUEm18BoiAu1p9cyeP8/msG2hag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579848;
	bh=JRexz9Q2fxs/thx2XS+PjoYVg8EBojt+iaReWmzmF5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=5BzhGzKfXQWWuQYuH1MOW5JVNSoEpJimveO5HhIrjMN8nGsfRuFJk6N3isZw8kLDU
	 Y2GDWFSnVVvKQ8ncIpEucZ7MM7i+gZKmrUBYmJKMJIh/X6/gg8kt4CSJlJLAODF9gW
	 7OVYfNVqQsDFbN7dvX4zsP26mjBoBRkanMU1nM8np61UKxvzflEbsZhKWe93fCeLo8
	 P9U7vh/cqLtLYryfpXmUUKxQKYbV11YuR9VV9RvVwAeWwxqFXWHeMMl8qcrc/rF2Je
	 8RRirHJJWhM9Pxz51EF45+2GxQwXh8gVFa/JfJcOklR0INt+LK0Tfxfi0VnXY2pqik
	 0lx9+kk2t6EKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B16B1814B1;
	Fri,  9 Oct 2026 21:04:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 118001DE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBFBB4018C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C2OPV8KyUfaq for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3250B40080
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579845;
 b=Ahwtel6kwWU41odqi+QKsYWkQUHmxbHT3ythjXbbDQuLjBA/pi3NfLgwfIPNW/k20ZYT
 i9xNORiXiK+HgbBFI4Wvufsc4YYIjTqlvdBzyfoxEXyr/menUXRKOMZ87wHYCwN5NGVfo
 QXfXddiJo5s8JMHX1ajBjBnw8imslIx45l5mUkPxpwR0XUCRxhKDFhOH5eAnvl/rq6zXb
 sJfJcDpjHwgtM5MEQldc9PXwwHVmh1UGNeMgkrma44UVg5usmTvQJcaoxY4UNLkpzflkU
 nhF3lQoM/153isj0e9x/TT5Umc6vBNjUB4Rw7JQnTeBBv3WZ1MmHObKZ1y8HSIIZkyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579845;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=JRexz9Q2fxs/thx2XS+PjoYVg8EBojt+iaReWmzmF5M=;
 b=Gc0L3/jUsgSnHG1U6Kb9ZN4R++tsp0BgZs5EnaB3OAvt5C+Gt1yUi6Y5kFASKqB1VPC5
 8cJFCjN8KGZoqPl3LPUUNakjOXgLY9OXy8OVTKw7lpO9MaiMmK4dazRTQoOiDU2gP9qTs
 +Ixt0c25mkjmtSCYWvPI5+4SzU1cQArLsJzsdIpgPFfXHtTlEoV2+AmwyCeBXCCn7jIQU
 I+5f5LjGDdz+EaEbLrlPOJVexSTFvXNj2qUJhbjPCKzyF6vuEnOw2ZXK4lmPRJdfVaglf
 VB75CCS/xIQs49suxy6SX/xO4MCXoNHIjyZtqjHigZKAW9KlYNld+cVPsGjkayxNFdw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NwRmkA7C; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NwRmkA7C
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3250B40080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15F1A60200;
 Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858801F00893;
 Fri,  9 Oct 2026 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579843;
 bh=JRexz9Q2fxs/thx2XS+PjoYVg8EBojt+iaReWmzmF5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NwRmkA7CZm4yWxVgYi5BIZgFFBEQS7cycww/zxM/tN/cEiEkFDnMfoPc/ny2uTcIU
 Jv8b40JyLfCcEye8mB8MY2kL7u5xtjCnx5u3uqNS459/AAuv5r/TRHQOebbG9R11Ts
 J7SbEM3kcl1dEOaUptWu9qwmMpPQxkRGiJ2lqnD9c5np5vy2HtC+I5WvL5EcI4tdoH
 m60lOs1+9qUSal5J/P7cEcy9Il57DSpPPOecePkuWgYrAAv6avLpDjULRjhNKXrqsk
 aQku6bdSFH3NMF6lxoKK7eA7opYtlEyuFyLATx0VosLzyAUBsz2FmCJUPr5TMaiV+w
 EUxQduYXhffdA==
Message-ID: <sashiko-outbox-166075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 08/10] netxen: use pskb_may_pull() to pull
 excess TX frags into the head
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-8-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-8-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:04:03 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

> netxen_nic_xmit_frame() pulls the frags that don't fit in a TX
> descriptor into the head with __pskb_pull_tail().  It already checks the
> result.  Switch to pskb_may_pull(), which takes the length the head
> should end up with and checks it against the skb, so this driver no
> longer calls __pskb_pull_tail() directly.
>=20
> __pskb_pull_tail() also releases empty frags, even when there's nothing
> to pull, so if the frags being pulled are all empty it still gets the
> frag count under the limit.  pskb_may_pull() returns early in that case,
> so follow it with skb_drop_empty_frags().
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D8

