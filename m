Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBD606A322
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TViDJZen;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XDTqMeG9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00E42407AD;
	Mon, 19 Oct 2026 22:56:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oCJezkvdkrR0; Mon, 19 Oct 2026 22:56:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA127407B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450574;
	b=VFfK3AXLFLmDijtunbVRdVpkV4grWIaVlKgkDYMDmEfn/gY9JZUeEyOJ0UjUbZ65ALRG
	 Ykec6qRlHYyvCoBQeP8aWFLX4XM2bVGSgKOOAgBWkDRFVDXHr2FvGvgD9l9XA9fk21BJa
	 2Xkizrxu+icM2uExkJleCm8y+VKTfuSyTtEXV/41rmtwDDq2UAQ136elBE3/6yQuxzl9k
	 6eDjEbzDcS6Y+jU+RKqwDfKnpQoZYXa4Uk/OGbhS0zhgNouAaFUYDuZH5lZfcr6wqIsRK
	 U16uUvc5aGtFoUhNFqlshKYnO7OGzVM9pja/eCoO7Wfq0JcwuTRscxIi0+iiFKKPOvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=unixHZvd5zeSgPpT0jNo1jl/ObTo4C760TAI7TbRVJY=;
	b=iUVnSFIysI+ZRyvqO+7//q/siXf39No1chhGJJLA1J3H+M43XYErQ9KOUQnwficbav02
	 wWkfpG9dAcU/VS/tyXYo7j0g08jykiq4Svd8BI1rh3nLiuq23riRu31/7JI2YOLl5HgLz
	 mF9gIC/GyEC2onwBDAMjKrfEh6KVgS73PLAtjC2QM6B+if2Bgv7odlTeZtmYCbRm8Ard8
	 QCWxrV9RxTFc01GGCtu0wJhFMB4JkHHt0DJgiBpI1OWRpaaLAznOO1EfOu3Y0HHFDUMrN
	 5WrooyKJ7JCXyiB55HGA0+v2BLZSDeVABfCz7Y4y0cm2nHb5x+DT3z1VwDkh00dCMsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792450574;
	bh=unixHZvd5zeSgPpT0jNo1jl/ObTo4C760TAI7TbRVJY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=TViDJZenczCFFt12QJpsnDf4+sGre+WKQOVLuYb7Z16usQUO8UjcOpL2PubmqzlQP
	 uGZNGQlHTEb/pzaiHAStrltuJy4fEUcQp0NOoVaQK2N+qNA+MzwiStSQvsQQj1uL5u
	 7DH+R5/dUb7fLpOhkm40sFAXPXUUzCKZiaiZQeOh61gugJ6SrJyAN0bTSBTAAe0HZV
	 by4kJmPtgF7NNdqW7zpVr33iQ2smWzvwMUWaZ+KFPBFS+w20cesTrwLyKgUaYpQsDC
	 EGo1JMCL8It2fzzeFe2IKZQ4xxOoL/DgOvR+tnMAsOw8+BFy6Br6SCdYQ125s/2HYP
	 WQ5fAk6PS3xmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA127407B3;
	Mon, 19 Oct 2026 22:56:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F023263
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5506A80F61
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:23:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qs20-66lb3ZG for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 08:23:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BC9380F55
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792398181;
 b=Y1Kjgy/xUbdP0aFHPOxFwSm2udbn6Z5im1dzE6ifqOsaAR6/Eix4ZKJ9i91BfLthIkeW
 vr4Pvd1Hhd4+EopIjLzIPpy5H/1L7A3/Z8cirwekJhiAPOPV3Jug21LeHfdgFuDn/12lb
 1dtzSx0cOrCE7MLsc/45QHBoF5FmsQxLygYMlOt6HTiSsy66Dh/TfN6kjfFKaBbuwkI9t
 CFfUtHBZOvuYJTlZSKClp+yfZT7tJHwZw0sXgJP2Jlz36rmyUTRoKyDPoYofzPAGVV9te
 768vp9MiPIU/Ea70rZ1YTs/PVKQinBDoZ1zOn0lsMBwEN5L4ZVynqYCQofu2kO0UDUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792398181;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=unixHZvd5zeSgPpT0jNo1jl/ObTo4C760TAI7TbRVJY=;
 b=VhJNbH6KZwFNRPo2vFDCBktj/d8SFt9kSlTtUR/9hYmFOg+efexY6chhLBwH+wmnVTDG
 3YE3AxPlA3HQqVs7FgpYU0zTFnT1UdrZBQmLHf/bYRITcYzMGAVq0avIbpAIyiDhQuNug
 IzWYc1vYZlLcQ6ivDnIvPuHBEDt5rIBLT3Sq9UkPOBAswQTgcVZE+Mtjf0PdKBDi2/PfF
 qC4k7p+QjnTN5roTng9iJx3ZcvycrC53QogMvlvqXLFneNu+8siymbTMrp4l7egdIhpEJ
 fkDQXd2r+j7h6MGnnsJjd10Ezuea8Jm/JHfdFSmXh4BoEN0aIRChQb4XxdliAJweSEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XDTqMeG9; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+marcin.knap.vecima.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XDTqMeG9
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BC9380F55
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:23:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 27B2F600CB;
 Mon, 19 Oct 2026 08:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C72A3C2BCF4;
 Mon, 19 Oct 2026 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792398178;
 bh=ss+Ay5ky+oMHizLDR1kIYc6Phpgh2tmXwdEs6PiiD9Q=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=XDTqMeG9J05nMX5grZXxC7LnYPRb3PsL8ZQc0AQuoTuPSv8M0QolrnBHnV6JN9RJe
 FT1312DSw0EhdxqpqgROVo3kR4SOONZdwtJBphWxaBbPGdaornQLs7pCEfuzmrwVND
 P0ctUfRHjNAqFy7E24AwqLkunPjFw10GHTBLQopwq/niwSz6m13H3b0xPg/ya8fTJQ
 az245IWVOECSZ/s0Systbpl3YcSK/AlVOHTBky+LYmReTHhkPW6scKhBA/pTv5QO+w
 6+HC1/oRF0Xsne7E2sUIdhizOkTi6+jvGYYQ85w7werIkwerg5azI/r85aQ3jHaIYN
 nA+ghCYzDp3oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9E175CCF2DA;
 Mon, 19 Oct 2026 08:22:58 +0000 (UTC)
From: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
Date: Mon, 19 Oct 2026 10:22:02 +0200
Subject: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMAwAf4X02SYrKgn+ivGBbR1UDZBWzCLh3
 53yeJfcrWCswgaXagXlt5hMYwE6VBCGbuwZJRaG2tUNOWox2wM/ATVjnBb/ZEzKjNQdvTu3IZ4
 oQWln5ST5/72CnxPcdmmLv3N4/Y6wbV+jyIs7fgAAAA==
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
 Marcin Knap <marcin.knap@vecima.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792398177; l=3895;
 i=marcin.knap@vecima.com; s=20261019; h=from:subject:message-id;
 bh=s6M5ShvilqT323SiSxSUh6dP4sF4L+nlpgOVCpDnEy4=;
 b=HFs2SdpG1CqBqkvoJRwEfJGWNfBJ7ooY+MScmp5JkPzPFwlIAXQjDAdi23OedaFro/Z459wVH
 WUhia9cS1xdDc452zTPEUkNgfr0sWLUaj7fqvb7FkxgW6e/kSnBincv
X-Developer-Key: i=marcin.knap@vecima.com; a=ed25519;
 pk=rCvVOuopf4s4BHtLE+FRnv0x83PoFHgBPo9mtNlvzLk=
X-Endpoint-Received: by B4 Relay for marcin.knap@vecima.com/20261019 with
 auth_id=1237
X-Original-From: Marcin Knap <marcin.knap@vecima.com>
X-Mailman-Approved-At: Mon, 19 Oct 2026 22:56:11 +0000
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

A failed xdp_do_redirect() leaves the buffer owned by the caller, and
drivers rely on that: mlx5e treats the failure as XDP_DROP and releases
the buffer when the Rx WQE is refilled, and i40e and ice free it on
XDP_CONSUMED. The buffer is therefore freed twice. It gets reused for
another Rx descriptor, the second free puts an in-use buffer back on
the pool free list, and the same UMEM frame is later handed to user
space twice. On mlx5 with striding RQ this also ended in a NULL pointer
dereference in mlx5e_post_rx_wqes().

Leave the buffer with the caller on both the single-buffer and the
multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
do. i40e and ice relied on the core freeing the buffer on their
need_wakeup -ENOBUFS (XDP_EXIT) path, so make them free it there.

Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
with the Rx ring. With this change no duplicate frames were seen with
striding RQ on or off.

Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
---
Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
The i40e and ice changes and the multi-buffer path are build-tested
only, as I don't have that hardware available.
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c   |  1 +
 net/xdp/xsk.c                              | 15 +++------------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..d32c7255f0b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -358,6 +358,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
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
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..0edc160c660f 100644
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
base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f

Best regards,
--  
Marcin Knap <marcin.knap@vecima.com>


