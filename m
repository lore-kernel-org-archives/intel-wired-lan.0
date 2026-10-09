Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA02CA9EBD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE8B240919;
	Fri,  9 Oct 2026 12:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xvjzIggC4OZ9; Fri,  9 Oct 2026 12:14:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F8024091B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548093;
	b=B3MBM/AiXjwUpYuXPamKaJlCRpgFy2HNG70r/scVPr0bw0eOdA0x1IR5kT5yslQWtxqJ
	 2JLkOOH8kehoFAE+IeUMjWzJvqbWsmkFFj5F92q3+KhQ96jCMENH5i4k4JNetgnta/0EF
	 XTHzSYQIYVFQFDz1sDgQc5cIl0zd9Jf8n3XotwsVunj6fOMP8dzhVC8CYCj0wkr61VCZ7
	 JKk8CcWui1qAvzvKvs/LWbRNhF/b3FgEZra27WaVX994DSZd72ZxeUQ2tSr0zHkz3gim7
	 MX6/n5PAStY5mCYdN4j5H36eUymeSoMB3vRTsRiL9Nxfu5gB9p9xXS8PUHxxtFXLiNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548093;
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
	bh=5aFKpUIrQyYGlR7+7DCsc8ydZ5MihGyMtHWnYZGOLfE=;
	b=osOhx0CNby7+AnZN1aLL0uEAsLxhrvFW9nMg94NcnbFjdUdfk98Kn5NmW6uIHiOIh1EP
	 nh8mSvL7zfANWNDvy0OMBoLp8f1HpXsRejZacDBpaakAvtV0wYHvy/egPEtdFjiAOh80E
	 ygaG0nyobrLYMCnHoCfZY/Eh2jVseGerupnEq897Jhv9shMXCuO205YhEfeBOZyvlfnir
	 yVve86S4go5h8IJaDGSmhkBMlXyiZMFsT8gB/bZn3weFiAQBHeHffn97l+/veqZgOLH+5
	 8sgeBUIMiTAvquxx1dxIJJkLmzt2+2kDwGKuNjIvI+KBdATuq6k1RiXn2uEeHHrkfHQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KSyIWUoY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548093;
	bh=5aFKpUIrQyYGlR7+7DCsc8ydZ5MihGyMtHWnYZGOLfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3Cu9vUAkSGQValEbt/NBLHeZXCSWJ5dS7Yz0qIf63HXtIJmluWvb+64mg4I7eKtcJ
	 nQ2b19SvN8xPgck80f4i0uT3RQ39dVfKkCfVx/LLuai6G1SLUxOODf+TMUp7XFm8Og
	 +lg8sNqrRag6/MpoSJIkH9xu92SxCkPCsfU6gY7mLsQq9NtVDKoIo459uplCJv3sw4
	 cBbFnUjbxFGq94lL/RaZP5XwNkNhO+cp4P7cZD12DImrht6OTG9//OUj1cCDPfm55o
	 HSZZ2uVRO7hZl5wBs/PMBIq0DeSZCSfTIHERGMXtWDeLS5CJpMJflbXQXri17rF14G
	 TwjX7MdRO0P6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F8024091B;
	Fri,  9 Oct 2026 12:14:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90D31317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82AC040902
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZ1CozpAaY2S for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50AF2408FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548090;
 b=YwUlU8h4RMztbL/aiFY9/mePFxsav0Hb6Sl06RGFJqJst+JOukG2boIGDLPpaXW1wfNj
 ehq7I98MX/2MG6tHws8QNT+Ogh8uoht7m2H8W+T2M8sRwOPQFA1qqdA+trHWqRUDFw0uP
 6PYnJ9nqnLtr8k8eMaz+UXgjpbzrBKVW1IYiz50bpx4+cew0bGfH5Z0Dq3cbSll+EUkEN
 uTDNBgav/G9+v5G6xlW4xobKRPlWlpKrWe3PwPCcG4dPv8scLagJ5ULjNHod2moy0sDXW
 J4VdcuP39aVz3fXjfXp/2gw5MV+NFzHqa68B88iZNgl2mWX8k/NUjq5eXZOICH+lNyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548090;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5aFKpUIrQyYGlR7+7DCsc8ydZ5MihGyMtHWnYZGOLfE=;
 b=FLbTp0mW/IlgAo0l92oBrDz0D6GX9+8/U5vjeudpmTFA8ehu5OnGcyB2bpDOfW7y8yDb
 Aj6cj97hzZS+XEsSVg102tgTIBmE9+Jfc/xRN+OwKgCkfRxGn5j9c/Vg2YVD5Ui1qcps/
 wnN+MTTd+Y2ayPTYDeTZdxwq3TktowLQb0uT5orLioPXMJGg1VBgMthlQFMeZzZrehyda
 mG4HnpyeE93NXeaNMakZT9psqS3VEj5VggW43CfSC9GmO30EnAnhbqbybs3fQFQQq5yUI
 wOrk/SJgoXW5My2SuxyrJbRPpRzmWGqzwsvu753K3whDoqUHizKSi1Bo8ZNlP/cUxsw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KSyIWUoY; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KSyIWUoY
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50AF2408FF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548090; x=1823084090;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S21YojpVXyoD0w7YKuSVQH09IvJc9X+ncpEbKejmmH8=;
 b=KSyIWUoYsTbUheSlHN6IeSQaH4lQN/K0iU2VWUUI1odDahxYGpHuVCs3
 T8lkmlYuPrTShWYKL+Sm5kBmXHtewOjYtZe4vKrSwP24BfDwK/U7Eznz2
 riSyR0KeSu3nPbF4YiyGNNiPO94m5yjBrWd+Vo2UNfPXi++A2QGImq2jo
 VFa6b+m7jInwTKQYYX7WRxQZsP07zB6cVuOUxBZDGP9Z3rJa9/YvNkMwW
 eo/oW6CbbAL5aaF8S/2K26JAD9iXyCavPo2gOKrv+AXoeVjTJRJM5Dwwj
 3VpJ9e6AdfVcHgITlJ3MEOr70U/xG1Sz7yKvMDFVL13amqWN2h3BZFGZ5 A==;
X-CSE-ConnectionGUID: YcMN24pARO+6Jpr96g3sUw==
X-CSE-MsgGUID: tNx9iE15QIWD0SgDlIQj0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251088"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251088"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:14:50 -0700
X-CSE-ConnectionGUID: uQPJSAOtRQCsQHhq/2VTmw==
X-CSE-MsgGUID: DFLgBQePTh2WBzqmhVqa1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420383"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:44 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 781AE2879A;
 Fri,  9 Oct 2026 13:14:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
 skhan@linuxfoundation.org, rdunlap@infradead.org, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 01/14] devlink,
 mlx5: add init/fini ops for shared devlink
Date: Fri,  9 Oct 2026 14:04:12 +0200
Message-ID: <20261009121433.30347-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add .shd_init() and .shd_fini() ops, that will be called for the first
devlink_shd_get() (to initialize driver's priv data) and on the last
devlink_shd_put() (to allow for the cleanup). Both ops are optional.

.shd_init() could return an error, which will stop creation of shd
instance. The initializer also gets an additional, optional param,
that driver could use for any needs.

devlink_shd_get() now returns ERR_PTR() on failure instead of NULL, so
the error from .shd_init() reaches the caller. Adjust mlx5, the only
user, to that and to the new param.

If any of the callbacks will need to get devlink instance, it could
be accessed by shd_priv_to_devlink().

Both callbacks are called with devl_lock held, .shd_init() before
devlink is registered, .shd_fini() after it is unregistered.

Next commit will make use of the callbacks, a later one will make use
also of the additional param.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
(v0) first discussed at:
https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com

v1: remove redundant added blank line (Jiri)

v2:
 * call devl_register() only after .shd_init(), so there is no NEW/DEL
   notification pair when the init callback fails; adjust the order of
   devl_unregister() in devlink_shd_destroy() (Sashiko)
 * return the error from .shd_init() to the caller instead of
   collapsing every failure into -ENOMEM, devlink_shd_get() returns
   ERR_PTR() now (Sashiko)
 * commit message: .shd_init()/.shd_fini() are called outside of
   devlink registration; the init param is used within this series
 * kdoc: use @shd_init/@shd_fini member tags, fix the "shd_devlink'
   priv" wording, document the calling context (locks, before
   registration/after unregistration) and that a failed .shd_init()
   is retried on the next devlink_shd_get() (Sashiko)
 * devlink-shared.rst: document .shd_init()/.shd_fini(), init_param,
   ERR_PTR() return and shd_priv_to_devlink() (Sashiko)
---
 .../networking/devlink/devlink-shared.rst     | 19 ++++++-
 include/net/devlink.h                         | 30 ++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  6 +-
 net/devlink/sh_dev.c                          | 57 ++++++++++++++++---
 4 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
index 16bf6a7d25d9..f8b2a3d8aa82 100644
--- a/Documentation/networking/devlink/devlink-shared.rst
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -45,6 +45,14 @@ The following functions are provided for managing shared devlink instances:
 * ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
 * ``devlink_shd_put()``: Release a reference on a shared devlink instance
 * ``devlink_shd_get_priv()``: Get private data from shared devlink instance
+* ``shd_priv_to_devlink()``: Get shared devlink instance from its private data
+
+``devlink_shd_get()`` returns ``ERR_PTR()`` on failure.
+
+The driver may initialize and clean up its private data of the shared
+instance in the optional ``shd_init()`` and ``shd_fini()`` callbacks of
+``struct devlink_ops``. The ``init_param`` argument of ``devlink_shd_get()``
+is passed to ``shd_init()``.
 
 Initialization Flow
 -------------------
@@ -55,7 +63,9 @@ Initialization Flow
 
    * The function looks up existing instance by identifier
    * If none exists, creates new instance:
-     - Allocates and registers devlink instance
+     - Allocates devlink instance
+     - Calls ``shd_init()`` (if set), on failure frees it and returns the error
+     - Registers devlink instance
      - Adds to global shared instances list
      - Increments reference count
 
@@ -67,7 +77,8 @@ Cleanup Flow
 
 1. **Cleanup** when PF is removed
 2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
-3. **Shared instance is automatically destroyed** when the last PF removes (reference count reaches zero)
+3. **Shared instance is automatically destroyed** when the last PF removes (reference count reaches zero),
+   ``shd_fini()`` (if set) is called after unregistering it
 
 Chip Identification
 -------------------
@@ -85,6 +96,10 @@ Locking
 
 A global mutex (``shd_mutex``) protects the shared instances list during registration/deregistration.
 
+``shd_init()`` and ``shd_fini()`` are called with ``shd_mutex`` and the devlink
+lock of the shared instance held, thus must not call ``devlink_shd_get()`` nor
+``devlink_shd_put()``, and must use ``devl_*()`` variants of devlink API.
+
 Similarly to other nested devlink instance relationships, devlink lock of
 the shared instance should be always taken after the devlink lock of PF.
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 7abd23376319..98bdde4f72ca 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1607,6 +1607,34 @@ struct devlink_ops {
 	 * with other operations.
 	 */
 	bool supported_cross_device_rate_nodes;
+	/**
+	 * @shd_init: Shared devlink instance initializer.
+	 *
+	 * Gets the driver's priv data of the shared instance (the same as
+	 * devlink_shd_get_priv() returns) and the init_param passed to
+	 * devlink_shd_get(). Should initialize the priv data. May be NULL.
+	 *
+	 * Called when devlink_shd_get() creates the shared instance, before
+	 * it is registered. If it fails, the instance is freed without calling
+	 * @shd_fini, and the next devlink_shd_get() for the same id will try to
+	 * create it (and call @shd_init) again.
+	 *
+	 * Called with the global shared devlink mutex and the devlink lock of
+	 * the shared instance held, thus must not call devlink_shd_get() nor
+	 * devlink_shd_put(), and must use devl_*() variants of devlink API.
+	 *
+	 * Return: 0 on success, negative errno to fail the creation.
+	 */
+	int (*shd_init)(void *priv, void *init_param);
+	/**
+	 * @shd_fini: Shared devlink instance finalizer.
+	 *
+	 * Gets the driver's priv data of the shared instance. Called when the
+	 * last reference is dropped, after the shared instance is unregistered,
+	 * in the same locking context as @shd_init. Should clean up the priv
+	 * data. May be NULL.
+	 */
+	void (*shd_fini)(void *priv);
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
@@ -1672,9 +1700,11 @@ void devlink_free(struct devlink *devlink);
 struct devlink *devlink_shd_get(const char *id,
 				const struct devlink_ops *ops,
 				size_t priv_size,
+				void *init_param,
 				const struct device_driver *driver);
 void devlink_shd_put(struct devlink *devlink);
 void *devlink_shd_get_priv(struct devlink *devlink);
+struct devlink *shd_priv_to_devlink(void *priv);
 
 /**
  * struct devlink_port_ops - Port operations
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index b925364765ac..2c58f820b018 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -43,10 +43,10 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
 	*end = '\0';
 
 	/* Get or create shared devlink instance */
-	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, NULL, pdev->dev.driver);
 	kfree(sn);
-	if (!devlink)
-		return -ENOMEM;
+	if (IS_ERR(devlink))
+		return PTR_ERR(devlink);
 
 	dev->shd = devlink;
 	return 0;
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
index 85acce97e788..4f1b2f24b755 100644
--- a/net/devlink/sh_dev.c
+++ b/net/devlink/sh_dev.c
@@ -34,43 +34,61 @@ static struct devlink_shd *devlink_shd_lookup(const char *id)
 static struct devlink_shd *devlink_shd_create(const char *id,
 					      const struct devlink_ops *ops,
 					      size_t priv_size,
+					      void *init_param,
 					      const struct device_driver *driver)
 {
 	struct devlink_shd *shd;
 	struct devlink *devlink;
+	int err;
 
 	devlink = __devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
 				  &init_net, NULL, driver);
 	if (!devlink)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	shd = devlink_priv(devlink);
 
 	shd->id = kstrdup(id, GFP_KERNEL);
-	if (!shd->id)
+	if (!shd->id) {
+		err = -ENOMEM;
 		goto err_devlink_free;
+	}
 	shd->priv_size = priv_size;
-	refcount_set(&shd->refcount, 1);
 
 	devl_lock(devlink);
+
+	if (ops->shd_init) {
+		err = ops->shd_init(shd->priv, init_param);
+		if (err)
+			goto err_unlock;
+	}
 	devl_register(devlink);
 	devl_unlock(devlink);
 
+	refcount_set(&shd->refcount, 1);
 	list_add_tail(&shd->list, &shd_list);
 
 	return shd;
 
+err_unlock:
+	devl_unlock(devlink);
+	kfree(shd->id);
+
 err_devlink_free:
 	devlink_free(devlink);
-	return NULL;
+	return ERR_PTR(err);
 }
 
 static void devlink_shd_destroy(struct devlink_shd *shd)
 {
 	struct devlink *devlink = priv_to_devlink(shd);
 
 	list_del(&shd->list);
 	devl_lock(devlink);
 	devl_unregister(devlink);
+
+	if (devlink->ops->shd_fini)
+		devlink->ops->shd_fini(shd->priv);
+
 	devl_unlock(devlink);
 	kfree(shd->id);
 	devlink_free(devlink);
@@ -81,46 +99,53 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
  * @id: Identifier string (e.g., serial number) for the shared instance
  * @ops: Devlink operations structure
  * @priv_size: Size of private data structure
+ * @init_param: Passed to .shd_init() callback alongside driver's priv;
+ *              this value need not match across all users of the shared
+ *              instance
  * @driver: Driver associated with the shared devlink instance
  *
  * Get an existing shared devlink instance identified by @id, or create
  * a new one if it doesn't exist. Return the devlink instance with a
  * reference held. The caller must call devlink_shd_put() when done.
  *
+ * On creation, @ops->shd_init() is called (if set), see its description
+ * for the calling context. Its error is returned to the caller.
+ *
  * All callers sharing the same @id must pass identical @ops, @priv_size
- * and @driver. A mismatch triggers a warning and returns NULL.
+ * and @driver. A mismatch triggers a warning and returns ERR_PTR(-EINVAL).
  *
  * Return: Pointer to the shared devlink instance on success,
- *         NULL on failure
+ *         ERR_PTR() on failure
  */
 struct devlink *devlink_shd_get(const char *id,
 				const struct devlink_ops *ops,
 				size_t priv_size,
+				void *init_param,
 				const struct device_driver *driver)
 {
 	struct devlink *devlink;
 	struct devlink_shd *shd;
 
 	mutex_lock(&shd_mutex);
 
 	shd = devlink_shd_lookup(id);
 	if (!shd) {
-		shd = devlink_shd_create(id, ops, priv_size, driver);
+		shd = devlink_shd_create(id, ops, priv_size, init_param, driver);
 		goto unlock;
 	}
 
 	devlink = priv_to_devlink(shd);
 	if (WARN_ON_ONCE(devlink->ops != ops ||
 			 shd->priv_size != priv_size ||
 			 devlink->dev_driver != driver)) {
-		shd = NULL;
+		shd = ERR_PTR(-EINVAL);
 		goto unlock;
 	}
 	refcount_inc(&shd->refcount);
 
 unlock:
 	mutex_unlock(&shd_mutex);
-	return shd ? priv_to_devlink(shd) : NULL;
+	return IS_ERR(shd) ? ERR_CAST(shd) : priv_to_devlink(shd);
 }
 EXPORT_SYMBOL_GPL(devlink_shd_get);
 
@@ -159,3 +184,17 @@ void *devlink_shd_get_priv(struct devlink *devlink)
 	return shd->priv;
 }
 EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
+
+/**
+ * shd_priv_to_devlink - Get shared devlink instance from its priv data
+ * @priv: Driver's priv data, as returned by devlink_shd_get_priv()
+ *
+ * Return: pointer to shared devlink instance the @priv belongs to.
+ */
+struct devlink *shd_priv_to_devlink(void *priv)
+{
+	struct devlink_shd *shd = container_of(priv, struct devlink_shd, priv);
+
+	return priv_to_devlink(shd);
+}
+EXPORT_SYMBOL_GPL(shd_priv_to_devlink);
-- 
2.51.1

