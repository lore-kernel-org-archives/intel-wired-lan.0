Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCD7C072A2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Nov 2023 03:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AD40408DA;
	Wed, 22 Nov 2023 03:16:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AD40408DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700622969;
	bh=lWGBl7nhqq5uvbi6r2RDegRfmwTtYMQvlk+1byR+zek=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=h7xdbJqfAosPf4kdXygNiGXWd/BbPQLvq0JyKc7LbIiZDj/CkyzQHSNi718tWLsDV
	 DYZJUMxpwViEW7HBO+wEI++dt/odeZnljEiidTD2M4kyBbAXAYaeVE0DZodNu1Wz/o
	 t8SmKKNcDIPzgYQI8QGJh0DxxXVX9xGgVC8y6bt8v1vNQkZ6tL9MWVaMJiVyNXtf8g
	 1R8c76M72DFL2eX6lPIcKCRvJTia4qNrTiZMZaUHtwc2t99Uacnu+xqAq3+HuKUoU2
	 PzuaK5k+v9GUUkyr/yw7HxRcIWdSMRNXNHI0PiIPYVeUTlptOOgRRYtci2K8C+iPur
	 md6yRsZ8Y9+jw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xULtmgvU9Gxz; Wed, 22 Nov 2023 03:16:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77A36408DE;
	Wed, 22 Nov 2023 03:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77A36408DE
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 7CC611BF350
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Nov 2023 03:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5126D408DF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Nov 2023 03:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5126D408DF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZQ8sAlBu6N9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Nov 2023 03:16:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E65F6408DA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Nov 2023 03:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E65F6408DA
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="456302479"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; d="scan'208";a="456302479"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 19:16:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014104140"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; d="scan'208";a="1014104140"
Received: from fedora-sys-rao.jf.intel.com (HELO f37-upstream-rao..)
 ([10.166.5.220])
 by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2023 19:16:04 -0800
From: Ranganatha Rao <ranganatha.rao@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 21 Nov 2023 19:10:30 -0500
Message-ID: <20231122001032.2959301-1-ranganatha.rao@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700622965; x=1732158965;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lnk0AR0iJLU/GDfM/FT+r8pH4x2MEkHin41VaFUQH9s=;
 b=kmYmeAbBHOsWxGHPEV2xsepndaxfgeKiHE5Crw7YtJKPEE0JC4N4z1Cc
 1OM7v+ALmXLU2M+0TmTInGhVW181YGx0uiJK90DH4lWmBVqJIifogTsQQ
 YRXDlfK8b8/jmWh393r6ss21YuB3U8kG1wJPQu31p+9awdMbAUAQtZx6y
 1z+zDG4w4VtzPw4m9n5UOx/+0MI9ZoBuwIRzkb468DOsvDs7q17vtfKd0
 uVw3R4ZNQWAFHylSeTOsvPLqKiTYsXR7nuhk4muhvRaksIU0e5z8glwLG
 5wjRFpvaKwZf8ILtHBRnpGJmQITip8q7Amu5osA6OCYggLsnJUaG+bYaq
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kmYmeAbB
Subject: [Intel-wired-lan] [PATCH iwl-net v1 0/2] Introduce new state
 machines for flow director
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
Cc: Ranganatha Rao <ranganatha.rao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fixes current design flaws in flow director by introducing additional state
machines.

Piotr Gardocki (2):
  iavf: Introduce new state machines for flow director
  iavf: Handle ntuple on/off based on new state machines for flow
    director

 drivers/net/ethernet/intel/iavf/iavf.h        |   1 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  27 +++--
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  15 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 107 ++++++++++++++++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  71 +++++++++++-
 5 files changed, 198 insertions(+), 23 deletions(-)

-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
