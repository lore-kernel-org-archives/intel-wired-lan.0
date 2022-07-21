Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42580C433EF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Jul 2022 21:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB1CD41748;
	Thu, 21 Jul 2022 21:15:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB1CD41748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658438125;
	bh=NuQDDWOMqonGmZ/ZakkxNOS/Zb/ChUKXcbhWMkBu6FU=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=xsnv/LDOSonwUBMbhCcBJpwOhoKCByJh5pUzbRQH+aTe7kMAy626ySIpLXfaqWoK2
	 zalWymULiexUTrEjotDSEzXp/sXYOZSw4YZPGW856PE+E8vgii9+LgN5M6XPEO9ohD
	 0fLAVRkKBnh6OSLIvX8QGYsAUA/Jx0HP/PDO8Lq+NqDOZdZiHq4kgjrKFoK0+JlD7d
	 IbUI1MQa/nKpOtgYmgDETjM1z3dCDisYeL6CibkplNgQ2W5mpoZUNNC/UkYaozLgIH
	 O0eo0Xf1OhyiUe362MGTxoUaLgem7aRDaHLnDcU0dscerwx2TzTQMonX1/5gj80Apa
	 ePVKoTRpgwaqw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d0tR5q27zXRm; Thu, 21 Jul 2022 21:15:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 716EC41794;
	Thu, 21 Jul 2022 21:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 716EC41794
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id C40FB1BF375
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B22060BCD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B22060BCD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUePlJur1J2X for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Jul 2022 21:15:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB18B60B8C
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB18B60B8C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:15:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="348874458"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; d="scan'208";a="348874458"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 14:14:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; d="scan'208";a="925816174"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.7])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 14:14:58 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org
Date: Thu, 21 Jul 2022 14:14:45 -0700
Message-Id: <20220721211451.2475600-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.35.1.456.ga9c7032d4631
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658438120; x=1689974120;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=70dL+TKinMdON+cgvUm+mfjuUHW7dRrlqBQG6XkWacw=;
 b=dnlmyZ6I9HZB1Jew0do+lycikwnzBKSzmplZgrvs1vnvubKiVvyqPKfY
 QEyN1d6xXivrTxayXWgMewkBx73o/zyKtfp/q7HLE4cPVQbmrlEcn9V8y
 dLQAdar4FOHIVjhWFcOqcqfeHHLRgw+SXV+CJELAnF4LDZoE4++lyvNcA
 9gaI9Tkn5NYH2gwbvAryySx+VJW6p1fEjMY1xskwBu2PVQi/79Wh/w9KB
 0XK3nVmMRLYK+YfVUicGK4kZD7BX2TeYNIL5s5gYvcrbEpxemepTdkTLz
 I0fGvAt1frbrVGhkzjxws2Ah2lIrEtr4qpSF3I57ztGzVgYgRgXdixh2T
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dnlmyZ6I
Subject: [Intel-wired-lan] [net-next v2 0/2] devlink: implement dry run
 support for flash update
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
Cc: Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org,
 David Ahern <dsahern@kernel.org>, linux-doc@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is a re-send of the dry run support I submitted nearly a year ago at
https://lore.kernel.org/netdev/CO1PR11MB50898047B9C0FAA520505AFDD6B59@CO1PR11MB5089.namprd11.prod.outlook.com/

I had delayed sending this because of conflicting work in the ice driver at
the time, but then forgot about it and never got around to resubmitting it.

This adds a DEVLINK_ATTR_DRY_RUN which is used to indicate a request to
validate a potentially destructive operation without performing the actions
yet. In theory it could be used for other devlink operations in the future.

For flash update, it allows the user to validate a flash image, including
ensuring the driver for the device is willing to program it, without
actually committing an update yet.

There is an accompanying series for iproute2 which allows adding the dry-run
attribute. It does as Jakub suggested and checks the maximum attribute
before allowing the dry run in order to avoid accidentally performing a real
update on older kernels.

Changes since v1:
* Added maintainers to Cc (thanks for pointing out the script, Jiri!)
* Replaced bool in struct with u8 : 1
* Added kernel doc to devlink_flash_update_params
* Renamed PLDMFW parameter from dry_run to validate
* Reduced indentation in devlink.c by using nla_get_flag

Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-doc@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org

Jacob Keller (2):
  devlink: add dry run attribute to flash update
  ice: support dry run of a flash update to validate firmware file

 Documentation/driver-api/pldmfw/index.rst     | 10 ++++++++
 .../networking/devlink/devlink-flash.rst      | 23 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  3 ++-
 .../net/ethernet/intel/ice/ice_fw_update.c    | 14 +++++++----
 include/linux/pldmfw.h                        |  5 ++++
 include/net/devlink.h                         |  4 ++++
 include/uapi/linux/devlink.h                  |  8 +++++++
 lib/pldmfw/pldmfw.c                           | 12 ++++++++++
 net/core/devlink.c                            | 17 +++++++++++++-
 9 files changed, 90 insertions(+), 6 deletions(-)


base-commit: 5588d628027092e66195097bdf6835ddf64418b3
-- 
2.35.1.456.ga9c7032d4631

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
