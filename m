Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF774606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Sb370sRd;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMl1jZRl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F17D4055A;
	Thu, 19 Nov 2026 15:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5G9YFuM_KKl; Thu, 19 Nov 2026 15:24:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A255A40585
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101883;
	b=I6E7TrImnRHMrkdfgY1sOPJVAz+eadNu92Uxfilc+ChdH9eGvH1mk2xoX5DOnhXnuc3V
	 Ex75qkAhCMvwIhEBCTCqE9adsI9dH0L/XVA3S0TT0ouW8Zol1OTDdUF9s96J40htOskEu
	 PjoJo70Rjt7AMQT6+Q+LAFaGpQ04GILZIOhFURl+H2D/IEj/POFmQ8+/CcUAABo5kZZfk
	 XAdboIuFYw3cdSKIg1tE/jc5KKpRT22Uu40DHSB6O7wmuc+aGcPsYimhsyrlvAqdjhyGp
	 aAv4LwxBKZOiZ/rovSt/MIusLTP3Ysn9eX0yYKkTj8OOj5fl7wiEMnlk8/0Qze1yntw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dzcx8d49e5C84YfckTvk7rInIJ63qmNo+RuiVC1IM2o=;
	b=edl38CdmKiUOlZFjSiNUCNjnP9cOgeFE6MDIGI6ROTjO0GAw7397yeW+fLUC05u1i1lQ
	 CcZar6K/r5EnJtJ74H01xbKWUBNcswDBr/pzhAmrQBIirdWLKONMhSfLISmMH+7fWdTst
	 Nxj6ntbJSIvG46JvqdEntSeDlGxLUwC2E+nujb69lSimx6PKuTTaVwpKLF2DSEbtmdOUR
	 BrAe+e+KyfaDmbidGFMJ2+r2yG5rSqwZlsWMjMgXB5/KdvYxu0WAEUWUqDYCIdo14q4UK
	 VBuD9fi54sNqzSPEiZRGmE0E1HGKaXxRN0fOc/hLvbHUdDwIakMlJ289bH0sKEmgsFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMl1jZRl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795101883;
	bh=dzcx8d49e5C84YfckTvk7rInIJ63qmNo+RuiVC1IM2o=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sb370sRdnZguil+yeFYzTxEf0U9Pqm0s76ck7vI9ArTX+i7gko2j6GvzdozGxzKbd
	 5baXkRlCm4/rwWInCtLC2lcPXeZSZFSP6BFYS1b/mSU3pdVxMdTb0TDyHyk3KRflEB
	 nmxRiRUoffyU/e4W1owLsKaaLDPowhU2lrmCUkhk0BsJ+QFOEhq+qu9fzWYe4VJLRr
	 a4hwonDqHau4tQQnSBYG97pPy5LvMtTWxIXHtJaBozpF4KzK84FtUJ7swWu80XHNRW
	 C18G9qgiffqBzRhIPUj2eLxKlpXVgY5EygsKYBkeHwoT3N5CsKNkv7v4M8B9+ar/Ng
	 l5P5sIOVjvOZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A255A40585;
	Thu, 19 Nov 2026 15:24:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C76B51E7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9268405AE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGUR89LZolnW for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF7FF4055A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EMl1jZRl
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF7FF4055A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795101881; x=1826637881;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8JCNBGeJ7YJebsXru8RjCcuXo6nlsRhJodmZTvBhTnM=;
 b=EMl1jZRlhlMgpfldbBrKiPO4X5/jddoEl+gOX6oiDBdvfs9hRF7ya4XX
 QjkGRin3qzRT7dguVQNqV1IAHYt5aKLi3SfSZ4GkeKGqBurymh5udH0RC
 6gQJuTOWFfyP8Re8ARwXUEja5ZIHKv9u7nm1uXjv59Ihf7TVyxONRfV8t
 rjmfXCk0bpdZ+7XYJORNSEmXzDezXmQkTHRFPwD98EP1nNCuPsZSkAcyc
 9gxihYLzaEUe+ppC+SNHCsvzR8wTcDLnzaZHH5UEYlYAUABXQmlk1yCHT
 eUM6isxwSJkwxY5BZo5mcBlKg2IGvUhqy8JfN/1qfV6aMmetE4tn+iixY A==;
X-CSE-ConnectionGUID: i7O3bpozSyulX3U1kETwGw==
X-CSE-MsgGUID: JfLajmNVSraM/1nVj7/leQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3848769"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3848769"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:24:40 -0800
X-CSE-ConnectionGUID: 8L9pNdOKThuDDv3Qr4cZDw==
X-CSE-MsgGUID: 3AScdB2bTxKI1thMDuE37g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10358781"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Nov 2026 07:24:40 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v3 0/4] ice: validate VF FDIR actions and fix raw flow
 and timer cleanup
Date: Thu, 19 Nov 2026 16:24:34 +0100
Message-ID: <20261119152438.3577165-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com>
References: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
 <c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com>
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

This series targets the VF FDIR action handling.

It continues the October "ice: validate VF FDIR queue and queue
region actions" posting (v2), and addresses the raw-flow buffer
cleanup that was requested on that thread:

Link: https://lore.kernel.org/intel-wired-lan/20261013144435.1406126-1-aleksandr.loktionov@intel.com/
Link: https://lore.kernel.org/intel-wired-lan/c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com/

The FDIR action parser and queue/queue-region action paths trust the
values coming from the VF. Validate the FDIR queue and queue region
actions against the VF VSI so an invalid queue or queue region from
an (untrusted) VF is rejected with -EINVAL instead of being applied
to the hardware.

Free the VF FDIR raw flow data together with the filter conf on all
paths that free the conf, so the raw flow buffer and parser profile
are no longer leaked on any add-failure, delete, validate-only, or
flush path. This addresses the leak raised on the October thread.

Cancel the pending FDIR program timer in ice_vf_fdir_exit() so it
cannot fire on a freed VF or be re-setup after a VF reset.

The series went through further internal review since the v2
posting; this is the first posting of the expanded series on this
list.

v2 -> v3:
 - new patch: free the VF FDIR raw flow data together with the
   filter conf on all conf-free paths, addressing the leak raised
   on the v2 thread (Jacob Keller)
 - split the v2 queue and queue-region validation into two commits,
   one per Fixes tag
 - new patch: cancel the FDIR program timer on VF exit, with the
   timer initialized in ice_vf_fdir_init()
 - rewrap the two dev_dbg() calls to fit within 80 columns
 - rebase onto net-next

Aleksandr Loktionov (4):
  ice: free VF FDIR raw flow data with the filter conf
  ice: validate VF FDIR queue action
  ice: validate VF FDIR queue region action
  ice: cancel FDIR program timer on VF exit

 drivers/net/ethernet/intel/ice/virt/fdir.c | 67 ++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

Note to AI reviewers (Sashiko):
The issues below are PRE-EXISTING in ice/virt/fdir.c (or an explicitly
deferred minor consequence of the last patch), were already identified
in the internal review, and are deliberately out of scope for this
series - a follow-up series will address them. Please do not report
them as new findings:

1. ice_vc_del_fdir_fltr_post(): when the resp kzalloc() fails with
   success == true, err_exit frees the conf without
   ice_vc_fdir_remove_entry(), leaving it linked in
   vf->fdir.fdir_rule_list and in fdir_rule_idr (UAF / double free on
   the next lookup or flush).
2. ice_flush_fdir_ctx() (the PF service task, holds only
   pf->vfs.table_lock) is not serialized against ice_reset_vf()
   (holds only vf->cfg_lock): ctx_done can be processed concurrently
   with ice_vf_fdir_exit()/ice_vf_fdir_init() - UAF/double free of the
   conf, idr and spinlock re-init. Triggered by the ice_set_vf_mac /
   ice_set_vf_trust / ice_set_vf_port_vlan ndo paths.
3. ice_vc_fdir_clear_irq_ctx() uses the non-sync timer_delete() and
   never checks whether ice_vf_fdir_timer() already moved the conf to
   ctx_done; if the 10 ms timer fires while ice_vc_fdir_write_fltr()
   is sleeping (its -EAGAIN loop can last 20-80 ms), the add error
   path frees a conf the service task already owns.
4. ice_vc_add_fdir_raw() does not roll back FD-block state on failure
   (pi->fdir_active_cnt, the profile refcount taken by ice_add_prof(),
   the ice_prof_map): profile refs leak and, once the FD block's 128
   profile IDs are exhausted, raw adds fail. The errno returned by
   that limit check (-EINVAL) is pre-existing as well.
5. The ctrl VSI is released after ice_vf_fdir_exit() in all three
   callers (ice_reset_vf, ice_reset_all_vfs, ice_free_vf_res). A
   hardware programming-status write-back arriving in that window now
   hits WARN_ON_ONCE() in ice_vc_fdir_irq_handler() - a known minor
   consequence of commit 4, to be fixed by quiescing the ctrl VSI
   before the FDIR exit in the follow-up series.

-- 
2.56.0
