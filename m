Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCF3C04A6A
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Aug 2023 05:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C91160DFC;
	Wed,  2 Aug 2023 05:03:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C91160DFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690952635;
	bh=a0k4FtumpqaDhlK3R9tv2Zcb06wWeiBQEIAt8DRCN9E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=cPm2l+/4jQxD+Yc1BClSngBSFFHTglaPPEQSNEDVKZ9R6jw/WRedW5bBrAEnzX+r0
	 qkF7Z4QV/RrmwAxyC0hh8F3FsK9wG5xzhfdlW8twemr1/Cg6Mm2nydi5nJ1HRvMocv
	 fOXuulorNx6i0jTD4mUNCLDv1n3SC4fGTHghEafaW2TiQ64cuiv6+hW5emhk9LG/IZ
	 Q7+Qcl39P5qqCIm92LPUJ0O096V97VIgERj6CqgTp4oJrqBt5Qn0VcLzZ/XAaPRzhv
	 RcN7Krda+Ps8KSEEHSj/Xe+lapIpvHC+24KcnK1NI7YuAVWnABtXcOunl/aBQKEuJx
	 O3snY+oOo9ddw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vCmEtp6dQTLS; Wed,  2 Aug 2023 05:03:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 429EF60EF4;
	Wed,  2 Aug 2023 05:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 429EF60EF4
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 60E861BF33C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 05:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 730AA4174F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 05:03:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 730AA4174F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDSs2uiPYqYR for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Aug 2023 05:03:45 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BEFC94175A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 05:03:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEFC94175A
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E8F3D617CA;
 Wed,  2 Aug 2023 05:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E6C433C8;
 Wed,  2 Aug 2023 05:03:42 +0000 (UTC)
Date: Tue, 1 Aug 2023 23:04:48 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 fam1-i40e/0001-i40e-Replace-one-element-array-with-flex-array-membe.patch@work,
 fam1-i40e/0002-i40e-Replace-one-element-array-with-flex-array-membe.patch@work,
 fam1-i40e/0003-i40e-Replace-one-element-array-with-flex-array-membe.patch@work,
 fam1-i40e/0004-i40e-Replace-one-element-array-with-flex-array-membe.patch@work
Message-ID: <cover.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1690952624;
 bh=Lh/8DXYnrVwSuT95CJrJrjg3AAwX2dmsR+R7uiAEAko=;
 h=Date:From:To:Cc:Subject:From;
 b=r8e2tnRr6NR/LJPVYeu/KXYVkqyD0lFLFN6wGOkUXSTnUvkHDwxIOHNPqVuq3fu18
 dW+IjDhbZTUUy5VqJL3lObzr1M3wg9vwgla000FujrcSx8KH3fxIaGKnFHXW8HruSy
 aoeKf9L4La43QQvz+pDwhEZOykqvRb2M6cNfJOMAfR50hmRGcM19Wtos27b39mV66G
 G6E3LxGY1Sp5kwbXVMy+Y+h2BFcyVip+M00JjLHhuP6t9Xb4B90mubprHGO93YA9yX
 GGLeuFgMQoA9czqR3P1/u6sJZX5FR1OPeiUhgC8R0atIvazIzrSgdU5TvvZ6ZyLDcN
 Vc6wXOtl+e9Mw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=r8e2tnRr
Subject: [Intel-wired-lan] [PATCH 0/4][next] i40e: Replace one-element
 arrays with flexible-array members
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
Cc: linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Replace one-element arrays with flexible-array members in multiple
structures.

This results in no differences in binary output.

Gustavo A. R. Silva (4):
  i40e: Replace one-element array with flex-array member in struct
    i40e_package_header
  i40e: Replace one-element array with flex-array member in struct
    i40e_profile_segment
  i40e: Replace one-element array with flex-array member in struct
    i40e_section_table
  i40e: Replace one-element array with flex-array member in struct
    i40e_profile_aq_section

 drivers/net/ethernet/intel/i40e/i40e_ddp.c  | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_type.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
