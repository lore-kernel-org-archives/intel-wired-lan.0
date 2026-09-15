Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6A5C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D33080DD3;
	Tue, 15 Sep 2026 12:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkQ1Z_p7BWi6; Tue, 15 Sep 2026 12:55:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8949F809CF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476935;
	b=inlwA1fqWdbT3DjkUOy/FhF0OeCnDpBMbO+oq2T3adt+c7RjwQbIG853a+4aCaPbZ+Gi
	 fETHjJdYuI1FM+AzAz2nSjSoybbOPIPAcb9x8elHqmYVYMKFpLVGx8EqnXFvCktYYBfOA
	 qZIbBkjoh4eFa77SppGhbLndYH32dX+FmE2dpPifkMPmAyfQxb7XbRdyAa4H1XwJTwol0
	 SThftqpsqXGSTp5t34p1TJNDYqTBcBgoJerdXqFDHy8eDGJHCP4uQvkAaObX4uQUj8jup
	 OSO2i09+qAglwfBqfa1dl2STBh5XTd4pXSWRI3pTbrwD072Ans4A9BdMWdJnnflDcqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476935;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f6BClYjhR0BvXb2+59ranMvyK11Alfc/ee4WvaUclIA=;
	b=bhSSIG9QvDWioOq1VMd5U3OemXp9+NL39NBB42rsHTE6wGw66jwWCW9x8BsgcVQLqCKD
	 BBPRCHZ8/6SFCr9J9fzG5A4vf2ZjoARC0Ud1vm1Bfe/+DYHv8McQPR6PTTd/onJIKk+pr
	 JvdJI2SYNNHQx+/+IWan7RzqTB7vukCHM0AkESXe09XpEDWasaeWZ0YjnkCtZFylcSGC0
	 reROEBBO6fb21hzi0v+BIFWfHY0vhmUD61VrMS3YEFamdjlby8JSJabp3ebn1OS7e07VR
	 kYpLnCi6FB284vN43YI7CsVO5fRnX6cjuAeYoptePycSZaw2dXkgOKPSrXVPqpuO8Eg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476935;
	bh=f6BClYjhR0BvXb2+59ranMvyK11Alfc/ee4WvaUclIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eHh+94ApuIr8FxYOgv0Y75BMAysScErYK1EIFUNHyD+RUYNUh+xhGLSogTlmA8EpG
	 6oSniU6iYXzdX2z++Uq14VM7WbAt1pVe2uT3tMMj8EyDb4JwF+nXfR1Myx+r0qaPGG
	 zJKqQAErNwOK/n2TJ9kJUO/MY50JfaOLlonW6hv3QPat692quc84W438mRTvZ7HGyq
	 bFzu3CM0WphQ0LQGaHjw9oxSKoDBvANp1toSzVO0w5MN30zlykBJQolxjKeXkLXxYs
	 2WWrtB6gr4rFtmWgK9i5Syl/eznBVLtg5VPbTeQj7VqDD6Tdm7thhROvpstDSRTAHl
	 Uc8tGDzbc/S7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8949F809CF;
	Tue, 15 Sep 2026 12:55:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EC23493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90E5C4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dEeFdgyexOT0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 04A764002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476933;
 b=hjGQqatCsepWK1TGMXFMGe+hBIJj5ACnMzoqfgkR8rPme9iyQBfqV/qwNewaeLj7oiUo
 6YPMaNJxANwq5L+R0erQQZO0JXjYPOcCd8rsKgRJO5E2tOkbynP0NfuP6J8JMJ9kGkiSM
 FUm5SzvJgo3wy/+T50JMYKj2LVDedyx9dBn7LXs25/Xd0oJTgIIAAvfFGdUYgBNmqgRyC
 6Gd6bwX0akl2qR2vd9zif4IWm3FJhUgdpZeO+nQkoUjFj9/s+5AylT5/mWWab/TlmlzG/
 lfV9RSYkkpkM/NKK7lPzcfT1G6tPvZTYxRT1baeIu84iBF12YgNeV5NiK+tXLC7IzwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476933;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=f6BClYjhR0BvXb2+59ranMvyK11Alfc/ee4WvaUclIA=;
 b=YvucTG6xe8rMBnDW7szbPV65yxiHpz+E3NNGgnR7wi8wAy78tLi7KCr0Z3f1DrR6T7ON
 A82yAMBXviWaoP1q+M3TWhdUn8MCimAEkLVei5litJ2BX3LP6IwsW7eacbBQSrYO7JtNw
 K+SC8B4C2fK0i6PPTNoSwLpS4jHm20yJQ4TFrmSE7D2SluyYqKpc/BYdFF/ggD7Wc94Ja
 BFn5JVOyLwnHKnA8IwY9EPNUoPWjLXxCAUMxAnHeYXVKHPmIb8zR2QnL6UNYPAAR9fiRk
 wBxW7AjgORnH1UC06lRn1NQuTKXPZ+oMXx8GWmzFzbQQE2zT8yt6tBrdTYzgJ60Us6w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OYZEt3SR; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OYZEt3SR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04A764002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476933; x=1821012933;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QbXm+JwgBf8365ZN3NtaaxWY/NhmO4xPGoE/XzAJmhI=;
 b=OYZEt3SRHpksGncR+uKwSYRi11Cs+oGgWS4goLIyG889dB4ounEZY8Jz
 qWmWXxzcSeILqPUNIVHOE5Sznr7JqcNEUbDGiyJhmtymR80oPvKEgG4PC
 0hGxyQgHj3YVdqFYsdoOKZMPSiSk0UEEgLlzWNXki3bxyjD2zKlYTI1wS
 OYeahBCg/ReY+6LAjZIredVWn7+aCrm+wxe5Y/WFPjyWOVC1mXbHYezzn
 +QnO7T2IDk3bnGm8nlc4ozbQ70UHXJprgiNvZ1ixHR2OR0uJi0OeffyBu
 QBUNBtUcIHPoi9pkl1uW3PCyFr1W0iM7xviun0jEmadYkjWBIxZx5QT7f Q==;
X-CSE-ConnectionGUID: Xnh8u9AfTje0JenuZJHktw==
X-CSE-MsgGUID: 1HqHt83ZSZKX89M2+NVxXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853103"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853103"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:33 -0700
X-CSE-ConnectionGUID: pTgahotrQbupyL3qGrp0ww==
X-CSE-MsgGUID: mgikFVEPRIeVfRK9SXRZRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225176"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:32 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: [PATCH iwl-net v2 1/3] ice: fix asymmetric pause negotiation
 reporting in ethtool
Date: Tue, 15 Sep 2026 14:55:27 +0200
Message-ID: <20260915125529.3975723-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
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

From: Tomasz Lichwala <tomasz.lichwala@intel.com>

Add Asym_Pause to the supported link modes so that asymmetric pause
negotiation is properly reported via ethtool. Without Asym_Pause in
the supported modes, 'ethtool -a' incorrectly shows 'RX/TX negotiated: off'
for asymmetric pause configurations, even when pause is properly
negotiated and functional at the hardware level.

Fixes: 5a056cd7ead2 ("ice: add lp_advertising flow control support")
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bf9a821..a257b7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2365,8 +2365,9 @@ ice_get_link_ksettings(struct net_device *netdev,
 		break;
 	}
 
-	/* flow control is symmetric and always supported */
+	/* flow control is symmetric or asymmetric and always supported */
 	ethtool_link_ksettings_add_link_mode(ks, supported, Pause);
+	ethtool_link_ksettings_add_link_mode(ks, supported, Asym_Pause);
 
 	caps = kzalloc_obj(*caps);
 	if (!caps)
-- 
2.52.0

