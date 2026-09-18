Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D824C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D94A60E18;
	Fri, 18 Sep 2026 13:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkrIlh9v7qq5; Fri, 18 Sep 2026 13:32:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8900E60E05
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738361;
	b=jE9OC5ui7b7G7FTeS3e5oa3YWcL5lyJfvtaSDkcUIDaicUOiCOajop5U7h2ufk/dBMwJ
	 4IvwRY0uy3GAESKptosr+fhiOgDwUFR9GNO5x9vSGHQF+zvmMqomniAdcQlNhhD5Wb1fB
	 upf6oUPMIBqsbVTcpO8y5hzDz3xsMWkJ8TQ8/iL1WIlf3VaYwnRlGyEM9WAQjnivMeUyX
	 seV+tXAcluKo5DDrNQmBzu7cjM1FL/GwqLfkCGngltUMDFZrgUaZC7Ge+4oTxptRxJcFs
	 JMfHPmgVNbYPUCak/xdOBb0AJFy8nshk2YnYTyf5ySsCSWQVICophD1MvMknx21K7nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LKoquSdDQYVhPhkJ62HgErg47vYhBwpkGsfSrmbEmMc=;
	b=qteIMIIbb/mc8rhB15cZFzpNl53VLB1dyWFJfKLYE5ctM1ekdWYTeoLW6gbg3Im+qmjv
	 LvLBYppX3dBW91DyMVdM4nDGrnggXvT6uKL856AByx9KI9171cARm8oUHAPEwhZ0KNXb7
	 iFFiSwm0khtpG2/h7MrvIR0hJxONF6m1X8rvOVhYLpUD9m9W/ay7JDgXSA/4BIdmmYSSs
	 uPu7aajwMJexCm+5ik1kwbqybllFzZ0gln1THTSCh/t74F9lcANlx79JmTPM5o/KlLQgc
	 a91JwDWaPMiXoKShDq4w14ggAw1MZ7OOn9wakb6fYeFtWzLDx107VonsLHXGhL5Uu7g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738361;
	bh=LKoquSdDQYVhPhkJ62HgErg47vYhBwpkGsfSrmbEmMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MM1JVRsNoRD0yID0R5xKHS03lNsLmqqUAKMkc54BuYjJeLfY4UPL4u5i1Pwal0zL2
	 3j2xLIu7fZagyUZjrIaKbyj3sQem9jFcgbT8ZEqePVnBIbytKBS7zjv3A8uvVOxnoW
	 lKRggfF7LKWIHbG4JBlnBfcun5hTy1x42guOktCa5fQTioirEpQInQbNI91sTwGp0u
	 ous/gtThXUDVwA7Cdfp1tkALM+cVZeAXE26Jep8KuWtZ+XWAk41LeOuMph+J6PPl1w
	 OSRBCNwA3g9f5VpI3PohIMgb5WVa75BXNgqUH87D0hV8pbzOZG7vX3I0i4h5PJAPr6
	 DBMmxjPY2XpSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8900E60E05;
	Fri, 18 Sep 2026 13:32:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DAAD843A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1346400B4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jRXwk6-oJVhk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:32:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3004D40348
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738358;
 b=kT73vXlSIMtfSS/c6KWgaS4z/wy6fpYjo+PR2OmZ6+UYEfSfYa7BkZrAxMDvxfefNQvc
 SJdnED6N/9yKY1mHgqgxXq9y8JqwhZNIgCK/83HIsIIERQ1k9ifJGMA96CVcMckhof17m
 I3q6Sa+8bk8LaLyIAazEj4KzPYyFcsa2Knla26G7Usjzn0azxqdWxaSQEF347YzHm+a5S
 f6vAlE9Akk9B3m6whpj/T/gggFFvJaDF98qPAU70tccaVVgKwr2v7HT2/e9GGx4Ed7jSb
 qlTdUpN4UM7WYE279LP3RTlnf0Ps+GC00vLv2ghKRjbKqmpvuI2nB1Hcqv27OMVrm6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738358;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=LKoquSdDQYVhPhkJ62HgErg47vYhBwpkGsfSrmbEmMc=;
 b=Vo0i4tPb8kbFO1Uj9SemZePGyPpgbG3o4sAweW/vPAW53nm44hKe8zYhHJwNrL3RLCg0
 AtopBBGL43mbcwQ1KNU42h9iTi47gi1lPDNAw+jlGL8XsnHv5nRe6gdanR884bJ+W8HlL
 U2V4UV+JVJwSzkgz5Um66/khJowC/m4jYuoJTs2H7MFDWPoUdoYKeH1iQXHvtb3CuYlKt
 49fpwan+bQjIwvuvXEgxbuJbnP43h0/rm6q28qHX1Z5ZElq0TrmxJy1xV1pUBBc4xJjMs
 vcwu6LFWyjptPNq502pIQrVKejo1z/eChqV0CMnRZPbyEVdPcwivL3yai023kBV8asA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LYsmzHEz; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LYsmzHEz
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3004D40348
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738358; x=1821274358;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VChwflk0shkuBtKgGE57//Nbv9qLEN/7fd5WM7wrFSc=;
 b=LYsmzHEzBxHeYedq8pehh0dLasjMOQxk8Llryg8090Niafq0LKk6GPRC
 Bz1Fr7CHTK7GOKSLm7cNJ+uoIgmxr2kZ5Bb3GCFd5pNixp5F61JeIVStx
 zBrlDH3UDog6qa5co+8XGg6fqiF2m0J4hhOb1UknOLiZHwWNZ01xxxDZT
 LDrlkh0nzUc5RcNDa2/WtgVf+1BEfB6EkMdCu5m11BNWyefsloRH3cvKx
 yu4apbtlMZd+x7JBpbExgrfUmFQtQhc/q3zFLNFMsLco0OXTU3MLkhA80
 sOTCaT26Vm1TeF4tsWyKrRPxQKmwH2xqkze58JtvhKf73AAbGauxnk4W9 A==;
X-CSE-ConnectionGUID: ZX3+HeRzTni7p4Y44VNq4A==
X-CSE-MsgGUID: nW3Gg8kJT0GYs+TXttm+oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776412"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115776412"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:32:38 -0700
X-CSE-ConnectionGUID: zY1nWEEXRpWb3zN5q2op9Q==
X-CSE-MsgGUID: 2G2F19iuR+OAsedfePvrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835241"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:36 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Tomasz Lichwala <tomasz.lichwala@intel.com>,
 Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3 1/3] ice: fix asymmetric pause negotiation
 reporting in ethtool
Date: Fri, 18 Sep 2026 15:32:32 +0200
Message-ID: <20260918133234.4169074-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
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
index bf9a821..a257b7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2365,8 +2365,9 @@ ice_get_link_ksettings(struct net_device *netdev,
 		break;
 	}
 
-	/* flow control is symmetric and always supported */
+	/* flow control is symmetric or asymmetric and always supported */
 	ethtool_link_ksettings_add_link_mode(ks, supported, Pause);
+	ethtool_link_ksettings_add_link_mode(ks, supported, Asym_Pause);
 
 	caps = kzalloc_obj(*caps);
 	if (!caps)
-- 
2.52.0

