Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AA606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=756zrqnA;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j4hRzK/N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A27E607F7;
	Thu, 12 Nov 2026 16:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wVlHWbOiKvug; Thu, 12 Nov 2026 16:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C65FB608D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794502514;
	b=ICOhRe90PED3wA/1bntFbyDbYK/1kswvw8oqmSo5xaWCXwh7f1+ybgZ6V+f2k6MRp4U6
	 EqBRiDB7FalD6zM3FvvA16nWj5zqTAAxY0/lOW966uIt9kRkrY9Mw/BYE3rToehai9Wz5
	 wCHezZjZZ/SBCF2uYWxf6KDBL9LSKGzh1w/mk2K6kUxhrdzngvTrj04hatizlYEb3TYuL
	 CKcDjsTKMizT4FKFcjyzGv5vZ5ssKyUuCOPQoPo2a7+xsY80QA+5/s7Xmh7XbdueERZYi
	 CsuB/cZ9y5PkeqNIKhLg3c545KCvdL2yxbh7MQOOOks0QKdgffiUNdpc8S1NauH3MHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794502514;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gCmBxRck2pGwY1dXy/qFuwaXSqXYOmKFVAr3BJpKxEo=;
	b=i5iFaX6fk7KC+Eu0x6D0VyzAKgfWRgxE3ZRVdSVuAphEJ+oSuKGYt7ZDLC9E4no3L+Bt
	 MoHTS8bx5RCQckW8pvcH2yiglOkiymwhjNYy2lOBCWQtManehVGdLUTzni+573H6QaNr2
	 78pTv0JZ8FBxT1tyUAV+mXrCYXerHHC6PGB513hrXpqEPAIiAgIoumiBbpIiZHUhI8m3k
	 RbQF8WbxCGVbaiZCdQHmB91+VlUvmLxa1VTkJpsLY1u9Ay5gJ+yntxCk7TiyXAltmbbZQ
	 qR8dAkWESd6fuhSexdBhINiRZ5SWQePZ4opu9ctXRSNEO1p6oTk8yulWPD9Si9Cx2Qw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="j4hRzK/N";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794502514;
	bh=gCmBxRck2pGwY1dXy/qFuwaXSqXYOmKFVAr3BJpKxEo=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=756zrqnAjSLbQuTuPdPSsn8HxhPSnCXpDKPpuw89zxd6+n9k6Yi0UmqgxSL3VH7/n
	 oB453pY2Sg3fuBQuj/M3olznXf80YXhBgoa1kTdgYt/PGJ45+cd/3YN8Fc6knL/xWv
	 aIwcZwAqBPA9U2ddiMVVBV7iAtpJzSW8KYWsTLJnYa9HxOdZkYeTiVYmixv0gGJHuQ
	 F1kl9zWTnl8t7nL0twgIYtBAPxsEwsgBzH1dQKvQidFlXZ+A6ztabVFgo0CNOejtDU
	 xO5EEBNydoxpw6v01O22t4l3KNyMpb9vbHBZ/DgALOt3x9nqhgFue6j6h5kArXTYBY
	 IZUQOIiqs3pGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C65FB608D2;
	Thu, 12 Nov 2026 16:55:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E31C7156
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC7116089E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZIlMQ8Uqa595 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 01:11:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A75D60897
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1045"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com;
 envelope-from=3mhl1agckd4k5tcun0tt11tyr.p1zv06ry-9v4rq-yn0yv565.15715y.14t@flex--sgzhang.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=j4hRzK/N
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com
 [IPv6:2607:f8b0:4864:20::1045])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A75D60897
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:11:15 +0000 (UTC)
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-3b0a528ca65so3451562a91.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794445875; x=1795050675; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gCmBxRck2pGwY1dXy/qFuwaXSqXYOmKFVAr3BJpKxEo=;
 b=j4hRzK/NMcuJz7ehWXh4mpD65a9fGU4nzyw7BWkHvG3r6vfA4EmJECU97H28ScQGVS
 5+ipRFedQnwL9aTT7+tkKpUyJy55cAKulQCHCqmOKftBr/RyUMayndW0ykZ+w4EfChyX
 qXjQYSpKhJwICVcmiH1N/n31XzX5L6aVcIwjiGOaw5Dn9FfGh+6FPR0ZDCvLUmb0jZGz
 zpeVX/SjGzTxH0h5Op062ZgRN/WkGsRedcRu46nkAIAMy7RlK86TV30qfxP+wKy+CJd6
 yPilJNb4/BZ/GxSPhPb/8LPSnb9N8kK3FGTQ28bR3/E4cd63uXSCINapa4ggUuHoxybH
 XSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794445875; x=1795050675;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gCmBxRck2pGwY1dXy/qFuwaXSqXYOmKFVAr3BJpKxEo=;
 b=xkmdeSfofhd6WVeROS+lOWsuov5ERRLcEfeG9WFvWL/cvTQxW7n7mVnrn82OQCJ+av
 LivT11AY90ndZiL88enUIGMyY+RIHfaUVpzQQIsZOHF+Ffu3BUKXqaghoB+A2Md2FbCa
 7z1a9ZGwUtSQDoGLUXaWsN7iRWnPmu3Jk9yKb6zToXmpK5JTI13DIEzGm5w8GpQmE/BZ
 wc8iAjI7pjZ54HlM7dzW0Z6ZabgAMs7dPpQPqB+mcVHLJlCqntKNy8uWOD9s2PX+kYSW
 YaaXJzu7eNBwDM5IadZfkbtgPCp6C+YvEIt/DFdIzi9n12gky/RE0ieCGra7qkWHmTgm
 5J8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFoKZ5RroqFwjKT0Gm74IDDHcH8hjk2bObHglmwlMtZrDzefvg1bogadadrvNnVayk8Vl5LEPbHJMOk0T8seqs=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8+o53Vw914lB8mvF3oNly5bTjlIw4ImN5562iSSlvOoN4dNtmN
 1UMDb1MlRHzCnCJRp9BfFassGEIiBV+3ArEXQq/or9tyuwErQpARGsaUjo4i8r8bo0xCjcir6cq
 2HkCH3GmWHQ==
X-Received: from pjtf15.prod.google.com ([2002:a17:90a:c28f:b0:3b1:3798:48e0])
 (user=sgzhang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57ec:b0:3b0:a9de:9884
 with SMTP id 98e67ed59e1d1-3b182f200a7mr3805638a91.40.1794445874792; Wed, 11
 Nov 2026 17:11:14 -0800 (PST)
Date: Wed, 11 Nov 2026 17:11:08 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261112011108.1524624-1-sgzhang@google.com>
Subject: [PATCH iwl-net] idpf: preserve tcp-data-split setting across hard
 resets
From: Ray Zhang <sgzhang@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michal Kubiak <michal.kubiak@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
 Brian Vazquez <brianvv@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ray Zhang <sgzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 12 Nov 2026 16:55:12 +0000
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

idpf_vport_init() runs on both initial probe and hard reset, and
unconditionally calls idpf_vport_set_hsplit() with
ETHTOOL_TCP_DATA_SPLIT_ENABLED. If a user disabled header split via
'ethtool -G <dev> tcp-data-split off', a subsequent hard reset sets
__IDPF_USER_FLAG_HSPLIT again and silently re-enables header split.

Move the default idpf_vport_set_hsplit() call to idpf_cfg_netdev(),
which runs after idpf_vport_init() sets rxq_model and returns early on
hard reset when IDPF_VPORT_REG_NETDEV is already set.

Found by code inspection. Reproduced and verified on an Intel IPU PF
(8086:1452) by disabling tcp-data-split via ethtool and triggering a
function reset from a test module via idpf_idc_request_reset(): before
this change tcp-data-split reverted to 'on' after reset, and with this
change it stays 'off' (with rx-hsplit remaining 0).

Fixes: 9b1aa3ef2328 ("idpf: add get/set for Ethtool's header split ringparam")
Signed-off-by: Ray Zhang <sgzhang@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c      | 1 +
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cd1b173e3b27..db6603711be4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -945,6 +945,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->vlan_features |= netdev->features | other_offloads;
 	netdev->hw_enc_features |= dflt_features | other_offloads;
 	idpf_xdp_set_features(vport);
+	idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED);
 
 	idpf_set_ethtool_ops(netdev);
 	netif_set_affinity_auto(netdev);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 928de868fa62..fc56437b01ab 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3381,8 +3381,6 @@ int idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 	memcpy(vport->rx_itr_profile, rx_itr, IDPF_DIM_PROFILE_SLOTS);
 	memcpy(vport->tx_itr_profile, tx_itr, IDPF_DIM_PROFILE_SLOTS);
 
-	idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED);
-
 	idpf_vport_init_num_qs(vport, vport_msg, rsrc);
 	idpf_vport_calc_num_q_desc(vport, rsrc);
 	idpf_vport_calc_num_q_groups(rsrc);
-- 
2.56.0.611.g1030f0b940-goog

