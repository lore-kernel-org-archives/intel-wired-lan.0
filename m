Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EAE606EE9B
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TXQZtexh;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=Bf0q06/E
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BA4B60838;
	Mon,  9 Nov 2026 17:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sf00rqj386UI; Mon,  9 Nov 2026 17:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BA4C6082E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244744;
	b=oMb/PbVFwu6/GGrzPJ2J+kPdJKXVtGRCBKRB95+oPksJYhul1cquZKlDCPT/R9XivTJq
	 CoIE3t5dsS0mU+gLGRChCEhfzE+Xleitmb/nu8+MZsFuKyeJtXEfQWPY0+S6mSjsHuvRU
	 3WRFaZjfBBi1R04yCqqpX/DRJp1/Tsh71gAtO5s+jFhjqa8EF46+1HITVhj0PfecSxfLZ
	 Tk7/E9zqKD3QDwqPrdtsUrweb8EEvtnuwM03fu7qh8+Dq2mp62LM7+lfH6IgQO5KsFXTr
	 JL5cWtAUBfRnXZ6tQXC2YPKJNPh/wD6rhRwhsr5CtI6U4rFvjDx7SUPbSSTKW1gSe+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mg8UGJuyK6ZVPowqoxE+B4fRWFQpJezgay0t77tS3ig=;
	b=M/sQ7sa+neJHmiSvdhgxlsklwKnV+YeRMYCGqXTCm6KiX9UthbqQdfpPTKGBiB2lBxOG
	 QJL1a2TfrVtppPPp0aDETNoEXLg6L88wVdH1la3M/hcPUkBT+cVkn4KZ5/PL1Gke5sGkQ
	 KZmLvEhlLRQCZu/4lFXXmDLOfZE/VbjeNfDbjy3+WPR9IqhhJ7y7hl/ft6HoV23gmi8tY
	 JVgQbtKBjTLbP9y747NA9+h7xs3vfJZ4BDCkH2RFM4+4+stgECQr4SD3IBSA1K5l33X2J
	 8mnlUe3z5s4kDLRAndLr/lQNOz8RtOOIdf13usn5Ni0A7MarRBRtZrnnHp6Awx7U2+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244744;
	bh=mg8UGJuyK6ZVPowqoxE+B4fRWFQpJezgay0t77tS3ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXQZtexhXhi747+GwHy0RRsDOTpXA+L8OjbitjGwWzSGCTat3hJ9lTya1muCfDWU3
	 Gx53jQb7jAtmRiK32AFpGKSqfHSJgL0fbjyf1lDPZ+B3vWiIwwRqiE5Y9yMy5Wu/nU
	 xwoYVMa1QccOfJrNQbuOG4wRaVakWHq60+7GIvhu9GUhSmtLrx1GVFOOjDY9OsdKAy
	 nwFpmVf6FuAYHNJviEFc8VJJMVmkxUy+MrByl3GNGkqurEiekwH+WkaevZrUzkZOc5
	 XqvMZtUaxQ2hqWnPVQRQA9iSodEuLv1GR7ekKZRrkrMat4lg5sFRBR75vgsepXcNSv
	 rvxszFV1/6z5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BA4C6082E;
	Mon,  9 Nov 2026 17:19:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 790E41E3
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F3B34009B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h7peIcPVycfs for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 18:44:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A6EAA4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com;
 envelope-from=omar@blockcast.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=blockcast.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net
 header.a=rsa-sha256 header.s=google header.b=Bf0q06/E
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6EAA4005F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:58 +0000 (UTC)
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-19305bcb72cso1621276c88.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 07 Nov 2026 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockcast.net; s=google; t=1794077097; x=1794681897; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mg8UGJuyK6ZVPowqoxE+B4fRWFQpJezgay0t77tS3ig=;
 b=Bf0q06/EXNrWCcmBrSyNSwNx1xcIiDNbNJaRXvDsVYZC+/DuebDerwcK6dfJ5SGw1X
 3wYE3YT/9h0H+f8VMT6i6k+gxCt9D5DhYjFoFc8Y9yH4BvTGDhqTQtC+sHHP2MVY5fwu
 52P1bSamoE0Q1YKSeL+hwi1L4B1P2/JEpRmYjnCoBcm6AaEdf276jPfHnNL+VtnT+MpJ
 GCCprF0105A6vqhBzOuqVUbPq+kFukqtkWuB+zkvoC4SDMCVIHqD4COqoTOnBJCAJMlB
 PqZ+w9vnreUeaCCltoVp5euhGsOkeP/dcRe7TAXc1g74MIlrzuBmzk1Ii68pDAwvFryX
 nOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077097; x=1794681897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mg8UGJuyK6ZVPowqoxE+B4fRWFQpJezgay0t77tS3ig=;
 b=sR+yOMvUiDdxJIBQ9cj6jGHa7H5zQvegDQ0nrvG2pINiUfOMKyhqfsOewGfN8v37xH
 vH/A/ljdu6ZfcCHqNcEJsuiHhdXzrY8rSQKQkC9SEK2Up3pCLd1+OcuZvK+FZqEEKcy7
 gUGC6xRiPY2cICpau3NyfsqYO5bsIr4rGNXiCUWNTk3+XOJlZdHUy8qPNWu6AE2FlESL
 x/CPbeXHj9XnVaE8H08Km5eavCCLASuFlQqXDTTWHFu12tfbkOoxzTBs6DP2qxBGdDEI
 ehQt4rnrk8ApwulGagAgAQ2KI+TUr237xjR84x/addwjO1rtTrtSztaoH9/rsDJcNr1+
 GzWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGA/ha5crAaXaohZyeTI+HhZhI9G6z65P62UDtUHHhKTIVq/nOUVlBagtk6ZpupS/Q+fljYiugZbajlW+7v4o0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8OzjrqaNtMPu22uxZ+1o6tXp2x2goXBQ5CT7AScw7bmbqI2d9s
 ihxmYDTnPoHKmeUaPNo6iQCeWDpUfy53SJwnfgnIPl0Ww1EC05GH/dY+ZM6liWAwfLs=
X-Gm-Gg: AYBFou0KG+7OufH5quH910kOfN4LnqmZ2uocEZiCREhkD8mxXOGd7k1H68Q8rExpxXr
 b+mZRjMW+fe5QpSZN//yQW6/psC3rMEvxxKnkB9fUPgB+M6kXk5+sJOM+V6HEYsAoFLaFbSHwpc
 Ee98vh1VyqR7QcOBlPhq3TpaQL7Cq3v57388JN7fUXUx5nak76dUmklM7k8h7aweXbHP3s9/WqS
 mwof7TWoJ/HhDImWbLFncjpbOsiD5wOZcgpyMO9GuTMaYcDM4c8F0mlyaEbIK6WOhF4SOyny2Ar
 4ZPFJiuXVWEBFZXO2kk1pbEiTis8VqQBYrzWRlzODseXbwUGpX9bjJ04JEeoUvMUNPdU3EneRN2
 UaF75fTd4fXGQqxjdEITj+CHtziU988g7h1xOHSjqFlj7Y+AeAAIjX7pWvjXvgp3MqyJ+vo8AS/
 ctk7uXAi9GyRP06lKosNZMbLGlsCUisoSFEGqpGKXWZWLDaPy90uK13hYQWSc4VhgZP/5kdRy2h
 K8mIcNp4ca0oINqLPgawvQmdhQIYyODyimLd/E+hhpmFrbuJsh2rUrimEY/mVZjJnvXVZ/ilFZl
 Rz3QZ7qiokD/2LNk6yq04v+rzl/H9IN7W0NTb2znhqtdAGtkMavKoINqDkjZ2GUJQByf+1I=
X-Received: by 2002:a05:7301:dd81:b0:35c:8b96:94d9 with SMTP id
 5a478bee46e88-36f75d229e2mr8091949eec.19.1794077097000; 
 Sat, 07 Nov 2026 10:44:57 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:44:56 -0800 (PST)
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
Subject: [RFC PATCH net-next 7/9] netdevsim: add a TX reference provider for
 AMT relay offload
Date: Sat,  7 Nov 2026 18:44:35 +0000
Message-ID: <20261107184437.2783174-8-omar@blockcast.net>
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

Each PF port offers itself as an AMT relay replication offload provider
(include/net/amt_offload.h) for relays whose stream device it is. It is
not a pass-through to amt's software fan-out: the port keeps its own
endpoint and group tables, with a staged and a committed member set per
group under the generation amt gave it, and decides from those which
endpoints get a copy of each packet amt hands to ->xmit. Each copy is
encapsulated by amt_offload_encap_xmit() and sent out of the port to its
peer, so any divergence between amt's desired state and what the
provider committed shows up as a wrong copy count at the peer. The set
committed before the last one is kept for packets already in flight,
and an endpoint stays allocated while a set names it.

debugfs (ports/<n>/amt/) shows the tables and counters and injects the
failures the contract has to survive: busy (xmit returns BUSY),
fail_commit (group_commit returns -ENOSPC), max_endpoints (endpoint_add
returns -ENOSPC), stall_ms (every programming op sleeps, so amt sees it
overrun op_timeout_ms and resets) and op_timeout_ms (advertised at
bind).

The provider owns its devlink objects, registered on netdevsim's own
devlink instance, not amt's: resources amt/endpoints, amt/groups,
amt/members and amt/cmdq, and an "amt" health reporter reported on
every flush (amt's reset). amt registers nothing on devlink.

Moving a netdev to another netns unregisters it there first, which
makes amt forget its provider; the port offers itself again once it is
registered in the new netns.

TX only: netdevsim has no ingress classifier to simulate the ingress
path with.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/Kconfig               |   1 +
 drivers/net/netdevsim/Makefile    |   4 +
 drivers/net/netdevsim/amt.c       | 600 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/dev.c       |  68 ++++
 drivers/net/netdevsim/health.c    |  28 +-
 drivers/net/netdevsim/netdev.c    |  19 +-
 drivers/net/netdevsim/netdevsim.h |  27 ++
 7 files changed, 744 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/netdevsim/amt.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index fda19ae4b..6e45d2fa0 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -625,6 +625,7 @@ config NETDEVSIM
 	depends on INET
 	depends on PSAMPLE || PSAMPLE=n
 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
+	depends on AMT || AMT=n
 	select NET_DEVLINK
 	select PAGE_POOL
 	select NET_SHAPER
diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
index 87718204f..eec03812a 100644
--- a/drivers/net/netdevsim/Makefile
+++ b/drivers/net/netdevsim/Makefile
@@ -25,3 +25,7 @@ endif
 ifneq ($(CONFIG_MACSEC),)
 netdevsim-objs += macsec.o
 endif
+
+ifneq ($(CONFIG_AMT),)
+netdevsim-objs += amt.o
+endif
diff --git a/drivers/net/netdevsim/amt.c b/drivers/net/netdevsim/amt.c
new file mode 100644
index 000000000..ffb9aa4e7
--- /dev/null
+++ b/drivers/net/netdevsim/amt.c
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: GPL-2.0
+/* netdevsim: TX reference provider for AMT relay replication offload.
+ *
+ * Each PF port registers itself as a provider for relays that transmit
+ * on it (include/net/amt_offload.h). The port keeps its OWN endpoint and
+ * group tables, with a staged and a committed member set per group under
+ * the generation amt gave it, and decides replication from them: a packet
+ * amt hands to ->xmit is copied to the endpoints of the committed set of
+ * that generation, each copy encapsulated by amt_offload_encap_xmit() and
+ * sent out of this port to its peer. Any divergence between what amt
+ * wants and what the provider committed shows up at the peer as a wrong
+ * copy count. TX only: netdevsim has no ingress classifier to simulate.
+ *
+ * debugfs, per port, under ports/<n>/amt/:
+ *   tables         the provider's endpoints and groups, read-only
+ *   tx_copies, tx_busy, tx_stale_gen, tx_dropped, commits, flushes
+ *                  counters, read-only
+ *   busy           xmit returns BUSY
+ *   fail_commit    group_commit fails with -ENOSPC
+ *   max_endpoints  endpoint_add fails with -ENOSPC beyond this (0: none)
+ *   stall_ms       every programming op sleeps this long first
+ *   op_timeout_ms  advertised to amt at bind (0: no limit)
+ *
+ * devlink, per device: resources amt/{endpoints,groups,members,cmdq} and
+ * the "amt" health reporter, reported on every flush (amt's reset).
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/rculist.h>
+#include <linux/refcount.h>
+#include <linux/seq_file.h>
+#include <linux/skbuff.h>
+#include <net/amt_offload.h>
+#include <net/devlink.h>
+
+#include "netdevsim.h"
+
+struct amt_offload_endpoint {
+	struct list_head		node;	/* nsim_amt_bind.eps */
+	struct amt_offload_endpoint_key	key;
+	/* One for amt's handle (all endpoint_add calls for the key), one per
+	 * member set naming it: an in-flight packet may still be copied to
+	 * an endpoint amt already deleted.
+	 */
+	refcount_t			refs;
+	u32				adds;
+	atomic64_t			copies;
+	struct rcu_head			rcu;
+};
+
+struct nsim_amt_set {
+	u64				gen;
+	u32				n;
+	struct rcu_head			rcu;
+	struct amt_offload_endpoint	*eps[] __counted_by(n);
+};
+
+struct amt_offload_group {
+	struct list_head		node;	/* nsim_amt_bind.grps */
+	struct amt_offload_group_key	key;
+	struct nsim_amt_set		*staged;
+	/* Committed last, and the one before it for packets in flight. */
+	struct nsim_amt_set __rcu	*cur;
+	struct nsim_amt_set __rcu	*prev;
+	struct rcu_head			rcu;
+};
+
+struct nsim_amt_bind {
+	struct list_head		node;	/* nsim_amt.binds */
+	struct amt_offload_binding	*b;
+	struct list_head		eps;
+	struct list_head		grps;
+	u32				nr_eps;
+};
+
+struct nsim_amt {
+	struct netdevsim		*ns;
+	struct mutex			lock;	/* binds and their tables */
+	struct list_head		binds;
+	struct dentry			*ddir;
+	bool				busy;
+	bool				fail_commit;
+	u32				max_endpoints;
+	u32				stall_ms;
+	u32				op_timeout_ms;
+	u64				commits;
+	u64				flushes;
+	atomic64_t			tx_copies;
+	atomic64_t			tx_busy;
+	atomic64_t			tx_stale_gen;
+	atomic64_t			tx_dropped;
+};
+
+#define nsim_amt_deref(nam, p) \
+	rcu_dereference_protected(p, lockdep_is_held(&(nam)->lock))
+
+static struct nsim_amt *nsim_amt_of(struct amt_offload_binding *b)
+{
+	struct netdevsim *ns = netdev_priv(b->lower);
+
+	return ns->amt;
+}
+
+/* Every programming op runs inside one of these: cmdq occupancy, and the
+ * injected stall that makes amt see an op overrun op_timeout_ms.
+ */
+static struct nsim_amt *nsim_amt_op_begin(struct amt_offload_binding *b)
+{
+	struct nsim_amt *nam = nsim_amt_of(b);
+	u32 stall = READ_ONCE(nam->stall_ms);
+
+	atomic_inc(&nam->ns->nsim_dev->amt.cmdq);
+	if (stall)
+		msleep(stall);
+	mutex_lock(&nam->lock);
+	return nam;
+}
+
+static void nsim_amt_op_end(struct nsim_amt *nam)
+{
+	mutex_unlock(&nam->lock);
+	atomic_dec(&nam->ns->nsim_dev->amt.cmdq);
+}
+
+static void nsim_amt_ep_put(struct amt_offload_endpoint *ep)
+{
+	if (refcount_dec_and_test(&ep->refs))
+		kfree_rcu(ep, rcu);
+}
+
+static void nsim_amt_set_free_rcu(struct rcu_head *head)
+{
+	struct nsim_amt_set *set = container_of(head, struct nsim_amt_set,
+						rcu);
+	u32 i;
+
+	for (i = 0; i < set->n; i++)
+		nsim_amt_ep_put(set->eps[i]);
+	kfree(set);
+}
+
+static void nsim_amt_set_free(struct nsim_amt_set *set)
+{
+	if (set)
+		call_rcu(&set->rcu, nsim_amt_set_free_rcu);
+}
+
+static int nsim_amt_bind(struct amt_offload_binding *b,
+			 struct amt_offload_caps *caps)
+{
+	struct nsim_amt *nam = nsim_amt_of(b);
+	struct nsim_amt_bind *nb;
+
+	nb = kzalloc_obj(*nb, GFP_KERNEL);
+	if (!nb)
+		return -ENOMEM;
+	nb->b = b;
+	INIT_LIST_HEAD(&nb->eps);
+	INIT_LIST_HEAD(&nb->grps);
+	b->priv = nb;
+
+	caps->families = AMT_OFFLOAD_FAMILY_V4 | AMT_OFFLOAD_FAMILY_V6;
+	caps->paths = BIT(AMT_OFFLOAD_PATH_TX);
+	caps->op_timeout_ms = READ_ONCE(nam->op_timeout_ms);
+	caps->max_endpoints = READ_ONCE(nam->max_endpoints);
+
+	mutex_lock(&nam->lock);
+	list_add_tail(&nb->node, &nam->binds);
+	mutex_unlock(&nam->lock);
+	return 0;
+}
+
+/* Drop every group and endpoint of @nb. Caller holds nam->lock; amt has
+ * stopped submitting packets for this binding.
+ */
+static void nsim_amt_bind_clear(struct nsim_amt *nam, struct nsim_amt_bind *nb)
+{
+	struct nsim_dev *nsim_dev = nam->ns->nsim_dev;
+	struct amt_offload_endpoint *ep, *et;
+	struct amt_offload_group *g, *gt;
+	struct nsim_amt_set *set;
+
+	list_for_each_entry_safe(g, gt, &nb->grps, node) {
+		set = nsim_amt_deref(nam, g->cur);
+		if (set)
+			atomic_sub(set->n, &nsim_dev->amt.members);
+		nsim_amt_set_free(set);
+		nsim_amt_set_free(nsim_amt_deref(nam, g->prev));
+		nsim_amt_set_free(g->staged);
+		list_del(&g->node);
+		atomic_dec(&nsim_dev->amt.groups);
+		kfree_rcu(g, rcu);
+	}
+	list_for_each_entry_safe(ep, et, &nb->eps, node) {
+		list_del(&ep->node);
+		nb->nr_eps--;
+		atomic_dec(&nsim_dev->amt.endpoints);
+		nsim_amt_ep_put(ep);
+	}
+}
+
+static void nsim_amt_unbind(struct amt_offload_binding *b)
+{
+	struct nsim_amt *nam = nsim_amt_of(b);
+	struct nsim_amt_bind *nb = b->priv;
+
+	mutex_lock(&nam->lock);
+	/* Empty unless amt broke the teardown order; then free, not leak. */
+	WARN_ON_ONCE(!list_empty(&nb->grps) || !list_empty(&nb->eps));
+	nsim_amt_bind_clear(nam, nb);
+	list_del(&nb->node);
+	mutex_unlock(&nam->lock);
+	kfree(nb);
+}
+
+static bool nsim_amt_ep_key_eq(const struct amt_offload_endpoint_key *a,
+			       const struct amt_offload_endpoint_key *b)
+{
+	if (a->family != b->family || a->port != b->port)
+		return false;
+	if (a->family == AF_INET6)
+		return ipv6_addr_equal(&a->addr.ip6, &b->addr.ip6);
+	return a->addr.ip4 == b->addr.ip4;
+}
+
+static int nsim_amt_endpoint_add(struct amt_offload_binding *b,
+				 const struct amt_offload_endpoint_key *key,
+				 struct amt_offload_endpoint **epp)
+{
+	struct nsim_amt *nam = nsim_amt_op_begin(b);
+	struct nsim_amt_bind *nb = b->priv;
+	struct amt_offload_endpoint *ep;
+	int err = 0;
+
+	list_for_each_entry(ep, &nb->eps, node) {
+		if (nsim_amt_ep_key_eq(&ep->key, key)) {
+			ep->adds++;
+			goto out;
+		}
+	}
+	if (nam->max_endpoints && nb->nr_eps >= nam->max_endpoints) {
+		err = -ENOSPC;
+		goto unlock;
+	}
+	ep = kzalloc_obj(*ep, GFP_KERNEL);
+	if (!ep) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+	ep->key = *key;
+	refcount_set(&ep->refs, 1);
+	ep->adds = 1;
+	list_add_tail(&ep->node, &nb->eps);
+	nb->nr_eps++;
+	atomic_inc(&nam->ns->nsim_dev->amt.endpoints);
+out:
+	*epp = ep;
+unlock:
+	nsim_amt_op_end(nam);
+	return err;
+}
+
+static void nsim_amt_endpoint_del(struct amt_offload_binding *b,
+				  struct amt_offload_endpoint *ep)
+{
+	struct nsim_amt *nam = nsim_amt_op_begin(b);
+	struct nsim_amt_bind *nb = b->priv;
+
+	if (!--ep->adds) {
+		list_del(&ep->node);
+		nb->nr_eps--;
+		atomic_dec(&nam->ns->nsim_dev->amt.endpoints);
+		nsim_amt_ep_put(ep);
+	}
+	nsim_amt_op_end(nam);
+}
+
+static int nsim_amt_group_update(struct amt_offload_binding *b,
+				 const struct amt_offload_group_key *key,
+				 struct amt_offload_endpoint *const *members,
+				 unsigned int nr_members, u64 gen,
+				 struct amt_offload_group **grpp)
+{
+	struct nsim_amt *nam = nsim_amt_op_begin(b);
+	struct amt_offload_group *g = *grpp;
+	struct nsim_amt_bind *nb = b->priv;
+	struct nsim_amt_set *set;
+	int err = 0;
+	u32 i;
+
+	if (!g) {
+		g = kzalloc_obj(*g, GFP_KERNEL);
+		if (!g) {
+			err = -ENOMEM;
+			goto out;
+		}
+		g->key = *key;
+		list_add_tail(&g->node, &nb->grps);
+		atomic_inc(&nam->ns->nsim_dev->amt.groups);
+		*grpp = g;
+	}
+	set = kzalloc(struct_size(set, eps, nr_members), GFP_KERNEL);
+	if (!set) {
+		err = -ENOMEM;
+		goto out;
+	}
+	set->n = nr_members;
+	set->gen = gen;
+	for (i = 0; i < nr_members; i++) {
+		refcount_inc(&members[i]->refs);
+		set->eps[i] = members[i];
+	}
+	nsim_amt_set_free(g->staged);
+	g->staged = set;
+out:
+	nsim_amt_op_end(nam);
+	return err;
+}
+
+static int nsim_amt_group_commit(struct amt_offload_binding *b,
+				 struct amt_offload_group *g, u64 gen)
+{
+	struct nsim_amt *nam = nsim_amt_op_begin(b);
+	struct nsim_dev *nsim_dev = nam->ns->nsim_dev;
+	struct nsim_amt_set *cur, *prev;
+	int err = 0;
+
+	if (nam->fail_commit) {
+		err = -ENOSPC;
+		goto out;
+	}
+	if (!g->staged || g->staged->gen != gen) {
+		err = -EINVAL;
+		goto out;
+	}
+	cur = nsim_amt_deref(nam, g->cur);
+	prev = nsim_amt_deref(nam, g->prev);
+	atomic_add(g->staged->n, &nsim_dev->amt.members);
+	if (cur)
+		atomic_sub(cur->n, &nsim_dev->amt.members);
+	rcu_assign_pointer(g->prev, cur);
+	rcu_assign_pointer(g->cur, g->staged);
+	g->staged = NULL;
+	nsim_amt_set_free(prev);
+	nam->commits++;
+out:
+	nsim_amt_op_end(nam);
+	return err;
+}
+
+static void nsim_amt_group_disable(struct amt_offload_binding *b,
+				   struct amt_offload_group *g)
+{
+	struct nsim_amt *nam = nsim_amt_op_begin(b);
+	struct nsim_amt_set *set;
+
+	set = nsim_amt_deref(nam, g->cur);
+	if (set)
+		atomic_sub(set->n, &nam->ns->nsim_dev->amt.members);
+	nsim_amt_set_free(set);
+	nsim_amt_set_free(nsim_amt_deref(nam, g->prev));
+	nsim_amt_set_free(g->staged);
+	list_del(&g->node);
+	atomic_dec(&nam->ns->nsim_dev->amt.groups);
+	kfree_rcu(g, rcu);
+	nsim_amt_op_end(nam);
+}
+
+/* Softirq, under rcu_read_lock(). Copies go to the committed set of @gen
+ * only; a generation this provider never committed (or has already
+ * retired) is declined, never guessed at.
+ */
+static enum amt_offload_result
+nsim_amt_xmit(struct amt_offload_binding *b, struct amt_offload_group *g,
+	      struct sk_buff *skb, u64 gen)
+{
+	struct nsim_amt *nam = nsim_amt_of(b);
+	struct nsim_amt_set *set;
+	u32 i;
+
+	if (READ_ONCE(nam->busy)) {
+		atomic64_inc(&nam->tx_busy);
+		return AMT_OFFLOAD_BUSY;
+	}
+	set = rcu_dereference(g->cur);
+	if (!set || set->gen != gen) {
+		set = rcu_dereference(g->prev);
+		if (!set || set->gen != gen) {
+			atomic64_inc(&nam->tx_stale_gen);
+			return AMT_OFFLOAD_FALLBACK;
+		}
+	}
+	for (i = 0; i < set->n; i++) {
+		if (amt_offload_encap_xmit(b, &set->eps[i]->key, skb)) {
+			atomic64_inc(&nam->tx_dropped);
+			continue;
+		}
+		atomic64_inc(&set->eps[i]->copies);
+		atomic64_inc(&nam->tx_copies);
+	}
+	consume_skb(skb);
+	return AMT_OFFLOAD_CONSUMED;
+}
+
+/* Called under amt's offload mutex, like every programming op: from
+ * the reconciler with no other lock, or at teardown with RTNL held and,
+ * when the port is being deleted, the devlink instance lock too. The
+ * "amt" reporter has no .recover and no .dump (health.c), so reporting
+ * it takes no devlink lock in either case.
+ */
+static void nsim_amt_flush(struct amt_offload_binding *b)
+{
+	struct nsim_amt *nam = nsim_amt_op_begin(b);
+
+	nsim_amt_bind_clear(nam, b->priv);
+	nam->flushes++;
+	nsim_amt_op_end(nam);
+	devlink_health_report(nam->ns->nsim_dev->health.amt_reporter,
+			      "amt reset: provider tables flushed", NULL);
+}
+
+static const struct amt_offload_ops nsim_amt_ops = {
+	.bind		= nsim_amt_bind,
+	.unbind		= nsim_amt_unbind,
+	.endpoint_add	= nsim_amt_endpoint_add,
+	.endpoint_del	= nsim_amt_endpoint_del,
+	.group_update	= nsim_amt_group_update,
+	.group_commit	= nsim_amt_group_commit,
+	.group_disable	= nsim_amt_group_disable,
+	.xmit		= nsim_amt_xmit,
+	.flush		= nsim_amt_flush,
+};
+
+static void nsim_amt_show_ep(struct seq_file *m,
+			     const struct amt_offload_endpoint_key *key)
+{
+	if (key->family == AF_INET6)
+		seq_printf(m, "[%pI6c]:%u", &key->addr.ip6, ntohs(key->port));
+	else
+		seq_printf(m, "%pI4:%u", &key->addr.ip4, ntohs(key->port));
+}
+
+static void nsim_amt_show_set(struct seq_file *m, const char *name,
+			      const struct nsim_amt_set *set)
+{
+	u32 i;
+
+	if (!set)
+		return;
+	seq_printf(m, "  %s gen %llu members %u:", name, set->gen, set->n);
+	for (i = 0; i < set->n; i++) {
+		seq_putc(m, ' ');
+		nsim_amt_show_ep(m, &set->eps[i]->key);
+	}
+	seq_putc(m, '\n');
+}
+
+static int nsim_amt_tables_show(struct seq_file *m, void *unused)
+{
+	struct nsim_amt *nam = m->private;
+	struct amt_offload_endpoint *ep;
+	struct amt_offload_group *g;
+	struct nsim_amt_bind *nb;
+
+	mutex_lock(&nam->lock);
+	list_for_each_entry(nb, &nam->binds, node) {
+		seq_printf(m, "binding %s epoch %llu\n", netdev_name(nb->b->dev),
+			   nb->b->epoch);
+		list_for_each_entry(ep, &nb->eps, node) {
+			seq_puts(m, "endpoint ");
+			nsim_amt_show_ep(m, &ep->key);
+			seq_printf(m, " copies %llu\n",
+				   atomic64_read(&ep->copies));
+		}
+		list_for_each_entry(g, &nb->grps, node) {
+			if (g->key.family == AF_INET6)
+				seq_printf(m, "group %pI6c\n", &g->key.group.ip6);
+			else
+				seq_printf(m, "group %pI4\n", &g->key.group.ip4);
+			nsim_amt_show_set(m, "committed",
+					  nsim_amt_deref(nam, g->cur));
+			nsim_amt_show_set(m, "previous",
+					  nsim_amt_deref(nam, g->prev));
+			nsim_amt_show_set(m, "staged", g->staged);
+		}
+	}
+	mutex_unlock(&nam->lock);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(nsim_amt_tables);
+
+static int nsim_amt_atomic64_get(void *data, u64 *val)
+{
+	*val = atomic64_read(data);
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(nsim_amt_atomic64_fops, nsim_amt_atomic64_get,
+			 NULL, "%llu\n");
+
+static void nsim_amt_debugfs_init(struct nsim_amt *nam)
+{
+	struct dentry *d;
+
+	d = debugfs_create_dir("amt", nam->ns->nsim_dev_port->ddir);
+	nam->ddir = d;
+	debugfs_create_file("tables", 0400, d, nam, &nsim_amt_tables_fops);
+	debugfs_create_file("tx_copies", 0400, d, &nam->tx_copies,
+			    &nsim_amt_atomic64_fops);
+	debugfs_create_file("tx_busy", 0400, d, &nam->tx_busy,
+			    &nsim_amt_atomic64_fops);
+	debugfs_create_file("tx_stale_gen", 0400, d, &nam->tx_stale_gen,
+			    &nsim_amt_atomic64_fops);
+	debugfs_create_file("tx_dropped", 0400, d, &nam->tx_dropped,
+			    &nsim_amt_atomic64_fops);
+	debugfs_create_u64("commits", 0400, d, &nam->commits);
+	debugfs_create_u64("flushes", 0400, d, &nam->flushes);
+	debugfs_create_bool("busy", 0600, d, &nam->busy);
+	debugfs_create_bool("fail_commit", 0600, d, &nam->fail_commit);
+	debugfs_create_u32("max_endpoints", 0600, d, &nam->max_endpoints);
+	debugfs_create_u32("stall_ms", 0600, d, &nam->stall_ms);
+	debugfs_create_u32("op_timeout_ms", 0600, d, &nam->op_timeout_ms);
+}
+
+int nsim_amt_init(struct netdevsim *ns)
+{
+	struct nsim_amt *nam;
+	int err;
+
+	nam = kzalloc_obj(*nam, GFP_KERNEL);
+	if (!nam)
+		return -ENOMEM;
+	nam->ns = ns;
+	mutex_init(&nam->lock);
+	INIT_LIST_HEAD(&nam->binds);
+	nam->op_timeout_ms = 1000;
+	nsim_amt_debugfs_init(nam);
+
+	rtnl_lock();
+	ns->amt = nam;
+	err = amt_offload_register(ns->netdev, &nsim_amt_ops);
+	if (err)
+		ns->amt = NULL;
+	rtnl_unlock();
+	if (err) {
+		debugfs_remove_recursive(nam->ddir);
+		mutex_destroy(&nam->lock);
+		kfree(nam);
+	}
+	return err;
+}
+
+void nsim_amt_uninit(struct netdevsim *ns)
+{
+	struct nsim_amt *nam = ns->amt;
+
+	if (!nam)
+		return;
+	rtnl_lock();
+	amt_offload_unregister(ns->netdev);
+	ns->amt = NULL;
+	rtnl_unlock();
+	debugfs_remove_recursive(nam->ddir);
+	mutex_destroy(&nam->lock);
+	kfree(nam);
+}
+
+/* amt forgets a provider when its lower device is unregistered, and
+ * moving a netdev to another netns unregisters it there first. Offer
+ * the port again once it is registered in its new netns.
+ */
+static int nsim_amt_netdev_event(struct notifier_block *nb,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netdevsim *ns;
+
+	if (event != NETDEV_REGISTER || !netdev_is_nsim(dev))
+		return NOTIFY_DONE;
+	ns = netdev_priv(dev);
+	if (ns->amt)
+		amt_offload_register(dev, &nsim_amt_ops);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block nsim_amt_notifier = {
+	.notifier_call = nsim_amt_netdev_event,
+};
+
+int nsim_amt_module_init(void)
+{
+	return register_netdevice_notifier(&nsim_amt_notifier);
+}
+
+void nsim_amt_module_exit(void)
+{
+	unregister_netdevice_notifier(&nsim_amt_notifier);
+	rcu_barrier();	/* nsim_amt_set_free_rcu() is module text */
+}
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index f00fc2f9e..7fcdb0d67 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -444,6 +444,69 @@ static void nsim_dev_port_debugfs_exit(struct nsim_dev_port *nsim_dev_port)
 	debugfs_remove_recursive(nsim_dev_port->ddir);
 }
 
+static u64 nsim_dev_amt_endpoints_occ_get(void *priv)
+{
+	return atomic_read(&((struct nsim_dev *)priv)->amt.endpoints);
+}
+
+static u64 nsim_dev_amt_groups_occ_get(void *priv)
+{
+	return atomic_read(&((struct nsim_dev *)priv)->amt.groups);
+}
+
+static u64 nsim_dev_amt_members_occ_get(void *priv)
+{
+	return atomic_read(&((struct nsim_dev *)priv)->amt.members);
+}
+
+static u64 nsim_dev_amt_cmdq_occ_get(void *priv)
+{
+	return atomic_read(&((struct nsim_dev *)priv)->amt.cmdq);
+}
+
+static int
+nsim_dev_amt_resources_register(struct devlink *devlink,
+				const struct devlink_resource_size_params *p)
+{
+	static const struct {
+		const char *name;
+		u64 id;
+		devlink_resource_occ_get_t *occ_get;
+	} res[] = {
+		{ "endpoints", NSIM_RESOURCE_AMT_ENDPOINTS,
+		  nsim_dev_amt_endpoints_occ_get },
+		{ "groups", NSIM_RESOURCE_AMT_GROUPS,
+		  nsim_dev_amt_groups_occ_get },
+		{ "members", NSIM_RESOURCE_AMT_MEMBERS,
+		  nsim_dev_amt_members_occ_get },
+		{ "cmdq", NSIM_RESOURCE_AMT_CMDQ, nsim_dev_amt_cmdq_occ_get },
+	};
+	int err, i;
+
+	if (!IS_ENABLED(CONFIG_AMT))
+		return 0;
+	err = devl_resource_register(devlink, "amt", (u64)-1,
+				     NSIM_RESOURCE_AMT,
+				     DEVLINK_RESOURCE_ID_PARENT_TOP, p);
+	if (err) {
+		pr_err("Failed to register AMT top resource\n");
+		return err;
+	}
+	for (i = 0; i < ARRAY_SIZE(res); i++) {
+		err = devl_resource_register(devlink, res[i].name, (u64)-1,
+					     res[i].id, NSIM_RESOURCE_AMT, p);
+		if (err) {
+			pr_err("Failed to register AMT %s resource\n",
+			       res[i].name);
+			return err;
+		}
+		devl_resource_occ_get_register(devlink, res[i].id,
+					       res[i].occ_get,
+					       devlink_priv(devlink));
+	}
+	return 0;
+}
+
 static int nsim_dev_resources_register(struct devlink *devlink)
 {
 	struct devlink_resource_size_params params = {
@@ -514,6 +577,11 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 		pr_err("Failed to register NEXTHOPS resource\n");
 		goto err_out;
 	}
+
+	/* AMT relay offload tables, owned by the ports' provider (amt.c) */
+	err = nsim_dev_amt_resources_register(devlink, &params);
+	if (err)
+		goto err_out;
 	return 0;
 
 err_out:
diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index 3bd0e7a48..f6bc6cb51 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -175,6 +175,16 @@ static const struct file_operations nsim_dev_health_break_fops = {
 	.owner = THIS_MODULE,
 };
 
+/* Reported by the AMT relay offload provider (amt.c) each time amt resets
+ * it. Recovery is amt's own replay, so there is no .recover, and no .dump:
+ * with neither, devlink_health_report() never takes the devlink instance
+ * lock, which amt's ->flush() may not take (amt holds its offload mutex,
+ * below rtnl, and the instance lock sits above rtnl).
+ */
+static const struct devlink_health_reporter_ops nsim_dev_amt_reporter_ops = {
+	.name = "amt",
+};
+
 int nsim_dev_health_init(struct nsim_dev *nsim_dev, struct devlink *devlink)
 {
 	struct nsim_dev_health *health = &nsim_dev->health;
@@ -196,10 +206,21 @@ int nsim_dev_health_init(struct nsim_dev *nsim_dev, struct devlink *devlink)
 		goto err_empty_reporter_destroy;
 	}
 
+	if (IS_ENABLED(CONFIG_AMT)) {
+		health->amt_reporter =
+			devl_health_reporter_create(devlink,
+						    &nsim_dev_amt_reporter_ops,
+						    health);
+		if (IS_ERR(health->amt_reporter)) {
+			err = PTR_ERR(health->amt_reporter);
+			goto err_dummy_reporter_destroy;
+		}
+	}
+
 	health->ddir = debugfs_create_dir("health", nsim_dev->ddir);
 	if (IS_ERR(health->ddir)) {
 		err = PTR_ERR(health->ddir);
-		goto err_dummy_reporter_destroy;
+		goto err_amt_reporter_destroy;
 	}
 
 	health->recovered_break_msg = NULL;
@@ -213,6 +234,9 @@ int nsim_dev_health_init(struct nsim_dev *nsim_dev, struct devlink *devlink)
 			    &health->fail_recover);
 	return 0;
 
+err_amt_reporter_destroy:
+	if (health->amt_reporter)
+		devl_health_reporter_destroy(health->amt_reporter);
 err_dummy_reporter_destroy:
 	devl_health_reporter_destroy(health->dummy_reporter);
 err_empty_reporter_destroy:
@@ -226,6 +250,8 @@ void nsim_dev_health_exit(struct nsim_dev *nsim_dev)
 
 	debugfs_remove_recursive(health->ddir);
 	kfree(health->recovered_break_msg);
+	if (health->amt_reporter)
+		devl_health_reporter_destroy(health->amt_reporter);
 	devl_health_reporter_destroy(health->dummy_reporter);
 	devl_health_reporter_destroy(health->empty_reporter);
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a75076891..4294c026d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1075,6 +1075,10 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (err)
 		goto err_unregister_netdev;
 
+	err = nsim_amt_init(ns);
+	if (err)
+		goto err_psp_uninit;
+
 	if (IS_ENABLED(CONFIG_DEBUG_NET)) {
 		ns->nb.notifier_call = netdev_debug_event;
 		if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
@@ -1084,6 +1088,8 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 
 	return 0;
 
+err_psp_uninit:
+	nsim_psp_uninit(ns);
 err_unregister_netdev:
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
@@ -1182,8 +1188,10 @@ void nsim_destroy(struct netdevsim *ns)
 		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
 						      &ns->nn);
 
-	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
+	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
+		nsim_amt_uninit(ns);
 		nsim_psp_uninit(ns);
+	}
 
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
@@ -1238,10 +1246,14 @@ static int __init nsim_module_init(void)
 {
 	int err;
 
-	err = nsim_dev_init();
+	err = nsim_amt_module_init();
 	if (err)
 		return err;
 
+	err = nsim_dev_init();
+	if (err)
+		goto err_amt_exit;
+
 	err = nsim_bus_init();
 	if (err)
 		goto err_dev_exit;
@@ -1256,6 +1268,8 @@ static int __init nsim_module_init(void)
 	nsim_bus_exit();
 err_dev_exit:
 	nsim_dev_exit();
+err_amt_exit:
+	nsim_amt_module_exit();
 	return err;
 }
 
@@ -1264,6 +1278,7 @@ static void __exit nsim_module_exit(void)
 	rtnl_link_unregister(&nsim_link_ops);
 	nsim_bus_exit();
 	nsim_dev_exit();
+	nsim_amt_module_exit();
 }
 
 module_init(nsim_module_init);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d909c4160..549afee0d 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -127,6 +127,8 @@ struct netdevsim {
 		u32 assoc_cnt;
 	} psp;
 
+	struct nsim_amt *amt;
+
 	struct nsim_bus_dev *nsim_bus_dev;
 
 	struct bpf_prog	*bpf_offloaded;
@@ -232,6 +234,11 @@ enum nsim_resource_id {
 	NSIM_RESOURCE_IPV6_FIB,
 	NSIM_RESOURCE_IPV6_FIB_RULES,
 	NSIM_RESOURCE_NEXTHOPS,
+	NSIM_RESOURCE_AMT,
+	NSIM_RESOURCE_AMT_ENDPOINTS,
+	NSIM_RESOURCE_AMT_GROUPS,
+	NSIM_RESOURCE_AMT_MEMBERS,
+	NSIM_RESOURCE_AMT_CMDQ,
 };
 
 enum nsim_port_resource_id {
@@ -241,6 +248,7 @@ enum nsim_port_resource_id {
 struct nsim_dev_health {
 	struct devlink_health_reporter *empty_reporter;
 	struct devlink_health_reporter *dummy_reporter;
+	struct devlink_health_reporter *amt_reporter;
 	struct dentry *ddir;
 	char *recovered_break_msg;
 	u32 binary_len;
@@ -351,6 +359,13 @@ struct nsim_dev {
 	bool fail_reload;
 	struct devlink_region *dummy_region;
 	struct nsim_dev_health health;
+	/* AMT relay offload tables of every port, for devlink resources */
+	struct {
+		atomic_t endpoints;
+		atomic_t groups;
+		atomic_t members;
+		atomic_t cmdq;
+	} amt;
 	struct nsim_dev_hwstats hwstats;
 	struct flow_action_cookie *fa_cookie;
 	spinlock_t fa_cookie_lock; /* protects fa_cookie */
@@ -472,6 +487,18 @@ nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext) {}
 int nsim_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		  void *type_data);
 
+#if IS_ENABLED(CONFIG_AMT)
+int nsim_amt_init(struct netdevsim *ns);
+void nsim_amt_uninit(struct netdevsim *ns);
+int nsim_amt_module_init(void);
+void nsim_amt_module_exit(void);
+#else
+static inline int nsim_amt_init(struct netdevsim *ns) { return 0; }
+static inline void nsim_amt_uninit(struct netdevsim *ns) {}
+static inline int nsim_amt_module_init(void) { return 0; }
+static inline void nsim_amt_module_exit(void) {}
+#endif
+
 struct nsim_bus_dev {
 	struct device dev;
 	struct list_head list;
-- 
2.43.0

