Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8114EC00140
	for <intel-wired-lan@archiver.kernel.org>; Fri, 12 Aug 2022 13:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2CB7400D1;
	Fri, 12 Aug 2022 13:25:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2CB7400D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660310758;
	bh=/uvtAEWWsrKlSeOFuxcMsz/V3on4BrU7Der+CftdVbE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=XF86RkMljqHC3BVjwDwczAS2HxWA82c+Sus1KjC+f2v7KsMHuoRia/nInFoCoqX4H
	 96CJBLBiKr1prOaf6ErGLMsJfmcDucfwiUuWQf5bV417QGRCdfglwQkrnI7jpTmO5x
	 PAwFiCgbu81tNWrksJWq3WK9wJRA2iHp9i6z5ilgWusnoq73DOjeQ8mG5OwVZqlLJF
	 ev0fMMVwMgVd+IarixZgePeilYphamtQF1nKZ+9iWoCyMsYJTKO3DNka04/qVKiTrZ
	 LukZnFrQc0/UukT19MVP7bh/8Qj2F98RsekYAPRwBh4lPPdQGsC/X+jXYkLcCwNS58
	 pW+Nxp93W4qxg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HVTLsGXem6WO; Fri, 12 Aug 2022 13:25:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D8B7540BEB;
	Fri, 12 Aug 2022 13:25:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8B7540BEB
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id C82D41BF23C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Aug 2022 13:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7FAA83DEE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Aug 2022 13:25:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7FAA83DEE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xpdKCz44ajF4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 12 Aug 2022 13:25:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDBF083147
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDBF083147
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Aug 2022 13:25:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="290346947"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; d="scan'208";a="290346947"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2022 06:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; d="scan'208";a="674075737"
Received: from gsiwik.igk.intel.com ([10.102.18.50])
 by fmsmga004.fm.intel.com with ESMTP; 12 Aug 2022 06:25:54 -0700
From: Grzegorz Siwik <grzegorz.siwik@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 12 Aug 2022 15:25:46 +0200
Message-Id: <1660310750-290943-1-git-send-email-grzegorz.siwik@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660310756; x=1691846756;
 h=from:to:cc:subject:date:message-id;
 bh=N970h0AVv1qJTQgmmiQJUiepAUnCw2nhSKmBch9TzQ8=;
 b=l/xfZs+YBHACbPVe5Y2w4f3z0J4cAkncUFMhjab3Hx/raE9TuX3lzS9k
 Vd07gVBe68b0uAGEVUjTeX9QXl/DZSK8DWTjI66P5GYw7dQFwe2RDZUCK
 /fCbwgdYfeFEAiwHC46wqAxVrDkxNQjR2zLv0ib20hDehEcYXmlb4GSEH
 n0qmV/wIhKQv7C5OOAhzk9ksAGQXpOWe5cedDKpq5yq7X7JPvznyJnhXn
 ya4luQ1uaCp3RHtdkf29ZBzh3MOIQdBnvuDoaaplaHZVwyNIQDO0TMEEM
 lxNyeAui5tqX5wGIbUKJsCQid894EwVhpKoXjBzDgr4pACW50coIqESKQ
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=l/xfZs+Y
Subject: [Intel-wired-lan] [PATCH net v5 0/4] ice: Fixes for double vlan
 promiscuous mode
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Grzegorz Siwik <grzegorz.siwik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This series fixes known issues related to double vlan promiscuous mode.
When at least two interfaces are bonded and a bridge is enabled on the
bond, an error can occur when the bridge is removed and re-added. The
reason for the error is because promiscuous mode was not fully cleared from
the VLAN VSI in the hardware.
Ignore ERR_ALREADY_EXISTS error when setting promiscuous mode.
This fix is needed because the driver could set promiscuous mode
when it still has not cleared properly.
If the requested promiscuous mode setting already exists,
an -EEXIST error message would be printed.
This is incorrect because promiscuous mode is
either on/off and shouldn't print an error when the requested
configuration is already set.
Avoid enabling or disabling vlan 0 when trying to set promiscuous
vlan mode if double vlan mode is enabled. This fix is needed
because the driver tries to add the vlan 0 filter twice (once for
inner and once for outer) when double VLAN mode is enabled.

---
 v2: Fixed error message when setting same promiscuous mode
---
 v3: Fixed style issues, changed to return directly.
---
 v4: Fixed problem with patch applying
---
 v5: Fixed incorrect title patch issue
---
Benjamin Mikailenko (1):
  ice: Ignore error message when setting same promiscuous mode

Grzegorz Siwik (3):
  ice: Fix double VLAN error when entering promisc mode
  ice: Ignore ERR_ALREADY_EXISTS when setting promisc mode
  ice: Fix clearing of promisc mode with bridge over bond

 drivers/net/ethernet/intel/ice/ice_fltr.c   |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_lib.c    |  6 +++++-
 drivers/net/ethernet/intel/ice/ice_main.c   | 13 ++++++++++++-
 drivers/net/ethernet/intel/ice/ice_switch.c |  9 ++++++++-
 4 files changed, 29 insertions(+), 7 deletions(-)

-- 
1.8.3.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
