Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1980BEB64D9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Jun 2023 12:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A50D41EF6;
	Thu, 15 Jun 2023 12:59:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A50D41EF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686833969;
	bh=L2FX0G0D3yu5KcB6h5CV4KGuFKI5nDXI8JqAFPZi9vY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=wSwvd4bx5BDiOtok8eqmZvUagdU6d7F3NGgr4XDxkuhk0L8LYEwxGq/tyyETFCP3r
	 ZnnpJU90jH4wt+pt18jOCjyHGN3ymb+mNd4OUhUfS8NcmtUmQvKQ9YjVTlSCIPzpZk
	 X61ORdPhoqghDGotWjh/9FdS+Qfo8jyVkFxN6ahqWmMyeVP0xSI5HkVCBNITOJjDJO
	 QU2QcyI4Pwg6xHH7/iNmT58G+XOdKISzJk/gzItIGkSDM8SJGQpi7hRUgfkhwxaCU3
	 NzTYQ3a1MTwVMefDItXv42+wItbkviTdaLuSQ4LDgg1xL6m6kOIXXQU8eqReiIlz/Y
	 yKElj7RsI9eXg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZQHt3mjKEx-n; Thu, 15 Jun 2023 12:59:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59F5641F8E;
	Thu, 15 Jun 2023 12:59:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59F5641F8E
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id DBA121BF275
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Jun 2023 12:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD93940515
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Jun 2023 12:59:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD93940515
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JBG506jwwFv8 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Jun 2023 12:59:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC3D2400D8
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC3D2400D8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Jun 2023 12:59:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424794811"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; d="scan'208";a="424794811"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 05:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825259716"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; d="scan'208";a="825259716"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 05:59:23 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 15 Jun 2023 14:38:26 +0200
Message-Id: <20230615123830.155927-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686833965; x=1718369965;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gcKU6ImbVvYc32brtTTMSGrZzt+11kXeKchcu8AjD5s=;
 b=ZfpSv7OJz0LP9J7ZJ2WVB8E2cnWMc/yznPm2/sJYzbUUNx5qUvNPzxjX
 AtxAT2etGMJ/lOkuH7/+qnDsYDg1mN2EJHhLgXABd6gZs0D/o+qTlM00j
 35pe5jtHmrh2Qqmt8WpM2j7Hix7LTQ8LSC7MfJgLyAWQnbCdhSLEhRfm4
 9itSiM21a7KA/RatiP7unmY2ld6TMHbbJ7a8gIdV5EVwQohg5hYtHiCXs
 CczrnOiLHqcqRLeq6frWE2bPLDBusFPrAhFZD8pH2If9Sx28tZPXNCaAq
 4cMZjnjXYhdqIR52AK4U7ifadM6a6XWWVw+Yv4vk7bC03/ebCGpx5UtF0
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZfpSv7OJ
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/4] change MSI-X vectors per
 VF
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
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

This patchset is implementing sysfs API introduced here [1].

It will allow user to assign different amount of MSI-X vectors to VF.
For example when there are VMs with different number of virtual cores.

Example:
1. Turn off autoprobe
echo 0 > /sys/bus/pci/devices/0000\:18\:00.0/sriov_drivers_autoprobe
2. Create VFs
echo 4 > /sys/bus/pci/devices/0000\:18\:00.0/sriov_numvfs
3. Configure MSI-X
echo 20 > /sys/class/pci_bus/0000\:18/device/0000\:18\:01.0/sriov_vf_msix_count

[1] https://lore.kernel.org/netdev/20210314124256.70253-1-leon@kernel.org/

Michal Swiatkowski (4):
  ice: implement num_msix field per VF
  ice: add bitmap to track VF MSI-X usage
  ice: set MSI-X vector count on VF
  ice: manage VFs MSI-X using resource tracking

 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 257 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  13 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   4 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
 7 files changed, 258 insertions(+), 24 deletions(-)

-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
