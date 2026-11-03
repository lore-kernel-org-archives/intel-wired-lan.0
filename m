Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877A606A330
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=g6Dns79R;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lsBaVMEg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BC5860859;
	Tue,  3 Nov 2026 14:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zWUpyVPT17d7; Tue,  3 Nov 2026 14:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D8656085E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716813;
	b=BUduaA1qnlWOREQyNHZNTgUN6mdmM8PF40bLlUpYgoaVNcNhG66ekMQI48igA2VhR7Hb
	 bfeNo4YrMSS04hFpstJ5F1EA5R1T/+PAf9WELfZnR0K7vQNLfTKi516CHwkBlw8RBnXWN
	 TmnPvwpnfHxWpF+SXrhF5VJ6ZlXUq8gSFNHwOsAF0CD7FnXPha4NUTFdRwGChcWmgZCfh
	 65iQ1VXFsbuoJEvH7T0DE6vIXh88BvCEATVdLjVImpi05TAh8p3SS9xDSnMTdTfW2N5+R
	 VyjdiOUfodev3GaShJua6WxtSi1LX/DFi6SFieGAerD1oBSEEXZle/cAiLIEwEL+Osw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716813;
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
	bh=P0MvXjZrXWkrQfZgOw8XDw3pr8Sx1MoRjoeIUFPH8so=;
	b=LVFiELFA7+mBHPxDVrP8pcpXSIpFhssFTsJnEOT501wlqORcBWP/C4lLs0wP9y90OsjQ
	 eos6y6NkIfRzo3jxveTHGcd/UPfGTzabGTRS7MXJ/vphEq0ytXJ53CFTEhIqE4ogRVIaS
	 7FqqF0Lfu+P/Lj/rFKjXtvhA4SUMsbli4uvHfxcSsbHoNXFIamcEXHOFJ5EJcGYyKarle
	 wqnqm62onTmJLyr0KmiCLOdq7sTaLCtfyhIBExZMn+dMt8Hm/WreIax4YOl6vGNIDRwMf
	 SNODcyH/w54g/Sww/17elPaML6sTmDQ7jM4pLfoBWxBMms4dK8SM9+0isjui2YlV12w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716813;
	bh=P0MvXjZrXWkrQfZgOw8XDw3pr8Sx1MoRjoeIUFPH8so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g6Dns79RHEcKUU/xYlheXwZFFCwH5gomMP0gKcwdFKXl6U7W0Fit+vAxO+ORPoWui
	 Qe+XKy3MFxO5NcSybeG2luONV8XAk5ayGz6SHBAyu/k7C76udedzkWUoqTrhd5boc0
	 Gw+IOczsLVN+/9q+E5cPeX0TDVA6kyycnVw3UGVKNEDR27EBGhf5Kl5HJGayD4Z3Wh
	 zP7z/lkeO0pFbKMANVAzYs1E+eSJDGA4yBlfUxxNAnLadQpx5fBp9+uXihEzfiMq2t
	 nDW32L2a4w2G1A8AXC7xS0+kAmeWbJG52ZuVl6Gp/WPQgEPhjYA+lx4vcD2BJHKGpQ
	 YJtRLw4oJMi2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D8656085E;
	Tue,  3 Nov 2026 14:40:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05A98235
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC55540070
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vW2hIKMvholK for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:40:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 19154400FB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716811;
 b=bgscJxw6NKUDpA98/vPUwh6+TafqjwVIKl5s6VbKK4r++J2KKu8HTXsBdy6JdtlbF69C
 VpzDV+CiMDuF71xK/eBjkn9iBnvzBlml6bEs4LSLx46U1adcHwrCMum/y4TvjLElzTkQf
 SNQxEjmfkg7NDeafsfhxC1bUH26J+Ag2EY3zh7vF4S98LoU89tvsrYNQpbLJa4+Q/MZQF
 mp0ElCbTrR4M7jR82EBs7/+VSrYmFZuAfK/XyIJAjUYpm55MSjAx926S5MJfxRT8TX9fb
 +NzJZQl+7XDldZsjWPsowRKQq6RNoCbab6r5FUMPx3f5LQvtZRf70bBpatqYHnySEzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716811;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=P0MvXjZrXWkrQfZgOw8XDw3pr8Sx1MoRjoeIUFPH8so=;
 b=hq/RN2JCqPuOfV6v/Njd/m79ZU0I5mUOfHevpb5MuUNGf6bXNGV7k3cmvDgHXoYxX1ba
 bo2lE/wiRELw0/Dhnbo131Q2QP4MrT03QCXhlEisHuUehuT5y/8rUYQBXKYF/Stf5ATlf
 vhxnukueTXPukkIrjCyZ0gW4mjBGlW1jvD+jHW5coPYn4uFNpAzxVpN1n3/KhtfQNgnEa
 ewlrnK6OohI+AQMYSmefP0pbwSMGPBRcGC9O6lEImtN7ZBov2Ux3w2VniqXn8KcTnsWTC
 jdXQBQ4S5qzjP//cjZDC2ljNvhcad7TO5jYFFwPZpjAaK+bH/Lf2oA7L3bOOaUpr6Ww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lsBaVMEg; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lsBaVMEg
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19154400FB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716811; x=1825252811;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ndtKM5pOidHsUWwRe7gQYfiOfPgxt1HpXR0bdo0FaoQ=;
 b=lsBaVMEgI5SdY+BwozzxPImr53RjYiK7sMntztE+9haqkfK5aJMFIRsa
 zMVcxmF3JAG6sNnTLBuFziz5GRKxFR1yYXIx140fluTDtQQ+B6uLMaxqj
 6gMRxO5Y+oTMSk3cRuI5LM2cH3MwJd+kIQW8x5AtS+Io4mwrmgc1dG6C7
 IUIOB9Hon3rW5xR7w83j5RtLt4dP0t3dxbxhCBYZ8mxSCt57PCvO9TOJI
 ZOTeQfQeNq6cvH8d423PEBpIIJ/z/+k9i4HRpCbi45XAqEYMh8HTjxJ5f
 uKe0B6COyDqK3tD/bk3E/dXFjRXNdh7PlzrzgIWkBs4nWM+ouklv+AMgK g==;
X-CSE-ConnectionGUID: NY1PUL3NSIe8K4kfreQeTw==
X-CSE-MsgGUID: Ua2TWWxJTZulWhIMOAIoAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324124"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324124"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:40:10 -0800
X-CSE-ConnectionGUID: ILHJJmwFTkyfTfm6UV7c+g==
X-CSE-MsgGUID: mpTNajGuTWmy0m1IObsikQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8290039"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:40:05 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 3C425312F1;
 Tue,  3 Nov 2026 14:40:03 +0000 (GMT)
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
Subject: [PATCH iwl-next v4 14/15] devlink: add devlink_alloc_drv()
Date: Tue,  3 Nov 2026 15:14:55 +0100
Message-ID: <20261103141646.303620-15-przemyslaw.kitszel@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

devlink_alloc() records the driver bound to @dev at the time of the
call as the owner of the new instance. That fits the common case of
a driver creating an instance for the device it is bound to, but not
a PF driver that creates instances for its VFs, as the VF device could
be:
 * not bound to any driver yet (VF driver not loaded, or
   sriov_drivers_autoprobe disabled), what triggers the WARN_ON() in
   __devlink_alloc();
 * bound to another driver (VF driver, or vfio-pci), which could be
   unloaded while the instance is still registered, leaving the stored
   driver pointer dangling (it is used to report the driver name in
   devlink dev info).

Add devlink_alloc_drv(), a variant of devlink_alloc() that takes the
owning driver explicitly, as devlink_shd_get() already does.

The first user is ice, in the next patch, which creates a devlink
instance for each of its VFs.

Such an instance reports the owning driver in devlink dev info, not the
one bound to the device in sysfs. Document that in devlink-info.rst.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4:
 * document in devlink-info.rst that an instance created for another
   device reports the name of the creating driver (Sashiko)

v3:
 * new patch
---
 .../networking/devlink/devlink-info.rst       |  2 ++
 include/net/devlink.h                         |  4 ++++
 net/devlink/core.c                            | 20 +++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index dd6adc4d0559..7ac5625e2934 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -25,6 +25,8 @@ versions is generally discouraged - here, and via any other Linux API.
      - Description
    * - ``driver``
      - Name of the currently used device driver, also available through sysfs.
+       For an instance that a driver creates for another device, e.g. a PF
+       driver for its VFs, the name of the creating driver.
 
    * - ``serial_number``
      - Serial number of the device.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index d01128ef393d..5c90edf9a92d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1693,6 +1693,10 @@ static inline struct devlink *devlink_alloc(const struct devlink_ops *ops,
 	return devlink_alloc_ns(ops, priv_size, &init_net, dev);
 }
 
+struct devlink *devlink_alloc_drv(const struct devlink_ops *ops,
+				  size_t priv_size, struct device *dev,
+				  const struct device_driver *drv);
+
 int devl_register(struct devlink *devlink);
 void devl_unregister(struct devlink *devlink);
 void devlink_register(struct devlink *devlink);
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 9b844e0c1bd2..efad05e54ba9 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -531,6 +531,26 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 }
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
 
+/**
+ * devlink_alloc_drv - Allocate new devlink instance resources for given driver
+ * @ops: ops
+ * @priv_size: size of user private data
+ * @dev: parent device
+ * @drv: driver that owns the instance
+ *
+ * Variant of devlink_alloc() for a driver that creates an instance for
+ * a device bound to another (or no) driver, e.g. a PF driver for its VFs.
+ *
+ * Return: new devlink instance, NULL on failure.
+ */
+struct devlink *devlink_alloc_drv(const struct devlink_ops *ops,
+				  size_t priv_size, struct device *dev,
+				  const struct device_driver *drv)
+{
+	return __devlink_alloc(ops, priv_size, &init_net, dev, drv);
+}
+EXPORT_SYMBOL_GPL(devlink_alloc_drv);
+
 /**
  *	devlink_free - Free devlink instance resources
  *
-- 
2.54.0

