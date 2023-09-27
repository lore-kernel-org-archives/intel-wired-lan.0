Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21407E810AD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Sep 2023 09:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DBD641FEF;
	Wed, 27 Sep 2023 09:27:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DBD641FEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695806846;
	bh=m8fCI69k0dUsSqYcVun9EDn2P64ETp87kA/MGOEWNes=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Ah3wDNpkBrltWkTtNyCuBASJbp32MU/SXM0c24Koc9QuheMinAjhMOlC3qqVNrt8X
	 Nar3XssTQ2YLwlgR1Zl3FRmDGHL86iEPnP80JPZAVNyF3dC2uEDHL1E6JgKQoO56CX
	 tRntMbbzeDeo0hrBNDUo+o88T+3sm4lE9FzNh07H4ofoXR5Kq2ZSNrBkyW395rUFE5
	 rA0BESZgBDYGRavWVsP27+xmeXsF1enx+RgWJL0EuHecjlaceK2nCI/WtKwHMvdp4s
	 V9ZWlY9lgxPuOHwnag+YjCRIjJUWRubBrSMKhAWvFtGSy1dKwXRDtj7Y308V9zKS75
	 dPaGuGuteTGUQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ktcndjaO_FYq; Wed, 27 Sep 2023 09:27:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CAF041FB4;
	Wed, 27 Sep 2023 09:27:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CAF041FB4
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 3B1021BF335
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 09:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ED0082733
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 09:27:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0ED0082733
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XAKGajmeYsrz for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Sep 2023 09:27:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40803826EA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 09:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40803826EA
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412692316"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="412692316"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 02:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778479224"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="778479224"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
 by orsmga008.jf.intel.com with ESMTP; 27 Sep 2023 02:27:10 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Date: Wed, 27 Sep 2023 11:24:31 +0200
Message-Id: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695806843; x=1727342843;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5YlCDla9H8pAw0C4B5gYO+TrDwc7pWqE1EPlo/uCT1A=;
 b=gP0tER58Na5ZdLi1biHycEYadU1VZhisfVeP3AsEwJbJOt0mz2yavi1M
 CgaBpG+fbCjFS8IVxskWAi1rpKdcX3k22UWF+qecUPFQZQDMBxuZdsWAz
 vp7lyy7vkf8kqNyCGWWmn/ouuWXzW3tBv3TxgekZwWSvkiFrVE3jdHeER
 YDMN/ksP/X5DlhXunLAB9QRgkkunHlw0jLgh/C8FAlHDhFgPESzaY0B1D
 9VXyu4VB1ay6kXXPJ2i0GorRf1v2Q8JXPVyOw3NEqom+bbst/PT3ELpP9
 I9oFAJ1bOrCAb5Od8dcNWQ6szLsCkfYvuVlAzJhLIqbbV3dQlKG+LyeUj
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gP0tER58
Subject: [Intel-wired-lan] [PATCH net-next 0/4] dpll: add phase-offset and
 phase-adjust
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
Cc: jiri@resnulli.us, corbet@lwn.net, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 anthony.l.nguyen@intel.com, kuba@kernel.org, vadim.fedorenko@linux.dev,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Improve monitoring and control over dpll devices.
Allow user to receive measurement of phase difference between signals on
pin and dpll (phase-offset).
Allow user to receive and control adjustable value of pin's signal
phase (phase-adjust).

Arkadiusz Kubalewski (4):
  dpll: docs: add support for pin signal phase offset/adjust
  dpll: spec: add support for pin-dpll signal phase offset/adjust
  dpll: netlink/core: add support for pin-dpll signal phase
    offset/adjust
  ice: dpll: implement phase related callbacks

 Documentation/driver-api/dpll.rst         |  53 ++++-
 Documentation/netlink/specs/dpll.yaml     |  33 +++-
 drivers/dpll/dpll_netlink.c               |  99 +++++++++-
 drivers/dpll/dpll_nl.c                    |   8 +-
 drivers/dpll/dpll_nl.h                    |   2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c | 224 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
 include/linux/dpll.h                      |  18 ++
 include/uapi/linux/dpll.h                 |   8 +-
 9 files changed, 443 insertions(+), 12 deletions(-)

-- 
2.38.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
