Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7E606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=aTxdYYbZ;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=CCHeAtqe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D211160809;
	Mon,  9 Nov 2026 17:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tST9bEybP8ok; Mon,  9 Nov 2026 17:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D16CC6081F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244741;
	b=BaVfoJuJbCFE3IhPzWacmegEo8OkMbi/uONfaNnztVOyiH6/32NDSXCFkQK/nNuND42u
	 l0q+Rv46lD720KArGm2XVqo72WdQSVekwfx8K/pwxzPTOI6mInIzU3bErQ/dtNI5wndyR
	 39s5cM/cqCMYxQ32eoyBGXvD/ltG5xs0f8tqPVcSF20CW2YWxTySz6TY3keWjS6RuZvr2
	 vMC/faVUfLP3Ma0mrCh/HzbQK/dMoyZmqrCce6oNPnVhjnHSeWFTEkFFdLdZuJ/Qpgg3F
	 Zm01nSzei1FwUg/lBH0GMsIVhEFNqDlQJPXrFPp06YDBxgl/oRhJrpapGDtzJzu9nJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sg7nmjDxIAixbof136SBr2EkAZqYxcTSKOudRFI2tTA=;
	b=muRhpMbvu91vpL8lbN0/qc8KQ//2sslF4E7Mg1/xPPUPZmFtxeGnig0w09qfq11DnVth
	 lN/u6P/+hegqpDi2Z4Zx59wzAeDMPcrApXeZ7jLIXFm642bXH7z+3EbN9eocPqnenGP16
	 gpSaFemZbBKeVsbrXFawixoBMZRLdkTcrT8QmJ9be/gKydf2r9UN3OnYkizPboadwplt2
	 VHvZBxqLZDpgEmJBVI7gU5cKUqt81BviWtvd1aAW0Si+sfKfGt4nzzZU0u8NhgSMu/1r4
	 pK9JIrK2kc2NK4Wripb8KBz3ADPVGRph5+mqs55dt+kDgx7bqBawHTUaUjN/KUUWqQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244741;
	bh=sg7nmjDxIAixbof136SBr2EkAZqYxcTSKOudRFI2tTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTxdYYbZLR+SO0S1bCMHHD3I+1MX7rJYbypF2sHyhoXmmcg2U8fZe8GODHn/z027D
	 JW6jyIHBqIfLjma+SHN68nAWmzfy3D2wsLYBvXzSWeEyGGEq6t769EMt97Dj9OCySO
	 35D8Adb5v/EUmvcu31RvBbjvOJY9dA8JN/AKSnKA2HS7r68e4wWnUPMG67JyUzNSLD
	 ZGjLdccT1sjbTqQGWeEWuRqYmu/PjgNHX6ddX3J0swSVycKScBeuuHDGa/TmrR0Xd7
	 YSnkiDGYOXSdqSBRlKh0kHYZHMZZ+nV8WnjQYXaZVB/7tHNU47dF23eZRd/r521MmU
	 dW/o6oTMMwENA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D16CC6081F;
	Mon,  9 Nov 2026 17:19:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D4B21E3
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8ADBB4009B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdUAVOE8271r for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 18:44:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D982B4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=omar@blockcast.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=blockcast.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net
 header.a=rsa-sha256 header.s=google header.b=CCHeAtqe
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D982B4005F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:53 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso2799946eec.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 07 Nov 2026 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockcast.net; s=google; t=1794077092; x=1794681892; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sg7nmjDxIAixbof136SBr2EkAZqYxcTSKOudRFI2tTA=;
 b=CCHeAtqeic5d7NRcZr9bzTkVVnbKYmHoDARcgVuu+3DuHto6sB5MJIJN5ugQ4rhisy
 xRf4W1E8wQ0H0PfW+NLDIW9DAN/XPgXRFWNAsbzfuBY8e11x5TQMqHBK9E5v5XIB5NUU
 tp8mxcIyvtHySmWmwCZyzOLvQDeTUsyUl46G9NNMbBwEGwjUvvzrr4/igLzYvwapnRjo
 p6uB2FGgCrbCPp4SotqM4iuS6qJYXZTWBUAlvXoFHOkYx5Zoo9N0eRIbJWQrUU7U3cWn
 3m67fI9I8fc/VL4GnPUhSVv8aG08/+p5HZWSsqT+qRaxwLwbOEznSXFOCADid4GAg81A
 gRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077092; x=1794681892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sg7nmjDxIAixbof136SBr2EkAZqYxcTSKOudRFI2tTA=;
 b=oLimxMS//xiS6plAS9Y80G5N08C9gFPWLuUwsRPWsh4gG+GXD7jvxfPQw+6qj5DcIq
 a6k5mFrq94cYSC99AxqRrTosfoORXQe/jNQOhUedP9zHPpcW69d/IyFk43VMJvboCeiT
 jBE+UXMi1phIqKcOQMY9wfcB5LQ2fqR/S5NBf3D9rlVsUoDd7q+/pNvapWnSCEk8Izbg
 BFC5HmBO7xI0PuzezvTMgjv5ctSyEcbhVxOmEsRR/uj5Ld1tFaapcqbZw8qSZavju7jC
 nrkziUOQiSeyLYTINAJ51BPlsr+s9Cyjzn1As2zCPPXV7rMIQ5ScJZLf4d+N2kt/tEEb
 BnZw==
X-Forwarded-Encrypted: i=1;
 AL+hErFo/ZI0+ik0AeTAHWq4hrYL/ustBH+5XXZngIqwLfrNN06yoqEK+Mdvcm4MXPoO8I4v0d1kydMMsJHB5SJzFiQ=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9RSWEQl3I5OXA2xzknl/EpwOsxTrVmY4ay3r9B4J6roqCJ/Vax
 fPcCzXhHd65X6aWDva1YMeVPhNz0ojjjfW+hIHcBQ5Ea8COSbKf+9pFBbMBl30ITdpU=
X-Gm-Gg: AYBFou1uS0F3zPY/4W4IUoEp51xNjhIP6gaMcZ4/MmJTqPeePZ6EpysXbWmzxmMBctJ
 8uBpX5R2JaG7gVKgEU80W7gz5nQNazfC1/GmgqX4wuJuy1pOsnY593tQmqvPFM2+X9DqwL4vMiR
 9tghcWCu4TzPZGV9CjGH+f2ypaJv+1agByljHJ0Le7ZeQPaDoZ/fnquHvi9Y0yDVa0aPbJRm5aS
 I3z8lQLiEQHuSQfCZgFhHtp0GOv6S0TDL3sFqEzqfE+oY7a1UGU5kzcZ3kdZPmFny7OItPXtovS
 KvBTwdNl6VU3VV2kHxwH1tQXEbGMdGK1ji3NZjDJIYX3tuwDcah+KS1ovs9S/Auqg8181Q9c8/1
 9D8FYk7LZn9gOimB8KceHr2zuLfE5Yp9bmT5rKzOY+dpjJJZa+1iwA22xXjXAsN12J3mYFs5GtP
 /nELY90U2b/K7Y6aYn6zZBfkVPxYlhce9i41/kwUmoz+bCJx7GTLQOoY9TxznA4H35USvyF5/86
 wEaHDvra0kpkNPgON/Av33rR6wD6G3ux/v+5wg3z39chbeARSPfiKcrotV+7VSwQ7D9xbAdon5l
 4F4+hBYq2HISs10tKLtiha5ASZU+fn4vgnCCRa6mlG2J24oV5+4jrv/A/CsdT2Kex511saI=
X-Received: by 2002:a05:693c:881b:10b0:351:7ec1:a92c with SMTP id
 5a478bee46e88-36f76520e62mr9146148eec.28.1794077092493; 
 Sat, 07 Nov 2026 10:44:52 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:44:51 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 brett.creeley@amd.com, sgoutham@marvell.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 Ido Schimmel <idosch@nvidia.com>, Satish Kharat <satishkh@cisco.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 5/9] amt: add IFLA_AMT_OFFLOAD_MODE
Date: Sat,  7 Nov 2026 18:44:33 +0000
Message-ID: <20261107184437.2783174-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107184437.2783174-1-omar@blockcast.net>
References: <20261107184437.2783174-1-omar@blockcast.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 17:18:54 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

software (default), auto or required, after
IFLA_AMT_MAX_TUNNELS_PER_SOURCE. An unknown value, or a non-software
mode on a gateway, is refused with extack. required with no usable
provider on the stream device refuses the link with -ENODEV and extack.
Emitted by fill_info.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c        | 25 ++++++++++++++++++++++++-
 include/uapi/linux/amt.h |  7 +++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 377660e55..58e9da443 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -5719,6 +5719,7 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_NUM_QUEUES]	= NLA_POLICY_MAX(NLA_U32, AMT_MAX_QUEUES),
 	[IFLA_AMT_DISCOVERY_IP6] = NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[IFLA_AMT_REMOTE_IP6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[IFLA_AMT_OFFLOAD_MODE]	= { .type = NLA_U32 },
 };
 
 static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -5745,6 +5746,22 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
 		return -EINVAL;
 	}
 
+	if (data[IFLA_AMT_OFFLOAD_MODE]) {
+		u32 offload = nla_get_u32(data[IFLA_AMT_OFFLOAD_MODE]);
+
+		if (offload > AMT_OFFLOAD_MODE_MAX) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_AMT_OFFLOAD_MODE],
+					    "Offload mode is not valid");
+			return -EINVAL;
+		}
+		if (offload != AMT_OFFLOAD_MODE_SOFTWARE &&
+		    nla_get_u32(data[IFLA_AMT_MODE]) != AMT_MODE_RELAY) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_AMT_OFFLOAD_MODE],
+					    "Offload is only valid in relay mode");
+			return -EINVAL;
+		}
+	}
+
 	if (!data[IFLA_AMT_LOCAL_IP] && !data[IFLA_AMT_LOCAL_IP6]) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Local IPv4 or IPv6 attribute is required");
@@ -5802,6 +5819,9 @@ static int amt_newlink(struct net_device *dev,
 
 	amt->net = link_net;
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
+	amt->offload_mode = data[IFLA_AMT_OFFLOAD_MODE] ?
+			    nla_get_u32(data[IFLA_AMT_OFFLOAD_MODE]) :
+			    AMT_OFFLOAD_MODE_SOFTWARE;
 
 	if (data[IFLA_AMT_MAX_TUNNELS] &&
 	    nla_get_u32(data[IFLA_AMT_MAX_TUNNELS]))
@@ -5998,7 +6018,8 @@ static size_t amt_get_size(const struct net_device *dev)
 	       nla_total_size(sizeof(struct iphdr)) + /* IFLA_AMT_LOCAL_IP */
 	       nla_total_size(sizeof(struct in6_addr)) + /* IFLA_AMT_LOCAL_IP6 */
 	       nla_total_size(sizeof(struct in6_addr)) + /* IFLA_AMT_DISCOVERY_IP6 */
-	       nla_total_size(sizeof(struct in6_addr)); /* IFLA_AMT_REMOTE_IP6 */
+	       nla_total_size(sizeof(struct in6_addr)) + /* IFLA_AMT_REMOTE_IP6 */
+	       nla_total_size(sizeof(__u32)); /* IFLA_AMT_OFFLOAD_MODE */
 }
 
 static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
@@ -6068,6 +6089,8 @@ static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		goto nla_put_failure;
 	if (nla_put_u32(skb, IFLA_AMT_NUM_QUEUES, dev->real_num_tx_queues))
 		goto nla_put_failure;
+	if (nla_put_u32(skb, IFLA_AMT_OFFLOAD_MODE, amt->offload_mode))
+		goto nla_put_failure;
 
 	return 0;
 
diff --git a/include/uapi/linux/amt.h b/include/uapi/linux/amt.h
index de1ae1929..c67a1f763 100644
--- a/include/uapi/linux/amt.h
+++ b/include/uapi/linux/amt.h
@@ -122,6 +122,13 @@ enum {
 	 * AMT_MAX_TUNNELS_PER_SOURCE; raise it on a relay that fronts CGNAT.
 	 */
 	IFLA_AMT_MAX_TUNNELS_PER_SOURCE,
+	/* Relay mode: enum ifla_amt_offload_mode, default
+	 * AMT_OFFLOAD_MODE_SOFTWARE. Replication offload to a provider
+	 * registered on the IFLA_AMT_LINK device (include/net/amt_offload.h).
+	 * Required mode refuses creation with -ENODEV when no usable provider
+	 * is bound. Gateway mode accepts software only.
+	 */
+	IFLA_AMT_OFFLOAD_MODE,
 	__IFLA_AMT_MAX,
 };
 
-- 
2.43.0

