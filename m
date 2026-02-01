Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4E2E65275
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Feb 2026 14:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 259E960F85;
	Sun,  1 Feb 2026 14:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sspLmdwhyOmA; Sun,  1 Feb 2026 14:15:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2EA860ECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769955307;
	bh=NsDbxjjmDR7CvHkvxGhq8nSyf2oqDfr3q8OmR6MlyCQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cPzj3kZ2EODcmFJ7NOSmThvWVEMDsRhp8t/3hb6qBIbrbIj+IsOfT41ZfNx8F5j5B
	 fufKkKn/M+68nkIXEmqK15/gupmaT1J2MrvqIgXyfadkInDZAdiBxvQcdwlPxj02gW
	 D1SBtzlR9JqO10HGEYzylSm8ik2Uhsqi3CWbipemDgIFDT6yk38NYtZcpED4GAjL4p
	 1+vYemOElPLVZpUOEpMJnYxE2SyiPtYkUB+drLKmNhgB97x5RyqFzFywjoyUrj4xj+
	 5aF83Si6/RtKT1KNdOdBUuavzXj4XBAFR2AeyhB3rSZjwywhqh59WiijfQz4LF58sV
	 pAmSOoNFj9v3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2EA860ECB;
	Sun,  1 Feb 2026 14:15:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D26923E
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Feb 2026 14:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1D484082C
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Feb 2026 14:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NcKwVE6KQ_D8 for <intel-wired-lan@lists.osuosl.org>;
 Sun,  1 Feb 2026 14:15:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 101B040829
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 101B040829
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 101B040829
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Feb 2026 14:15:05 +0000 (UTC)
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 611EEWh2001191
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 1 Feb 2026 23:14:33 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Simon Horman <horms@kernel.org>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>
Date: Sun,  1 Feb 2026 14:14:00 +0000
Message-ID: <20260201141430.131063-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=NsDbxjjmDR7CvHkvxGhq8nSyf2oqDfr3q8OmR6MlyCQ=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1769955273; v=1;
 b=jHULLAp6oKbuXYDcbKLPKiG/1tfUlOI1mcpKIrrSPQpjY2q5LtCJZ/w3N5Os+4tN
 ADBk2kK5J758uT3e1l7mvCxnillFqYnySDCBgxBlfoYehf4IfmpAjH/BFVLAtWcl
 gyuHhTIwDiBBFVKJdat4FoK2uXg/JUhgjV++xeSdFgmJS0VtjD0Drf2Cir05EZB0
 tsh6jw2G5q2fltSqltwI10XcpjfsqiNOtjSK6FqS2xXVNtP5wt4cdgFdvGaHHQXz
 la8EU5nKsAl6WRH16a7nBgAZxSQbdTLNbBoqubI1e8clbHSr+TP5hsF2yrSQeo/v
 xZJxF2fBGQiaJVCtN4j2PQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=jHULLAp6
Subject: [Intel-wired-lan] [PATCH v1 iwl-net] ice: ptp: don't WARN when
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

In VFIO passthrough setups, it is possible to pass through only a PF
which doesn't own the source timer. In that case the PTP controlling PF
(adapter->ctrl_pf) is never initialized in the VM, so ice_get_ctrl_ptp()
returns NULL and triggers WARN_ON() in ice_ptp_setup_pf().

Since this is an expected behavior in that configuration, replace
WARN_ON() with an informational message and return -EOPNOTSUPP.

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 272683001476..082313023024 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3048,7 +3048,13 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
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
2.51.0

