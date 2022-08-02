Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06520C00140
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Aug 2022 10:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88CC5605B3;
	Tue,  2 Aug 2022 10:28:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88CC5605B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659436129;
	bh=9pXI4HbN9dmPVEKBbqmzpyTqV/hM7xe/J8zDELxFh+w=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=14yShypG/B6gvnoVIzOK+W0xvyzFai0gEntpRDHGttAPAE9WxQ92m6Ug+e5BRdoS9
	 pi6/HLhE5eORM3c+rz8DwBwU6KlDCBiz1iqcY3FGdP9vW0PutLFO0F0s3FXQYIHlFJ
	 D+a5q8mJe9RrUgggCNgzPBs6p+t2/hvUSvl5o04gpd4gkJgdRXYUNapThNEAnzG6Lv
	 GDcYq9tC36+yMq2jnQaH1wCnlR9rJEwiqhTQgwId8blkgJ6f2LsCV46yt3lUopNgbL
	 m7P+MLpA7JCZ3u6W/KMBVPlUPic5S9eftQXvQmyyFanpb+pEZ+4i4jeJRWMdNfnIce
	 jl8sFoknOPJTg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6aHwCYdeeo00; Tue,  2 Aug 2022 10:28:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A35760AFD;
	Tue,  2 Aug 2022 10:28:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A35760AFD
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D28E41BF5DB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 10:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A685F402C5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 10:28:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A685F402C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMU3xsZ0bzEP for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Aug 2022 10:28:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B970402C2
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B970402C2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 10:28:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290589525"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; d="scan'208";a="290589525"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2022 03:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; d="scan'208";a="635244135"
Received: from propan.igk.intel.com ([10.211.8.82])
 by orsmga001.jf.intel.com with ESMTP; 02 Aug 2022 03:28:45 -0700
From: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  2 Aug 2022 12:26:15 +0200
Message-Id: <20220802102618.31303-1-anatolii.gerasymenko@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659436126; x=1690972126;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=F8REI7Ci4/eEDXHtP/leKe+AkOkkghHLP84sO8fXodo=;
 b=fop++LULw+dbwWGjipg1SmQ2ABkAdv49pcP0XEprOP2VsPb/WR/x6A5m
 slShuDnd5P5UeCGqkpR1U+citnVTFZvyC04BP3gzyKw7mBPEI0MQzMMhV
 Gqu/mu087diN0p0nIycF25EXR7KgHnHaRQ9/dzsBDYcdJLchmKntAnCsK
 b94YX97JGLhncXXB9938pqhXYyMaZsauaZACFmCqC4S0bS9PQVB3JfWWn
 3aSsiy2e6l+pfP4ZBzs+BJXxPf8SI97b35K2IW/u8I9a2QLrMRyG9ji56
 TYPgRjVc1rwx3t2UozqNzwPm9bv5s8HSSRDlNOPwwsUKLK62g9dtWEr/s
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fop++LUL
Subject: [Intel-wired-lan] [PATCH net-next v2 0/3] ice: Implement LLDP MIB
 Pending change
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
Cc: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

If the RDMA traffic class is removed, then our Control QP (RDMA Admin QP)
may not receive completions and would hang RDMA processing. Which would
translate into requests for reset on the card after receiving such
changes from the switch.

To solve above problem FW will no longer remove TC nodes for the
applicable TC instead allowing RDMA to destroy QP markers. After RDMA
finish outstanding operations notification needs to be sent to FW to
finish DCB configuration change.

Anatolii Gerasymenko (2):
  ice: Get DCBX config from LLDP MIB change event
  ice: Handle LLDP MIB Pending change
v2: Remove inline hint for ice_dcb_is_mib_change_pending()

Tsotne Chakhvadze (1):
  ice: Add 'Execute Pending LLDP MIB' Admin Queue command

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 18 ++++++-
 drivers/net/ethernet/intel/ice/ice_common.c   | 13 +++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_dcb.c      | 39 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dcb.h      |  2 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 53 +++++++++++--------
 6 files changed, 101 insertions(+), 25 deletions(-)

-- 
2.37.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
