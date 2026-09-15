Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B56C982C4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE68D605E0;
	Tue, 15 Sep 2026 12:56:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ExxlmyAi5ZJN; Tue, 15 Sep 2026 12:56:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 53F686077C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476977;
	b=aeBuEofVQhqNcKMjMM90Q2FIEUFgaIg35i9vHwgBqv3gf4EMvBa9tWxBSe3AdMbGU4mT
	 r2IgdvspTrM/gK+7NRrYg5H1Ov5p7SKuGSVY7cLe2007KrSAg0StaNbbc/+9az6g8GzB5
	 +P92GnvdjvL/GvuFzSo8InOLUpj8LhH7EDR4N3f4cHEaxFpfPzWngkMRsX10AfLfyVdQC
	 NO+xDI4dFDrwf+SNb1dsOi2raMgn3qZhUSc9VXm3NxQdYI24zNP42eBI6mSWUAR9B/xUZ
	 9DBfMxwvzqZIS3GzQSkRDW80gUn00toB75E0joPOlKNoT2LWH3ulwlwwxu/RrXhMATQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=srBZJTpy/lH8KzbKgzWwJ669akt1H75CvNa8/DfEEXo=;
	b=qnvssw1wpEpeYu3JUNpEhWjWs/AhLBwSKgrJ04KYSsOq8MEC8YJH+2tahqJfLBz3ajk3
	 DJpTWR5OumtV2dsh95BTcdx7Ws4Wtv8bO2vPdkjpDJY5no30UVP7AMxi72JPLlvHi/+D/
	 eFgHwueYIKBAY9QSSxPAm7USfjCcxPyGfpiklSj0k7v4WFj5A4pRsZ4v4ps+NrKpNSvc7
	 hKNJ5b/tng3gBQA67rgoZ2L2G7e4/hxHOohyBZvj+GNvsKcjPNVflgoyOmYYJeW5g5Evq
	 UPB1dSfDsf/yB5QTPtEGTwNYNHfZ1jOTo+m2iApgeVfrSnaj/EGHgRIa6artuZpa+PQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476977;
	bh=srBZJTpy/lH8KzbKgzWwJ669akt1H75CvNa8/DfEEXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d61aMLh6gTa3dvPTX1MtY7sWZdPoRrkcRQ970oonhTIqWp3FXOgwYl8Yav7HLLBN6
	 eqcU0pg9EdgLenOstHwunezY5ABtUfGgwAY1wg8gcD8f/8BsAf7c+4qqjYQfk+m9oh
	 qy17nCpm0+Pik070VZ7hgXuJyRNXUIov90M/GDPJ8OJ4xnjZGrbwkUCaFMuIcpoUUn
	 AR6mmTbdxCMn908oJKRsoXCd2u+D3K+wOwtyRhdsEDwvhBfzEyxVuHPEc9Zp+KKpAt
	 u8EWhTjNvjywZXL1nYPIXXAJeXzQOVAqHZFLQC6iImGjM9fs/svBpzIccbPsmgZDHZ
	 cb9MPrL5u3aNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53F686077C;
	Tue, 15 Sep 2026 12:56:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B715493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D77140699
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wcR_GrUIRW9F for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 955C440695
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476970;
 b=JYPQoczi3Z/pd0B4SUsVJYzAIWrDCqELzNou28xYpb9QNK54+ykCbHqgp2M70Hz59fp/
 eluLz1XJX8mSZ10aCkkJUIoJU4M7z+3IaQ0hUE/A3uzIBh+3ihPs21u1YWJpMui5DmyJ3
 mnsZM3F/jHMUJk5taccF4yUydeRDqmNc2YUtpVL1f+884r0FpZJ04dARr++PhGuN60GSY
 TA2uQgNNtAPeYINHgLB0XZ8QmwGZUMPFHRLFEO1LqTk7jqBdJEUh1s6GXNyO0FE8C4yCP
 /NrZRMPBzMfg74TIG6HZoG59ZOX9ITOsKz2Yn+icNQYh5/w2EqUlFjmbAVhCzCE0tfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476970;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=srBZJTpy/lH8KzbKgzWwJ669akt1H75CvNa8/DfEEXo=;
 b=U14CGN2ciWvJ1HUPgVLwWmrOwZtu964cxF4mpzL84axw4c+b+BbRf4kWs3khLZWDca9o
 bGTu54Lp9+4f8VvbiPCJ11KetVyIgt20cNAe+lMEDmYu9UQ1Kz3AjLeDdpx3eOP1IGdXG
 t7niaaLxYA2liRwcgn8qf/aGzgaoiWb+3WzRKPaaRu/0E3InT23bYflQmpbMBRFcy1QaI
 moZjdISs3U8Ed5buoDDbjGECh3ZxB6i7QPUYR5dNk4Ocf6MWH9eOKaTDoOTlpF8dXCmkD
 Yt/sAlNDbrdAYgf24wsrfUxS01GDyRP8L586sbnXHusxgimSRXceKiIM4stF7coh1Mg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KussL2z5; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KussL2z5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 955C440695
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476971; x=1821012971;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GgxD624Eu0lCw/tTk89CMQqXWPEIP9c3nFeqMp5ikOs=;
 b=KussL2z51Y4gxaiowwNBiq9odLLX0ufvQDgE+QG/Nty7OiCW2NXRoC8P
 1l5wUhlkVYqRJdYFcN6qAiFjIWNcoUaSV1nNQNofA3g78z4QVB3hu0lCO
 bG8o2yrPjEbPEwxGkrMe+/nP0RZjZ33rms84gCbm0ZScrtLWoha22QyrY
 io10ftKJ2DKXrQYi0McQpbZrI5T1LCN4yAitScDSaTVYsEQ2yE23O1i7K
 rLWqz3XxKGj+XctWQwl8D4kOOX1F29eePEgjYMzyezp2yHvVmV3io/1g7
 uzkq4vg4nsWK7Sxr6gUbvJJQBvy5Eugk/lD1sQmJW+2ZcXvBQczUwvRiq w==;
X-CSE-ConnectionGUID: mE+hEpD4SGiGfBJjCy/0Ow==
X-CSE-MsgGUID: LFCGjInkQlGvGQLvPeJpZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607105"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112607105"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:56:00 -0700
X-CSE-ConnectionGUID: MOkHcWd8ToGKs5Qu4036ww==
X-CSE-MsgGUID: BfqJPAaMS3S7ro8VmGz+jQ==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:59 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kiran Patil <kiran.patil@intel.com>
Subject: [PATCH iwl-net v2 5/5] iavf: return 0 when TC flower filter not found
 after qdisc teardown
Date: Tue, 15 Sep 2026 14:55:51 +0200
Message-ID: <20260915125551.3976068-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Kiran Patil <kiran.patil@intel.com>

When an egress qdisc is destroyed, the driver proactively deletes all
associated cloud filters to prevent stale hardware state, decrementing
num_cloud_filters to zero in the process.

The kernel netdev layer is unaware of this implicit cleanup and may
still try to delete the same filters individually. If the filter is
not found in the driver's list and num_cloud_filters is already zero,
return 0 instead of -EINVAL to avoid confusing upper layers that
believe the filter is still offloaded in hardware.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Cc: stable@vger.kernel.org
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index e5bf15b..de80947 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4162,7 +4162,8 @@ static int iavf_delete_clsflower(struct iavf_adapter *adapter,
 	if (filter) {
 		filter->del = true;
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
-	} else {
+	} else if (adapter->num_cloud_filters) {
+		/* other filters still tracked, so this one is a genuine miss */
 		err = -EINVAL;
 	}
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
-- 
2.52.0

