Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB956606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=zRwPKTj2;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eYQw8xpF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5D4A80F6E;
	Mon,  2 Nov 2026 10:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fT70QHxRlyh9; Mon,  2 Nov 2026 10:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62A2680F58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616394;
	b=Dfd2YPyYaKL2vxSeyJn7+8aC9Xng5+zaZZpHgo9iCjhGVuDH3VO0WOSOdpqYK5OZ3sXz
	 5FImpQNXEgY8u659WpKItk0JkmebJGYnFw2M3FKd6e/aHyUGX3iZ+xbuGQ6UzzW4gPilK
	 y+oObUwqMXm2YdPPx/w+qadi2KpRjpLqpE7WJtsOTWqIC3H3iUsr+4gV3dz6f1IfHANZL
	 usIbryMc0c/DYvWOwgCaOI9o8zEXhonBBE+w0ukk9tspaIs59OyO/dUsVG5Jg5j7JH9WF
	 Ky+sT7Ij43iGawi4jsH4bXCcoyW6bB18juv3v/rdMrsS+IoO/CBlV1jypEnIIl9vcnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0de0W6jxw8KtscxBWkG1yp2WbDEIeVe8u254gNP5E2o=;
	b=CU5eXPzjuGjz1y6ECw/UwIxas+slwNizaeCRcKbbFEa7idj85N9feLrwvlwcIP1Qtpys
	 O93hdCWqDkjfloZMOJgMdbfAGpW4wSF0jD/rDG4a0Vphp7ScKUjskGU5eAWKMYmYc8B5x
	 s63FgPN5WH2+JvnyDuRrmuAFf9Embb2Z0wNeP3OBWLtFzi2R2u/N0k83P4YKJnCRafM+a
	 dMXCtmV0KPOaL4NVdQRR4OEfym1qCm85uQi1LtEuouvngK1MghrTAeHmbwcL6fAbYdllm
	 FzE1uiWbUn8PEsBdEJKxOusx86mE85FnwDKFytHSE0mGxzP40JKIhgKZmHkeK1Jzayw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616394;
	bh=0de0W6jxw8KtscxBWkG1yp2WbDEIeVe8u254gNP5E2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zRwPKTj2C73ZQX1mHr+LCI5/mLaQ8qHEjXQDXdxVNKYlALzg+oX6N+TL5ZwgUoCOI
	 cBOiIkTvT0TI5zyE4ob/fX7bIOsaTErUvQnxWEVieKxr+Td5ot2IwTkCXj7YhhT36u
	 aHCVNX4oHpTVvffA+Fmxlo7r/95SA0IqNjkufJJqOYhXDYm3A8ASZnDd/ZLEFDUzH+
	 FZpONB5EXEI4gBLJIBjigWUeN2P79bJS4+pIAZHsJHfbOIlJHD0QSVmF2FP2iuSV0L
	 QEF89x0B6W9KXVKCsFYCdkAe8PzpXIVrfw8JrdJQpyEmzEf5pJKPt4AkErUA4Qp9gs
	 9R2TdsqoZVysA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62A2680F58;
	Mon,  2 Nov 2026 10:46:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FEF9D3A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 812EA60792
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m50fDN72NuHc for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1DA46076F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793616393;
 b=WVdNmbw7WAPSNIzJP4abaBjlZhIgXVe9137uozUIpFy6vx0oVTcGhrQ6RmSbyBnemv2n
 XR2f/4vGnAdZr1WX+COhzxBWzoVwgi9Uay5ZskxYkQeU6TOyktz9teogynNNT/IZV+/Vm
 wJIiaADCIBDMZdIv0leBo+g497pdL1rgdsi5vIis9RNnuNDqHOpRTJ0uJESmksh7a/n7J
 L0vUYJTZUZuDr2XYwBPptnzRpx2WzR6ii7SVA/gS/xk9RbwslxnbeOEw5PlEowLkHdMpQ
 beEPwP17SdKFka46ID321IZbXMtNcoFXrKMMvA7vU1+uEyh29BK7WHY2vCH6iCIGIYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616393;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0de0W6jxw8KtscxBWkG1yp2WbDEIeVe8u254gNP5E2o=;
 b=CQE+jPvju8xJhjLkZp8teyk2zDxkQJ1fYmvUiQU644j6WkA2+FNYQZVFOXSjZ5LodyqU
 o/600HRmG0oJxRzd/eZM/9ljxUydZZESlGgcYMNbfaLlhDOSj05TI3gIDiOn4EAJXRv93
 ya7+9R0EeWlJIvXzpqPipDN5/0pLgxphvl0CH9OtrjcUMTGaDb8rEwrv9sdagVLMgCWhU
 w03dLbIQbxSBKhBzETScqelzP2jKfTQWDjbLvZBw9o9FAlIe2AaWCpgoegX7dOvm+eNf7
 4y5EK5eONNXvK2aik+5ikjOAJxngjsYy8l7N4btAQCTi2dIw4tP1TgIBhQHjX1SKLrA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eYQw8xpF; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eYQw8xpF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1DA46076F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616393; x=1825152393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cW+Movk1Z1ls6/YMIHhoUPIB2qHu/pPsMjpsRhMTgpk=;
 b=eYQw8xpF/ID5bWSUza73/797mRtPWP/zvHGLrRQFpQnwKRvejcfofXy5
 zFAy++Iw9b5Qt7FBE1egYiWKnIVJexYD/RSF39t2H35AxrU+aLWWyy8DL
 6w+lbAq1mZ6iAjmABSUA32pMS/EUTVGmjrDnqqwsyjXzeUq62UQ9qFICr
 e2BHGEXLTF7JjFuPo62qBetsr9WgoLeM77akSySCZUcf8/CzlGjpS1RTb
 9sUKQSLbZcYxRM5COTvUKvg9xfPNdmCe8QlCoPp4Rl00NfEZO0/ti+Kv7
 0A7uDOip20hO6EU+PKv6KKtrxtzmUWz1O3pvhCahM6lhhUwL+mB1Tat8Y w==;
X-CSE-ConnectionGUID: wOoggAh/TO2E0KI8V+f+hg==
X-CSE-MsgGUID: eLjjNn2ySF2iFte2mLcDaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305021"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305021"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:46:31 -0800
X-CSE-ConnectionGUID: E20Jtrf3Tz2N8/ujoxdMtQ==
X-CSE-MsgGUID: XGQpi2oeSFywndy8YLvBoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012003"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:30 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com
 [10.217.184.18])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 64FB92876A;
 Mon,  2 Nov 2026 10:46:28 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 1/6] ice: don't wait out a reset in
 ice_dcbnl_devreset()
Date: Mon,  2 Nov 2026 11:50:16 +0100
Message-ID: <20261102105346.30739-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_dcbnl_devreset() spins on ice_is_reset_in_progress() while holding RTNL,
taken by dcb_doit(), and pf->tc_mutex, taken by its dcbnl caller. The reset
rebuild needs RTNL in ice_ena_vsi() and pf->tc_mutex in ice_dcb_rebuild(),
both called from ice_rebuild(). So the waiter keeps the reset from ever
finishing, and thus keeps waiting.

Nothing is gained by the wait anyway: a reset in flight normally rebuilds
the DCB config and reopens the netdev on its own, which is all the
ifdown/ifup here is for. Bail out instead.

The reset bits are cleared only after ice_rebuild() returns, so a call can
still see them set after the rebuild has finished, and skip the ifdown/ifup.
That is harmless: ice_pf_dcb_cfg() has already reconfigured the VSIs, only
the stack-level notifications of the bounce are lost.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index bb5cc0a2ba69..9cdb9581fdc3 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -15,8 +15,9 @@ static void ice_dcbnl_devreset(struct net_device *netdev)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
-	while (ice_is_reset_in_progress(pf->state))
-		usleep_range(1000, 2000);
+	/* waiting for a reset in flight would block it on the locks we hold */
+	if (ice_is_reset_in_progress(pf->state))
+		return;
 
 	dev_close(netdev);
 	netdev_state_change(netdev);
-- 
2.54.0

