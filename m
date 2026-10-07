Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A423CA5FF1
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45A976081E;
	Wed,  7 Oct 2026 13:17:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rI3lJsOK90fA; Wed,  7 Oct 2026 13:17:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 96D25606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379028;
	b=ffR3OhBT1q2RcCrd3YnjsLU2m79tR9PPOOsvpQjNUkIlXCa9j5gPqgX+1oGWIFN0phXv
	 w0KarVS6FZ8u/CR82LcLg8CP7JUcIxcjrNRCwTFnQ4t4+ucCDEX9iBcddf3FXKpOJn84H
	 3i/KN9/NlC2D1BIHax7bDCXgB8dwF5XqiYfGhzNpJ4aFhIsgp0lyf8d1dnDVCRDUaXcCz
	 YhXJuPK8z5nL+u3ar6De47m001c9Cdxi/xzKp+prldYFBtHTCZLRh5SvMVMR+TtFYdeIm
	 e0aKpUnW1OPHb4xLgbDizetWm05QLg6fxKbpCovUS5tip3Fy7FS/W85lMxsXjmW+Vxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7EfnFTjwrfqrkZ+Gq8QKva8wbGlzTr5LBQnRes/+1oM=;
	b=q4+ETaFz7VZH3xKaT8jxHEwMiG3Zpmc+EcXSdn6+VWMRPVp1W++Llls4+nkuLDl6cc2M
	 pJ216wntLwbtcdmqEGiKCv8uCjMovzqv5DhsAs1NVC73RC108iQOucSeBuylFN/a5olg9
	 Ie8ejL3ln/TCVJ3yVx58r+yv9jY8T8+UT199xvo0TvJ8ObS4GQHGXdAyjLSpqxsvTRnrp
	 MLqDNVDZ5o1Uljdap9ji9SQflN1wHXPFtGcZRXW0PVSHoutwrmQvKDvzznuf6QFY72R/s
	 t2WURSYQYvJ4laHog6Xmct9+A5CyULu5Bs9nMa/489xYnz0eZ8lTOcvxQZReRmHw+oQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791379028;
	bh=7EfnFTjwrfqrkZ+Gq8QKva8wbGlzTr5LBQnRes/+1oM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aIITpfs7O6f7ogzS8T5M8mp8mGXlsjAYwdbYkfOeL5IkKNslbMivs83AepQVPhwK5
	 ajYWg1J58W8tyqo4ABHv0jFHg+g3gOkDrhN+ax4Y0owkxGIWzmM+I3BsaK9ocOnPoJ
	 fB9LTFXLges6NOkHnsrBHs71uAiDUu1YNNDW4J+QA+w3H9mLzHwZMBWnhH+qOsNRBr
	 MsfMsWZXH44qwboWTxJvLLYZ08D0HYWd5rOSLEC+IMxkmWM+AZ/YnTcbB8cqa4CzXt
	 7eMP6iQ3On7k07D7UeKY3wigeimBswa/W035qhhNmZkFhM5E3FsNEEnRA9EJ/DYLL2
	 oopGIEANaTTKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96D25606B0;
	Wed,  7 Oct 2026 13:17:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 75DAA22B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C9E680969
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvTJNwyPjvPR for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 12:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 867B480D91
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791377305;
 b=L0LT8Q9Jbr+yX9swNqMduDseCh42Tw89M5BpOHkcQBs/CE28gDVTkb+CuVEMta8bPqSv
 fwZpAPnBeQG1mzR6PqOy1o6tI3G+FDyjtXjJq8bh+d22j1peOUzRjTjpeC2gibeISw2uq
 3oFK19yuKImyN+zXzcBuWPhE5Q6hZkFA9fRslNXl9iU/hSHMuv/dbLjgfmW3+ddMEEHwj
 b5WtIvx7LDk334iqo0F0XhSz2yRhfDif1ja3ZD9k1ILVQQ44+/B7BzuGjX3Svrjj23OOl
 5f6DfWGExN94NxqzuACNh6x2cm3316iJWmDyeyAZVYzq43nQEVgEXl/ihXww7LzaGCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791377305;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7EfnFTjwrfqrkZ+Gq8QKva8wbGlzTr5LBQnRes/+1oM=;
 b=I1CjaRc2gEoUlXLT8RyYzDCODJnY+nTLnG04Kid4GYmELvhaUotoVlqiamK61kNsxPoH
 QIPDGySIWXMiPb05BW5ZuzTaUFgSry/oxHT/eV//YtTYT01RAJ3OxGEsZ1aiPCD2yzcAd
 6+2Tq+QzZU+gKP4J2Z9VJg2LaZpN/mUUUDMfb3pMtZEBIc8n73dwnlpPFlcmagYs21Lpx
 6A0jAfgG0YGKtgC7x9D0zMBSLmX9ZCLqj+UqcZ43UbMZt5E5x3dMabLFQcorASl/U651q
 215srjN89UtSgQqKIry8eT7EPnQ+zvsN4Yk5F3lUBtPpx3auRt5rpF4QpjxYyVlB9sw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Vw3NhRHL; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Vw3NhRHL
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 867B480D91
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791377306; x=1822913306;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=u/ilxP4SZzxr1TQ9vRilSrEEMKqtoey+NUCZ2jC/VNA=;
 b=Vw3NhRHLE7hv7r1IaH6PhX0lAY0e/iWctBRmWtlB4GVlWYC7Au2A5Irz
 DDi7yc7NkCHCJOh1iiju2SIxA2LqgPeV2t1qxDAYn4zleWfRSVThRP+9m
 nD8mqgHD2AehZqnWDcvMmMuXr8eJvqGSBhD4lP91pd8XeMMkku5HZHhzv
 6jozWam5Z2dEjV4+k/6eDbl9qG7hNPz53Pf/MvaZtA/vOudYvKgbGZZVH
 FS7kZsBsAXoq+bhaFj+c7I4ry2Xxk4eZiw3lGkbKbhH3J3LWsBeUDxa7h
 p+rRasSnjY119RW9NkgLlyffC5bArUhQPQ1SxVSjKtLDBsTvCmnXSOyIm Q==;
X-CSE-ConnectionGUID: 7PsIbZoLTDSrGvB82yJcgA==
X-CSE-MsgGUID: MzMqw9c3SJizT4H9MP7omw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="31584"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="31584"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 05:48:25 -0700
X-CSE-ConnectionGUID: 1R7YEEYpQZyyngYTmtSJwA==
X-CSE-MsgGUID: kI5Fd59VQNKnTIg3qP/nhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281191707"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 07 Oct 2026 05:48:25 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v6 5/7] ice: Document control PF lock ordering
Date: Wed,  7 Oct 2026 12:48:17 +0000
Message-ID: <20261007124819.1074675-6-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
References: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
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
index 641b02b0296a..30767f209cd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -164,13 +164,25 @@ struct ice_dpll {
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
  *     health_notify_rwsem (read)
  *       -> pf->dplls.lock
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

