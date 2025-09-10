Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5FECA101F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 10 Sep 2025 22:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49E9D8420B;
	Wed, 10 Sep 2025 22:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wf4VoZjO9kNI; Wed, 10 Sep 2025 22:19:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0226843EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1757542751;
	bh=faDaaCe9eHY4bsA8Y6JtH7wTEzGEgv1zxdTd+/w3W1E=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yH04gyfFL93wztoKQi7QoRS1dZJ6V/EIHN9OffzrqRGzaMfbzYB8EccTJnGW8+V7s
	 FphJVXfYnhhsulKiJMhkEHxNKqlq3+VQeulfed85cEmeUUGKfnge93mNMCeQpgOWa7
	 je0jYL7YThQnpeEqtYODAILU5PaTgDTQ8n4x4VDHVDF1uVeJqRIc6gcQWTMuJSoXkx
	 SUJz0TP3qn7eUf1nP0eBtWxremGuAsGPlte0mq/N+3CrHLMFogWqglTFWi1vJtTrE0
	 PmE/zmFjLZreuL5SAUY6ScaFUDBH0qk2CkE1gd2whi6n2O1VV1BoWMgUOFJUIEtUz1
	 iQbFHlRnqtsCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0226843EC;
	Wed, 10 Sep 2025 22:19:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 524342BB3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Sep 2025 22:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38B0141965
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Sep 2025 22:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7iyHjm_q4Q-V for <intel-wired-lan@lists.osuosl.org>;
 Wed, 10 Sep 2025 22:19:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=91.218.175.180;
 helo=out-180.mta0.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 83ECF41962
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83ECF41962
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83ECF41962
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Sep 2025 22:19:08 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Yael Chemla <ychemla@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 10 Sep 2025 22:11:11 +0000
Message-ID: <20250910221111.1527502-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20250910221111.1527502-1-vadim.fedorenko@linux.dev>
References: <20250910221111.1527502-1-vadim.fedorenko@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1757542746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faDaaCe9eHY4bsA8Y6JtH7wTEzGEgv1zxdTd+/w3W1E=;
 b=FmkdZyfS/eH70Kx0zumWID/lfsaZxrfR3I/VBKDGU8geKhPo2GeNa9yB3QDaO63Ht8bSWl
 DUBSLlm0vgPUXUuybuZO77zSU/NPsDjRuDgcZMqnlpxAk/xqRcHHXb1DRMZw1PfgfaGLKD
 um5sEm1/dp+TKpOuQ9nItl+CYI5ZJBw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=FmkdZyfS
Subject: [Intel-wired-lan] [PATCH net-next v2 4/4] net/mlx5e: Report RS-FEC
 histogram statistics via ethtool
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Carolina Jubran <cjubran@nvidia.com>

Add support for reporting RS-FEC histogram counters by reading them
from the RS_FEC_HISTOGRAM_GROUP in the PPCNT register.

Co-developed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 476689cb0c1f..1da439dda323 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1529,15 +1529,46 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv,
 	return num_of_bins;
 }
 
+static void fec_rs_histogram_fill_stats(struct mlx5e_priv *priv,
+					u8 num_of_bins,
+					struct ethtool_fec_hist *hist)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	u32 out[MLX5_ST_SZ_DW(ppcnt_reg)] = {0};
+	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {0};
+	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
+	void *rs_histogram_cntrs;
+
+	MLX5_SET(ppcnt_reg, in, local_port, 1);
+	MLX5_SET(ppcnt_reg, in, grp, MLX5_RS_FEC_HISTOGRAM_GROUP);
+	if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0, 0))
+		return;
+
+	rs_histogram_cntrs = MLX5_ADDR_OF(ppcnt_reg, out,
+					  counter_set.rs_histogram_cntrs);
+	/* Guaranteed that num_of_bins is less than MLX5E_FEC_RS_HIST_MAX
+	 * by fec_rs_histogram_fill_ranges().
+	 */
+	for (int i = 0; i < num_of_bins; i++) {
+		hist->values[i].bin_value = MLX5_GET64(rs_histogram_cntrs,
+						       rs_histogram_cntrs,
+						       hist[i]);
+	}
+}
+
 static void fec_set_histograms_stats(struct mlx5e_priv *priv, int mode,
 				     struct ethtool_fec_hist *hist)
 {
+	u8 num_of_bins;
+
 	switch (mode) {
 	case MLX5E_FEC_RS_528_514:
 	case MLX5E_FEC_RS_544_514:
 	case MLX5E_FEC_LLRS_272_257_1:
 	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
-		fec_rs_histogram_fill_ranges(priv, &hist->ranges);
+		num_of_bins = fec_rs_histogram_fill_ranges(priv, &hist->ranges);
+		if (num_of_bins)
+			fec_rs_histogram_fill_stats(priv, num_of_bins, hist);
 		break;
 	default:
 		return;
-- 
2.47.3

