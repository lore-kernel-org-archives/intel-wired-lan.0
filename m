Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8518606A31E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qlXfxeEM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDF1YvTc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99BCB60B01;
	Fri, 27 Nov 2026 14:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6IGibC64ZfAu; Fri, 27 Nov 2026 14:21:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0499860B04
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795789313;
	b=VyZE8Evc4z++XoO+2k5RGNBdO3+mDsL4vz089dc/92iMKsLj7iTzv6iUbzqewtFY2fNj
	 MUrov/2nbd3uNHm+zje9zMn7Rax5BOulPpd2QLNWBfg02HnnX3pjtdr3XopANv7KVIjJI
	 WfdD1b5V1QPV8+7bZVkRwave1c/glILeMB15KX+XCudPO5uyv4S0WnSX1diY/VsuaQ+VG
	 bEGLEsO4yrO8ljDJGVMuJbNww6+TB0i0I4FY6Tbp244vbcseI5lUSY5BRCBL6Q12H1RiA
	 /Kn6IqYjtE/mF3re4DBYXGb2coJ2tFZ67kfX0r/l6TDZGOKd5UVcnO8bJF1dasGQ+Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795789313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7+c1Qm3VYeU1+HWEx+l1hojCUO1r8kUOKWi5tpZjEFQ=;
	b=U8GujTApYPBZtKMw39/pgh+NLngjwcvVMc1/4e9QaBrbpc1sfL1fpPtG7BFvCkD8JHPh
	 oY7+APjYw1nU/Oa9qBwmOto4qe8AGLuciWDxAX+fH/VM7+gY5Fsf1h17w2HAzbHzgy5ok
	 U5MuyxmszCJfSMquK0M0s/BtRsSNmf9IP8bgRoFW95OM1+BX0xpo+49aMn3td8j90MZ6a
	 Y1lhaEy2Jzw87dzskJvHWiR0L2tACnGKS5qbQAnjXkRnKe0gfZtuztOfQKx9n7ndFbjkY
	 1yy9b6maa2E1MT2z3oO4XXq/qMQop/vXBVmqcq4h3TDagQVEZGDy25rdrZ/aBkYIrvw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795789313;
	bh=7+c1Qm3VYeU1+HWEx+l1hojCUO1r8kUOKWi5tpZjEFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlXfxeEMlE4kl+LPQGyp2JrmcAV2uPdPY8biJx0yDd1RA9CVX775lxig0GgjAdy0f
	 6xUmPkzVrPec6G4a81l9AAPs7r6LOeSYFWDrJ2UTG9uZrO467Khx8nZMUy4TxpaqBf
	 mVLuJI1kgEmG1J08X3B3WvNnnlQlhNFE31MMIqNDZ4V/+bZkqxdaeQDlljFVVNmA4E
	 yEoYsRHPori2Czv6aY21eoNIaWtB0on4tHwwFJCKuFg6E3JtW6DD0+2DnkHUiEb5L/
	 fN2yjevQYdj3P5QiDiKEQJXXgdPP3LFsuCb/eMCOb73iIqVuh9c5uo5I47talWl9Pb
	 vfHbSDz5zm0pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0499860B04;
	Fri, 27 Nov 2026 14:21:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E19E1373
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF6A34095C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCz1xbDOQCLG for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 14:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20A7740A70
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=bjorn@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jDF1YvTc
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20A7740A70
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E8A245955;
 Fri, 27 Nov 2026 14:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29781F00898;
 Fri, 27 Nov 2026 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795789310;
 bh=7+c1Qm3VYeU1+HWEx+l1hojCUO1r8kUOKWi5tpZjEFQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jDF1YvTcOZIItHkIbN2v0sQMzIKYAr7B1NuEmMRXZfwW5guiOGIRAnfZ84fnza+ou
 KuIfaYDVPPah8qEPjKTJbF/JnsSI8vYu0suJ4MYpXaG5ZY1/+01Ac7LwPgyZDN/q7P
 O5Yfj+ZKRvXcITPli95LyIJR4t4Omb4R3oa47Sm702fWwVkP1EWCfqfGUoUQC9ItRm
 G7Rx2QVLGWzlyukn/WqOwcePlcCASoDSzaUqhAwNg6TSw/1ypspRp2Gq/Q7gGF36oP
 Nq9px5OqKlKW/JhbWZe/5mbSlGqCImLYXhl2xLCO6hENDPWFhbCtZ8DkbPgzEzdMA6
 6e+3QF4z0GUCg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Colin Ian King <colin.i.king@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/3] libeth: xsk: Count each XDP_TX buffer on its own
Date: Fri, 27 Nov 2026 15:21:27 +0100
Message-ID: <20261127142131.3527737-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127142131.3527737-1-bjorn@kernel.org>
References: <20261127142131.3527737-1-bjorn@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

libeth reads the shared info of an XSk XDP_TX frame when it flushes
the bulk, not when it queues the frame. The fragment count it finds
there decides how many completions idpf reports to the XSk pool.

The shared info of a zero-copy buffer lives in the UMEM, which
userspace may write at any time, so a rewritten count makes idpf
report the wrong number of completions. Once the next patch moves the
shared info into the buffer pool, the next multi-buffer frame of the
same poll can overwrite it before the flush.

Count each buffer on its own SQE. Head and fragments each take one off
the in-flight count, and the head counts the packet. Stats do not
change.

Found by code inspection.

Fixes: b3ad8450b4dc ("libeth: xsk: add XSk XDP_TX sending helpers")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/libeth/tx.h  | 3 ++-
 include/net/libeth/xdp.h | 9 ++++++++-
 include/net/libeth/xsk.h | 6 ++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index c3db5c6f1641..25cad5566436 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -22,7 +22,8 @@
  * @LIBETH_SQE_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame_bulk(), stats
  * @LIBETH_SQE_XDP_XMIT_FRAG: &xdp_frame frag, only unmap DMA
  * @LIBETH_SQE_XSK_TX: &libeth_xdp_buff on XSk queue, xsk_buff_free(), stats
- * @LIBETH_SQE_XSK_TX_FRAG: &libeth_xdp_buff frag on XSk queue, xsk_buff_free()
+ * @LIBETH_SQE_XSK_TX_FRAG: &libeth_xdp_buff frag on XSk queue, xsk_buff_free(),
+ *			    stats
  */
 enum libeth_sqe_type {
 	LIBETH_SQE_EMPTY		= 0U,
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 898723ab62e8..66a3c4ec9967 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1794,12 +1794,19 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
 	switch (type) {
 	case LIBETH_SQE_XDP_TX:
 	case LIBETH_SQE_XDP_XMIT:
-	case LIBETH_SQE_XSK_TX:
 		cp->xdp_tx -= sqe->nr_frags;
 
 		cp->xss->packets++;
 		cp->xss->bytes += sqe->bytes;
 		break;
+	case LIBETH_SQE_XSK_TX:
+		cp->xss->packets++;
+		fallthrough;
+	case LIBETH_SQE_XSK_TX_FRAG:
+		/* One buffer per SQE, see libeth_xsk_tx_fill_buf() */
+		cp->xdp_tx--;
+		cp->xss->bytes += sqe->bytes;
+		break;
 	default:
 		break;
 	}
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 249b1c740788..2cd4252a3445 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -129,6 +129,10 @@ libeth_xsk_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
 
 	sqe = &sq->sqes[i];
 	sqe->xsk = xdp;
+	/* Count each buffer on its own SQE. The shared info of the frame
+	 * may change before the bulk is flushed.
+	 */
+	sqe->bytes = desc.len;
 
 	if (!(desc.flags & LIBETH_XDP_TX_FIRST)) {
 		sqe->type = LIBETH_SQE_XSK_TX_FRAG;
@@ -136,8 +140,6 @@ libeth_xsk_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
 	}
 
 	sqe->type = LIBETH_SQE_XSK_TX;
-	libeth_xdp_tx_fill_stats(sqe, &desc,
-				 xdp_get_shared_info_from_buff(&xdp->base));
 
 	return desc;
 }

base-commit: 28a371228d4eb4857cc31eeb1a0d7d01e9c3ea2f
-- 
2.56.1

