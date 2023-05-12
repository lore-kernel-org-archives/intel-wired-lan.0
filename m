Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9500DC77B75
	for <intel-wired-lan@archiver.kernel.org>; Fri, 12 May 2023 15:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46C5440986;
	Fri, 12 May 2023 15:29:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46C5440986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1683905348;
	bh=qlk8aROzansnF+U8VyeL6j9hqblZBScGRtPDgt4L5s0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=yCA60m3ph2KO7GYxEM22jNH0PR9TWvsEgF5dQCd5oNPvUhRWJLfml3JHsyfpo5PPs
	 KJb6L+xpplMdzG8vKeGA8y9C7aKPDWfDacRVcnk9wwzmVUTvkl42R+i+PVWxj3Wo0I
	 liaA5MTh025Xnupq7CqIyH1uEBHgGdkUlZTItpOKJHB6J2MV3S02QLgpW6/GC3BrRh
	 Zl8Fy+bLQDfgzlhl/CfE975mZe1kxKBefTMBh8WxCB7L0LVNSqmdwpsdz6uzGDwzYX
	 PXBR89z37aGwvcQpETgb6IJjcZGPuF/yLXHoAi29MhJUPX+6Hb+dsW+Rl2f1Gl6NOP
	 FZJCEno1iAeCQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tQvTXDqUhhmQ; Fri, 12 May 2023 15:29:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D2F4409A7;
	Fri, 12 May 2023 15:29:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D2F4409A7
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 29E6B1BF2CB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 May 2023 15:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F67482190
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 May 2023 15:28:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F67482190
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9KYtS9E0olA for <intel-wired-lan@lists.osuosl.org>;
 Fri, 12 May 2023 15:28:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6170E82173
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6170E82173
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 May 2023 15:28:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="349653359"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; d="scan'208";a="349653359"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 08:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="1030124549"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; d="scan'208";a="1030124549"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga005.fm.intel.com with ESMTP; 12 May 2023 08:28:49 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 32DB8369FF;
 Fri, 12 May 2023 16:28:48 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Date: Fri, 12 May 2023 17:26:00 +0200
Message-Id: <20230512152607.992209-9-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230512152607.992209-1-larysa.zaremba@intel.com>
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683905334; x=1715441334;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RxAZyfKvmCeKRbEnyC2VNCiFTtwsPxlmLEsjOF/q5aQ=;
 b=cTqdVinm6D3WGx5gq8iC1lnhVgPUOVIltAyChg7dHlNhenUONyW5zebA
 dYNHDHgCB4snLzo/60v25ASISSFZ1/r6amTLMGFP0pPhn5YI3dAIuarYO
 r1KVBd//aqh6ajE7sP6aUSvHxui3svZtXt8xRIEMt5oslkzykH9D461sf
 4nPlblrUpxsrXlkPppnriASCC1/HqMbX4+3PCIyPB4yxLFpgeSmLk8UAh
 hdH8NXJZ3uQTTOrLwaqL/gOLjQlplxy7YZynKEK01sI66pPLjA9shojX9
 2/IIM+isGFi5w1SNDLie81EBB+QVgF4MdSJFfrmwj+ds9/gckYDVEi8mv
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cTqdVinm
Subject: [Intel-wired-lan] [PATCH RESEND bpf-next 08/15] ice: Support XDP
 hints in AF_XDP ZC mode
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
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Stanislav Fomichev <sdf@google.com>, Maryam Tahhan <mtahhan@redhat.com>,
 xdp-hints@xdp-project.net, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jesper Dangaard Brouer <brouer@redhat.com>,
 Yonghong Song <yhs@fb.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In AF_XDP ZC, xdp_buff is not stored on ring,
instead it is provided by xsk_pool.
Space for metadata sources right after such buffers was already reserved
in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
This makes the implementation rather straightforward.

Update AF_XDP ZC packet processing to support XDP hints.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 3b80aed5d47a..7f5ce3529666 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -708,16 +708,25 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
  * @xdp: xdp_buff used as input to the XDP program
  * @xdp_prog: XDP program to run
  * @xdp_ring: ring to be used for XDP_TX action
+ * @rx_desc: packet descriptor
  *
  * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
  */
 static int
 ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
-	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
+	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
+	       union ice_32b_rx_flex_desc *rx_desc)
 {
 	int err, result = ICE_XDP_PASS;
 	u32 act;
 
+	/* We can safely convert xdp_buff_xsk to ice_xdp_buff,
+	 * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
+	 * right after xdp_buff, for our private use.
+	 * Macro insures we do not go above the limit.
+	 */
+	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
+	ice_xdp_set_meta_srcs(xdp, rx_desc, rx_ring);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	if (likely(act == XDP_REDIRECT)) {
@@ -816,7 +825,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		xsk_buff_set_size(xdp, size);
 		xsk_buff_dma_sync_for_cpu(xdp, rx_ring->xsk_pool);
 
-		xdp_res = ice_run_xdp_zc(rx_ring, xdp, xdp_prog, xdp_ring);
+		xdp_res = ice_run_xdp_zc(rx_ring, xdp, xdp_prog, xdp_ring,
+					 rx_desc);
 		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
 			xdp_xmit |= xdp_res;
 		} else if (xdp_res == ICE_XDP_EXIT) {
-- 
2.35.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
