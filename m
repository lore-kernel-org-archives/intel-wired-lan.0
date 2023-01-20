Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BAAC52D11
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Jan 2023 17:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 469C9612AF;
	Fri, 20 Jan 2023 17:17:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 469C9612AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674235053;
	bh=x0DtXzrkxgsERPOLFnP+Pfx0beiHrl70Q8xyjzuZzbA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ud4u1MjAfA48OrMnGjdkXrlHxDgPccptLHMKXM38yOdTudjrkJqzB3LuyedJXKN1k
	 H1FVTPRQzizrEOSxaM0BscoLFvbK8po3hxDL8Rkk3SAJ0okkgxHrdncaHRH4s8LH4s
	 Y4C6s/1yi+boY8CiEC0kLf9lwBjpS68IJRgLcLrealVdilLJQQRzeifE9NUYNYLvSn
	 e7j+MCwVriTzEIz4mogzoguSTFf91pLLSZ13BymqmAb9UvRAaD/a9PerMVUvoT+D4L
	 aHQGRNRep2cCjQZm8GrQS4B6JR9wKQ0bBgYWnw3sFA15DYwjw8z3LNDsCvI7PME0BT
	 Lk1OtFHzSZjCA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hz8bsAaaXf0x; Fri, 20 Jan 2023 17:17:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 620B1612B1;
	Fri, 20 Jan 2023 17:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 620B1612B1
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 3D2EA1BF584
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 17:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18A6F612B1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 17:17:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18A6F612B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n-Ci_J37TePn for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Jan 2023 17:17:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 856AE612AF
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 856AE612AF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 17:17:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9B00461FD4;
 Fri, 20 Jan 2023 17:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1115C433D2;
 Fri, 20 Jan 2023 17:17:25 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Date: Fri, 20 Jan 2023 18:16:52 +0100
Message-Id: <a8ec5fdb515463443f4984b40760370594094854.1674234430.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674234430.git.lorenzo@kernel.org>
References: <cover.1674234430.git.lorenzo@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674235046;
 bh=8bcWrSdLkPBLDabPqoyHtUr2JYRbbglpSB6VTJ2pAFo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p09ZafJaEpLsXZFWt1AOZwlMi4a7Fv/KkcRs4WzUQRA+Wx/C0FwOXJTkBhFUdvqIk
 fqE0GnynjQgXQJY67Ss5BKdO8fjU1HdbmmPphkJr/AQKxi1n4V9wiWKUVuwkDhPcJe
 6oc+7+ozrJEoyqF/aY6E4HiVCeJTE+l46Rp6omAqUfqUVCPoPGBsMqhqv1Rsr8vxJo
 R+r/C99U+ejsT5I2jHxM76J7iz0ANN/wvnrpoMGf3Fu1yr+AHgLcnolEY7/CMaMgVq
 Zzh/da5kKpOVaSqKhNoT/yBkawJMx43LEzZfrbIiymy6umDhjNhPvBGPixN8bRTPjA
 wpCIkJI2tWcMw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=p09ZafJa
Subject: [Intel-wired-lan] [PATCH bpf-next 3/7] xsk: add usage of XDP
 features flags
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: mst@redhat.com, vladimir.oltean@nxp.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, daniel@iogearbox.net,
 niklas.soderlund@corigine.com, andrii@kernel.org,
 intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com, kuba@kernel.org,
 pabeni@redhat.com, aelior@marvell.com, hawk@kernel.org,
 christophe.jaillet@wanadoo.fr, memxor@gmail.com, john@phrozen.org,
 bjorn@kernel.org, magnus.karlsson@intel.com, leon@kernel.org,
 netdev@vger.kernel.org, toke@redhat.com, ecree.xilinx@gmail.com,
 alardam@gmail.com, gospo@broadcom.com, saeedm@nvidia.com, davem@davemloft.net,
 nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Marek Majtyka <alardam@gmail.com>

Change necessary condition check for XSK from ndo functions to
xdp features flags.

Signed-off-by: Marek Majtyka <alardam@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/xdp/xsk_buff_pool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index ed6c71826d31..2e6fa082142a 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -178,8 +178,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		/* For copy-mode, we are done. */
 		return 0;
 
-	if (!netdev->netdev_ops->ndo_bpf ||
-	    !netdev->netdev_ops->ndo_xsk_wakeup) {
+	if ((netdev->xdp_features & NETDEV_XDP_ACT_ZC) != NETDEV_XDP_ACT_ZC) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-- 
2.39.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
