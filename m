Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2DBC5DF9B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 13:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B42D40652;
	Mon, 24 Aug 2026 13:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ecCfn7eMHLL; Mon, 24 Aug 2026 13:22:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787577774;
	bh=W1mYa70rSkl/+xbo58TUmsAHLfx1g15gUBw1nDnrTGs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YNtAZkHleXbuH95I8VkNQ48K8lJ/5YA19m1Chwpsm+kDMKX6L/+rwOT+l0H11bdvx
	 Wb687GP74I+cy3xUrwAZPUICbo1pmHNAHWLjnEZYfSv9i1HxxZS1G598euexbE0SO8
	 S8CVqtceC8uPDHk6eEdppgUjYtRYNQJLTfMuAP7A7Xb2aTQC2hFUxQcdxxwBWHQzkU
	 f7fTHz6dFqji4VxFjASOe5gWvJVHtUi/SN4fN1kacR7Sx6KFBYYlVLeJYDzoxjzfEi
	 q6WinpN1xSQCnszOhrMjTfKZbzWVPsqoGDHwU9zqx/i38puvv50r7VSDdfRi9F9rO4
	 PYKwqWwUrSPSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D1444065B;
	Mon, 24 Aug 2026 13:22:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 761313AD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 13:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5ADC040050
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 13:22:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMBNv7-Hd4WJ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 13:22:51 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=i77ViLRv
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A36D640029
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787577771; x=1819113771;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4iwRKxSimrc6YusEY2wkNKpRDAOO+LqtPIbldkpRD9Y=;
 b=i77ViLRva15uSM5SYPKuYjTieZGJGW4rFh1gHePWP0+q8Qe80yRc95Vi
 R1DoqTCuGl+IAiU4sD/N3lyKDRhzJjU00MXw94Ex0IMzN5ovPxyL2KFqS
 C1buOHyUIqPQO27syW36Kik+MmlPXOHSrta98JNYZl3AZMdMDoGRrfG1p
 haowVeUnusuZXuhTKfjWZN3lwd3cCN7AlqOy8Sushe6v2M5PfsljCxAMW
 Pp3zTvZeqPoqBrPzY7sSj+YhFxJ2kPOaobz/DarArW4UMeg3eHPekZMjg
 0zjg4lLYzJiZkW2fRednN0e9eR1i7adIcqdMFGKHpOOpUE5+pxJPfhbyA Q==;
X-CSE-ConnectionGUID: Ebq8/vi2Tb+soGTYIH8Xjg==
X-CSE-MsgGUID: dWk2G97RQ8WdWVhHs+pQKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91898136"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="91898136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 06:22:50 -0700
X-CSE-ConnectionGUID: X2TNBJc/Q4iKOZ8Nnsjp1A==
X-CSE-MsgGUID: rb4Vfjr1S1WVsplx+l9oGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="305213235"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 24 Aug 2026 06:22:50 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2] ice: fix bound parser hash offset before reading
 packet data
Date: Mon, 24 Aug 2026 15:22:48 +0200
Message-ID: <20260824132248.3396788-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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

ice_rt_ho_set() uses the HO register as the starting offset of an
ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
be advanced by user-controlled data reachable through
ice_parse_raw_rss_pattern() -> ice_parser_run() ->
ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
size of pkt_buf.

Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
so it stays correct if the packet buffer layout changes.

ice_parser_rt_pktbuf_set() stores the caller's raw pkt_len in
rt->pkt_len, even though it only ever copies min(ICE_PARSER_MAX_PKT_LEN,
pkt_len) bytes into rt->pkt_buf. Both ice_parse_raw_rss_pattern() and
ice_vc_fdir_parse_raw() pass a VF-supplied pkt_len of up to
VIRTCHNL_MAX_SIZE_RAW_PACKET (1024), i.e. larger than
ICE_PARSER_MAX_PKT_LEN (504). With HO now capped at 504, the
"HO >= pkt_len" loop exit in ice_parser_rt_execute() would never be
reached for such an oversized pkt_len. Store the already-clamped
length instead, so rt->pkt_len always matches what was actually copied
into rt->pkt_buf and the loop-exit check remains a valid bound
regardless of the caller-supplied pkt_len.

Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
Cc: stable@vger.kernel.org
Cc: horms@kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
- also clamp rt->pkt_len in ice_parser_rt_pktbuf_set() to the same
  ICE_PARSER_MAX_PKT_LEN bound already used for the rt->pkt_buf copy,
  so the "HO >= pkt_len" loop-exit in ice_parser_rt_execute() can't be
  bypassed by an oversized pkt_len from the raw RSS/FDIR VF paths
  (reported in review)
- dropped Przemek's Reviewed-by since the patch changed
---
 drivers/net/ethernet/intel/ice/ice_parser_rt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
index 3995d66..b330005 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -10,6 +10,8 @@ static void ice_rt_tsr_set(struct ice_parser_rt *rt, u16 tsr)
 
 static void ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)
 {
+	/* keep the ICE_GPR_HV_SIZE-byte read below within pkt_buf */
+	ho = min_t(u16, ho, sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE);
 	rt->gpr[ICE_GPR_HO_IDX] = ho;
 	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
 }
@@ -106,7 +108,7 @@ void ice_parser_rt_pktbuf_set(struct ice_parser_rt *rt, const u8 *pkt_buf,
 	u16 ho = rt->gpr[ICE_GPR_HO_IDX];
 
 	memcpy(rt->pkt_buf, pkt_buf, len);
-	rt->pkt_len = pkt_len;
+	rt->pkt_len = len;
 
 	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
 }
-- 
2.52.0

