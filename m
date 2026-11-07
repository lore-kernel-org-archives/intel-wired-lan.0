Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4E606A339
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Dq3JkSW/;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=Ng4AsTHG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C82480DB1;
	Mon,  9 Nov 2026 17:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ny2yqNkfWHRo; Mon,  9 Nov 2026 17:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33B7E80F20
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244740;
	b=ZWB9fM45kQrJ/iHKv7FsHgYJc2CiIfXplGy6s0ykyfOP34e8L6ynBr28+WknFWJ/pD9h
	 p0qXoD569b5rkpk6DK5SjsZPvatRziqz0yFe4i7BX5ACRlxmHV1eFGYswQM7yW8KGkAse
	 W4GjJSRRYm57798Hqw2UHNH0LrsJTKEbUj4uFDkWiSX6+CDbBpo01oJUES/lUusrJ+Dtq
	 StvPV9ybVzca3OFSFOh81FKn+BVUpueaa/JeZ1e5++UNeZlNMClI6H0XhQS67YB5Gsu/v
	 O3Xa8bU6wJmnDwMcgdFOQ2osjHzLBS9Eaun/xmahzSuBYE+iT7kq/w+GIYZYHReJ3Og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244740;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xYAGS+XY4LIyYAiAoo2wIS0oAg0GDCdOlyiXz1Uxi6Y=;
	b=aTjPktImIOR1LA8jEKcmtDJItCxZCnwnwmUY6twJ3XZfkcSHmX/jZmh/UDLjkXo/FlFc
	 MQd/I+egdHVSvHO/8dliw8F0KoLBe58p+cIzkw2p28lXy+EqqAfaHXfmiQ9Vyil+zbvUW
	 rECKQe3g9iJF1zesFZY2F+EeCJqGh5OUBqKOygkRFMikYjmvYVOnJadxDdIv3k9ggwb2h
	 8anTP5bsrtkfGSAmZivsCu4PLy32q1s/+ui2eZTTWOa8vItbF+qqE2Wb/tH53HOkLl06/
	 f8HD/CkKQtVlUbkTSzIHTsU/d+DliWfMyDB2Lw04kSMtH1vuhTDOIXego1a+IWKrDJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244740;
	bh=xYAGS+XY4LIyYAiAoo2wIS0oAg0GDCdOlyiXz1Uxi6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dq3JkSW/3H1ot8xU7yqDKKhJQZIAEsFi9jiftMPmwOTHw/Rh8uXe4uHWNd0El7cTm
	 JJ/RxztL/0VH0HGiie2kvYnlHB8T6srCcGqkWEnleIhQKRyvVSuSHgvSjEM1i2+BN8
	 gDbcztdtK6HyqaDGIEKON+9wJMU6Y0fT5Rj0HalmLqwQIieyRM7nI04g6QY2OtKuDj
	 arTrTw/UYrQPXJ+rF7aScmGnXToMhkPKEWQ38NL6ef+65bWQlXvUJa4+7IdKITmzsc
	 Xd7NYredIduGOp/mpa/KeZqvN/h5UPGIDrUJ7JYsiWI54bToTo17M+NwqjbvnbG4Ud
	 ubax0bhhXBZ6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33B7E80F20;
	Mon,  9 Nov 2026 17:19:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E44591E3
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA34B406FE
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GprRvaGf11qx for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 18:44:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76A9D406F0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=omar@blockcast.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=blockcast.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=blockcast.net header.i=@blockcast.net
 header.a=rsa-sha256 header.s=google header.b=Ng4AsTHG
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76A9D406F0
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:47 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso2683550eec.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 07 Nov 2026 10:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockcast.net; s=google; t=1794077086; x=1794681886; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xYAGS+XY4LIyYAiAoo2wIS0oAg0GDCdOlyiXz1Uxi6Y=;
 b=Ng4AsTHGDizpxfrzPAY9vGbMcKNOI6R/r3Os25zBR2APOx574tMp984tBOFoKGOGXn
 7MSQn3JABmWbgD3juDtwUjQvXazVnygigZf6G+yC+E9xNzUyHRwMAvvY53VsyPDj6pe7
 GmjGJcdEe1WoSFRI77CN2UVRLcvvbkE1pZCvr5UOjLC7zgIxQo2jfIIN4jCxCUBgT+4O
 D3UXAX8YvJbEJ/nXGpX/tsrkrGfGt9T+hZ7sOyJrs15xUhBsKkyW4Yb+VfJQZKcCkKMt
 msYH4n0iNCYOO/Ksl9oi4ssUeOdMzo8qvmx7MmeNQdMVKK7vrrzx13/tQDDSy5VeiQbL
 IK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077086; x=1794681886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xYAGS+XY4LIyYAiAoo2wIS0oAg0GDCdOlyiXz1Uxi6Y=;
 b=pC0Xtm9qcs69qmEJRl26+ZHv+3Q39VLjjvRNNIm8VsUAEbqainCa1QQMPwqil4wwaT
 RZKDtYmaUPuOVV7clmWgCpulKcI4OnEKN/r+fk3UHh93rnARYQPsd+PXHtQO7Lk3LCgG
 pzmG6HHkR9PSaH7KnmxKrgnO2lgASvJFN3qqDkb34+fzzb+uLjAnTAtlTADkUIBAho5r
 Wbj8R0R0WtbPSpJp4+0cGKXOCnSjpsf5cJqhAQaM21pg+wODnUeEt3v+kh3etBgo9KnP
 /RMS7hm9A6XgeEhDXTeJ8N9Lh5u4yRbpWyIwmgBB9P+mnnuPlpxCH0FoVmCMU2aQ8DMu
 YcTg==
X-Forwarded-Encrypted: i=1;
 AL+hErGax0ARfK0NRUauVbDXKhTQqAjCIIqpavTaAS2o9TfuFDGj9r5jsObwE4sgU5q6KJPvb8M7XMLCfpxtQMaU+6I=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8VLnYJLl8HCxrGQHwi2Qwnqis5Rk6B8Q59qWkOvo7tLVHKQTrm
 cPEL7qg2wztNQupJrv0P1PsUvKAdy4NgENE27YpH7gri1HydmOVZQt2IVBzMooGbXzs=
X-Gm-Gg: AYBFou0onfZyRzxPp6Qr3TpIb+eUvyhz8AhumuJQKb32Ve1mXdqTS9yAmclJpj7Cc2D
 gm6VOF2DTPbyRBAaNOu2dL4Rha+dqIf+rtQ7awZRvnbSfQF7G3KQMX+NXMfiDN40du1ThJXnzAy
 mjF6qRi95puLSQT8fnR/dIcoiRcL0TaQi4uGnA4/CHuhyzNx6PUO8OHtkL5DACCm4pr4ono/u/0
 HO5wujWjVDBKwTeOPDerhdjF5La+yL13vRSMZF+CzAs+zz5oMq31bm20KU8nPexevMRpoID62jp
 tCIjqc7wkDwPemMFIpo78wAM9teXBuO16KRK1hmZGCWKsGqM+2v29vEAYEegdKexkpjfolcUEvk
 bbAd3oFYVtDAFBujfBTuklxk4kKYZFa8NcEL7ZrnBtMNvmMdFHccPj4tPRQXilDfbV77OhxhMbk
 kZoAlgLJYOVprEq2/VQiY3wme9/SqrBtsUH+RDxQIZWp+k1eixB9yP/prSL4S/1J4l71X+CHNX+
 FT8LqU+KpUF3mz4KJfLOmG9646ozie9hsFCgxP6jvizkNGhXiAn1oEGsjC3vwrzZaZ6jUjFENrY
 37pRx5urfwRLQL4wCAaBszVzA8mP0Vt96yvbQWLQlwPJn2Y8OrjfJTk1ndPnhyfJdsjSDsA=
X-Received: by 2002:a05:693c:80c1:b0:36a:1732:1e7 with SMTP id
 5a478bee46e88-36f76d0f26emr8538567eec.31.1794077085833; 
 Sat, 07 Nov 2026 10:44:45 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:44:45 -0800 (PST)
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
Subject: [RFC PATCH net-next 2/9] amt: offload provider registry and
 lower-device lifecycle
Date: Sat,  7 Nov 2026 18:44:30 +0000
Message-ID: <20261107184437.2783174-3-omar@blockcast.net>
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

amt_offload_register()/amt_offload_unregister() (EXPORT_SYMBOL_GPL) keep
an RCU list of providers keyed by the lower netdev. Relays are listed at
newlink; a relay in auto or required mode whose stream_dev has a
provider binds there, and registering a provider on a stream_dev binds
the auto and required relays already using it at once (counted). bind()
fills caps; a relay whose bind() fails, or whose outer family the caps
lack, stays unbound (counted): in software in auto mode, refused at
creation or left without carrier in required mode.

On NETDEV_UNREGISTER of the lower device (before amt_dellink), on
provider unregistration and on relay deletion, teardown runs in one
order: stop admission and wait out in-flight xmit, cancel programming
work, group_disable all, endpoint_del all, unbind, unpublish,
synchronize_rcu, software. A required-mode relay that loses its provider
drops carrier. Counters are under the relay's offload/ sysfs group; the
global required-refusal count is the offload_required_refused module
parameter.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c        | 425 +++++++++++++++++++++++++++++++++++++++
 include/net/amt.h        |  34 ++++
 include/uapi/linux/amt.h |  20 ++
 3 files changed, 479 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 201421ad0..034221e1c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -20,6 +20,7 @@
 #include <net/icmp.h>
 #include <net/mld.h>
 #include <net/amt.h>
+#include <net/amt_offload.h>
 #include <uapi/linux/amt.h>
 #include <linux/security.h>
 #include <net/gro_cells.h>
@@ -3464,9 +3465,11 @@ static int amt_dev_stop(struct net_device *dev)
  * lifetime matches vxlan/geneve and the rest of the netdev tree.
  */
 static const struct attribute_group amt_upstream_group;
+static const struct attribute_group amt_offload_group;
 
 static const struct attribute_group *amt_groups[] = {
 	&amt_upstream_group,
+	&amt_offload_group,
 	NULL,
 };
 
@@ -4028,6 +4031,414 @@ static void amt_link_setup(struct net_device *dev)
 	ether_setup(dev);
 }
 
+/* Relay replication offload: provider registry and lower-device lifecycle.
+ *
+ * A provider registers against the lower netdev relays transmit on (their
+ * stream_dev); there is no net_device field or ndo. Every relay is linked
+ * into amt_offload_devs at newlink so registration can find the relays
+ * already using that lower device. Both lists are written under RTNL;
+ * amt_offload_providers is an RCU list so a reader outside RTNL can test
+ * for a provider without it.
+ *
+ * Teardown has one order, whichever side goes first (the lower device is
+ * unregistered, the provider unregisters, or the relay is deleted): stop
+ * admitting packets to ops->xmit and wait out in-flight callers, cancel
+ * programming work, group_disable every group, endpoint_del every
+ * endpoint, unbind, unpublish and synchronize_rcu(). The relay is then
+ * in software, exactly the path it runs with no provider at all.
+ */
+struct amt_offload_provider {
+	struct list_head		node;
+	struct net_device		*lower;
+	const struct amt_offload_ops	*ops;
+	struct rcu_head			rcu;
+};
+
+/* One provider-owned handle amt must give back on teardown. */
+struct amt_offload_ref {
+	struct list_head		node;
+	void				*handle;
+};
+
+struct amt_offload_bound {
+	struct amt_offload_binding	pub;
+	const struct amt_offload_ops	*ops;
+	struct amt_offload_caps		caps;
+	/* Cleared first on teardown; ops->xmit is only called while set. */
+	bool				admitting;
+	struct list_head		groups;		/* amt_offload_ref */
+	struct list_head		endpoints;	/* amt_offload_ref */
+};
+
+static LIST_HEAD(amt_offload_providers);
+static LIST_HEAD(amt_offload_devs);
+
+/* Relays refused at newlink for want of a provider in required mode. The
+ * refused netdev is unregistered again before newlink returns, so the
+ * count cannot live on it.
+ */
+static atomic_t amt_offload_required_refused = ATOMIC_INIT(0);
+
+static int amt_offload_required_refused_get(char *buf,
+					    const struct kernel_param *kp)
+{
+	return sysfs_emit(buf, "%u\n",
+			  (u32)atomic_read(&amt_offload_required_refused));
+}
+
+/* Read-only, but a load-time value still reaches ->set: parse_one()
+ * calls it without a NULL check (only the sysfs store path checks), so
+ * a get-only ops oopses the loader. Ignore the value rather than fail
+ * the load, so a stray modprobe option cannot keep the relay down.
+ * NOARG: a bare "amt.offload_required_refused" would otherwise be
+ * -EINVAL in parse_one() before ->set, and fail the module load.
+ */
+static int amt_offload_required_refused_set(const char *val,
+					    const struct kernel_param *kp)
+{
+	pr_warn("offload_required_refused is read-only; ignoring \"%s\"\n",
+		val ? val : "");
+	return 0;
+}
+
+static const struct kernel_param_ops amt_offload_required_refused_ops = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = amt_offload_required_refused_set,
+	.get = amt_offload_required_refused_get,
+};
+module_param_cb(offload_required_refused, &amt_offload_required_refused_ops,
+		NULL, 0444);
+MODULE_PARM_DESC(offload_required_refused,
+		 "Relays refused at creation: offload=required and no usable provider");
+
+static void amt_offload_count(struct amt_dev *amt,
+			      enum amt_offload_counter cnt)
+{
+	atomic_inc(&amt->offload_cnt[cnt]);
+}
+
+static struct amt_offload_provider *
+amt_offload_provider_find(const struct net_device *lower)
+{
+	struct amt_offload_provider *p;
+
+	ASSERT_RTNL();
+	list_for_each_entry(p, &amt_offload_providers, node)
+		if (p->lower == lower)
+			return p;
+	return NULL;
+}
+
+static u32 amt_offload_outer_family(const struct amt_dev *amt)
+{
+	return ipv6_addr_any(&amt->local_ipv6) ? AMT_OFFLOAD_FAMILY_V4 :
+						 AMT_OFFLOAD_FAMILY_V6;
+}
+
+/* The data path's way in: a binding is usable only while admitting. The
+ * caller holds rcu_read_lock(). The later TX handoff is its first caller.
+ */
+static __maybe_unused struct amt_offload_bound *
+amt_offload_tx_admit(struct amt_dev *amt)
+{
+	struct amt_offload_bound *b = rcu_dereference(amt->offload);
+
+	return b && READ_ONCE(b->admitting) ? b : NULL;
+}
+
+/* Record a handle the provider handed back; the later reconciler is the
+ * production caller.
+ */
+static int __maybe_unused amt_offload_track(struct list_head *list,
+					    void *handle)
+{
+	struct amt_offload_ref *ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+
+	if (!ref)
+		return -ENOMEM;
+	ref->handle = handle;
+	list_add_tail(&ref->node, list);
+	return 0;
+}
+
+static void amt_offload_set_carrier(struct amt_dev *amt, bool on)
+{
+	if (amt->offload_mode != AMT_OFFLOAD_MODE_REQUIRED)
+		return;
+	if (on)
+		netif_carrier_on(amt->dev);
+	else
+		netif_carrier_off(amt->dev);
+}
+
+/* Bind @amt to @p. 0 means bound; an error leaves @amt in software and
+ * counted. RTNL held.
+ */
+static int amt_offload_bind(struct amt_dev *amt,
+			    struct amt_offload_provider *p, bool on_register)
+{
+	struct amt_offload_bound *b;
+	int err;
+
+	ASSERT_RTNL();
+	if (amt->mode != AMT_MODE_RELAY ||
+	    amt->offload_mode == AMT_OFFLOAD_MODE_SOFTWARE ||
+	    rtnl_dereference(amt->offload))
+		return -EINVAL;
+
+	b = kzalloc_obj(*b, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+	b->pub.lower = p->lower;
+	b->pub.dev = amt->dev;
+	b->pub.epoch = ++amt->offload_epoch;
+	b->ops = p->ops;
+	INIT_LIST_HEAD(&b->groups);
+	INIT_LIST_HEAD(&b->endpoints);
+
+	err = b->ops->bind(&b->pub, &b->caps);
+	if (err) {
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_BIND_FAILED);
+		kfree(b);
+		return err;
+	}
+	if (!(b->caps.families & amt_offload_outer_family(amt))) {
+		b->ops->unbind(&b->pub);
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_FAMILY_UNSUPPORTED);
+		kfree(b);
+		return -EOPNOTSUPP;
+	}
+
+	b->admitting = true;
+	rcu_assign_pointer(amt->offload, b);
+	amt_offload_count(amt, AMT_OFFLOAD_CNT_BIND);
+	if (on_register)
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_BIND_ON_REGISTER);
+	amt_offload_set_carrier(amt, true);
+	return 0;
+}
+
+/* Return @amt to software in the documented order. @cnt is the cause to
+ * count, or AMT_OFFLOAD_CNT_MAX for the relay's own deletion. RTNL held.
+ */
+static void amt_offload_teardown(struct amt_dev *amt,
+				 enum amt_offload_counter cnt)
+{
+	struct amt_offload_bound *b = rtnl_dereference(amt->offload);
+	struct amt_offload_ref *ref, *tmp;
+
+	if (!b)
+		return;
+
+	/* 1. Stop admission and wait for every ops->xmit already admitted. */
+	WRITE_ONCE(b->admitting, false);
+	synchronize_net();
+
+	/* 2. Programming work is cancelled here once the reconciler exists
+	 *    (next patch); nothing can program the provider past this point.
+	 */
+
+	/* 3. Disable every group, then 4. delete every endpoint. */
+	list_for_each_entry_safe(ref, tmp, &b->groups, node) {
+		b->ops->group_disable(&b->pub, ref->handle);
+		list_del(&ref->node);
+		kfree(ref);
+	}
+	list_for_each_entry_safe(ref, tmp, &b->endpoints, node) {
+		b->ops->endpoint_del(&b->pub, ref->handle);
+		list_del(&ref->node);
+		kfree(ref);
+	}
+
+	/* 5. Unbind, then 6. unpublish and let RCU readers drain. */
+	b->ops->unbind(&b->pub);
+	RCU_INIT_POINTER(amt->offload, NULL);
+	synchronize_rcu();
+	kfree(b);
+
+	/* 7. Software. */
+	amt->offload_epoch++;
+	if (cnt < AMT_OFFLOAD_CNT_MAX) {
+		amt_offload_count(amt, cnt);
+		if (amt->offload_mode == AMT_OFFLOAD_MODE_REQUIRED) {
+			amt_offload_count(amt, AMT_OFFLOAD_CNT_REQUIRED_UNBOUND);
+			amt_offload_set_carrier(amt, false);
+		}
+	}
+}
+
+int amt_offload_register(struct net_device *lower,
+			 const struct amt_offload_ops *ops)
+{
+	struct amt_offload_provider *p;
+	struct amt_dev *amt;
+
+	ASSERT_RTNL();
+	if (!lower || !ops || !ops->bind || !ops->unbind ||
+	    !ops->group_disable || !ops->endpoint_del)
+		return -EINVAL;
+	if (amt_offload_provider_find(lower))
+		return -EEXIST;
+
+	p = kzalloc_obj(*p, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	p->lower = lower;
+	p->ops = ops;
+	list_add_rcu(&p->node, &amt_offload_providers);
+
+	list_for_each_entry(amt, &amt_offload_devs, offload_node)
+		if (amt->stream_dev == lower)
+			amt_offload_bind(amt, p, true);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amt_offload_register);
+
+static void amt_offload_provider_drop(struct net_device *lower,
+				      enum amt_offload_counter cnt)
+{
+	struct amt_offload_provider *p = amt_offload_provider_find(lower);
+	struct amt_dev *amt;
+
+	list_for_each_entry(amt, &amt_offload_devs, offload_node)
+		if (amt->stream_dev == lower)
+			amt_offload_teardown(amt, cnt);
+	if (p) {
+		list_del_rcu(&p->node);
+		kfree_rcu(p, rcu);
+	}
+}
+
+void amt_offload_unregister(struct net_device *lower)
+{
+	ASSERT_RTNL();
+	amt_offload_provider_drop(lower, AMT_OFFLOAD_CNT_TEARDOWN_PROVIDER);
+}
+EXPORT_SYMBOL_GPL(amt_offload_unregister);
+
+/* NETDEV_UNREGISTER of a stream_dev: tear its relays down before
+ * amt_dellink runs, and forget its provider so no entry outlives the
+ * netdev it names.
+ */
+static void amt_offload_lower_gone(struct net_device *lower)
+{
+	amt_offload_provider_drop(lower, AMT_OFFLOAD_CNT_TEARDOWN_LOWER);
+}
+
+/* newlink: list the relay and bind it if a provider is registered. A
+ * required-mode relay with no usable provider is refused (-ENODEV) and
+ * counted globally. RTNL held.
+ */
+static int amt_offload_attach(struct amt_dev *amt,
+			      struct netlink_ext_ack *extack)
+{
+	struct amt_offload_provider *p;
+	int err = -ENODEV;
+
+	INIT_LIST_HEAD(&amt->offload_node);
+	if (amt->mode != AMT_MODE_RELAY)
+		return 0;
+	list_add_tail(&amt->offload_node, &amt_offload_devs);
+	if (amt->offload_mode == AMT_OFFLOAD_MODE_SOFTWARE)
+		return 0;
+
+	p = amt_offload_provider_find(amt->stream_dev);
+	if (p)
+		err = amt_offload_bind(amt, p, false);
+	if (!err || amt->offload_mode != AMT_OFFLOAD_MODE_REQUIRED)
+		return 0;
+
+	list_del_init(&amt->offload_node);
+	atomic_inc(&amt_offload_required_refused);
+	if (p)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload required but the stream device's provider cannot serve this relay");
+	else
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload required but the stream device has no offload provider");
+	return -ENODEV;
+}
+
+/* The relay itself is going away. RTNL held. */
+static void amt_offload_detach(struct amt_dev *amt)
+{
+	amt_offload_teardown(amt, AMT_OFFLOAD_CNT_MAX);
+	if (!list_empty(&amt->offload_node))
+		list_del_init(&amt->offload_node);
+}
+
+/* offload/ sysfs group: mode, binding state and the counters. Counters
+ * are monotonic since netdev creation and wrap at u32.
+ */
+static ssize_t offload_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	static const char * const names[] = {
+		[AMT_OFFLOAD_MODE_SOFTWARE] = "software",
+		[AMT_OFFLOAD_MODE_AUTO] = "auto",
+		[AMT_OFFLOAD_MODE_REQUIRED] = "required",
+	};
+	struct amt_dev *amt = netdev_priv(to_net_dev(dev));
+
+	return sysfs_emit(buf, "%s\n", names[READ_ONCE(amt->offload_mode)]);
+}
+static struct device_attribute dev_attr_offload_mode =
+	__ATTR(mode, 0444, offload_mode_show, NULL);
+
+static ssize_t offload_bound_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct amt_dev *amt = netdev_priv(to_net_dev(dev));
+
+	return sysfs_emit(buf, "%d\n", !!rcu_access_pointer(amt->offload));
+}
+static struct device_attribute dev_attr_offload_bound =
+	__ATTR(bound, 0444, offload_bound_show, NULL);
+
+static ssize_t amt_offload_cnt_show(struct device *dev, char *buf,
+				    enum amt_offload_counter cnt)
+{
+	struct amt_dev *amt = netdev_priv(to_net_dev(dev));
+
+	return sysfs_emit(buf, "%u\n", (u32)atomic_read(&amt->offload_cnt[cnt]));
+}
+
+#define AMT_OFFLOAD_CNT_ATTR(name, cnt)					\
+static ssize_t offload_##name##_show(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
+{									\
+	return amt_offload_cnt_show(dev, buf, cnt);			\
+}									\
+static struct device_attribute dev_attr_offload_##name =		\
+	__ATTR(name, 0444, offload_##name##_show, NULL)
+
+AMT_OFFLOAD_CNT_ATTR(binds, AMT_OFFLOAD_CNT_BIND);
+AMT_OFFLOAD_CNT_ATTR(binds_on_register, AMT_OFFLOAD_CNT_BIND_ON_REGISTER);
+AMT_OFFLOAD_CNT_ATTR(bind_failed, AMT_OFFLOAD_CNT_BIND_FAILED);
+AMT_OFFLOAD_CNT_ATTR(family_unsupported, AMT_OFFLOAD_CNT_FAMILY_UNSUPPORTED);
+AMT_OFFLOAD_CNT_ATTR(teardown_lower, AMT_OFFLOAD_CNT_TEARDOWN_LOWER);
+AMT_OFFLOAD_CNT_ATTR(teardown_provider, AMT_OFFLOAD_CNT_TEARDOWN_PROVIDER);
+AMT_OFFLOAD_CNT_ATTR(required_unbound, AMT_OFFLOAD_CNT_REQUIRED_UNBOUND);
+
+static struct attribute *amt_offload_attrs[] = {
+	&dev_attr_offload_mode.attr,
+	&dev_attr_offload_bound.attr,
+	&dev_attr_offload_binds.attr,
+	&dev_attr_offload_binds_on_register.attr,
+	&dev_attr_offload_bind_failed.attr,
+	&dev_attr_offload_family_unsupported.attr,
+	&dev_attr_offload_teardown_lower.attr,
+	&dev_attr_offload_teardown_provider.attr,
+	&dev_attr_offload_required_unbound.attr,
+	NULL,
+};
+
+static const struct attribute_group amt_offload_group = {
+	.name = "offload",
+	.attrs = amt_offload_attrs,
+};
+
 static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_MODE]		= { .type = NLA_U32 },
 	[IFLA_AMT_RELAY_PORT]	= { .type = NLA_U16 },
@@ -4284,6 +4695,13 @@ static int amt_newlink(struct net_device *dev,
 	INIT_DELAYED_WORK(&amt->secret_wq, amt_secret_work);
 	INIT_WORK(&amt->event_wq, amt_event_work);
 	INIT_LIST_HEAD(&amt->tunnel_list);
+
+	err = amt_offload_attach(amt, extack);
+	if (err) {
+		netdev_upper_dev_unlink(amt->stream_dev, dev);
+		unregister_netdevice(dev);
+		goto err;
+	}
 	return 0;
 err:
 	dev_put(amt->stream_dev);
@@ -4294,6 +4712,7 @@ static void amt_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct amt_dev *amt = netdev_priv(dev);
 
+	amt_offload_detach(amt);
 	unregister_netdevice_queue(dev, head);
 	netdev_upper_dev_unlink(amt->stream_dev, dev);
 	dev_put(amt->stream_dev);
@@ -4438,6 +4857,12 @@ static int amt_device_event(struct notifier_block *unused,
 	LIST_HEAD(list);
 	int new_mtu;
 
+	/* Before amt_dellink below: the provider's tables are torn down
+	 * while the relay and its stream_dev are both still intact.
+	 */
+	if (event == NETDEV_UNREGISTER)
+		amt_offload_lower_gone(dev);
+
 	upper_dev = amt_lookup_upper_dev(dev);
 	if (!upper_dev)
 		return NOTIFY_DONE;
diff --git a/include/net/amt.h b/include/net/amt.h
index 5b3405f04..7d70f30e6 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -379,6 +379,29 @@ struct amt_events {
 	struct sk_buff *skb;
 };
 
+struct amt_offload_bound;
+
+/* Per-relay offload counters, exported under offload/ in sysfs. */
+enum amt_offload_counter {
+	/* bind() succeeded and the caps covered the outer family */
+	AMT_OFFLOAD_CNT_BIND,
+	/* ... of which: bound when a provider registered on the stream_dev
+	 * this relay already uses
+	 */
+	AMT_OFFLOAD_CNT_BIND_ON_REGISTER,
+	/* bind() returned an error; the relay stayed unbound */
+	AMT_OFFLOAD_CNT_BIND_FAILED,
+	/* caps lacked the relay's outer family; the relay stayed unbound */
+	AMT_OFFLOAD_CNT_FAMILY_UNSUPPORTED,
+	/* teardown because the stream_dev was unregistered */
+	AMT_OFFLOAD_CNT_TEARDOWN_LOWER,
+	/* teardown because the provider unregistered */
+	AMT_OFFLOAD_CNT_TEARDOWN_PROVIDER,
+	/* a required-mode relay lost its provider and dropped carrier */
+	AMT_OFFLOAD_CNT_REQUIRED_UNBOUND,
+	AMT_OFFLOAD_CNT_MAX,
+};
+
 struct amt_dev {
 	struct net_device       *dev;
 	struct net_device       *stream_dev;
@@ -484,6 +507,17 @@ struct amt_dev {
 	struct socket		*stream_sock_v4;
 	struct socket		*stream_sock_v6;
 	atomic_t		upstream_setsockopt_slow_count;
+
+	/* Replication offload (relay mode). Everything here is written
+	 * under RTNL; offload is also read by the data path under RCU.
+	 * offload_node links the relay into amt_offload_devs so a provider
+	 * registering on its stream_dev can find it.
+	 */
+	u32			offload_mode;
+	struct amt_offload_bound __rcu *offload;
+	struct list_head	offload_node;
+	u64			offload_epoch;
+	atomic_t		offload_cnt[AMT_OFFLOAD_CNT_MAX];
 };
 
 #define AMT_TOS			0xc0
diff --git a/include/uapi/linux/amt.h b/include/uapi/linux/amt.h
index c04ed1fa4..de1ae1929 100644
--- a/include/uapi/linux/amt.h
+++ b/include/uapi/linux/amt.h
@@ -21,6 +21,26 @@ enum ifla_amt_mode {
 
 #define AMT_MODE_MAX (__AMT_MODE_MAX - 1)
 
+/* Relay replication offload (include/net/amt_offload.h). */
+enum ifla_amt_offload_mode {
+	/* Never use a provider. The default. */
+	AMT_OFFLOAD_MODE_SOFTWARE = 0,
+	/* Use the provider registered on the stream device when its bind
+	 * succeeds, it covers the relay's outer family and it implements the
+	 * TX path; software otherwise.
+	 */
+	AMT_OFFLOAD_MODE_AUTO,
+	/* Refuse to create the relay without a usable provider, and drop
+	 * carrier while none is bound. Unlike auto, also bind a provider
+	 * that replicates only on ingress. A bound relay still forwards in
+	 * software, with carrier up, what the provider does not serve.
+	 */
+	AMT_OFFLOAD_MODE_REQUIRED,
+	__AMT_OFFLOAD_MODE_MAX,
+};
+
+#define AMT_OFFLOAD_MODE_MAX (__AMT_OFFLOAD_MODE_MAX - 1)
+
 enum {
 	IFLA_AMT_UNSPEC,
 	/* This attribute specify mode etier Gateway or Relay. */
-- 
2.43.0

