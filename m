Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72FAE92FC0
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Oct 2023 21:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2138B610BE;
	Thu,  5 Oct 2023 21:46:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2138B610BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696542398;
	bh=+YjjIJ7yY5g3voePcj4vQ8E60tV9GzE/lp3pGL5u/SA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=4AIxhQgbt5BjngqK34Qo01J4APtnhcFrxQwwY82MGVg2dbz1yMD3n3cASXqB/ySeO
	 L2cf5WVcMPGAfTK5pjgk+gqLxtbbCM6EPGKu94JNl2GkViPKLxueGuhm5cNq0WvkVw
	 uW1F76yGFWxDKcDLQwZdKXQ82i/A5YDPRwcamehfCJoWRxoxMQ3mNEETMDdAIXIW6B
	 tBZUH6136PKp9Aq++73z+2pkxInjL4wisBjRFGoU2e9xtT7m3Cn3kbPMWOEGZBggcT
	 0Nu7+4kyYGXXHkMghlFSVtlKYdLC4dY6sQrdhsiymEoksKGLOugcMsDYVBvo7dPYcY
	 8/J/C2qGD1i1g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UkCWlfpY_XDA; Thu,  5 Oct 2023 21:46:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8A7B611D2;
	Thu,  5 Oct 2023 21:46:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8A7B611D2
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 534131BF5A8
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Oct 2023 21:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2687242C21
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Oct 2023 21:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2687242C21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4oxuAGf0fUiu for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Oct 2023 21:46:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E4E341DE9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Oct 2023 21:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E4E341DE9
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="373977679"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; d="scan'208";a="373977679"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2023 14:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="822271019"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; d="scan'208";a="822271019"
Received: from tsicinsk-mobl.ger.corp.intel.com (HELO azaki-desk1.intel.com)
 ([10.249.35.190])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2023 14:46:21 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Date: Thu,  5 Oct 2023 15:46:01 -0600
Message-Id: <20231005214607.3178614-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696542392; x=1728078392;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O9gVJq8pRjhkuugdq7kz+kmA4VDD5HLqbMMbl0uWA80=;
 b=M/HSj38+vqVZAa7CFQf7tEj4YmcvfarbS8XQV+Ol9vFceNhfKGmuTI7W
 WZCxwiecRT8VVYONlew3tHY5oEVC2CVCaZsp34rmioBchVDgiSBMpW8xg
 Im0ETyxWcpgvDN0Uc4hsXKaryOiE7j0JKD4FqW9kqtinT9deVLpEii5Wt
 4oHMcgrtaB1Q1Wuumodr5M8Yl+iTKdyJ1tSEMNuBDeqqqEwKNaTeGzi23
 Jie9PL45+tdK/GEhpt2qyEVRDoUtS1OCp6pXo+IthWsrk20Px6j9sZW6U
 +XEob0e6uZi3GFgznmNrtGpHVMNZN0L4tBtVeww+p1huqwd/ddHZ454Q6
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=M/HSj38+
Subject: [Intel-wired-lan] [PATCH net-next 0/6] Support symmetric RSS
 (Toeplitz) hash
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
Cc: intel-wired-lan@lists.osuosl.org, Ahmed Zaki <ahmed.zaki@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Patch 1 adds the support at the Kernel level, allowing the user to set a
symmetric RSS hash for any flow type via:

    # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric

Support for the new "symmetric" flag will be later sent to the "ethtool" 
user-space tool.

Patch 2 fixes a long standing bug with the register values. The bug has
been benign for now since only symmetric Toeplitz hash (Zero) has been
used.

Patches 3 and 4 lay some groundwork refactoring. While the first is
mainly cosmetic, the second is needed since there is no more room in the
previous 64-bit RSS profile ID for the symmetric attribute introduced in 
the next patch.

Finally, patches 5 and 6 add the symmetric Toeplitz support for the ice 
(E800 PFs) and the iAVF drivers.

Ahmed Zaki (4):
  net: ethtool: allow symmetric RSS hash for any flow type
  ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values
  ice: refactor the FD and RSS flow ID generation
  iavf: enable symmetric RSS Toeplitz hash

Jeff Guo (1):
  ice: enable symmetric RSS Toeplitz hash for any flow type

Qi Zhang (1):
  ice: refactor RSS configuration

 Documentation/networking/scaling.rst          |   6 +
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |   8 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  22 +-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   8 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  14 +-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  35 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  43 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |   4 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |   7 +
 drivers/net/ethernet/intel/ice/ice_flow.c     | 439 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_flow.h     |  46 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 117 ++---
 drivers/net/ethernet/intel/ice/ice_main.c     |  49 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  55 ++-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  35 +-
 include/linux/avf/virtchnl.h                  |  16 +-
 include/uapi/linux/ethtool.h                  |   1 +
 net/ethtool/ioctl.c                           |  11 +
 23 files changed, 629 insertions(+), 298 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
