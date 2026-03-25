Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1284FEA811
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 06:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FE6B60A72;
	Wed, 25 Mar 2026 06:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5G6ujGLe_5CY; Wed, 25 Mar 2026 06:32:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D99360A82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774420347;
	bh=pXCcTwKb1lLOpjLS5Q7uk+ANua3ZXes7YNzR6hx485M=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hjTSI8ZZuef6UOC3+iEOK7qFbJLoFCrjIYTkEgNFF/IpNAfLVNx/K/0DZqlhN5Frd
	 iW4JOhFK/Ld3KMdDD1GU37h+450seo5WbdM/AxUR/xy5VnHXFOnVhAakFQAvuMksHw
	 3s65ySkXIHSu5ad8d7WraazWPjiU/Jk9BuqFBUjG8F6utE1NN0SzBSyUL17qjxVDV+
	 liNKgXlOO35sPrAukSQ/hTLcmYaQzmBfsBwUHiXNYD/yeQYtZ3hPaR8RCymTTtmDO4
	 0iuKAxiwsnBAlWCn1pCxNxhjCffKBWi5D0JS9b75EDtFYvZcDoEVsOCI/w882YfxM7
	 dBxKcZv0IEzCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D99360A82;
	Wed, 25 Mar 2026 06:32:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 158FA353
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 06:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0797781E95
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 06:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v7UHlOqmNifS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 06:32:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BDD7381E82
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDD7381E82
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDD7381E82
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 06:32:24 +0000 (UTC)
X-CSE-ConnectionGUID: 1cTWFjQuSkijLoxu5OOemA==
X-CSE-MsgGUID: Co4ZpzceT5qzT0KtIfHpyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79308068"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="79308068"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 23:32:03 -0700
X-CSE-ConnectionGUID: xGulh6gmTcuT57k7D1q5RQ==
X-CSE-MsgGUID: qPQk9mTjT8WgBzbn8tkU0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="221693629"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa008.fm.intel.com with ESMTP; 24 Mar 2026 23:31:56 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.24])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 9095E2FC6;
 Wed, 25 Mar 2026 06:31:54 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Date: Wed, 25 Mar 2026 07:26:52 +0100
Message-ID: <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774420345; x=1805956345;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h4RRCfcEdmRZK9RVaAKuvBOS4NvEEsJkb8bg0Tcf2SI=;
 b=br2HxiAphAAiFs+aAGEYvIsozIdzfz361knstHxuNyJjlNGS0nu3eN/p
 atHuzwFtip30O9zzYsmp8DKytm1nkVhP8I4CetE6H8eCKTYURdcnnTa7K
 yWhtg1/U39Z0WPMPnz0+S9RnBbhN2vh6VTFCTEtBQ0WAKIOa2VtwsLcVW
 95EexCJJcG/D02pJGt011uzloXdJhRjBnrfyXraAPukdNJfuqyhzqdYHW
 Le8GYxuI8yVZOXollrXNMM+BP372nhEkGqBwgIy4JWRsLy+cBh3JWBGxw
 hszXNAsaE4HZBltYj8t3xjrOBDByZZ44StnEEuVoOe7Ih6qQR0hdHDROf
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=br2HxiAp
Subject: [Intel-wired-lan] [PATCH net-next 1/2] devlink: unify
 devlink_shd_get_priv() into devlink_priv()
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Unify access API to shared devlink priv data with normal devlink.

Thanks to Jiri Pirko, we now have ability to create shared devlink
instances [1]. Introduction series have added usage of those for mlx, but
without priv data attached to the shared devlink.

Current API makes it possible to access shared devlink instance's priv
data:

	void *devlink_shd_get_priv(struct devlink *devlink);

but it is easy to forget (especially during rebase from "before shared
devlinks" era) and call:

	void *devlink_priv(struct devlink *devlink);

which even has the same signature, so it's hard to catch the error.

New proposed API unifies both calls into one, without any increase in the
observed struct size. (Alternative could be to store additional pointer,
set during devlink_alloc).

Unexport the less convenient API call.

[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v1:
https://lore.kernel.org/netdev/20260323132136.13191-1-przemyslaw.kitszel@intel.com

v2:
- fix typos (Alex, Jiri)
- fix infinite recurrence (Alex)
- add __devlink_priv(), which is more general than v1's devlink_to_shd()
  (Jiri)
---
 net/devlink/devl_internal.h |  7 +++++++
 net/devlink/core.c          | 10 +++++++++-
 net/devlink/sh_dev.c        |  8 ++++----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7dfb7cdd2d23..0a57318d92f8 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -58,6 +58,7 @@ struct devlink {
 	struct mutex lock;
 	struct lock_class_key lock_key;
 	u8 reload_failed:1;
+	u8 is_shd:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
 	struct devlink_rel *rel;
@@ -72,6 +73,12 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
 
+/* Get priv allocated for struct devlink */
+void *__devlink_priv(struct devlink *devlink);
+
+/* Get private data from shared devlink instance */
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 #define devl_warn(devlink, format, args...)				\
 	do {								\
 		if ((devlink)->dev)					\
diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..a242be203fe8 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -230,10 +230,18 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-void *devlink_priv(struct devlink *devlink)
+void *__devlink_priv(struct devlink *devlink)
 {
 	return &devlink->priv;
 }
+
+void *devlink_priv(struct devlink *devlink)
+{
+	if (devlink->is_shd)
+		return devlink_shd_get_priv(devlink);
+
+	return __devlink_priv(devlink);
+}
 EXPORT_SYMBOL_GPL(devlink_priv);
 
 struct devlink *priv_to_devlink(void *priv)
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
index 85acce97e788..b85e5cb1edbe 100644
--- a/net/devlink/sh_dev.c
+++ b/net/devlink/sh_dev.c
@@ -43,13 +43,14 @@ static struct devlink_shd *devlink_shd_create(const char *id,
 				  &init_net, NULL, driver);
 	if (!devlink)
 		return NULL;
-	shd = devlink_priv(devlink);
+	shd = __devlink_priv(devlink);
 
 	shd->id = kstrdup(id, GFP_KERNEL);
 	if (!shd->id)
 		goto err_devlink_free;
 	shd->priv_size = priv_size;
 	refcount_set(&shd->refcount, 1);
+	devlink->is_shd = 1;
 
 	devl_lock(devlink);
 	devl_register(devlink);
@@ -136,7 +137,7 @@ void devlink_shd_put(struct devlink *devlink)
 	struct devlink_shd *shd;
 
 	mutex_lock(&shd_mutex);
-	shd = devlink_priv(devlink);
+	shd = __devlink_priv(devlink);
 	if (refcount_dec_and_test(&shd->refcount))
 		devlink_shd_destroy(shd);
 	mutex_unlock(&shd_mutex);
@@ -154,8 +155,7 @@ EXPORT_SYMBOL_GPL(devlink_shd_put);
  */
 void *devlink_shd_get_priv(struct devlink *devlink)
 {
-	struct devlink_shd *shd = devlink_priv(devlink);
+	struct devlink_shd *shd = __devlink_priv(devlink);
 
 	return shd->priv;
 }
-EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.51.1

