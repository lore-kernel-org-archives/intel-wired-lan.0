Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1261E10987A2
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 16:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD21284740;
	Fri, 20 Mar 2026 16:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ea-4LB36KMWv; Fri, 20 Mar 2026 16:07:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90850845A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774022845;
	bh=9UW7/W8cWYlSifLJpojgxWAcXp6ZQri7/c4FUIwuHiw=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=y69qQhBmxlTSCmkzkqS//z8dUE+HCKNnIN5f2n+/eorM/o852YOU6GIdP5GK3wdGo
	 hYI8LuYMJL09OY/iZpUBljaI7slhoHAIAKAiVcwbg381HVWB8N0qAwzZxx4+rRGr1F
	 7OIvQuNns3NnLx02SV6Skm47vnpIgffxkhjNcqvKoajJqCqexLYzf0qNmzfCt1O64i
	 SQLY4wn8pERp8brjX7vVIF4mZmq7RbKY96ye5o4wq6Xz5DQHPzO5w26lQIG5yNDkSR
	 qln9cteeI9zSYgPVn/gVHROhu122NsffKk4/oNUDCrXJA85KGDdTMBOi2rYx6l+UAc
	 eLdWx+BcThdQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90850845A2;
	Fri, 20 Mar 2026 16:07:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DFCF1B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E844C846DF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ASE1P9aF6S5e for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 16:07:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=199.89.1.14;
 helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AE568845A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE568845A2
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE568845A2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4fcnWs5Vmfz1XM6J6;
 Fri, 20 Mar 2026 16:07:21 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OrWShpSAw2JF; Fri, 20 Mar 2026 16:07:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fcnWm1JKZz1XM31H;
 Fri, 20 Mar 2026 16:07:15 +0000 (UTC)
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, Bart Van Assche <bvanassche@acm.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Fri, 20 Mar 2026 09:07:07 -0700
Message-ID: <20260320160707.3047815-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=acm.org; h=
 content-transfer-encoding:mime-version:x-mailer:message-id:date
 :date:subject:subject:from:from:received:received; s=mr01; t=
 1774022838; x=1776614839; bh=9UW7/W8cWYlSifLJpojgxWAcXp6ZQri7/c4
 FUIwuHiw=; b=cVxnRryT31/CBREpUWYfhjb8/6Y1y/iNJpR9dDg8HB4sE7X4c+f
 g8y0bx1LmVyh2CKQbQkLu9EDYSdKz8dBxbdkv8H6lycWejmTRHESyaXUx+33l80D
 No13B3yXuidk5ieWgXznzrOx6EV5NbjjYglJdr0Ow53FHZK/AMZNf0h6ego6BXbu
 a6IUBvM0R7tKpmE6b4jRmUuyMUdghgd/u2kUD84fXnup/Wge24MUSwYlsOn24+XF
 Vo2U7uO2CthIJSIp1EJcJNOwg3Qd5ZDwlNJjuZfSEDllDg9HVuLMMDY4yCGWnmwa
 Xgpw7EpBSCuMdOCWOBOPtZO4PSqIMHhLZ3w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=acm.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256
 header.s=mr01 header.b=cVxnRryT
Subject: [Intel-wired-lan] [PATCH] iwl-net: ice: fix locking in
 ice_dcb_rebuild()
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
From: Bart Van Assche via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Move the mutex_lock() call up to prevent that DCB settings change after
the first ice_query_port_ets() call. The second ice_query_port_ets()
call in ice_dcb_rebuild() is already protected by pf->tc_mutex.

This also fixes a bug in an error path, as before taking the first
"goto dcb_error" in the function jumped over mutex_lock() to
mutex_unlock().

This bug has been detected by the clang thread-safety analyzer.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/e=
thernet/intel/ice/ice_dcb_lib.c
index bd77f1c001ee..78ded6876581 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -537,14 +537,14 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	struct ice_dcbx_cfg *err_cfg;
 	int ret;
=20
+	mutex_lock(&pf->tc_mutex);
+
 	ret =3D ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
 		goto dcb_error;
 	}
=20
-	mutex_lock(&pf->tc_mutex);
-
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
 		ice_cfg_etsrec_defaults(pf->hw.port_info);
=20
