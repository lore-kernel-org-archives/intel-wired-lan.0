Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F769C98330
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15A1440BCE;
	Fri, 25 Sep 2026 23:58:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6s4-7h0ewpP; Fri, 25 Sep 2026 23:58:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8200340BDC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380693;
	b=dgbgppqX3YhFYJewuGC7iIb4SYYmQt/tRoVaSoTP6GgcxI44uZUa16LFF6ZC2yT9IUoo
	 aJ+zaq3BBsa+pbAz57LGhDDUdkCNMf1IacW3hXLjDbSoKr7wzc65+itYjYQDLLXp4VI84
	 oZpzDRXxuoPmfZPTSvfTyxJYRcV1+kA9SPtoVfmQmjVrO79WU7K2LgtEfBykPl3UpNkun
	 Fq/tgUw8NkGh0gAuh1wBqIYUU+NVH9NlsBGomcsUkh98dGfuLjsvnxeQyjNMdQcRFOR5l
	 9Fl84E19SHvjB2Gb16zgDud9CcP9S3Uh9Cye4tTFGMFn9uqiDdLm5MXdjWuYKwcsYig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=smvFZV76vSxZR953FRwoAC7wxWJsaHhQpOtW7ASOyr4=;
	b=MC/8dKFrJaTSsX6vEjp40GPiuSGKj22K6sHxpyxQ5cQL3D4pTRxx0I4Ug9pG/GnLnI8S
	 w//pXpm/EDgKPYixpEdZjcAFrO0oA2Q2yR738Mt6RpseFai5SR+zrTXbqPyMZa4PoFucV
	 UQ5vc4cLt74rPlqWimfW9gXwmfCSiCT3eHFzAX3GDfNTDBgoiLevwEJLjm8YS0qiqYKsc
	 sWpZ0LN9mz0AKg8omodXCb/M6ICTIKq/kZJGweKFRvS1pi7LU9OBlbnUFimooSOZd7CL1
	 J+1JWVj93olDqRLxEAN7IPr4F5Oow7O1aW55VTAVuMqhTLqg6uNUzmK3sPvFgbNv6UA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380693;
	bh=smvFZV76vSxZR953FRwoAC7wxWJsaHhQpOtW7ASOyr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H4vjnVl7Vt+hp9uUFui1mGmWDZ4/2XHWNHkxROOTfMnzLG9J4vG5IcBFVslzT+m4Q
	 S8gcdfXR41GXD3U7tR5+dTPnWBtKt0z0xnznqHICZ0bQHz1JDj0ZYZydQW182AMhYm
	 Lkm7vtA/g6Z4tJYZM49I59XuooQ8aTNVancrybomWLUI9LAyKTRbvb2pPqjjvIAHtX
	 3DPygf5YjlhIhN7ryfESQ86riZ9fMFkI4AD/Cmickpp8o0gEWOR8Dte6sbuZM9QKwE
	 q+2uxwIeiOhx9uCiREZxivxyrSVYiNjnzlVDgYM9I37Ezm8c2hwgrG+RtXWwbVW6TA
	 sOcRF87cGZ8zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8200340BDC;
	Fri, 25 Sep 2026 23:58:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BFC4194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 195BA60720
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rPXu-Ligz58O for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5790560C13
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380686;
 b=DS57817oHtoIR1sW0gb7roDMB6spuR2y/R+MlYpg3HICwMA9HfpO3R9KzAUguuJCEoVL
 iTqziuKC+VfYlwJHvjRTSO0gkD97ULmR4xiuatdQoQdNO9uGan+eIBbXAJlHr39WPlIvL
 W1dH7zcmLCw30D1FgcO3SDE8Y51/n5rWGLXqBSY9lGV4naBc2tpM9QKMKmuEeQVqcvOT9
 D3R7W2O/AreHh2di+ZXsaeR31Cu7gUZpHGKlgI/o98f9wxFxJZXsrg8ihpFUyoHNHQsIr
 sN5tmohpu8I3atlpnIHFyzA5VOVjqqNhbRZNE7n/S7EGf3LJ1k9RQdO98uCCC/sPW9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380686;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=smvFZV76vSxZR953FRwoAC7wxWJsaHhQpOtW7ASOyr4=;
 b=mofKgidCWrcq2X+YTNQjuZeEi8mTZKvlQQnSkLiDLDPLuOHQ5qLTUV1Pci2ZIw+MAdo+
 ibQNyLSKQoAyvUbUNHv9LR/xdvSKy1x6LvCFEJ9EgmyLwNQrqvdhl9VX9f7ZhFX1gRGh1
 CwANexDOIYBEST69GJyTN32CbBhmQ8xfbbFSFqtx28Hjh8RkCIoMG9oUW24bReVqHTGd4
 sm/lq5CQoTlikVqnMHNKQScCKYbDh7x1k9JKRjHfURRupZZe1n9j73oxnQaPUHttNiEBy
 DranjCF/c6d4zpueOW+gMh7T0+on8sIc0mjyzGY69Y/Mn0RyAWX/K0P/s3HwWMlyEdw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WbqkXkkH; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WbqkXkkH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5790560C13
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380686; x=1821916686;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=xSiIrj32lJho5BfKE/0NtM7UFO57Q5TqjB0VFG7GEFM=;
 b=WbqkXkkHHJFKV5YZvUfsju7ihKU4gBALNmdtmlX/ENWrLPgvFhK+u+tI
 CvxKzKzRYnf2wnVU/XMpQoX9dKSw5CaQu63j67OzKY0F2whgMriOz7j6y
 PuFKk7aQeLnKirBvSIRoSU/qDPGNKj+5hc8eN1kUTZSOkgLKdHYWKpRE1
 50nYeTyyFBMatn3qcJ31kxflbTGuTtzNumewELuBYkYrBkPQss4tIgK5J
 +4hjG7XQ66APRu5Vudn25ZKA+HUllEYQ/UV3ES2uFUbuTO2ERT6Sno+HV
 9V8bXRZvu96zz61/qg/DgLeYGXPu5EIYQOrNEJm48GBS2YpNSUy7gjVsF w==;
X-CSE-ConnectionGUID: zuGX/oFRSamYdXTlkq+yYw==
X-CSE-MsgGUID: EOZuNDfXRCeZcDVHmoR8tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212813"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212813"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
X-CSE-ConnectionGUID: HCs3Now6SguNDx+6Wpx7gg==
X-CSE-MsgGUID: ZaFWjB4RTl+nG0arJqYxHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731129"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:42 -0700
Subject: [PATCH iwl-net v3 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-10-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=xSiIrj32lJho5BfKE/0NtM7UFO57Q5TqjB0VFG7GEFM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXFV+spHeCeuthNZ7Hfr5ue+X55FCk/2B98pLxePni
 NZVXM3pKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCKCXxgZrkzZ9aQiVTfk8PED
 v/Mubgm6yrymhHFaWA/3vSLGfVeqixgZbqjeErdf1KI3MeBtBu+ys2sjZopbXTbk3yTr7HFcuDK
 MFwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
including its timestamp counter has been reset.

Note that despite the name, this PHY soft reset only impacts the timer
block of the PHY, and not its regular Tx/Rx functionality. Additionally,
many configuration registers such as the PHY_REG_TS_INT_CONFIG and
PHY_REG_TX_OFFSET_READY are not reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e83ad2bb8d42..e5bfede90431 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2128,9 +2128,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
2.56.0.rc0.395.gd1f3524e15dc

