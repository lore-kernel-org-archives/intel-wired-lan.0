Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAC606A336
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=T6SByk9v;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=rpoke7kI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 638CB60785;
	Mon, 23 Nov 2026 16:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MS-lUYR7riIg; Mon, 23 Nov 2026 16:24:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 312A060794
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451092;
	b=cB9jFZE/+myQA39w1DAJxnIjoQ9gm9NeZfygnaU8uLKRltSYOCikj6Snf5EH17o4wtbf
	 EZmOInza7h9UZ0jcrC6T+vJ4BlN2LOmhVY1DeOEBhIf3nMXqD/O/NQ/F1qd8F7DWkW8qU
	 d715GHQF88ssHwbzsehJPq5w9p4yNjSF/07dDSWfbFeHzWcOlUWosY6Yc2e/eQWSXKo03
	 dUhiBqQtvi149a3LBWHLJxWEH7NBrBwwJIwYN2t88DHpZm97bKZXTzId4ppDn/NbBqwci
	 XAxuEE6Y9jOqPIguYGW8D4ylGVDbszVVmAiR4uOBTL2/b4oHbR2gZd9N+bLhgGVxJSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eoP3hjAwq4Cw4bE/mFqEl7hyxh+jDCjYeuZjTBgdVoA=;
	b=Rmn7HCgioknhgjMprXJh0yh3XyNQ3XtisBGGOJwQPkdMHSWHMkEQWs3TKSzNcqS6vxi2
	 J1MU7M61zPouQeL+FhyPvJVxaG8Ef2qlZsd1dNE9AJL3o8rauWzBr8qksAXVL+Ff/YbK+
	 a6gcUdyUsGHB6Zn3UEoBc+4JEgVQ+v8NoToe/0txMvkCbWEzq1BqRFRznY7jlf1eEdpxM
	 XMlCpqXn9Z2UcW87uLmo/ZJZFKONbRZHydmYCncPeJGHnh5Vub+MTBxMrCxN5JbukiFh3
	 UmC16BOnR5/p0AWPbasfzeAPDYhTpS/1ogA7YvZ9MVaicqYQya46iQOlJ9JiMACpgXA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451092;
	bh=eoP3hjAwq4Cw4bE/mFqEl7hyxh+jDCjYeuZjTBgdVoA=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T6SByk9vvvvhAs1DpVD6+t6ATxsbukUOuGsz63xRKFXHUMFEFksLZCBA3rPGmdHDI
	 4UrK/IcxeHr0yD2gYVJLrOw4UDWxPOIdt2YO79M8tGDU4jCO0RK4ImysRon98p9xV8
	 hRD5eDVWX5ibqESzPUnTTwLiu0Dlhxumft47a0FNPeGlpppeZjlRCa8H1D0pAST54w
	 Li7BdsdUbedUzCH4HD9ac5S70kLW1R14ZRx2KKcMpxpXR30ggt2wOu8S9k1vy/Ey5P
	 KSCV1k6aEfim5vRAKVfVXE9w3tbPbClyG6rCekp1VS3Gd/I1Xs0doK6UsH1/uhQgzj
	 d0y1qUDi7h6Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 312A060794;
	Mon, 23 Nov 2026 16:24:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A12E4260
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 13:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 878D640176
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 13:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZHJza-1IGQw for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Nov 2026 13:27:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 70D24400FC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.109
X-Greylist: delayed 378 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 22 Nov 2026 13:27:18 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=rpoke7kI
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.109;
 helo=mail-106109.protonmail.ch; envelope-from=toresbe@protonmail.com;
 receiver=<UNKNOWN> 
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70D24400FC
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795353654; x=1795612854;
 bh=eoP3hjAwq4Cw4bE/mFqEl7hyxh+jDCjYeuZjTBgdVoA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=rpoke7kIbufv5EUE+v6QP9RKHaLv9d1qKHGkUFy0dbwBonBukYa4BaGXbmrm8WNVk
 m3uZZVey1t5mFukibLbam0SOEw8fBIt9sylsw0uynTm0vxf+RwueirbLJyiaScBMAl
 HVux3Ir16vSZ+lRQkEZ6T7U23zaAoORLPgu+3vJEFhv6hHMyWEOLoQMbvKLOLikTzQ
 LNmBXVTBRkdMVelcTB6RDEZpUzWwV3HA6hxJ+jdK7l8ie/oa6t1e6mvHjCFdz0J90y
 Ut6Rj2s11nbcT9bZcjbP5JHte8w3FaHTm9YqSHy9So6y5/tbfcchZf+3aj+EubmQJ+
 XmD2bDeMu9Eew==
Date: Sun, 22 Nov 2026 13:20:46 +0000
To: Tjerk Kusters <tkusters@aweta.nl>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Sven Auhagen <sven.auhagen@voleatech.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
From: Tore Sinding Bekkedal <toresbe@protonmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>,
 stable@vger.kernel.org, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Nowlin <alexander.nowlin@intel.com>
Subject: Re: [PATCH net v7 2/3] igb: only strip Rx timestamp header on the
 first buffer of a frame
Message-ID: <d1cec124-8685-4be9-ae70-1142e3be4f88@protonmail.com>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-2-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
 <20261120-igb-rx-ts-fix-v7-2-63b03045978e@aweta.nl>
Feedback-ID: 21125876:user:proton
X-Pm-Message-ID: 687ed69b38c3864e14592e27266a6843882b0919
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Nov 2026 16:24:50 +0000
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 12:10 PM, Tjerk Kusters wrote:
> This is easily triggered by a GigE Vision camera streaming dark frames
> (mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
Mostly commenting to make this thread searchable -
We ran into it on a Ceph cluster: Proxmox VE hosts (kernel
6.14.8-2-pve) with Intel I350 ports in an LACP bond at MTU 9000.

Enabling chrony's "hwtimestamp *" put the ports in HWTSTAMP_FILTER_ALL,=20
after which jumbo frames arrived 32 bytes short (tcpdump: "total length=20
9000 > length 8968") and were dropped. Small packets were unaffected, so=20
  Ceph heartbeats kept passing while OSD traffic stalled, reporting=20
laggy PGs and slow ops.

Note that removing hwtimestamp from chrony.conf and restarting chrony=20
did not clear it; the ports stayed in HWTSTAMP_FILTER_ALL (using ethtool=20
-T") until the filter was explicitly set back to NONE.

Thanks for the fix.

