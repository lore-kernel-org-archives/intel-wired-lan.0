Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE1EC02199
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Feb 2025 18:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A959642654;
	Wed,  5 Feb 2025 18:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ko36Qp7difEN; Wed,  5 Feb 2025 18:20:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CABFE42655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1738779650;
	bh=ikRlJhJfRL9U71CYDLJpJon5/8/MrbQYVopCvcbvnR4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=elMgh2gljmqXSoIMB7iTByq34sR36rhGl/7EIlcj1gvdtQeSgZ9grhqiBDR7X4tK1
	 BCxVsXZvjarY9gV2A4xTbLnVdf5PKUO9EHnDqcg6gbSzrEfbt6yp+2lDbvXmuJ5HHL
	 d8xyWGPcHgDtIH+E8jhl7bo3YA+b7DKV6WfUGUpvtm3cHYpXlZHapymxYsBeLR715O
	 E7Z4jyOLnyIkmsxD7y+GFwH5SwtP3Qu65xqG6cXe+nMIu81kFZj3ZoBCwX/Pnn+eTu
	 ivzBpCDd34kwqK5hTDbfmR1JACy8SjHaWpRBoVlOQv7xokAZwmge9q3m05emphucS6
	 6XfX9wuARMoMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CABFE42655;
	Wed,  5 Feb 2025 18:20:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15D3C12A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Feb 2025 18:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEB3342656
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Feb 2025 18:20:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4QXmwIhLr53 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Feb 2025 18:20:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=leon@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 29D124265D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29D124265D
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29D124265D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Feb 2025 18:20:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6415D5C6DE2;
 Wed,  5 Feb 2025 18:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225E0C4CED1;
 Wed,  5 Feb 2025 18:20:46 +0000 (UTC)
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ayush Sawal <ayush.sawal@chelsio.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, Louis Peens <louis.peens@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Ilia Lin <ilia.lin@kernel.org>
Date: Wed,  5 Feb 2025 20:20:21 +0200
Message-ID: <dcadf7c144207017104657f85d512889a2d1a09e.1738778580.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738778580.git.leon@kernel.org>
References: <cover.1738778580.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1738779646;
 bh=SCHohVyocop9U+D74KyFZpzTnEVgZWU7PjsASmySSzQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T1iuvS49G1SDbHxveO9HoPx5m3rmJtLOJdGmWJMQ9/21Hexh7fVrleuNrcgZ432uI
 YJEcoV8QE/Pp+pkCnfkcWIkEwojbWPXglG3/X2sRYOIqqIuEpiIgaUqrnDi5Iw9IRU
 29O/kwkv4enT7RceufiDOKsIKMqVOb7ruuTCK4UsMS5FpUZeB/Ug9fdqePEljqpTSe
 QGDaiAQUIffTuRcIUOuutEjTBpu3TTAXjEwx6ck1mX1iwCXGt7adTwgjPcUlrbZcCC
 j89PhLZE+CsL0cTzDa0PbRD8HzC3YvH8YXjXhwBYgupCGHXDd1GKGlXrF6wOA6sp9U
 5RRHAAYTvalNg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=T1iuvS49
Subject: [Intel-wired-lan] [PATCH ipsec-next 2/5] xfrm: simplify SA
 initialization routine
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

SA replay mode is initialized differently for user-space and
kernel-space users, but the call to xfrm_init_replay() existed in
common path with boolean protection. That caused to situation where
we have two different function orders.

So let's rewrite the SA initialization flow to have same order for
both in-kernel and user-space callers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h    |  3 +--
 net/xfrm/xfrm_state.c | 22 ++++++++++------------
 net/xfrm/xfrm_user.c  |  2 +-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 28355a5be5b9..58f8f7661ec4 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1770,8 +1770,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
 u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
-		      struct netlink_ext_ack *extack);
+int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
 int xfrm_init_state(struct xfrm_state *x);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 568fe8df7741..42799b0946a3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3120,8 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
-		      struct netlink_ext_ack *extack)
+int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 {
 	const struct xfrm_mode *inner_mode;
 	const struct xfrm_mode *outer_mode;
@@ -3188,12 +3187,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 	}
 
 	x->outer_mode = *outer_mode;
-	if (init_replay) {
-		err = xfrm_init_replay(x, extack);
-		if (err)
-			goto error;
-	}
-
 	if (x->nat_keepalive_interval) {
 		if (x->dir != XFRM_SA_DIR_OUT) {
 			NL_SET_ERR_MSG(extack, "NAT keepalive is only supported for outbound SAs");
@@ -3225,11 +3218,16 @@ int xfrm_init_state(struct xfrm_state *x)
 {
 	int err;
 
-	err = __xfrm_init_state(x, true, NULL);
-	if (!err)
-		x->km.state = XFRM_STATE_VALID;
+	err = __xfrm_init_state(x, NULL);
+	if (err)
+		return err;
 
-	return err;
+	err = xfrm_init_replay(x, NULL);
+	if (err)
+		return err;
+
+	x->km.state = XFRM_STATE_VALID;
+	return 0;
 }
 
 EXPORT_SYMBOL(xfrm_init_state);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 82a768500999..d1d422f68978 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -907,7 +907,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
-	err = __xfrm_init_state(x, false, extack);
+	err = __xfrm_init_state(x, extack);
 	if (err)
 		goto error;
 
-- 
2.48.1

