Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E98CA9EC1
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 802A48140A;
	Fri,  9 Oct 2026 21:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yB0Meah6ZR68; Fri,  9 Oct 2026 21:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD1DC812EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791582214;
	b=EZjNx+6xlkg7nZgTTUljfn+lOejO615bYG8JVMQ5iBq21ZItlRw0RvD3KGX3WwFP2TKp
	 cHK1uq3RPQq5t7ul1gw0gKAGoO5w9TMND7op5Cv1/7NE3OLlCaR1bL7KrnGV3XzZriL1P
	 QcQY9vXFwQcRhqgCePNHligWJeCqLCNvc7w/cYwCgizYDZ3f9HnGJK2dXSZm7JybGGEhH
	 nlRZuYSnu3l5UoJzopTQ6pS+2Pc6fnIWBdeJsRGdTAobOv4u/d0WG/FkJ5lU0rWHUgSR7
	 iyUtzJHAXfwFkbHTOGLREB6GwdW5tgAi1q+gF2VLOsxMqV6uciiTYNd929/E0+Uw2lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791582214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2D6YtgIRb1bhEheSOd6yABqf6bekOGV3m7nzB1K26Lk=;
	b=Y+owQJX4ir8UwgUOkI7BbmEsdU9L9shoYEon6tmAcXRsh7c1iPsq4Y5Kf/3E2++5UcDV
	 Zai/3X9KQjTtnOnBsMhDB+vT4EOiyADwcIA100nDBo/1Zh6ekqoQ90oO0b1C4x3830oTF
	 wSK3sVw07rNjsBAiJhoy5uY2YN35dtq8yisck/C28OsLhUpWpItuUDJmGRGbh8+W/pj1E
	 K0WfuH+xf0SOufjI4tSphzjlf0pJErNG0n89WdLR1xi1v6Oum+HoHTEKBy/4ZoCSU9bCq
	 8XqaMmrvvpDl/zSWKVttyroyopAyiKbd7F9CGlprn2tVG63f4axno1W+SmDssXQRITQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RL46ISoB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791582214;
	bh=2D6YtgIRb1bhEheSOd6yABqf6bekOGV3m7nzB1K26Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IeMgbod7B5EKfQ8W8ba6XFCFhHQ5vF+OL8rkCRo55wENpPXv1tXTdMfdtBhyNeCwH
	 x+VBeGK05PqPWGs+IkNfu4PiYIqxToRmbrIhvjx5MGI8zg9VKZe0gJpSxn+9dV5nqS
	 0BlZA2TnKOptuV8tCvxEYX8Z4xT0oFWHYqOKjMog7VyvrRG/4+ftNzQjUOvEpyPyuj
	 1A9JekDdF+2fIKfpQT7zzwzftHmV3Py2pXlhpDOp3oy/AjRtfqHZD227nzD+bAMesb
	 JOLtugUNRcr1Z7F9ObgU9UeVjn3bvj4hDXR1qFNKdjASr/lRpykPiihOldlPJn/CJp
	 2pum2MTQVOqeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD1DC812EE;
	Fri,  9 Oct 2026 21:43:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45A48317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BDAF812AB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yYd1aq4nADQI for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6898381296
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791582211;
 b=cY4/M+QYXWTMPrUmm3mVjYVoe6x4R4THAGA+DERNKrk1h8vjGT4saYQSxF+CCLGWybO6
 mJrtb8sGs3wWEgGbeepxr0opOajzow54Qq0C7uC7KNUuZhh9nTCbmbSaMqbPxP/wNOOGP
 LYtmUmG0C4X52j44zxbIkRRq7I/ELpW+xKG8sHo4fwrSy2rXpUu9T1mfzliiO0pZvKkXT
 rjl9Jq8OW6fltpqvRWkMgMNgasj+41pG+g/zBDBj3jxOav1yG12FSdRufYbe13O3fswGt
 3gsab0L0Ja73q1x6KfAn70s2v/zVr/y79NB9ZNRh7nZsN8t3n3Ws6qaf8WzO5ffw23Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791582211;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=2D6YtgIRb1bhEheSOd6yABqf6bekOGV3m7nzB1K26Lk=;
 b=GO2aVvkBCn2CGso8eRRyBHJ+H6AMPx/nEVjQ0trkadEFHqCvxXkOlg1RISDntckwy5X7
 I5pwiJvpN8iio9519BKHH+xwnqOKcnGdNlqOYukfP6i3hZ2v5l9rQ+AO2Qx0odeOMjG1c
 H25i4Ucav841yUo3tkhrkDJOJslCBD8Mh7BFa24LGl8sDdRMVwikblENRMt2thuLadI/0
 IslXoQavuyvsCyASWvvNmpI4YD9ul6qeqEvMrYBEr4UE7mJzGwsL8daUNiOJ3XA/Uveyr
 ItokaG3x4wvCZHtPpkxI45VaZ7WiwgMODJQFNeuxXewPtBmqW48qn+6xWzl+EyNWuBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RL46ISoB; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RL46ISoB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6898381296
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791582211; x=1823118211;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b3v1jRmKN0XKB504hPvje8iwiGmGvIJpsaPwBhnAvNk=;
 b=RL46ISoBDoSjKfsvkZ8ov2vN7A+oRoCMx2Lobpeqfdv98pMS9pbq2EEm
 xWgQfGxDR5j9isLE8ZWc/c3DkAB3kqLD3LETAIef1aBw053gQJGvDzI2l
 2Jh9/+cT2dcDeRAa6TVAn65gbP1pZzjx21J6E7mnFodQ42JUlmh20utcK
 G3/lwmFCl5BM6GXuqvFhp4xjnvwzbskbV7EnlwVvkSn4FVBbMl6Z2+aH8
 CwDHfTaRBLYcne88pAPEPRGk90A+ibudI0ZDaZU5J5efqh1/3jPEFOHxe
 xrYdQgs8YIzB8dGGRxxqrQUzhCO3XpAAQs6BRYOmGKD9DaWurG6DGkETa A==;
X-CSE-ConnectionGUID: fZ2zjYtyQDC+UYD5NQ0Twg==
X-CSE-MsgGUID: BGIz5TVzQ9+X2XYD6NG+XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="381511"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="381511"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 14:43:29 -0700
X-CSE-ConnectionGUID: 7DAtqTlVTTSmM83ru3s2RA==
X-CSE-MsgGUID: RYH3EiO7SkCsdtAtLkIGfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="366990"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by orviesa001.jf.intel.com with ESMTP; 09 Oct 2026 14:43:29 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: milena.olech@intel.com, konstantin.ilichev@intel.com,
 joshua.a.hay@intel.com, namangulati@google.com, decot@google.com,
 madhu.chittim@intel.com
Subject: [PATCH iwl-net 2/2] idpf: release PTP before freeing vports on the
 init task error path
Date: Fri,  9 Oct 2026 14:25:37 -0700
Message-Id: <20261009212537.3996-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20261009212537.3996-1-emil.s.tantilov@intel.com>
References: <20261009212537.3996-1-emil.s.tantilov@intel.com>
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

Release PTP, which cancels the aux worker, before the unwind frees the
vports, matching the idpf_vc_core_deinit() order. Previously it was
possible for idpf_ptp_update_cached_phctime() which runs via the PTP
auxiliary worker to read a non-NULL but already freed slot, pass its NULL
check, and dereference the freed vport. This can happen on driver load,
where any vport past the first fails to initialize:

  BUG: KASAN: slab-use-after-free in idpf_ptp_update_cached_phctime+0x4ad/0x4d0 [idpf]
  Read of size 8 at addr ff11002129215050 by task ptp3/10120
  ...
  idpf_ptp_update_cached_phctime+0x4ad/0x4d0 [idpf]
  idpf_ptp_do_aux_work+0x37/0x50 [idpf]
  ptp_aux_kworker+0x64/0xd0
  kthread_worker_fn+0x289/0xa20
  ...
  Allocated by task 8820 on cpu 32 at 2113.761375s:
  idpf_init_task+0x321/0x21c0 [idpf]a
  process_one_work+0x917/0x1940
  worker_thread+0x5a5/0xfe0
  ...
  Freed by task 8820 on cpu 32 at 2113.809014s:
  idpf_vport_dealloc+0x8cf/0x16b0 [idpf]
  idpf_init_task+0x245/0x21c0 [idpf]
  process_one_work+0x917/0x1940
  worker_thread+0x5a5/0xfe0

The aux worker is armed in idpf_vc_core_init() before idpf_init_task() is
queued, so it is live throughout a failing init, leading to the scenario
above.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reported-by: Konstantin Ilichev <konstantin.ilichev@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a1c739cdd540..9c541dd6ed4d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1747,6 +1747,8 @@ void idpf_init_task(struct work_struct *work)
 	return;
 
 unwind_vports:
+	idpf_ptp_release(adapter);
+
 	if (default_vport) {
 		for (index = 0; index < adapter->max_vports; index++) {
 			if (adapter->vports[index])
@@ -1760,7 +1762,6 @@ void idpf_init_task(struct work_struct *work)
 		cancel_delayed_work_sync(&adapter->serv_task);
 		cancel_delayed_work_sync(&adapter->mbx_task);
 	}
-	idpf_ptp_release(adapter);
 
 	clear_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
 }
-- 
2.37.3

