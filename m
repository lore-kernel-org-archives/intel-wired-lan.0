Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A968C47DD9
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Mar 2024 07:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C57CD80B0C;
	Wed, 27 Mar 2024 07:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7iuiC7GJVjNv; Wed, 27 Mar 2024 07:57:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 297EA81EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711526268;
	bh=jz1vvdFD+Eq8cb9G2Bv1kGIJT1qi79TE/Yvgly9pFp4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=we8btY7KEIl8xXH6o9iOj/58rb9AjOlSVeSlcn8CTguj1GSpCW3USwT275evCeJ6C
	 O+CoVaBDSJYVwDbUWjYg5QTpt6COArnzxxqB8ExtQ8xdvFhUtpR1YKSI01jIIwz5O4
	 VlK8Q6W9z4borjJxhTU7NxJQPJU0Ao77nm6dyoHkHw0UYq/2owEtxsLu6wEMHmSM2I
	 8lACOFFICY0JfYWckMfpmRynGUhUfPbRYK9duQTexoNLCCZwnmRD+05Xshzgr6DpeX
	 j0J7YIk8Mt114CH7vkF7T/OPI5A3U4n8fxChUyo30Eetii0BZd/aNM+uEwZ52ni6/z
	 GpgzS8L8ALJog==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 297EA81EFE;
	Wed, 27 Mar 2024 07:57:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D9CFF1BF42D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Mar 2024 07:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C42CF408E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Mar 2024 07:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPtSyJ3t4ahq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Mar 2024 07:57:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D2D9E408DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2D9E408DF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2D9E408DF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Mar 2024 07:57:45 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-sAbaLoo_N5ubFQQrgTYL3w-1; Wed, 27 Mar 2024 03:57:40 -0400
X-MC-Unique: sAbaLoo_N5ubFQQrgTYL3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C692101A523;
 Wed, 27 Mar 2024 07:57:39 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0233C1596E;
 Wed, 27 Mar 2024 07:57:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 27 Mar 2024 08:57:26 +0100
Message-ID: <20240327075733.8967-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1711526264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jz1vvdFD+Eq8cb9G2Bv1kGIJT1qi79TE/Yvgly9pFp4=;
 b=DbCwOsgCzD0uY+ihgaLLhzy25+vdKQB1yxtOZy2U5nbWOFiTZo/ZgNq5SwwdN6MP4KMd2m
 Qqd6zbeRxLs795V7syD9TpLRSP+LLAgr2PBGwaX8A2bllADNVpR2os32paO2xR+Sv43zuz
 4dWpRb8AQkJcDUhCMoUIelRM5l3Trek=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DbCwOsgC
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/7] i40e: cleanups & refactors
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 aleksandr.loktionov@intel.com, edumazet@google.com, anthony.l.nguyen@intel.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This series do following:
Patch 1 - Removes write-only flags field from i40e_veb structure and
          from i40e_veb_setup() parameters
Patch 2 - Refactors parameter of i40e_notify_client_of_l2_param_changes()
          and i40e_notify_client_of_netdev_close()
Patch 3 - Refactors parameter of i40e_detect_recover_hung()
Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
          in existing code
Patch 5 - Consolidates checks whether given VSI is the main one
Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
          in existing code
Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
          particular and uses it to replace existing open-coded pieces

Changes since v1:
- adjusted titles for patches 2 & 3

Ivan Vecera (8):
  i40e: Remove flags field from i40e_veb
  i40e: Refactor argument of several client notification functions
  i40e: Refactor argument of i40e_detect_recover_hung()
  i40e: Add helper to access main VSI
  i40e: Consolidate checks whether given VSI is main
  i40e: Add helper to access main VEB
  i40e: Add and use helper to reconfigure TC for given VSI

 drivers/net/ethernet/intel/i40e/i40e.h        |  30 ++-
 drivers/net/ethernet/intel/i40e/i40e_client.c |  28 +--
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  36 +--
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  29 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 205 ++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
 .../net/ethernet/intel/i40e/i40e_register.h   |   3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  98 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   3 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 +-
 11 files changed, 282 insertions(+), 173 deletions(-)

-- 
2.43.0

