Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80693CA0EE0
	for <intel-wired-lan@archiver.kernel.org>; Wed, 13 Aug 2025 10:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A87B8230D;
	Wed, 13 Aug 2025 10:46:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxJYeoIhd07k; Wed, 13 Aug 2025 10:46:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B60E7822D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1755081960;
	bh=Mt3oD0ax2tzVdIVD/t0AGEERVsL3ilmQ83BoHWhfm6w=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=564lB0S0WU98Iuex0kg3ikun6Jbjl3Ee0+1tpcMhHFkyb5GE++Ho65xtrwAPs0xoc
	 7zYgHFftSLVM2tZJx6hzvE9x4Vpa6wgbJif2Vqn3+uhuK8LnzjkbRpoIB+tQgyaR6q
	 2U+jbUsgmc6dHWpx2HGwanm5Me2tO+r3VwoxmVrnhsXJI+QfzGrlPoNY4Z2EVIQjeE
	 eke70CiCT4H/xvWCW1a7SekxZGDPWtjAYU4LIpwG127bCTU5/QSgljI/cE2k56FHp9
	 1OrbJeHcxtBDkWVWYTtznUxe0dUGoJr8oXld+dxiE8cm80lfo7ENcT5V8dUGILti83
	 1/5oHIgZKpz1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B60E7822D3;
	Wed, 13 Aug 2025 10:46:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B539E1C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Aug 2025 10:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6B96402F4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Aug 2025 10:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aafp-QBGYhTk for <intel-wired-lan@lists.osuosl.org>;
 Wed, 13 Aug 2025 10:45:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F07A9402D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F07A9402D0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F07A9402D0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 Aug 2025 10:45:58 +0000 (UTC)
X-CSE-ConnectionGUID: C7zxul1nQi+fJYxho3ILMg==
X-CSE-MsgGUID: iaKAZ8qpRSWcbLCfrHmXFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44949617"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="44949617"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 03:45:58 -0700
X-CSE-ConnectionGUID: 3kpDtVxTRmO+3RqIleOZ0w==
X-CSE-MsgGUID: lA4uhLofR3uNdHGQ6DqQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="166066908"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa009.jf.intel.com with ESMTP; 13 Aug 2025 03:45:57 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.219])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 400C728779;
 Wed, 13 Aug 2025 11:45:55 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 jeremiah.kyle@intel.com, leszek.pepiak@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Wed, 13 Aug 2025 12:45:12 +0200
Message-ID: <20250813104552.61027-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755081959; x=1786617959;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4z9xVP7KPmCNxufYbAPRjD9usg6SJ9c7GW/z2DZdyqQ=;
 b=ge0px0IxIaV/gXDSrCnu35jpw/BPItcjhl6mGkQTHF1ylzzIm/VMr92s
 DVflVwA+ZtHLYaPp6XPfhDQ2bVO/gafD/vpn0kGtP+DF18w06TyPcBdPz
 6TLhzRIUWterxImeZiQg1cDUMXu+q88fkb57dlidvJg05jvfdvNg4XE9a
 3Xhj+VriuAsLB9Kt6QPxKlV3kdrxUihOU9BuwumMQrh7VXptxp4AsI/Y5
 m/f+MONj5mz/5geQCXfzBtL3vcSEd0BHoA3aV/vGskqFSOTLwC0/1bJny
 rKbJufP85xeyFaho9rZYkZfqseR/dm3RV3WOPHvvaWUXDuSnG8RZDqoVP
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ge0px0Ix
Subject: [Intel-wired-lan] [PATCH iwl-net 2/8] i40e: fix idx validation in
 i40e_validate_queue_map
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Ensure idx is within range of active/initialized TCs when iterating over
vf->ch[idx] in i40e_validate_queue_map().

Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index cb37b2ac56f1..1c4f86221255 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2466,8 +2466,10 @@ static int i40e_validate_queue_map(struct i40e_vf *vf, u16 vsi_id,
 	u16 vsi_queue_id, queue_id;
 
 	for_each_set_bit(vsi_queue_id, &queuemap, I40E_MAX_VSI_QP) {
-		if (vf->adq_enabled) {
-			vsi_id = vf->ch[vsi_queue_id / I40E_MAX_VF_VSI].vsi_id;
+		u16 idx = vsi_queue_id / I40E_MAX_VF_VSI;
+
+		if (vf->adq_enabled && idx < vf->num_tc) {
+			vsi_id = vf->ch[idx].vsi_id;
 			queue_id = (vsi_queue_id % I40E_DEFAULT_QUEUES_PER_VF);
 		} else {
 			queue_id = vsi_queue_id;
-- 
2.50.0

