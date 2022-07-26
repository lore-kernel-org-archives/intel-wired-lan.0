Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB9DC00144
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 Jul 2022 23:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8319540347;
	Tue, 26 Jul 2022 23:44:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8319540347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658879056;
	bh=oeAH7ZwYZHr6/uqtcbS441OkBIcx1jo5s6rIvd5RDh0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ax5gnNpegIr4TycBUG7cNCvKh9Nv0URSxCtw4cnR5sOSZsfml5qNiw0nmk/LnNL/N
	 ktcD5xqtMe5wKabuHlMmzZp00FjowD7aAFcg7Y5lyCrgmlPUBzEgM7CBi+X3piHyb4
	 a/E/1bNYXEcAWCXrBfm0y/jXfrXD5EvZsaeqCntS6VLRd+DsCbTizIgNgI2QRX9b7k
	 diLaEBCkSWEck1of/o5MfBoy/e9Hh1YJvdEkag87bgfcwGOgtAUGkN5qKYG5slBNOt
	 hSP1GVwyvE8GgoUdUCL+QLM+boLykjpzK0pjI5LIKr03+EYVzf1HSqNFO8bEyzYMb4
	 P/bpuaDc/gz/w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V_WlHrkOuoZB; Tue, 26 Jul 2022 23:44:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42AAC408DE;
	Tue, 26 Jul 2022 23:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42AAC408DE
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 642711BF2CF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Jul 2022 23:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31B3F4031D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Jul 2022 23:44:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31B3F4031D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K3bameeKdA0c for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 Jul 2022 23:44:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F167F40003
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F167F40003
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Jul 2022 23:44:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="313873675"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; d="scan'208";a="313873675"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2022 16:44:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; d="scan'208";a="689649885"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.7])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2022 16:44:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Tue, 26 Jul 2022 16:43:51 -0700
Message-Id: <20220726234357.50610-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.37.1.208.ge72d93e88cb2
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658879051; x=1690415051;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OhJyHnOKLqRqtcaq6taLGccXrTy8gu/zR0H4KVHBFuA=;
 b=QbnkVL204VY//1LzxWkTLHDZ4lIs9CsJ3TC1da8WZClguiIn2SD7sS8P
 Lqa2qSlnwYOHAySk/IGA/f4uxiMZEYXo3EEfDue1Z9ebgXtdNyt+1izPk
 r6OX1O/U7go7TIkPPv4FZya5PYb1cgufHiMmnImcBk3JCVAei0f9lYhS7
 PAF6xh9Ew34ooSkqf89FyrLvv/q4jeqdRSyfE7nZe8SkhN8GO7IhRmA62
 /HRpq41wuhSxDW2+JMNbV+yy/6BMyAuFya9lxPsSVu9gIaSENZldWwMMp
 NkdEJ0qnnac0HdbQiKD1+GfHaNKc8OFUkTmvCO+M0Om8BkbcMqH0GaRqa
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QbnkVL20
Subject: [Intel-wired-lan] [net-next 0/6] ice: detect and report PTP
 timestamp issues
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

This series fixes a few small issues with the cached PTP Hardware Clock
timestamp used for timestamp extension. It also introduces extra checks to
help detect issues with this logic, such as if the cached timestamp is not
updated within the 2 second window.

This introduces a few statistics similar to the ones already available in
other Intel drivers, including tx_hwtstamp_skipped and tx_hwtstamp_timeouts.

It is intended to aid in debugging issues we're seeing with some setups
which might be related to incorrect cached timestamp values.

Jacob Keller (6):
  ice: set tx_tstamps when creating new Tx rings via ethtool
  ice: initialize cached_phctime when creating Rx rings
  ice: track Tx timestamp stats similar to other Intel drivers
  ice: track and warn when PHC update is late
  ice: re-arrange some static functions in ice_ptp.c
  ice: introduce ice_ptp_reset_cached_phctime function

 drivers/net/ethernet/intel/ice/ice_ethtool.c |   7 +
 drivers/net/ethernet/intel/ice/ice_lib.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 751 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   9 +
 drivers/net/ethernet/intel/ice/ice_txrx.c    |   4 +-
 5 files changed, 435 insertions(+), 337 deletions(-)


base-commit: 5245eb4f3cf8ba1e9e0e6d58d810eceae9edc0c1
-- 
2.37.1.208.ge72d93e88cb2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
