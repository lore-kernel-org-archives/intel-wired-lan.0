Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27322C001DE
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Aug 2023 06:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 976D640490;
	Fri, 18 Aug 2023 06:47:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 976D640490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692341234;
	bh=h8bkTmjPMYRNwvTNRH6z4lSz019KDAf7KPyagt3RIMQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=uQrju+QHVGstBBht673ljtE0AwOqsWkQj8YGv1FYOzCljov7PCHy3hMZPqz0fo12J
	 7b6fL+0oAaHXBKvGhnruj9zhwFCf/7UWSt9r+Vy374Ux70BTakTLMRG0Q6cDhT0wjt
	 2+twbJ2Erz3SSk81lgcOLoMXo2P9zLye6hKdc144Pjc6V2ZjtXBxCA6NaCe79mCa7i
	 tekC3/xjoacB2hXCOBwjOOxCl8QCrNBAVFHeHsYrO+DGlsucCJip7UoogYzMymdwWp
	 WXm43UOwvJslb07dJwRfWLwgiraa3S6PZDG84w2hWPH9wqZobayK8ObivviK2mcLzG
	 VAOLt/dLU1zEg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id quNrJsW7OLFb; Fri, 18 Aug 2023 06:47:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B32B1402C3;
	Fri, 18 Aug 2023 06:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B32B1402C3
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CAF621BF2B4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 06:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D58840490
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 06:47:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D58840490
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOGatRwztz2G for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Aug 2023 06:47:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F8D6402C3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 06:47:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F8D6402C3
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="439408345"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="439408345"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2023 23:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824997387"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="824997387"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
 by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 23:47:07 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 18 Aug 2023 14:47:00 +0800
Message-Id: <20230818064703.154183-1-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605024453.2378898-1-junfeng.guo@intel.com>
References: <20230605024453.2378898-1-junfeng.guo@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692341230; x=1723877230;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NEa1gYjFAzfWB2EjJ4eSC2R6sLBuBlUWr5iejdHTtZ0=;
 b=VMdhX3pb1kte3sParYhb8AZXer8XjCFuHpR6NoOfITRldGX9YwY7rHmi
 O7Df30hXmtFCPcdkrwj6oyDHyv3hT7cSgz6HBfrIx1D+OfQwYgBqqkUbe
 Wd60mPGTTwiiHXmfj7/KBLxnsnEaTQA8GfBQwXlABQiAZte9HeH8sWLlI
 kzuPy0DjWUPX9CQkTKY+5Ykp+CHLF06FvQo4sp2wSbHAIbVe9VliMj5Kj
 vDAxYry0isomx9rvNPiFjuOFpvonXH2+1U3IIa0w8pv3UaRvw1r6t/QBE
 y8nFu56b5qXya2HJywG+zCLpgknU8xecRtowg0kB+ieMg/ORkxdaXV4P5
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VMdhX3pb
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/3] Enable the raw flow
 filtering for FDIR
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: ivecera@redhat.com, qi.z.zhang@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This patch set provides a method for applications to send down
training packets & masks (in binary) to the driver to do Flow
Director (FDIR) filtering. Based on the Parser Library, these
binary data would be used by the driver to figure out the infomations
that are needed to create/destroy the FDIR rule in the FDIR stage.

With this patch set, the raw flow filtering for FDIR could be enabled
to allow new flow offloading features to be supported without any
driver changes (only need to update the Dynamic Device
Personalization package).

v2:
- Replace magic hardcoded values with macros.
- Init DVM mode for parser before running.

Junfeng Guo (3):
  virtchnl: support raw packet in protocol header
  ice: add method to disable FDIR SWAP option
  ice: enable Protocol Agnostic Flow Offloading FDIR

 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  99 +++-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |   7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     | 114 ++++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   8 +
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 460 +++++++++++++++++-
 include/linux/avf/virtchnl.h                  |  12 +-
 7 files changed, 698 insertions(+), 7 deletions(-)

-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
