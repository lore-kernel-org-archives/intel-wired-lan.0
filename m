Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D622CC46CD2
	for <intel-wired-lan@archiver.kernel.org>; Sat, 23 Dec 2023 03:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98A5F415EF;
	Sat, 23 Dec 2023 03:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98A5F415EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703300419;
	bh=7NaRV6xo1wAcbh/+MljQwit+8EfG2kjk7hH8NMSfAsI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=btdczijTRY2XPNH7gQYe5NwIripasfjefn781vhCzMQPm65keq7rQ+BQithfsPwWF
	 4sEGN+FbRMjDsfOse1zAtOb8f/O/lBgdTeoux7f1djv6QtyCiy5m+QrjVM7uQbRTf/
	 OqM6PJMZ/OXSeuXXuba0j0noi4Dk8TpabT3IX+xckFi7xkW4dtHhs7R9VJFDbLI117
	 YveIl02duGFvhhllgh1K/fG/sbXNmRD7Fj1qH0q8pEJB1RUg0YM9N1aUzqUvZ63OIJ
	 V8umFGDhxU68QXpZKtJnlcD13raFo9h9LEjkVLfQOnmvymwFh/Xr12wsV2uchb2wS1
	 AxUIFmJJU3gCA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CAGCTCVyeou4; Sat, 23 Dec 2023 03:00:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 828E142DBB;
	Sat, 23 Dec 2023 03:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 828E142DBB
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 2FCCA1BF255
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0715142DC2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0715142DC2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id safOjFqrgLQr for <intel-wired-lan@lists.osuosl.org>;
 Sat, 23 Dec 2023 02:59:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5F7C42D6D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5F7C42D6D
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611052"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; d="scan'208";a="386611052"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 18:59:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; d="scan'208";a="25537650"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:46 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Sat, 23 Dec 2023 03:55:47 +0100
Message-ID: <20231223025554.2316836-28-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703300389; x=1734836389;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+6J77JDqTiJN5j8IBkCDiN5nsC96D4OujctoP2BKkx4=;
 b=jNuBqnfKahPAKDJJrRwnOItMuiiaX08HLq7NFFBiTEkFWczkzYcl5tua
 lFYGLEbrQzofBP+KqF5eUKTbM2TFz3cWt3+ZVmeLs7aFYA9D95wuEkzGY
 Y18U9SIoTLb9oEY80wNsXNpLSps2Nx4Gm/OtkvkPAYu4p0DyE+g/sh7wI
 81hPMM5cXjemOKWZmJAkhPL5OJpEZqXTdSxLMykgPVQ+mY8GjOOUeh+wN
 YZzdJuY2USvPnBoQaT2WFmNn9stFJYWTGt1YK97+NomvHjfz8ZoGQQokh
 u1R8dy43noUj9Hm3tKXOU/rPn/6+M7S3P9vOr/LjQx11AVCxqN9FMWO4/
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jNuBqnfK
Subject: [Intel-wired-lan] [PATCH RFC net-next 27/34] idpf: add support for
 sw interrupt
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Michal Kubiak <michal.kubiak@intel.com>

Sometimes, it may be needed to be able to trigger a HW interrupt
without a "real" interrupt from the hardware.
Add the corresponding register fields to the register table.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 3 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 4 ++++
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 2c6776086130..335bf789d908 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -100,6 +100,9 @@ static int idpf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
 		intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
 		intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
+		intr->dyn_ctl_swint_trig_m = PF_GLINT_DYN_CTL_SWINT_TRIG_M;
+		intr->dyn_ctl_sw_itridx_ena_m =
+					PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_PF_ITR_IDX_SPACING);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 20f484712ac2..fa21feddd204 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -347,6 +347,8 @@ struct idpf_vec_regs {
  * @dyn_ctl_itridx_m: Mask for ITR index
  * @dyn_ctl_intrvl_s: Register bit offset for ITR interval
  * @dyn_ctl_wb_on_itr_m: Mask for WB on ITR feature
+ * @dyn_ctl_swint_trig_m: Mask for SW ITR trigger register
+ * @dyn_ctl_sw_itridx_ena_m: Mask for SW ITR enable index
  * @rx_itr: RX ITR register
  * @tx_itr: TX ITR register
  * @icr_ena: Interrupt cause register offset
@@ -360,6 +362,8 @@ struct idpf_intr_reg {
 	u32 dyn_ctl_itridx_m;
 	u32 dyn_ctl_intrvl_s;
 	u32 dyn_ctl_wb_on_itr_m;
+	u32 dyn_ctl_swint_trig_m;
+	u32 dyn_ctl_sw_itridx_ena_m;
 	void __iomem *rx_itr;
 	void __iomem *tx_itr;
 	void __iomem *icr_ena;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index f5b0a0666636..a78ae0e618ca 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -99,6 +99,9 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
 		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
 		intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
+		intr->dyn_ctl_itridx_m = VF_INT_DYN_CTLN_ITR_INDX_M;
+		intr->dyn_ctl_sw_itridx_ena_m =
+			VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_VF_ITR_IDX_SPACING);
-- 
2.43.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
