Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2105EC88E7F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA207405D9;
	Tue, 15 Sep 2026 12:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZmF20cooWmgp; Tue, 15 Sep 2026 12:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5D147405E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476933;
	b=ZXNnHxquwybrqrVFcvghF8LifciOMJ37G6Up9o0MUIuDC2678JT2975QDytK0iK+cVND
	 tjYnVvERkXoXMSA8j3d5zycnC7gMtZLUbI7hbdQNzMBVzojSvnly/sRJtrttkC0qR6UR6
	 7VFTkaW5GoZrfBmim2IdbT3a/jK8y9fpDqacJdJw/dVxY6Nnz7AJ2Xkjyp7eYzTK1X5kS
	 nW6m8m/XGzV9N1afIPD/2pRJh3P8NpGkREvFJjMj7wz6/5ZnnIBIR+wPoLGbMEyzr1bVh
	 oBDaqOXFxlVcTmZY3QKAY+s3il0JQ1SsMuxvsJmxUrcKwPb5Zv6+YwhTHUzSGXsi5oQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YR383n1ruqVJGuB2k2yTlIFH3oSrVuHTa1cIVVkLISI=;
	b=dys1Y03U2LjHPZsF1UIUt2I65xMH6uxc/zUVWEYBRNm8t2am5jWLj5R4ItLRhmnv3l/z
	 pEKTUO2szvrMjUy1TpVrQ3OmWMY+ZFDvkRbgsYeHggqne8i6bLJBs8r6Va/UH0fvczEm4
	 GulXC8sHVDfQmdM+/oOvMSQjWDNxL7N/0uor0snhYMyiKJ3SFiKDdjtkGl2GnEk0eX0co
	 YmjstGK7GzQTImAh3CYbjH2bIpeqkUcVIWBP9RDejsIsrKbESM2m5sbiVfQSCwydYtg7B
	 tdsVyAxg4wJZrOwCKX+Ufz311fKO72bY2G+roVLOmx3TpsUD16koXOg1jn2HGt5tSfA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476933;
	bh=YR383n1ruqVJGuB2k2yTlIFH3oSrVuHTa1cIVVkLISI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MUCtHQkZijEtd/vRI5WRnW7OJ3xgkZxZlBYMw2d9ZB+csO1sg6l8CFjrWmUCerkQW
	 xudOjxCv+A9ink/8EHjDeZoNlfcCVGho2pAKem9vZ52wQYPL6Rhfw4FymztubcdKIX
	 G3pusyVrDix2H/yeS6fOvLvelIiJRamgV0iSWLTyvmuGcyYV9Fto9IXIleVs4YYTlm
	 TN3Q0ar0oIW+Fex87AEzO9wy0J6Ew5QZ4ZgEz8jE26HPOqOVW6xy1TXOwKWhsL7HON
	 hCP9PtuCIpiQdnqoDkhc7Wp0UpJ6LNkch1p6vBM3iPmXfaPpIAJMX8LR3k0SA2GnMJ
	 eo6jVWZuV0+kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D147405E2;
	Tue, 15 Sep 2026 12:55:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AB59259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58BF64009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ns6OlZ9Im4U for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A3C4E4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476931;
 b=VM3mF0r6pSWjWL0z/vy2BffRh6NGdpa7yN+K7BmoR9rw2T8KyrY1LgzY4NlCo+IuRLBz
 veak7Lp0Jzcl9wFadsoiwfQCjdQ5oHbWahtkgwayE6y3e8k5GgUtwEk1NalgOqMJWwucn
 MdhVAQty+0ZXW3N3AE1DyUwHd9wZ7x7+LL57ocpO2hBmL053MXNWyNZPZXRZsIf6hgC9z
 jA5bm9/2eaxfWWi0hMpDOfOyUskHdzLVy17HFLj3VQbPau3pu/1ouWGvTO8SoxprCKIcb
 USTenaQupXcpqmGkbx+xw1oJtP0IdbcmlqpfMjLnR48vuByYcyHl3/UAfRoziERUFgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476931;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=YR383n1ruqVJGuB2k2yTlIFH3oSrVuHTa1cIVVkLISI=;
 b=qyrlRX7StWyKLq4zhbuzu7mmnG9mSPXiun/7vbXC9wqLCx5kpRNSNxjaB8WJtjtqf6r5
 LArjrW6JAU7woUweO7tZ994gWHLske/C7k+zAtMqesNlQmjtbq6a/p4gqW2q/J9eo4jG9
 M9Buno9qkYo8fDYx4/mm8XE0ahnwzyx9fAJD0gV/wT+3/N+OWVk3SxNFnlb31joEvQxDB
 R9zhGPvS/xtsUspIGvemK/iUm7hV2+efjTJw1m6lULQVZ+tt43BXkdDCFZVGS2sWJnoOb
 woJNzVv4h9X8LYP6EikQw9LQrc+1kbhxB8iPIbOoFMuh6FbWaPi4JDDSSfuwjFIsmow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TpDplQhy; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TpDplQhy
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3C4E4002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476932; x=1821012932;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FeeLgtXyIcvN3lZwwvk132f5c+qCV/DoD+T1EPFYWJ8=;
 b=TpDplQhyk+ps3f1J4jwSxrgCR6aZrs5t+b7yt3tRqcN5naKDBn1zWIr6
 M5OE2V/PnvadMV+H5dgKd3HWdFAnCt8U60dh4ncBOrnS6LiQABk8nQDgw
 4ADeB8THoQNA4agVGfFphYNeQ2HHo/C3M4mIM73tJ/12LPJfy6+VVezE0
 EIRYELHtAE4dZ6giheueLSOyVK7DRH21usT8q6Z3qKpwi+X1zDC+kWMwf
 QYyo3nEQtvSHYogbRLUh5eNJHKTNxzqX95UWxNZMRG7ZjohlHyvXFxcj6
 HqMR2ZxzGUwzWvDp1j1HMwgetkL0iOy+N/S2c4OiEbQ09ZFsYtz1NqZbZ Q==;
X-CSE-ConnectionGUID: 6hTNFRcgR4iV0uRYrDu83Q==
X-CSE-MsgGUID: 4DQWKzRSR6uYTjeyeA3EAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853101"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853101"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:31 -0700
X-CSE-ConnectionGUID: RFU1mVnQSCemnmpBejX2JA==
X-CSE-MsgGUID: xdqzrvrvRKOzFMB8kE1x/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225164"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:31 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 0/3] ice: fixes for pause reporting,
 autoneg and RDMA
Date: Tue, 15 Sep 2026 14:55:26 +0200
Message-ID: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
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

This is v2 of the ice fixes patchset for iwl-net.

v2 changes:
 - Dropped patch "ice: fix 'adjust' timer programming for E830 devices"
   as it has already been applied to the iwl-net tree.
 - Dropped patch "ice: report EIPE checksum errors to the OS on E830"
   from this send pending further internal review; will be resent on
   its own once that concludes, rather than holding back the other
   three unrelated fixes.

This series fixes three issues in the Intel ice driver:

- Asymmetric Pause capability was missing from the ethtool-reported
  supported link modes, causing ethtool to always show Pause as
  unsupported even when the hardware supports asymmetric flow control.

- Autoneg disable was only attempted when AN had already completed,
  ignoring the case where the link partner does not advertise AN ability
  at all (AN37).  Both conditions should allow the user to disable
  autoneg.

- RDMA was incorrectly disabled on E830 devices with 4 or more ports
  because the generic port-limited-capabilities path capped maxtc=4 and
  then cleared the RDMA capability bit.  E830 does not have that
  limitation and must be skipped.

Konrad Knitter (1):
  ice: fix autoneg disable when link partner doesn't support AN

Lukasz Czapnik (1):
  ice: support RDMA on 4+-port E830 devices

Tomasz Lichwala (1):
  ice: fix asymmetric pause negotiation reporting in ethtool

 drivers/net/ethernet/intel/ice/ice_common.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 29 ++++++++++++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.52.0

