Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24CEC982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 11:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47E7660760;
	Tue, 22 Sep 2026 11:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9jBsuOy8JXu; Tue, 22 Sep 2026 11:36:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E6282605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790076963;
	b=nJ4uMNBo1q8lz4IOYDngDYIDMhsFesgjR8IJsmxmcAWoimElGNawQ5+xA98kzP6Jk4zP
	 +gNMIhDz0VpRlJJzilLPpwZPOXmOxEmFZDfJPVLK/d7vZnJsBBD6N/w25W4ctY3+XxYGv
	 Irecm61UQYyEvgJ3eB5nvNravx5jqQRYV7oDFgaVszcDX9QzK33y01fxNgbOmGe3yXINn
	 U1roGpCO5IN9po0C8ZI9jfupDouYqhhj3tK2OcC2CCmkKhtz0k30mQMLYJCTG8LizQHqY
	 DCKlJGAu0sto0XwBiZuLJAZdhTkBlI6sLlFuVpOlRixN+CJQPXhmUseqMlYm9pS2WUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790076963;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YBmAB/tVkUeN5IulXsTX9npf9AcMV0UV6INeuhNaOlY=;
	b=pBkOjWlJiT/hZ6azA1Luz+EB3/+fQJW7iUu3Rl2mcD4yNcMdi1tiFScMTtVRS3FURwyv
	 PklYOXf4aWfHB6wLotkmQj/bEjweFMKQOA50vG0V0FctGyEWsCjqohYbzNRDhJptiZdeJ
	 kZTpYgEG/FQldDAYW+tBEqGjW5DydTWFKJ1HCKWxeOtSJN89LabG/9zXYXzcr8gwXh2Ox
	 nGwqGVf9ZwRNCbl3Ig2kzI38pipMIDUZXXs+/PR4JerpUrP5DQXYXJkera/LFj3veFowZ
	 OUl/8gx8hhsRcvuYT8KazbqcgDRyWLSOihxD2HhQzfRZqqbcBVEnIEh/bQBJOfXfJzw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790076962;
	bh=YBmAB/tVkUeN5IulXsTX9npf9AcMV0UV6INeuhNaOlY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9RKN3pveSBkgvPTc7dANd32tjrRDzAzmQGaEkFoG6KSGDRzXBWhACyjHmg6rzzXz8
	 oCWuoIiSV0TNtLHbY9qefh1iic233GH+MYcJbdnMo1zd5OEFnS3VCxF2OEbTFMHRVF
	 dOCdejjJiHnZa160zQ2zDe6Udhd7KyTAqutwOmfHOnHcR3Nsu9WTXX1IzNdk0KCk95
	 3J4cXs+L4hsgEx0yjayUDVb/qwzNc+mq+ASmSs2MRP6hSzcsm1BubFZa5se6foOq+8
	 PQK92efd+GwjB4+Uz8rb1/SkLRKbbYY1ZDGNaJtahsdTShcK4nRq1GVaOIpTQf2YJJ
	 PvGOcmAkRnDrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6282605F9;
	Tue, 22 Sep 2026 11:36:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91367A20
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8305880C53
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ouaIqBVvevdO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 11:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8E14D80C4E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790076960;
 b=h4jxix3uWl6RHfNuQ1mGwpEtHLe8KxKjbkKwreciXbCEGmL1EAtcKdVrl2GxG6swrf8x
 qKsETft42TYZc9nZI3VHAWA4/ieuR6Q6rYqwJTGaKLsHNCH8+vnqQjMsDm7aDaskxUrtm
 3el8HPLvKaR9WJYGwKeVpQu74WT+Pj+orpcvqMV9iAm31ISCuLTABmix6SfXifkYvKrHA
 IHXsS17Wamn3Lkr5/ndLpXzHlC44lrO6mQDNI1moA8DhForpVG6LLWcMlGvIejcTDrmbq
 9X+s2VewkRQpT2nxomrK6L8EflDebmX9oDopyAMs2HuPyVHoZvQ1sr23U6OQzJ774Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790076960;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=YBmAB/tVkUeN5IulXsTX9npf9AcMV0UV6INeuhNaOlY=;
 b=FdEjxLsz0f1Q6P1CJw5yksKLmVuewGVzzZ9/tJ+8wir80L5f8BlOxtOQcwEgYDXVnXwB
 UoVj89ZKr2DliQKktOtTiwV9O4ZhUqYZifsuamEZgSxVan/BITvEnEVZm+C6I4QmUnmkC
 6M7/f8t+lma0lUjEYteoJYOn7wRA3pZo5x6qGGW8zfhBFZPm4hefai7haI7uk6diyl86E
 O0goNK95Sqv5ancSLhMkThtWK7rQq2BaKZYo7hjlLKGp3CIMRgwQWMQx2wA73/9TpPorS
 Zp/8LxCHJY1q81EuHK5Gq51f6uZ+a6DR8eYN+hPp3nd5iVHVTIzZvif+G2FxZUbD2Wg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N9NacNcF; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N9NacNcF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E14D80C4E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790076960; x=1821612960;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Q7Qq1ojA9P4t/8q0aG9ChIfME7AZFSv4Z/bbT5TDIO0=;
 b=N9NacNcF9GH0jyYfT8uQCOJpcLQU/7v+m2ASVyz/pclA9qpZcTuAIUWL
 n4A0dCq/ZPVXCE1XuT+j4cYdziAUoAu5VR227AVTMQp+evyqdoN0/cT+I
 7QRU3lSDs0ri/QfcU8HdvPSbKlFpoZ+nZha/acD/84cV2s+NK//AX7C8j
 2LRnlWMM/6cm9HMgQVis2hUcnlrKkhvjC/4ZXroFiKgJ9lqszA6gLX2M7
 g+L6egxd1OnEIIaa3xxg7plfQA18mv6GK13HEJhjKaQ4wHXERacumdIca
 YtzME3TOxwTAZ2E8ID4TrCJXVIJD9jecYRNuMqy0sMYusFFHqgRfmEJvI g==;
X-CSE-ConnectionGUID: o3mxMNmiTAW8Mytk20NFkA==
X-CSE-MsgGUID: 4/TIVhUrRjukHiJO5ioicg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787327"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="90787327"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 04:35:59 -0700
X-CSE-ConnectionGUID: qhl5J6QWSouxkDES+jgeQw==
X-CSE-MsgGUID: hUsLZAzQTHK8bLav/guSVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="272591974"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:35:59 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 0/4] ixgbe: fix FCoE/XDP issues and PCI reset
 handling
Date: Tue, 22 Sep 2026 11:35:54 +0000
Message-ID: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
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

This series fixes several ixgbe error and reset codepaths.

The first three patches are prerequisite fixes that make sure that
the driver does not access hardware during the reset time when it
is unavailable. These add the required availability checks etc.

The final patch adds missing handlers for PCI function reset through sysfs
in the manner that is safe for ixgbe. It implements the PCI reset prepare
and completion callbacks to quiesce and reinitialize the adapter. This
prevents TX queue timeouts and other related problems caused by
inconsistent hardware state after a sysfs-triggered PCI reset.

Previous version: 
https://lore.kernel.org/netdev/20260617084329.199110-1-sergey.temerkhanov@intel.com/
v1->v2: Almost complete rework of the series to ensure safe
	reset procedure

Sergey Temerkhanov (4):
  ixgbe: Refactor device operations to check whether netdev is available
  ixgbe: Fix FCoE refcount taking for unsupported adapters
  ixgbe: Restore previous XDP program on ixgbe_setup_tc() failure
  ixgbe: Implement PCI reset handler

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   6 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  34 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  42 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 193 +++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   4 +-
 7 files changed, 262 insertions(+), 31 deletions(-)

-- 
2.53.0

