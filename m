Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89315606A32A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vnPRTzgg;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kc9AtqBh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 627A740688;
	Tue, 27 Oct 2026 17:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVUqBJbVbqGU; Tue, 27 Oct 2026 17:45:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A820440760
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793123109;
	b=IjrkiywUbMP66t5Wj6j9+sBkIpE173029vb0w0U1Rx0LQ2kmpMkEewB2eQNq2Xpbgx0L
	 0HHdX7dzYU4TCDBDA7vB/LDuoL2qK9LTV3ZKKK63678kGHeh49yzifeLnPTZDKXsbPnkU
	 Tc86QG9VDt5skyCmZOIwSBFjIEAmsH+9RD6kCCRUK8bCZsYxps10yBECNfeembTicLxe1
	 Cgj8K/p+Xj4tqJaYBEsBwRao8wl0k390yjZa8y7mRffNeIcY0xQYHpUVCh8r7/xa0BO84
	 iXjh1QrM5MHFDydEv/Ys+waLyerdw2jfCUywMawqOsggQm1NYcSaphxmaaSo3Emw22w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793123109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/TR1bViauvjwZaKRF05t5oo7Kw5H+7ikAqOV4mWdZ7Q=;
	b=P6Pr/ilE92kKmshnhK/0G96YMhnu2PebJvAvpBOW9rQLLfnIBHJ0D8j9zzz7+J6AqHUB
	 ZHU52DLPclR7zhwDHx9IlP2W2vmv+o7TTlKwYntQk6ffNrlt6tk8X5Ec2Td6Db7vphm9T
	 5yZeA/rq6gpij1C0i5lfKFCxdL3ZxqPLRaByCZsOSKtKTc6LC0RP8KO1lRXwYEwv0DmFA
	 +3ughxpaDw8LzQFGwyRZcTa/m7Tx8mZN1Na2y0Yc3QJjYyNOBYBqZ8Nwrdz5H+AsXRB6a
	 ledfpSnXLQqRALvoSxyaSnlQg6o8hf9M9hr5C/6IsBeahkOhRMos9Otp7u31NmowSgQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793123109;
	bh=/TR1bViauvjwZaKRF05t5oo7Kw5H+7ikAqOV4mWdZ7Q=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnPRTzggD3TO+5GAR0FNYYmOVkbE9S06nc1DPPp6xVz5+XCofwiJZ29WENrBw6/uJ
	 6wgdg7vXNn6w0LXvusut4XphwlwHNiHuFvhS6pohQMCW+E29HV+2FqcEdcB3O2aVvu
	 gnH0cEyR4aHf9MwGNilcR92t1Vrx9UBDf354v3dhSgv4Sgartxk+jmePmMw6HhctrZ
	 MJoneXkQnhsowzV9qdVKW2h2hzXE5d4aipVif+XKChtYn+kKs6vai4/3/xXA8kb4na
	 RQ03rmlMomAHwlSRhZieKuF9znDe7rAzdsSiJzvnce07j0BAqoMCLEXRu7L28p1hW7
	 rGWAT9Qi4OL7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A820440760;
	Tue, 27 Oct 2026 17:45:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39618235
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23D2F6068F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8msJNJXgUWE for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 17:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51E3960699
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793123106;
 b=snOWqipFBoO33zKdA55NVS7pdn/rqqstTLEbj52SANp4lmz6e3IpHWKIM02qkhclNTM4
 EIZXB4eghgzXbAXRT8v7v8ThiUBtmPhtEsm4YDJb0VkXOMjYV/q/xPuhtd9u322AUhiwv
 ZNl71D8aVw9FCTzNImQ9fOPEI3HMBZufalqPVLaEI8fblz5YXIb8kjJ+lQ64OQAwBrTro
 IZtrXwA4QozYtCtTxaNtGZAd4L6xfiARhWVdhJRX7FC5Yi+nwK8AFoJiQiy8ngLqSapy7
 sDztctWoIIg7Oa5A9ZPlJAR0INJzVlVPRZV7Tg/d/BJs9XAKIp21545BrHkmXPpWWtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793123106;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/TR1bViauvjwZaKRF05t5oo7Kw5H+7ikAqOV4mWdZ7Q=;
 b=ZClPyzM7KODioFzeaF8BL5QQSZQ+8YnQMG14lDai5MQ4olcfsuEprr7TgKCnwbxFMSqG
 xvPuV0Kto32ZCcSRnbVtc6Ez3QCzOQWA+aWRE28JZHw/5wft+St+jJkIpcvKSlkM/lGPG
 g33nBf75QsG/T/Cr/SDpDlJRvR0StUClz8+Wt0JklbhWXc2I7GnOfLh3G+Dl4Y6o+8Dv/
 RJeH8u0Hz28J/277PetEdPSD5d95UvwlPugRAEgo9rz+ny2PQ1a5BGrQjk8xMHvW+1/fl
 Jt9XnS7eG7hsRYEXYXoFfd6KsbnmKan1Df0r7/XRr3iAD7aLUb4MkSmBXHkaMlFNeaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kc9AtqBh; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kc9AtqBh
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51E3960699
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793123106; x=1824659106;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IpxMtbW849ipNY8TGlXeddECebWR+RUA7VcN2pOXP24=;
 b=kc9AtqBhTch0ZfQeDVnELakpZAIS0x/BiEk94D6E7aYIXjTiyPj9Ljxl
 9FgRRTQUEENJ4QmxT37SHCmDWucNNPZ4CW1VuDvr5YmVGOMzx7Z3nwDO4
 1lC+2DnDkIQa94DEtuGIuvl+MLuzF1afjYr9x4OmPzc8Bv9+NLmtHwGcJ
 NyBM3kB7G57yf53tFktSTYEri+VYs6xGLap964xyhshORfYCjfbrNRAOU
 hbv4cgb4KTdtONL91hghMhBEL6iS6uTwPgjK24YWbd9s00Q2QRVNb6VoY
 tzvFEDdCLR434tdwEgqPkqMA3MtNEsjX5cYbr6/hSn1hkeNaTDPL++uK8 A==;
X-CSE-ConnectionGUID: Zu+AmlmgT2ej1XracW9Yag==
X-CSE-MsgGUID: ZHDbS/Z3QtCdAUJ2FsVe2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1713380"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1713380"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 10:45:06 -0700
X-CSE-ConnectionGUID: 5H9MTuujSKq6UNYmBslcNQ==
X-CSE-MsgGUID: 4dUS1L77Rey/Mtt5Ubc4dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4685707"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa006.jf.intel.com with ESMTP; 27 Oct 2026 10:45:04 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 1/2] ice: parse external Root of Trust capability
Date: Tue, 27 Oct 2026 18:45:01 +0100
Message-ID: <7d67f40ea838a9b9e363a26eded23deef8a8ff6c.1793119681.git.aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793119681.git.aleksandr.loktionov@intel.com>
References: <cover.1793119681.git.aleksandr.loktionov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reserve the external PQC Root of Trust capability ID in the shared libie
capability list and parse its value into the device capabilities.

Firmware reports 1 when an external Root of Trust (eRoT) controller is
present and 0 when it is not. Keep a separate bit for an explicit value
other than 0 or 1, so the flash path can reject an unknown answer
instead of reading it as absence: an image the eRoT turns down leaves an
erased flash bank behind, so guessing is worse than not flashing. Set
both bits with |=, so a duplicated capability entry cannot undo a verdict
already taken from an earlier one: an invalid value always rejects the
update, and a mix of 0 and 1 keeps the eRoT checks enabled.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 7 +++++++
 drivers/net/ethernet/intel/ice/ice_type.h   | 3 +++
 include/linux/net/intel/libie/adminq.h      | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 81187214..cc387c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2482,6 +2482,13 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 	case LIBIE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE:
 		caps->tx_sched_topo_comp_mode_en = (number == 1);
 		break;
+	case LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT:
+		/* sticky, so a duplicated entry cannot clear an earlier verdict */
+		caps->external_pqc_rot_present |= (number == 1);
+		caps->external_pqc_rot_invalid |= (number != 0 && number != 1);
+		ice_debug(hw, ICE_DBG_INIT, "%s: external_pqc_rot = %u\n",
+			  prefix, number);
+		break;
 	default:
 		/* Not one of the recognized common capabilities */
 		found = false;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 4b6ed42..1ff69f7 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -311,6 +311,9 @@ struct ice_hw_common_caps {
 	/* Post update reset restriction */
 	bool reset_restrict_support;
 	bool tx_sched_topo_comp_mode_en;
+	/* External Root of Trust (eRoT) controller present */
+	bool external_pqc_rot_present;
+	bool external_pqc_rot_invalid;
 };
 
 /* IEEE 1588 TIME_SYNC specific info */
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 839114d..df42f5b 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -175,6 +175,7 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
 #define LIBIE_AQC_CAPS_PENDING_OROM_VER			0x004B
 #define LIBIE_AQC_CAPS_NET_VER				0x004C
 #define LIBIE_AQC_CAPS_PENDING_NET_VER			0x004D
+#define LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT		0x004E
 #define LIBIE_AQC_CAPS_RDMA				0x0051
 #define LIBIE_AQC_CAPS_LED				0x0061
 #define LIBIE_AQC_CAPS_SDP				0x0062
-- 
2.56.0

