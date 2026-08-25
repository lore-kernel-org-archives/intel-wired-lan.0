Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396DAC61DC4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EE444072C;
	Tue, 25 Aug 2026 22:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KkG2iBb84O8c; Tue, 25 Aug 2026 22:55:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787698515;
	bh=v0Mnqddv/Dlc3aReOP0LKlOiBXJu9CPPX9apz8BkxhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZN1lAKJmdodgjCupdE1+Y3LZrCdq+UGix1uDLYhQhkJ0isi+RJ/rwVmDCcS1qZ+Ez
	 2ASM/XWLeKNHSrHmIpiHfWgeHfkst/N2ww6rGwdbkIakSqSfEYkaC/vSoFBmaPMnpa
	 AhmPxeVZYyl3fmWId+v9rJodOLOrpfifzC3afxYlGLHLqaQiouzJ+lOKT63XRWKCmK
	 BxIXRsRNJX1g5OmI2gnioyteojo4KQVC7+bJgMWunzhgxV2aPJ6UEYNY3rxgmpoLHd
	 oB4SYRpz9F29gFlUhGCVXCdO0TX5Y+fvsDvE+KVMZzgZ4WRUiitkFkqQN9gQPganqA
	 0qFQnruwIsifg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E27C40746;
	Tue, 25 Aug 2026 22:55:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D92668F1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEE5060740
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDvTz-pUwHXp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PlSf2fvl
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7B006070D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787698508; x=1819234508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=RRgCM1Jt5ZKW3xOnkfDLQfBOMA02Aj+2gZ+Lbs4N+UU=;
 b=PlSf2fvl2vil81DFyRQE+o6Bo+HcMmH+XAxYtYebLGma2Ku6AjQpiQRJ
 KbHwTr4BoxQ0m3/1fuUzc6E5Ut+lTdv1F36jyQrgElMv+ARO5BpBKugCp
 djUkLkzOF6Vcj/I9GQnYgGFMZPmxI7l+GnjW761QjvW9lU/oDwFo5+f0A
 pl4BUTKgAOkKJBCkxVyB32FQwgboC85Qw3ZA3C4idRwDsE5n9jbvfIpTn
 sC5Q58URbQ2v0lTiW0UjA8lcHB1Si8zCwCTK8xJKZi0lzGP1chkIkR2UY
 eAk7/R9/oWrOcpgmpX1aQHZz1fcrIT1gYe35QcIc9UL9in2K+xMmFfRjR w==;
X-CSE-ConnectionGUID: 76bmko8lTQC+snTKVi9Y5A==
X-CSE-MsgGUID: qvhxTS+cR7KJZr1DGPO9NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120453"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87120453"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:08 -0700
X-CSE-ConnectionGUID: qIV6klrbQoqQUSQ2WA8HJA==
X-CSE-MsgGUID: gxswPdFiQ7SawCZYXOkmoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="264789704"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:37 -0700
Subject: [PATCH iwl-net v2 13/14] ice: skip reading Tx ready bitmap on
 ports with no timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-13-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=RRgCM1Jt5ZKW3xOnkfDLQfBOMA02Aj+2gZ+Lbs4N+UU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WbvyfEubqy9CUn1cs6/PFdHOecUktO9tv5O7k1RVo
 K3dprSOUhYGMS4GWTFFFgWHkJXXjSeEab1xloOZw8oEMoSBi1MAJuI+neGfqXFUqnViyZNeye2V
 zzoSy0L3rRayaJjAeuWnW4XEtGxdRoa7n/q7OVe+DNtb/0nszIFTr6b6i/t+fOPuJ2Up0C3j6MQ
 DAA==
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

On E82x devices, the interrupt for Tx timestamps are handled by the clock
owner. When an interrupt with the Tx timestamp cause is fired, the clock
owner PF iterates the list of ports and checks for timestamps across all
ports.

The existing logic reads the PHY timestamp ready bitmap before iterating
the list of in-use timestamp indexes, even for ports which have no
timestamps waiting in the software timestamp tracker. This has a
significant and measurable latency impact on reporting Tx timestamps.

Check the bitmap and exit early in the event that there are no timestamps
waiting on a port. Observant reviewers may notice that the check is done
without acquiring the lock. This is fine, as the only thread that can clear
in_use bits is the miscellaneous interrupt handler. Whether the thread sees
or fails to see a new outstanding timestamp does not affect correctness,
only determining whether or not it should do extra work.

Using the ice Tx timestamp traces, with a simple ptp4l setup the average
latency appears to be around 175 to 200 microseconds with a few outliers
taking hundreds of microseconds to be reported. With the check to skip
empty bitmaps (and thus skip reading the ready bitmap for inactive ports),
the average latency drops ~50 microseconds.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8500e9a5b047..96e96ba1731d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -573,7 +573,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.55.0.814.gc42f45431d0f

