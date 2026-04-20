Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B2AF588C3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Apr 2026 13:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BA6A61110;
	Mon, 20 Apr 2026 13:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_SnlddnbQcM; Mon, 20 Apr 2026 13:16:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FFDB6110C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776690977;
	bh=UKfMAYP+YaEBWmLalYQmWxaecTT/vnItuoJhnjdPeuY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AGV8p6jVcMeugzibyFlOf3Tfi9Tlg7d5n7IFg/ac0SlPaUhXXwObc+Ut+e/zKKrgE
	 IeghgC/AeiDDHD+v1Gaxi8dgdczzOClLXxfeXM4qeyMCvNrE/8eq+RL8k4xKtgOn0B
	 sWtfsf5U8oC1v3wXG4+J5LQFBRLNh6g6obci86Rp/EULhMN4/Y+Oph3qfnc3SXWiqr
	 8NhtLpu2Cfu7+h5GARnFBWGkX7qNReHWH9MkJLD4X/6hMMN4MWkEyFiyPhLlDX2cyT
	 XAeRiwtNSEXFaTHIyQ290/MfSF1BD8qnALEOe9Ze5hwNJ0LGhGBrv/i4siwJj1o5vo
	 LB/DPWoaqYzzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FFDB6110C;
	Mon, 20 Apr 2026 13:16:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 39AE124D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AFB640514
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qe0pIwidaALM for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Apr 2026 13:16:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashal@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8871E40261
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8871E40261
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8871E40261
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:16:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E32F940473;
 Mon, 20 Apr 2026 13:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A4C2BCC9;
 Mon, 20 Apr 2026 13:16:13 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Sasha Levin <sashal@kernel.org>,
 jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com, sergey.temerkhanov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 09:08:07 -0400
Message-ID: <20260420131539.986432-21-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776690975;
 bh=3gnS4H5dN42k38IxAUh5e5CfDoKP9ZQMGb82ft8Sop0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R8Z7jEi4Oq87usBdbuxfM8PhvjI1jIp/duOSrVCYZdkqKHsTcwl6er8tjNZYyaCEh
 fMc7qG0NoiTr32m7JmOZngV60NdG/BnEhUxSQhmwBrtbG2NDEyv/91QS442jdkertZ
 yzcj67jwuTAuR7Re6wFcHSl82KzcH8VHU835Um7VzI4GoCk3+609vVslFlOqH6Pnn6
 3qNxe5DO8L4uPLFpx01AFgz8sn2tPg0Kh3VyiAeZLpwqIwa3yrYv5FVWMOB6pp3+H1
 FwD0v4CekRi8iPpbdYzDApSOCt98pKvEc+FBnctbKpcSIDZUtmCYJJ8HtMzI8O9id2
 xkjWUhwjIOK9w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=R8Z7jEi4
Subject: [Intel-wired-lan] [PATCH AUTOSEL 6.18] ice: ptp: don't WARN when
 controlling PF is unavailable
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

From: Kohei Enju <kohei@enjuk.jp>

[ Upstream commit bb3f21edc7056cdf44a7f7bd7ba65af40741838c ]

In VFIO passthrough setups, it is possible to pass through only a PF
which doesn't own the source timer. In that case the PTP controlling PF
(adapter->ctrl_pf) is never initialized in the VM, so ice_get_ctrl_ptp()
returns NULL and triggers WARN_ON() in ice_ptp_setup_pf().

Since this is an expected behavior in that configuration, replace
WARN_ON() with an informational message and return -EOPNOTSUPP.

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index df38345b12d72..02517772fb5f4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3041,7 +3041,13 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
 
-	if (WARN_ON(!ctrl_ptp) || pf->hw.mac_type == ICE_MAC_UNKNOWN)
+	if (!ctrl_ptp) {
+		dev_info(ice_pf_to_dev(pf),
+			 "PTP unavailable: no controlling PF\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&ptp->port.list_node);
-- 
2.53.0

