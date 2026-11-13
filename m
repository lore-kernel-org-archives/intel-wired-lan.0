Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E0606A338
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0n//KAuQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki5GTd9k
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9EE76068A;
	Fri, 13 Nov 2026 14:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UC6rhvKpDEEt; Fri, 13 Nov 2026 14:27:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AD6D160711
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794580079;
	b=az7f2402GdcAr1aIQj6eFnq8/FEKv4Y4XOJEmlKRxPnuMVv3aw5BfH9SvfCr5bdsqhEH
	 SiJNVd9vhXbhVAj92dphVRdb2NgMb7RGp/LY9KhUL1LAbDP0UX1EhEMC8LhqpqoUNg2kq
	 F5Yyp5FBOPWFrYldaJv21wbYeqvIC9eeqKuSnWNNWK18t0cajowEmwPAubws0xpSzrtXp
	 n5BeILMpVfyDVXJAL5ESGXp8HmO4/HF5GY5Mmt9OqFrZkrXcRCcRzoHdh/CP5J2teO0Gb
	 VnPzwoqN26KcTobv5p4uTg70PGXcvrUAoHGIu+/QXPRT8grBGa5UKZGbBZ/FNKS1T7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794580079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jzMjuQl8C8L+Em4Znh14MLOEnvwiWcUFEgHaJGwy67Y=;
	b=lzuoEFiqeEg/hNZtSBQEyDSeM3YFZuOFDv9L+0ZIaxOJVkAuXjjyg6ZwAXO5v8yhz4AE
	 BxqnnUTrfD82a4vzNCt4U/gEantwiBkoVcBstYWjz0r7jriZ+GLTPP4F0a7THXba/EAp4
	 RMAZjGStK/aEovypba6GI+G0C82+Rb6AT4XP5iURNIZ0mrajpfE49iWyKKxfNv8wYS9YU
	 oFjQ/NAb/10KrKtboJFGnQ8rC0YC4tEls93n/nQ4pIgOFp8DnHsPsF/bKuHhOdUHA8YKk
	 j3x/KcPjpYoX490oti0yqqmhF4tDTAR82uSiTZlGT7p+A8Kf0eKA6NZ9+ko/J9A0THA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki5GTd9k;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794580079;
	bh=jzMjuQl8C8L+Em4Znh14MLOEnvwiWcUFEgHaJGwy67Y=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=0n//KAuQqvBd/vLEt92ZStAyiN81kZU5ojXcCpQy7qRXlhZnYVC5A8KgWJbPEve69
	 5y2TwNnmEvd8RHintTTEo2K92QJqYXxen8fT7t8l8OMNuH5hmRgt8NJ+WqG9nMgxzS
	 cSKY7SLG2hOVAA0o8x9EREdlcxSBsYcLeQBGJUagup98pWGxARfNWRU0n7RdjG41lA
	 Jik1/1nDovHwWrs8RZp+GbM8/1jesoWnt7DsvmvA4G7z9ff8gyTMu8OdQ7lcQVZMuc
	 lxE8qinXwbTfyx72aLu8aYpjvhI6QtmlKivCb5OyxMHXfQyLr89BAbbpjXXWE/dokx
	 dhPKZQ98F+nDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD6D160711;
	Fri, 13 Nov 2026 14:27:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79BEEF46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AD276068A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dn3In5aUyP3f for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 14:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBF6360711
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+marcin.knap.vecima.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ki5GTd9k
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBF6360711
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 14:27:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D26D6267A;
 Fri, 13 Nov 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0A5DF1F000C5;
 Fri, 13 Nov 2026 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794580074;
 bh=jzMjuQl8C8L+Em4Znh14MLOEnvwiWcUFEgHaJGwy67Y=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Ki5GTd9kZO1v1YpRYCn9q37lTcSQoq1XQuVQ3TPce5Jm2d89KWb9tuiVln4Rf+GHQ
 pvnA78CO1sTOmuN8GNCBuU7iBaVAFaXdjgmUUEsbpLyZV8gwT4cpHhIYKP/hx6LsJt
 SifaHqnY6gtP8c0OnTl9tnTmUnVpQ8J/7l5SxWoV4uuJUvDtIPXdtJ/9dzr+l5JWh9
 2gbz/bcCZ9ar2VnwoYt4BiLk1uNsw5RHgYGOfC3LF1OhHGLTfzRkHc6Z1WHJBBdziE
 pgb/YWZDxC741EPw5WZpuc3Zf2ZdtIECmrObrnSoHIIrM7B8lp9d2tKV3Uu2MM+yjN
 PY/VDDOj+L+9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5DFF6477FA;
 Fri, 13 Nov 2026 14:27:53 +0000 (UTC)
From: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
Date: Fri, 13 Nov 2026 15:27:52 +0100
Subject: [PATCH net v5] xsk: Do not free ZC Rx buffer when the Rx ring is full
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-xsk-zc-rx-double-free-v5-1-6ead3af4d131@vecima.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPwU7DMAwG4FeZcsZTnGQt2Yn3QBxS12EB1qKki
 wpT331pd9jQVHH8Lfv75bNIHAMnsd+cReQcUui7EnZPG0EH170zhLZkoaSqUKKFMX3CL0Ecoe1
 PzReDj8yATjdyZ6k16EW5/Y7sw7i4r6LjQbxdh+nUfDANszivHUIa+viztGdclv8pyggIyjm0v
 qrUs29eMlM4ui31x6UkqztGyzVGFYa8xNY467WvHxh9Y1CaNUYXBtFJqtmjrfUDY+6Z1afM/JR
 hKR0pVbg/zDRNF1JEBNOnAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794580072; l=9330;
 i=marcin.knap@vecima.com; s=20261019; h=from:subject:message-id;
 bh=AIRvjG754M3Sj+HEOteZxm3m/GpLx/VY0+cKvGXe26g=;
 b=zB3gPzf/0sJ5eXrmEbQ74x47vNq7n1pTvVq58hqDTGLdkK79RCz5FTQhxR/MaGY5aXsI2bj6l
 a+TqHBR2f4BC/sP6QtOeIsNvzsc+YE4wl2W03VomnEx21QsLasFyq7h
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
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
- ixgbe keeps the buffer in the ring on its need_wakeup -ENOBUFS
  (XDP_EXIT) path and runs XDP on it again on the next poll.
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

This covers redirects to an XSKMAP. A zero-copy buffer redirected to a
devmap, a cpumap or an ifindex is copied by
xdp_convert_zc_to_xdp_frame(), which frees it before
__xdp_do_redirect_frame() can still fail. The driver then releases it
a second time, and the copied page leaks. That path is not changed
here. It can be fixed separately in xdp_do_redirect(): copy the buffer
without freeing it, free it only once the frame has been queued, and
free the copy on failure. xdp_convert_zc_to_xdp_frame() itself has to
keep freeing the buffer, because its XDP_TX users rely on that.

Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
with the Rx ring. With this change no duplicate frames were seen with
striding RQ on or off.

Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Nitin Shetty J <nshettyj@marvell.com>
Tested-by: Jerome Tollet <jtollet@cisco.com>
Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
---
Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
The i40e and ice changes and the multi-buffer path are build-tested
only, as I don't have that hardware available.
---
Changes in v5:
- Commit message only: describe the devmap/cpumap/ifindex redirect path
  and how it can be fixed separately.
- Link to v4: https://patch.msgid.link/20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com

Changes in v4:
- Commit message only, no code changes (AI review):
  - Drop igb from the drivers that rerun XDP after XDP_EXIT;
    igb_run_xdp_zc() turns IGB_XDP_EXIT into IGB_XDP_CONSUMED.
  - State that the fix covers XSKMAP redirects.
- Link to v3: https://patch.msgid.link/20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com

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


