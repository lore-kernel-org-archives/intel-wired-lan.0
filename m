Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD88C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 449E760720;
	Fri, 25 Sep 2026 23:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E_JZgw54Sy35; Fri, 25 Sep 2026 23:58:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9236260D57
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380691;
	b=rt4hxm46AIH05v1mg0omBnlKhIWtkx6ayZB4i9/5i0Iuur0pN/ArzkQiJq3TQvZ7oosl
	 X5u1npj9lB7NDDxFdt//lTLSQyx9nKH8GEIrx0QV4fPQhHIgYSCZ3IcJyI3NLb9z1NReW
	 dspdWTfWlaZHvvzEuCX7zwN5XRk4l90+fsB/NPkB2afJv9FdweMpHegr2hgs6iiuC7Pkd
	 gfGFejjZnd/jHG4+L/5uE5k0oP6HUJTl7N6m11MFo1KwKsIfTVV1dQupNy+FmOdgdZvHK
	 FWnsZov0LmxRMSl5YHGsnWUoJENxjfn2g2FOPm6VWXfEyXB3HaIXzfdwM6lW7jTyYCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380691;
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
	bh=c3AkqAxaFikrKSSQsNUBfep4T12896P1tjcuO9m7dXo=;
	b=VmEJf7fpGbY12Dz54DuwLGR9vSV94Z2u+J024tCcB3e/ooGcSHZ0OCb4nc8kJPg4tp3V
	 K1o2jptUVW4N3bMR0iSmGp5XfmF6yvM5fhERBa3ynJChbrSl4X5ZzM/4oOS5fqFPWdcfE
	 nAvPdSKjEeBJUx/RFWaWTO4QANuJO/hU5fvBIi+M9xZcTyPV1kcP72hQaHggU5yVOVtUb
	 oysAxeVmYT0fXz8GNN6fWbs1jlFdsVvg2ouByHpEHJZuA6WBAORA64VMQIfuTT0SWmqh3
	 aSGjZOJ4DIDTBQl4m29o6NH5YsYaAzA/a3ukmtb5MLnMjgU78+j7Pnz86kHRhLwAFRw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KRejJ9K0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380691;
	bh=c3AkqAxaFikrKSSQsNUBfep4T12896P1tjcuO9m7dXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SaWP5i4jIm1dGqXUJsYdVRCDDW3ia5hjQhVn+Smg9JBPgpTMy4xkl4lfH0gc4Zimk
	 0eIltjOQ1s2ALrHjkjyWdaIHo0+g3crZ4BgO4lPhvpx26DvkQSWY1rIulgbBCzszY5
	 89J1tOHpFseBULImQ2x/+fqNNrOvAJLlLoXDnQCFgeDdp0FObldFVC63Zf8xMVGjXs
	 pootKE8G08DPqmIgnjzAccBC3ciMScYImAfE7BV13SLR4hE0bFSZ5YF+Ati2engW0X
	 05r4aPd7tBUsT4g6T0qVWreajJ/IHaazeU1/tKdlfirvx0GaZdlPmNs+L1ydvO9V0O
	 oPRodbIPsLhng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9236260D57;
	Fri, 25 Sep 2026 23:58:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6ED5194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD5C460D6D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vfz4RiaCHBx7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0793B60720
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380686;
 b=gXhVU2WDfPdmtHbNxKeFCINQeuBARckmCDZSI95C3nMxFnv3VkNcY1aPgZi4ddV8hytf
 CgsHxpCGUaZo4k3Ke3N4YeAcZvf0Y5SO4yU4eIK0NeJNMuPBT8Y8jkIv8J61N5XEm28TH
 GOQudN2NBt/XMRrgJNYAuwX7FKvJ+6cUNn6ZhPprPnB2AH6FNF4BhXk0z1uVPn2l4Mjud
 nWoZwvYogj/jjAB35n0AJCSZJK5/djld1NUOt26QnL0uLzf8+8asPfFuuKALbfgEsVnrX
 TbZzHx5eKuZkAQazIDGRxEwey+73eahMu45nISNbQAGrRzTgSgjWqiFXDSxAN9i4flw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380686;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=c3AkqAxaFikrKSSQsNUBfep4T12896P1tjcuO9m7dXo=;
 b=WsWF4zBCHOHGUj5LD0zEpSw+74tHSq1mu1NCeoRzqLpNQwKAMtAGVtxt9pGFLh/O97oB
 ZG5mx+0c6WCqWDUJBjqZ/iwtfC2Qjk12uo7z7VBN5D1oZBpE02KttikicBSbjHeoLZoce
 i+UhW1qGUW5W/44sYj95YTA9YinD2jJyFYnVYnZ1jItHXeacifMsI1gQazqcXzmlxzs93
 GH272INByT5FPw9uXtYJfhAy67CcKcWeTn9BhssLnSRn8c85xUTzqsV6gjpqQnWUL9kmA
 OI6dZhPbjQXvlba1Y7DbHi5/1IlycTd323dnJbuG2/+I7GJBKvSESVwZGtHHLKacDaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KRejJ9K0; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KRejJ9K0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0793B60720
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380686; x=1821916686;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=YGlMYJP+RFG6ts3N7+fOrNwQRQ6/32vb7Jz7NjGyPR0=;
 b=KRejJ9K0YF4rBPAKpoi6UfhYBUU4zYvzFBWQ8apFR98hxk9d38bzeAmM
 IgTRNR2ZBsGgBGimW/wrFPE1qsah3PcWtDonscMuDdQLu1QTvGhH/Hdh5
 27tMaoRusucDbdmZM+GNFmFLiQug7BTK0eHmpUSLkl3J7YdOHkyP4l4M6
 8USypbF2w+zVJ/n9VVO9tdRCS9vxqr5R3B2L0FtheffUFDhrNJFpSU4v+
 lyEiwNyN9hBOD5A6ZFYPVbfcVglojKNDIUvASyKoJdGLQV5+iDEBqYBso
 Y+SapeBmPmtQIpdedkXv/9BYO59nvpXX914jK9GBc6yVVA2xhjOZ6zoRf Q==;
X-CSE-ConnectionGUID: tcZ468u2R7WWMGDSMI+v+w==
X-CSE-MsgGUID: rD7bxUq1QrGMJ/ZkLDE3xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212810"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
X-CSE-ConnectionGUID: zTLamPe6SSaoNAVQw/OSwA==
X-CSE-MsgGUID: kiOKAJbMQVmTee/SmjzrvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731120"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:39 -0700
Subject: [PATCH iwl-net v3 07/15] ice: E822: cancel offset verification
 work during reset preparation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-7-6532598e8da8@intel.com>
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
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2365;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=K5fn26b9QsNTZ5g53c34wse0O5O+1y1s247X4YTHg3Q=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXJUPtMIN+eNczjyx2/r9Wvq3/SbyNn7m19WztMPWi
 x9jnRvSUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwET+qDMyXLlvm+T842b7p9LH
 Kvun15V4PrPZ0jr975N7f+/dz23dNZmRYfsF4Zr45nlX30iZeuy+ulpk5ccJTx+f/flRLlLqUuP
 pbHYA
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

The offset verification work task for E822 is executed after a PHY restart
to complete vernier calibration. In the event that either Tx or Rx
calibration hasn't finished, it may still be executing when a reset occurs.

A single PF reset does not trigger a PHY restart, but larger resets (CORE,
GLOBAL, EMP) will initiate a PHY restart.

The ice_ptp_wait_for_offsets() function does check if the driver is
resetting, and will reschedule itself. However, it is possible that a given
execution is already past this check. The function may then fail to access
the sideband queue. It treats failures as a reason to re-schedule and check
again later. This re-schedule will then see the updated reset state via
ice_is_reset_in_progress() and will keep re-scheduling until the reset
finishes.

The larger resets will restart the PHY, canceling any outstanding vernier
calibration and forcing a restart. Preemptively cancel the task for non-PF
resets to avoid doing unnecessary checks while resetting. The task is not
canceled for a PF reset, otherwise nothing would restart the task to finish
vernier calibration after the reset.

Fixes: 95af1f1c4c9f ("ice: reschedule ice_ptp_wait_for_offset_valid during reset")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7f82439c47ee..7cc151b01a13 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3006,6 +3006,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
+
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

