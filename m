Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0463FCA601F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B84DF8100F;
	Fri,  9 Oct 2026 20:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRZ9lGptLmsM; Fri,  9 Oct 2026 20:12:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 015818101D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791576769;
	b=ivZIe0oGEjsr2wEl9ouru6o5CZaVRYuVvObcVHWiSF1i42GbviSrCL8PTC9wJcorsLg0
	 xX8mfmylXDt6y9/2IwB8Wtz8wdaRAsRWpxAMzYAy+MsVP6wSNsEeg2TKFTpba4eRibBqV
	 jRdJ1ZsFks5M6MMTBshHqAWmHOGx/tchZfv2yVd3shl91HYYmWLwViDys0P6MTJ6WANL9
	 2/BrtP1pqBI201SBLyrJlKdOO2khU5ZvJmy8Pekd8tUnObZYrDz5arXGNDoZQxCO8JSIx
	 ezU2nJzgpe46Fa/Rnz4HeJiYlfPhV50Y6mZW7Qzvyk2KEyy4/mNumz7p1i+aCeGEL7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791576769;
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
	bh=6UgNgfpSEmn3s3Q16E9pgWxhF35kFRPdVIadqvvF1p4=;
	b=Hd8haCC9L25psuGc1fyXT5rc8KiUSAKhEdnPZvnwLT5CYMX9GscqVXyWGAyhuY2ocxjZ
	 Bz2j02L5VVJwNrSUa8OGj2Kp4Xb1EnZkDuuRoPAp4Cvr2pLOF35GwJF2CA6dJn/KIhEUv
	 eKZmgREA99JCvbLK+SGsdZrXmjkL4fz7Yretf+btNKQpmvdYufAsJZzxowwoqAAfWPL1Y
	 jTC5q+w3EGEKOqosGgzjuw6D1ilXKE01uGUYnqcR2veHh/E1P+wkMC5gj+86CBhnRnz4g
	 0wfG7wsZoLPhaCcKZ5o48fHDBrb9bWdvKWj3AlVxqsuN4TrFyITMriTcsW7UOk0pdAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791576769;
	bh=6UgNgfpSEmn3s3Q16E9pgWxhF35kFRPdVIadqvvF1p4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6fyBfQQ8NJqqED7A7oAJC9TfTWf7jatt9imGxOG7uZsEfhtMLEU7hJ89glygiNkhu
	 WLkUpXmlCGhr8AzRi0Yy54s49MZ5UblWO4FznE29Rk6CV/o2MamZ/5lk3yew+y+LMJ
	 AlSMuUgkAFXxZwgpjOYXwBQEsk+zEELPGlEaex8H+YeIChk6xxZcZQnYceuklAOkw1
	 XsIyM+9SPiLnN72iormvPagVOwjrJT1UNCTZJmyHn1H75i+ezNov4EEaw7s+CKXmSP
	 XDjkGSXG8p8YrSjscw+ru+chJq7sfUAhtCIAn4GqPqKZC9NOgYYFmUNQhWpbeXSFce
	 xWV+k2fu6HVEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 015818101D;
	Fri,  9 Oct 2026 20:12:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6542F3B4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5741040080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ay3-BLoiib7 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7006940194
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576766;
 b=QvpA/jv0cVCjH0HkXUtx1KhkA56dopkijn7GxweuUWQSwETYQU6Tjq3aiavaG7lkGSn1
 JI6OUaL5CMh/4DjPPxPq5A94w0NczMW9VsLFEWKY7g5ECzzw31xn/Q0aebREfcC0pqoeP
 qS3e11SuwEY++YB2fdEp9NT0QX9jNkfy/m5pFaU7nAopcQL0DYKLmlQAqEvGHaqVGThjz
 SyG7twz3WkBgE5/X7gMwdKQ7Ok/tw7ro5h9np9EQmu88QOwJXd1OWboGE4tTHwZInSPo8
 H43wXy8SqkIoQh3aUqTiDp4ga+9OsoCTqZwlxWmUG7s+3vTW8fAZtA3zF+LoDdsG7dQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576766;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=6UgNgfpSEmn3s3Q16E9pgWxhF35kFRPdVIadqvvF1p4=;
 b=qALcbZx1RTgr71QK4BThsUJDfqUV8Euh2KYVbRJ7P5Mhf8lNPZHVTnGi2EsJup7sGMCT
 43w7DskYsGp6pJzRRiCXL4HKgxIuyfw8ONPMYGtgY8NUG4d3PA59wO6gkYEQI9eCcCtWj
 DMXms+a8Zyboih1Z7D36C9GX1EvN7cI95Xq8lItYPzcs7cMwDGApwklH4wUchl6o7MuYx
 lRP8O4qJPBrWe00Rr6GyRAoEASTMOs1vMrLpHZ68nKK+cZ09W/fooF+Av950ep3Ae/1H9
 70cxaf7gi3zUu8d6UMd9he/l7hLjxmrJQBqhsZpAJSKx/cwviUXTAOQtFrOhesbUjJw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BeQZShA3; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BeQZShA3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7006940194
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791576767; x=1823112767;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=qcfAqVqUbJpLMgAxbxgCRHyhaDa5fmfg0i9TPyjVxh0=;
 b=BeQZShA3Vm9HIYJfCWMT3esai3fKMM9H83QPpu7NdkjKdBSdf9Jpwf6T
 WBhm7MBNxrGsNrfM6tJMFmRBZKgvTYQH1HVF/dosRxQ60Q3UsuDoOKYIk
 TWw1vGwUfiikb59l7YlogBVSajJKWxRfU3s+PvdYHJSwC2RcYBo/VPxsb
 Q21LLGO8BkxKRH12z1T0dduYKoi6M5ARyGrZukAlhtILKiingik+0+jgF
 Jq7MA4ee861aJ7AhyxrQc0LfS77Zs3EPVctaViPARLLxrYZ0nwfCifW9H
 zPLmkQXdcnDS8yVWDxjlGrsaWiWQgBt8/X0xUQhq0Q11SpY7Q86zmEVWw Q==;
X-CSE-ConnectionGUID: eyWIOKm4Rou6b60X/mTllQ==
X-CSE-MsgGUID: OJtYvv3wQRmzR4NXaWf/8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="261911"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="261911"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:45 -0700
X-CSE-ConnectionGUID: Rk4Dx38eQvyZlp7xitfFJQ==
X-CSE-MsgGUID: rw5uTOyATCCYIaEQKtiJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2189804"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 09 Oct 2026 13:11:20 -0700
Subject: [PATCH iwl-next v2 4/6] ice: pass agg_info instead of performing
 lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-4-313964c25c7b@intel.com>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
In-Reply-To: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=6216;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=qcfAqVqUbJpLMgAxbxgCRHyhaDa5fmfg0i9TPyjVxh0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyTXts6opY/P5+VLsgkULdi1Wb+JLvDi4uCgiW42uOMZ
 3gJtDB2lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMBHxtQx/ZZulrzsZvCj7PfXh
 R87/Xx/NbE/3l9y64lf3okCPbO/8N4wMq+4Vz2Oxq74uwBQ7Md8/POZbsxLLDObQDqOo6k0rvi7
 jAAA=
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

Several of the functions involving aggregator nodes take the agg_id
parameter and perform a lookup via xa_load. In some cases, the functions
are called only from inside other paths that already performed the relevant
lookup and have a valid agg_info structure pointer.

Refactor these functions to take the agg_info directly instead of
performing an unnecessary lookup. This simplifies the implementation and
removes potential error paths that can't properly fail.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 61 ++++++++++++------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 27971cb135fa..b1c2901b23f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2589,25 +2589,17 @@ ice_rm_agg_cfg_tc(struct ice_port_info *pi, struct ice_sched_agg_info *agg_info,
 
 /**
  * ice_save_agg_tc_bitmap - save aggregator TC bitmap
- * @pi: port information structure
- * @agg_id: aggregator ID
+ * @agg_info: aggregator node
  * @tc_bitmap: 8 bits TC bitmap
  *
  * Save aggregator TC bitmap. This function needs to be called with scheduler
  * lock held.
  */
-static int
-ice_save_agg_tc_bitmap(struct ice_port_info *pi, u32 agg_id,
-		       unsigned long *tc_bitmap)
+static void ice_save_agg_tc_bitmap(struct ice_sched_agg_info *agg_info,
+				   unsigned long *tc_bitmap)
 {
-	struct ice_sched_agg_info *agg_info;
-
-	agg_info = xa_load(&pi->hw->agg_nodes, agg_id);
-	if (!agg_info)
-		return -EINVAL;
 	bitmap_copy(agg_info->replay_tc_bitmap, tc_bitmap,
 		    ICE_MAX_TRAFFIC_CLASS);
-	return 0;
 }
 
 /**
@@ -2811,7 +2803,7 @@ ice_cfg_agg(struct ice_port_info *pi, u32 agg_id, enum ice_agg_type agg_type,
 		return PTR_ERR(agg_info);
 	status = ice_sched_cfg_agg(pi, agg_info, &bitmap);
 	if (!status)
-		status = ice_save_agg_tc_bitmap(pi, agg_id, &bitmap);
+		ice_save_agg_tc_bitmap(agg_info, &bitmap);
 	mutex_unlock(&pi->sched_lock);
 	return status;
 }
@@ -2863,24 +2855,19 @@ ice_get_vsi_agg_info(struct ice_hw *hw, u16 vsi_handle)
 
 /**
  * ice_save_agg_vsi_tc_bitmap - save aggregator VSI TC bitmap
- * @pi: port information structure
- * @agg_id: aggregator ID
+ * @agg_info: aggregator node
  * @vsi_handle: software VSI handle
  * @tc_bitmap: TC bitmap of enabled TC(s)
  *
  * Save VSI to aggregator TC bitmap. This function needs to call with scheduler
  * lock held.
  */
-static int
-ice_save_agg_vsi_tc_bitmap(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
-			   unsigned long *tc_bitmap)
+static int ice_save_agg_vsi_tc_bitmap(struct ice_sched_agg_info *agg_info,
+				      u16 vsi_handle,
+				      unsigned long *tc_bitmap)
 {
 	struct ice_sched_agg_vsi_info *agg_vsi_info;
-	struct ice_sched_agg_info *agg_info;
 
-	agg_info = xa_load(&pi->hw->agg_nodes, agg_id);
-	if (!agg_info)
-		return -EINVAL;
 	/* check if entry already exist */
 	agg_vsi_info = ice_get_agg_vsi_info(agg_info, vsi_handle);
 	if (!agg_vsi_info)
@@ -2893,7 +2880,7 @@ ice_save_agg_vsi_tc_bitmap(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
 /**
  * ice_sched_assoc_vsi_to_agg - associate/move VSI to new/default aggregator
  * @pi: port information structure
- * @agg_id: aggregator ID
+ * @agg_info: aggregator node
  * @vsi_handle: software VSI handle
  * @tc_bitmap: TC bitmap of enabled TC(s)
  *
@@ -2901,20 +2888,17 @@ ice_save_agg_vsi_tc_bitmap(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
  * already associated to the aggregator node then no operation is performed on
  * the tree. This function needs to be called with scheduler lock held.
  */
-static int
-ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
-			   u16 vsi_handle, unsigned long *tc_bitmap)
+static int ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi,
+				      struct ice_sched_agg_info *agg_info,
+				      u16 vsi_handle, unsigned long *tc_bitmap)
 {
 	struct ice_sched_agg_vsi_info *agg_vsi_info, *iter, *old_agg_vsi_info = NULL;
-	struct ice_sched_agg_info *agg_info, *old_agg_info;
+	struct ice_sched_agg_info *old_agg_info;
 	struct ice_hw *hw = pi->hw;
 	int status = 0;
 	u8 tc;
 
-	if (!ice_is_vsi_valid(pi->hw, vsi_handle))
-		return -EINVAL;
-	agg_info = xa_load(&hw->agg_nodes, agg_id);
-	if (!agg_info)
+	if (!ice_is_vsi_valid(hw, vsi_handle))
 		return -EINVAL;
 	/* If the VSI is already part of another aggregator then update
 	 * its VSI info list
@@ -2952,7 +2936,8 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 			continue;
 
 		/* Move VSI to new aggregator */
-		status = ice_sched_move_vsi_to_agg(pi, vsi_handle, agg_id, tc);
+		status = ice_sched_move_vsi_to_agg(pi, vsi_handle,
+						   agg_info->agg_id, tc);
 		if (status)
 			break;
 
@@ -3080,15 +3065,19 @@ int
 ice_move_vsi_to_agg(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
 		    u8 tc_bitmap)
 {
+	struct ice_sched_agg_info *agg_info;
 	unsigned long bitmap = tc_bitmap;
 	int status;
 
 	mutex_lock(&pi->sched_lock);
-	status = ice_sched_assoc_vsi_to_agg(pi, agg_id, vsi_handle,
-					    (unsigned long *)&bitmap);
+	agg_info = xa_load(&pi->hw->agg_nodes, agg_id);
+	if (!agg_info)
+		return -EINVAL;
+	status = ice_sched_assoc_vsi_to_agg(pi, agg_info, vsi_handle,
+					    &bitmap);
 	if (!status)
-		status = ice_save_agg_vsi_tc_bitmap(pi, agg_id, vsi_handle,
-						    (unsigned long *)&bitmap);
+		status = ice_save_agg_vsi_tc_bitmap(agg_info, vsi_handle,
+						    &bitmap);
 	mutex_unlock(&pi->sched_lock);
 	return status;
 }
@@ -4420,7 +4409,7 @@ static int ice_sched_replay_vsi_agg(struct ice_hw *hw, u16 vsi_handle)
 	ice_sched_get_ena_tc_bitmap(pi, agg_vsi_info->replay_tc_bitmap,
 				    replay_bitmap);
 	/* Move this VSI (vsi_handle) to above aggregator */
-	return ice_sched_assoc_vsi_to_agg(pi, agg_info->agg_id, vsi_handle,
+	return ice_sched_assoc_vsi_to_agg(pi, agg_info, vsi_handle,
 					  replay_bitmap);
 }
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

