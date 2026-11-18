Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFBC606A32A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=V9lDbZoT;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S8fDoTjf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70D7C80F20;
	Wed, 18 Nov 2026 00:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEpU4kFhs8-v; Wed, 18 Nov 2026 00:32:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C852281091
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794961927;
	b=UWITi0Pk5wQ18cwouDaqy3mbXlgPzeR5luWPearbXp155X7U/BBUYiFTZZmzPSa7GmbN
	 B5zfYnkfCdPHbmUnD62LWj6AW0j9wLKd7hilZ18D6o3Vjyb+xfugdidPtuW2wbuEuMyt8
	 RArkDEevOA+lTaaabDC2KUKHcaW4Qq8ioquuM5aptWxq5odUoAgB083h00t8yV2aeImrA
	 HHqATMGrzv6d5LtN6DL7YO5IqL4cupPDJS4xDR3TZZcDIRs8bSMrWGJnteYqIaUBhzFyz
	 k/M9wg8z3rzv9yaWq6zlk/Q/ccMl/thPOESZvL/B/qiLXdMut/O/NTzIkbsy3Rg3Z2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794961927;
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
	b=Fzm9rqvmabPpJs51cKE5/sRTHS69LYj/bH3Noms/GRFh3BHBedd9VPw1Mb2YcA6InCHT
	 nD85XSK5JH8ObGVzQ3Zu5pujw6GLT+5fQTsFy2SBO0klGVcZpQktEV5MtNOqjx6IoZuDL
	 20e4j/q9pLr2Tw5ZCPeVsGUhwftlIx0xya8qea2Cfy2AddOz5zgHoqwd/8e52IKld9cv9
	 9g6Ys0tTsmVRuDHp1rAprRdOcjVL3KGM/9luQrW/0j4OiJWf0WmfEg5YetyPYMM7fIM13
	 kILSc/Gtf1tXqi4o3J7dzYMbjrkCg2HHRUUXz2TPDmNr2J93d6DlCXfIzRsx8yfchuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794961927;
	bh=BnPFs9+rXBzrAHaMWq60HJFFyWmPxdPz0P0naes2LtI=;
	h=From:Date:Subject:References:In-Reply-To:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V9lDbZoTVKW9F0ahOqassKnL0Sv1UYqgPdiB4mbXVuWEzh8Zbd+MDBNou/gPBkrd2
	 wirfaW/1ClzoAt0MccI/vSLim5VRCXM/f+8FuwJZfGaastNrvaFoU/6D6emPUP6wTa
	 bb2lw8J3dTeEROiEzVEzMDLaL/w5IHPriUO1qGX6RWd++ZxkGkkn9mMZ+5pKLjvZNC
	 JBjmqC/yNYbujL8rJLaf1xrvFQAjlU9bTDLtttn46NArEgmOGJdqTa35B/4en+eeEN
	 GACD/KP8ejpOOOUZxfVrCPw5fcpwmXnd3Y7kKh2JPXe9QKxbnou+NzyecHICm4iNY/
	 QvjN/ZRW0Yo9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C852281091;
	Wed, 18 Nov 2026 00:32:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3060249B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2286F60729
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ezZN4ytxh-97 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 00:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 511C260730
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S8fDoTjf
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 511C260730
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794961924; x=1826497924;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to;
 bh=7kA2vGltI3l8O2Yw7UGw5cbt6sbrv6QPi17A326Y3Tc=;
 b=S8fDoTjf7UpOo6pQz6NNCr9TztKmkjtbk+cm2VVMaiM3avLks15BORss
 p7wsRg2qPGbUOK4TkDpRxOBy8V0qjZ0PkiQ0hUrKuOOWIkk9LEYMvE8jB
 56728Z6jRtzOBv4BivWX6IioGgDPI8XfWHpr8/iiISm4rMNMcO9oump1z
 V1tA2SoHVfpSyatJuKIIyB9unRR0JyT0CuHIYRMjeJJcQQBfbZhNhSeSn
 Txm/onVIC2ZBF7d6pq09GdNTGK3iRlLJAQHiISpApNiuQBPrXg58+u36z
 llUxUHvNkMRiUNymK3SqdJTtJ1u4hpbv/kFiCJnzMZNFIH8BgMAKLunof w==;
X-CSE-ConnectionGUID: mPn5gGqJR/OWFbMstFLsIg==
X-CSE-MsgGUID: TvZkQVXPTYOy4tm+H2dUJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3618634"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3618634"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 16:32:02 -0800
X-CSE-ConnectionGUID: jLwpc6OPS2i3/92Z79bc7A==
X-CSE-MsgGUID: zUNfMn/dTtW7v0CR7G18QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9824887"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 16:32:01 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Nov 2026 16:31:44 -0800
Subject: [PATCH iwl-next v3 2/4] ice: exit PTP callbacks early if not
 ICE_PTP_READY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-jk-e825-e830-timecounter-v3-2-87ea4c86a249@intel.com>
References: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
In-Reply-To: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
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
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw/H/9qNWrmeBx5Jmnvxvde1PTiq8uXVC5da8jcIfT67
 4xlT+U/d5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRffcYGRYr9Jy85bYkSVjx
 v70ZxydHvsvBR8qUuPa/3TUlysTgwAVGhu32qmLKqx6Vlz669qDDJzDR/a+6QeVbYwPWfdHP7l2
 14gYA
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
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

