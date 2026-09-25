Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64D1C9832A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 22:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CC5C81318;
	Fri, 25 Sep 2026 22:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5f0vsz65-PAU; Fri, 25 Sep 2026 22:34:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8217F812E8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790375652;
	b=GIj/puhTEimjS0EFhZVGv2QehsbDWBpCuLC5AtI/3UFefVFUYw5GplAQ0qZt4CxYnM0C
	 wiEpHTNq2P7vsalOvZfP675VSQScjds1THJaAPhvqVVUmsz84/LlmiCUbCM+Fzb2YDYfF
	 Crnq9dJp49MoAj5vPX4/5xVjbmGnwCHteY6xqcq/XDaEI+lXLa8hkg7vl47NGUGw4izTl
	 i79YSj01ZZHJlecfOYEzFm7Ld7/omzqlEDP6mQgnPQF8MDllKIdp3S6aWwb1mip6EI16D
	 iTIL5LWmQfSw2aygCano6RZDe7laTNDW6ZPJ0JS+l1YhsNa9G+mHoeWsxpCXbPCvQtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790375652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N1ccGQ9ELx+Jvjlm/x3OnwaYs4lKtfFX+oJHb7au2Dg=;
	b=NHGdPcF9U3FQ8j6iOn6zQlP6g7X6yhaADAL/vIpyutPc+raoiUi7bvz8VQCPDXjm0RhD
	 SWEmfdfb/fgXC89P/kZYyi9hPwhxOuCSW2RieRlq1zRnIrMq5jK+Vau26VAdufxSbZe9T
	 wfjE/XgoX8/0qA7nuz2r5BU6nEIfdVH/OJaqu5bfSOLO7peM7kM8pX6D6HJOGFTTqH29i
	 SzU7XEyUepir5t7dgFpFyGmHncq3JBD6H2Ha55R1NBSOn7SZB30HA6d6sDyH7Q1iw456s
	 4N8vABQifbTpSkUwSaydk3IUR/KYEcJjCHDa0NwTsMABPA+nqF9oD/zZUaEFFMXVADg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790375652;
	bh=N1ccGQ9ELx+Jvjlm/x3OnwaYs4lKtfFX+oJHb7au2Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fW2ITtrelREK7ssuAnOpkTDBbAB5xfPSHdA5hnrJUZw6BjKHdohLat9WTBMQXDZ2C
	 duGl89REKoyEWa0vHn/2CSqDxc+p9ULhDHsReMjQMnvDX6nLDs1VWHGQFnly0os6Uc
	 oIGqBu05y765a8WSmuH2pzh9l025ycwezCWS3k97OQ1NMmImaNema8hU8bwmIHN9Ec
	 +itu6J0CBhRJi01Q4mUhqxnoLxgRxuzF11MdYN0ACvR7qKCK3ejush+UiMgjS8rV2a
	 ym23azIubDVuxqtPiBGbJG/8UXz0SVp560OoGa2gw48kt7OW1EW2TeKjepJ9P46Zvm
	 W39nRVZa3tivQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8217F812E8;
	Fri, 25 Sep 2026 22:34:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 19119335
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0AE2640A9A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9qRpSv8A2Yp for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 22:34:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3EFB640A82
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790375650;
 b=akwg0GUV014rdGVt9/8/C+zFqg0ZzbUi3ElGTj5ZRZHhRhvFgmg23maJAXqTT61u+muD
 zIr+FpeU8fSRA5aKim+nijV8HXoiDoCuxc3DmmORI69ghzI1LDTOY6Aiu/E4jC6zGwuKV
 0yPbEvVAN5+ibHd5h70G1/+ATcqCmAlRkVRfulx4eeYJFWJVNR4tdyqXb1Qm9GF214PUg
 a/qEkEzZJpgekxNAQgdU9Q0kvZwgshMAF4Hu7H7+klP2k9Jd+zGCz+xNlyXYNRWGTke/4
 k0opZtBN9UkObAChVidDBvJpErqG3O9ZbJCAKHv/41wUz/XwCh4Z39IrB+VyQagi57g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790375650;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=N1ccGQ9ELx+Jvjlm/x3OnwaYs4lKtfFX+oJHb7au2Dg=;
 b=hIvbXDrIJeJPhTNIbIIObA01A6sapiqECIWBA7KM+yfLBUBI1IiJ6ETDZlKN7r2wFsjk
 dyXoN3C6Vkf5dvDS0lEpT+zJPp1zlDqV2KdqrZh66u+BhjoAWm0y3184dsc3ITgpr8bet
 KAXmsALC3jaKyQ5S/+iMsoYZ1sdo1h8KwbP7ABKD58Dkqs3fj2i8/+m0GCy7ZAWIkYQ2q
 2rnj6g9Ux4KxaJoEC22Vgt+ocSm1k7HfeWWfBp/x4cNJySZJbRubbvddri5ZyGTtBICJr
 uWCmO5MA82pzppFO3M/wyrrrYPiK3Fm1IFGHgSbNUi00Uv8aAQLVQmax9GPRNo4aLnw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bBRn7ePr; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bBRn7ePr
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EFB640A82
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790375650; x=1821911650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sdj4njEDSoSp/umSPZjViadBoej1J72Eti9zbsLYbYM=;
 b=bBRn7ePryacsGPR/kLELzfA2AHXQ97Cp8uCWzNaEZPiRUeb01KZfmTG8
 U6nDh4FcfnLnD7v3OKvVxTAEfmiyZn40lQQov/Hs6jRtv3sxPXVUDJQmz
 fopQQ00yr8i+b1Oymvcf16hu6eJwqyao/+DjuHMMVErLpHVHXyXYlgIbn
 HxQCmk7z2KTdHTSru8dZymB3ytHWJUt6+ykTGYg/O6mlIi1yFneWeeXoB
 eulY2PavnqT77YCnlvNDzyJPmucMLcKSLjPbZY1+QDkSAgP1kFuDB3H09
 4RNYxxMwmBGpLZ9WhJ+3iuMYt0lgPT061gp15f8MG6fpV+COtr/GiZlqt Q==;
X-CSE-ConnectionGUID: fa/WnJJlSpSmrA61WNPWEA==
X-CSE-MsgGUID: +vJ5iiMXT6mUrdGBjFh2ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90071998"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90071998"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 15:34:09 -0700
X-CSE-ConnectionGUID: lV4oakUWTie2Hg9p5M/RGQ==
X-CSE-MsgGUID: OhHepA3TQfu6hp/9eMkcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="273053432"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2026 15:34:06 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, davem@davemloft.net, edumazet@google.com,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP command
Date: Sat, 26 Sep 2026 00:28:24 +0200
Message-Id: <20260925222824.270640-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260925222824.270640-1-grzegorz.nitka@intel.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

The cross-timestamp capture path programs GLTSYN_CMD with READ_TIME before
starting the ART/device capture and clears it with NOP afterwards.

It was assumed that this change was needed for E823 devices, which
turned out to be not true. The hardware supported by this driver
does not require it.

Since GLTSYN_CMD is shared with other PTP operations, touching it here
only adds a potential race source.
Remove the redundant source command programming instead of adding another
guard around it.

Testing hints:
Verify crosstimestamp path, for example with phc2sys tool, on
E822/E823/E825/E830 devices. Please note that the phc2sys tool performs
cross-timestamping by default when supported by the hardware. This can
be observed when the reported delay is 0, indicating that the system
time and PHC time were latched simultaneously.

Fixes: 88c360e49f51 ("ice: Support cross-timestamping for E823 devices")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index fd97190a89a9..23c0a45050d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2229,9 +2229,6 @@ static int ice_capture_crosststamp(ktime_t *device,
 	/* Snapshot system time for historic interpolation */
 	ktime_get_snapshot_id(ctx->snapshot_clock_id, &ctx->snapshot);
 
-	/* Program cmd to master timer */
-	ice_ptp_src_cmd(hw, ICE_PTP_READ_TIME);
-
 	/* Start the ART and device clock sync sequence */
 	ctl = rd32(hw, cfg->ctl_reg);
 	ctl |= cfg->ctl_active;
@@ -2258,9 +2255,6 @@ static int ice_capture_crosststamp(ktime_t *device,
 	*device = ns_to_ktime(ts);
 
 err_timeout:
-	/* Clear the master timer */
-	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
-
 	/* Release HW lock */
 	lock = rd32(hw, cfg->lock_reg);
 	lock &= ~cfg->lock_busy;
-- 
2.39.3

