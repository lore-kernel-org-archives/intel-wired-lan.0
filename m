Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAD3CC6B03
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 12:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E351140385;
	Tue, 13 Oct 2026 12:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4zIFTtvLZpr; Tue, 13 Oct 2026 12:12:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1D050403E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791893559;
	b=e6mR/NBAaF3Up77jX7Mnw15AymqOsS65VttfAEnaQsxXmE6Kmmh9l75ru/EPrjJLo6YJ
	 fKts3HiNWWlyHRsxB6BXV8JugjDNprlARdc10hEWIbYdjkB4yO12c+7v2Tos+R3rFmHnd
	 fP1Lk0VnJ4OPt/iZLgWHermt1ugsCFGhNUtw/AT8LmhjzaFyAvRxLJWCBoVD89mOeGd9p
	 4Q7k2hGnivE89V0t2AIqpJ7J0a4w/1rRH9FSrPUokzs4+uElLyLEqQO5vnnZ2GKptEOIU
	 nANMqEn1YFHJbPoHPGAKBnFpMwf8WpziEmwcfNAoIApGlgu7IXgRJ4R8QfrFnZ4dcPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791893559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2ZQESZ4ejOVf3RnoP7b09ULWLMWyLE2vdzE7Bkq650o=;
	b=inWLFj3+QoAmUWmBNy4DhOBCfmWYdeB2Tj/m5z5E4f0rmT61gb35h/IWlELMaQY3uF3l
	 q8loro1MLlE+RXH5vmLQtDzVMi34Lt/8Zf8AfQOKC60imoipa2BhBq/4PoVs2CtZMS107
	 lZfbPhtNho/Lwa9i4gCivlBrQUiSWapn6c2pH2B0a5yEPc2GOPvN6KAozcvtURyEX6bvw
	 fNX+r83TzmxgJ0MlhyiVdC3ZnknxUAaHe0GakZK+Yr7pAZvIhq+ezVs+spFwudHAgWZDm
	 PbKyB7VG/o+Kohydn/9+abv32XeZ2qq8WLZmZyDJjc7JXtibOX/I8CIsfAmPyiW+6MQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791893559;
	bh=2ZQESZ4ejOVf3RnoP7b09ULWLMWyLE2vdzE7Bkq650o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ktmkD/znqQAhbLtumvwOQCxlVtOrEP6tSpCO2ooeImEVM6dBtEcTZunC63ladLosY
	 yzNNsfz6h6Hg/ZrRwjHRdpZ+B84NhEhjXWvKe5mvjlXi2/bnXQCipaAoUFav01AYvJ
	 OkH4q+9FCrHez9zwknyY7wUVVOLChw8GNUcE2UjVat0WWRKbadrgkjIgkyd4+tuRca
	 Bo4mX2TENZX6tFgMAU+7Hon8It3PjFrTMQIciGtpxiddijc+ymEisTFMLa+awpMsp0
	 xsFV+/3xNLvK3TQbWKAXZkrvpKD78mMFnkGOKWf7AALIX5Y+CyfUWvQq30KHpN4jL8
	 uzeP2xvxXlZXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D050403E8;
	Tue, 13 Oct 2026 12:12:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98F0D235
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A34440070
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6A3uNpEa5wTi for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 12:12:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6993A400C5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791893556;
 b=gHM+rO1fxwjdR0gF89+NsRd3LwgfLFUSKnNl0IZHo7DTSY7XRRx8XkkOwPjVQl4cnL9Y
 Ty0frTgFiZCgENX7J8HqFx07Hef3E1czJA5eOjLjyXaztRKMq2XaeCNpoHhC/DCFiy+BP
 AOXjEfQE+1DOKjrMKH0iL94w8kUnz8SigJO51BOGDXTDIbeLjF0TM4QxE9VJ1WvBW/qLO
 KYar80zpFLWMN8/unXLrMPd7a0ZIJs1DsOYOn1YfmcYMIEUPFPZkIjcu66UCRVVIwXinG
 GgT9naj+I7QR9daYU/B2bxsu6Sj/cncfyYCjFw4Xvlj7HjA9I3Y10tu2Safw5z2o1Ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791893556;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=2ZQESZ4ejOVf3RnoP7b09ULWLMWyLE2vdzE7Bkq650o=;
 b=cjg02iF9C4MYnGnsbgZtRhKH0YNPHSpeJT8F6IlOGycU7ls9QhTUjYXv4QOIOOlR5FQp
 b8Mudp5U8f7pvxdEs3QEhkFl33Eq90xl9n3fxZHmNaM4zvcOhI2VbZhc2bNXbw/XPGBjD
 zBAqAJM6l5pYLiwZO3C2CQPPVOHQ/t6qcALZs4dc173+Ba7PL8oZYBoy1vfQcpgowmh4X
 lpYApSRd1GAdATSDP+OrlRua1/S59SEWV1DW/Hbu0CVNcpoNk/DXLOgwpYVwJmOl5Z1HT
 WeOvBlS3KZQyT7ppL+gXbum8andv0L7ZO2XIMbWMDTBS7v9Qxz1VKSo7Jq4iRrHjnmA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=neNM60iQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=neNM60iQ
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6993A400C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:36 +0000 (UTC)
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3550c917fd3so4006118eec.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791893555; x=1792498355; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2ZQESZ4ejOVf3RnoP7b09ULWLMWyLE2vdzE7Bkq650o=;
 b=neNM60iQB2GOMDcnv6NzsyIgPMOPqasgZzAbjKeHG/gGuhJiMUoyxIqCznr2Akyukx
 nutBTgMUar/sdngUhH/joxqfDECzBiEYs/qdmhMDkIQ8IxUnBy0SIMPd0b+EnavKk7AF
 gz4cypiKl3yfSHoeVn/MukEEf9gbtL7V3ZzzZOXcWG6KYsn0+YDnBHPz2lWDB4enGEiK
 eUBuBJxLpZ7z8+hyEgf6HpdbKx+/AXFF5HAm8JR2DwRnF5kwnb2L9uqczFpLnfJjpO9f
 qVTxl4aDfIGgynoRM6PDNhEvP+fYQKA/8pxMIS6Pm6WWuCjuVkEiBKrxJ72eo4uJJgUM
 qJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893555; x=1792498355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ZQESZ4ejOVf3RnoP7b09ULWLMWyLE2vdzE7Bkq650o=;
 b=OGIfXb+BaNLZRNUbgsRvOQP3gqz8zes3t0mwWIZU4usKnPhP1N1hshXI6SE8w3G08c
 4XnV8Ndw1SkUP0PiqcIBJyXYYZK16NExOYjoQFzbg2iHf7JuZ/17no92XDyao8NjQHDi
 dow9q0TvA0T8ku3J5agQGb4YHowncjMOtYbTCkvmtWFR8bcnRvHkvliSoP3ufKpNaXpP
 J6i/FyC6wp0D4+7s4XW0F8Gj2woExtSL5tTgtCcpdfwY+dJIsjx1clIr8DHQv9KstfyA
 cvX1/MreRY5bm7IUowDmV6l9/Y2r4a34QbpvBoCQh7eiYNhzT+COC9ebHOxJzEjpnkxt
 /+OQ==
X-Gm-Message-State: AFq9FYKfR4WkInP6vjd3C9phP64OIX1tRSQaYz4VINFlD2MGaNgdjKae
 JRFF2uUlTsO/gDyt0Qsc0aqf4L3LCZwoJbv/ItlDYJRg5Ac2W4qojmD3lLH62/TTaZv3gw==
X-Gm-Gg: AYBFou2jMdZXVgczPgtbLbApJxQlEg62n/TPVDBv0lUoyKU6DWYMafZl7CDTouo7+sz
 1IPMaUaPsGtlBxu4smSsJoiQr/7Zz+7nvMKSDO8CC+DJTEyoSK3oD+43yq03GJN7Cb4a5hQxCTk
 LM9+bMk8tUn8qrAAfsLlsTDreNQ8MkIAdlfrnuPqjCde+Xv8PAy0ZNrxABIDL3AEcEo5OmdCL9v
 9T4uOcrv5Cs4Gh0HCkwFooxcL0ahEa/q7tTJbqW59zRcUTNRDgcoTeD5uE3AzaW4kddDI0+6qDw
 uxofSi0egNb+KMdb5hj8b4Cl4od7c1P1bo3+PTISY008W193GMvhGU/tDXZP6R9VU0UklRFkppX
 XgtFVVcGJIe1JIsRjxH8Mt2X5BjXY6ybhGJY/gSDRGBysfo34Hom3zkRHD/tgXFLBSoKaXzLW/c
 yWWELod6HrWKdK8xMoK1bUGcCOHQq8fiGsjOFL59D9UE2YNYlyNXZl3JmEetmARG0Nn2h4Ik/pC
 c1Fq1W+QLyicNQyRCYAw8nQZiWfQ+zlMiCvVgelkPSAeqo6H7v8lvn9oIQlmYORKjcMm/15U4ns
 +A==
X-Received: by 2002:a05:7301:5005:b0:34b:4b99:24ab with SMTP id
 5a478bee46e88-3537e0be018mr17583399eec.22.1791893554886; 
 Tue, 13 Oct 2026 05:12:34 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (34.224.142.34.bc.googleusercontent.com. [34.142.224.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca7133asm52304765eec.14.2026.10.13.05.12.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 05:12:34 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, milena.olech@intel.com, joshua.a.hay@intel.com,
 alan.brady@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v5 0/3] idpf: destroy the vports on shutdown
Date: Tue, 13 Oct 2026 20:12:21 +0800
Message-ID: <20261013121224.84482-1-luckilystar08@gmail.com>
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
Patch 3 keeps the mailbox up for that teardown, as remove already does,
with a short timeout so that an unresponsive control plane cannot hold
up a reboot for long. Patches 1 and 2 first close two existing races in
which the mailbox task uses state that the teardown has released: the
async PTP Tx timestamp reply, which patch 3 would otherwise make
reachable on shutdown, and link change events, which can already arrive
in that window on both remove and shutdown.

An LLM coding assistant helped analyse the problem and draft the changes
and their messages. Each patch carries an Assisted-by tag.

Changes in v5:
- New patch 2: idpf_handle_event_link() returns once IDPF_REMOVE_IN_PROG
  is set, so that a link event cannot use a vport, or its netdev, that
  idpf_deinit_task() has released (Sashiko on v4). The window predates
  this series: mbx_task keeps running until idpf_vc_core_deinit()
  cancels it after the vports are gone, with or without the requeue in
  patch 1, whose drain makes the check race-free. The same window on a
  hard reset is not changed.
- Patch 1 is retitled to the mailbox reply it guards. The Tx timestamp
  state cached for the transmit and Tx completion paths is freed by
  idpf_ptp_release() before NAPI is disabled; that older lifetime issue
  is not touched here.
- Patch 3: a missing Tx queue marker no longer stops the mailbox
  messages that follow. The remaining queues of that vport skip their
  marker wait, and UNMAP_QUEUE_VECTOR, DESTROY_VPORT and DEALLOC_VECTORS
  are still sent with the 500 ms cap. This departs from the helper
  suggested on v3, which also failed the later messages: the device has
  just answered DISABLE_QUEUES, so its mailbox works. With the first
  marker treated as missing, all six transactions completed and 3 of 3
  warm reboots were clean.
- Patch 3: the kdoc and the message now say that only a synchronous
  transaction that times out fails the later ones at once, and that a
  reset already running in the event task keeps its own timeouts.
  IDPF_REMOVE_IN_PROG is documented as covering shutdown.

Testing of v5, besides what patch 3 describes: W=1 builds of idpf and
libie with allmodconfig and allyesconfig showed no new warnings after
each patch. On one server, modprobe -r idpf and a reload completed
without warnings or IOMMU faults. No link event arrived during a
teardown in these tests, so the path patch 2 changes was not exercised;
these devices do not support PTP, so neither was the one patch 1
changes.

Changes in v4 (patch numbers as in v4):
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

Changes in v3:
- No new flags: adapter->vc_xn_timeout_ms (60 s from probe) is lowered
  to 500 ms on shutdown, and idpf_send_mb_msg() fails the rest at once
  after a shortened transaction times out (Emil).
- IDPF_REMOVE_IN_PROG is set before the service and event tasks are
  cancelled (Emil); the comment and message no longer state that a reset
  does not clear the vports (Emil).

v4: https://lore.kernel.org/all/20261012063027.27750-1-luckilystar08@gmail.com/
v3: https://lore.kernel.org/all/20261009032706.94324-1-luckilystar08@gmail.com/
v2: https://lore.kernel.org/all/20261007055741.30629-1-luckilystar08@gmail.com/
v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/

Tian Xun Ng (3):
  idpf: ignore Tx timestamp replies once removal has started
  idpf: ignore link events once removal has started
  idpf: keep the mailbox up while tearing down vports on shutdown

 drivers/net/ethernet/intel/idpf/idpf.h        |  5 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 ++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 +++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 49 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  3 +-
 6 files changed, 64 insertions(+), 8 deletions(-)

-- 
2.50.1 (Apple Git-155)

