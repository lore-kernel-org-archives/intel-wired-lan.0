Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D985D3EE84
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Jan 2026 16:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48C27405E7;
	Thu, 22 Jan 2026 16:23:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3sbagVvUb7R; Thu, 22 Jan 2026 16:23:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C418405DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769099028;
	bh=fSPBjnXiwkb3Trb5xPtL83txqpG+MDatg5fChUvhWmU=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XwdkSbnQAhB/sONsl+OR3phDpMMq9EZZQcm7XAnb0NuS4+drhymyIeNO5jtFxuqJU
	 MYR0+8rjr2s08gMDqkqY5k8I/h53ugKs+iN55Dx9HPTTY2mosC8+YLHpH5Nt//w8kp
	 2qS83ZA2us+bntTF5yXjK+3GLcPmIdzz0IecXc8WGromNE8Jk250uSvjWOP8KWLkEp
	 5wdvvhTg5K0N3zAwz8IThYXhIhfZT0z/x5+IoYDIKz0xAMnJE7x1edhW6nsGUDkRjI
	 zDGet2YzQobWgtl/E7BSDujZLjhYwnCnowvtBUdV1rSMZnUgeeDvQzX+A2WGz3AKSn
	 11+1htZHj7HMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C418405DD;
	Thu, 22 Jan 2026 16:23:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76BCC122
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 16:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 649A4812C1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 16:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dv6As4WoG-3q for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Jan 2026 16:23:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=piotr.kwapulinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8E69B812C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E69B812C0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E69B812C0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 16:23:46 +0000 (UTC)
X-CSE-ConnectionGUID: OU7cJS4TTwCCjArQzK7G9A==
X-CSE-MsgGUID: 8P+pl6pdRWia34qTWV1J4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74198955"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="74198955"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 08:23:45 -0800
X-CSE-ConnectionGUID: wlr0GsckTR6DU80y2gsnmg==
X-CSE-MsgGUID: PvVe2uwWToeIfH788ICvuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="211625961"
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
 by fmviesa004.fm.intel.com with ESMTP; 22 Jan 2026 08:23:44 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Date: Thu, 22 Jan 2026 17:44:38 +0100
Message-ID: <20260122164438.112469-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769099026; x=1800635026;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7rwY97g4ofATDXBFjwomDZ6MCIT+W7MiZ9pKqkzwOeM=;
 b=NEW7k8lehO108GvQwsl6qI/e4lYVF6pymr5qzJKAz0PKNcaCUN211SDL
 Z3PwIzAOXp1qJGMjPhSNrhZqWynRIPM9lwQzajylooJgdnLuZXcisPmh4
 DXqKycgVJzZ88lIsbu2PZhlvtahCfc5s0/TFI4OKHEoiCAPdDjI9MFNDl
 NaKSonuFNHAPNybwJHemEtngc+T7NlNDdozY2OnFUx/M7TDHZYty1ZA+F
 TRl+NIuliWrP8HQcEpf7jz0FqUVsEbZbxbvzdNQfGsI/REWv1KI9R/HPx
 4zbw7W/yU6SeKRwG1j8XDGJl6vm/g/v+kGQCz6IKLWwJxBreL/4yAut//
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NEW7k8le
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/2] ixgbe: e610: add ACI
 dynamic debug
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Enable dynamic debug (dyndbg) of Admin Command Interface (ACI) for e610
adapter. Utilizes the standard dynamic debug interface. For example to
enable dyndbg at driver load:

insmod ixgbe.ko dyndbg='+p'

ACI debug output for e610 adapter is immediately printed into a kernel
log (dmesg). Example output:

ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0701, flags 0x3003, datalen 0x0060, retval 0x0000
ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0:       param (0,1)  0x8194E044 0x00600000
ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0: Buffer:
ixgbe 0000:01:00.0 eth0: 00000000: 01 00 17 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: 00000010: 1d 00 00 00 0b d5 1e 15 5e 4b 90 63 aa 0b 21 31
ixgbe 0000:01:00.0 eth0: 00000020: 69 eb cd ab dc f8 8a fd f4 53 e2 dc 54 e0 81 fa
ixgbe 0000:01:00.0 eth0: 00000030: 12 dc 41 82 01 00 00 00 24 20 08 26 53 08 00 00
ixgbe 0000:01:00.0 eth0: 00000040: 08 00 14 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0009, flags 0x2003, datalen 0x0000, retval 0x0000
ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0:       param (0,1)  0x00000001 0x00000000
ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000

Piotr Kwapulinski (2):
  ixgbe: e610: Convert ACI descriptor buffer to little endian
  ixgbe: e610: add ACI dynamic debug

 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 119 ++++++++++++++++--
 1 file changed, 109 insertions(+), 10 deletions(-)

-- 
v1 -> v2
  Commit message updated

2.47.1

