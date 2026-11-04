Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F2606A330
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Yr3n3x36;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuXFvwm/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B8BC4064A;
	Wed,  4 Nov 2026 08:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xsap6cPlTnn; Wed,  4 Nov 2026 08:11:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 38DCE4064B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793779900;
	b=cb6FnOogebKvxhZ/ghLufflIR7IekGj69c/L6fcV07775rIsyY1g5JTHzcT4Z2BnUQtP
	 BB7fxrhX0olDV6194OtKzNRoJ7jw700SOR6dw7RQBRjIlN/hSPVkRnNTvZtdsdP3C5hbm
	 GQApm3fFVj6wsLpumtPuHznAVOzBDL/PAnJvsNClXsF7kChjukyzeKXlpvlZrd0znwpn7
	 sZ3dEJnWls4QEURCHaHxTP6z2XCTFxDeyhEN2tKlvl5GjXxK+0u12Xle8/V23hVGg/AJm
	 rtBer99/eMotdSw+ve+FDwYD1gogfYnTNQpQOeQeZ23yZW767cBa7q9Ri0+oR7YyZlA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793779900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=MLhpiOQq+BcLHoXpwFBleckIHcU5aB2HxUSVZEWSQXc=;
	b=sGwRAiiPScQbzwS5VIajx8y559KC7E8MFKivKsfvrVZeBqtm3LixwZqXknhAWvKt/4SS
	 lShzvS4oRDFYBL/lKHMb2rj6wOKtKQHR9QZybCZib94S3qgBXlov62v8R+xCSt4sJ9AT3
	 zVHPO3k/PHtHcIPYzrVbkAPyc8IDrZyKQ4tZa4XXotJzmRJjGvo0w7zQVldxR7eEjrvbB
	 KqEmKcH+w1GokCrXxjCQG1F8wmPy8FASeQL58+QfcPQ5l6NbJbYL7gVZtoCLC9HgXHAIz
	 tKlvpF5rJ0LuTNJcpvErVw/sLYNekjQnFdyd3Ah/dUwNjFTWcTf6MiwRChbzsSZhJAA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793779900;
	bh=MLhpiOQq+BcLHoXpwFBleckIHcU5aB2HxUSVZEWSQXc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Yr3n3x367lE13dhL1QAt+0RxaetgmS7nuH92gdwLZPCwHWzP1XjNqSjintFo5gbek
	 EKW1OOHTZXdSxzW3JBekMcjfMLGl4sxrUYhAXO0OC3VJB13Pt8QKwUy0OFFETVC3rz
	 7cLA31xMfOWOgr7Myijk0N9sCXAbvLnSU1DGRI/q3Slk0+CWgV8askQJtlhXyF+IXA
	 lUmD9qUHwUQoGcHpY4T7DLuPotaL/broNMsuenN6bbi77iddr8qYu/hd8iEEFrChsW
	 BhmYKtxHfjuGtKLbrzCt9KICSU9ocVoi9S+FoiN5OCjTw4TfsB8TE951Pz/EBKkRcp
	 UvOoDyPeEbc3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38DCE4064B;
	Wed,  4 Nov 2026 08:11:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05A57435
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 08:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB2C2402C5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 08:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WkODXVraL7AF for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 08:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 84CFA4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793779897;
 b=X9gFECMe6LCApuYIFg9FU487wBRLwubxbPBmni7eSHsM9wQLSlNWApOflDpyKaoH4Ppy
 eoxGW/kYPJR0jYCEUo28abtstq+/4+/mJJIRkqCDH57vxkbIb053CHQtoRm2FCvp6Rltq
 YF9CzOXryiQVCa5wM+q76Ud1ohgajz0VxGGKNO5vINXDmP7zuFPNacJZRpX0XWU7mZGmh
 LhsMSEpZXHpEWLtLTq2OHYLfOeoQcCAaYlOHeXbNoFDAr04wUDZnt7CDct6t8Glm/hKyn
 2N8TT4DRsoyVcvVoK0woodyc0hzS5ugmI8BS3NkfptkwhOMdOeUpd/Hre1w1i9LD6+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793779897;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=MLhpiOQq+BcLHoXpwFBleckIHcU5aB2HxUSVZEWSQXc=;
 b=WxAYwsUW1BwFsx9drlTUsZiUgm4eCrnObJ5bVtoUOzBTtW2cHnH1pkk+cV/paatwGDmv
 GCGSq64cCA8uVAWdbz3wpo2x1SnPAV+oZE4FH5Vi+aTiyEDoeycxU1iNiA4Mi7GUkrtNG
 +oCiHbTUHeEAGDVhMizTrdindfssc95/XbHt0n13XxaiBFGdRWvZk83CIupl2aDM7hc3Y
 4tLak4V6b+bfKzoTQLD8rbx8ACqGarj6wE8pvNXvN6VUeyyLAIbHhgBOnl+cI+wqZ4K+A
 QTUgLWc8F1c5TpXqRNyIsqq4e1W+T9ggC4bxkkO9VkE7Eu9+RFQAc3dPvcr5B4huqSg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="IuXFvwm/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+marcin.knap.vecima.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IuXFvwm/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84CFA4004D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 08:11:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E92EA6022E;
 Wed,  4 Nov 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793779895;
 b=a2NQcqweFi0UL41gAF1ZBj1W0z3PpKMG7kCeS3l2smMS17M9UqKj4z7fR80TUfR0LE9X
 iL9PbfWvrRhlBxnf9qCf/TOIh2mr4+JwEt5s2WQV0HR9N1YuRm30pWrnWdgoUSDPM5/ZG
 LmpjJHfwTU5XyfZTDny8n5kxCIl6GhYcd02bWcP/Oe1qpKY9mQcF7Re/CF90EcHLs+Ta4
 xKdIsoSrvtNNBtk7hkaZ30BkxOoQ0fAJcYSy1YKWsgRSCANojYPoFOW9G2SnkgbJq43vs
 OWquyDiuhA8IqRshsVfxXAcQXXsNxqIiJLIvu7ziG43QHZB6mKzGPD8FgpHu1Ekw5zw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793779895;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=MLhpiOQq+BcLHoXpwFBleckIHcU5aB2HxUSVZEWSQXc=;
 b=onY+AXlfaq2v+lNl8+i1GnWHzalFb/HcO2kUIyC5oznBY9tNesNlF+okmShSBs5vqIwz
 wvhx5YFrP1HqhQoOsLc/IHYTYekdriJ/yim/MzIjNynLPYJxsOc+IMzXafApgqA3rwbpJ
 BGykl7rYI1yU6IEE60lGpAUU/luZNZIGhsxNa1LsV0CC7wVpK5+gVKvdZbczI0Yf41Y1W
 CKaLCWI4X5oePeFWZADpmzMcdffCSGWUI7c4oiGmhcXnptt0rYbbB5k2hSabSg5f+JrsR
 o91p/JBAjdQwWVybCu8CibXWVaqnjFPmE0IgN+J40Avmz6GqJX4GjxzbHS2+QlXkpXw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D90231F000C1;
 Wed,  4 Nov 2026 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793779895;
 bh=MLhpiOQq+BcLHoXpwFBleckIHcU5aB2HxUSVZEWSQXc=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=IuXFvwm/+J/Uw90dfZV8DYqJig3VePze9NUmNZyJSpUgokU4roHu3dwD34f0QZFKR
 H6+6SZSDk2olabbd3/lY9OAp/fQUe3GiMeV/IFynh05MCitH2Fb9ojYiYuxSiGLIKb
 P2nG97WdhzzjAxE4dEfeYo7sgg8Ah2gXFRib2vw8cA3Zka2XvIcDBSjZLZI9PhzjyN
 vjd395E9DuQEzIY7iA23/jfuRaBKU1g1cNt4kyjnu/20GbiH3R9HGr+4aEFZOUWdQ0
 51JWU6Q9QYhLOOVz0HzAmh3mYGX5gNLMxB4YUhESXhoL27kSnLwOk9bshKCn+fdCFS
 6TY7uQ7nZHiug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4E3BB46D4D;
 Wed,  4 Nov 2026 08:11:34 +0000 (UTC)
From: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
Date: Wed, 04 Nov 2026 09:11:24 +0100
Subject: [PATCH net v3] xsk: Do not free ZC Rx buffer when the Rx ring is full
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6CMBAF0KuQrh3TKYjiynsYF6VMpSrUtNCgh
 LtbcKML4/JP/rw/Mk/OkGf7ZGSOgvHGtjGkq4SpWrZnAlPFzAQXOXIsYPBXeCpwA1S2L28E2hE
 ByrTkm0JVGWoWf++OtBkW98ha6tjpffR9eSHVzeJcq43vrHss6wGX8p+hgIAgpMRC57nY6fIQS
 JlGrpVtlpEgPpiU/2JEZJTmWGWy0KnefjHTNL0A+P3rnhkBAAA=
X-Change-ID: 20261019-xsk-zc-rx-double-free-1a3b059cd41f
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Nitin Shetty J <nshettyj@marvell.com>, Marcin Knap <marcin.knap@vecima.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793779893; l=8126;
 i=marcin.knap@vecima.com; s=20261019; h=from:subject:message-id;
 bh=/laycyHfa7+gbXe0gfkjeC8lPXK/Rk4DOFzJfL0dQwQ=;
 b=hQCx725MgG1C0JQBAD56aXXsYonoB7PKYR+oWIN1Bt+sR9ahZvW+49W7jXZ/OcSy9QDVfXk28
 shOgotK2NCWB0XstEKyqQIWoOAlOaPF9TGPzKZTut+Z2IOzTkHQoE8N
X-Developer-Key: i=marcin.knap@vecima.com; a=ed25519;
 pk=rCvVOuopf4s4BHtLE+FRnv0x83PoFHgBPo9mtNlvzLk=
X-Endpoint-Received: by B4 Relay for marcin.knap@vecima.com/20261019 with
 auth_id=1237
X-Original-From: Marcin Knap <marcin.knap@vecima.com>
Content-Transfer-Encoding: 8bit
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
Reply-To: marcin.knap@vecima.com
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcin Knap <marcin.knap@vecima.com>

When an XDP program redirects a zero-copy buffer to an XSK and the
socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
-ENOBUFS to xdp_do_redirect().

A failed xdp_do_redirect() leaves the buffer owned by the caller, so
the driver releases it as well. That is harmless when the driver frees
it right away, as i40e, ice, igc, stmmac, idpf and most others do:
xp_free() ignores a buffer that is already on the pool free list. It
breaks when the driver releases or uses the buffer later, after it may
have been reallocated:

- mlx5e treats the failure as XDP_DROP and releases the buffer when
  the Rx WQE is refilled. By then the buffer can be in use for another
  Rx descriptor, so an in-use buffer goes back on the free list and the
  same UMEM frame is later handed to user space twice. With striding
  RQ this also ended in a NULL pointer dereference in
  mlx5e_post_rx_wqes().
- ixgbe and igb keep the buffer in the ring on their need_wakeup
  -ENOBUFS (XDP_EXIT) path and run XDP on it again on the next poll.
- dpaa2 hands the buffer back to its hardware pool while it is also on
  the pool free list.
- octeontx2 returns false on a failed redirect, so the caller goes on
  to build an skb from the freed buffer.

Leave the buffer with the caller on both the single-buffer and the
multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
do. Make the drivers that relied on the core freeing the buffer free
it themselves:

- i40e and ice consume the descriptor on XDP_EXIT without freeing it.
- gve DQO counts the redirect error without freeing the buffer.
- octeontx2 now frees the buffer and reports it as consumed.

Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
with the Rx ring. With this change no duplicate frames were seen with
striding RQ on or off.

Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
---
Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
The i40e and ice changes and the multi-buffer path are build-tested
only, as I don't have that hardware available.
---
Changes in v3:
- Target net instead of bpf (Maciej).
- Reword the changelog only: drivers that free the buffer right away
  are not affected; name the ones with a deferred release or reuse
  after free (AI review). No code changes.
- Collect Reviewed-by tags.
- Link to v2: https://patch.msgid.link/20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com

Changes in v2:
- Also free the buffer on zero-copy redirect failure in gve DQO and
  octeontx2, which relied on the core freeing it (AI review).
- Audited the remaining zero-copy drivers against Björn's table.
  ixgbe and igb no longer run XDP on a freed buffer after
  XDP_EXIT; making them drop and consume the descriptor (R2) is
  left for a follow-up unless you prefer it in this patch.
- Rebased on current bpf.
- Link to v1: https://patch.msgid.link/20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com

To: Joshua Washington <joshwash@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Sunil Goutham <sgoutham@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Simon Horman <horms@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Cc: bpf@vger.kernel.org
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c           |  4 +++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c             |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c               |  1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  3 ++-
 net/xdp/xsk.c                                          | 15 +++------------
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 82ed5e48b00a..cc544420df11 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -686,8 +686,10 @@ static void gve_xsk_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 			goto err;
 		break;
 	case XDP_REDIRECT:
-		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
+		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog))) {
+			xsk_buff_free(xdp);
 			goto err;
+		}
 		break;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 51a05ce4c7ce..a11ee1f3fa38 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -360,6 +360,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 		return;
 
 	if (xdp_res == I40E_XDP_EXIT) {
+		xsk_buff_free(xdp_buff);
 		*failure = true;
 		return;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c3..7c1dd4c87a71 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -636,6 +636,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
 			xdp_xmit |= xdp_res;
 		} else if (xdp_res == ICE_XDP_EXIT) {
+			xsk_buff_free(first);
 			failure = true;
 			first = NULL;
 			break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 90af9b9044aa..6d10c132f61c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1555,7 +1555,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				*need_xdp_flush = true;
 				return true;
 			}
-			return false;
+			xsk_buff_free(xsk_buff);
+			return true;
 		}
 
 		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 781ba46eb152..89bac2feeff2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	struct list_head *xskb_list;
 	u32 contd = 0;
 	u32 num_desc;
-	int err;
 
-	if (likely(!frags)) {
-		err = __xsk_rcv_zc(xs, xskb, len, contd);
-		if (err)
-			goto err;
-		return 0;
-	}
+	if (likely(!frags))
+		return __xsk_rcv_zc(xs, xskb, len, contd);
 
 	contd = XDP_PKT_CONTD;
 	num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
 	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
 		xs->rx_queue_full++;
-		err = -ENOBUFS;
-		goto err;
+		return -ENOBUFS;
 	}
 
 	__xsk_rcv_zc_safe(xs, xskb, len, contd);
@@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	}
 
 	return 0;
-err:
-	xsk_buff_free(xdp);
-	return err;
 }
 
 static void *xsk_copy_xdp_start(struct xdp_buff *from)

---
base-commit: fb7bd3a2aad70a76232a7168a505386d0a1396af
change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f

Best regards,
--  
Marcin Knap <marcin.knap@vecima.com>


