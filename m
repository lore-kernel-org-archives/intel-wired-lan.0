Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1E8C61DC4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 880774072C;
	Tue, 25 Aug 2026 22:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F-gK9-Y3DpdJ; Tue, 25 Aug 2026 22:55:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787698509;
	bh=n4Cf8r8a2vCAV93ZnLjFLfC8M0khZAJS8I4Awx4TGjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8DpSGjvcL4sXHtDoawPQh+WAl0gMm8bYdixAUg6n6IcofyWzf+WmwcRCHOb0QcLJ+
	 6kXZYDfdQlklMqxof+Io3LzX6MgzXhRFtrIlvAJxb5YDSXAjSl0cCFhz4NWMFURg8m
	 7AVSY3ZBAYjaWqXcfW9F2F30PIL9JJsk8U3NG77/DlOVhqcQXYGlVrJ5k09BUTMHd5
	 sGWwQlbRaANjQwSQJEGunzoRYMuCJiUkxhhuNumrm0famyM2htKrJ53ivjr0yVJhJD
	 /o1yaYO5olRX91S65eoF9G8m3wxEy1kurtLcx9pG5Ky48dgwIcSHoqIm1X77YwfwRH
	 i1pgOXO9EkYJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80346406DA;
	Tue, 25 Aug 2026 22:55:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A525334
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C48040629
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqq5dJGwmHbm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:55:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dth9OCyp
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C299406E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787698506; x=1819234506;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Sjg0PSFVQgrhpJweLV0+MIJmWnIEe9kamjhvO9C0ZoM=;
 b=dth9OCypjEwZLvaEG3EsiZ2cBsKMKUv/Y5HN62AkWDScVjcRyXbI/jjc
 g0skUtSsxSE25LMWB47fXHGyma4trxB65Q/DzVPFU/r1KPGxTvXBGWL3c
 C/ClS63PTv4Ak3z93o4ipUHFofF86M6ny/K3pLhAjtF+alM3Q36Ve4zFf
 0vPo1IL9MGvpndQT/FLZamx7V3UpvLILppeZMZm39+gNuy4LMACEs9inI
 dWhZmPfrQKADm6nH52FpgZBtOB83468Ec3zAql8rUzStgMQ/F4PotFWmm
 yEwrtcTkU8I5qjO1yX0fvSgqERzk8yqflLJcFbJvVFmuCjZ3iSU6hj9hi Q==;
X-CSE-ConnectionGUID: duRvnTmFQ2uaIeIsAW0S7g==
X-CSE-MsgGUID: JKr9Osu1Ss+nxpEm+dGUWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120418"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87120418"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:05 -0700
X-CSE-ConnectionGUID: 1lZCFVuiTY2uzgT6BDM2jQ==
X-CSE-MsgGUID: wsjPO74jQVi1prKCAk8FBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="264789664"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:26 -0700
Subject: [PATCH iwl-net v2 02/14] ice: fix removal of PTP timestamp tracker
 during reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-2-8223f95d26e3@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Sjg0PSFVQgrhpJweLV0+MIJmWnIEe9kamjhvO9C0ZoM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+Wev4y33bzzpsMPuTv84+cZ1LtfX8lop1B1dqRwY8X
 Kosu3VWRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNxWsTwz+B7trP8hfK8uS8U
 Odf8z9HY5ybIyGpy0TRW/Os75yBfQ0aGL99ND80vO8AhOfnszuMXjZmiG/hei15eVv6fo09GZXc
 VJwA=
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

Commit 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker
during reset") intended to modify the PTP reset flow of the driver so that
it stopped calling ice_ptp_reset_tx_tracker() during teardown and stopped
calling ice_ptp_init_tx_*() during rebuild.

Unfortunately, the commit only removed the calls to ice_ptp_init_tx_*().
This fixed a memory leak in PF reset. However, now a CORE or GLOBAL reset
will leave the device unable to initiate Tx timestamp requests
indefinitely.

In practice the CORE and GLOBAL resets rarely happen in production
environments, which explains why this has not been caught until now.
However, it is trivial to verify by triggering the reset from userspace via
ethtool. For ice the following command will trigger a GLOBAL reset:

  $ ethtool --reset eno8303np0 irq-shared dma-shared filter-shared \
                               offload-shared ram-shared mac-shared phy-shared

This was found by Sashiko review during feedback for an unrelated change.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
Fixes: 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker during reset")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b12181b8c843..142d39ee5cc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2979,8 +2979,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_perout(pf);
 

-- 
2.55.0.814.gc42f45431d0f

