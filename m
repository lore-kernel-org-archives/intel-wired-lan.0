Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2313FC9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D76D760D95;
	Fri, 25 Sep 2026 23:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4d_6aQfInDHM; Fri, 25 Sep 2026 23:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3A89C60D9B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380698;
	b=N3RHGB/JDVhso8o68xwXVIx1knPzXEr3GUfn/wT8lDpix338xeMVhBgy3LbGj1sUJMXS
	 QPIpSMf8LCXjyRRqlFim9rAhYyFIbgtS2CR49m9ZYTmjSwagh+CIU16UN88E0AvDuor7p
	 z1Jh+j/+j91Io7rEpK09b/cv3x1zfN8DRzS6bstb2pATLq3ed1wejcyuNnC4q705vCDW1
	 bGH+HWN2KCZzTociXoT2L40UUlcEtZzm/aXmjw8iissJVwvaJg0CROmhse82Tal/SW72e
	 T30qS2s8FECDeYDOJ/5nj/kfn0rCxK5q3DTIdHa17gUgV9u5Ka2lWtWcU+y/I3o7vpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6dvqFatX4aGMRDhE+Bbt7oIS/uW3xScwhw0mZNnrrJA=;
	b=m4GrzeBK1y6A2TueubmwHnocBFgA5ZzYGCbmA0zvK1GWbaleO+KMmf9jf9dXKDkHwXmJ
	 aRzkkeDTD7idZLC2KSWDc/wOWVWAxXlaD4f/BeN8ABkAHUYxYArX8zV6EqJLFDAfFUxU6
	 xe9/10ODGkQl4bZW23RooC49PZ7ru8bdrIz4u0QnzBnMlqn6KI1S7p4PdjIlZANdvwWNe
	 gPS60dmJCz5krJMurNIwNgc5zRaTv3GCDE2mx16Ak0cXcv1arCFYLdSJA027EVLbxIbpF
	 9S4aDz1vPn+56JqBj4nWMzb35PZlKH/G0kn/DjuW1k+8PyJUqzjin8pZdLJhvaPh66g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JV3HB7Rg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380698;
	bh=6dvqFatX4aGMRDhE+Bbt7oIS/uW3xScwhw0mZNnrrJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8m/5dQxCB3ceZO+AVO6xDaaw27EzzDkSm+yrZWWJTk56o7s/0FHdJ0JPomcrBVQGu
	 nJ0A0H0j1ar59TQTI2zsV468wuaXI4UArVmPhQ8ZrW2mZBMpkhdvdNKiWcGRjrtg3k
	 kWI+7VkU/RPujUwK4lFdKhDClJ7KoRyTGhIjay0kUZFMu7qFFYeOgs12for5VQFrof
	 PlrqeZ4RRsC4MUe567lqdD2iO+qSSCi8VFqj+qdoOawXAk5YqlLYuMsdyMi+8+SJCP
	 fcyPeudnMyxN7o2/pEgqjNyALrlXjyVm9T4zncGwrmChLz//jzfYbe+xgi3QtdtVDF
	 pYdIYKwyxCikQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A89C60D9B;
	Fri, 25 Sep 2026 23:58:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 95412194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B94460720
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WzeqD-gtyhWC for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B387860D57
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380686;
 b=Yn5HZTcY6a1SAlKovc8MfeFgTUnSRlwsMhrx2WjT5fS53BLQjwJHkCh9PLHD81T9PuNf
 rj81ahkmxznX3PvfkqApzA2j5UxXpmva3yVHVj540vLlwes/bU8kWsimdLiPR4PUOoPY7
 NFiTuJrD2P3LJCzKSnuyJnK8Bh0CKfL0sL99qOcP1cUuqiXiZTLzZxGpNAePLWx+Vig5U
 A7sQsQdFgM2+EQEQYMSbagchZp1cOFuZxDwm9OG9lPatkLRctUyd0xmguLBZBH2D7yXOj
 1YYvcpWKBgUpRboCoK2sgtqD79kpkSiND7hmR3C1L0RDPfxxDWrWOVH40JjbvW1M+pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380686;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=6dvqFatX4aGMRDhE+Bbt7oIS/uW3xScwhw0mZNnrrJA=;
 b=BoP/BSWvbBeZd4NiTOZWcuZRHk7nrQz43tyIH2QMaZ3y9NQS8zKQdIfqvTQ+a/RMscRA
 P0lutSpd9BZePuJ2MI75a//2LNdpsivtw8tQvrhgNqM74YcySRoDxLUN557XE22OzZEWy
 nt+3bIi2ra2CrCV2VeNKw/od1sm1MhnPzO28UB1q6xj7nffvA2wc/h826vqVHtEF0S1h1
 6CFoQy5NAQZB45dHnXHXBE3MnOzWpiSlceKnnxSV9r8eFCxvCVK/erRpRnRqThC/KV16a
 JcS0/Xf8sLanhPJcuhDM40Z06X6lG7aICtUlJWbGknrTCCup306LBesJ/Pt0O3TfLVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JV3HB7Rg; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JV3HB7Rg
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B387860D57
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380687; x=1821916687;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=LModPPid7o56jjXnQSWrDSxAvYC0381c/xaTE7hR/tw=;
 b=JV3HB7Rgq55SFn9oMAUgeLH+ovoMN5kyvP3NdWirFZyiaWxRx5NCF1iB
 lmDx6AiQzEFiH38Omh1NGCvwBD0H7ivoXtPORjK1YIDidxSX9RTzmYtPe
 OpF1yORJSf85ra23Av0LhevHO6qSGNaxlGQeOQ6OkM2tC6d6J8uOw1/of
 D0ImLSUWtMCLTataYZrmWaDn3fYK54iaMrvvE5cOpQPHkNKewl6s11IkP
 g28WqBdIMYqtn8pAzKYEoK+x98H4d5hiAj/PbuJmU0D3HjTmFEFToAKDC
 gdke14XE7WZ3VaDhUU3SBonnn+BYIiYgjqbPTGL5TND+BWUiQza2415jK w==;
X-CSE-ConnectionGUID: svV+iXgZQuCye7ZcdTx5pA==
X-CSE-MsgGUID: X6+u5CPCTQKF/rKQpITvng==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212818"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212818"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:04 -0700
X-CSE-ConnectionGUID: FXuhOE3zQWC2ZgUiOM+G4A==
X-CSE-MsgGUID: W0YQlFROT8erjoK50g7Xig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731139"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:45 -0700
Subject: [PATCH iwl-net v3 13/15] ice: skip reading Tx ready bitmap on
 ports with no timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-13-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=LModPPid7o56jjXnQSWrDSxAvYC0381c/xaTE7hR/tw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXNW2GyZoZnk1dxq/y/p4ROV56sTzKdMX2p1d8OhO9
 NOUN972HaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkVx3D/9BN2wsaZxeuZHff
 7PRRQ+Zp8cW2Ri/2yFnCwl+N5p4umMHIcOrH1U8TNPWWdfUKbeJeY3+bS8u9pbYwp/T/e8XtdeH
 nGQE=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

On E82x devices, the interrupt for Tx timestamps are handled by the clock
owner. When an interrupt with the Tx timestamp cause is fired, the clock
owner PF iterates the list of ports and checks for timestamps across all
ports.

The existing logic reads the PHY timestamp ready bitmap before iterating
the list of in-use timestamp indexes, even for ports which have no
timestamps waiting in the software timestamp tracker. This has a
significant and measurable latency impact on reporting Tx timestamps.

Check the bitmap and exit early in the event that there are no timestamps
waiting on a port. Observant reviewers may notice that the check is done
without acquiring the lock. This is fine, as whether the thread sees or
fails to see a new outstanding timestamp does not affect correctness, only
determining whether or not it should do extra work.

Skipping the check has the highest impact on E822 an E825 devices which
iterate all ports in a single thread, but it is applied universally to all
device types since the extra read is unnecessary regardless.

The average latency of a Tx timestamp is impacted by several factors
including system load, the number of timestamp requests, and some random
factors that are difficult to control. However for comparison on my system
with these changes, while operating ptp4l on a single port with a sync rate
of 16/second:

  Before: mean 317.43 microseconds, standard deviation 34.51
  After: mean 189.71 microseconds, standard deviation 43.24

Of course this level of improvement may not be indicative of a production
setup as one might expect timestamps to be operating out of multiple ports
on the device. However, even in that case an improvement is still likely
depending on the actual timestamp rates.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a5ee8c8edf3d..9dc0b5fa3319 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -576,7 +576,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.56.0.rc0.395.gd1f3524e15dc

