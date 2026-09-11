Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006A6C88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A642F60602;
	Fri, 11 Sep 2026 13:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cV95SM2aVDnY; Fri, 11 Sep 2026 13:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 86D6460644
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133455;
	b=UfrGha6doNNv1EfnaDyAcWetWWceEmj9BrW9WMFX/1dG08r5P8ncNuyF7RFuT7fpMS1K
	 JP6SQM/0Cbir+ABb5do40qSInmP5yh8tN4s3zzBMRu6ggor4MuSYz8e5+rShHLav4k6Um
	 np8d1i6IaK2kE3nJMCBPM9lQ5Gh8UWz1sHXBZXk1keZ/IlR9zo2jUqEHNp6M4JFA28b+l
	 IzDCbNlfH8Ez6m3aX2K67rmZ2Xxu2eBAQzStiwYblcngLxy6RbWPNIp6eWikw1DgrH1x1
	 ACV9rp2LIz1Nd3z/BzYdYl4TaS62hfjAaJYsRuf05oeDEjViOD8t8oZ4VLhRV30nOjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Gfk1qs6Erb/ifbCANLTQxTgj1ELxRKiMQM4x57I17dU=;
	b=NFYMdpDSfAdVe/zt8ekJnCqIoymOFwigrqDJR/TTcTfoTvfwev7b4M17Gtdj/3Kbu5kp
	 hC0yjrUBQwk3HoP/px66zGxhz8izFZ88I+csgfHWl5BniUVznkjJHmPEgAhJEVz1Lm4tV
	 sFDZTlsD0/OPHI1qjrxbkgCYbdN38mBOE+IyoRUUYfksuveyslAQ+Ae3ah3TiXzPDazCN
	 P2k1759+JVWxKE/6DqmQWkop2dxYTIwJkkbDk7RV+PFESnWtUrs4Ysi1T4QjSD0L8/GnE
	 Cq0XlxeAdHGuiLbYPFl1NLlidX3z7EIvXUhtAvhNCocIOtzf0CGlqqVlcvg4Gsbd+eA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133455;
	bh=Gfk1qs6Erb/ifbCANLTQxTgj1ELxRKiMQM4x57I17dU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IwJHENeWJKW/BBxGRJNybPojO1Oz7qpJ0Gg3JXmZH/mAllB/NCaW9u2hp2h1cDJan
	 vpsqhvPNt8d6WR3H/bAs6ARICv32zkBtVql2073r1JwYvKgkBVcn+ugAQYOhP+pwyS
	 xD6L34SDx7FF1rzPZlyqS6Bt7gKGaw4BiI3kcfojlkTubuEbD/THNjEeKCJJl9Llb+
	 cOoF9pZCowcbsmi6Z60BxFImCvxi73xril5ZgKt6EX7xa8jT+18xBjErKIp49gFHUf
	 TcTTPNuaxi85pgWlLbMzkt9Zq4Uod5ePIrgbIA4cRXe1u1ucrxy4ERzPCVQaqOoO4t
	 Q6ZzIijpD50Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86D6460644;
	Fri, 11 Sep 2026 13:30:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A485732F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95F7340811
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTWqEeXRTsbp for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:30:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1046F40607
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133453;
 b=p8uKDqw+23TXxyeWM0D3FZejk7Qrpb1cYurYmR75N/6blBepobuL3iZ7Xv30DH+bURHv
 090YIILTRQVmI0Eu8+Ty4RoR1XR8PFtXXMo0yHidR4HgLl8iv+FKZmCvhI1SRbsSCRmDs
 eYeQyZo5Qbwd3AODy/khzeuFUb3ukb89T54z8Gje/de9KBxIIngSOFKnej6+YX3zteVT3
 8yacogArMaDz9OolvJI3jLK4Ha/wnlq+1BB3iHwnscOfXAbesgxlZeDQzR8AuemUBwml+
 xQ5I/KJS2vQ8OtOOOmUSMN5LLEaU1BQ9HLXrmNLkzStBB2+PHHSPZCLmKQNGr6j2SJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133453;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-IronPort-AV:Received:
 X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=Gfk1qs6Erb/ifbCANLTQxTgj1ELxRKiMQM4x57I17dU=;
 b=oYviT8VEl+5dibkv8dfi08OL67W9equLNWm50vH+9+7pagtWwW3R2+ntWSwcKwvB9nlc
 vkAt9oP9nYFsZQhOFhY9W//bd+7yGuP1y4g/LZczG7qaNEbU9E5hSyQ9H9nA2pm6gpe/t
 cfDfzcN8yL2ms9RpPZ/EpD6JMsORRT7ceuNGKg4a/9kZVSWsXnKfw8KWHYPTU4v4EndhR
 JsFzqCCofITPtOSdPqxsZi0btqII0h7nZTqgip8hBuP/GeHlStcJbzGu123VM6qmbLPIy
 dPM9r+ffD91gxJBAVjtNtXgyxSZJXBjJCjvX3NCMhWytCsCB5gOMepT0ceIhGye3xOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZIHx9yOq; 
 arc=none smtp.remote-ip=192.198.163.4
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 11 Sep 2026 13:30:52 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZIHx9yOq
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1046F40607
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133453; x=1820669453;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LrZ2ncNwR8m2BBw2Loy6xydWlmptaQWowFJKwOnP7Wo=;
 b=ZIHx9yOqJAwaiQ7O+I85hupmapmXPJb0dfG9cOYGZpvUbmNeguG/RyJ8
 ujmwObhg4JlIzZ7cX57yrdtOYLURTSpvC9v3svHNxMJOckh25kzXRrg8D
 BEdDh7ccopiUS3gM52j97O9uE2cyChhDUBUTi9SAR6Z8pCXtxjW0/hOmT
 VIH1QFEvQXMZDvFdg02AtGrZEmsJOieJvIjOAeJsUvT6dxBR+zqbTvTig
 XJCBx09jTLLF7WRRvMBb/eQ9blRbf7PI9bKXr5fbcAMPtnGqToAdw5MV8
 3IfqfWssrLnykbqY5iVNqXCoPBTXtsJwu7OJtayYNdT6MnCxRgZJpyBTS w==;
X-CSE-ConnectionGUID: MCeZFCQPT5aB11ReRQASfg==
X-CSE-MsgGUID: I5CkeGkNQueHG+QUCVvJ0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107519"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107519"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:29:49 -0700
X-CSE-ConnectionGUID: a20Sxac6Q8aiYkvWGy0IfA==
X-CSE-MsgGUID: WJO6pqH3TPSzCJ7rnXWpVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541252"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:49 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 00/10] Interrupts helper in libie
Date: Fri, 11 Sep 2026 14:49:11 +0200
Message-ID: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
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

Hi,

To not copy the same code to handle interrupts in ixd driver move it to
libie_irq module and use in both idpf and ixd.

First part is changing current idpf code to make it more friendly to be
moved to the lib. Basically there is no need to store MSI-X entries in
separate table. Instead of that store it in xarray which also replace
custom lifo implementation.

Patch with libie is about moving the code to the new module. No
functional changes here, just moving the code or adding some more
descriptions.

The irq code is similar in ice. One patch also coverd the changes in ice
driver.

Last patches is the implementation in ixd driver. To manage MSI-X it
needs to first map correct regions. Do this using virtchnl command,
similiary as in idpf.

v1 --> v2: [1]
* patch 05
- New struct idpf_rdma_irq { entries, map, num } replaces
  adapter->rdma_msix_entries and adapter->num_rdma_msix_entries.
  idpf_idc.c is now touched by this patch to follow the rename.
- Removed the idpf_rdma_entry_to_index() helper. v1 reverse-looked-up the
  libie index from msix_entry.entry on every free; v2 stores the
  struct msi_map directly in rdma_irq->map[].
- idpf_rdma_intr_init() now allocates rdma_irq->map as well and unwinds
  both arrays on failure; idpf_rdma_intr_free() frees both.
- libie_irq_deinit() sets irq->pdev = NULL at the end.
- libie_get_irq() gains an "if (!irq->pdev) return NULL;" guard.
- libie_irq_free() guard changed from "if (!map.virq || map.index < 0)"
  to "if (map.virq <= 0 || map.index < 0)".
- idpf_vport_intr_alloc(): tmp_irqs changed from __free(kfree) to a plain
  pointer with an explicit kfree() on every error path and on success;
  loop variable i hoisted to function scope.
- idpf_mb_intr_init(): the libie_irq_alloc() call moved above the index
  check (cosmetic).

* patch 06
- Dropped Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>.
- Otherwise only context churn from the idpf_rdma_irq change in patch 05.

* patch 07
- Dropped Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>.
- include/linux/net/intel/libie/irq.h no longer includes
  <linux/net/intel/virtchnl2.h>; it forward declares
  struct virtchnl2_get_capabilities and struct virtchnl2_alloc_vectors
  instead.

* patch 08
- Commit message corrected. v1 claimed the allocation order was
  preserved

- LIBIE_IRQ_ANY is now introduced here rather than in patch 05: the enum
  value, the kernel-doc entries, and the struct xa_limit local plus the
  dynamic-then-static fallback in libie_get_irq() all moved into this
  patch.

* patch 09
- Removed the hardcoded PF_PCI_0/1/2 offset and size defines from
  ixd_lan_regs.h and the static ixd_running_regions[] table.
  ixd_iomap_running_regions() now computes the three ranges around the
  mailbox and reset registers from PF_FW_MBX, PFGEN_RTRIG and
  pci_resource_len().
- ixd_start_regions[] made static, with a comment explaining it stays
  mapped for the whole driver life.
- uint i -> unsigned int i in ixd_iomap_is_not_start_region().
- New ixd_fill_caps() requests VIRTCHNL2_CAP_LAN_MEMORY_REGIONS in
  GET_CAPS, and new ixd_is_cap_ena() helper. ixd_vc_dev_init() now
  selects the path based on the negotiated capability instead of sending
  the command and falling back on error.
- ixd_handle_lan_mmio_regions(): bounds check uses
  struct_size(recv_mmio, mem_reg, num_regions) instead of the open-coded
  sizeof() + sizeof() * n; zero-size padding regions are skipped; the
  unused err variable is gone.

* patch 10
- Register addresses are resolved once and cached in the new
  adapter->mb_dyn_ctl and adapter->oicr_ena via the new
  ixd_mailbox_irq_regs_init(), with a NULL check returning -EINVAL. v1
  called libie_pci_get_mmio_addr() on every enable with no NULL check.
- New ixd_mailbox_irq_disable().
- ixd_mailbox_irq_deinit() rewritten: early return on the flag, disable
  the interrupt in HW, then cancel_delayed_work_sync(&adapter->mbx_task)
  before free_irq(). v1 instead re-queued mbx_task after freeing the irq.
- ixd_mailbox_irq_init() now handles kasprintf() returning NULL (frees
  the libie irq, returns -ENOMEM). v1 passed a possibly NULL name to
  request_irq().
- ixd_remove(): ixd_deinit_interrupts() moved earlier, before
  libie_ctlq_xn_shutdown() and ixd_trigger_reset(), instead of after
  them.

[1] https://lore.kernel.org/netdev/20260907102418.2697317-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (10):
  idpf: store HW vectors information
  idpf: fill q_vector interrupt registers one by one
  idpf: get rid of msix_entries array
  idpf: drop v_idx from q_vector structure
  libie, idpf: move irq code to libie
  libie, idpf: move hardware irq info struct to libie
  libie, idpf: move parsing alloc vectors command to libie
  ice: use libie_irq for interrupts managing
  ixd: support for getting lan memory regions
  ixd: use interrupt for mailbox communication

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   5 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_irq.c      | 181 +-------
 drivers/net/ethernet/intel/ice/ice_irq.h      |  14 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  15 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  88 ++--
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 108 ++---
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 425 +++++-------------
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 142 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  23 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 109 ++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 159 +------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   9 +-
 drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  31 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |   8 +-
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  10 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      | 126 ++++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 133 +++++-
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  90 +++-
 drivers/net/ethernet/intel/libie/Kconfig      |   6 +
 drivers/net/ethernet/intel/libie/Makefile     |   4 +
 drivers/net/ethernet/intel/libie/irq.c        | 368 +++++++++++++++
 include/linux/net/intel/libie/irq.h           | 120 +++++
 30 files changed, 1250 insertions(+), 947 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libie/irq.c
 create mode 100644 include/linux/net/intel/libie/irq.h

-- 
2.49.0

