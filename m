Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344CFE9B36A
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 11:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDFB1610D4;
	Mon,  2 Mar 2026 11:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cnc3H6z1KPkG; Mon,  2 Mar 2026 11:40:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D9E960FE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772451642;
	bh=iwCjK/8BbuVWkdj/Kq+vjZgwo9eNY1olqWaI6BrfiNo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Oe9tX6Gxdyppb8WBZPXc8gftdD2QGogsd/QnNf3EgoOJN1asT5O9NXdHtPR11/ROQ
	 cCQbMk4TV9JMNQpiJRa3q9zqX2hrUUpA0RvNOdwKSPggvJwja74gQalmFm9HWm88Bo
	 2LhaUXHiNNAOEt2VosLwmwP0jSnG3MhtDdhHxxci0BROcyEXCb0+pBHu57TdOnWZK2
	 v5xVUPuA2kuJpVMFesAH3CGYma0OJ995gaGhRDJf4FVztf0ph68plaHrvkmNW4Fv9U
	 Vdjowp/pQGmaVpQkvEukrxu6GKkvWbOgbqJVTspDAIRSVFbPox9QFM02Isd37I+uFZ
	 C/hBCiyUH1Tlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D9E960FE5;
	Mon,  2 Mar 2026 11:40:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A298231
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 11:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EE9783DC0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 11:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yN888DZyY67a for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 11:40:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4689383DBF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4689383DBF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4689383DBF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 11:40:39 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-NZk-JfuzPTikoSvBfLw7EA-1; Mon,
 02 Mar 2026 06:40:33 -0500
X-MC-Unique: NZk-JfuzPTikoSvBfLw7EA-1
X-Mimecast-MFC-AGG-ID: NZk-JfuzPTikoSvBfLw7EA_1772451631
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 618DF180034D; Mon,  2 Mar 2026 11:40:31 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE62E1956053; Mon,  2 Mar 2026 11:40:27 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Mon,  2 Mar 2026 12:40:21 +0100
Message-ID: <20260302114025.1017985-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: roLDcQ_sIBFUry1je2gzKENNhV5L15TAObL9vjoBBOI_1772451631
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1772451638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iwCjK/8BbuVWkdj/Kq+vjZgwo9eNY1olqWaI6BrfiNo=;
 b=Lk+lCUBx/+bwSafvDsQ1UM/pgtopbmpTxMTLyNoiJHqg2LvOpjsiF9NfAb90bFBs8/JkKW
 qHs7uiQNPqrvLqOl7rvZ+wQr/1HKNxggdbhDoOeemMDA+dSavGukuoXA/y7yD1SaYQDkXj
 gs9oupB37EJJV8irmckikR9+M+J7qpc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lk+lCUBx
Subject: [Intel-wired-lan] [PATCH RFC iwl-next 0/4] iavf: fix VLAN filter
 state machine races
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The iavf VLAN filter state machine has several design issues that lead
to race conditions between userspace add/del calls and the watchdog
task's virtchnl processing.  Filters can get lost or leak HW resources,
especially during interface down/up cycles and namespace moves.

The root problems:

1) On interface down, all VLAN filters are sent as DEL to PF and
   re-added on interface up.  This is unnecessary and creates multiple
   race windows (details below).

2) The DELETE path immediately frees the filter struct after sending
   the DEL message, without waiting for PF confirmation.  If the PF
   rejects the DEL, the filter remains in HW but the driver lost its
   tracking structure.  Race conditions between a pending DEL and
   add/reset operations cannot be resolved because the struct is gone.

3) VIRTCHNL_OP_ADD_VLAN (V1) had no success completion handler, so
   filters stayed in IS_NEW state permanently.


Why removing VLAN filters on down/up is unnecessary:

Unlike MAC filters, which need to be re-evaluated on up because the
PF can administratively change the MAC address during down, VLAN
filters are purely user-controlled.  The PF cannot change them while
the VF is down.  When the VF goes down, VIRTCHNL_OP_DISABLE_QUEUES
stops all traffic -- VLAN filters sitting in PF HW are harmless
because no packets flow through the disabled queues.

Compare with other filter types in iavf_down():
- MAC filters: only the current MAC is removed (it gets re-read from
  PF on up in case it was administratively changed)
- Cloud filters: left as-is across down/up
- FDIR filters: left as-is across down/up

VLAN filters were the only type going through a full DEL+ADD cycle,
and this caused real problems:

- With spoofcheck enabled, the PF activates TX VLAN anti-spoof on
  the first non-zero VLAN ADD.  During the re-add phase after up,
  the filter list is transiently incomplete -- traffic for VLANs not
  yet re-added gets dropped by anti-spoof.

- Rapid down/up can overlap with pending DEL messages.  The old code
  used DISABLE/INACTIVE states to track this, but the DISABLE state
  could overwrite a concurrent REMOVE from userspace, causing the
  filter to be restored instead of deleted.

- Namespace moves trigger implicit ndo_vlan_rx_kill_vid() calls
  concurrent with the down/up sequence.  The DEL from the namespace
  teardown races with the DISABLE from iavf_down(), and the filter
  can end up leaked in num_vlan_filters with no associated netdev.

After reset, VF-configured VLAN filters are properly re-added via
the VIRTCHNL_OP_GET_VF_RESOURCES / GET_OFFLOAD_VLAN_V2_CAPS response
handlers, which unconditionally set all filters to ADD state.  This
path is unaffected by these changes.


This series addresses all three issues:

Patch 1 renames IS_NEW to ADDING for clarity.

Patch 2 removes the DISABLE/INACTIVE state machinery so VLAN filters
stay ACTIVE across down/up cycles.  This is the core behavioral
change -- VLAN filters are no longer sent as DEL to PF on interface
down, and iavf_restore_filters() is removed since there is nothing
to restore.

Patch 3 adds a REMOVING state to make the DELETE path symmetric with
ADD -- filters are only freed after PF confirms the deletion.  If the
PF rejects the DEL, the filter reverts to ACTIVE instead of being
lost.

Patch 4 hardens the remaining race windows: adds V1 ADD success
handler and prevents redundant DEL on filters already in REMOVING
state.

Petr Oros (4):
  iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
  iavf: stop removing VLAN filters from PF on interface down
  iavf: wait for PF confirmation before removing VLAN filters
  iavf: harden VLAN filter state machine race handling

 drivers/net/ethernet/intel/iavf/iavf.h        |  9 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 53 ++++---------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 76 +++++++++----------
 3 files changed, 54 insertions(+), 84 deletions(-)

-- 
2.52.0

