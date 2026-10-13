Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B4FCC6B08
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 09:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94F2B80AA3;
	Tue, 13 Oct 2026 09:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ivg91WWpaSTT; Tue, 13 Oct 2026 09:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0049C80BED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882773;
	b=Yae0wYn2XoPEl/kPg5qHFS5RJ111mLDqbZoGaJamq4jFiP3pORAp5dM4LrTN7o77WUdg
	 EF/IQy1a3GWDe9XOZgWQsLCmwCWexfEYHQPJEmo9f66lb88jl9dVg6sxjCEp/WbFTdzN7
	 jDAWoYKi6mtUK1JFMnI8kd91tQcLFlaVxNK4OutdYfNjKk8JVbEbUXYfXZGOFrmfuVQdN
	 zjoqXkNK+PJKwHCTkR1VU/m0YYUYX4ae1VKDAqKykl0hsjf5PGv0W5b037SEoP6njaL0a
	 wo8a/UZAj8yH6F11LP3hjX55ZypNj0lofb2i/apzdkzy9J8+udA0Xe6xp5NNEO6TRcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wTwyNySPCV3a2nuco5ptdAqgJTZzVg9TKCQ4kvjo9Dw=;
	b=Uzyyiqd86XDPnPwpRDArTxf+kvaWb7iKq9JKuGxYX4Gs5FQaXhuMCGIjXZzvqX/qrt0V
	 kinJPcxqo+N/1VWohfhxpdd1zOD5u93vGvmhoGmm7+ITNDgI0ne5Uu3t2lTW1yIY3wajM
	 +1JxHknzFjI8y9goPZhzD9UBGXonuB+2+a61N07vdEv5XsJiZv4R19bDE3OPtp97zb9ic
	 rz5b05kB1L8o6zv1IAV288Fe/vhirDM24Yfhh6Yp+cSBZYtbNaXcIh+vm66KhYrLPzUbl
	 U9Svmd4GDHjbhbwWdzDeeEeXLJwY2JPiEzwaM0JTo9Fi54/+pZ6YCs31Mv7ppR2IZ3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791882773;
	bh=wTwyNySPCV3a2nuco5ptdAqgJTZzVg9TKCQ4kvjo9Dw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6fTZbzpeLfPET3k2X0YGFBN/loSp7yrazRW72uBkax8gI+/sqI2rHCx0yS2b45f9c
	 rbEbs6BcbGY5n6oPhcUcGVE6FHt+n7aaGiYyQpPUG9fnDb7G+w/iV6kDGmroovWVdu
	 TZbJTVlOQyRb98pJ6ngphDrokAdk/69Dti/kbXPeHDHmgJWYkbKsduXDk5bmsumFxQ
	 Fp6B+X/UERSwYsNKCx6mS/c7/mba7dLroo91YmogIa9jLM+jjAiqr047h58+saySLQ
	 Yts9EFJsHfXR3yS8Fh/u0SfYaHOb9UkAvenXrfz1smpR3n9ZT8WjKTErzodje4Lqj3
	 mBDzYPfqL07Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0049C80BED;
	Tue, 13 Oct 2026 09:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F4434DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CEE6606D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qSzu9k7r3P2z for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 09:12:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7AC12606AF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882764;
 b=c+kXIK6Y0AEOR2A0ptK+EL9pT4hgycRlLUl0yH64O+YVjdggz6vtaKI9ZRXLi4P7oWAa
 TBsZx+Grv1eiX1Y0DaFHOIADr07cPaj6CNO5JuswtV/ZA/rgQ20IabHpMSPJSpJtzckrf
 WYBix64hryQSYZKjB9aKY9P3w3+tbfgIme5J9vsMRU2nwr3bkB5/htQroSvK2nzZUSu0/
 EYcOTD6mwp6PpNNQPQxY+IGZbbSZphRA9BA2nT/ywJp33xv9Ra24d4C/OtMl+gBDvoFkL
 inX0Obsm3HdM/P8GqhgjTMz77nQFHDIxpmIDFR9ItrCtci7IjqzLo1MMrTlaZ1Fh6CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882764;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=wTwyNySPCV3a2nuco5ptdAqgJTZzVg9TKCQ4kvjo9Dw=;
 b=sg7ElnIVjHniVtiN/N23OZ8Fy+9hJVbnv1gcRLUbmbYXFf20KNToQ852yTfwlpcT36j+
 WXfGg77quqk4Y0TStzMMSFFdNnMS1xEiIbKlz4LWpDbsY2c9O+9hr3u5h4Z0ifQ9fjdDG
 J5PCtFp9vdLBYeLuavoJ8x4K7S3kWR7AuVqEngtuHlSlMLKtZVuUqAAwaCowfRYbsR8ck
 Cv7jClx+t1sLWsxvB/NBbpVAqAzPUGsLetk3K6Gr1KyiZ0rzGt3NTuF5sht5+KSYEyVhh
 UsQwUZYcsJwy7AYRDZle56CCVRifWpwfWWcHyczwXa2Pi/K0kVpzpTegDEHtlB7m78w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EEWwFrOK; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EEWwFrOK
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7AC12606AF
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 09:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791882765; x=1823418765;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=bnEehlojFdYuCfDE8aSNEldaQV65xVSPPlDeWyIPHPo=;
 b=EEWwFrOKgRHtriTMzhDnB99i6OMwP5bCoyXwaaXy5MZfbSkBbDgygmdn
 SUkd/VOVaoWxA8AYHUns4EGKAvm9W56Qe4puTKMmpOUsdoFuY7xTL33aL
 jAwXFHDLxGnIcyX+ylZ6ZPALlomU6mumdMb92cAyly6piQSwzIgnzm5aC
 O8ppy80ybXHcnk5wDusJCcpaOZYRctP2mXJ67LmGd0cYx65o3kOLpF5+v
 j59NOJ6T0K3i26TiJ2Q5DpmRKfYtT8QL+WQDHAzpRgKmnl0I6DW5mGd3j
 YdC7PxtKuw54J0A3IC/K4ATxgc00xz6r2o6E+gb/lsc3TMDvryeoU6Ahk A==;
X-CSE-ConnectionGUID: NIS+tpwPTIeQT2Kv17Fd8Q==
X-CSE-MsgGUID: U0UCAU7CQUC0pNaoNjCUIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="481273"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="481273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:12:45 -0700
X-CSE-ConnectionGUID: dyDCkiywRz6L3H0bMWfgLA==
X-CSE-MsgGUID: 7abIClYdRWeGcV0A9tiMqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125351"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2026 02:12:44 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH RESEND iwl-net v6 7/7] ice: Release control PF lock before RCU
 wait
Date: Tue, 13 Oct 2026 09:12:35 +0000
Message-ID: <20261013091235.1423979-8-sergey.temerkhanov@intel.com>
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

Clear ctrl_pf while holding ctrl_pf_lock for write, but release the
rwsem before waiting for pre-existing RCU readers. The published NULL
already prevents new readers from acquiring the retiring PF, so holding
the writer lock through synchronize_rcu() only stalls sleepable users.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a8b5e9b2f2ca..ffc9f31ae47c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3302,16 +3302,21 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
 
 static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
 {
-	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+	bool synchronize = false;
 
-	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
-	 * is being removed to prevent any secondary PFs from accessing
-	 * it after it is deleted.
-	 */
-	if (ice_get_ctrl_pf(pf) == pf) {
-		rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
-		synchronize_rcu();
+	scoped_guard(rwsem_write, &pf->adapter->ctrl_pf_lock) {
+		/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+		 * is being removed to prevent any secondary PFs from accessing
+		 * it after it is deleted.
+		 */
+		if (ice_get_ctrl_pf(pf) == pf) {
+			rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
+			synchronize = true;
+		}
 	}
+
+	if (synchronize)
+		synchronize_rcu();
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
-- 
2.53.0

