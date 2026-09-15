Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1829AC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA9A880D87;
	Tue, 15 Sep 2026 12:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XvRH2F8c_SS; Tue, 15 Sep 2026 12:55:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 518EC80A49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476943;
	b=qXKOBJnZNsJeYV99JPPkY/rwOKjfxK6FGKp3I+VwPHS2Xp/rQgT7i9AL3MzZRdtergx8
	 l1toBucOW2QCQcdI/2Z5ic3JEYDJnOruG4ktkEmI/pePZo5GvB2v7KcPaWfCYx+em/e9H
	 6hebYEpCbgWq17UQ3JIQn66De8XbDC25eaOzCqPWMio2b+hhqHzidE1VoGfM5GHnAGa3b
	 qDMsmUdKO5xoGkzxu59go20LwURP3n8m/AtikH31vJW0lDvTgcrNMb7cysdAJONPU4o23
	 ZZ5mWPTuxQh3eJo4uFs/JuNBRV8wBmJ6ki2D6a/BqP/exbFqKmidIXkhvUrHmpEXkbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9B+m392C2EAoR13+zfNc+g/7erKJJw75SveS1jXKw4c=;
	b=Ah8SrepDtEX2TODqeROz3Em9Qe7bvQ1Gy+YdIgj3JzEa6xy5GifZWZnhw8Gx0jfUWdFI
	 rDA/APrlSUbjXsGBYn33k1/FVoppOnof2wQk4cr3bVeZNU7nankSOOzV/BOqUxB9ZlgdW
	 rWpT6eRWphfnaVBrr4x/erdVzgAUsbOarYcjjSQ6g8ONXmMmZvp114vtu3fLu0YvH31Xb
	 oQXfdyexponeEbeBo62BKpCecgvYzazGlBYWYvi8h/ywraZw3C9GJkZ+deOMIgZ0R+l1e
	 5sa9KNZs/Q2Slvoy2/NoETfAsn7p/Jb4wRhAmLF/QPYm7VsYzFJKz6EG5Hg14Amdggw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476943;
	bh=9B+m392C2EAoR13+zfNc+g/7erKJJw75SveS1jXKw4c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UExqh3JkHR4RjOYeVN6LtlBUk8cpG3tYvbB8bjCIVIgzJCc9+kEUNP6XciuZ+nS7+
	 XSNRceJjrlV38GBrjlH4v5cVdnWyXEB0MG/GuEH/VjXkEGrl1E1af71ZgqvaL46dVl
	 Z/sffuCPMzh5+zllw9R8YSe4GzHCI4BE2DpJf1D4jIK8fpCdRVYzkPSYmDj3LmN6bN
	 +nouLc48OqJnUwth2MPBLTSHFKO1/DfhIn6Urbtu2aTBNwRO0YVcGISx0v69ma87+1
	 p4rahqVtqY0b4nocyYueMnR8+397Vnx11SFJRukNg2m9pa11hJSgmTgA5lfPBDmLbu
	 wKWZqkV9VAHrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 518EC80A49;
	Tue, 15 Sep 2026 12:55:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 25E05259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BEC04009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FrgADfXkSjGC for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6DBA34002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476940;
 b=TDVjzkMEmvh3ihNKEjSy64kvyqxMqlLMosxR2HwjeAP61Fz6DIf+Pgsvuq/w6F09hrF/
 FhTd0w+KMSj2gcbb0s6vf3h/jcQH3G2HzlCN0bQev11deBUXVvPhBqbuTS90g3OQLgFT7
 j6yyHO6GVYuOOyZxk+Fjf26HuJjmrkq87bVwSeRc7mcl6kwPiaozJqYFkcrPJ1AtdhVrc
 FEeYlPXP2WwY/MO/V4oocxmKYgB33PiU/uSAgjn17yPYjDzB74kZQIicex8xLGNzBoo23
 GLPL+X9AK9iz3LNeoCymDqpPqtAovQr8j1lfsTMgwq2yE2KcLAkNaqsiVwr4UKuuIig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476940;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=9B+m392C2EAoR13+zfNc+g/7erKJJw75SveS1jXKw4c=;
 b=VADPbhLaeubRNf87wAgxOHVfMd0vDIlnscQ7Nvq01IMlIagDfDcutuqq0B04iN/8xuEY
 Tk+tS5RW6fgJAS1es7SaA37fZnYJNVKmAZVJpewtZydUnH5Ix9HjvWQhiAQwVkDLTTPSX
 zbb3bVEDREmvGn/UXjAgIxKog0o4njtm4VWPNdzk92jZe6RgThafAj5wdaQ1+6bEi75zc
 VBZ4uEb/4XKYAgTpA8H6GKVNES0x4O8Cp8ej6URl2ZXlPbo7r6YMklkAgDF5EhUol5VnW
 /nbusGlUgeLTCjQdUm96oX0YqM3zhAwpaGrEFOa3h914SszvCE06QblhOLinsUXZDTA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TtlvQbHJ; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TtlvQbHJ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DBA34002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476940; x=1821012940;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rpdh8R+NRZzqvazI4/u0qaGqY5bMi/i8jHNEkqrrHhY=;
 b=TtlvQbHJ65kZQ9RCTJTqif4iag81cuOOpmgkkGDPLLcY0YMdOAQYFruX
 nuQSj+zJhMnx9YWT2HIpz3EEicd29rUKdvazF+aeV3TGINBMOMecklcW/
 AzyMJo7Sfd5a2m2pNvvtCAb83ZbGfdLd8qLO+dbqLbnQeYfWMTeUrHGbX
 qX3cfM8VxJ/e27g28q+mURiriZ220J2EeXO4qmNJjS8GSWeFMJyUwNyP8
 KMRQYDz4JpX2bnaaLI7fWs09Nl0r8JveDjuGn0evFAKOiSJ6UBubnNlTl
 vBwgN6PTcnxkYQiGw779CJ5g6rExi+L41u979SEV2mgHQCiThHGPeUFZy w==;
X-CSE-ConnectionGUID: NtG8QiUcTYyb7Lz9cwqn3Q==
X-CSE-MsgGUID: PjBQXE8XSOKOMgN8nIjpAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853115"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853115"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:40 -0700
X-CSE-ConnectionGUID: p31Ag7D1RoSIdkQSviTJBQ==
X-CSE-MsgGUID: ITyztPNjQuWR9Q3zi0vbWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225213"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:39 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 0/4] ixgbe: adaptive ITR tuning to prevent RX
 starvation and ACK overdrive
Date: Tue, 15 Sep 2026 14:55:34 +0200
Message-ID: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
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

This series was split out of a larger internal "ixgbe: nits and
improvements" cleanup batch. It tunes the adaptive-ITR algorithm and is
kept as four small, independently reviewable/revertible patches rather
than one monolithic rewrite:

1. Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 so the minimum
   bulk-mode interrupt rate cannot drop low enough to starve the Rx
   descriptor ring under sustained full-line-rate traffic.
2. Add an ixgbe_container_is_rx() helper and give Rx containers their
   own latency thresholds, replacing the shared Tx/Rx heuristic that
   the lowered maximum would otherwise interact with poorly.
3. Limit how far a single ITR update can decrease while in latency
   mode, so a low-rate ACK-only stream cannot overdrive the interrupt
   rate in one step.
4. Name the usecs mask used by ixgbe_set_itr() instead of relying on
   an open-coded complement of the mode-flag bit.

A fifth patch from the same original batch, removing a redundant
ixgbe_ping_all_vfs() call from the link watchdog handlers, addresses an
unrelated VF mailbox race rather than ITR/RX-starvation behavior and is
sent separately so this series stays focused on one topic.

Alexander Duyck (4):
  ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
  ixgbe: add ixgbe_container_is_rx() helper and refine RX adaptive ITR
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 80 +++++++++++--------
 2 files changed, 49 insertions(+), 34 deletions(-)

-- 
2.52.0

