Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01760A5BDD
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xN/4SWRw;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Td8ncVxA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BEBA80D1C;
	Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LS2SIaDRCJi6; Tue, 27 Oct 2026 12:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 74FB380BE0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103301;
	b=Oras9b9KFi89BjC4c5WvvC+kbafrdRJLXzvLTp/dkBaCmlxjFSETZtG0tKrD0Xjl9kxD
	 22CYChJGf8LArIzQeoqGncWxKP2euYt4hjf4Bfm00h7DuKSN74mB9yyLpRfb1DoyVERk0
	 4tVDwS414V+2gtS8MOPN5ZsVetIVQQDN2IkmROt+mMdPqFT/222lxijxi2qFG9qbi+FQW
	 /hgi73R8rhwGb0STOZ5IrEf7sirK5cpimZnaMXQYf+N845o11lvtrz2hJqRD+6GJK+yDy
	 xt/XrEs9sypUUY6f0xbDbhGhc3nV1kNy9DyOfWqXYou4FUkD8wSdBd+j11atoDcT5uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wsO1juH+qPygKRAFBHgPVkSB8xyUy8Z/UqIehySmMw0=;
	b=iqT5zOuE08Odii1guiwGczQzLX2HABfbFuMCkE5nAYLJ6QF8S4dlvFaGh4CxdJ8hZLqN
	 7T+XIsLXM6XnqOpoz2mpQAiNLB6P9FL6kqhxfOeYSEg9bwDGFvh9kDx2rKDgDXJAuij5s
	 Y99y79IHN0FRGMxhLZcWNH/k1jh6+t1nWIOcco+P6K/4n0FTI6oqklz7fbjv/N3alAzwn
	 qFMZro+wdlP2vs62GKN0jH/iD3A+afKXozeXsAb6R1RLRgd8nY05XoxRR9bvFg2Umdo19
	 b2nIdmHcXvsOL6Ixrf+DuK2iGZlbgjxBOFBvP/okn9ACy71E227fpRmk5EmvYY/KU6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793103301;
	bh=wsO1juH+qPygKRAFBHgPVkSB8xyUy8Z/UqIehySmMw0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xN/4SWRwmUSz5l4vpB4aXPhhIc1hC8KUsWoURrBq0kuYmI1SG6AWl/rHX27bGhLRj
	 oO+XbhwZAjyRDrrFRL3Q8K6yD+uF71GzIhpOXPYtyarIoHGUOmK5Va8ijuU8vNaAaC
	 ve3GV+ViXBUiIwTv85K4pr0QjZNZYlG4knZw7z+g5Qmgevbf8wjfeT3HJm891TcRfQ
	 5YW0COizHUAAXglU+6x34L5chUlPcjOZcKWbOV/OBEC+Mg1GNXOD25/gxD2sfbOFSz
	 J0wqIkAPX2+Mlh7nDYYXxbb1aoDRG+a568DxBb62+Og3BK+gCCSoUjd9+CzOoW5cn0
	 B7VtL7ZeRNzWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74FB380BE0;
	Tue, 27 Oct 2026 12:15:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FB613D9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85E0360725
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSDEFMOy2DXb for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:14:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AEFAE605EF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793103298;
 b=ArZYwsbBUvlf8Mvbk+sLyj5U9oyMNGZApbbeMeBsCT5y9Y5nMmdMu2opb/bFIB8+sbfZ
 sD4537A6jtkyakcyun2JY9cxiBaWeo/6+ThD93JkP3nfycd/wO26K2yQh53F5bYy/lOsa
 vqhm32AACHG80wRW6qjo8pRrIt6uJWMwA9rzwxjzY0Zdtna7sXpP5wpxwETeF7qyvdwiB
 LYbTts9KJz2X0YiPfv15LMNm90RnQw+heIJopIdJXGtfj8zbekaYwYWdwByznXOAcKLag
 ws/4L1dcF6cj/9ONqetfyOXhIf4C+KsAg2VScD5T5qZBRlpN0n4HOWJ3wTsYpQkpiqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793103298;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=wsO1juH+qPygKRAFBHgPVkSB8xyUy8Z/UqIehySmMw0=;
 b=SU+g8qprWYYPvPmPNPWfG8UHIcvmRBVfhNVF2W9fYvlNIQnrwIbPPgjQAxpNMJrI/5S+
 cYiD6Xzgol4paFpCwrYcvCKOxfXR3H0nrFJRpdBtN12u+6FZ5UtUdvKzgAWgyIoKKEYtV
 0WIsCp2cNtinUdLs6JfN55/JGi+OTjslRjkCPLgRLD+7Y6XhjkPi6Akb1NsMkDUQ4jCl+
 P3rFY5zUIJDIh+pOFr/IISB73XmvWcOvkU6HVto0OyaB5tYoQu7bpOfUaVVEsaFxHf3u+
 QnXMIl1WMM+QnGDN0L/OKK9dU3CB0efHnH9nLHRiKorpQ1/+rcVwf+JW2Pd0TksYDpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Td8ncVxA; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Td8ncVxA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AEFAE605EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793103298; x=1824639298;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xgVhCO7AITK5Da2R66zir1pxG+0NCGYhJxcbZJcq+8s=;
 b=Td8ncVxAMhMkEHVubYwM0TwP4mARjw9KRMOsThMTHOcTbtJ8jwi7qplV
 f3fTexIvp/TXIXZvfXP/wRdhlTrv8rtPMZMd+TWAWERZhM8EMS5y9mDji
 Tz4nx7VfQSEue1GZtzhTabpdmesk+xeabY+ZC/FgWPppLxQgjaA25bTsm
 2qSTNK/MVW/UsSpNBE90hJKvDKSr6abzKjAqhbKSFt6pJ9fClwmNRtibu
 qiXs5xyD8kYYXm3DxxKs6gsgS5MnXT7fVcJ7J1hgr3ulrjro1tG+OOD9A
 rJ2XtsyywVYgWPEeXQ+y0DzdX6wtXcTtbrQWsLvIPx08L1FH5QZczjb9o g==;
X-CSE-ConnectionGUID: u/McbqWHS2OzM+q0eQmrag==
X-CSE-MsgGUID: A6Bj7nuNRBaxaiftViMXFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1709343"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1709343"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:14:56 -0700
X-CSE-ConnectionGUID: FyuuJV9CRuqLtWENRAVZ0Q==
X-CSE-MsgGUID: 9M7TgGGaSgyYHYOLaFEAQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4529793"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa002.jf.intel.com with ESMTP; 27 Oct 2026 05:14:54 -0700
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Subject: [PATCH iwl-net 0/2] ice: iavf: fix USO for 32-bit systems
Date: Tue, 27 Oct 2026 13:14:40 +0100
Message-Id: <20261027121442.907414-1-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

That USO works for these two cards on 64-bit systems is just pure
luck. Currently, the computation of the UDP segmentation header is
performed using sizeof() a pointer instead of the sizeof() the UDP
header that the pointer points to. Since the UDP header happens to be
8 bytes long and a pointer is 8 bytes long on a 64-bit system, this
works on all those systems. But no such luck for anyone using a 32-bit
system as 8 bytes != 4 bytes. So fix this by using sizeof() the UDP
header that the pointer points to instead.

This was found by an LLM while implementing something else that used USO.

Magnus Karlsson (2):
  ice: fix USO for 32-bit systems
  iavf: fix USO for 32-bit systems

 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.38.1

