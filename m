Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5306AC982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2090560710;
	Tue, 22 Sep 2026 18:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ls-cqSKekY7x; Tue, 22 Sep 2026 18:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C35B360766
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100516;
	b=SgjJct748PaVt91C14/nY6+5D8ZkErMIoZlAaB/1m5NKlyqnj2VC4xAtjht/ZRm/ihBF
	 U66a989GrY/k6zlg1oOmPODtf78R9LkPG09R+GdzozzJFEJ/UwBOeWaoT5z+NVFtx9yeI
	 0d8ySnAtTwmxabgy500oKabDCbxTVWRRVU4VQ6YtmZ5Vgvi0A8nEoaj0tZyQXDAVE8BNg
	 96OKpj06eVw/T21ANAqO6l0cijOxQuk0Fv5WSWK2QBTGvngE/90f038qx9zExXKJH/kcs
	 geR+VdQ0GxWwf2DD9hlzcdSBH4KwmwT1LyqMMwrb0R9HH69/Ljs9T7hTh+1cWzaqZXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100516;
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
	bh=p/tT8T2wAOjsW0vSt53XIleGMxZ5ibgzQPbVrXy4miM=;
	b=qxKgzJ6DWNDzQ0FP+//69NMq13267dbr3TEQl5AwoOB2SOPLrY/pxtccBtvjBUCc+tdO
	 rdMfAI5YSm1qi3UsVWYYcJLhQVWYZCzyLJTuk1J3CldCBaf/3AR9jXyDggejvpEnaD0uc
	 DsjB3f6oeyJb9sYpBcDOEEnI2wAZBS8Y3g3sAezuFa9N2peSO3dBj9RC0Ey47G+YPm/mO
	 M/hqgJTWCUjLICl1IdFIxee+VCSiOqsAGbeJ/QUvuVVhmHKH5P5fdobKIhjP2IZmkZNM5
	 RtY2tc2P/C8cls++EFZa92+U4+Gj7AhfwCk7Tw18VWoKJt6ynT0x5nO079mCb0BgLfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YV0kbY39;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100516;
	bh=p/tT8T2wAOjsW0vSt53XIleGMxZ5ibgzQPbVrXy4miM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jOOr07rH7YTd39uSZmbR89R/pjsQnmfjPVV65LMnzwGMYzfcIGBqXqj1qNstLeQk5
	 vcl8SdIHQABuSWFDY1Heept+3inruUChu7128sn1KuclxcIW2eurX9bOm+Txc9EV5Z
	 skMSz5kCCVxxzNEmTn/F3+UjpbOoiX6uvPc6FnJ20LuJOgHdqpJPuHIjOzSwbmLlr0
	 xLvbimm7DL0iagtYDMkuV4hYDmJALkhQAR/Dz4MnSa0R81uXJlhBc8rKtqKfrFmTuq
	 h1Xvp1jbXFablCqeJoHtKUnzczJit6u9LJDD3KCGiSlWA+bpPSuQHX2nDoP/1Ocjm9
	 GIjRxzOyhVTng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C35B360766;
	Tue, 22 Sep 2026 18:08:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77E9912C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69E376069C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDPWfj2SCvBK for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AFC2A6067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100507;
 b=YhbzhznWzCajFd7z6mY++9gLvQIFccgSewcRHtmhyziwT0l1aV0QRLsrtWwONlKRycI2
 UeZedm1xiZ0xaj01n0ui1vgtp4TuaRU3SxxK6Xqbd8gCNDvEtXXSExpXPmshdc6c/lhdu
 ZKJEU5HkTV3LBJL5EN1NEXcWU0LBjAYrwF6lxkXskHIauB4rmzMxILfCHRuhm36vonutR
 XBTuiywTJvd8J4oZMpLYJhecnSgHmK4tw19Fwgx//wNAyxeFeWWB78r+RET//fWc2P9C2
 Rsr467Cr+WZYKsLGzLgPwsoKwH3Yc6F27SdFDOd7ljMrpqYU4gBmrTnfarTX6Dab4kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100507;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=p/tT8T2wAOjsW0vSt53XIleGMxZ5ibgzQPbVrXy4miM=;
 b=rkamsYKc7APhWMjD7+fjQZoaKaguJIcJvsctAKlTDI3C8T9QxUa7fyELTETITiGgZ2eC
 pvuL0mwixl/Jth62RUF/fNSYE75j0317aIlwBUONym1LOzcCP7VGQRLHZtEFNWnc/tfZ6
 Nf3xBbDrmmmyVuEUMgAD2Q7uq73we8q09kZSK7IygglII4IOhkCuwdny/D77kzw6e4/WB
 CmaL8Ia/4Cz7fnX6sh0DJnaZFE2lD/Vnhm+ElmttHPgEx/+HYKHL6g/dyh60C6XM4tmuk
 /Y1TYUUb2pOx+rU1Trb/UNFNG+78mlynsEzDut+k7+rC4XoFLAtc3qf2/k1Fw6kP+JA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YV0kbY39; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YV0kbY39
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFC2A6067D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100507; x=1821636507;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=vPWenbyyHGt72pia3E2iY9PCH1ARyceDooGNZ5KZsSo=;
 b=YV0kbY39QXtrtu3PmL1zJxDa3sj3/vF0BOHPmcDuFnOvThNa/a9vItrk
 PXHzXqGj7o/Z3xEzZ4ppoSf1dqIxXHMPJ4NPoyfkCoCTCm+J7XAeS66bF
 09sn8po/AMB+ZIl+GD0B1YxUiwNu9iXn7TskUDf48HAkKh1iKsChnwuFa
 tiZTJkXNvEyw6B3SAouz1Ww85x6sGGYRSIXlZnjINIM5t+r3GmKzX8MUg
 Q6aAISW3I56SA1BuiRUrAJGDIRZghcqGVPH82SDCcOaBWSmKu8deZi2tC
 Ipxj1xPhsgnjt8OowreLJt0A4vNPz/aDtB6IKwhA6ZqYoMSs6JMI/D2pm w==;
X-CSE-ConnectionGUID: 0GcMMJd5RQOkkt9L+WhSCQ==
X-CSE-MsgGUID: nQ/AWvjRRtuVMx/NYLULCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232037"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232037"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: CMnp7b2zS+m1KQ5NryrXdw==
X-CSE-MsgGUID: 3zC8NkJ6ShmPk7uUtAN+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315315"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:39 -0700
Subject: [PATCH iwl-net v2 06/15] ice: E822: flush offset verification work
 during reset preparation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-6-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=T1zzYwQG1f0nawDGBjFAXJfbTFuTGKQqNw4tAUKh1ww=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6UrfD4oBf5ZxGHN437n59/NXAI56RtPha+tu1a22
 +NlyhmOjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYy/TfDP82pcYcEAvkz76Uz
 Cm/PVv94qS/0fUDzMu8XL4T9tvzf8pWRYcn+jOBD0omumdz1RzLPhPSpm3IWr7GQD9p477THzLx
 ZfAA=
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

The offset verification work task for E822 reschedules itself if the device
driver is resetting. However, it may already be executing and attempting to
access the PHY when a reset has begun. Flush the work to ensure that any
current execution has completed and will see the updated reset state. This
avoids the potential accesses to the PHY state while resetting. It is also
simpler than attempts to cancel the work which could lead to a race between
the clock owner PF and the port PF.

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
index 364f0f389d85..fccea0511eb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3015,6 +3015,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_flush_work(&ptp->port.ov_work.work);
+
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

