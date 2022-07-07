Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D2CC43334
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Jul 2022 10:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3471A40B07;
	Thu,  7 Jul 2022 10:17:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3471A40B07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657189021;
	bh=1fGyW8ld3r18EVLVMkKuVzF04XUJK6JxuKznbfjqk+Y=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=DHhnO2HE/bjxeltKee1MnFwZ4i2whCrpLHtazsC0LJ6clYmVOEE68A6fneE8MGWMe
	 0/AYplYR6RbrMUi2wZcl7yh2XTuFG3NkwEySuMJRkMpfaysjPQg40gMMdbUiQ1dFXb
	 YW2849ZRLoJASApit3DLg0realuUF8MPi4R78lQJc5wFfHfP2MLybKTWOuYVRvOnxb
	 c+eiudWX8xEgpCwEyQDUPyCsdyD4O2OEX+uRRuWkS+1K3FMNNxBU1V6YhbmMQGE7TN
	 hgm6G092aYuEdJKyWlmto8zy3eItziVTBrp7qnX7DE93YKHzUsGf8DvHP1b5endzFP
	 58oKdN4izfWpw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CccPxLJS1nvk; Thu,  7 Jul 2022 10:17:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A6B840B28;
	Thu,  7 Jul 2022 10:17:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A6B840B28
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D9BA51BF86C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 10:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B255540B07
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 10:16:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B255540B07
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F3AQ07vOH7V4 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 Jul 2022 10:16:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5F10400DD
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5F10400DD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Jul 2022 10:16:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284729221"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; d="scan'208";a="284729221"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 03:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; d="scan'208";a="651077054"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2022 03:16:54 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  7 Jul 2022 12:16:49 +0200
Message-Id: <20220707101651.48738-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657189017; x=1688725017;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JhSwozAgKYlJy+X03EQEM0YoYTa8MOfoBs+82qEK3q4=;
 b=gVG1GYeH/z8ghNRiQdR6Sb8+tvZU9UcilGKzfQdk+qzgil7MEt0YsbT8
 VvEgnKSXJhoV4i1a+aHPffe+wzOYFx5+gEHIquSpVtR8DMTmkLmvpbj+z
 7VNOHDQ5DtmZiiO5qTFTBCpcbdkuzmeUK//kB0JQuu3gMlDgIJ08zR9B1
 +QAMrLlS/dv0finsVtS8jQQVgmNouBIwMTAs1vCFI3CQqDkiKTxHr569V
 fsiYBQhCPENDcftB3IlyfmiVJFSd+IwqrfTIQF4KYaA7LzIzCOQ7avr/w
 wA605WJVHI/nc7Vn6vEIrl557i7WcCz/cG0ZFyTB0/rJKwpNy/JhCDdxy
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gVG1GYeH
Subject: [Intel-wired-lan] [PATCH intel-next 0/2] ice: add NETIF_F_LOOPBACK
 support
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
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com,
 anatolii.gerasymenko@intel.com, kuba@kernel.org, davem@davemloft.net,
 magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

these two patches are pulled out of the set
https://lore.kernel.org/bpf/20220616180609.905015-1-maciej.fijalkowski@intel.com/

they are about adding support for loopback toggle and they were written
for AF_XDP ZC testing purposes but they are good on their own and since
I need to rework ice ZC support a bit, let us route them via IWL
instead.

By the time I am done with refactor I believe there is a high chance
that these will land in net-next.

Thanks!
Maciej

Maciej Fijalkowski (2):
  ice: compress branches in ice_set_features()
  ice: allow toggling loopback mode via ndo_set_features callback

 drivers/net/ethernet/intel/ice/ice_main.c | 73 ++++++++++++++++-------
 1 file changed, 51 insertions(+), 22 deletions(-)

-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
