Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973E606A330
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sVvzVHkY;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TKsTlDkk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32E2660A7D;
	Wed, 18 Nov 2026 16:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e05tKBMuq9rJ; Wed, 18 Nov 2026 16:34:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 324A0606B8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019697;
	b=k1Gj+xz64DU4u9+hhnjMU8yvDMT2OtoxCRHo5cYFGbSCMhSOCu50Ef5CHZLSyhpc5SCK
	 iiT/RGbwfg4+lUWroBSoyl+bMVphEdeIxUchjv859Ahw2EtroW24jA6upqVdFLrSrfvz4
	 DDHGyGc7d8a6WOuB0BiFfsvU+75TktkQ/ts9GNwelnRfYMULKrz7gj5cgoORZM7JfsTf6
	 eF4hdjv+PK0YpJDdbIIq8vUfu+G82JT84/FpM1CooJ2k9wNakQkamoYkILfIGhYNDED2W
	 y4fx1Du6sCUrRlZkHxe0vAKQTN5aUhjtCjkJsGg1n93Fgsd/zpzWica3h+wmW3CnFJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WLZm9VUh9VAQ5amzZlEaukxVQYAksbVebu8A1KJUgK0=;
	b=UAfZ8WvPmxxp/nMarCtGfCkOUwkRMbtjNJw6y8+b7YbP+kN6jyi+HSD7ZapLALcHRq2s
	 b7Z30r5+hVTRPGJdLLMpk62kTWoMvx+h7VrmicyefIgCLkQV2J0fkCwOoSlhtQjLsi0Hz
	 FoQDte8mEnnVTbK4/TDpjC/Q0Cp04DcrWm9vBAUiltSeIMSxfhs8rG4SlYku/EO1sBQlR
	 5T1CLIVk7kwj8yRUjO9U2/uNDN1Utnk5l/rYbqlaYoe9mIg2/SAl07PInVGrr0+M1Ng5l
	 RG7C5GWdgObQ/rysvCbwN46ZYD0hwDRWsBc3Z1JEmRt8G/WQBjNgtruBB9DCYbvO4XQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795019697;
	bh=WLZm9VUh9VAQ5amzZlEaukxVQYAksbVebu8A1KJUgK0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sVvzVHkY7QKczPkSrurHmXcqLk3W5rgJ3v1hUJ9MUxJ06FT7H37qpgTaUy8hnJwGl
	 y4jIWgGluzLh8iO3cBVNW9DE1tT793PjdGv1/Izz4SHfvF1B7zh2rqLkC1BL5oSeX7
	 vVZXsmS48CAXC+gB5gYVsXrlbwKnp+DmDTz/EWKLxqRlP+DcrvVdCSEj3MgJWSBV1p
	 8u5hBJH7b6KkfhPlTDgYAd6c+fjuuaigHiHpTKdfH7aAueeZr+zlf2GLoo+Exr/xJd
	 4xQO2skAmvrmyrVFbF/6/BpLVkR14w/heCR8Tbphnx5K1ooNNe02TDC0QGZIqevuNC
	 z2e1hCexXs17Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 324A0606B8;
	Wed, 18 Nov 2026 16:34:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7465A9F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A8614049A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5X8ZHrkr7sb for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 16:34:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8774C40199
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TKsTlDkk
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8774C40199
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795019694; x=1826555694;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ukqsb4QfIauZcxK6DOBy/Y+qvV3KMW/19YoCVppIvRw=;
 b=TKsTlDkk2Uj5ltzptE+btTpmQvHiMFvKkfHnX1wpgC7G1/VFJQNS6zjw
 CLU8FEEUnI3H6BIs4QLFPEwc15cjNtC5+nM6nL0T0T/IYmMAGGp0B1PDE
 45BwjxYcWk4tKQMF46pVGVB4tVQVQ101vSYg9XHyJpo9XQtzwHeRREkRm
 gYA+FBF4/4UqSMvUgHRqD4DttxkvI5PRqLdNgY6mYKUngYnU1EA58kciD
 v5PUz3L1GDkUMydCILPNJvzhKFNh6lOzr2Qpiq+pij6Jwgx5l3LMsFj/B
 +nDtXJsfzZXYZ0086OJU7+ezUFVMkvBsAMS7UA0sdkWror6iZG0uBeqpT Q==;
X-CSE-ConnectionGUID: zNyL8i9rREmbCapwpFJRqw==
X-CSE-MsgGUID: VKMWmJcjR6e2ks1paq5Mog==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3855908"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3855908"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 08:34:53 -0800
X-CSE-ConnectionGUID: GTwL5z4pRg+w8+yxLYOtHg==
X-CSE-MsgGUID: Okv5d6FUSm65B0Feg3uGXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10071901"
Received: from ccdlinuxdev13.iil.intel.com ([143.185.161.17])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 08:34:52 -0800
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-net 0/2] e1000e: Remove unnecessary workarounds from Nova
 Lake platform
Date: Wed, 18 Nov 2026 18:34:45 +0200
Message-Id: <20261118163447.1117617-1-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a dedicated Nova Lake board type and associate its device IDs
with the correct MAC type. Then restrict the K1 workaround to Meteor Lake
through Panther Lake, excluding Nova Lake where it is unnecessary and can
degrade performance.

Dima Ruinskiy (2):
  e1000e: introduce new board type for Nova Lake PCH
  e1000e: remove K1 workaround from Nova Lake

 drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +++-
 drivers/net/ethernet/intel/e1000e/hw.h      |  4 ++--
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 ++++++++++++++++++++-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 17 ++++++++--------
 4 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.44.0

