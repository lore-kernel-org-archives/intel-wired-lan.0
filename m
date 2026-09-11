Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8822C88E4C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 11:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95711405CE;
	Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w3DGCkM-b7g2; Fri, 11 Sep 2026 11:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B7380405E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789126749;
	b=e3DJilRXmjOzgm8Vbnqdj2Dmo0evupfVf9x6l2mrNRMSZeS9DXMmF13c5Q2mJNuXYNaK
	 hjo4uqqyRllb4fEf0ZLJA93f712VCRUKPNUduXyU9XGXYizoID7RfUYVP8OZUEVqXcKzC
	 bc6qIbqBYPc7V9LdYEn/13sIABM4NR9Z+mf6PQ4lNHYV6grAGrpAY/N/elXsihihFXsov
	 clcuawQuYomgIJIP/yodTSZO6yU7JnLyA5X7wAPxr4hv91ySPz/7bERlUUU7yV0xWd2F7
	 HPnQVwVJgIw8Ih8aJchd0Nf7n5GKQss0eq5ZLGbCeNhpqKepmTOkrdEP+gB4KTC04KA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789126749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wxHX/b1dfccCfmMvwYHaPpiJbezWTOEyI9QP2P8HukA=;
	b=QyMKa+Ps1pNxYKMcVfrfcXQd+1cAsFfaKlf+0hkskj4iFA+CEdnvEA/aWEivYz16L+pN
	 kSyFowztECqyQRi3GQTJkLB2HwDXV7+B7Q5a0oaadiaBmrs+GPQ3e23cd0uXl9PXPDVdA
	 igHrVyzzoLhAUx1ZAdRJGeBsqPht4/LznQ5ynJ/JXbW0v4QPRxi6bVtVIcC0sPzDhTAJq
	 2eK3dtXhEMpGI/0Acwokh9TCaf1oNIE3Wpt9+3htRFvADrcM8e5C99qDdZfgfX86lolga
	 /G3ytfeVnCLgr5r1M7fKYELUIZKfeskC+u/i19C1IRgkqryIDLyvXwKMryYdOLRMMtw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jTwiqCDJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789126749;
	bh=wxHX/b1dfccCfmMvwYHaPpiJbezWTOEyI9QP2P8HukA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IWR8iJfqi2Kpnp9FZ5doQFRJFRPzD+TnD2SQQ2J4nfeV1j3I2zRU+WX0Lim/rOVUz
	 SqrSEXDc0tzuGbxPWvRXPHC8+3BnMQIiQr6g5++UoWTeoO+s0q3UX1gki9TChY142U
	 cpmGE+FTW3tMno7OjazbBd0BPrAZjoEmW+XVVzctOeVHUX3gn0SmKznzBg2+FdvmUb
	 PjVnz9PVFa2n2OpUrgdGkCQRfpVNzqJTV8P5sWfipN+kOMjzhh0hcLQdMj4YsXAs30
	 Tdr/NBdgf2uCpiEeUPtEFV+OZUwhABo++THtkQszuiTrh4zNR4K4xahsGiOd1ONtCd
	 RiC9BwsZ5xOxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7380405E0;
	Fri, 11 Sep 2026 11:39:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 774F52E3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D341405E0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ByEUg846o20 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 11:39:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 37E28405CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789126746;
 b=iKpJ4hAU6y8sUnEbjL0lXlrbKtEgJrnGvZMd2h0kR0BShaXI+lPfsaWUPuW8tfDms9aL
 679jzBUOYEzLHG+rkUrQefg/bRX5JN35vXE4/6jQYb7vDqT1QNq6e1P17ZJH2Q3X3b/3O
 zHmJUxRHl3nsf4IjHhYIKvSgt2dl7+vLOm0egKkG6nxmJINPWopbV9IfXGWCKwvfOYc57
 DHldEKxRXzm3A2M5X+DKNg380voN6/Bik5wm4r/X2JF0nOpGr8x2xiNsLrfu7kjzM90wX
 p8/9j4atXzwy0aUSmj1qG9nqNv5SDtRI1GUU1LQydiBwbeJK5YWcRSSiXL8roaCvM9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789126746;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=wxHX/b1dfccCfmMvwYHaPpiJbezWTOEyI9QP2P8HukA=;
 b=fK3ykDlFLoou8YU8iQrzTF6jWfomjU0mTX7IXav+/uZzIqkK8GdQECpnNdJyYTHK5lja
 5EeIY94gNFLMrGk4PszY4bhS29j3JXkyxG/Oy9bXWwJjoP2wTbM/TBKu7qUIoT+CpGMJG
 Qhz34KvIFDX4LEw+DGVInUDmCGEUJMpj/MPTTyYKB6exmcza8WPKfImYK7IE7ztfjj2un
 DQyomBfhaMiCsn6OiqiO/Au+ZetTrf+9k2hiBk8TkYkXgU+6VDy1O/mly1Jvjjq5v4W1v
 a0Rnce0IIfAIAwz8s0DVwCjJqeMGqXg1VeSS860Tg1KT/o9NozzVmY93PValWjFsL3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jTwiqCDJ; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jTwiqCDJ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37E28405CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789126746; x=1820662746;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wvNxanIRdQM5aGw3gxWpcPj9WY2QwFj5Iap6gvL5Aes=;
 b=jTwiqCDJPLDa68lQtUAafXb2Ibw+XlduyTAcWlllmrHfKSNjfP1vzJfp
 4HxWr3++c4//eFLu/kTIMdJEeEq0d0J/N4XB7lVVo9c7hIv3CFdpbIdiX
 4WAuryeRLWzaj5hHMUUjqUTwpSE9xVZYpti84cDgudH1Qjr4Ymwdly+VU
 /CUHtC2PIjU/6r3VTaSH/QJrwQWGP/FZRYTB3X5APHcIqCNGle6W6UwcI
 PareTdmE6tYO+uL8eYaCq2gaK1mWvmM5qZdqaOh5ov7tmHucLYk7FIrOY
 d1/zmxcCA1grevMQ9RlTeWasq7qw61aRC0dFWA33c6wI7e+d/KR/9VsIA Q==;
X-CSE-ConnectionGUID: xFHHF/yoRFCkMjrKDYMtEg==
X-CSE-MsgGUID: iZo5SwQMRUC0kup0Fh+fxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359883"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="112359883"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 04:39:04 -0700
X-CSE-ConnectionGUID: LUmrbq0lRBalY3egJKFS2w==
X-CSE-MsgGUID: PKySCI3RQ7mozg7lcFxRZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270135834"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:01 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id EA9062877A;
 Fri, 11 Sep 2026 12:38:59 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3 0/5] ice: fix stats array overflow via proper realloc
Date: Fri, 11 Sep 2026 13:26:15 +0200
Message-ID: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
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

The first three commits are simple refactors to make the rest smaller,
the fourth one untangles the logic/lifetime of the stats array entries,
then we have the final fix by Michal for VF OOB access to the stats array.

Michal's fix was made prior to the rest, I have only slightly changed it
to base it on top of the pre-work commits, that should resolve all the
corner/error cases reported by AI.

The series was made anew vs the [v2], but the goal and spirit is similar,
but I have started from beginning instead of playing whack-a-mole with
yet another corner cases. We are also back to [v0] by Michal, as it turned
out to be more elegant finish with my first four patches already intact.

My intention is a direct apply to net, as this was already (v0, v1, v2) in
the past-iwl loop.

[v0]
https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com

[v2]
https://sashiko.dev/#/message/20260812204619.32253-3-przemyslaw.kitszel%40intel.com

Michal Schmidt (1):
  ice: fix stats array overflow when VF requests more queues

Przemek Kitszel (4):
  ice: extract __ice_vsi_free_stats()
  ice: extract ice_vsi_new_stat_arrays()
  ice: extract ice_vsi_get_num_qs()
  ice: rebuild ring stats arrays instead of reallocating them in place

 drivers/net/ethernet/intel/ice/ice.h        |   8 +-
 drivers/net/ethernet/intel/ice/ice_lib.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c    | 295 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |   4 +
 4 files changed, 183 insertions(+), 125 deletions(-)

-- 
2.51.1

