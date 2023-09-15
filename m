Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2119AEED600
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Sep 2023 14:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D2AC40207;
	Fri, 15 Sep 2023 14:58:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D2AC40207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694789891;
	bh=1db4ak7ELPwQU22pgBCd4N+f6QFkO7FZWNg9FLa6l3I=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=hGcZWr2pkPCurtTsQGkqM25Ol6YUZoCUD9d+NY2nrbHgWvWXO6alUGyRGd+5EMBZ0
	 Ap6q981lY6e6eLv9IEHBHeCs877pv0KC5VyCDXEseG8UVdPh7kt2AR02XaQBgzTjY9
	 7yaMKd/Ooyu5i+iQJvsU98rag+QimtOkb244XipYONQ8mgmcLtzWeM/JLU4fOLXiyN
	 WcLZMuOYHLTxreQfSjzAHpEnddkQj4hHFIpGUNeiqRhuTv2cQh4Aqj6ipynXd4YJn6
	 r44cx4KrzersUX0gzLbl/Z2VEca/HFB89cKaKmTX6AyXgHZSDGR5QhuLWcC0ww7GhI
	 bRJ8DQvUX0IBQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z3Wu1YuhgU6r; Fri, 15 Sep 2023 14:58:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85611404FF;
	Fri, 15 Sep 2023 14:58:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85611404FF
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6779E1BF20B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 14:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F6CB40207
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 14:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F6CB40207
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yXBiWJ_F-_tW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Sep 2023 14:58:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BB04404FF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 14:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BB04404FF
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="445723947"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; d="scan'208";a="445723947"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 07:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810548649"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; d="scan'208";a="810548649"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga008.fm.intel.com with ESMTP; 15 Sep 2023 07:58:00 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 8980B333F9;
 Fri, 15 Sep 2023 15:57:59 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 15 Sep 2023 16:55:20 +0200
Message-Id: <20230915145522.586365-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694789885; x=1726325885;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IFoeJfee1c5/WFl5XI80VGzxax2tOzfaCmPP7RDjNMo=;
 b=lO6QouaiYjDrbHqlPlyjcQgzu1Bj7sItn5vnY1BbGhwvSBGyCPtyMjCg
 m5lGLRUQUTicB4n10wcYPsSNL8VUUYSvZ0Dh4jN/ToBjovH9KvaAun/+p
 AikS79PRYOh515qFec6NFnZ/PbdsT3MibCa7sATTu05pJdNquDyBpgZY0
 j8QZpBNIwfSXz+jNVgYA9INh2Dkek2DkDBhFZ5Wgjpy7d78WG4/UjhYqI
 OiRQBzcikHZsGcu0nfo78I2A5Qzk3NKMQzsUVB+mI2Th5Yi5MTAo4CX/z
 1SixVJvOR0Ci9nhW8WcpweXbN0nObbro93ht8/60zgzaTXiXvbh4Wa6DK
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lO6Qouai
Subject: [Intel-wired-lan] [PATCH iwl-next 0/2] ethtool: Add link mode maps
 for forced speeds
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
Cc: Pawel Chmielewski <pawel.chmielewski@intel.com>, netdev@vger.kernel.org,
 aelior@marvell.com, manishc@marvell.com, andrew@lunn.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The following patch set was initially a part of [1]. As the purpose of
the original series was to add the support of the new hardware to the
intel ice driver, the refactoring of advertised link modes mapping was
extracted to a new set.
The patch set adds a common mechanism for mapping Ethtool forced speeds
with Ethtool supported link modes, which can be used in drivers code.

[1] https://lore.kernel.org/netdev/20230823180633.2450617-1-pawel.chmielewski@intel.com


Paul Greenwalt (1):
  ethtool: Add forced speed to supported link modes maps

Pawel Chmielewski (1):
  ice: Refactor finding advertised link speed

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 201 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  24 +--
 include/linux/ethtool.h                       |  20 ++
 net/ethtool/ioctl.c                           |  15 ++
 6 files changed, 178 insertions(+), 85 deletions(-)

-- 
2.37.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
