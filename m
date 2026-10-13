Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8EFCC6B10
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 09:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E9E0606E1;
	Tue, 13 Oct 2026 09:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87ZcFlx4CUUz; Tue, 13 Oct 2026 09:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEA956075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882766;
	b=GCK0wtRtbluDDAZDMfDYeDznrWB2oWCwkIZdavj1XEaD+sGrEuoQDJv5BUG8yHyEvvxt
	 QLooCp8E/PfDa4vVvxKOrOmisDxpGgiuNX3EvRV1bC42gOArRcx6Fg34Sxb9quaDiHAtk
	 dYIUaHgFf3hjZLO+n78wVdXFC02sibIPDXMqxIr6yBTopuBrb3ABk4mUQ9m7+CScIFa1t
	 u/HCMH6y7JpRd/A6mpZNN7RT0EQCPdOwIHsUvJbqjeZLOP9TwynbYOr3J0/c01k/z3AN2
	 /U4ffkHKXSoPq/hCMg6iUHthHKamFPj9YMvAMtj+YC9sophMfiklGwc116cc6olG/7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hMpYTZZRidxZi26kjaK60RyDsjLscr4LwSgbTe5BCPA=;
	b=LajxTf70EUskuQPJ0Ai/OuCkBdrliI4//zRyp5K6+zCcVREtpPNoB3W92TooWCA5PppK
	 wjaRWPV3M3oSaBi0u104Q0RRQDAzfcM67cBOG3+G4u7900xVOryGdBj80p1FdFAENZ/PC
	 mUO3ShgsVvzbZHVOZh3RXZtnPObaMqZ+PTeDGmvvhVR/wRnxyTR4LPCJpk+/32TnAy7aP
	 Q2syPA7XBl1iOG5T7WG/VOzNnv6upHEN8OXmIiMRybrQAwhPWs+rIx6/I2WejegMZUuLB
	 9uew4S1e10HxxFsmzi1DsWjUMbne8paYf71mr1cKMEHAymeHs93S+5zsuaE320xw63w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NXH05ck8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791882765;
	bh=hMpYTZZRidxZi26kjaK60RyDsjLscr4LwSgbTe5BCPA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zXl80py8PTu1BUxukQ9qKl8wx/DMbTZpFGve3TuXY6r/gadvgRZETcKXgLBxtLHKo
	 PirVxfX2qJ7XV4J8RoeC1yL8nY7GcnWuV7uayI0z12MqQVmfIt68MNzoYUCDVrpS5l
	 ImMBt+CMXlZHYTY5QVSSXkYj1J60xYt32ViIcDkUVZOK+zlWhzIzzvbiEEl/mNL0mw
	 Kxy73jCYXnLfsRKWe0V69kA+khv6MLqBvobit5DZHuUbWr2ma1SeuZIeQ+R0X7MfgS
	 4RA+UvbYUgBMjDnqXAuiZLUS1OJ/sQNfzb818cc3VTYR7VftanNlhoWSeHukRHGpzz
	 XXQ3CP9SwN1zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEA956075F;
	Tue, 13 Oct 2026 09:12:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 849AE129B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B4DD60693
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNdh8hX33fpq for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6948606CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882762;
 b=rtAQHb129ybdh/pfB/2KheUYg3dnmUIc6akCd1kVvrU+tbQngEy+LYIKOleo9yViic9+
 78tGy+bWYpbqnY2ksqFHdqm/BjzysH3fAFxI+5lhfecy3cbZriE6aTDqNPkE3Vt6uoyaE
 mjsMVzYnJtMxcLbluPiOm/+Goy++j9NQVRi/jZtQMYxeeVkbmdWyzRd86hp/4F8zYrBvJ
 pzxJmqmBB6vLrQwQ4xbOMlsFdcpjQRsgfsIMzRy2TsJXi5C8YmqwHRMYKWO3Cliu0KAS8
 RexpX5RJn9l8fFpC2ApwB6xLqexsD1c5hEHCPugeVpJqQYmDJUBJpRdG+U+QML+QZmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882762;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=hMpYTZZRidxZi26kjaK60RyDsjLscr4LwSgbTe5BCPA=;
 b=JEZ7cglPstJHdfrZ50ojA0m38EFnNj5Xsp24Y5m1HSuCGgq8GuNPp/VViPKtwBRE67VA
 MT4L2nXRVA4qKvR4uXtGUTSQlaT0GrTXyHF1cRuDh4ti2RJ2dav8bAKqTa4UbQa3B3Kjl
 PCfnD+GMZsAU+SRrF5bYlgheETlmPbEMwgRJVknXPf64PGtFUIN5hAaLXiDCp3VwEeZ8+
 MsnXYEw2EuNpO2pWLjGhHx4aGZXWezf18WdGDPvCYUBpHRSe7vVDqqie1hmS+BrvBtz0n
 h+3sZuFwmML7y4tq7RTss6Lgy0QFqX/RQSM7xy+LNazWEXEhfyLu+If60fhSvRpfGRw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NXH05ck8; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NXH05ck8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6948606CF
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791882763; x=1823418763;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=TpgFCoSzEYIkrg+PeuqhXqB3GHzlbfRY9SqjDKu32t8=;
 b=NXH05ck8zrj5G74yd1cj+a+cXKi9ktt29fBu7+KKetYZ/LhxRKUBMkFH
 tD4WF1psVu0ZqkmA4lBd80vskYEv9lX/4gT84MlM6qsTXkEYgst4aER3H
 Ph9fpn6MCrBBhAl6ZqVBp0gRAyBf+CjnqiCzUN2KaB9SqmzG9MvFDnj0r
 rZg+n7TVSLMdSkS39frpMCftJ9B/6Qkn05Ua9V6b3WXRCRktRuqFbsFAn
 gkAoe8UzHssJAqfRNdH8T0LHc+0r8FTW+1QkZN74crcKGOz86uJEmafPi
 LQWefwR0V7rQEq93UaP21hNEMrBsk5w565cIVDIqZQM9atuOqKt0wn9jX Q==;
X-CSE-ConnectionGUID: v+4VEbrNTsW3T9AsS6P8VA==
X-CSE-MsgGUID: /NKTQpozQrGVHmQ+TfF05Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="481270"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="481270"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:12:43 -0700
X-CSE-ConnectionGUID: t+Aax03NSx2HIRyemvHTNw==
X-CSE-MsgGUID: 3F8ne6FWRhu88TqanNf09w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125349"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2026 02:12:42 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH RESEND iwl-net v6 5/7] ice: Document control PF lock ordering
Date: Tue, 13 Oct 2026 09:12:33 +0000
Message-ID: <20261013091235.1423979-6-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
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

Document adapter->ctrl_pf_lock as the outer lifetime lock for TX clock
state and PTP hardware semaphore operations. This makes the existing
ordering constraints visible to future callers and helps avoid nesting
the rwsem below a DPLL lock.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 103ba3e49068..f2c235d849bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -153,10 +153,22 @@ struct ice_dpll {
  * Locking:
  *   Acquisition order (top to bottom):
  *
- *     txclk_notify_rwsem (read)
- *       -> pf->dplls.lock
- *         -> ctrl_pf->dplls.lock
+ *     adapter->ctrl_pf_lock (read)
+ *       -> txclk_notify_rwsem (read)
+ *         -> pf->dplls.lock
+ *           -> ctrl_pf->dplls.lock
  *
+ *   PTP hardware semaphore path:
+ *
+ *     adapter->ps_lock
+ *       -> adapter->ctrl_pf_lock (read)
+ *         -> PFTSYN_SEM
+ *
+ *   - ice_ptp_port_phy_restart() runs with adapter->ps_lock held by its
+ *     caller and reaches ice_ptp_lock() via ice_start_phy_timer_eth56g()
+ *     or ice_start_phy_timer_e82x(), so ctrl_pf_lock is not the outermost
+ *     lock on that path. Never take adapter->ps_lock with ctrl_pf_lock
+ *     held.
  *   - @lock serializes all DPLL state mutations on this PF. When the
  *     controlling PF's lock must also be taken (e.g. updating the shared
  *     tx_refclks usage map), acquire pf->dplls.lock first, then
-- 
2.53.0

