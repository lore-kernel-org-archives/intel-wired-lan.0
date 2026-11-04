Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039E606D81A
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fkSRefRL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuwkN1h8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A708760686;
	Wed,  4 Nov 2026 06:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wl2Rn6Np6GWa; Wed,  4 Nov 2026 06:40:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 55B1360697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774412;
	b=Gt4dYHcPtVmyPLMID+gQlXRKpRFwG2udfEAfZ4o9r5+Pt0L5AFYQ+Po6Q7EUS44J1mBA
	 cCN9vBl4sOke7KnWU4C1COfJ6n1hdPhNLbtm7hxWS8nt6S5HeQFSKBlrdGsXj01BI5RcT
	 XSqIy8yY+vwMvAiNmDH+IOJnDPRPWfvIcRdjqc+zFaPbx+KyV56YOGxXkfriztucXIdvZ
	 5SvLBIW2/2nVxOaUQWJUSBKpPD9Ochi/FKkkFkXjNQCKrOy+BihILepMOacOfVuqVVIcY
	 wYq4Y0DygEly+snZ9gOdvN2WLKUWJl/hgZAFKmdOdIg8CPJDDkEWu+pKSpidUv6Fujw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793774412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=B5lc3vSTvHKXLgI0M+yJbkfam8NaeVMw9GKGtY5G8xg=;
	b=NSWCj4dcmbf4rIrPMOZQ9oCfJGkhGSgoJ3Dz4IH+Xv1MS5ypw14ZvfksW2BvmvjyAKOY
	 kYwdzV/dDDl5hT+Pkt9tfV9QeYv+HZ/3uo0ZyrNdE/cqnDLRkaZ2fY5bd8Db+yx0h6l5I
	 /2pJoySN2BtfJpexgdgS6/iYbKDu/aN9v/rPCgH1KPLN8WqIs/BHuUj/xZLC9RiGPtpVD
	 LCtN5xciFW5ms/GznauxwMkYO4p82RtuI8ByiBmxFPnx6Rw5sSZMy9WQ+b9LNLjzOgAgS
	 8TvkXNw7UdsRfDriy8XZB+Brqtdxt9kuedBmRLekCoJOZMGVpS3Leoy+uMTu7GmPRIQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793774412;
	bh=B5lc3vSTvHKXLgI0M+yJbkfam8NaeVMw9GKGtY5G8xg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fkSRefRLOoqRI8g4BYQwNOBsjvPHT2gYXT9fiDa6yPVkL6fqnTvItSR4Vh/cwZJkF
	 K/11rWYsFvoIuO2ihKAhqlp0P7LnLRfZoAXXzAkrMaLY6eHicH//uIANiHwYfOY/Xz
	 2NGx3VXpeiIwzM5mg8271ik26oeM/qcYlgIZZRRhpC89FaWY6C1vqCqFbjp9sH1/KQ
	 uJfrYD/IGbksHM5TCJZT+8ju8W65eHBNEuf6wVjZpA8hasPvSHpX7Bo77/fkTvB301
	 6KN8v5yKZlHepGbmaR6dE0ErU0Z1gNnMYb04/QlSMBszeyuJiWCO5jxngN/vZh8jx3
	 TcbJkeJHmsl3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55B1360697;
	Wed,  4 Nov 2026 06:40:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64E0A932
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56AA7401FD
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRkoyLSYmYl5 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 06:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C27764004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774408;
 b=G9uEuG93YQ1FrDyQ48YUccCRAu+6rg4GDVOGq6LA6Yi0nrXMgKVKSeffrFwjdzBZcLXs
 TF2aK9prx5ujx7DkgKzOfpCdZMjP8jICPikv7k1NuCBOZ/DrGsVtBk5jOeb9/rS7SWG+y
 FQIgq9ShmKqKttYA+wgA2cAtzxR6bDlecQRSsW75v7uw52DovEpI0xzB9VjUkFEPCIOmJ
 2nEkBmiOJEqhYoxOLYVMzlyuHqbPpG7Uq8Nn8/38msWC+wlgHQsmlpnXOoC0lj6IfYvIW
 euw4yFPLNKyfLa1bRaC+9ve4TLaMPg3BYZqUhEpMspGdligWBVoYwQMeWCJWfjZt62A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774408;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=B5lc3vSTvHKXLgI0M+yJbkfam8NaeVMw9GKGtY5G8xg=;
 b=bHzOV2kB5YNf9bKJrZItjMncfPcBBO24o9Y1wqTXfkOVyiBgkwq2loO9iiT5sPHOyx/2
 M8T797YuKOKpseP0oxPM3jTtdSExTbLPTgcyPNi29KYfqv7d2BvNESdUFk7CBeZplCtE0
 GNQkGrAr2yJv0OzbJPDgKcJcz27ISBRSxSTRsJC/0OrWODLcUjhW+8ACHDeq3Du0xJ28I
 BaBawxIRnsbEoD54Bdopplx26S/rO2pZilPMFdRmd8HuG+66QQYVBYkN0hIWcbiqOD92c
 EuQ4LS8A00ldHJ2+n9FxUIiiXzm+sDafHPK7bpJ7T64EOaK1ONHyJIhvTdLW+ahw59w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AuwkN1h8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+tkusters.aweta.nl@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AuwkN1h8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C27764004D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B69A143D75;
 Wed,  4 Nov 2026 06:40:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793774407;
 b=nsI+UOE/UQs62ynO0bisYKpy9SU2/nOnBYX5ZitZgKsFyja5n4Gjd0V3vlVtB9AkMPZK
 GeAyqphkylstJ690ZQm4/k2DYEI70sqZQH3RoW+IJ6PdGTcoziI34jfeHbKpmVLIBHX0T
 +pc9aEJQePpVV5ZlcEe5dZZ2nONB8yx+BHfOL5/cTH81S/fKYiOocL0LPw/C0N2ijGDq6
 dSv6B5+OrmM0gAjtG6P/TAN0F1dlwlpESSTSmxRm1Az0K1j6mH0exZFCwftLPp83XRTHx
 cUcUfw+5f/ES0UGLZhdeGp5QbYGwoeGGxwk5Lc/1D219Yb9xiGNOiS0DiMU4nmE97hQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774407;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=B5lc3vSTvHKXLgI0M+yJbkfam8NaeVMw9GKGtY5G8xg=;
 b=FSGuCXzLFc1XsTSMaCi3jMOlJ7BhDNaDkhT+qVBsjyfLFC2SBBYo1oT7RWqiLugDrl3M
 nhSHJejFyznriIwLakbgGlKaXhEKYKtHJIKWYmGwAZILA8VEKB7WHbgphQnz+tznn4Ho1
 70/tgckRa7Iu+Qoe+SfmezlGk9l/Qn79JRPQ0VYPBIKcvUGwKxLBDP7tsi/LJSqPB710l
 1a7ZOgbf6AU7I8gz93MlsMZnvyYYWq9uRI6AtdLZdKaSeCji9F4ytWEU5wcf3hjYZH+7w
 eaTT1L7ipMOJi571uzObpS+fX2rnzE0RMtFsPglC6/3rtGtkUYC15UcvD3fNXO6NouQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 454A81F00919;
 Wed,  4 Nov 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793774407;
 bh=B5lc3vSTvHKXLgI0M+yJbkfam8NaeVMw9GKGtY5G8xg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=AuwkN1h85EQBcyb7gL/bz8Gjizuj091A+yqhV8lAAc/RNlJYv9DSvy7u0bMluYO3R
 7Pf6mSVVh3qfpUlIT9Zsb74ml4+BPgWVVMX0wakEaAOXn1FUpijz8hC4jgRXLn06sI
 eKLnzLvP3rlmjABOBdeyX0PLMEVBMThIqqW4ldm5iBwWC/M2AMFdAkpmMICnDquB2q
 YmMP1l5KVMGxxNq+getW+hajRfF4JjjChuOLwXc8I8uNtV2F9WF0+v/txfOnykjFQ4
 fUylGvIa5PiubA7roDgjDlQUH+c0ji+IujwzRNfApvUoAhaHhUwh98QHQQne9KybEU
 k7aGo7dpPOGyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C964446CBA;
 Wed,  4 Nov 2026 06:40:05 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Wed, 04 Nov 2026 07:40:02 +0100
Subject: [PATCH net v5 1/4] igb: do not let XDP frames span more than one
 Rx buffer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-igb-rx-ts-fix-v5-1-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Sven Auhagen <sven.auhagen@voleatech.de>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>, 
 stable@vger.kernel.org, Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793774404; l=13985;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=fRCfOfr/7aojxs01zFpAF9Pls2KaBRj14KhPc+FAN/o=;
 b=TgdC5jA3XN178qHtf9M7JUzw2jOsPZYBXi3Fhum7jDfc0YzUyug5oOA78Q3nGWHFpMUXQAe6B
 6ZTBFL0/k39BbaQ/vvfjE9DJYaSkQKCX7E6FJI944KPLUISwnf/z5ws
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Content-Transfer-Encoding: 7bit
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
Reply-To: tkusters@aweta.nl
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tjerk Kusters <tkusters@aweta.nl>

igb does not support XDP multi-buffer: igb_xdp_setup() only accepts an
MTU whose frame fits in one Rx buffer, and the XDP program only sees
the first buffer of a frame. The maximum receive length is not limited
accordingly, though. RLPML is only lowered when the frame fits a
build_skb buffer on systems with PAGE_SIZE < 8192 and no VFs. Otherwise
the MAC still accepts frames of up to MAX_JUMBO_FRAME_SIZE while XDP is
attached, for example at MTU 3000 on 3 KiB buffers, and at any MTU when
PAGE_SIZE >= 8192. With VFs allocated, RLPML always stays at
MAX_JUMBO_FRAME_SIZE and the PF pool limit in VMOLR is only lowered for
frames that fit a build_skb buffer, so the same happens at MTU 3000.

Such frames span several descriptors. When the program does not return
XDP_PASS for the first buffer, no skb is built, and igb_clean_rx_irq()
handles the next buffer of the same frame as the start of a new frame:
it runs the program on it and may pass it to the stack as a bogus frame
made from the middle of the original payload.

Limit the receive length to the configured maximum frame size while XDP
is attached: in RLPML when no VFs are allocated, and in the PF pool's
VMOLR otherwise, as RLPML then has to stay large for the VFs. Larger
frames are dropped by the MAC.

Also make sure that the limit holds:

- Leave room for the inline Rx timestamp header when checking that the
  frame fits in one Rx buffer, on XDP setup and on MTU change, where the
  limit is the hardware buffer size. This lowers the largest MTU
  accepted with XDP by 16 bytes: from 3046 to 3030 on 3 KiB buffers,
  and from 2022 to 2006 with legacy-rx or PAGE_SIZE >= 8192. Setups that
  use XDP at those MTUs will have to lower the MTU. The build_skb frame
  limit used with 2 KiB buffers is kept, so XDP still attaches up to MTU
  1510 on x86. The header is only prepended by 82580 and later MACs; the
  room is reserved on all MACs for simplicity.
- Base that check on the buffer size that igb_set_rx_buffer_len() will
  select, not on the ring flags, which are only updated when the rings
  are configured and can be stale on an interface that is down. As a
  result, an MTU change with XDP attached can now also move from 2 KiB
  to 3 KiB buffers. The check is skipped when XDP is removed.
- Refuse XDP while rx-all is enabled, and keep rx-all off while XDP is
  attached, as the MAC then also stores frames longer than RLPML. If
  rx-all was requested meanwhile, it is turned on when XDP is removed.
- Refuse to change the legacy-rx private flag while XDP is attached, as
  that changes the Rx buffer size without checking it against the MTU.
- Program both limits from igb_configure(), which only runs while Rx is
  stopped, and no longer from igb_set_rx_mode(), which can also run
  without RTNL, for example on an IPv6 multicast join or a VF mailbox
  request. Otherwise such a call during an XDP removal or an MTU change
  could apply the new limit while the rings still use the old buffers.
  Attaching or removing an XDP program on a running interface goes
  through igb_close() and igb_open(), and an MTU change through
  igb_down() and igb_up(), so igb_configure() runs in both cases.
  igb_set_rx_mode() still updates other bits of the PF pool's VMOLR, so
  the limit there is changed under the address lock.

This follows the same approach as the igc fix that limits RLPML while
XDP is attached. As before, the PF pool's VMOLR is not written on i354.

Tested on an I350 at MTU 3000 with Rx timestamping on and xdp-filter
dropping all IPv4 from the peer: 8242-byte frames are now dropped by the
MAC (rx_long_length_errors), instead of their last two buffers being
delivered as a separate frame. XDP attach at MTU 1500 and 3030 still
works, at MTU 3046 it is refused, as is an MTU change from 3030 to 3046
with XDP attached; an MTU change from 1500 to 3000 with XDP attached
now works. With XDP attached, rx-all stays off and the legacy-rx flag
cannot be changed. XDP attach is refused with rx-all on, and at MTU
3000 with legacy-rx on, also when the flag was set while the interface
was down. MTU changes between 1500 and 3000 with XDP attached, while
the peer sent 3000-byte zero-payload frames, let no frame through as a
separate frame.

With two VFs allocated, the same frames are counted by the MAC but
dropped by the PF pool limit in VMOLR before they reach the Rx queue;
without this patch their last two buffers are again delivered as a
separate frame. Read back from the registers, RLPML then stays at 9728
and the PF pool limit is 3026 at MTU 3000 and 1526 at MTU 1500 with XDP
attached, also after each of about 200 MTU changes.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c |   9 ++
 drivers/net/ethernet/intel/igb/igb_main.c    | 146 +++++++++++++++++++--------
 2 files changed, 113 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index f7938c1da835..4f2891fca282 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3438,6 +3438,15 @@ static int igb_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 		flags |= IGB_FLAG_RX_LEGACY;
 
 	if (flags != adapter->flags) {
+		/* the Rx buffer size depends on this flag, see
+		 * igb_xdp_setup()
+		 */
+		if (igb_xdp_is_enabled(adapter)) {
+			netdev_warn(netdev,
+				    "Cannot change legacy-rx while XDP is attached\n");
+			return -EOPNOTSUPP;
+		}
+
 		adapter->flags = flags;
 
 		/* reset interface to repopulate queues */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00ec0..8abdd4e58550 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1964,6 +1964,54 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)
 		   "enabled" : "disabled");
 }
 
+/**
+ *  igb_set_rlpml - set the receive length limits
+ *  @adapter: private board structure
+ *
+ *  Called from igb_configure() while Rx is stopped. igb_set_rx_mode() can
+ *  also run without RTNL, so it does not change these limits.
+ **/
+static void igb_set_rlpml(struct igb_adapter *adapter)
+{
+	u32 rlpml = MAX_JUMBO_FRAME_SIZE, pool_rlpml = MAX_JUMBO_FRAME_SIZE;
+	unsigned int vfn = adapter->vfs_allocated_count;
+	struct e1000_hw *hw = &adapter->hw;
+	u32 vmolr;
+
+#if (PAGE_SIZE < 8192)
+	/* restrict as needed to support build_skb */
+	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB) {
+		pool_rlpml = IGB_MAX_FRAME_BUILD_SKB;
+		if (!vfn)
+			rlpml = IGB_MAX_FRAME_BUILD_SKB;
+	}
+#endif
+	/* XDP does not support frames that span more than one Rx buffer.
+	 * With VFs the global limit stays large and the PF pool is limited
+	 * through VMOLR.
+	 */
+	if (igb_xdp_is_enabled(adapter)) {
+		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
+		if (!vfn)
+			rlpml = min(rlpml, adapter->max_frame_size);
+	}
+	wr32(E1000_RLPML, rlpml);
+
+	/* the PF pool's VMOLR is used on these MACs, see igb_set_rx_mode() */
+	if (hw->mac.type < e1000_82576 || hw->mac.type > e1000_i350)
+		return;
+
+	/* igb_set_rx_mode() also updates this register, and the core calls
+	 * it under the address lock
+	 */
+	netif_addr_lock_bh(adapter->netdev);
+	vmolr = rd32(E1000_VMOLR(vfn));
+	vmolr &= ~E1000_VMOLR_RLPML_MASK;
+	vmolr |= pool_rlpml | E1000_VMOLR_LPE;
+	wr32(E1000_VMOLR(vfn), vmolr);
+	netif_addr_unlock_bh(adapter->netdev);
+}
+
 /**
  *  igb_configure - configure the hardware for RX and TX
  *  @adapter: private board structure
@@ -1981,6 +2029,7 @@ static void igb_configure(struct igb_adapter *adapter)
 
 	igb_setup_tctl(adapter);
 	igb_setup_mrqc(adapter);
+	igb_set_rlpml(adapter);
 	igb_setup_rctl(adapter);
 
 	igb_nfc_filter_restore(adapter);
@@ -2468,6 +2517,14 @@ void igb_reset(struct igb_adapter *adapter)
 static netdev_features_t igb_fix_features(struct net_device *netdev,
 	netdev_features_t features)
 {
+	struct igb_adapter *adapter = netdev_priv(netdev);
+
+	/* with rx-all the MAC also stores frames longer than RLPML, which
+	 * XDP cannot handle
+	 */
+	if (igb_xdp_is_enabled(adapter))
+		features &= ~NETIF_F_RXALL;
+
 	/* Since there is no support for separate Rx/Tx vlan accel
 	 * enable/disable make sure Tx flag is always in same state as Rx.
 	 */
@@ -2886,6 +2943,27 @@ static int igb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
+/* Check that a frame fits in one Rx buffer together with the inline Rx
+ * timestamp header, for the buffer size igb_set_rx_buffer_len() selects.
+ * The ring flags are only updated when the rings are configured, so they
+ * are not used here. For build_skb rings the frame is limited to
+ * IGB_MAX_FRAME_BUILD_SKB, which is below the 2 KiB hardware buffer size
+ * even with the header.
+ */
+static bool igb_xdp_frame_fits(struct igb_adapter *adapter, int max_frame)
+{
+#if (PAGE_SIZE < 8192)
+	if (!(adapter->flags & IGB_FLAG_RX_LEGACY)) {
+		if (max_frame <= IGB_MAX_FRAME_BUILD_SKB &&
+		    !IGB_2K_TOO_SMALL_WITH_PADDING)
+			return true;
+
+		return max_frame + IGB_TS_HDR_LEN <= IGB_RXBUFFER_3072;
+	}
+#endif
+	return max_frame + IGB_TS_HDR_LEN <= IGB_RXBUFFER_2048;
+}
+
 static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	int i, frame_size = dev->mtu + IGB_ETH_PKT_HDR_PAD;
@@ -2894,17 +2972,21 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 	bool running = netif_running(dev);
 	bool need_reset;
 
-	/* verify igb ring attributes are sufficient for XDP */
-	for (i = 0; i < adapter->num_rx_queues; i++) {
-		struct igb_ring *ring = adapter->rx_ring[i];
+	/* with rx-all the MAC also stores frames longer than RLPML */
+	if (prog && (dev->features & NETIF_F_RXALL)) {
+		NL_SET_ERR_MSG_MOD(bpf->extack, "XDP is not supported with rx-all");
+		return -EOPNOTSUPP;
+	}
 
-		if (frame_size > igb_rx_bufsz(ring)) {
-			NL_SET_ERR_MSG_MOD(bpf->extack,
-					   "The RX buffer size is too small for the frame size");
-			netdev_warn(dev, "XDP RX buffer size %d is too small for the frame size %d\n",
-				    igb_rx_bufsz(ring), frame_size);
-			return -EINVAL;
-		}
+	/* verify igb ring attributes are sufficient for XDP, leaving room
+	 * for the inline Rx timestamp header
+	 */
+	if (prog && !igb_xdp_frame_fits(adapter, frame_size)) {
+		NL_SET_ERR_MSG_MOD(bpf->extack,
+				   "The RX buffer size is too small for the frame size");
+		netdev_warn(dev, "XDP RX buffer size is too small for the frame size %d\n",
+			    frame_size);
+		return -EINVAL;
 	}
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
@@ -2935,6 +3017,10 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 	if (running)
 		igb_open(dev);
 
+	/* rx-all may have been requested while XDP was attached */
+	if (!prog && (dev->wanted_features & NETIF_F_RXALL))
+		netdev_update_features(dev);
+
 	return 0;
 }
 
@@ -5323,7 +5409,7 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned int vfn = adapter->vfs_allocated_count;
-	u32 rctl = 0, vmolr = 0, rlpml = MAX_JUMBO_FRAME_SIZE;
+	u32 rctl = 0, vmolr = 0;
 	int count;
 
 	/* Check for Promiscuous and All Multicast modes */
@@ -5380,14 +5466,6 @@ static void igb_set_rx_mode(struct net_device *netdev)
 				     E1000_RCTL_VFE);
 	wr32(E1000_RCTL, rctl);
 
-#if (PAGE_SIZE < 8192)
-	if (!adapter->vfs_allocated_count) {
-		if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-			rlpml = IGB_MAX_FRAME_BUILD_SKB;
-	}
-#endif
-	wr32(E1000_RLPML, rlpml);
-
 	/* In order to support SR-IOV and eventually VMDq it is necessary to set
 	 * the VMOLR to enable the appropriate modes.  Without this workaround
 	 * we will have issues with VLAN tag stripping not being done for frames
@@ -5399,19 +5477,10 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	/* set UTA to appropriate mode */
 	igb_set_uta(adapter, !!(vmolr & E1000_VMOLR_ROPE));
 
+	/* keep the receive length limit set by igb_set_rlpml() */
 	vmolr |= rd32(E1000_VMOLR(vfn)) &
 		 ~(E1000_VMOLR_ROPE | E1000_VMOLR_MPME | E1000_VMOLR_ROMPE);
 
-	/* enable Rx jumbo frames, restrict as needed to support build_skb */
-	vmolr &= ~E1000_VMOLR_RLPML_MASK;
-#if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-		vmolr |= IGB_MAX_FRAME_BUILD_SKB;
-	else
-#endif
-		vmolr |= MAX_JUMBO_FRAME_SIZE;
-	vmolr |= E1000_VMOLR_LPE;
-
 	wr32(E1000_VMOLR(vfn), vmolr);
 
 	igb_restore_vf_multicasts(adapter);
@@ -6707,19 +6776,12 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
 
-	if (igb_xdp_is_enabled(adapter)) {
-		int i;
-
-		for (i = 0; i < adapter->num_rx_queues; i++) {
-			struct igb_ring *ring = adapter->rx_ring[i];
-
-			if (max_frame > igb_rx_bufsz(ring)) {
-				netdev_warn(adapter->netdev,
-					    "Requested MTU size is not supported with XDP. Max frame size is %d\n",
-					    max_frame);
-				return -EINVAL;
-			}
-		}
+	if (igb_xdp_is_enabled(adapter) &&
+	    !igb_xdp_frame_fits(adapter, max_frame)) {
+		netdev_warn(adapter->netdev,
+			    "Requested MTU size is not supported with XDP. Frame size is %d\n",
+			    max_frame);
+		return -EINVAL;
 	}
 
 	/* adjust max frame to be at least the size of a standard frame */

-- 
2.27.0


