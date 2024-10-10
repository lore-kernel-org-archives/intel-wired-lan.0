Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87B1CF11F5
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Oct 2024 14:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53C556062C;
	Thu, 10 Oct 2024 14:23:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQaN8KyOI4wO; Thu, 10 Oct 2024 14:23:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A645F607DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1728570194;
	bh=bPkI0RrpKL2j9QF5+MxKuyW+Smc4rqiYT4OgCAl//7I=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=wePQecLYJ56jqbtbIn3orGSERHXPhCBWuC8PZQS4p9zSGoaLi1xsr8PvOz0Qhhi1X
	 jQjmGkLirJdomqv8pfK68kekggu4f2hz/i2j4yx36Tmhj5uyPdFrYJAnAn/IdfkrZE
	 OKLCjMdkxfv1zyk+rWo0vvbSrkd00khTIqPlATQfC8vzztDzaLw7eW/M1krU0hzemf
	 4Y8U4YN/5/kZcZdvxJsezXap2V1RG9KtorJ4kv9A8G54mqBURbg+fTcdX9A9FRqLGm
	 wgYeIvRxjJYOhWdOAymheIJYGX7zCsCUIj9S9pHaemEA+OhvqOJtWntvvYFFffDovs
	 1fAmbWRaJASiw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A645F607DE;
	Thu, 10 Oct 2024 14:23:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 286451BF4E3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Oct 2024 14:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 146CB6062C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Oct 2024 14:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AKpytiUnl30N for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Oct 2024 14:23:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=karol.kolacinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2CA64605C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CA64605C3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CA64605C3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Oct 2024 14:23:11 +0000 (UTC)
X-CSE-ConnectionGUID: mPclU3uLS9m/bVIWhEykOg==
X-CSE-MsgGUID: yQHFn33lSAeAuYwgIp5TpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39321092"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; d="scan'208";a="39321092"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2024 07:23:11 -0700
X-CSE-ConnectionGUID: nUNLTj/3TmuvRdjbIxLgNw==
X-CSE-MsgGUID: /SrTfLOPSVWe1XlAEzNhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; d="scan'208";a="99937486"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO
 kkolacin-desk1.igk.intel.com) ([10.217.160.108])
 by fmviesa002.fm.intel.com with ESMTP; 10 Oct 2024 07:23:09 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 10 Oct 2024 16:21:13 +0200
Message-ID: <20241010142254.2047150-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728570192; x=1760106192;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0xZO2lp6VcDxW0Dou79Y4m8CjL7bQyqt7vDopJMgQRU=;
 b=gn5/csBSW56WQt/2HZRj+Km3NKRpl5ZcCQ9De5oum2ISnkqBsByC560J
 d6esnj7hKCUt/ew7xinZNJL3t51xh36JYE6qut/pGspsnVHEBlK1IfW+K
 197bCkFG5TutPEhNl7jZtgGBSHMIG7/VtpsGA4dVuZ6UIb2qAtbSY/0vX
 0i0tgzED+vRho1B5NpMEYusibftaus3fPg4CzpaA9KLlB7zd+CplIm+Vv
 uRDZe81DqRY3ulQf7UiNcrQFq4JxjbAfr9lck9W2OiwsOG0NdwgQHZjBT
 wXz3gWixcZ4dksDXXNKdk47y3sFXWgmBdGHpGfXePgPVwu6xiyqhp2lZl
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gn5/csBS
Subject: [Intel-wired-lan] [PATCH v2 iwl-net 0/4] Fix E825 initialization
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
Cc: netdev@vger.kernel.org, Karol Kolacinski <karol.kolacinski@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

E825 products have incorrect initialization procedure, which may lead to
initialization failures and register values.

Fix E825 products initialization by adding correct sync delay, checking
the PHY revision only for current PHY and adding proper destination
device when reading port/quad.

In addition, E825 uses PF ID for indexing per PF registers and as
a primary PHY lane number, which is incorrect.

Karol Kolacinski (4):
  ice: Fix E825 initialization
  ice: Fix quad registers read on E825
  ice: Fix ETH56G FC-FEC Rx offset value
  ice: Add correct PHY lane assignment

 drivers/net/ethernet/intel/ice/ice_common.c   |  42 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  77 +----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 281 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  40 ++-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   7 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
 10 files changed, 243 insertions(+), 240 deletions(-)

V1 -> V2: Removed net-next hunks from "ice: Fix E825 initialization",
          whole "ice: Remove unnecessary offset calculation for PF
          scoped registers" patch and fixed kdoc in "ice: Fix quad
          registers read on E825"

base-commit: ab8024f0207eec0f376591c958b5bd30a03ae370
-- 
2.46.2

