Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35144606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=55QrFeRK;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IMJ46ECR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1735C40564;
	Mon, 26 Oct 2026 22:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XvxiBHyHsPOu; Mon, 26 Oct 2026 22:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7929C40541
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793054239;
	b=thD6bpovT2hE1T1qgcB8/IOZ1vHv8UQiLhhupwFClqjhmsCU2u0kmXnHFlH3LzbCKNG+
	 Ynclye3wh29nVbRBIyx4T78wlsbT3ybq9QKrZ+BgjiDq76raEMLF/UaLBZNqqZITnvZif
	 WzFCMG2W8FMhKJrE55JUVfQsqOmMqtK1Wh2i/GY0dlxU4v/zYPf+/d7qv9dcuXGtwN4XP
	 0xrkt9QIju9R3jtWcONce6GOnfO0/YFNtit7Y4T+hv4G+/w1ZFm+ymmh3LoGEjDC5kWlw
	 sWopZNfGNEkS+Q07QHP9gD5X0Aawui0DvBOOROM2ulSTwtTlEwNgxg/OGim+TcvTyQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793054239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PHqpiZGdhoD5vu76Ijvn6//meczoxSumkSX8oVTfzNM=;
	b=QEc8Ob4Ge/+mpv/5LoIYet9EqVOcCmHYbPpU9dx7eKi1NEkiz26e3q2Jn7QyX/EaMKRy
	 yN9JYNFI6avQvDtx4KR1bv5KIAVNGsmHScLE1jiuWGabeffsg19mq2O2Q0qLk7JSmp9hC
	 Zkn34lAl9mSsXFbKftIUsGf058JOIfZhgsCcGDppcJloQvyYjvflNCtc/8oAylVQqwqms
	 2grYEc4EI4OnrXuWHWPI3wIUILUrmsvSYopmd2/6nAuFc6QfoLDn4uhNyG5GdlQAiPyWn
	 ayFxh1TvGN72l1wvssaUJxGwrffdmfrvPaQY1Ck71Lr70PzpnGiidk2w5uPkPK8D7jg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793054239;
	bh=PHqpiZGdhoD5vu76Ijvn6//meczoxSumkSX8oVTfzNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=55QrFeRKSlm5gkNSx7GdkSQ/Spx3SwlAhSzU3EJAmtHZdgBkNJyv1vGEcNB+aYBrc
	 zCJ064/WGCTIv2IuoiXqwC6XnVdDSo711FVVy5N8A1mtYv9vbcVMx5bJmjCIPps0wA
	 oip+/IiECgPfNz3U3LCsGBpAz21xmxul24kvr6FbKpX+tL0tUYHfgP5Pgbj9HgmqOI
	 K3beuHDU4mkX53zCcy4/dlnZart8vFbLPsgGdEGYwgTmNGjx0LVRoMeM1AiHjAHXss
	 qBbzotY4VpEFu1AvVAGBt5CUItX3XXOXmCBvcj+eai2V3FMQRIBgUWZH/YaapTE3tX
	 GjvZ4tYnZelSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7929C40541;
	Mon, 26 Oct 2026 22:37:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D709A2F5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8B1F80AA6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kkx_2yenNtm6 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B383C80A95
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793054236;
 b=EWSgIqeINK4RJsvu6oJcbiM2Nr8LmpZMcDiLtl6OL+PDTytcXK6mv0AiMcrqqQGyX+nJ
 5Og6HCXdv3cSPsFdjZH1qwVmkzb6Te02nHoeB+6Fe592LYuF8sPPo7Tj9sajSJHf5PWrB
 lidZpn6oe6bWGTycUsiuFuHJ+f4tScpSfutqGByeA3uKrXxNiCZSsqkzyshlRg16djIi8
 VKAs7cHBkmH7A1aZduNk5eaxOPNobA50Awn6bAuRV6mM6SDXs4/tLhdIRw6Fd2AW0UBi+
 owJiQut3n7LfQpVE19fmq/5rZAqAzlw0X3IdUx+vynOaIL/FHGMqpVszUZiqJDzQiXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793054236;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=PHqpiZGdhoD5vu76Ijvn6//meczoxSumkSX8oVTfzNM=;
 b=ryO9zxwPwOFmvj/by51R3Owu8LXuKbiEQE/VKSUScFLBTJZ0uIJknmvbDpIUdBchgT0Y
 ph3cg43E7XO6fg5SSbo/Vwna9DENIvfdgv+wqQBG5bo68VCmT1dQFWvwoN1Qax3R8qg4d
 AVZ6+DrV5IK/8mcl4IueVIqCvUMH/5e66ZmSSVKA2/aGa2K+evHUpScZvOikaEDKy0mUW
 BKGLVin/3ftTKemRVD93dJyvaBwXIFoy2o26Yp+74dT9c7Gm3V0wnxHBk/ZX9Acl0dLAK
 GPzm3Mp3kmfXBJHTgairMp74u2cohxzDmFB+SoYfR3EJZlLtw3VqR7wdauJ7QcAgHJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IMJ46ECR; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IMJ46ECR
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B383C80A95
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793054235; x=1824590235;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Okwn7M3ZYOeAPTAHNHPAqdtqM3yrOy4FAegJURs2ykA=;
 b=IMJ46ECRQgq3chxa834OTynT7ALAOLfeHrK+3l7UrLotf5OHBY8d53rW
 4GmpFfN/djbMR5+YyxR8eOpKP2wmHkAlRRHNNmgJEvHx8OsXI0mVxeuob
 VEGiVnmvK4DYBLmxwK1pXkimXktw3+BGaYjUdVIAR2OoGxUmkr++RlWrT
 nxoYNI1JWEjqTHr4Lor2OsDwOedhQAeZEHs8BK/33K1NF6Km5rID390pV
 Q3UgMMNyIAhSJGFb3/0EZLCkSLqV052HQyaIJJnOKSx7Cv4CoTVnlYDEI
 HKEGoHIbi7fkGiXpx5irxMOpuGQwEbKgj9KzYhRGepEDgDjw3b0bwq2m9 Q==;
X-CSE-ConnectionGUID: bxxp/83NRQaQ0D72CjdmQQ==
X-CSE-MsgGUID: oionOEOFRLuwM1khD4hUSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1616398"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1616398"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:37:14 -0700
X-CSE-ConnectionGUID: pD5jWBZMQ1O7EpL7DEpQpQ==
X-CSE-MsgGUID: 5ZtY0x4gQOitqk+cGdfLoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6217173"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by fmviesa013.fm.intel.com with ESMTP; 26 Oct 2026 15:37:14 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: phani.r.burra@intel.com, larysa.zaremba@intel.com, joshua.a.hay@intel.com,
 horms@kernel.org
Subject: [PATCH iwl-net v2 2/4] idpf: skip empty netdev slots when detaching
 for a reset
Date: Mon, 26 Oct 2026 15:19:06 -0700
Message-Id: <20261026221908.24690-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20261026221908.24690-1-emil.s.tantilov@intel.com>
References: <20261026221908.24690-1-emil.s.tantilov@intel.com>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

adapter->netdevs is sized by caps.max_vports in idpf_vc_core_init(), but
idpf_init_task() only creates netdevs for caps.default_num_vports. These
are separate virtchnl2 fields, so on a device that reports max_vports
larger than default_num_vports the tail of the array stays NULL, causing
a crash on reset:
echo 1 > /sys/class/net/<inf>/device/reset

  BUG: KASAN: null-ptr-deref in idpf_vc_event_task+0x22a/0xa30 [idpf]
  ...
  Workqueue: idpf-0000:83:00.0-vc_event idpf_vc_event_task [idpf]
  Call Trace:
  dump_stack_lvl+0x77/0xb0
  kasan_report+0xca/0x100
  kasan_check_range+0x100/0x1b0
  idpf_vc_event_task+0x22a/0xa30 [idpf]
  process_one_work+0x917/0x1940
  worker_thread+0x5a5/0xfe0

Add netdev NULL pointer check for every vport in the loop, same as the
max_vport loops in idpf_remove() and idpf_init_task().

Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 791ebff985072..0cdbd81b13711 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -765,6 +765,9 @@ static void idpf_detach_and_close(struct idpf_adapter *adapter)
 	for (int i = 0; i < max_vports; i++) {
 		struct net_device *netdev = adapter->netdevs[i];
 
+		if (!netdev)
+			continue;
+
 		/* If the interface is in detached state, that means the
 		 * previous reset was not handled successfully for this
 		 * vport.
-- 
2.37.3

