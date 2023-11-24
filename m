Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0E9C61D97
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Nov 2023 15:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C4856156D;
	Fri, 24 Nov 2023 15:03:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C4856156D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700838235;
	bh=32ysEOslRnd/8+qC2pwrC3r4NVytX24ohyUihatQc2k=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Q/IwKhtUi0ZjqenTSGS87HGv/z71g6MWc59d6TN46ubs5Ua1bRjP9CvehLWrkwbAX
	 GBpd5AzmRX4a8JAgIE81yTYvmuHf1e1f9UNAQ1SV41K3HQA/xiSddcuuRAV6vTCg3W
	 fQ88WyDPJat6GIu1XCFRS7WTg86R66OkF67HWQ8NhdKSRJpLn/I08iVOF6rhlD/qmy
	 D4a38WC4TOGiRILVFXhZ44BlaHwxTqKv178VYebA00cGZp0d/ip1uat7y2LraA1OOL
	 83MXyjzYDnNyxLeyn+kBQ7XBMP+Sj56iYY2gFiY8fFyfog4GAo1nfM9f12Z0AOKf8u
	 kGRrEjNxRjaog==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rzUDZBenvM1J; Fri, 24 Nov 2023 15:03:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F3EB61595;
	Fri, 24 Nov 2023 15:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F3EB61595
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 12F611BF271
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 15:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB4868221A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 15:03:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB4868221A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GHIykvVVUq3D for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Nov 2023 15:03:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93DEA82211
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 15:03:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93DEA82211
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-YwIFWucYO1i2thUxLoGzug-1; Fri,
 24 Nov 2023 10:03:47 -0500
X-MC-Unique: YwIFWucYO1i2thUxLoGzug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F8B33C01E0B;
 Fri, 24 Nov 2023 15:03:46 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.226.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40A7B40C6EB9;
 Fri, 24 Nov 2023 15:03:44 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 24 Nov 2023 16:03:38 +0100
Message-ID: <20231124150343.81520-1-ivecera@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1700838230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0XJZJPBiFQgSSe+XxCMWeD8kd9qiENSYyfcir+QL/Yw=;
 b=aeJCzS6o3/DeQr0EYcF/JxxXZ1OIl1DcXZ68EOMI3Bm0ndbN+AYnMJPTxJBE0fFa4bu4AU
 sfrNDvvbxA1R1vaU8lGYV/pJERIAmquL9JtIqjr7Ac1U2elfULELpr0h2BhvD9cRKpKATE
 qEG64ti8xJIgfqJl2ZBthi/JF3vzOfY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aeJCzS6o
Subject: [Intel-wired-lan] [PATCH iwl-next v5 0/5] i40e: Simplify VSI and
 VEB handling
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The series simplifies handling of VSIs and VEBs by introducing for-each
iterating macros, 'find' helper functions. Also removes the VEB
recursion because the VEBs cannot have sub-VEBs according datasheet and
fixes the support for floating VEBs.

The series content:
Patch 1 - Uses existing helper function for find FDIR VSI instead of loop
Patch 2 - Adds and uses macros to iterate VSI and VEB arrays
Patch 3 - Adds 2 helper functions to find VSIs and VEBs by their SEID
Patch 4 - Fixes broken support for floating VEBs
Patch 5 - Removes VEB recursion and simplifies VEB handling

Changelog:
v1->v2 - small correction in patch 4 description
       - changed helper names in patch 3
v2->v3 - correct patch files (v2 was broken)
v3->v4 - added kdoc stuff
       - fixed wrong check in i40e_ndo_bridge_getlink()
v4->v5 - fixed VSI/VEB interation macros

Ivan Vecera (5):
  i40e: Use existing helper to find flow director VSI
  i40e: Introduce and use macros for iterating VSIs and VEBs
  i40e: Add helpers to find VSI and VEB by SEID and use them
  i40e: Fix broken support for floating VEBs
  i40e: Remove VEB recursion

 drivers/net/ethernet/intel/i40e/i40e.h        |  93 ++-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  97 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 563 ++++++++----------
 4 files changed, 373 insertions(+), 390 deletions(-)

-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
