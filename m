Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82801C43334
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jun 2022 12:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F738408DA;
	Wed, 15 Jun 2022 12:27:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S1x6GiiQhuur; Wed, 15 Jun 2022 12:27:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27D1740AB6;
	Wed, 15 Jun 2022 12:27:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 8F8471BF5A1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jun 2022 12:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A72940AB6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jun 2022 12:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bnG3K9kbZ8t7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jun 2022 12:27:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D04F9408DA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jun 2022 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655296030; x=1686832030;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JSkccpRUloPYm1RdhfIXHPXxzxXRU9wj9KgYiZyHkqU=;
 b=kxlMqiqC249N5msP37IClhOyEm+t7zk6nhhgbRMxDcmDc4O7xZNYsyxi
 swoeco7BKexETFbeuTLKEGDsP2PDj9TbhC1wqUxPVBQbvxHYtCsa9NXfg
 bf6/TMedb1/UaeauDpQKQwKFVfj2yYO8PV9NG7oFv2wDMrhoclUnnCbF7
 WpQqrAsUgF0f/T23bP6ltL1HGaHzgVRIFNXGnDiyq3S7O1LgjaUejs6o3
 UToCq74EGKVqEOiiIhZoJankGbg0J1l/4i7tMN5Tu6U7nrMlRzrnpoZ/4
 CkPfRGkkcDB13pV7P1W7rlCb7uE+mW611R3YzT9kkv4oYwWwgV2p8tRmS Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="259404301"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="259404301"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 05:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="589087528"
Received: from amlin-019-046.igk.intel.com (HELO localhost.igk.intel.com)
 ([10.102.19.46])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2022 05:27:09 -0700
From: "Palczewski, Mateusz" <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 15 Jun 2022 12:26:51 +0000
Message-Id: <20220615122651.26949-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Subject: [Intel-wired-lan] [PATCH net v1 0/3] iavf: Fix pending DMA
 allocations while released from device
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fix multiple issues that can arise, when VF cannot configure ASQ/ARQ properly.
Failing to do so can lead to driver hang, null ptr dereference and possible
DMA allocations leak.

Przemyslaw Patynowski (3):
  iavf: Fix reset error handling
  iavf: Fix NULL pointer dereference in iavf_get_link_ksettings
  iavf: Fix adminq error handling

 drivers/net/ethernet/intel/iavf/iavf_adminq.c  | 15 +++++++++++++--
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  6 ++++++
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 11 +++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
