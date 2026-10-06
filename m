Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43317CA6001
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C24D40634;
	Tue,  6 Oct 2026 14:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j__eveU1jNXd; Tue,  6 Oct 2026 14:33:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 40837405FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297200;
	b=dFGMsdNCoX2oqiTTmOohkVRVSAyLQnKQX2jKY9fDyNi8SljzEDJ19mIvg4g0yzjy8RHS
	 YX95lRWOkscjzDPexjAJsD5pTz7f9DAJw6XaNTMqICCyJiP4WKYtomDfEecIpUS10BooE
	 478/ps7OCzeUPhX7Bn7x3QwGgaVzCQ0tcFzgGkctBR50tM9UYjVKTX7fcRxkifIZFtY5O
	 X63kF93cj9BARh9n4mStWtaWCwQqTD9ruSeS8HEgKj2mV9yemu0LsyQ1s6Tl1dHRWDnhO
	 kFqTljFUfQt/XVzdWUbViyBLa4wiPcHxABkRGtWVuUVR5fNZV8sIfbGVaQ7mu8SXu2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x7nWfQ0yujhknk6sX4Mt9s8nPbtRiQSpNJrIYJFBBTU=;
	b=Cv1Y4iXk3RAHjR6jk8pRoLKc9w5Ufquz9k66lxNKtvHU/MySHHRA98koFY0oumETQU6O
	 Kgj+x6ZMg1I3/Y9O6Ioo7GZESEowXbc9n1PIvsULtjUXNuqobTjQgbqyMtV0Gxnk3zZum
	 vQMK4T2KW7QKQ6dbdcrghIVJAM79QaNkjt01NTXcWXQNtmito+26sTe4AmoR9/Kc5yuZ8
	 A7V+dcMwltogQSkHeXzf2vuUh0dCXCIcRby5NyF6GJl+ydJzmdGLLKYgzdfMjpnxtRsnI
	 wSstMq05DsO5HmWLc4nW0V2Wkx8q+BffC/lCHY3qmQihpbysKdSnoicKY0LmbTNx/CQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297200;
	bh=x7nWfQ0yujhknk6sX4Mt9s8nPbtRiQSpNJrIYJFBBTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ti9luiX/HhwVgidQjJSj/5TbNC6pY8YAGbFZv3XFcQLL6YHVJ8j+PrSMTtt0GMftn
	 /DXsLWi7Txfll8qh4pX/2MTEyOVEuzZvmFACsqzQoIXC1rpCBJkVr+l0qZAM+ox07d
	 BJfkQT/6Z8Mt+0mtyQsI45OUGZ0CKzMREdPMKTr8Xan5sgUKF7R0+jFDVuygJqMI1/
	 yo7e/0V4G4MV2z252PDdIg1YQ+yY/LGq5MHQVaeruihniFUrzAZTVv2Vkkcgtz83q8
	 H/MfUTzjl2TtugEg/U0I3U2gWqU+NkiRYD1ct73ItxjHas6QSFLjDomlzmxzvQXvkQ
	 RokTceEB8dgwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40837405FB;
	Tue,  6 Oct 2026 14:33:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24193341
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A2B1607CA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJmbMTKdC-An for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 357F5607D8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791296689;
 b=Pq5OeIafRMgZdtmDBEtyn/DtjGCb/9XIVptkZWqFI6m5admRUTlEXRDxrkXbR6M27BYs
 qEbk0ex9pYDcaMQGQVxBI+DGG8Q5WrBg8G/QKgPtBWX27+4f7m64FdKmQaT/eV398xXxR
 C3DuJrpgWfRNVmLF56kN5t0vT4xU3wJT08jKDZtzSIAHlYG3ioUkx9zF5g4ZX5ZmA7Cmm
 ac/3rMpS578X/KZb4HFs8QnmejMZt6i3zxUS/y/ECNI/jxPgdx67li/KzoZ8PpVcrcgPs
 JdLmWeHD0ISc9z4rg2QpwVnCxPkts2IcOjDdbBexCcxAMokjxwhdfPy8h5+2SbnJdlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791296689;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=x7nWfQ0yujhknk6sX4Mt9s8nPbtRiQSpNJrIYJFBBTU=;
 b=mzc2ouoFm+DZyA/xufgcGa+rkcb5Fqu2D7NL2M4DWmPQIt4V7vyKMgM7GWeszTs6xjVS
 f07vmeixTpWoLJIc6tI4n1OJVoAz0iIFJqIx3kvxlaQmB81BhvDiU7+unnUYrWHio/wlT
 R7Cb1O4T9JS5CdBptQV3bTlKHtbVX0C8+0lJom7rG0QRE5UcfXN991+v8kUK6VDAu7p6/
 9JUlxw2NHheGePx36enyy/GKA5owTCC3uYPKAyi6hIVvwu/olZDHQNdFQpTOX+mqZiZPC
 UU/koPBwskb8diOVytgPq0cKvAh1ebDspv15f/CgkY4TbPEIuEC15rI8cM6ZXhSU6qQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JbiTF+6h; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JbiTF+6h
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 357F5607D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791296689; x=1822832689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9nJEGVcvWziY+gIYPXdMPwRGwjDMrwG9fGr6gH1UCvM=;
 b=JbiTF+6hlFgkQFSo5yp96y6uZs3gWdWMHGy5YMvfkKBVfx6MjsRgB1yl
 IKD6u8mLEn/hiZlI2PeSe/bg05KUQPLC6INcliyJzqzxFHapLpZQU8nvI
 994hm+huLzD9oUFHPVcFFLYO32S/7wd7+xdau2AMO4OElN01pk5bsgRlg
 JFCQP8/rx59NQlHjP0nD1v8NvPqCQv8Q/1MWjha2ZBYxFk06U8Y6o6YKB
 IqKDK80G6kG30mZJt2YYCT7NpfRuW6dyihHKhuR53yTbjmT0vvRTbWEFc
 q33B2Jx3YP8s9zsNZCz8HJM8MiJVB0G8625/sGctMKE9Va3E5Nx2uzqMy w==;
X-CSE-ConnectionGUID: 0mRwXTTjSuSyzBSQpHsOYw==
X-CSE-MsgGUID: nQ8gxseXRLy1HqXJIFGMtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="117507487"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="117507487"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:24:49 -0700
X-CSE-ConnectionGUID: 3LEiGtpDQUay6DBxUM534A==
X-CSE-MsgGUID: ZbfmSHQrQI+09dXxSMV0uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="305105861"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa001.fm.intel.com with ESMTP; 06 Oct 2026 07:24:48 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Tomasz Lichwala <tomasz.lichwala@intel.com>,
 Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v4 1/3] ice: fix asymmetric pause negotiation
 reporting in ethtool
Date: Tue,  6 Oct 2026 16:24:43 +0200
Message-ID: <20261006142445.2867917-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261006142445.2867917-1-aleksandr.loktionov@intel.com>
References: <20261006142445.2867917-1-aleksandr.loktionov@intel.com>
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

From: Tomasz Lichwala <tomasz.lichwala@intel.com>

Add Asym_Pause to the supported link modes so that asymmetric pause
negotiation is properly reported via ethtool. Without Asym_Pause in
the supported modes, 'ethtool -a' incorrectly shows 'RX/TX negotiated: off'
for asymmetric pause configurations, even when pause is properly
negotiated and functional at the hardware level.

Fixes: 5a056cd7ead2 ("ice: add lp_advertising flow control support")
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 82ddc21..8b7d7be 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2374,8 +2374,9 @@ ice_get_link_ksettings(struct net_device *netdev,
 	/* All ice_media_type enum values are explicitly handled above. */
 	}
 
-	/* flow control is symmetric and always supported */
+	/* flow control is symmetric or asymmetric and always supported */
 	ethtool_link_ksettings_add_link_mode(ks, supported, Pause);
+	ethtool_link_ksettings_add_link_mode(ks, supported, Asym_Pause);
 
 	caps = kzalloc_obj(*caps);
 	if (!caps)
-- 
2.52.0

