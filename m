Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C8606A32E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UDZNpRzQ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CepuZmZU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B03460838;
	Tue,  3 Nov 2026 14:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mNWY7zfd1RVW; Tue,  3 Nov 2026 14:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E9DA60859
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716810;
	b=mwSGxxyY5QdXxj07Oo5ckzO0clJAaWVJjUs1QKXEAs/G799PRwaBve7w9gk18tqjqxxf
	 9RkEpedD+/pyHY/Z/PPkpS5XVHZom6B5P7sl8CgcqUXOlr1IGr0b8sOwzJo1+31eErW1E
	 BEgwPcnBALakPYWuvjqXl5fREwgzOVhoi15H87P8Ka75K9SBh0/WDaliABh0N/w7WgM2R
	 VsVjjJgKropdtJragjfZXAktiFTA6wtcuNpkubzFvM/VkVGhdRDVOqnYRH9BssiwyTW67
	 ZhT8yrDqCV1U/etkwwym1FPvRNRsNVEX150u+jxgXERcf2LIYfmyzjtwl6lMtFfnd9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=molVHtSV1DK4KoY51YHybqC76E7aoPSoyqlC26p0+jk=;
	b=FjcwDvk0xyTy5Z6Q48jeZgYZjT7oaN+DnBhlfUE+kj24SGSsYURG0Rszdq309d+XQApD
	 g6kz6GNnD/IdkEdarMsBJWTr2pHTCNr4oloppUSEZhOq9nyg1nqKQ2LprpDMi1YxnFLcB
	 dcKfJ5PmV3L0Vnvmfd/+7OB8yJ7Tl06CdMcwD/uOQIUbnAnnvRQUvcef+AN6bb3y4d1Yh
	 XwlpQmbqs4wetjx92RrlgUzpa7n8tRTCokHyEdRDScMSFciT1Tyj2pieUeTqexIfqPhLv
	 pfejFobUZ0eQaUeyIbfmp8Dj0bFO6UwACdkESD1IVBaD7LdTzjRV5bFUiwva1/jz0wg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716810;
	bh=molVHtSV1DK4KoY51YHybqC76E7aoPSoyqlC26p0+jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UDZNpRzQ3zxtvYP/NJObf3BQkMrVSWn0f9FjCCtDsrY+50ki4+IVvW5eG42S7yP7H
	 pQxAvCESmnwtthhWkLmu40/1Tj7TT7RkQOMFssJ039saA3ufDZhr7DUapu0QkzMghp
	 ZasNuvPljMq8RwhIwG2nfYa19bt1TCj6Gb9KELgD2ygdmBZjCRMNUK2YJfFGCnqvu1
	 MxLVubY15pVOSRppD3CDCrUK93SK8nv1G3gDPSeQtKW1XZDJESqHYG5OnbecQ30Bto
	 UcAjLeJgujzNNUAb9dcM2j9e+2P9v/Vi6jqEFIP1TOf9V1DpKjKkwQDx9/WEs+klXt
	 Q2AdlGjKP9+gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E9DA60859;
	Tue,  3 Nov 2026 14:40:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06CAB356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E077A40070
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8MuMBprr_w8P for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:40:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD634400E0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716806;
 b=geeIMbGRXKI6J9YdLdtiKW9/89WRVkRmed+fRqoqr5XNWLWnUovVQvumGEiH2vhjVPAU
 mV0K1qI4VRqUknDIlPaZRm3RvR0CucQTK9cebbH994U72U/E2XylVrgZEx6lWezgkYZm3
 +TWhYEfd2YSx/PCdqdqlb061g/3oEl5dveDJMjckzbsap78Of/uGkHbxkUOQHMmd/yf02
 IoZQaR5PRr0e/utIn2hUeuoD9vWfDOZNWXB4AfSGPCTKm4aUV0sueVfGmKOsv4MZu7XiN
 k3p6L1Eg9DzUT80csupbHff+imYuezfJPzX5438/jKyc3ehsDn03zdz2SF9xxuoSh3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716806;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=molVHtSV1DK4KoY51YHybqC76E7aoPSoyqlC26p0+jk=;
 b=E0tIgBF1RhJCT/qay0gKJ42esSRd0EMPvI1TXAsYSOEVKAJw+BSUXPytMBiPopNUTNde
 n7znWkS3gsx4JsTp9LXSBpqyUx1yKRDjQGq8MHFAU+EiuvjDbLulLRvX8HHaSZ1VJeePq
 AKl6vyzy2oIw+Eut/Vb1QwOC8OItm6fanL6CpWdBYsnzdYa/3myQepSs8Ny3K358QZnHy
 AMhFlq1qafZgR2ZNB/CC9CSifSpWsvyr88W17s1fbLQnHNbe7bZPtAxFLp7OWoVewDM8n
 fghnujq6fBlwm+DB6323yIgtSPZ9lVibdC+//nxi6P2f2ipz+Ak+gV7nKqJVkXX+WgQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CepuZmZU; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CepuZmZU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD634400E0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716806; x=1825252806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jw5uTUrnrNLPcSCTl/81ShNzbtoKE9D1eO/dAW7Fz4o=;
 b=CepuZmZUkabFevoBVS0FtXYFk02G3PEebU6knb/ZeGkd0L35W0Sugxvt
 5/Pfa0cC2XLWU84eCKUQ+ZNMfXt4IqyYAu8xEEKzM1l6t7jp5zMsaEhuS
 nF8swzSMLNTgyKD0VFEnbUJ5G3Gw3HeK0sJCiKYffCDgUPvqlAmcP/FJr
 6xr2dINOjmfgya5iuD3CpSjm79Zhz2LRhb9x9GguAfK13b+HR1Y6x8uhG
 N8CML6RXZ/X5GnT+6negHG3l0aKpi2jE48uJ5U2Z1PiuZFjLdKaBz1FMv
 X+6bay3yUM+JDRoyhX5isAbIXk8iTv4vpXRyMjDehBgI0YUem0xa9QuAb g==;
X-CSE-ConnectionGUID: bARK5vcCSl2Q6AnLhOVO3A==
X-CSE-MsgGUID: r30qnfTwQ7inr8+qd7pE9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324107"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324107"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:40:06 -0800
X-CSE-ConnectionGUID: EwzQWmxuRw27ZqqdjY4o9Q==
X-CSE-MsgGUID: x+EQnLMxQgSNVJZvdk6qHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8290008"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:40:02 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 6062A312EE;
 Tue,  3 Nov 2026 14:39:59 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 bruce.richardson@intel.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 padraig.j.connolly@intel.com, ananth.s@intel.com,
 timothy.miskell@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 12/15] devlink: give user option to allocate
 resources
Date: Tue,  3 Nov 2026 15:14:53 +0100
Message-ID: <20261103141646.303620-13-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Current devlink resources are designed as a thing that user could limit,
but there is not much otherwise that could be done with them.
Perhaps that's the reason there is not much adoption despite API being
there for multiple years.

Add new mode of operation, where user could allocate/assign resources
(from a common pool) to specific devices.

That requires a new .occ_set() driver callback, called on
DEVLINK_CMD_RESOURCE_SET with the requested DEVLINK_ATTR_RESOURCE_SIZE,
instead of staging the size until the next reload. Driver registers it
together with .occ_get() by devl_resource_occ_set_get_register(). For
such resources the getter value is reported as DEVLINK_ATTR_RESOURCE_SIZE,
as opposed to DEVLINK_ATTR_RESOURCE_OCC (current occupation) in the
"legacy" mode, and there is no DEVLINK_ATTR_RESOURCE_SIZE_NEW.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
RFC, Feb '25
https://lore.kernel.org/intel-wired-lan/20250219164410.35665-3-przemyslaw.kitszel@intel.com

I have structured code to just choose "the mode" of operation based on
the presence of .occ_set callback, instead of naming the mode, what,
even if not the most clear code, avoids the need of naming the modes.

v4:
 * return -EMSGSIZE directly on devlink_resource_occ_size_put_legacy()
   failure (Jakub)

v3:
 * keep size and size_new of .occ_set() resources in sync with the
   getter, after a successful set and in devl_resource_size_get() (me)
 * WARN on registering .occ_set() without .occ_get(), or vice versa

v2:
 * avoid setting DEVLINK_ATTR_RESOURCE_SIZE_VALID for leaf resources
   (Sashiko)
 * minor kdoc update (Sashiko)
 * add more WARN_ONs (Sashiko)
 * document the occ_set mode in devlink-resource.rst
 * commit message: describe the .occ_set() callback and how the reported
   attributes differ from the "legacy" mode
---
 .../networking/devlink/devlink-resource.rst   |  5 +
 include/net/devlink.h                         |  7 ++
 net/devlink/resource.c                        | 97 ++++++++++++++++---
 3 files changed, 93 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
index b7172d94b2c6..9c48155fcb1e 100644
--- a/Documentation/networking/devlink/devlink-resource.rst
+++ b/Documentation/networking/devlink/devlink-resource.rst
@@ -75,6 +75,11 @@ attribute, which represents the pending change in size. For example:
 Note that changes in resource size may require a device reload to properly
 take effect.
 
+Resources registered with ``devl_resource_occ_set_get_register()`` behave
+differently: the new size is passed to the driver and applies immediately,
+there is neither ``size_new`` nor ``occ`` reported, and ``size`` is the value
+returned by the driver's getter.
+
 Port-level Resources and Full Dump
 ==================================
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 98bdde4f72ca..d01128ef393d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -420,6 +420,8 @@ devlink_resource_size_params_init(struct devlink_resource_size_params *size_para
 }
 
 typedef u64 devlink_resource_occ_get_t(void *priv);
+typedef int devlink_resource_occ_set_t(u64 size, struct netlink_ext_ack *extack,
+				       void *priv);
 
 #define DEVLINK_RESOURCE_ID_PARENT_TOP 0
 
@@ -1959,6 +1961,11 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 				    void *occ_get_priv);
 void devl_resource_occ_get_unregister(struct devlink *devlink,
 				      u64 resource_id);
+void devl_resource_occ_set_get_register(struct devlink *devlink,
+					u64 resource_id,
+					devlink_resource_occ_set_t *occ_set,
+					devlink_resource_occ_get_t *occ_get,
+					void *occ_priv);
 int devl_params_register(struct devlink *devlink,
 			 const struct devlink_param *params,
 			 size_t params_count);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index c3cfda7ea070..c4502c480a6b 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -19,7 +19,8 @@
  * @list: parent list
  * @resource_list: list of child resources
  * @occ_get: occupancy getter callback
- * @occ_get_priv: occupancy getter callback priv
+ * @occ_set: occupancy setter callback
+ * @occ_priv: occupancy callbacks priv
  */
 struct devlink_resource {
 	const char *name;
@@ -32,7 +33,8 @@ struct devlink_resource {
 	struct list_head list;
 	struct list_head resource_list;
 	devlink_resource_occ_get_t *occ_get;
-	void *occ_get_priv;
+	devlink_resource_occ_set_t *occ_set;
+	void *occ_priv;
 };
 
 static struct devlink_resource *
@@ -137,6 +139,16 @@ int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	if (resource->occ_set) {
+		err = resource->occ_set(size, info->extack, resource->occ_priv);
+		if (err)
+			return err;
+
+		resource->size = resource->occ_get(resource->occ_priv);
+		resource->size_new = resource->size;
+		return 0;
+	}
+
 	resource->size_new = size;
 	devlink_resource_validate_children(resource);
 	if (resource->parent)
@@ -162,13 +174,31 @@ devlink_resource_size_params_put(struct devlink_resource *resource,
 	return 0;
 }
 
-static int devlink_resource_occ_put(struct devlink_resource *resource,
-				    struct sk_buff *skb)
+static int
+devlink_resource_occ_size_put_legacy(struct devlink_resource *resource,
+				     struct sk_buff *skb)
 {
-	if (!resource->occ_get)
-		return 0;
-	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
-				  resource->occ_get(resource->occ_get_priv));
+	if (devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size))
+		return -EMSGSIZE;
+	if (resource->size != resource->size_new &&
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
+			       resource->size_new))
+		return -EMSGSIZE;
+	if (resource->occ_get &&
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
+			       resource->occ_get(resource->occ_priv)))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int devlink_resource_occ_size_put(struct devlink_resource *resource,
+					 struct sk_buff *skb)
+{
+	if (!resource->occ_get || !resource->occ_set)
+		return devlink_resource_occ_size_put_legacy(resource, skb);
+
+	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE,
+				  resource->occ_get(resource->occ_priv));
 }
 
 static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
@@ -183,14 +213,9 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	if (nla_put_string(skb, DEVLINK_ATTR_RESOURCE_NAME, resource->name) ||
-	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size) ||
 	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_ID, resource->id))
 		goto nla_put_failure;
-	if (resource->size != resource->size_new &&
-	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
-			       resource->size_new))
-		goto nla_put_failure;
-	if (devlink_resource_occ_put(resource, skb))
+	if (devlink_resource_occ_size_put(resource, skb))
 		goto nla_put_failure;
 	if (devlink_resource_size_params_put(resource, skb))
 		goto nla_put_failure;
@@ -634,12 +659,50 @@ int devl_resource_size_get(struct devlink *devlink,
 	resource = devlink_resource_find(devlink, NULL, resource_id);
 	if (!resource)
 		return -EINVAL;
+	if (resource->occ_set)
+		resource->size_new = resource->occ_get(resource->occ_priv);
 	*p_resource_size = resource->size_new;
 	resource->size = resource->size_new;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(devl_resource_size_get);
 
+/**
+ * devl_resource_occ_set_get_register - register occupancy getter and setter
+ *
+ * @devlink: devlink
+ * @resource_id: resource id
+ * @occ_set: occupancy setter callback
+ * @occ_get: occupancy getter callback
+ * @occ_priv: occupancy callbacks priv
+ *
+ * Setter will be called when the user wants to change the resource size,
+ * getter is called to show the user what is current size of the resource.
+ */
+void devl_resource_occ_set_get_register(struct devlink *devlink,
+					u64 resource_id,
+					devlink_resource_occ_set_t *occ_set,
+					devlink_resource_occ_get_t *occ_get,
+					void *occ_priv)
+{
+	struct devlink_resource *resource;
+
+	lockdep_assert_held(&devlink->lock);
+
+	if (WARN_ON(!occ_set || !occ_get))
+		return;
+
+	resource = devlink_resource_find(devlink, NULL, resource_id);
+	if (WARN_ON(!resource))
+		return;
+	WARN_ON(resource->occ_get || resource->occ_set);
+
+	resource->occ_set = occ_set;
+	resource->occ_get = occ_get;
+	resource->occ_priv = occ_priv;
+}
+EXPORT_SYMBOL_GPL(devl_resource_occ_set_get_register);
+
 /**
  * devl_resource_occ_get_register - register occupancy getter
  *
@@ -661,9 +724,10 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 	if (WARN_ON(!resource))
 		return;
 	WARN_ON(resource->occ_get);
+	WARN_ON(resource->occ_set);
 
 	resource->occ_get = occ_get;
-	resource->occ_get_priv = occ_get_priv;
+	resource->occ_priv = occ_get_priv;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
 
@@ -684,9 +748,10 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	if (WARN_ON(!resource))
 		return;
 	WARN_ON(!resource->occ_get);
+	WARN_ON(resource->occ_set);
 
 	resource->occ_get = NULL;
-	resource->occ_get_priv = NULL;
+	resource->occ_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
 
-- 
2.54.0

