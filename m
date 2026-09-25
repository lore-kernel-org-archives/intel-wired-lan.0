Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20972C9832A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 22:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C038C81135;
	Fri, 25 Sep 2026 22:34:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hgz1sGaEqQXn; Fri, 25 Sep 2026 22:34:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 169DB8114B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790375642;
	b=Pb3S0wsxf9nWf2YEQ0eRldmo2QqBk15Jqig10BCz05BDNwPf+dSgkMO2G3LEIlfTRWfl
	 JQz9p8IOeiIoBIyVcM6yOrTx5DtxtPNTGyA55sjyS/3csaRJ306GjgWytJEuKjIiC4r9t
	 oDLczRP1cB3xpq2hP5kjyu1xf0LRpZoylzIHzv/JtVdLMjUfxwrrBPtl1gWxMujeSiZVx
	 4NU0jQLl93x3IpKJFoLSTm5XFnYZF6H6Ew3BJ0rHmgUaH/P3kfSWZvi20sRpo8uKgDV6d
	 w2X55MPC6xxIdUazIr7RpAQdu5VyeJgE28Qvopqumqe03kf/hBhU6ldZcY5g+hLs5gA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790375642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O6FFl/MJa1UqxykSibMKhUVY9/91ydeNbKo3ew5Zq4U=;
	b=WZzjxAAk2AOIHHW8C06J5zupYNIen223OKMhFO9Bkp1Ygn5FAMWDNZA5dzda4IlrPhrc
	 dBtWD+8RCAc6MiyHqopVu+dcTFh0VlqLvU5K0h5l3wwtUfgd/jjnXfuf/JBLzfoTqLZaB
	 0ZjbuJ/8K043ad5VqyoyjmhdY3G/7S08L9h8JZ2OQ3LTxxLg0T5eIf9+hqGo1Z1R6ouNP
	 QhWFhc2Oqicnp9jFrZUo/XEsnKm5b2TYHyIU9q+iJabQ6t5tRaIF6HwJ3py8/xVnVAMqe
	 DkPu7Z9DrlePysDmCGDGs+afTnJV6ZkrG61Rr0weDVLWhL+C5QdkgzHdeBw03frSmlw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790375642;
	bh=O6FFl/MJa1UqxykSibMKhUVY9/91ydeNbKo3ew5Zq4U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TpDn5Hc4OFECP1Z8/vHjaHlVf1tK+Jb4aFaPZx0Obn7KcJSxXhwBgFzjFdIIzjgtP
	 aGkPijISpIF+5fezvOKGKjWIYJsiAK4d49lQrrl/lEjMC7WXsSSOfc0UmhBudvIPQ1
	 MYXmqchmD4cp/mtKoD98bktsny8W4G+I2igukL8vS7dkSWe8R2aFELn+n/jrZFA8a8
	 Q0V2MIjlZAJWjd9Gdz7kA0wGbuZ6w553SzuvdQzT6uUltdvbfM97czu1Ab17NOrm5D
	 FUYJvu41oxz+tSY6epTEqWVuME3p5dMmPABJB1Mm1So8BI9C3Ht8THxqyoflhkXDBL
	 dIhbNCUV1dmdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 169DB8114B;
	Fri, 25 Sep 2026 22:34:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A7E8355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8906D40A9A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sX-boVzSyWar for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 22:33:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E24940A82
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790375639;
 b=ta2z4rlmvHiWZvHP9Te3lIE9v3U1NopX/22BDwPnSyT/fBbLqj/OY555FGtfHdKWzr18
 Pe7OdExXaIg1D7xeRwpH7LXkcvSCze0yptXWtwop0o2iaZ+ZKV8jmrjUXoex1E07nSsRa
 I5R/Bl8bsOTJ4dLGoK+UEbWpK+Kl9ZZncYIkSvKWxj7FB3NEuX4lJ7NTsX+uN6iblR96H
 FO92bvhkl6SCE/RkoPr6R/BSHF+gothgYxPZXs+ZB5QmLcFX1gzQ5ETr1lTqaNLHqKOQo
 lP+0qmWmq1NHj1Ul7sJjAcss6BXstMYcyQwVa19RmuP20fxvc9IU+CzevdTWmy8Kmeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790375639;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=O6FFl/MJa1UqxykSibMKhUVY9/91ydeNbKo3ew5Zq4U=;
 b=EyvHUSC0oCcGGXbjfImUHUhQAPQ7VYm9w1hqcobx0LdMJb9f7eH53DXXqYZPKMc+1nGo
 byqjjZW24KIMiozOZWo7bSxL7N8DV324SO65k/Mwp4g6QrTWrjZu614N/wCNvyg2jqOfb
 8tprAF1tAhWEMOZKMjivV8+pdBIcfJKQtK0YUf+JWrl6JoyQy9hfznePgmRVzyAa1HFX2
 WHbzslLlS/rKXDMH7oelJ4Fgf45At44OgWbOUgVLSL7yej44MvfvMdyDCQgkJo03fEVa0
 YEtkxF33wv2eUmOYhRSF5KkJu25xl04HJgOL5Xb3msLsp9WPJD7qjWSIiKmJJ99CDkw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S2xd7uEU; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S2xd7uEU
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E24940A82
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790375639; x=1821911639;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=glUuKZKx5cqmlLMf4KB/vt8XRQXqy6FVeihuH84SKGQ=;
 b=S2xd7uEUU6wop8zfoRzL1su8jv3ee5MW7VJUw9uEymNqFbh6xocmnWYB
 RhngZGvcFRZZSwwaYOJ946mowTe/kinAC0Tb1kEm4JWgYZf64ALnxa3+D
 psWO7zhQ3tKnCpoCSgojCEwFbrq7anhnYho4yITLKlG+Z3+WJvuedOpc/
 xvk9MDmgtRuq1QVLnqIHButmVY5wT/R+DXscVYgWz/KqevhrAdmY0PD1W
 xrhNAcPFCNd1F1Eah3LJEOY3Vyn0R0Fh2jViw47N3L45mFU/6UrgKD1mp
 QS4uG2UN8FYKKobvnGfjOG6zCM3DT50y/QekbI7KkYAAlRmHisztswIp7 w==;
X-CSE-ConnectionGUID: Fbe4+iZtRbqoCmSAlSSH8w==
X-CSE-MsgGUID: kPqQ/PWDT1OFCuc8tdFTaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90071983"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90071983"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 15:33:58 -0700
X-CSE-ConnectionGUID: sb/G1GFnRDaZ59yprzIAoQ==
X-CSE-MsgGUID: ohN2STdoQ9+JR583vsyCXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="273053379"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2026 15:33:55 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, davem@davemloft.net, edumazet@google.com,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-net 0/2] ice: fix E825 PTP timer race and drop redundant
 cross-timestamp access
Date: Sat, 26 Sep 2026 00:28:22 +0200
Message-Id: <20260925222824.270640-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
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

This series fixes a race in the E825 PHY timer start path and removes a
redundant cross-timestamp command programming sequence.

The first patch serializes the E825 PHY timer start sequence with the PTP
lock and keeps the shared GLTSYN_CMD register access and incval programming
within the same critical section. This prevents concurrent PTP updates from
clobbering the source timer command and leaving the E825 PHY clock offset
from the PHC.

The second patch removes the redundant cross-timestamp programming of
GLTSYN_CMD in the capture path. The register accesses were mistakenly
assumed to be required for E823-class devices. In fact, it was the
E824-family (not supported by this driver) not E823.

Grzegorz Nitka (1):
  ice: remove redundant cross-timestamp PTP command

Maciek Machnikowski (1):
  ice: ptp: serialize E825 PHY timer start with PTP lock and incval

 drivers/net/ethernet/intel/ice/ice_ptp.c    |  6 ---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
 2 files changed, 21 insertions(+), 33 deletions(-)


base-commit: 349099e5d8082ab01e60d91fba9d107591c17371
-- 
2.39.3

