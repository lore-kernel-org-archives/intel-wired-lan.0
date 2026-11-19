Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2C606A32F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xMBgm47i;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LiCpPl9G
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D5D360AC2;
	Thu, 19 Nov 2026 00:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2VN15wuRvTQs; Thu, 19 Nov 2026 00:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF71960AB4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795048294;
	b=Z9fpKAD74bWHQGCFEZPEXekGtIv8NGZIv6vYYxf+MquOWeJ3YlYLK1ws88ieo9L87uCX
	 LQKnpHl57VtasXjNCDx3u+fifUQ4KFeFmvq+RMnJjhBUAGGy3u7784wkbzlPT7EGdxuVU
	 jkx00JUZ66jXm1fDmGPbBlJowtRMn56ESWUFTw/aWzNqo1PQAyQOvEUK1ordEsSHz7GuB
	 thjw9V/qxWgLo548MmQZwweZE2Ahgv2vjMIqUAhthy6CslUVAKau65jLyfY2JpUSlBhNF
	 fA/5T+Oq/pZjugxid4eqnb417iZSjZTXyb0FdhX4BK7LiKjF6Zs7ZWhweuehBoHAATA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795048294;
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
	bh=SPbjAvt0unvMm5H74ENfpQfBnqISjsY1ifxPpUOZh9U=;
	b=YKc+zalFwvtYYI/Dog51AXwRgX1sPhNRHYMeE38qzMgdeTVdAvWOb2ng70yLoIxSXY2Q
	 lNj8dvuaOLfnor8IDKsgZftxJ81UaH1qWhclCoo2zOWe4PRREZS96S8f/pghwJNQeO4as
	 VMHugw9eEM07BWM6qY6iW93Xa3eEYIYRIseFgRtlxiZPWn9lMxkWkdZROkQDJRIAMQpah
	 XUjcP+1mwh0xGockL1C4kUN97TOS2eCxktuO4TscG0S+Na8fCDARcUXXV83AegGTBV4Zk
	 6XEL1vzV+Ys1kYC62KSTbrmw1MtVz7jaxwLytJnfD5ht6cv8x9K96ferMrzrTI13XHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795048293;
	bh=SPbjAvt0unvMm5H74ENfpQfBnqISjsY1ifxPpUOZh9U=;
	h=From:Date:Subject:References:In-Reply-To:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xMBgm47i0ULuT/Y3G6+lImWuHBbwNXxGclsMSJB7K/YhBz3FZpIRSfpKxlozepd8A
	 jP6AyDRWa2AQpMTaXzk0StIOJoU3bxRMadcJeP4ZU5LpM6FBAI/tjTe9ppy5CIzN+F
	 Cs8rnw9cXXFhDTUfx6oOhUCR8BRsJePTxC6mnK3hkunR1Wr3ANHPT2KTKw7uSCsMVn
	 nkDdu2MVCsLIxkKtbKvaHdGKezZ9JdUYdtJAQLKXdriYhja5afM9uFpINRXRBRe8mL
	 LM3DJkOF/2HHr3ZYY+7f3GZxk9iVEyRpLfUDl3R640ICOIV25J+h1Bd89i+jKtm/Dy
	 8UFx80ubAnM1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF71960AB4;
	Thu, 19 Nov 2026 00:31:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EB62392
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 00:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50BB6812A1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 00:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eh6g9CtLWrcI for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 00:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84DDD81282
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LiCpPl9G
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84DDD81282
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 00:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795048291; x=1826584291;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to;
 bh=Yn0XL16L5C4eqVqAPY/iBE5TfFaQs2QvGR64RkdnuqM=;
 b=LiCpPl9GozelELvcYRBppEgACLqjRfsS9pOnBfUcZimv60cVA5fNDgM1
 GjyLLCa2I7eZMvPFwhXiD/JRsfm5H/1CM1a3HnEedpMBX8B8sFQZsc7lO
 560FI5JcHVNkla75xziRDRABnJnNN9kMXHnlXWS+UmwLAB1Y07Oo2JU9p
 Vnf1xC9CkwDF2FoP2XWxSfeex9zasUdHCFQbBLx7YBM9j2/66IEhQUIfO
 J8YNFBjbo+CGtCudoMvjYNcFHSS0rWMKOUWoye+yO+86247rZ8JLV+Rlx
 ZniqRK2a3rvUQA8ocBjKc0+UgJNvSWNolxOpD1wbWoKLxRkvfDEYjK/2o A==;
X-CSE-ConnectionGUID: m0xNVKsvQxWUsW8SACGG1g==
X-CSE-MsgGUID: v5ddZ7zISoalS6PdnI5mdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3886157"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3886157"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 16:31:29 -0800
X-CSE-ConnectionGUID: 2nXpCSovTp6k0uu9Z/h8VA==
X-CSE-MsgGUID: 6vKejf/jQ2m76gRrUzytgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10287247"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 16:31:29 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Nov 2026 16:31:00 -0800
Subject: [PATCH iwl-next v4 2/4] ice: exit PTP callbacks early if not
 ICE_PTP_READY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-jk-e825-e830-timecounter-v4-2-0acd194b7357@intel.com>
References: <20261118-jk-e825-e830-timecounter-v4-0-0acd194b7357@intel.com>
In-Reply-To: <20261118-jk-e825-e830-timecounter-v4-0-0acd194b7357@intel.com>
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
 bh=Yn0XL16L5C4eqVqAPY/iBE5TfFaQs2QvGR64RkdnuqM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqx/ztFdM/237Jy41Ip5H0f0VKvGmNOh76d7Lkg6UN3dm
 PeL/bNMRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABO5WsDwh+fKslOhG5bOa9My
 OBAbu0LN9YjY2nDjNYznbe88WLTkyCeGf3qN17QXF+/8+n7y1zuTd8Q787pbm7/ifSRpdVWqtDJ
 Qhw0A
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
index 2b8b6f2a7ef8..777db22a7c24 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1612,6 +1612,9 @@ static int ice_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	u64 incval;
 	int err;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		return -EIO;
+
 	incval = adjust_by_scaled_ppm(ice_base_incval(pf), scaled_ppm);
 	err = ice_ptp_write_incval_locked(hw, incval);
 	if (err) {
@@ -2002,6 +2005,9 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
 		struct ptp_perout_request *cached =
 			&pf->ptp.perout_rqs[rq->perout.index];
 
+		if (on && pf->ptp.state != ICE_PTP_READY)
+			return -EIO;
+
 		err = ice_ptp_cfg_perout(pf, &rq->perout, on);
 		if (!err) {
 			*cached = rq->perout;
@@ -2016,6 +2022,9 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
 		struct ptp_extts_request *cached =
 			&pf->ptp.extts_rqs[rq->extts.index];
 
+		if (on && pf->ptp.state != ICE_PTP_READY)
+			return -EIO;
+
 		err = ice_ptp_cfg_extts(pf, &rq->extts, on);
 		if (!err)
 			*cached = rq->extts;
@@ -2070,6 +2079,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		return -EIO;
+
 	/* For Vernier mode on E82X, we need to recalibrate after new settime.
 	 * Start with marking timestamps as invalid.
 	 */
@@ -2139,6 +2151,9 @@ static int ice_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	struct device *dev;
 	int err;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		return -EIO;
+
 	dev = ice_pf_to_dev(pf);
 
 	/* Hardware only supports atomic adjustments using signed 32-bit

-- 
2.56.0.215.g47fdf2208c5b

