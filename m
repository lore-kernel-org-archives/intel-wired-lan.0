Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6C1E7718B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Jan 2025 17:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A7E0403EF;
	Thu,  2 Jan 2025 17:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kf_2FummgO4s; Thu,  2 Jan 2025 17:37:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AD15403D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1735839455;
	bh=M8kz3itQ/pGYcYkrFNStdI+yMsB12zXehoIKKmsZ498=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=orLCwaUjB7DPM7FKyw0Q/B7zk5Wyss2juRk1hS++HB20abK2upq4YvR+4CpYpNWUP
	 9DdlqcbAfvkLgI8FZSd+apcBrCK5FCfsMR4L6HXOjaitSiq80uqpprdZSiYEFE0kQy
	 +CTVuURDJgMyicA2saIf4zy+S3lwslRByXr/NgIMpXuhl4HrLpd18ZZjqp9K0ddP8P
	 DEWm2P8znmFRjsTIUtXidUwkxVvb7E5HDIdd8gtePOwPe4jUAePmfZ1oNpV3Msp2Pi
	 VbK9u8fFPMBUQu+hqQiIjssCC77hlD6HhFYk4tNnal2/xQZk9ogVXT2DD72h+zvEpN
	 O4Wmyalh8Bg8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AD15403D5;
	Thu,  2 Jan 2025 17:37:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5323F27
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jan 2025 17:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FC6A403ED
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jan 2025 17:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLDN6dgAcReZ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Jan 2025 17:37:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:5b::1;
 helo=mx.treblig.org; envelope-from=linux@treblig.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9F98E403A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F98E403A5
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F98E403A5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jan 2025 17:37:32 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1tTP8N-007tod-0z;
 Thu, 02 Jan 2025 17:37:23 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Date: Thu,  2 Jan 2025 17:37:13 +0000
Message-ID: <20250102173717.200359-6-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
References: <20250102173717.200359-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=M8kz3itQ/pGYcYkrFNStdI+yMsB12zXehoIKKmsZ498=; b=OXJrWKwmGnIN+xG9
 Dr/IAGXt1mVLdyOJo1s5bHRgm5o3xeZ2W8fsVIiEtGt+azB5yunUj/ReNzhbz6nfrTrqIDJ90FFoI
 c2/3PrzMgEuq4dUTPqiFsUEYG1nv8s00PKHVJzix2UB+EJAk8aJm7ZgfwfCt5rSY8fo0/h04w1/j8
 PsK5kXYtAEk2r3Fr0CFEHHeYzCNs5bwOjgq/our+CXOGdvPnJm8Snd6+ZtTQU4aCCjiKwkVJds9Zf
 FrrZc8ZCLzltxlOseI20VVt2SP8Kwa1UCzRBh3UFK2mWpMi0exbphLy8bj4KZX1hIE5txiKO+B1k8
 GbOfAYrAZ7vHNCGeTg==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=treblig.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256
 header.s=bytemarkmx header.b=OXJrWKwm
Subject: [Intel-wired-lan] [PATCH net-next 5/9] i40e: Remove unused
 i40e_get_cur_guaranteed_fd_count
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of i40e_get_cur_guaranteed_fd_count() was removed in 2015 by
commit 04294e38a451 ("i40e: FD filters flush policy changes")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d4255c2706fa..5d9738b746f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1189,7 +1189,6 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
 		      struct i40e_fdir_filter *input, bool add);
 void i40e_fdir_check_and_reenable(struct i40e_pf *pf);
 u32 i40e_get_current_fd_count(struct i40e_pf *pf);
-u32 i40e_get_cur_guaranteed_fd_count(struct i40e_pf *pf);
 u32 i40e_get_current_atr_cnt(struct i40e_pf *pf);
 u32 i40e_get_global_fd_count(struct i40e_pf *pf);
 bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0e1d9e2fbf38..83ba1effe8ba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9628,19 +9628,6 @@ static void i40e_handle_lan_overflow_event(struct i40e_pf *pf,
 	i40e_reset_vf(vf, false);
 }
 
-/**
- * i40e_get_cur_guaranteed_fd_count - Get the consumed guaranteed FD filters
- * @pf: board private structure
- **/
-u32 i40e_get_cur_guaranteed_fd_count(struct i40e_pf *pf)
-{
-	u32 val, fcnt_prog;
-
-	val = rd32(&pf->hw, I40E_PFQF_FDSTAT);
-	fcnt_prog = (val & I40E_PFQF_FDSTAT_GUARANT_CNT_MASK);
-	return fcnt_prog;
-}
-
 /**
  * i40e_get_current_fd_count - Get total FD filters programmed for this PF
  * @pf: board private structure
-- 
2.47.1

