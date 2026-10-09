Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BADDCA9EBE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34F3A81296;
	Fri,  9 Oct 2026 21:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ksHM0TRVnxY; Fri,  9 Oct 2026 21:43:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DBDA81316
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791582212;
	b=mDL65UJBoZsf4wbwLAF+gjQr6U7vh/LaS/Nqjqk1zhpdUv4E3cSJxIEB3XhkxxR6NlkA
	 4IKnoKvuwVf4FWfxhaMqfMnzct7JOlcQQOaHacIJ75zjC5LYIJXY8byMOFGjtwrNYvwah
	 sfX/GJvBpv9IzGWAPNrPv/YCzmg2KAfk4O3kvW4AQkyNOkxaOBHkMxTIcEeDDF9paKwgw
	 C9iGIkoqIZOF84m2wIXUcU2Yg0Ty4PqFTAmZluEIaxDa9J6jhgctQkY0LVdc24bRo66Z5
	 mSU/f77VdcHE857t3shiWZqemN0V5AdHP5XWIyK2cMQIAmlJnZX78kRkDzWCzt3lWIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791582212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vPN5sG3PCYeiDF1ovzd7RysuBW9wGpmuSSyjMclqjGc=;
	b=TAoLXIeU3lWELMp71u3hqfyIVmY70MZMQnjXzX2y0hlyawi0w5aM8H+liGSS35iXdxwG
	 t9R7gIsKeYFGCqRRwHlSv+mcHf/AKY3UIzUL6REw0HY9IZgsqkdfS7qEzKVQCOoRudGID
	 7dtGEUPK+jnQ4rwQ9CB6g1+aAsMc7Ex+xghY3Eqh5fKJwTvuGGMjvwfF8Fv7hnbAR5hE9
	 d+n/MBdrbvjeZz4v/Grpi4VThM/7M2Jwf6N2OOPKhFktjRuHy1cZenKB24IXE1oBoSKk4
	 4iLFgzsZpOVKdclyfQd2fXW1dvpOZe51jBzvZkjoLIUMvgtg3qpMwjZBSMioS6sBpFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HPifkalC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791582212;
	bh=vPN5sG3PCYeiDF1ovzd7RysuBW9wGpmuSSyjMclqjGc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mUl+Mvx2d4rchoHqdwh/tAjpoXRUQfE/KixqtGf7A3NcwLzX0JCDPAJQNv7FBfRIK
	 NxqatKDDXAGFSbX9P8Ur59aQlPGlXeuZXGCzy8ThNXQJGUcjMpC6MA2pxMPsFUnI4H
	 OdJ3Wg6xnw5kwPh1g1Q1U4KHO6NSMxncmXbwVzC7LnxeYY5TNJlviOK1CXAIRiYIPa
	 BoP6sNYXx2gTNjR0PyfZakzUSQVsggn6Av7mFohf79lHXRDNdc7VwTwWL8MsEqKmhX
	 9anq8s4YsJ+Nl0O1DLyGToPUsyEyPXhr94FZXsLN9PtCaz68F/BfZhnOeTRZ24xW6Q
	 2DaCFYSloU70A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DBDA81316;
	Fri,  9 Oct 2026 21:43:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AAD7317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C133812AB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0VdjcFFfUHa for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:43:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F95681296
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791582210;
 b=PegNxXzvXDQYoF1aKMiNFw7vDTpsS5vcehTsViMsfASMCM3CTNVqLpWA+XwzPMv68ipH
 uk0N1VXKgnU65zZvxKkwtkYE7mW6IS/e4mscOn2Lej23BT0tZ2ui5MjWEYojTtB0lEgUF
 IO3xQWB1fQAxM/eEISX4DXJcuZFpHPC/wFdIEX6BCkqy3jUNh8gYUfn23ZPYI6D5pRnuW
 a+fXg6TarKf1ekxhWJeb12tgZanypA1PSu2wTQ0n9l0EJdXnleunFjcz4jb/jhURoNrCQ
 zbyWRroYSueVRExE+BJqPe3uhJvn2i+0gqOJG/hAn9kmeXjt8rldkZghM8upLxInjjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791582210;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=vPN5sG3PCYeiDF1ovzd7RysuBW9wGpmuSSyjMclqjGc=;
 b=j1FTReCf9yYzTlFMv7quw1s0juknasIm1nKMYVZKtR3N0rP4X5yOVD7ig2NpScsrEIxx
 GXd2znJ6hhV3yr9IQPNDXWEsvVl6ldMtT36otzUvkgxbnXouZUz1RgEq9LYGxJU9jyG6f
 xQa9mfPX4WWMKvjes/nq9QWpN03Q9RrFNp2NAJq6FuDvKOnIFheBVA0Aj/JfG3zMheXdO
 UQBOjRs8iRdsuCcZFXxFB8Ted9J9dj2ITWtH7BEsahSAKMOXl+hpm79Uv3LCXxWoh1XZi
 nY5mO7T1NRq88I8+pfFHW1taVqj9Y87vnhdXnnOwzZUroTDJrdcHy2CrCdXp1/cKwXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HPifkalC; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HPifkalC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F95681296
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791582210; x=1823118210;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qOOGQyYoi7ZWlLJxe+2515nl/AwHO6vLpnp0P4IfFiw=;
 b=HPifkalC0HJJXWKb+b1BBpi8Q5lhJyyRaCj7crBMKC6hIDGAaGvSWMZn
 y4ZxUAur/Hf+vc8p3CptQyIwpcOCCqr81oD5H/v+pDcIg2GnI7QQFIbTQ
 rG1qeFMDIr+ga6R8UNqMerJd3KIRbnErrV6wDhFIhTXNusCZ1UE37vs+u
 RrKKu9z28HQ0hZETfx6hShrbhKc0fMGzrz1qEfjqGOt7fj56geeBY0VdF
 Dc+3XvFL/rzjhi+te9b3SvKVJqOEvYHPEHeWvZPjlCAZWpAutfKU6QCB9
 YqD71MmcUgpDa+D5HGqMrnjColl5e9Rkmc6mpwy/4etmbOkSsWKqp0O46 A==;
X-CSE-ConnectionGUID: 6B/kwpEOSkWgo38HHGp15Q==
X-CSE-MsgGUID: KT6nir/pSgG7Sgqpr82Zag==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="381505"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="381505"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 14:43:29 -0700
X-CSE-ConnectionGUID: kgPkVSChRYKouUYO1ZF7HA==
X-CSE-MsgGUID: AqjFP1xuTZW838mdcS943w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="366981"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by orviesa001.jf.intel.com with ESMTP; 09 Oct 2026 14:43:29 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: milena.olech@intel.com, konstantin.ilichev@intel.com,
 joshua.a.hay@intel.com, namangulati@google.com, decot@google.com,
 madhu.chittim@intel.com
Subject: [PATCH iwl-net 0/2] idpf: fix use-after-free in PTP auxiliary worker
Date: Fri,  9 Oct 2026 14:25:35 -0700
Message-Id: <20261009212537.3996-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
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

The PTP auxiliary worker walks every vport and its Rx queues to refresh
the cached PHC time:

  idpf_ptp_do_aux_work()
    idpf_ptp_update_cached_phctime()
      idpf_for_each_vport(adapter, vport)
        rsrc = &vport->dflt_qv_rsrc;
        for each rsrc->rxq_grps[i]
          WRITE_ONCE(rxq->cached_phc_time, systime)

The worker is armed by idpf_ptp_init() during idpf_vc_core_init() and
re-arms itself every 500 ms. This series resolves use-after-free issues
that will happen when the worker attempts to access resources freed by
the driver on teardown and failed init.

Patch 1 introduces rxq_grps_lock and use it to serialize every transition
of rsrc->rxq_grps against the worker. Discovered in testing, the
conditions and trace are included in the patch description.

Patch 2 moves idpf_ptp_release() before deallocating the vports, in the
error path of idpf_init_task(), matching the logic in
idpf_vc_core_deinit(). Discovered while reviewing the fix in patch 1
with respect to other paths that may be problematic for the PTP worker.
The condition was triggered by injecting a failed vport init. Trace is 
included in the patch.

For both patches the issues are not HW specific and will manifest for as
long as PTP is enabled by FW.

Emil Tantilov (2):
  idpf: fix use-after-free in the PTP auxiliary worker
  idpf: release PTP before freeing vports on the  init task error path

 drivers/net/ethernet/intel/idpf/idpf.h      |  5 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  9 ++-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c  | 16 ++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 65 +++++++++++++++------
 4 files changed, 73 insertions(+), 22 deletions(-)

-- 
2.37.3

