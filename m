Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E47C98307
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EECD740738;
	Tue, 22 Sep 2026 18:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bcGj0r19VcYc; Tue, 22 Sep 2026 18:08:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4F15E40760
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100524;
	b=pVKHGPrHStjY94UqRomjVo+pIKWL+6QOJoVVY8GeZyRERIov19csTjZqy1zePzgzeMWy
	 mxCmlPAXG3Ju0Q13NFXFAc0b+ln7ylpZJYFCWQvfvhrKxq7Rq+w4ER/zrr+NRZUIL50er
	 sjxWPmN6zylZbBLILnvt0Pz5mdcx7yYtRHewdhbYqDp7/j0D3H9JtFxlAi/Pu2H/FRUhd
	 xwrgzJrRCDlgBxKTEMeH0BXp5h477NOOdazP+P1yMn2MTcHJxVVXYtn//A38xw+h/67sH
	 jBt8c5Y2xj47Lhx/5BaLRzRt0K5df/0b/Z8hO1+mzL5Hdr0idz1COEr0q6grs5YxzPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100524;
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
	bh=4QV005CvyRRpHR0Ul18iAk07yxHeosmWxJ0oYApAIVI=;
	b=obdzihTSNUMzi1elHgyU4WQMddq3Actvb23T9EP7Ut/M6Hi6f8x/tM55ixhDrls4Rxvf
	 8k/jgs/sCsgY8+W5UavzGrzgoM3lfqjfet3diX84umbENnNOxNGYlpINIW2pRnAeng6lC
	 6mbzaonaLu1/+iZMmHjMijyvI776/88MSIkfYeq906J3uTtbY40W51pj7Nlq/6mgqzxeQ
	 6KKFeFnEUikONF5KN1v9Q+6hc4CJLhG6FkiZULXKLo+Nkd1aQwPsSeld+amfCzGmpfVEA
	 aBXA0nr//tIorCrm8tP0Wx0/yxesgnzATc950uZMAcfPH2iPdwl3nSBvnJlUYTLFxdw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100524;
	bh=4QV005CvyRRpHR0Ul18iAk07yxHeosmWxJ0oYApAIVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XIFPBwiAoovOQ18NGggNxtQs1ri8JYC8p9ogmh5pWEjWOdlpHr4YlVcbjbAgyYYBA
	 Ml2R5bQlJr2hlddnR+UrtIKvvgrxBcWGwsxtqE5U7tgRgjpKZbkMPslit4eMxZIAgC
	 tXjM4/8gLcKtztMqavCcaG2fOId47OMYOdmNkn9OhFRqNKzLfQYy3asf/PMzkHBRe4
	 qD9oLBvBsQnqPPaJCxAh5K2enFvc0oTTHF/VE8ePebC0ey/Bcp9Ligv4hwKs3N0FTW
	 PUgPKlRKabjjhzd/4yYjMWbNN+haBHijHqRO3P3kG18zUxu7C3Xi0I29G7EzqLDSKH
	 quc4AMUT1p2Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F15E40760;
	Tue, 22 Sep 2026 18:08:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EEA23A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4380A6067F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TxJwPUFNih9x for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 748CE6067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100508;
 b=mDqkPC6TLsTzhTER0oNZlboBwGiClQUjchg34ttvcI9fMrUjupUFDeYbzUAf4mG+rP6x
 UA9cKdQ73EnYydRjz45y7JItH1nimAqZLXKKv6+2N5acjC0WVVC3GQJQgyBe10xlvGraE
 yRRnNOE5O0jY2Gng1KfgE8UBkSB7pAjHTrUQ34NcnTL8WM3phxuWgqNmxGi+egpKFG1nn
 9KIwgYYU9KxxJOgH6CCswKXYWN7CLyrrgjUVl+9Q2DgyH+g0/FUH+4I4HAKJB7Vy8uSOD
 YuQ7+mQVNOj2zK0aJz2FUOFm3fsx6/u01SlW6BsWQkGLjfUATfQfSV6PC48zpurcJbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100508;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=4QV005CvyRRpHR0Ul18iAk07yxHeosmWxJ0oYApAIVI=;
 b=cPR/XfM7vsWglVbeM4QKzl+HT/s0IZOSLGft5JFAHWV9eti+JzRRR76aqFB/Ornuf+hA
 HkXJeVuyK6BKS+dTHCBIC7YGh9CjVzIi/kp37LLepyt4DqlgmyZW2ux1GKGHkgpa7pA3P
 xEx6MVLXZFv+6pIpR/5f4wkMRSEdC+TUXIdTtzr7e7O7zhb3/P6hE3xoXnPbFPIYORhTU
 tpAxZsxDFnP0rPRv2jHoq+kfOi6CgcsOABFryAH/oHs4h/uPi9HjPNM12TrqlLgHnM4Xd
 w6N8E1c3xnc9uiD+RyOPTQZ+7HaLR5/xMY1BADrGeAmdVt6T+yvH9+DV1AoCOLUIq5A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Cd6+q7uT; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Cd6+q7uT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 748CE6067D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100508; x=1821636508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=6nhRVeugXM/x6MkdahXqvJ2zeV+JEexQyuU6Fv3el8I=;
 b=Cd6+q7uT/p3gF2OVdBSBQGjMvW6gHHGLmbEzV5/XfxIhV/ISlax5btxZ
 /R7kELKuGMelcxuTTyvB2ZXIBxw3jihbPzYndh6I3b6iV5F5r2pF0gbZf
 a1+oDpS7thv/DqsAdzH9bajFLdZEYP/ig26/bICij1/iv/darh9kf1Tfb
 ikqP94ku1BWBdsbjReXH0WlQdEZcH6qI61P2lCce4brOoKHpxIQhF9JjS
 gFDwNa/lZXyN52zzUS2PVygygmE5R8/77EvxtyqbpM+ce06Fd5GNk29Uh
 TcRkIiDkwC+JHP2wcNj0cWyFuomUQB9QJhlV7ihmAZlaGdehHZ82fJhcx Q==;
X-CSE-ConnectionGUID: MjruHCUbTAONqxwf5Ica9Q==
X-CSE-MsgGUID: 3ZDEJl5CSimUSLFxrLj6zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232063"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232063"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:25 -0700
X-CSE-ConnectionGUID: pdhMvi0tSVyh9SHyrrH8GQ==
X-CSE-MsgGUID: Kc9oprq4RD2o74V4JtZrRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315351"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:48 -0700
Subject: [PATCH iwl-net v2 15/15] ice: Recalibrate PHY after settime64 on
 E825-C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-15-e55b692d0e6b@intel.com>
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
 Maciek Machnikowski <maciej.machnikowski@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=5vEYcy1CyOV/oMxHrdhHXVQKWNr75ORGp4TjTOfrtLQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2X9oha+Pd/Y1nj64bZzHkcfrFW5qnI1J9q60ngbv
 +h784V3OkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZhItQzDH07dex0BH4LuMida
 Nq6sYjjULdN1Wems6TbhMobLZY51xxj+p23Xc9OVPJo4O7KPcxfXxZ2vgnI4O9snfNzzr+6y5+x
 QNgA=
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

From: Maciek Machnikowski <maciej.machnikowski@intel.com>

The PHY on E825-C requires recalibration after large jumps of the
system time. This step is required and is done for E822 devices
previously, but was accidentally skipped due to oversight when
E825-C support was added.

Lack of recalibration will fail to converge quickly as the effective
adjustment requested is not applied properly to the PHY timestamps,
so the readings from the timestamp are incorrect.

Without the fix:
> ptp4l[12591.505]: port 1 (eno8303np0): SLAVE to UNCALIBRATED on SYNCHRONIZATION_FAULT
> ptp4l[12591.951]: port 1 (eno8303np0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
> ptp4l[12592.027]: rms 752851973 max 1102277559 freq -84408798 +/- 53560133 delay  6009 +/- 92308
> ptp4l[12593.038]: rms 91302045 max 136894784 freq +100000000 +/-   0 delay 93700 +/- 24153
> ptp4l[12594.050]: rms 16036314 max 35711594 freq +47433070 +/- 46746070 delay 44899 +/- 45255
> ptp4l[12595.061]: rms 5558880 max 12292103 freq -13092285 +/- 6627317 delay -13499 +/- 6560
> ptp4l[12596.073]: rms 759533 max 1081638 freq +837063 +/- 802691 delay   711 +/- 979
> ptp4l[12597.085]: rms 60485 max 106800 freq +146706 +/- 263535 delay   145 +/- 263
> ptp4l[12598.096]: rms 16428 max 41896 freq -46707 +/- 34325 delay   -40 +/-  34
> ptp4l[12599.108]: rms 3049 max 5356 freq  +5337 +/- 1730 delay     7 +/-   2
> ptp4l[12600.120]: rms  284 max  381 freq   +104 +/- 759 delay     2 +/-   1
> ptp4l[12601.131]: rms   42 max  119 freq   -124 +/- 143 delay     2 +/-   0
> ptp4l[12602.144]: rms   11 max   25 freq    +39 +/-  12 delay     3 +/-   0
> ptp4l[12603.156]: rms    2 max    4 freq    +14 +/-   5 delay     3 +/-   0
> ptp4l[12604.167]: rms    1 max    3 freq    +15 +/-   5 delay     2 +/-   0
> ptp4l[12605.179]: rms    1 max    4 freq    +16 +/-   5 delay     2 +/-   1
> ptp4l[12606.191]: rms    1 max    3 freq    +15 +/-   5 delay     3 +/-   0

With the fix:
> ptp4l[12834.266]: rms 27178238388098 max 30079328952737 freq +479164 +/- 1040869 delay     5 +/-   1
> ptp4l[12834.522]: port 1 (eno8703np0): minimum delay request interval 2^-8
> ptp4l[12835.315]: rms 86919 max 139746 freq +111289 +/- 539214 delay   -35 +/-  28
> ptp4l[12836.376]: rms 5415 max 8884 freq   +579 +/- 22798 delay     4 +/-   5
> ptp4l[12837.429]: rms  335 max  559 freq   -305 +/- 842 delay     4 +/-   1
> ptp4l[12838.471]: rms   20 max   45 freq    +79 +/-  33 delay     4 +/-   0
> ptp4l[12839.512]: rms    2 max    5 freq    +44 +/-   8 delay     4 +/-   0
> ptp4l[12840.545]: rms    1 max    4 freq    +46 +/-   8 delay     4 +/-   0
> ptp4l[12841.586]: rms    1 max    3 freq    +46 +/-   7 delay     4 +/-   0
> ptp4l[12842.637]: rms    1 max    3 freq    +46 +/-   7 delay     4 +/-   0

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e654f8962d13..b9018d8940d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2072,8 +2072,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	/* Reenable periodic outputs */
 	ice_ptp_enable_all_perout(pf);
 
-	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
-	if (hw->mac_type == ICE_MAC_GENERIC)
+	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
+	if (hw->mac_type == ICE_MAC_GENERIC ||
+	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_restart_all_phy(pf);
 exit:
 	if (err) {

-- 
2.56.0.rc0.395.gd1f3524e15dc

