Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A83C9832A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3D4640C88;
	Fri, 25 Sep 2026 23:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cr4X9O0iE-9f; Fri, 25 Sep 2026 23:58:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2ACC340C8A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380700;
	b=Ak2iKA8iPyM+lESrW95G0okcToHCOALumInYYv55AOGnNV86VFqeHCGrzL29WspMXzmP
	 u0p575AJ+FtBZbsp78oQsaLpMNNcjl8IYSsiwTWd6Il5OI9LpgHgQdFiaS97sJaT2aPaK
	 h3hXsmGywWcCpEzUP+euGIkC+JjB4Movp4gU2dniYTJF+2O+syXEIF5u9iyrhoHwieH5Z
	 4KnWnRPWsS1mxrR+C/H8FKeRhrJEDFgWtmW2FiZroyC+cOHVLkXrx1GYQE5zsDiXGj0CA
	 to4ObLAJEyZsC6knfAHvUYagJzvymDYxPULll2By3VbEkwvp0kmnbvUoRYa4GBh7Csg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380700;
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
	bh=/PAhe7BrQ33OTpntkbZOL1cDKokt21iQdq2XxYEr1W4=;
	b=Qf5Haw6PfU04Bho9kVdMLq5Ax5BTKA2/X8SRI96H8H46RttAu4gAms/nz14h6MyuNAQ0
	 NQXByMB+jvI3zWA0/2XyvoYkOOXsVkUQQ1QYFmxz5rLiDPy8AWTnI4KsQLB5yWL7g/AoO
	 4Fe/Nn5+1lS0LZWi67Bpl6IVHuZK2UiJxyAKxnkp+c/ltg+yG0CXPgrb5xV8jKgYR5Oim
	 WaOx5Xc3HBmzqgWDsmjU6YjDg0JBHfZrlRJdHqJJOZOGeEqtj5vGCB6qMLWEM2COq9ewf
	 +iTzPyfb30eCJ8YfXoaMToGoJPqgmM3fq4JgJ/LAQcYbBvz69IHoy6wglFa+KlhuDJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EyvbV6BH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380700;
	bh=/PAhe7BrQ33OTpntkbZOL1cDKokt21iQdq2XxYEr1W4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mhsogZ+k3Ut/CzibWPZT1X6dHx/y5p+/lQbfJXlSnmNI79h1zbfuSPkInWUv8Q5sa
	 NzGI594YfUo1eHyJd+cXap5056x1/+2vsbC/bi/4xm+yhlfybpePVR4cAXl1kzuJi0
	 F4VTAEaUmH1TUwyufgyCufbVaHJS+jRNN2gdYLG+IX6goTLGNcmai2E6mSAdjL2OaA
	 Yfb7r3jkmQ/6kOeb1O2m4nAmwHO1nanau2IvpSDhCIhZym6ZP4kffUB98LbS6lXewA
	 zIoPq+vjFmBNgh/ihAQMgoDsdh3weN6NkcN/WAK7ymR2tUFU3grOrZeNoWNND/Qg7x
	 VZjThr7Z/nPjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ACC340C8A;
	Fri, 25 Sep 2026 23:58:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7F17194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A990040B46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uliGgAyZOTQg for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CA08F40B6D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380687;
 b=DLbbn6m2f+iTE3OPmfuSng3QmeTg9fiZh/vRJCWM7NtX4sc3QGK2MX6tn0EAQndnJXZQ
 do83uM96mnxdEtjSKTA9+DTReDhwDJG04GeCYosnSQOMgkrfiaJDzEX+7jnHzKnOFbKDT
 0UwrH8JJSp0V2ysBeCiNnRkLcWlxI3Jc+KHs0t1B+6u4MwKVugycI+ioM9V7kaVICZsoF
 8tX2o1tG6+a1esCgDM06/FqYBEPS11QS3HPLeEbfwA514WuEcEVi6J3JnXgLT9iz3L7m/
 EDGY6oCAr9+aXf4lVyxr8trsmV5PVF+yrYsT74Jxs1FjSfnGE5NhpQI8+EfLHjDxCYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380687;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=/PAhe7BrQ33OTpntkbZOL1cDKokt21iQdq2XxYEr1W4=;
 b=Y8MU2LkGnE8wyWbJRBQYO0Cz4+pH9aGSCPbBmzMTpMNflMaRCMkFAosxA9/TeTyliQH8
 HKaY3tr4OctVBcR3n3GdarIe5u3oglfmQVf+/meTzDyNrXBQ6KqaZ4F7glPGpzm6VAIP8
 LwuiZvoOkeLTmbEKSjMLRcJ99nslYV6AH6IjBy7JJAtKyxZOhvN1lT5sGWt9F253n59fD
 li4+sixzjVdExqGa8dcG6pzGVjcXoXp6Ls1sNTOkJVBeE61HsVGcsdT2aEsqL0QmAXOnT
 sY4G8wUpvrw9dyXbGjeRz6w6fn4G5WBKkrdx1uG5CvI5ufWuhXt+ZRb2M0UQFiAZLAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EyvbV6BH; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EyvbV6BH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA08F40B6D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380687; x=1821916687;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=tbAusHiJzKJIVC36y8n9gmAxBZt/yk/gKm8DXUQQJYw=;
 b=EyvbV6BHy92oBipzVfWsChxKdcFLyJl8UCf5d+hQ7VWPEt06idEw/CMI
 lfVLdHaW1Pp4rwuXseP5xrpMV4omPAzDM1i+CfrhVTNoC6dv3jbTFMYex
 XbR4VRjXpgBvyn7FHFIdLPcYdEbAdYlqFdXE7bzGnEcE0h0sqIPoPbi37
 +FiKYJomcNmAEWIOE/0EInSD5hEIlp9MlyGw/FN+B1rCgYY2BIHFeYy5m
 KtY6uk+OhDm3l8ecvJ/4FmDNnnTyi5DcF78CdhRfzoaM0035296Mdn6wK
 iuIsesXxLjUV1YcqRo5xBp3cSQeZdju17v3jdVeECIW+QuW9yM9eL57Zo Q==;
X-CSE-ConnectionGUID: 0gW5URT/TTeqTpA4pZ/14w==
X-CSE-MsgGUID: gDgK7CalQOeCWu2JlexOSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212821"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212821"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:04 -0700
X-CSE-ConnectionGUID: 0P5v0ebMQqSTIPtZ7ZThdw==
X-CSE-MsgGUID: oP88gOiCRXG+FM4aq3rp1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731145"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:47 -0700
Subject: [PATCH iwl-net v3 15/15] ice: Recalibrate PHY after settime64 on
 E825-C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-15-6532598e8da8@intel.com>
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
 Maciek Machnikowski <maciej.machnikowski@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=XJYnGOIzMrOMQ/LcUzFdKbpZXkVUbFwdfMxUeBc7hyU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXDUq3rPFixlbAmsuHH+tH7p3xd0NP74E3rzfbqXXL
 dLmm3+ro5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgInY72Fk6H12fNvKJ9c3HDO1
 nfxZXjrFUuCnqv9NNjFZI485n6KaQxn+x3WJhrKE+TB/fFyySUn4x0Y2hzM8ZyqY1yyaMnPJ9v3
 anAA=
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
index 8d302b500a39..a5fe05d70461 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2086,8 +2086,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
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

