Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529B3C6FA8F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Aug 2023 21:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00F8740127;
	Wed, 30 Aug 2023 21:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00F8740127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1693432115;
	bh=2geAN+qKC+kpHdcyqkgHrDPAZFbHCsBfttQURgw0Zn0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CXQDwfVtfa0/wL+FFWaoGDiDK437Abpf9sVtZU8RxtcxRpZO6kjJQc8PYyo1g1yHv
	 jhGDEuHwWgE9v0eJ0ok11moDaa8+p6+PtIlz3aOznwA2jl51xmXgoCMc0ri0gHojCp
	 2oS+nDZgj/3Yulp9n5+7QeLrWfX5CKz8iwTYzSUT5KplYDbW+ZirBlOiFfCHo496B/
	 NvwEUTkm3I6bW9/grMd3mNMqkWq1Ebw+9c3vZ7ZNpbtatD3Ia3BWvAYVHyNPM0WqN1
	 UwfGauhWHkV0L1mZEuuiHdR+fuqiH4p0XDayq7GW9SkgD/YX6nnuwrbe0xfK0/Mqbp
	 VH5QgveonO9uA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cf866pTzqhQ8; Wed, 30 Aug 2023 21:48:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id F0E10417F8;
	Wed, 30 Aug 2023 21:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0E10417F8
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 7DB081BF405
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Aug 2023 21:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62BD86060A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Aug 2023 21:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62BD86060A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IwA2JFCERPe3 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Aug 2023 21:48:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91FBF60595
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Aug 2023 21:48:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91FBF60595
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="365958644"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; d="scan'208";a="365958644"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 14:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716072878"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; d="scan'208";a="716072878"
Received: from akervine-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com)
 ([10.249.42.39])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 14:48:29 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 30 Aug 2023 15:48:17 -0600
Message-Id: <20230830214821.3439959-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693432111; x=1724968111;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OitTqVofEbGPGaA2+8TsSqjw2wgORVZ97088BehUcPA=;
 b=iat9x1a1WYNkRi4AIGjCoT6ncgGkQff+C++RSyeBAMJH8TSmBtFUrJCv
 +NRdxx60ZlVMwcAx/qZFX76t/Ts38+hOWlirtm3nmVwv8T3l+pIq5XLWG
 sHfGPnCqCavJWlcC62gwedZ/UZskybquDxGtr4cBHcs37wgsQ6hh9rrKk
 +XJcD2bfJnGyGbgneYiaNslQsJEr3ibH+8kESL9mf15PCVn1OLY2IyTHW
 PPK5qMudyRzlOU5ivRRn820PuaGmwbWwRlCkifIEcG2/jxJghL0YueP0v
 X9bEhHSyZT1DIWoD8IXTaChtr07ZlGSIoqzXajeUYWdItlZzxQK/BRYBo
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iat9x1a1
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/4] Support rx-fcs on/off for
 VFs
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

Allow the user to turn on/off the CRC/FCS stripping through ethtool. We
first add the CRC offload capability in the virtchannel, then the feature
is enabled in ice and iavf drivers.

We make sure that the netdev features are fixed such that CRC stripping
cannot be disabled if VLAN rx offload (VLAN strip) is enabled. Also, VLAN
stripping cannot be enabled unless CRC stripping is ON.
---
v2: Move patch "ice: Fix VLAN and CRC strip co-existence" from 4/4 to 3/4
    Other minor fixes from Tony for the same patch

Haiyue Wang (2):
  ice: Support FCS/CRC strip disable for VF
  ice: Fix VLAN and CRC strip co-existence

Norbert Zulinski (1):
  iavf: Add ability to turn off CRC stripping for VF

Paul M Stillwell Jr (1):
  virtchnl: Add CRC stripping capability

 drivers/net/ethernet/intel/iavf/iavf.h        |  2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 59 ++++++++++++++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  4 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 66 +++++++++++++++++--
 include/linux/avf/virtchnl.h                  | 11 +++-
 6 files changed, 138 insertions(+), 7 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
