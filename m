Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BA1C25B0C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 11 Aug 2022 18:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C2E840593;
	Thu, 11 Aug 2022 18:22:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C2E840593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660242122;
	bh=Ojto5KPVNkmVPd0BdeglqfPIwhpC7YLN5UbdasLzKZc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Mgu/zRV+EbA/DqjcGjeJr889sMeO0M4am4MvSdO37P5s3wS74VwNUj4u1hi8O+Vv0
	 WZfhfeUmQ/FCvKaEscyRk9+KK2pKJrvC/e1rjTcphEs1rVb4nlDzgadGtvpVAJtRFb
	 gV4e83OdwozkoY3h1z80p3baRw+3Kq7AD0iecGko8/3yMUcFAy2QqfJf6ePViMnNFN
	 SJMRQJcF1nrP1vjp2RfvDc3x0TnGxg4nl3V/0s0AjQc6J/UQX7AKG1BskBdDzv3wI/
	 tkLDg+8CV0590A8QCWFZ91/cMGcsvx31x2l4HCEQNHV2fgF+PjDAIGjOimtTj36XeV
	 AsowfItFj3IMA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OsGDY_CRWYdc; Thu, 11 Aug 2022 18:22:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1818C40B6A;
	Thu, 11 Aug 2022 18:22:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1818C40B6A
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7F3521BF3EE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Aug 2022 18:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65CB840B6A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Aug 2022 18:21:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65CB840B6A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iNz5pPj6fRHN for <intel-wired-lan@lists.osuosl.org>;
 Thu, 11 Aug 2022 18:21:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CB9B40593
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CB9B40593
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Aug 2022 18:21:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292689569"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; d="scan'208";a="292689569"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2022 11:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; d="scan'208";a="933426138"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2022 11:21:56 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 11 Aug 2022 20:21:47 +0200
Message-Id: <20220811182149.145358-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660242118; x=1691778118;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wNGtd33mNlaPsi6uTyYY9xYtLMfRyQAIvuGLR+bepOY=;
 b=bvfivHjaN1/Gp+Ug72jQZ4rwtlzgY7m/fJMnp7VnTlGEuuLeW4slkBQJ
 ccCI529jcsQK8qKeZLwNoJIbKVqZTWRoi/pc+qim4xLj7JTsHtJnlSj8/
 inIm6E4rEt8RqvMks9T/5e5inJuCngz8dgYYC2Ewm4rSD03NPh/UJoIt0
 pi2bpoIsBe9q4PzA+/Iy8V6mjFW1sEaSY7yjUVEjhtH3tFxlgmeb078Lo
 TXumkP8LOuFZaYMeT0Cc1px753Rr6NLS2cfJ8QNRMPhdUN6km/kGB7c+/
 lOGzTA3pjw1se08Z5y+ndkHjY0nPtaNzM4ZqIbcvhI3mBSAVqlAVwxw8p
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bvfivHja
Subject: [Intel-wired-lan] [PATCH intel-net 0/2] ice: xsk: reduced queue
 count fixes
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
Cc: alasdair.mcwilliam@outlook.com, xdp-newbies@vger.kernel.org,
 magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

this small series is supposed to fix the issues around AF_XDP usage with
reduced queue count on interface. Due to the XDP rings setup, some
configurations can result in sockets not seeing traffic flowing. More
about this in description of patch 2.

Thanks!
Maciej

Maciej Fijalkowski (2):
  ice: xsk: prohibit usage of non-balanced queue id
  ice: xsk: use Rx ring's XDP ring when picking NAPI context

 drivers/net/ethernet/intel/ice/ice.h      | 36 +++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_lib.c  |  4 +--
 drivers/net/ethernet/intel/ice/ice_main.c | 25 +++++++++++-----
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 18 ++++++++----
 4 files changed, 54 insertions(+), 29 deletions(-)

-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
