Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A88CC43334
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 Jul 2022 13:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20D246005E;
	Mon,  4 Jul 2022 13:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20D246005E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656940373;
	bh=OaG6/33qtBkLQpY1MNy8+eMWULvZ2K1XLy92pubf4HM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Ekwt/yBF6XfdxnwFtdcS0mDQumYB7ZRqOFnvUSEdMkyDK2/6CyJ937FQoSfvYcnCf
	 2rsWxbCZpXIWsfAjoTF+22Nz0K9kIY3LdreX+xusq32GtewOFxNmRiCvpFzdoZUjDM
	 TBBBDJWEm3TQPRCcOjQyi3EzVLBOXOFPFXlCtOzCo9hAtRRebpd5qoZaCGq36Ig5Pv
	 kNgdc51b63cYXWinOHlUB0RA9JTKy28hAWRl80RktclKiMS6CuNav6ouSuHSG3Er5F
	 0/Es+omnqTf6H1NL/BJJm6Bgp3nSd/a9zHIXxAPZZEcCIjDxwhiDbawyfyDAGPVDrZ
	 0RNPgcESjo7tQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HW4txWVzpaHL; Mon,  4 Jul 2022 13:12:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2874060A81;
	Mon,  4 Jul 2022 13:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2874060A81
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9E00F1BF35F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 13:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 735E3405D3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 13:12:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 735E3405D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmKrRobePcaC for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 Jul 2022 13:12:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 739FA405AD
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 739FA405AD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 13:12:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="369451432"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; d="scan'208";a="369451432"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2022 06:12:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; d="scan'208";a="542586261"
Received: from moradin.igk.intel.com ([10.123.220.12])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2022 06:12:43 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  4 Jul 2022 15:12:25 +0200
Message-Id: <20220704131227.2966160-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656940365; x=1688476365;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZbdIxcqeT6LO9zM00tqQV+PEwDJsxvVilw2MdtcHc5A=;
 b=mLiUho7TTQIxfaMKoVwV5VtiprbRFwDJ398MDElcbtwid3OieKh455hD
 a4wBBSvv1kuXcwi0ytDmLy2fEeaBHd6auajGQyXM+XX7yidnk8o3GvkJA
 22HVP/Y6Tc6+qS7yfQC2p1U1yiXzMj+Z+SW6buPEhWyu6u1Og4qNsJdVP
 B+iGLObR5p017oB73nqKBnbhR37iu5vdVLoYF2tI0IR9yRd5ayHAkmgmT
 2ocKhG31B3J2LI8zZi8QvZNQTub8wGHIWPF9bhCvBqqPjyhczq0KO+tQ/
 CSOZMECXHALCCyQI/8CXVNOrseHpAPpsbpARpNTQP9Te5LKZ8BBUQ74Za
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mLiUho7T
Subject: [Intel-wired-lan] [PATCH net v3 0/2] Improvements for default VSI
 filter handling
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
Cc: Michal Wilczynski <michal.wilczynski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Currently when vf-true-promisc-support private flag is set to false, default VSI
switch filter is used instead of a proper promiscuous one. Unfortunately flow for
default VSI is a bit different, which leads to improper behavior like not being
able to enable promisc mode on multiple VF's, or filter not being removed in
'trust off' flow.

v3:
- Rebased, added fixes tags
v2:
- Changed net-next to net, since this can be treated as a bug fixes
Michal Wilczynski (2):
  ice: Introduce enabling promiscuous mode on multiple VF's
v2:
- Removed unnecessary parameter in function description
- Removed unnecessary comments
- Moved ice_vsi_uses_fltr function
- Removed unnecessary blank lines
- Changed commit message to utilize full 75 characters

  ice: Fix promiscuous mode not turning off

 drivers/net/ethernet/intel/ice/ice.h          |   2 -
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  67 ++++-----
 drivers/net/ethernet/intel/ice/ice_lib.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  14 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 135 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_switch.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  89 +++++++++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   7 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  51 +++----
 12 files changed, 216 insertions(+), 178 deletions(-)

-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
