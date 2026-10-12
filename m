Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9483ECA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 06:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C9E740629;
	Mon, 12 Oct 2026 06:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10JKjkxQJNJ3; Mon, 12 Oct 2026 06:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 709EE4061B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791786640;
	b=B35J5+IeR/Z9nbTfifeEnH/2Kss8LARgYYYqUZgiKU+VEAHGIZ0yhYm3YEFFULfSqlJI
	 KoCou4chLiB/ljLrxY2EcsZqm7b5gz8crxSHwFY4ArAX9VJWpwi05LuhewadOMMthyq3F
	 4avFQWdmeK/YYv7YypLaqGV+RCgT5DHQ/bGdvTZegenWOYW9AFnD1sbFOGVzqt3h3wcfo
	 40yQdgS+9mfH9oeKVUtgZEq7AetYMztXim9qbV17FE4nHMlArj4m/YI4iCP9/jgpYcXKu
	 zts73404yAk6Q+JxEPPmGKbaeghgeGOKVuSVSLXCupmwDnzv9Ch6XMZ4jVVfgECu8kQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791786640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WfFi2at/lgAH1/xbqXNWbCEaLwYnM/ZF1CQqtE9gXAU=;
	b=fx+1CuOp03aDbZsP3QB9Ue4BgxhE8p++3ieOt2jG9o1VP48Ea3kjxGrONynifiYd67zW
	 cTVsXrvZ2+ak3t/ElTi6w5sE0Mn7RG4yVFsmmwVAq/ho05KapfKzo1dKHSW1sdtGudzQf
	 BU8A+5kj7bYD9R8Srb3ktKFweVXHQ3Q35TBs+1RtwgdFrIRU7p8JgP4i31uj0GJJGBp29
	 va7AA6m0Mgm8Lnes2Mi6z6GI9buGqMTnXR0ujJR2cyGI+LSHTSeJGxI7ot0wg+wKqf29a
	 ySbB9KinJ1MByy/i4AXvFBtsS7iDWll+dbMlnKF7Z/WGA4zEOyI3pmkltbnQe0P4nsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791786640;
	bh=WfFi2at/lgAH1/xbqXNWbCEaLwYnM/ZF1CQqtE9gXAU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jumRDXFzgB7WCl6kOrYO4Bq9mkvHGd6vrrdh2Rbovm4v5G4tvJ2ia+VX+O4MZBjt5
	 i8DSM2OW4AGNKlWeKGDer5iGHbUgYMYtkOttyIKr2r0pMzbZ2rAoy/8DMzISFTPibh
	 cTuOyZUWR/n7c69uZ8FZGG4ztZTY9StvEd+CyYE5ipQAgItSGWtkKUXPE7YsTf1sZw
	 nPKWOXCQAs49ELssbituSG/xgXCKqS6WfcHPVb+Uzr8yBVan+FyIY3WNKpiGCNKiju
	 qIqWh0Atqnt7hZnf0fFrgjabtnV2Vfuv4Zc6spXiqsewFO9T0p3rMsf2MElM7umNfO
	 14mfnkEVXRCGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 709EE4061B;
	Mon, 12 Oct 2026 06:30:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3148C9CF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EC0580CEE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i91M-ebcA_xx for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 06:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4979380CEC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791786638;
 b=EdLXkRcCUXJDN3TLzMknl8WyLohM7WCe7mk3G2VNNN1UV1QSAKZyxZoAr5KoqJ1dxOha
 fq4aQ0fxbEBy9G9OVqvG09Airp5GmoG5j/dvOlx8NwNNxIqYVkGdOKrZNQBJNCdqFflsK
 RB5urjiGDyrqqRpcPsodj2OiqwU9+mz9EuyeyoegcQacrFhidm41LTZkS3si+PZov4FPn
 EUJ3Ifkx0PczTOvEFdedUjoCLtN7SE7xZm09CH64GE86BkNY/qw23GbxGqKpRjqznGFwB
 hSZxl+2zWQaK7bi/SpCXe2hnIrZ5kX93LZB/6DenRkzAmTt/FAG72MmNfSs9RqZpOTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791786638;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=WfFi2at/lgAH1/xbqXNWbCEaLwYnM/ZF1CQqtE9gXAU=;
 b=UXGWX9P/zfw/cym7Y/4LPFlxb+DujONdQh3Q9n71MiKV8OEKwImj3VhcvschSYToHnRx
 XBEkMlHw5NDONkNXxKV7EgSA/z+aqAW4e3EjV6VdLb4Bzs7SnhTjmBGBxZnTdx5n5RZg6
 00KyYaKp/0Y56eMyWyCs0meCeZI0oQcxXYpzS2QDsmCjDaK1Euh4GzDifTruA8KsDr0DX
 j644lnJs4D1IXYZRNgdtw+F3rzQU1UGAjl12B5Q3eElwe4eESWkvFKka3QTPs9JdANKJj
 cxW27ZOJv7Ne+bq98aZYnUu1wQtYTAmmdhfJD/OPazLSeoTFeo7z7niQYBFaFkSBpLw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Lefh1Ke0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Lefh1Ke0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4979380CEC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:30:37 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ab450c0873so1339998a91.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791786637; x=1792391437; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WfFi2at/lgAH1/xbqXNWbCEaLwYnM/ZF1CQqtE9gXAU=;
 b=Lefh1Ke0mr6Q5Wht5uOqA3gaWGr+ijrhRF6E8FtSux3aMgpKs2pthM9FpTotGCNaNm
 Eke8QztXJtqhYWLI1oXP/g3l7B8YIj1IQthQR8qlB3ywWDr1lATX4VZgRYqviEhhy4Ut
 d0SOlQL1g+WUemeTbbB72YQRpKZCd8mLMbaUAq+qWIP1YgQ8/ThX8LebeWPfj4OU5wSe
 45+1cn+rOAZO5nlbB0YbmYPNrnJMZoHTX/6TBDBupsHz7XwlT0GrXZIYoBmPTcfe3J22
 zOB9/bd8Ckz62fbdlmobrK0ufA4R399E7sr2HoFwv67N5J5vh4/mdZVTOvpfMIGYoyjs
 xjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791786637; x=1792391437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WfFi2at/lgAH1/xbqXNWbCEaLwYnM/ZF1CQqtE9gXAU=;
 b=CWDmZ1C000Ne/g/rOyKz+TfkXd3IY190rUR4blj/oCpu3TnTr4FWEJD6zK0WNQvf8j
 HAAxrrMzzlpmk4o8nWLyIPvjIUCYJhDUYO1xvTvh7HQRRxmQaTZSW+fP6Kv1ujMq8ujJ
 S1IDHJXWdAQbBjSbEcdqlR/jiz9hG3XsyNP6oQsBJX5xgmDLWP9kKPUXui95XCUD2B/2
 P1CsfmQWlwQLD3zs6gY3095zzYO/zHbDGTzYyhkcGQp4lJFbY5yiFHtZWMkUHwFf3CEw
 L5dfmIhWpiapo2EYjuOz6WRyq+g6yo24EBhWvmWipGlSRq1A76I3I9t3WdZfzCpNq/6W
 5PuQ==
X-Gm-Message-State: AFq9FYKkc+mHcoeK8BWuwyAjy0aRQl9M25W8d/NoP1CX2ScONcRUbMYo
 cBmYuD3oL4J8j820NJzF2vIFhK8h17COYg68JLYd3W9Izg15DRI+K/wqtUH6adcu3FE=
X-Gm-Gg: AYBFou2pLRWlLlNMpmdwJRIrPaX7IGng6smPZq5KwiGJ936TN1oBLcFGgNIZEj3UOez
 GtjapV/g3weFF1Hu0yFmti3bte/GQBPIEhTfG5BhunSXkHQYfqtyy1Exv+SqtZOUuh4qtLoOfO0
 Ul5ubUO9sB1tSsiDrwDNP82QavKyZqDAf+PXvsMNkM5EoadBFnnAz6WMnazo9XBshFzQSLL7Hww
 3IsXfBVmk2MXAO8C2/M30bJ3ak8VSKe4TExkZV5R48zEp4ycYFlZatzMV/ksErInvGBdmH4EMuT
 ENNpi7jkOwT+CFGmSQXyWSwdwA7XNdRUkEBx6guchEE8g/GIiAvNNE2kfhD0oZzobXHVffo5NBO
 lRk4uN1fF7emeh3RgaZmSIjVYH7nhX+MFlhVLdP/GqIagNVvsjvXEph6gvjfLK6vKlxezqca3kv
 LuMDEC9Plb0IwBZr4ySMyUoXK0Y0dR65JwVd3gAWvkUWm3Nl+c6L/5smNlgw2WOYx9K5WtgBpf5
 RPCRCAZnObi8sfK2b36WemiSJw6mW9CV6N1al5tcdaLGrPS7WoQrag23e+8zewU7TWB6Cw7L91H
 Z43ooV72Q+W1Uw==
X-Received: by 2002:a17:90b:5346:b0:3ab:235b:185b with SMTP id
 98e67ed59e1d1-3ab3a77980emr6448875a91.31.1791786637261; 
 Sun, 11 Oct 2026 23:30:37 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371c32cesm14452767a91.16.2026.10.11.23.30.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Oct 2026 23:30:36 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, milena.olech@intel.com, joshua.a.hay@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v4 0/2] idpf: destroy the vports on shutdown
Date: Mon, 12 Oct 2026 14:30:25 +0800
Message-ID: <20261012063027.27750-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

On shutdown idpf shuts its virtchnl transaction manager down before the
vports are torn down, so the device is never told that they are gone.
Patch 2 keeps the mailbox up for that teardown, as remove already does,
with a short timeout so that an unresponsive control plane cannot hold
up a reboot for long. Doing so would expose shutdown to an existing
remove-path race between the async PTP Tx timestamp callback and
idpf_ptp_release(), which patch 1 closes first.

An LLM coding assistant helped analyse the problem and draft the changes
and their messages. Both patches carry an Assisted-by tag.

Changes in v4:
- New patch 1, closing the Tx timestamp callback race that Sashiko
  pointed out on v3. It already affects remove; with patch 2 it would
  also reach shutdown.
- Patch 2: the Tx queue SW marker wait follows the same bail-out as the
  mailbox transactions, so a control plane that acks DISABLE_QUEUES but
  posts no markers costs one marker timeout instead of one per queue
  (Emil).
- Patch 2: the statistics task stops sending once IDPF_REMOVE_IN_PROG is
  set (Emil).
- Patch 2: the shutdown comment now says that a transaction already in
  flight keeps its own timeout; bounding that would need support in
  libie.
- Not changed: if one teardown reply or Tx queue marker takes longer
  than 500 ms, the rest of the teardown is skipped. On the tested PFs
  the queue-related messages took at most 240 ms, and the slowest,
  DEALLOC_VECTORS (about 300 ms), is sent last, after DESTROY_VPORT.
  With the driver made to treat the first Tx queue marker as missing, so
  that UNMAP_QUEUE_VECTOR, DESTROY_VPORT and DEALLOC_VECTORS were
  skipped, 3 of 3 warm reboots were still clean on these devices. A
  function reset as a fallback was patch 2 of v1; in our tests a
  function reset on shutdown did not stop the faults, so it was dropped.
  I can add one for when the timeout fires if that is preferred.

Testing, besides what patch 2 describes: W=1 builds of idpf and libie
with allmodconfig and allyesconfig showed no new warnings after either
patch. On one server, modprobe -r idpf and a reload completed without
warnings or IOMMU faults. These devices do not support PTP, so the path
that patch 1 changes was not exercised on hardware.

Changes in v3:
- No new flags: adapter->vc_xn_timeout_ms (60 s from probe) is lowered
  to 500 ms on shutdown, and idpf_send_mb_msg() fails the rest at once
  after a shortened transaction times out (Emil).
- IDPF_REMOVE_IN_PROG is set before the service and event tasks are
  cancelled (Emil); the comment and message no longer state that a reset
  does not clear the vports (Emil).

v3: https://lore.kernel.org/all/20261009032706.94324-1-luckilystar08@gmail.com/
v2: https://lore.kernel.org/all/20261007055741.30629-1-luckilystar08@gmail.com/
v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/

Tian Xun Ng (2):
  idpf: don't use the Tx timestamp trackers once removal has started
  idpf: keep the mailbox up while tearing down vports on shutdown

 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 +++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 68 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  3 +-
 6 files changed, 80 insertions(+), 9 deletions(-)

-- 
2.50.1 (Apple Git-155)

