Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B1CC88E50
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 11:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0868F60724;
	Fri, 11 Sep 2026 11:39:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZjF3-_5La-Qi; Fri, 11 Sep 2026 11:39:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E9CA06079B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789126754;
	b=i8htNKcu0zAXlq/+P37/I9XjVYMmPhbPRyHDkUt0QhDHkLos/fVrg4UlAbfrHZolJmnj
	 bXok3/yCEDXD4RCpoOVWfUvQifC0udh7kKH/NvSpC0hGePtxVLDdunJ2MjjzM0WLUaVJ4
	 FBNoGO45lx4I0XS0aMdf78TZ8AGxUpLP7I2ZEJIX+JWBcYH47HZxJSh+1l3ddbPiexm++
	 n+J+R/8UYEOa7ueB8DvdDd0vyI32aVg6zgzUwO5+ikOGO7ntt+q2VPwx6sJuqfrLFFZVE
	 Mq7m1YAutQM2AsMc3fLSVdwJnidjf43GLqtBrdYhNZxIAHwDeWBdTqnhO2CQFuuiqEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789126754;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nr9Wn/Jf3qyPCpXU9ZLkTCwVU13rU/vWpUcpXzHYKgw=;
	b=bg92LZp9nTbmnByATC8MYzkwRCDFNG8RknJaVmHIbxWLkTwFFaGRCTsytAT+bkOM1SgM
	 qjcyZBIxVdoXoC++8MikoAXu9kOiQHPnJb7CLeHf4gjQl9fXZfXc2tPUpPls/3b7kbq1m
	 A+wpl1ftO6Jc1zSb+6GfuwJudBUHJlbXrx6mcLM6rzIezeAj7VC369RSUHCiszzPM695a
	 QqT2tRmSHhJZvjXIUa6dZmUg5sfjWxThVcUY/S22xIt/jn7qXcsZBIYlWyGAi2D3ET0Hd
	 RM7YfOHwNFWeQNDjlOos3fHTVLf34k4T0Rke/tjVS9z9ZqfKQ3AbG4XaoKiTsEqqdgg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789126754;
	bh=nr9Wn/Jf3qyPCpXU9ZLkTCwVU13rU/vWpUcpXzHYKgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Xl2eQpOALehyGXxZkyLoKMkxzGxuTIiOmQyYx6MbRuWVvCe5/9Ubm7jOVhOzD9ib
	 bTWqJUfwfpaCgLbu4oSfQ3zqlRw4Hgp8Iw4dMEstA2W52/KpoGFO8ek45Sz/XKkY0K
	 lWWwdEe/Wsktpk6JGF7+k3gHGLwkZ+73IptUk8w0Fs1O6bjUp0mdJXffuqJjGPbOai
	 ll+HLU0orKuj8dGSLKCIHqHMTmwK7e1WdCbZ5dwN6PsH77HLZHfPS6sD+l7/VLV/NH
	 guw7XWZtwJkzItOJBADSZA3/rnlyF4eHuTf8uYvX3xIwU6/JBzSsvRECOz5jkJbIuB
	 khNcBUoe8cdkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9CA06079B;
	Fri, 11 Sep 2026 11:39:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EDD3129B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBA42401DA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D7xQ4mnsy9Qu for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B4C7640479
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789126749;
 b=hrN6BdqY8M/6Fk12A+6PcsKiGXx1n7gIdajyDlUXRgH+bqrFFTNjdpj2FyfJ4LEdylgF
 zuOtU0vgKdwlBuaJgRvYyE563kUll/ZQIFT/LScre8Sbjw75ku9H6i6I3HmZOtAnC3GRJ
 O04gxNullMV3OJ94ZeUTyOCzuY0jUvTL9BnABIrFtaIYn/VacNEudXmW/JFRTvzJBlwqc
 RuXMRRalxViHOYg65I3MxljRnlxoPi06zcmoK9YOv0x55eZnt9HqvHpQ+aa0KqY6t9lAS
 iATzjYxgMrpHSc7JqSQKmxQb129aw+PSf+cNZ+MT+KBs7jMhkM0Ac1cTtsQQXXE+u5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789126749;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nr9Wn/Jf3qyPCpXU9ZLkTCwVU13rU/vWpUcpXzHYKgw=;
 b=CEy2hStRyY3c7XrHWjzOmCZ/PcaUvp+57oyzOGYP2Df31FHDgb8IU4y+G1DodvlF3UmM
 P9sULAujVRWX6W1aKxI2r87mR4Jn4LiwJOjeoSUReTZfBp6zSpJl0P0einy+jyA9zN5EP
 fOU5QuRQ0FM6c+YfhuGKR7DNatVlsKn2+qbpHXSKs645neLdk2fn331/WwT25Ap1eyFo4
 EiMcK02LXne10daLP2o+52KH/OK0dvRMdQDRIqYjr9QMNPOku7uq7kRbIrnRI3yjnpJIt
 BFavz2VzhVSGo70ZQx7SPqwYT9K2LQvByWTKkXGXTJibVKLAZ2ZRXJhAHXhE6FwyooQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Q15Lc78+; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Q15Lc78+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4C7640479
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789126750; x=1820662750;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x+z2E/BXDzu7x4ByXHSGSYxrc17/+WSJzXzxc0RiUG8=;
 b=Q15Lc78+c+rRQd1LO/GCPGyWvg7InMoKDeigGYVV30YTV9VgCQunHVBY
 2LQS9CpynLdum6c+s88c4L4YJjGxT7VV5Z/k+lnH740EsstdLohl4PGSc
 XclbAgCA9ePzQb9o211U2mynCgNpUidqLV/3w9erLRcX/wRlBKwateuLd
 pfLt7qCjVvH8Uhl/zmxc8cTRQeTvhrdR9j2vfOIHMCXXXjbiDzDLDvUEF
 fXPSY13yyp9JME7DqiddoanMxQiHYtLsaJ7Vn7bB+HwFuQhuRNr2AMI6k
 KakKyworfefCUxvWmUTdPF+pUMBQs3LX6mjkc2T/Enyzi4CagRWEjFPk/ w==;
X-CSE-ConnectionGUID: hXRP+CRzTKCCLU9jqmFrLQ==
X-CSE-MsgGUID: G2k14GVeSrC3KFjNC3EDVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359910"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="112359910"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 04:39:08 -0700
X-CSE-ConnectionGUID: O1RGEEIcSXWa/EvhRmElzg==
X-CSE-MsgGUID: 4YTkuS1ATEqtnqInE6CXXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270135865"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:06 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 8083A2877A;
 Fri, 11 Sep 2026 12:39:04 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3 5/5] ice: fix stats array overflow when VF requests
 more queues
Date: Fri, 11 Sep 2026 13:26:20 +0200
Message-ID: <20260911113848.44086-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
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

From: Michal Schmidt <mschmidt@redhat.com>

When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
alloc_txq/alloc_rxq to the new larger value, but
ice_vsi_alloc_stat_arrays() returns early because the stats already
exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
alloc_txq and writes beyond the bounds of the old, smaller
tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
metadata.

KASAN detects the bug:
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
 Read of size 8 at addr ffff88810affea60 by task kworker/u131:7/221

 CPU: 24 UID: 0 PID: 221 Comm: kworker/u131:7 Not tainted 7.1.0-rc1+ #1 PREEMPT(lazy)
 ...
 Workqueue: ice ice_service_task [ice]
 Call Trace:
  <TASK>
  ...
  kasan_report+0xd7/0x120
  ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
  ice_vsi_cfg_def+0x12e2/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_reset_vf+0x858/0xf80 [ice]
  ice_vc_request_qs_msg+0x1da/0x290 [ice]
  ice_vc_process_vf_msg+0xb15/0x1430 [ice]
  __ice_clean_ctrlq+0x70d/0x9d0 [ice]
  ice_service_task+0x840/0xf20 [ice]
  process_one_work+0x690/0xff0
  worker_thread+0x4d9/0xd20
  kthread+0x322/0x410
  ret_from_fork+0x332/0x660
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Allocated by task 2439:
  kasan_save_stack+0x1c/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x96/0xb0
  __kmalloc_noprof+0x1d8/0x580
  ice_vsi_cfg_def+0x115c/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_vsi_setup+0x180/0x320 [ice]
  ice_start_vfs+0x1f3/0x590 [ice]
  ice_ena_vfs+0x66d/0x798 [ice]
  ice_sriov_configure.cold+0xe4/0x121 [ice]
  sriov_numvfs_store+0x279/0x480
  kernfs_fop_write_iter+0x331/0x4f0
  vfs_write+0x4c4/0xe40
  ksys_write+0x10c/0x240
  do_syscall_64+0xd9/0x650
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ffff88810affea40
                which belongs to the cache kmalloc-32 of size 32
 The buggy address is located 0 bytes to the right of
                allocated 32-byte region [ffff88810affea40, ffff88810affea60)
 ...
 ==================================================================

ice_vsi_rebuild() handles this correctly by calling
ice_vsi_resize_stat_arrays() before reconfiguration, but
ice_vf_reconfig_vsi() was missing this call.

Fix by calling ice_vsi_resize_stat_arrays() in ice_vf_reconfig_vsi()
before ice_vsi_decfg(), mirroring the ice_vsi_rebuild() pattern. The
helper sizes the new arrays with ice_vsi_get_num_qs(), which for a VF
reads vf->num_req_qs directly, so there is nothing else to set up for
it.

See the linked RHEL Jira item for a reproducer.

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Closes: https://redhat.atlassian.net/browse/RHEL-164321
Assisted-by: Claude:claude-opus-4-6 semcode
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v3: rebase on top of all the pre-work commits, now there should be neither
    mismatch between the alloc-time and use-time sizes nor regression on
    failed memory allocation
---
 drivers/net/ethernet/intel/ice/ice_lib.h    | 1 +
 drivers/net/ethernet/intel/ice/ice_lib.c    | 2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98dcfe..5236088c320b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -67,6 +67,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi);
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
 
 int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
+int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi);
 int ice_vsi_cfg(struct ice_vsi *vsi);
 struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
 void ice_vsi_free(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 0cd54af40c37..4949f29e538e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3093,7 +3093,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
  *
  * Returns 0 on success and negative value on failure
  */
-static int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
+int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
 {
 	struct ice_vsi_alloc_queues_params qs;
 	struct ice_vsi_stats *old_stat;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 27e4acb1620f..fd70a93b9869 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -268,6 +268,10 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
 
 	vsi->flags = ICE_VSI_FLAG_NO_INIT;
 
+	err = ice_vsi_resize_stat_arrays(vsi);
+	if (err)
+		return err;
+
 	ice_vsi_decfg(vsi);
 	ice_fltr_remove_all(vsi);
 
-- 
2.51.1

