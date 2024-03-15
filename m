Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08151C54E58
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Mar 2024 11:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC1A4415E2;
	Fri, 15 Mar 2024 11:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KtfGqRRocfu0; Fri, 15 Mar 2024 11:03:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF735415F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710500635;
	bh=/c+bDUfYsIRvRTf6Ge76qPfm1RXLYdQZrDo3BJamEdc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=2f3YiOQGf0ttt/Blzj2SLVc4eJhPoPrVqWex65uein2Ax0BXVZd4K8Lzj/fdV3zzA
	 nACoQXbNgh4SZDM1ZEYsF2rK9bvPG5JVqZM0S52F9D4WYU6lBEVMr48M8QQ0LVeVun
	 kaUhZsevzfVNzte9Wnupt0O3byTsEAPbhpCNCZFa0n+VBGrKDPSLxpMFCoSfIrWPut
	 B+kfDGDewo0UNaAC2Kp5uzx3m6ORJcs9VLRHYbOcBIpcnnR6v7y/hgVcT4OodXhMwR
	 XXUZtfgEB+DpKteVqJhlOb+9pax/urCuPB+xpEUqY2FD3WO6Xs1NtoXb0Zh/EfmfUU
	 NRLa2OLul99lg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF735415F0;
	Fri, 15 Mar 2024 11:03:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 593741BF976
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Mar 2024 11:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 448C160E6B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Mar 2024 11:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tc3wTSM77wss for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Mar 2024 11:03:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8B03F60E5D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B03F60E5D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B03F60E5D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Mar 2024 11:03:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5549429"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5549429"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 04:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; d="scan'208";a="35761191"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com)
 ([10.102.20.192])
 by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 04:03:52 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 15 Mar 2024 12:08:19 +0100
Message-ID: <20240315110821.511321-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710500633; x=1742036633;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jp05zdaPBy8QblvcBCHmZid5S/vi2Z39kiYDd/YOpZk=;
 b=DkCCVh3lyb7PZKxqvCMiblvjTA8JdKEFKRRgAYBW5QiDZhoV4M9oSwCB
 NLQWqKNQynCVgaXx85MXdaehhBrWGJl1I64YDE5+oIsE6uMHQC65ByBBA
 J6UV9MXh5Ci7CuJZLgSj6n5WOyrW1sqAkSCs+in1moj0WIMLr7ZTRvdbt
 6gvBtsP8RiIn9mwht6G9Tk+xQ5k3CxMDB0shgk6OczD6t+c3i32AgMg32
 MTUgepunpT+eacGJhLA3s7nCLOeQ5ez5HluUS7YbWsx+dQfiy3zc6/pTB
 a6NQGMJqVi2GcXhDzp23q17EhUmnwSBh9KGvBo2tuhSgL+Gt8JIVbC7+z
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DkCCVh3l
Subject: [Intel-wired-lan] [iwl-net v1 0/2] ice: two fixes for tc code
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
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

Fix how ice driver is parsing tc filter. First is a fix to always add
match for src_vsi in case filter is added on VF. Second is removing the
flag check as it isn't needed and in some case can lead to a problem.

Michal Swiatkowski (2):
  ice: tc: check src_vsi in case of traffic from VF
  ice: tc: allow zero flags in parsing tc flower

 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.42.0

