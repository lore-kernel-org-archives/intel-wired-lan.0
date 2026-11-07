Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1594606A339
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LtoU6GkE;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=QGWpQ9Rd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFED1607FC;
	Mon,  9 Nov 2026 17:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KrjDLj1x2C88; Mon,  9 Nov 2026 17:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59E0360803
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244739;
	b=iT1fr151ISLNMqGdqhaVYNP36OaDLzkqtrF0VrovYeQy6FJis0sGq7xaCG+nIsI26kLw
	 BCWKfdweLWTOX0WYRVfhLq0U9BIjrevjIV55ke4z7OowQGheu1vKfwtFQt8hS99pdq2gC
	 w4RNKUf/3Ghh8Eha+ykxtzspeVUwW5JpuqVGK5aqQlDi+FXWNNaXzrFuUd5N/kUMHNxRu
	 5gG0qOCK5l3UA1GDsGIOKFV4CeyLZJ/93Dlk/Xb3sgufFVsXt+Gz4/CZ/AmBuIHCzDbhS
	 z/TVK4RGWiybvKzdYVNi2TajsE+1c2KXv3MVdmNyI76c6T7djoXo81oXTTAbmFGH30g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KZ+ukhZnuLhEoTcJCFbadpKzgvv+xdEMUoSf7p2jX1E=;
	b=L+/AGNTBw7+Sv0aVPhTaKhjiOEhyBm+x8z5UjYWF9O7YPvwGEGowb3e/xdj+PTIBg1QA
	 Ilk6meuk6vUC+S3lWW69mxa8WE7eGDitl+1nLmfzPO4IGHwrFQmq+juPjAyXl/dqEN/P+
	 SQ4qjQ7eCN0W82x4up8slOu1OB1J1R+Xy2ByVpV3UAs7JVyRj7s+v07s1VdqjKvibXHFe
	 jUETIu3pcpcLyXeufDQmDVoxyfTO+3nGbCyMYyFrkV333Xdte3VlHo+ZLiD9GgnmXKaN6
	 /y6RQFpZ/fqsRBT+ksDBx1PdANM2Bvv0H1dtVK2qqun7tj5r6IyxvJ0r8PHHOjmOJag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244739;
	bh=KZ+ukhZnuLhEoTcJCFbadpKzgvv+xdEMUoSf7p2jX1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LtoU6GkE91ZuaaHVaXVzPP9ewDdJ5D/jfGJYcfgoi6SXXxgCZIUuKsmMXSrygiwfY
	 P+7b1SBeM81NYxdCd3/z65UDO63q0jEXNtmdA8fCqIP/JCIN/0QqYtMhPNYYcbPXaD
	 TKq8T4wrJ9ntTbKd5/jxdHBhhCpofyPLx/p9coC1Xl5AqwMNf8sJdfnRmZm5Bu1wyK
	 ALqUf0k6twCSFirNP/k9xF0yFrTNRLhh94jpW3QlmSsgl5Aqv05HgM686LAnPSh6Rp
	 mRPn6rjjxmfUlTYBHbkxL9Y0ndd1MvYZpxcBDDegwKOAxtzH3CErNxYtafQ0F8Eui7
	 u64mjHi0TG65A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59E0360803;
	Mon,  9 Nov 2026 17:18:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C4BF422
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D91081271
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZKnRvZrrxZiM for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 18:44:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 312328126B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=omar@blockcast.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=blockcast.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=blockcast.net header.i=@blockcast.net
 header.a=rsa-sha256 header.s=google header.b=QGWpQ9Rd
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 312328126B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:44 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so2804906eec.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 07 Nov 2026 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockcast.net; s=google; t=1794077084; x=1794681884; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KZ+ukhZnuLhEoTcJCFbadpKzgvv+xdEMUoSf7p2jX1E=;
 b=QGWpQ9Rdr4Sevih2U8nYZX8Mj0B7/JOLiy8CVUh1nOBEsgaH4azkV+fW4NQtX6uAnp
 wOCOIf1Z1GIK73CB1t+bSt5Ed+eRcQQhofkPXIjGLkywbnp4t+9s6leXPhlBgGYQLnoq
 wrN8BFVVqoW5e/KzkTJB54j5169OT1hUFzVXhilMj0glUyeP86o+PI/Jv453nSLqlMxm
 aDFMw336TC8qj0Ukx+tLqCZ1Gt+YJUH7Qq6X3PboCuxPsPCGCqfi4YnQL60gYPhW4YSa
 wRAGjDvATY2T4GXn3bW3dp2/4DDEynmobKGx5fUvWD0ovrfez/ts46usn96IWAi0B5HU
 wQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077084; x=1794681884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KZ+ukhZnuLhEoTcJCFbadpKzgvv+xdEMUoSf7p2jX1E=;
 b=TqMTSiCn9qVjbrUuHf/0TmkgZxJAF1l6ceoh79S/VGUm8T5fAtWESYx2fqwFVsVRl6
 /8lYtQ85EMhny4F6tyd030E5zsIyQRtYZPSb5fF3CX3XMHd/5rhZqN0C8sEt5hMreiP9
 /rbff2dSlQ97vMv7UQQSblIfNsaXBLu5PlahJ8mF20vQ2GcyB4gPIYkPfhWdyUYwluEP
 JvZL9SiWvi+ZibQfbVlBuB8xKY5rbHrHEJ7qqPmFPhLtBNcn/btkTyJo+FwB3Dbj5XQA
 WXrDHluE9RIYKc3mpDTPfttVXnswJuL5yPHDsZWR0Ioyq183fP187dxZS/m9f2IsEmfH
 Roww==
X-Forwarded-Encrypted: i=1;
 AL+hErFDqT2ty79sgDkALnGDoexEVTuCWZkeLTMB2pnyYhtmb83YTBIx4wjIA+RY/KmEFuEMpFRdJXshwXAAn2F+PGo=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9OJ2fcoAz7XtZDzJKn9dJgRL/NLrz4vTIOm3wEuzFXtiQztRk3
 2PNxS/3p3w7hrgdIB9KOeAYr/PF/RYyVe1HXHL6vf35nobPgHSU1a3CmUULAvrRSzJ4=
X-Gm-Gg: AYBFou23fDcweME9oQtP14Q3oEP192P67mHUdEJ3jO1a1f2XOA+o0o0qK9DQXHBgtln
 rDr8UGnTiuwkyBUi+Pc9FE3wDSTY1lD521v4j6t09/B4FlOvDlf7mPIBcHL8KVk9clGLho5juDy
 51Ss5r1QGnVma6PQiGwqNKcimQxA3MM1GV3v04FwVCR3is2p0xUTxQX2unSUQucDIerjbmR60+B
 vtmbOD6L8Gxnakga+7esmnhmgCinNWDfaOYvFDJKaWSxNJtV8+HtJkkxiUJ97lJeGYBdadpSvk2
 zzn5wCFcGeR6kevVBX8nonGchAfxJsiew9B44U+tbpx7KNZ+pKmLX3UdUp7wynyqo6U17RZt9QL
 YlKQbt6deH2d6tv+VwLFRPjFlnimdq6O6WjJiVwoJFiRgi4PvPHCBzvKStrdfqDsXyXVLpEylZj
 NIFjtv9qtEoCJLQi9qA+A3kRz6xzm3vlPBFoj9LXMrfIltdqd2VhC09Ir2e43qKSZioApn6/I3r
 m0E22/Sv23FK5zcB55Ikh+HQuuEVOb5La6tGDW1R+8K9FMDowNO3O03Hwaxb17xs4kQSAtQfeOe
 MBfB6xdKj0MRpjDdcknPhuz2aUfK2FSjF7BHnBftQ+3Ef62NvBV1kpfbx6G/NmIVtCWap5A0lil
 kx1frjuu05Al6kExQ
X-Received: by 2002:a05:7301:f0b:b0:366:83dd:46f7 with SMTP id
 5a478bee46e88-36f75a26838mr8205255eec.17.1794077083543; 
 Sat, 07 Nov 2026 10:44:43 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:44:42 -0800 (PST)
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
Subject: [RFC PATCH net-next 1/9] amt: add the relay replication offload
 provider header
Date: Sat,  7 Nov 2026 18:44:29 +0000
Message-ID: <20261107184437.2783174-2-omar@blockcast.net>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

include/net/amt_offload.h: provider caps, opaque provider-owned endpoint
and group handles, struct amt_offload_ops, TX/INGRESS paths,
FALLBACK/CONSUMED/BUSY results, the per-binding u64 epoch, and the
amt_offload_register()/amt_offload_unregister() entry points. An
in-kernel interface with no ABI promise; nothing touches struct
net_device or net_device_ops.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 include/net/amt_offload.h | 263 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 263 insertions(+)
 create mode 100644 include/net/amt_offload.h

diff --git a/include/net/amt_offload.h b/include/net/amt_offload.h
new file mode 100644
index 000000000..3be5d129c
--- /dev/null
+++ b/include/net/amt_offload.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMT relay replication offload: the contract between the amt driver and
+ * a provider that replicates relay multicast data to gateways in hardware
+ * (or, for testing, in a simulated device).
+ *
+ * This is an IN-KERNEL INTERFACE WITH NO ABI PROMISE. It may change in any
+ * release, like every other in-kernel API; out-of-tree providers get no
+ * stability guarantee.
+ *
+ * Registration is keyed by the lower netdev a relay transmits on (its
+ * IFLA_AMT_LINK stream device). Nothing here adds a field or an ndo to
+ * struct net_device.
+ */
+#ifndef _NET_AMT_OFFLOAD_H_
+#define _NET_AMT_OFFLOAD_H_
+
+#include <linux/bits.h>
+#include <linux/in6.h>
+#include <linux/types.h>
+
+struct net_device;
+struct sk_buff;
+
+/* Outer transport families, for &amt_offload_caps.families. */
+#define AMT_OFFLOAD_FAMILY_V4		BIT(0)
+#define AMT_OFFLOAD_FAMILY_V6		BIT(1)
+
+/*
+ * Reserved: (S,G)-keyed forwarding. v1 forwards per (family, group) exactly
+ * as the software path does, so this bit has NO v1 semantics. A provider
+ * must not set it; amt ignores it.
+ */
+#define AMT_OFFLOAD_F_SOURCE_FILTER	BIT(0)
+
+/**
+ * enum amt_offload_path - where a provider replicates
+ * @AMT_OFFLOAD_PATH_TX: amt hands the provider each relay data packet of
+ *	a group whose commit it has published (&amt_offload_ops.group_commit),
+ *	before its software fan-out (&amt_offload_ops.xmit), while the binding
+ *	admits packets and amt has not lost its desired state. amt withdraws a
+ *	group without a callback when a member leaves, until it publishes the
+ *	recommit. Every other packet goes straight to software.
+ * @AMT_OFFLOAD_PATH_INGRESS: the provider replicates on ingress and the
+ *	host only sees punted packets. Semantics only until a real provider
+ *	exists; no simulated provider implements it.
+ */
+enum amt_offload_path {
+	AMT_OFFLOAD_PATH_TX,
+	AMT_OFFLOAD_PATH_INGRESS,
+};
+
+/**
+ * struct amt_offload_caps - what a bound provider can do
+ * @families: AMT_OFFLOAD_FAMILY_* outer families it can encapsulate. A
+ *	relay whose outer family is missing stays unbound (counted), with the
+ *	outcome of a failed &amt_offload_ops.bind, except that amt first calls
+ *	&amt_offload_ops.unbind, since that bind succeeded.
+ * @paths: BIT(enum amt_offload_path) it implements.
+ * @op_timeout_ms: longest a programming op may take before amt treats the
+ *	provider as wedged, resets it and replays from desired state.
+ * @features: AMT_OFFLOAD_F_* bits. None has v1 semantics.
+ * @max_endpoints: endpoint table size; 0 means unbounded. Informational:
+ *	amt does not read it in this version. A provider out of room fails an
+ *	&amt_offload_ops.endpoint_add for a key it does not hold, by
+ *	convention with -ENOSPC.
+ * @max_groups: group table size; 0 means unbounded. Informational: amt
+ *	does not read it in this version. A provider out of room fails the
+ *	&amt_offload_ops.group_update that needs a new group, by convention
+ *	with -ENOSPC.
+ *
+ * Filled by &amt_offload_ops.bind.
+ */
+struct amt_offload_caps {
+	u32 families;
+	u32 paths;
+	u32 op_timeout_ms;
+	u32 features;
+	u32 max_endpoints;
+	u32 max_groups;
+};
+
+/**
+ * struct amt_offload_binding - one relay device bound to one provider
+ * @lower: the registered lower netdev (the relay's stream device).
+ * @dev: the amt relay netdev.
+ * @epoch: monotonic per relay device, bumped on every bind, reset and
+ *	teardown. A completion carrying an older epoch is stale and ignored.
+ * @priv: provider-owned; amt never touches it.
+ *
+ * Allocated and freed by amt. Valid from &amt_offload_ops.bind until
+ * &amt_offload_ops.unbind returns.
+ */
+struct amt_offload_binding {
+	struct net_device *lower;
+	struct net_device *dev;
+	u64 epoch;
+	void *priv;
+};
+
+/**
+ * struct amt_offload_endpoint_key - one gateway's outer endpoint
+ * @family: AF_INET or AF_INET6, the relay's outer family.
+ * @addr: gateway outer address.
+ * @addr.ip4: IPv4 address when @family is AF_INET.
+ * @addr.ip6: IPv6 address when @family is AF_INET6.
+ * @port: gateway outer UDP port (tunnel identity is address + port).
+ */
+struct amt_offload_endpoint_key {
+	u8 family;
+	union {
+		__be32 ip4;
+		struct in6_addr ip6;
+	} addr;
+	__be16 port;
+};
+
+/**
+ * struct amt_offload_group_key - one replicated group
+ * @family: AF_INET or AF_INET6, the INNER group family.
+ * @group: group address.
+ * @group.ip4: IPv4 group when @family is AF_INET.
+ * @group.ip6: IPv6 group when @family is AF_INET6.
+ *
+ * Forwarding is per (family, group), never per source: a gateway holding
+ * an INCLUDE(S1) membership still receives S2, exactly as the software
+ * fan-out does today.
+ */
+struct amt_offload_group_key {
+	u8 family;
+	union {
+		__be32 ip4;
+		struct in6_addr ip6;
+	} group;
+};
+
+/* Provider-owned table entries. amt only stores the pointers. */
+struct amt_offload_endpoint;
+struct amt_offload_group;
+
+/**
+ * enum amt_offload_result - outcome of &amt_offload_ops.xmit
+ * @AMT_OFFLOAD_FALLBACK: skb untouched; amt runs its software fan-out.
+ * @AMT_OFFLOAD_CONSUMED: the provider handled every copy of this packet
+ *	under the generation it was given and owns the skb; amt emits none and
+ *	retries none. A copy that failed is the provider's to count, except one
+ *	amt_offload_encap_xmit() could not copy or route, which amt has already
+ *	counted in the relay's tx_dropped.
+ * @AMT_OFFLOAD_BUSY: skb untouched; amt runs one synchronous software pass
+ *	and counts it. Never NETDEV_TX_BUSY: the relay is IFF_NO_QUEUE.
+ *
+ * Exactly one actor handles each packet, so no packet is duplicated.
+ */
+enum amt_offload_result {
+	AMT_OFFLOAD_FALLBACK,
+	AMT_OFFLOAD_CONSUMED,
+	AMT_OFFLOAD_BUSY,
+};
+
+/**
+ * struct amt_offload_stats - provider-side counters
+ * @tx_packets: copies the provider emitted.
+ * @tx_bytes: bytes of those copies on the wire.
+ * @tx_dropped: copies the provider failed to emit.
+ */
+struct amt_offload_stats {
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_dropped;
+};
+
+/**
+ * struct amt_offload_ops - provider callbacks
+ * @bind: a relay transmitting on the registered lower device starts using
+ *	this provider. Fill @caps. Process context, RTNL held. Nonzero leaves
+ *	the relay unbound (counted): in software in auto mode; in required
+ *	mode refused if it is being created, else without carrier.
+ * @unbind: last call for a binding. Every endpoint and group has already
+ *	been deleted or disabled. Free @b->priv. RTNL held.
+ * @endpoint_add: program one gateway endpoint. Idempotent: an identical
+ *	key returns the existing handle. 0 means accepted and durable, not yet
+ *	forwarding. Process context, never under amt's spinlocks.
+ * @endpoint_del: remove an endpoint no group references any more.
+ * @group_update: stage the member set of one group under generation @gen,
+ *	allocating *@grp on first use. Not forwarding until @group_commit.
+ * @group_commit: start forwarding generation @gen of @grp. amt hands @gen
+ *	to @xmit only after this returns 0, and may never do so: an overrun
+ *	resets the provider, and on TX a member leaving meanwhile withholds
+ *	the commit until the next one. Until amt publishes @gen, any @xmit for
+ *	@grp carries an earlier generation this provider committed, and a call
+ *	already in flight may carry any of those or @gen itself; the provider
+ *	serves such a generation or declines it. A provider must never emit
+ *	one packet to one endpoint under two generations. On failure the group
+ *	stays in software and previously added endpoints stay valid.
+ * @group_disable: stop forwarding @grp and free it.
+ * @xmit: TX path. Replicate @skb for @grp under @gen or decline; see
+ *	&enum amt_offload_result. Softirq context, under rcu_read_lock().
+ * @flush: drop every endpoint and group (reset after a timeout). amt then
+ *	replays from its own desired state under a new epoch, except when
+ *	the op that overran was a @group_disable or @endpoint_del of amt
+ *	giving everything back -- at teardown, where @unbind follows, or
+ *	after its desired state was lost: then nothing is replayed and the
+ *	epoch does not move.
+ * @stats: fill @st. Optional; amt does not call it in this version.
+ *
+ * Teardown order, on unregistration of the lower device and on
+ * amt_offload_unregister(): amt stops admitting packets to @xmit, waits for
+ * in-flight @xmit calls, cancels its programming work, calls @group_disable
+ * for every group, @endpoint_del for every endpoint, then @unbind, then
+ * synchronize_rcu(); the relay is back in software afterwards. If one of
+ * those @group_disable/@endpoint_del calls overruns op_timeout_ms, amt
+ * calls @flush once instead of the rest, then @unbind, with no replay.
+ */
+struct amt_offload_ops {
+	int (*bind)(struct amt_offload_binding *b,
+		    struct amt_offload_caps *caps);
+	void (*unbind)(struct amt_offload_binding *b);
+	int (*endpoint_add)(struct amt_offload_binding *b,
+			    const struct amt_offload_endpoint_key *key,
+			    struct amt_offload_endpoint **ep);
+	void (*endpoint_del)(struct amt_offload_binding *b,
+			     struct amt_offload_endpoint *ep);
+	int (*group_update)(struct amt_offload_binding *b,
+			    const struct amt_offload_group_key *key,
+			    struct amt_offload_endpoint *const *members,
+			    unsigned int nr_members, u64 gen,
+			    struct amt_offload_group **grp);
+	int (*group_commit)(struct amt_offload_binding *b,
+			    struct amt_offload_group *grp, u64 gen);
+	void (*group_disable)(struct amt_offload_binding *b,
+			      struct amt_offload_group *grp);
+	enum amt_offload_result (*xmit)(struct amt_offload_binding *b,
+					struct amt_offload_group *grp,
+					struct sk_buff *skb, u64 gen);
+	void (*flush)(struct amt_offload_binding *b);
+	void (*stats)(struct amt_offload_binding *b,
+		      struct amt_offload_stats *st);
+};
+
+/**
+ * amt_offload_register - offer a provider for relays on @lower
+ * @lower: the netdev the relays transmit on.
+ * @ops: provider callbacks; must outlive the registration.
+ *
+ * Every relay already using @lower in auto or required mode tries to bind
+ * now. Caller holds RTNL.
+ *
+ * Return: 0, -EEXIST if @lower already has a provider, or -ENOMEM.
+ */
+int amt_offload_register(struct net_device *lower,
+			 const struct amt_offload_ops *ops);
+
+/**
+ * amt_offload_unregister - withdraw the provider for @lower
+ * @lower: as passed to amt_offload_register().
+ *
+ * Tears every binding down in the documented order and returns with every
+ * relay on @lower in software. Caller holds RTNL. A no-op if @lower has no
+ * provider, which is the case after @lower itself was unregistered.
+ */
+void amt_offload_unregister(struct net_device *lower);
+
+#endif /* _NET_AMT_OFFLOAD_H_ */
-- 
2.43.0

