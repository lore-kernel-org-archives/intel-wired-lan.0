Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579F6C4332F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Nov 2022 23:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE46F8126B;
	Wed,  9 Nov 2022 23:27:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE46F8126B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668036436;
	bh=NZlPpdM7hyRBJJPFw6+kwSHvnsVXYfNSb4JDpgjDc+g=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=G+EFnPSwFv8i3FCDlkDgn75NOc4xEipHRV5EWTH1fH4tZc93JhnYPybL4rVa72tdS
	 h6IZKtpwiuUYqAdH0ZR4tYVW3uorVYySON3wr4LBuNBc/1gOsCMh0vcfHopeynv8z7
	 RjuKhfzKmbNvLVrqMUyyxxFt3YFYmfF6+d49mVATmVjRbSM0g9d26j4XK029FnG9rw
	 1QoWqS5So2XrLYz0kLr1E5S17apvEqX+isvWdMtLZ8m/cyF9jFozIoP4jvy5Ax3aQH
	 zwdaBYlwNmovZoz0NtlI5FmaDN/b6QygVq05hgApqHjjt+apoAWPQGQCIoNLxcjvFI
	 C3VFbPFqIIXLQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6IdR_oy1lK60; Wed,  9 Nov 2022 23:27:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id F326D8126C;
	Wed,  9 Nov 2022 23:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F326D8126C
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E0A3E1BF282
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Nov 2022 19:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B62CF818D7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Nov 2022 19:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B62CF818D7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WjrCZC62paWl for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Nov 2022 19:33:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15A90818BE
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15A90818BE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Nov 2022 19:33:06 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="373225144"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; d="scan'208";a="373225144"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 11:33:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="636868575"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; d="scan'208";a="636868575"
Received: from axxiablr1.iind.intel.com ([10.190.162.100])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 11:33:03 -0800
From: Siddaraju DH <siddaraju.dh@intel.com>
To: jacob.e.keller@intel.com
Date: Thu, 10 Nov 2022 01:02:52 +0530
Message-Id: <20221109193252.15594-1-siddaraju.dh@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103220145.1851114-1-jacob.e.keller@intel.com>
References: <20221103220145.1851114-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 09 Nov 2022 23:27:14 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668022387; x=1699558387;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0ohSmFWlVC7Npi2aBGpek0kdJN0Fd4Pb84oxfFOSCbM=;
 b=UQi5oR1Ctc9VtPp5yIc18kK5GmiAwYTwHzHpAANM4Jn6UBF6XPRnQWex
 ILDaI7YVuFXKbKBqQo6+uV3SCnePkIO2+po3lfjTRk68kJniQaFUw63B7
 /yaECwinrYwrQ+kTlz5ZLVdFZ1ATgk5xB2e8PO0FJx9fu81ty2qi+64Rt
 ErLemEBgPiO928RCU8dCnqGBrTbfl47yPNkdZD0/JYq0DEAF0XuSxZRKK
 NGmZ6IJ4AG8A0Isk2hUx9fNyXIDnlrtIrFTUzdFcmrWl5Tjy3XM0a7xxf
 5t43Xiyo7T00Dhkt+77XVkYDU6QbenmA/wM8a5Ln0uM9+9C62uvUwTn9L
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UQi5oR1C
Subject: [Intel-wired-lan] [PATCH net-next v2 00/15] ice: improve Tx
 timestamp corner cases
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
Cc: Siddaraju DH <siddaraju.dh@intel.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Reviewed-by: Siddaraju DH <siddaraju.dh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
