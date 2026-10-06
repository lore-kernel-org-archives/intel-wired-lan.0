Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810ECA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1406607DA;
	Tue,  6 Oct 2026 14:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8l3tTT2iteva; Tue,  6 Oct 2026 14:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 59A5A60796
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297199;
	b=KeaoRFguxUZXoR74Gk/sYc7NyUwBZsMOPVon1Yjvz89a8zNUPQ8xhNhli9+MzYcE8W0i
	 fBALa6xfHspnl5LqXWo+8w0bpoUrBuqa6VEJrre+TGegIN79jdTNBrXZDc/UeeojmITUU
	 iZAmhCl+0A7jCc9Fk/j8eeq/MeiLflJ/wVi+6CHcGH9NscWOmaQnTyc4SeKdqr8NqiMwe
	 4a2HPJUvsEZPzG3VaFLgpVN87xIZlZpQCVTxP1qTngG29rpJgIUrR4N7iOxKd9XThlN5U
	 buerdpD1sHm8w4ythbbBYWPJLIInmxfYSp8Du7alC7/QlrYJjae/05GVDP6Vjoq+h6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mVdMH7IifK5PutzHZP6bEi0MxaNr5PwnmKmwBdJOQPM=;
	b=ABRhbfrOeS57ohadBOvNrdBUECcs2AX2PwJg2Xuv6SYB5uDexEu8kfTsaMY/L63PhCGy
	 EDwgwCuJyMqN0KsIQtnAvy7jx0alAU/sYQrQ76ell7/eh/maS5FZgXG1kh5+SDOflwlyW
	 2b0F1XwwQwZBT7L6VdUW5VTOH6GBQboK/Jgy/c8O1n7ls3rTWdJH8CPSfoodajxdtWSX/
	 dvQ4ATHNB6AD52SN5F6sUFF/vQhb7geU8DDc+uyR4A8lDeOWNRk46p1XBUIloqF8WPma6
	 nedVBHb12raxdthIgH51A8KlVEuUgZgO91lyTbGuBdgUNx44Kcm/2sxsUPxcSyXTJmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VJkQ0LSS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297199;
	bh=mVdMH7IifK5PutzHZP6bEi0MxaNr5PwnmKmwBdJOQPM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IpdECsFiVsyMU3bDP1iu+tuiZIf+wqGyq8anqYpkGhn1nK1GhIAuwS6vUiMtQb6PW
	 DC1TT1jplc9/Ni8ZZxyy3TpinGUFtqqWvREkp6ddcYWHtKefTVS0+s4XI4nkl6XB++
	 eanz4dXFKMn3cUm/+ty4KX5Ga3bB51ujsHHByhiE9jJVanBzq76d7DYVtXL6TkQJzE
	 yTufAjR8UlRURGZGTEHaOSqKHjrjIzUYnCvDEYG3wJuJIRjB73Edrp9ZWlT6H3AlRw
	 dQ7XgkMBaRnM1SzzUH//eWAi9Nxb6TNv31PMTlYuG4sNijzOKSKOaEZ0NmTU4x2Vp+
	 0ZtzUzj2O4kBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59A5A60796;
	Tue,  6 Oct 2026 14:33:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB484317
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C87F607DA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i1Cu5-7Qw2co for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CCB46607CA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791296689;
 b=RxOBolHTmzjPzekhgEhmcUa7QfRKWYVO1W3pCJQlkuSpt2xY3N9AhXzXN6R06FQL/yw6
 YSDVRdUuZpm4PQFKnv18BwlxHQtPepQE1dphiqEGJdE3nqDGjtz8UHnjhDeq5b+Ji1roQ
 oKY29Jemtvni2VCmC+VySZtl4LRdjgY6z54N+MasTsQTjxKDO5XHNmsQWkRmkZNcgE5wq
 jLp8+tM1UdSt668wflGHkolhP5rW/DblIAK2OW/rx9whDM6j9zAqwF1+6iRL9Uk52GY26
 YYx/KAhw7ljCW3hhd43MHPRF5S1xVCELxe4QIyQ7qBkeR1A3KEv/pBjo+VdNbldMNVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791296689;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=mVdMH7IifK5PutzHZP6bEi0MxaNr5PwnmKmwBdJOQPM=;
 b=rkTE6bSZs7IJ9vfgs+ZAN8J3mWpv5HRtg000UYP2y8XZkqI60LyYhxHi9u8W2n5R78z3
 IEYbssxxVKvaJoG/xASXQGP6RIQ/jvDC3NLQsOdLpZetW8HcLQfFB0LePPIep6eiB3WVY
 DncLh62m/tb0RMfJDXrdQIyLPk4m0nHLXVvx0496u4tS76F/1dR70MwrmEgkzJyzYnrmh
 B66ILxmNIQcY18h/BbRVlCoL+o9hZcuXUTsOJzD5KAekiIglPRBCaj9oXHF3SCjwCk7ie
 v1Xl/KAsDPAmXfN+esjqgKPGO3caprarjchLRAqLyb6rx63cSMhPvShjufYW9KJVFHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VJkQ0LSS; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VJkQ0LSS
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCB46607CA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791296689; x=1822832689;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LMZImoOanKCMOw3C0j/fw7V21HfqH1U8p2bf54eIh2Y=;
 b=VJkQ0LSShPafhdHBtgb5L9oJKH9pilDy0DN+v+Xf2MikD8KR/8n7FEUX
 8GW4ryTZEWcpBdIJWKwad+qeXlsx8auwOUA+4gKf3/bJzHPanRCJbofy7
 h28VZ9+5M0U9PCHgMeS+awAYHVCNzTCu0VvfudNAPIjFU1Aj5eQmQS5ms
 /dG2/6b9m2NIgQqG7XRQ/u8U1XRbJk4qTH2K380VsoizzTfduhHYzXOiS
 UOLeN5g1EZi8eB8xAglcYrY2Zjayf/c4DeJUZSaU+pqZpCBsOX2jsYOHA
 15vamoLYujQaYXaR6QImU09Xj5HJKJybudYrHDdG/VUkuZJvZOBfvkumg Q==;
X-CSE-ConnectionGUID: dFTsz98yTRKdn1xvEz1cYw==
X-CSE-MsgGUID: 9EwpKqmoSL+8M25qDu28zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="117507486"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="117507486"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:24:48 -0700
X-CSE-ConnectionGUID: prZvVfLATwerCRqzpfHMxQ==
X-CSE-MsgGUID: 247LG9gzSb+UQXLdRRPoxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="305105849"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa001.fm.intel.com with ESMTP; 06 Oct 2026 07:24:47 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v4 0/3] ice: fixes for pause reporting,
 autoneg and RDMA
Date: Tue,  6 Oct 2026 16:24:42 +0200
Message-ID: <20261006142445.2867917-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Patch 2 restores E830 Clause 37 after the PHY Autoneg support check.
Generic MACs retain Clause 37 handling. Unchanged Clause 37 requests do not
trigger an autoneg change.
Patches 1 and 3 are unchanged from v3.

Konrad Knitter (1):
  ice: honor autoneg disable requests when link is down

Lukasz Czapnik (1):
  ice: support RDMA on 4+-port E830 devices

Tomasz Lichwala (1):
  ice: fix asymmetric pause negotiation reporting in ethtool

 drivers/net/ethernet/intel/ice/ice_common.c  | 14 ++---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 60 +++++++++++++++++++-
 2 files changed, 64 insertions(+), 10 deletions(-)

-- 
2.52.0

