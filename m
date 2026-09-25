Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850E5C9830D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42E2360BE4;
	Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 95mHEHJjDlSU; Fri, 25 Sep 2026 13:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 753B160BED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790342820;
	b=VLYRkLldnA0Bcm71LiSQwGdrKkOHbtE5ejRvQIvvYreyM8XUzONQsKCYN1F134VlIygK
	 CnCR8y/6nU4c2WQH8CVdNZY5xQF4nd+P/SFz6oD+FzdUusvuXu62RYb9C+Uw/EbQG7uMz
	 ENonGhUsluKHjLGk+yfNkLdaUoMcbq748TPbtholOmFnWhQewE6cNmUwcrHmHlDC4Zod8
	 Wi8yHlHGCTvUEJmmTbDId2EwMaj2GqrAeiT36lbDuep7hFh/gmBbAURbVp6hMPUyLWvNV
	 twkRRZdkdLYJ9E5gdqiYxNCGWmaaaOFpDEAfblJxWRQpZNcgwIg4vSvryVYdMWBhePA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790342820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fAwTOb6YY9VCxRYGEKOmtMKZA7kHySKut8LyJvJ/Q+g=;
	b=JKT2NV3FgwnbhiDfPdMPRlKlueZdmS1s84CQRlru9UviHli7QqND6wn6S7EWyKyhA6eU
	 UkskLHmhDegc06Uzg0CuMROmI9WEGJYYuxfJAxAzeMyRHtyT6JrIQTkRmiHTgMOwdzLjg
	 hQP0K37ZKA/fmvnaru1isiOlJGn0eU+4+X87e9QsZowX1fZd34lVN47E5q/+p9Kgeayg9
	 YF1wtDBBYNhlwyDOH/L/sYDJWwHZWZGiPWZtqDqLK9bq524h+t6AnDB/d0Bri7HxK4bSK
	 azuMCm0/9arYPlDEAuVzuwr8aOw7Y58Z2dAvscget/nuusODMjjBBR7RZfPXE4Rpfyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790342820;
	bh=fAwTOb6YY9VCxRYGEKOmtMKZA7kHySKut8LyJvJ/Q+g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tnyGLCG934ESvLCKWrxgVQ5GF3l+GNxYiV5yx80PQlHuv0EhWFXcVXXODn0deeo19
	 8fq4rIJDoQewABe0vlSeC1QtePcuW6goYGcy7QMLyPfQFYuxmuOAV0A7nqTvKMjvVl
	 8PdPfxpsM49XrReq3qad+nJPk/E327/MOH0lPfJDJ5JyfH33ahn6zHhB2PAfhDnTWj
	 nEopdjQ1tt5pvVt3CjJNeVrCE0UQKO8aPtsp0zntJJCTq6RRAJALdEKKfQ/ZfJByaR
	 8IzGZ50tXShfTP7mXZ9frx+GloQak9T5rKpSvp6oeg8jLHjadUXsGdR5Yk4nE9R4cC
	 HSsv4+wpCLJbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 753B160BED;
	Fri, 25 Sep 2026 13:27:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D530832F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3DAF40BA7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKUz6n-tyWcP for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 13:26:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 49C4740B2B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790342817;
 b=GoPjKSCeJZuuLFhgncBevWjccLZq+key6M9XYwX8sjmIjbN56KkXF1tMtfYcB2rBr6Pi
 CHiV8EV8WrPJi1lmwnaOwmszjIM1ceLG81KokYRwrC8O9SHVzMJ/pRoat4zdB7HV1hBcO
 VBBP5rADQaMr6v7j+IAhvR3f6SG54vBomkTuCJASr1FKRUqOwQx8iBT5FwMiMBNYU3bGS
 6x4Z6lxYo2Y6wQnGmMif2H2853/1dLQluGANiR49mfFLfJNOjyyGEFzDtOXcv6hTIvuiw
 nRI+TustR08k+P1KYa6u84Nab+fYFA+A0kgRiWNk21407GzzOKnhbCad1wDFP4mDmng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790342817;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=fAwTOb6YY9VCxRYGEKOmtMKZA7kHySKut8LyJvJ/Q+g=;
 b=ki1ecA+YXq75XHNKFc0RNY63YcYND7nSEeCpRcCGA3DMWUFYURltuOEIJcLcGSn9moHF
 Ch4EGEO1VkeR4MfL6GQNNU/pc9YRFNzghbGvVM0F3o3eT9S9CN9ojPCdfwk4DHS4Kh8cM
 +MGIDtILnHWDMqfqzlNK04djJj/wAAw8IALrc8vPUq+gkDZlDFK+GnaPgDI6eOSu+SQAq
 lfIimX9lRxbjtvFQhJS7b5ZbJDsCxlPuEgvnPLLLRnLLGMRYmo5Zs8IU7jkZeradt1EQh
 ttfh2kmhZ5uALLjwoFBA/hlD+2OgX3xajMO/lqCkdc3Pda0rekUcQ6lQ52kNEvRaq/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YvXSNLAy; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YvXSNLAy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49C4740B2B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342818; x=1821878818;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=25UpPq0UPIGVY0w45oEDvCYLB3/iWoNYVuagUka0bWk=;
 b=YvXSNLAyTC1qlelFEJh5gg8u5tei/sg8K94tc2LsDx4VPkoq7Sj+pVb0
 lG7UHsr18H+Kbxn5uiuwaY7KASdmCIac0xiUUiLvR4Xi01rBmOgZI6h+C
 GNQhgJlmxmAJMSoA6AjQgYmbuXhhUQnV8ogbeN6pNcvlk4W0nNEJOj+1N
 gx2oTczoWPEhyx30oAqSqp+kA57CttKjXUYmuhD/8PWUT8CD4XWRBgqlb
 m98dPY/vTCvaruVSR6FVBhMH6X8DmlekRhzS4T+BiU2cvkQPLeSPju1T5
 ylGUFxnuhzdLgBiRMdkV/HBEH0NRpMUbWFWry7QP4eJTSANNQNa8piFCJ A==;
X-CSE-ConnectionGUID: UOyvwdWzSBGu3fj/6ev+Hg==
X-CSE-MsgGUID: i9u6r6kPRDiAu/ooQaGICw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508245"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="107508245"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:26:56 -0700
X-CSE-ConnectionGUID: 2o8/wubERTSf+TOGvGI45Q==
X-CSE-MsgGUID: dWMzvWfVTBuYrZUbE/57hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282414660"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:52 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1FE7F2FC53;
 Fri, 25 Sep 2026 14:26:51 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 0/6] ice: fix stats array overflow via proper realloc
Date: Fri, 25 Sep 2026 15:15:42 +0200
Message-ID: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
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

Fix OOB access to the stats arrays.

The first commit (new in v5) fixes stats code against VSI_CHNL case (ADQ).

Next three commits are simple refactors to make the rest smaller,
the fifth one untangles the logic/lifetime of the stats array entries,
then we have the final fix for OOB access to the stats array (combined
for both PF and VF VSIs.

v5 handles now also the PF VSI stats resizes better, fixing devlink reload
issue reported in v4 by Clashiko.

v0
https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com
v2
https://sashiko.dev/#/message/20260812204619.32253-3-przemyslaw.kitszel%40intel.com
v4 (a resend of ~the same v3)
https://lore.kernel.org/netdev/20260921182106.1015019-1-anthony.l.nguyen@intel.com

Most notable changes in v5 already noted in the cover letter, individual patches
have much more notes.
---


Przemek Kitszel (6):
  ice: skip stats handling for channel VSIs on rebuild
  ice: extract __ice_vsi_free_stats()
  ice: extract ice_vsi_new_stat_arrays()
  ice: extract ice_vsi_get_num_qs()
  ice: rebuild ring stats arrays instead of reallocating them in place
  ice: size ring stats arrays from the final queue count

 drivers/net/ethernet/intel/ice/ice.h     |   8 +-
 drivers/net/ethernet/intel/ice/ice_lib.c | 343 ++++++++++++++---------
 2 files changed, 210 insertions(+), 141 deletions(-)

-- 
2.51.1

