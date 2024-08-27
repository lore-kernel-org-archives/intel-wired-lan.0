Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C190DC54735
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Aug 2024 21:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C0C0406C2;
	Tue, 27 Aug 2024 21:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7rE3lG-cUk71; Tue, 27 Aug 2024 21:53:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBA134068D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724795586;
	bh=3yXTBGfARulLLnTzWPWjl2ZGtQGVoWcl9QFB8lKIW4g=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XFPMWPKx1mWkb1ElaQCBiIV2YhzKM94N2JpyuIHFtzqVovYwkr+kHP/uwI5aBSquy
	 MfwODRbmA/byYWDWwZlrsUehcZ8k87IMEddKVpTvFWtbN21F/lbdrxWCgLzIbPnmjk
	 MNqPm6XSVhkjsECuj74wzhDmD2y2QVLt6j6MXAi1Ce4+20Fde7tWPtBwFTYyf7MoCG
	 VoOVS3PaDfDl+utUoSGZUUFKkeVT1mIyRpbN9WQ4zcmv9vvyjES/0Os4HfI6nKwOGt
	 3/8W5HrlVNRQGnoQ9spbKSeRpSdt77+MN8eeqsySYR4hZENuccg+tuK4pJbiH9XJvC
	 9jW7wpnF9DaZQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBA134068D;
	Tue, 27 Aug 2024 21:53:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 110F41BF27E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Aug 2024 21:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8ADCE8114E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Aug 2024 21:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4G6stuhwQ8Z for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Aug 2024 21:52:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BAE8281158
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAE8281158
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAE8281158
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Aug 2024 21:52:50 +0000 (UTC)
X-CSE-ConnectionGUID: CZXVNtjbQV2/tO2zSb7sow==
X-CSE-MsgGUID: TrcEAPJqRW64H08PqTkzzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27068838"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; d="scan'208";a="27068838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2024 14:52:45 -0700
X-CSE-ConnectionGUID: eimqqPf1T+Scm62qkUr3Jg==
X-CSE-MsgGUID: RytFG4q/RPibftfHYSclEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; d="scan'208";a="63189486"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2024 14:52:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 27 Aug 2024 14:52:06 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-e810-live-migration-jk-prep-ctx-functions-v1-3-0442e2e42d32@intel.com>
References: <20240827-e810-live-migration-jk-prep-ctx-functions-v1-0-0442e2e42d32@intel.com>
In-Reply-To: <20240827-e810-live-migration-jk-prep-ctx-functions-v1-0-0442e2e42d32@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 "netdev netdev"@vger.kernel.org
X-Mailer: b4 0.14.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724795571; x=1756331571;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=fVvWWmc//evEZHcKzlFxreA95ao/xY72CyoACOvZbMI=;
 b=UQnojb/Q56gwF/DZ4GgPdYoi2QN8jkVPUge3aG9sgskktTRtG2Kd5Vqz
 Gwb6SIwT6lV1iCoEecwWrttRibiXQyKgmp5ZRScQ/j72YjL/sBw+adGF+
 ONBc8WUwltbe9VnxRNN4wtr6laSbnEYs1D3P1ni46CzGlcMVY/WwIiK4y
 tk2quqNmddNm6mNG1PycC8rHeUgyibjMpgCYpoDo24sdLDPqUy4kjLd9c
 1rbFqI4MEGXZ1qB46IfYpkirrp6KZbHhCEynyoN48/CMkFWHYP6fCMEo0
 7HQraPlWDNc3jF+5//ZgxyndJrGyW7cEtTy8DqzhKryxJltDvLR4WcRnD
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UQnojb/Q
Subject: [Intel-wired-lan] [PATCH iwl-next 03/13] lib: packing: remove
 kernel-doc from header file
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

It is not necessary to have the kernel-doc duplicated both in the
header and in the implementation. It is better to have it near the
implementation of the function, since in C, a function can have N
declarations, but only one definition.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/packing.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/linux/packing.h b/include/linux/packing.h
index 8d6571feb95d..69baefebcd02 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -17,32 +17,6 @@ enum packing_op {
 	UNPACK,
 };
 
-/**
- * packing - Convert numbers (currently u64) between a packed and an unpacked
- *	     format. Unpacked means laid out in memory in the CPU's native
- *	     understanding of integers, while packed means anything else that
- *	     requires translation.
- *
- * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: Pointer to an u64 holding the unpacked value.
- * @startbit: The index (in logical notation, compensated for quirks) where
- *	      the packed value starts within pbuf. Must be larger than, or
- *	      equal to, endbit.
- * @endbit: The index (in logical notation, compensated for quirks) where
- *	    the packed value ends within pbuf. Must be smaller than, or equal
- *	    to, startbit.
- * @op: If PACK, then uval will be treated as const pointer and copied (packed)
- *	into pbuf, between startbit and endbit.
- *	If UNPACK, then pbuf will be treated as const pointer and the logical
- *	value between startbit and endbit will be copied (unpacked) to uval.
- * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
- *	    QUIRK_MSB_ON_THE_RIGHT.
- *
- * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
- *	   correct usage, return code may be discarded.
- *	   If op is PACK, pbuf is modified.
- *	   If op is UNPACK, uval is modified.
- */
 int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 	    enum packing_op op, u8 quirks);
 

-- 
2.46.0.124.g2dc1a81c8933

