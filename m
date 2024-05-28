Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BACDC25B78
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 May 2024 04:33:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6A23405E7;
	Tue, 28 May 2024 04:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6KyAxdHRCBK; Tue, 28 May 2024 04:33:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E0E4405DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1716870821;
	bh=DOVz5G+TnCjOJtQYEzd3pzQ88bNxzPikkZ02OclgpWo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3FE7JVBdUG+LNfOszkLpg/SO4kfwSVTJvgmaMgdXtUCYMayFr7BB4mU3AqWF53cM1
	 SEYII+162sjqMJGW9Zq4Mh2HthUgX2wWn11QbMMhKHnj4HGLUpFfqKzuDxa3R5A8MA
	 xBFpv1QrCXT0HyoKn84NVt0bSkV6LydCxXqr4ytG+GWoBgSnsHXZzm6W+Kz7g/MKPz
	 aXg/nlBmdeJ/ING0L7UN/ZSc30n9Q4VQa9tD2rWWzcHJD16JQ+QW1zqRFNe7LJ4L+H
	 g/l4bobmHnh0Lut0R2rON6L8kj9KnRqDR/83P41Ly5+nrqmYmAu77oDB7OCuckSiWC
	 AuKAlGoa5yzJA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E0E4405DD;
	Tue, 28 May 2024 04:33:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id CA1D01D23B0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 04:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD9A2405CE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 04:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ahXP7f_-pEw1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 May 2024 04:33:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DCE48405DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCE48405DC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCE48405DC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 04:33:38 +0000 (UTC)
X-CSE-ConnectionGUID: EqLyrmWrSGijOitOoj2cFQ==
X-CSE-MsgGUID: opbSX+VKQXSGVbLC7/wsuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13020135"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="13020135"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 21:33:39 -0700
X-CSE-ConnectionGUID: L1eglQUdQpChQYJBUzjobg==
X-CSE-MsgGUID: NfM+C1Z5TSy6oogU1fmFGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="66152430"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com)
 ([10.102.20.192])
 by fmviesa001.fm.intel.com with ESMTP; 27 May 2024 21:33:36 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 28 May 2024 06:38:08 +0200
Message-ID: <20240528043813.1342483-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716870819; x=1748406819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eMS+oxn1tYp+rxus1jdEnm2eqSOO3ayeaJRU5iz4V2o=;
 b=lOpyXmurQqxOaYvOj5344bGL1r4av2JFiaDum6QTyuGHJfwoyJGUMcc8
 XnFOhOEqiHDsNziSQ/b4y3w8JN4NdS3vAG0EAd5BQnbE9r2Flis557hKI
 46z0MYCF7y0l9V2M11y1oX7WAym98gpIVslfoeDIQ/mDk11w6YNnv0Mwi
 ogLHWlSwWO8i814dLxOVMeIrY8zc6ACqVxADLGrTHVJk5OcYr3e3fAWU5
 3w71SATzXkL3aoOCKZ+0H/+84rS7uNJGdaQ3zcU8auoEVPX+dIbZMtyFd
 UhleYZTTegHjifKvLsWZQkUvzg0L9QuVQtdzlVLU+uI+CMHlisUbDT5zO
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lOpyXmur
Subject: [Intel-wired-lan] [iwl-next v3 10/15] ice: don't set target VSI for
 subfunction
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
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
 mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com,
 kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
 pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, wojciech.drewek@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add check for subfunction before setting target VSI. It is needed for PF
in switchdev mode but not for subfunction (even in switchdev mode).

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8bb743f78fcb..fe96af89509b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2405,7 +2405,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back))
+	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.42.0

