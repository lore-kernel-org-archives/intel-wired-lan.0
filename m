Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB7606A339
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Ms94RNG0;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OvZsxmjq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FD07605FF;
	Fri, 13 Nov 2026 23:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6AoXKlS0ZOT; Fri, 13 Nov 2026 23:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 726F160DA5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794612651;
	b=nlL8kjPUoYsb+z1wOoVYr9Ch7ZBiX2wTgB1w5JRR5ZVAPWwltEQ2a10ToHTKRNVqGN/p
	 AsH1mD3BU2YaTWJ2ZkO7NQwiMaPPrPCbqs+KYlWmchl0TzpjZ3R+4vdtKJ7Lra4icbyQS
	 g4lreqrYyIMuzY6mSwGlvMNP6+1SIAW094gS4Z/AVjJz18jVXnpbHV90dnC5jiY0qYh91
	 3i57gOkjBVN1X6ZhtbMFGrHnf7Psookem16/gzyiPse3bUONx8GOkR3KOOwnXLiLZJ7ch
	 gVGtlEoyvYWteMje6S2LWZ3gltObBPSkyGD++kJ8H3JdCGUAycPbq9t1Juqdoi8jXBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794612651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BnPFs9+rXBzrAHaMWq60HJFFyWmPxdPz0P0naes2LtI=;
	b=gOce980uN4nVNCCyuGFG66KgHJXfkTu1G6bgH0LeK++LFjyni8g9845RAHF8+V69RLhV
	 Lss1g+8cLXM5pKs3yb/jGAkthHSXqH/RUQIwTxT+YaV7GPwtZdh+8Hti3A7IUHncJduoA
	 M+vnjzjm4aheiAUvVQ9Lcviw2CXmLO+2xfbmt2DawyHe3dTx34tzUq76Mhv7f6eRm50pK
	 RLNdMgoqHG+Nw832t4DyEeVVHJ7LGV3sgt+fqLpHntt1m/z8X6YyrqHqORMN9i7u6UvYe
	 FoqCXS8EACUwYOzBKnDMdA5wjVKpAYAFcyNC4wL/GcHQBLRzFzFpqBveqx1v3PhtE8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794612651;
	bh=BnPFs9+rXBzrAHaMWq60HJFFyWmPxdPz0P0naes2LtI=;
	h=From:Date:Subject:References:In-Reply-To:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ms94RNG0pbxD2z4QyHkyvUpQzdcwvtwlLmbw6I2kDAEhBD98qWcwzYYlirbn4HuN2
	 HFyX1UW5Z7w93mC3VY7XhZbrq7/RbhbR7t+CjJz749q65wuF4GNMxh9Ge9TfRAjczV
	 IVyfwhMRWxEhf+tPXlapg2YMeN4/wmTLphLPpCaZW9TUFmHQ40ie/iM6/fwl7kx6iT
	 HaZfZU5qOSpqWAQin8hldzA53C/bxwjwIslB7Pz8zDClO49VKveCvQW4RdG1sLXzPH
	 Kgf5HkUU0adWAHaj03MsnU4ZXtLsXYRR40KdOh2QFI+O9i1V9JEm/5mq1y9esq/XOU
	 5uGtLHONEilhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 726F160DA5;
	Fri, 13 Nov 2026 23:30:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B1491E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 816C240EA5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ha7KXFra7XAg for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 23:30:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA42C40EA6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OvZsxmjq
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA42C40EA6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794612649; x=1826148649;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to;
 bh=7kA2vGltI3l8O2Yw7UGw5cbt6sbrv6QPi17A326Y3Tc=;
 b=OvZsxmjqQfm8WesI++Uld862FFXZZpshVOQkjBEYQgylv0X7POfn7cL0
 uvGMKczoHiPA3qUkGn7YKiNnBJ1Kzr9oCiUivX2YiOEJ9UI7hrGCuwSuA
 +BzWGlyMhCrMS9TVCl02fFZmKs71gvmiJ+p79eExZeunAjWLHZsb22jPZ
 ydnusuBIqmajCphLXi+cT7fSv1lVrTH+blw9Ws+f8KEp16pI5fi6ki9D2
 5AVCLBrw9ozyzydJQxCEZhmelAc6RRPdoY56uySnQcGxpDrehziHJQooI
 sVVuiP7JXtyCwxinuAJAdqcGxJauKKLkh6udAPWYJ+NnlT53PlyxtFrH4 g==;
X-CSE-ConnectionGUID: M76uSKjOSGyViAeIW90fwQ==
X-CSE-MsgGUID: vJ69kqc5SLWmryR9faLoHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3470195"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3470195"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 15:30:48 -0800
X-CSE-ConnectionGUID: SFWsK4vRTXisFQqp2YfrbA==
X-CSE-MsgGUID: w/Rj88cSTUqUrUJlLQ7jCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9574072"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 15:30:47 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 13 Nov 2026 15:30:02 -0800
Subject: [PATCH iwl-next v2 2/4] ice: exit PTP callbacks early if not
 ICE_PTP_READY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-jk-e825-e830-timecounter-v2-2-9c357a7ed349@intel.com>
References: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
In-Reply-To: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2975;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=7kA2vGltI3l8O2Yw7UGw5cbt6sbrv6QPi17A326Y3Tc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzvcxeqXDv+PWlj39q79u0z3KbvcT/UUMWw6+ezRk+hi
 V4Wx6szOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIYUuGfxZeaqy2wtfDlF/b
 /n/49aCgmYim0urVB5dPimzfXaWvy8nwP7CAb8bZkEM/cyuDd7fbLP8Yd+CK2MRPU0pvlLvuv/3
 tPg8A
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a check for the PTP state at the start of ice_ptp_settime64(),
ice_ptp_adjtime(), ice_ptp_adjfine(), and ice_ptp_gpio_enable(). If the
driver PTP state is not ICE_PTP_READY, exit with -EIO instead of continuing
to try to modify the clock while the driver may still be loading,
resetting, unloading, or after a failed rebuild.

The check is currently best effort and doesn't guarantee to prevent a race
between the start of a new command and a reset. For that, we will need more
time to investigate and develop a proper synchronization mechanism.

The ice_ptp_gpio_enable() still allows requests to disable the pins. This
is intentional as it will be called by ptp_clock_unregister() when tearing
down. Additionally, the core PTP code often ignores the return value of
ptp_disable_pinfunc() anyways. Allowing disables through ensures the
internal driver state matches, while new enable requests are blocked until
the driver is ready.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a4c7c36905e8..bf37c2a7ff86 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1607,6 +1607,9 @@ static int ice_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	u64 incval;
 	int err;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		return -EIO;
+
 	incval = adjust_by_scaled_ppm(ice_base_incval(pf), scaled_ppm);
 	err = ice_ptp_write_incval_locked(hw, incval);
 	if (err) {
@@ -1997,6 +2000,9 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
 		struct ptp_perout_request *cached =
 			&pf->ptp.perout_rqs[rq->perout.index];
 
+		if (on && pf->ptp.state != ICE_PTP_READY)
+			return -EIO;
+
 		err = ice_ptp_cfg_perout(pf, &rq->perout, on);
 		if (!err) {
 			*cached = rq->perout;
@@ -2011,6 +2017,9 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
 		struct ptp_extts_request *cached =
 			&pf->ptp.extts_rqs[rq->extts.index];
 
+		if (on && pf->ptp.state != ICE_PTP_READY)
+			return -EIO;
+
 		err = ice_ptp_cfg_extts(pf, &rq->extts, on);
 		if (!err)
 			*cached = rq->extts;
@@ -2065,6 +2074,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		return -EIO;
+
 	/* For Vernier mode on E82X, we need to recalibrate after new settime.
 	 * Start with marking timestamps as invalid.
 	 */
@@ -2134,6 +2146,9 @@ static int ice_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	struct device *dev;
 	int err;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		return -EIO;
+
 	dev = ice_pf_to_dev(pf);
 
 	/* Hardware only supports atomic adjustments using signed 32-bit

-- 
2.56.0.215.g47fdf2208c5b

