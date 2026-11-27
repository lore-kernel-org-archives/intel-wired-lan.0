Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4129606A68C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qvCIB9/L;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yux9g2N7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B92C60AC4;
	Fri, 27 Nov 2026 08:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFD90gHPXFzA; Fri, 27 Nov 2026 08:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73CB160AAC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795769866;
	b=rjyZDwoUUHttshX/ybEVbakp0C5VTI3QzoqaeALIILrwxNiSk9Q0ziD/zQasAY7vuKbp
	 ZFL2knsUYILa8Kt5tC/6AgJbm1LxydAOcpUCQ379G/pzKCW+sBSYE6JdhdG7VcYofNRY1
	 miE4tH6x8CNQJ/StaJokhhutwPa0fPzJQaq63YyQEyGDMM3Y3zf4KUlf4zZOj9qFItIPs
	 M4rpLKMfqleHIo/0geKhzjq+1XKa5BErOkB+PareSCTrOvhRVkzqGaoRYlc2LWsvSLavI
	 sH8moa7LushuXGvKtQacmE55jJ/qhs+1l/2f2L39cNVtXyO6t5YgNem9TBJNpB0aQwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795769866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/G+Xs6o+vba8qSnCFylsLowici9WWMguXuW+fm0sBPo=;
	b=Is48WQjdq4EGjtlsb4iMFY9CUMX6nflXexgofjAvj7dfL7da/DRRwJ0eUAOQprg/FzE2
	 XqUofALrguN93q5Tq93ULutD7OhItC16P/j+vwB9AkEn2X/QZGdv5DG80OcthuZDvRl3D
	 aukakl4qdcRjI4F9Dd3l/YNDQFtD3hqaM5T21g8+rf9pxP0FZFXtudHSgBvN7HWu5FIrp
	 vh3wHt9FhkhvbDLW0AgTQZRXaRpeG39pfH1BGyGfGyItffS8dOvg7qlX0gjMw/bK6c0oL
	 Bk4MxRibXN9M0JeOr3qokymjAFBXbHqzQ5t58UsgcuMyf41rgPTqArcflmMm5xPBi9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795769866;
	bh=/G+Xs6o+vba8qSnCFylsLowici9WWMguXuW+fm0sBPo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qvCIB9/LtkNShVF2yN01SJlRHAoSq8BKdOILjnc1FV0B8isKUC6YclGQSvPD4S53r
	 Y7Ayhp80cpD2Pc1be4L8hkuIQelgiUxCKd+HsEQUSU/XwKFXeIcrxexYM3g4nwEpRN
	 JUAbNDOc0Hstdupd7GQCIuNF4kSCBcQTmK+MzRqnXDZkfdGWgnQVr1Xe+rY9c5NXYo
	 yjlmptHDgaeX3Nuzzmqlxfc3ZCB8Lhmq6yIOM6fF2lw2K1aGlm3qPsz8q/2cZp8Bpx
	 9SxBUg79ZMgmBBfrl5SZ5WrIDWjwAEfDbRGsOYZwmuuZRe89jo9ATZql7kw/KTMbzN
	 tvh2SfHf7ssPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73CB160AAC;
	Fri, 27 Nov 2026 08:57:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CB6C311
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CE7840A3B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e-sfn9EDfjCS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 08:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4D2040A36
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yux9g2N7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4D2040A36
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795769861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/G+Xs6o+vba8qSnCFylsLowici9WWMguXuW+fm0sBPo=;
 b=Yux9g2N7q2Or75gXUSAM1KedYalvAR5a3LKU3jbcIMg2x/MaB6EYcO+QHQWUhmpuyFJUBP
 oH2Vifhk9NG72mOYj7kPon+fHsQiFjHl60wtNDTaNF8k7//gfl4xL9U8UDQLRUNCrz9H19
 ONbJfrqOJH3/2rGm30H0UubFFzTIAQc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-mkvI4AjPMM6S_gk3UoUF1w-1; Fri,
 27 Nov 2026 08:57:37 +0000
X-MC-Unique: mkvI4AjPMM6S_gk3UoUF1w-1
X-Mimecast-MFC-AGG-ID: mkvI4AjPMM6S_gk3UoUF1w_1795769854
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 915EF180060C; Fri, 27 Nov 2026 08:57:25 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5FCD589; Fri, 27 Nov 2026 08:57:17 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Ivan Vecera <ivecera@redhat.com>, Alice Michael <alice.michael@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Patryk Holda <patryk.holda@intel.com>, Rinitha S <sx.rinitha@intel.com>,
 Aaron Ma <aaron.ma@canonical.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v5 0/4] ice: fix DFLT Rx rule handling for promisc and
 switchdev
Date: Fri, 27 Nov 2026 09:57:05 +0100
Message-ID: <20261127085714.1207361-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: TNmam_Zz5ECgHUvOr3nTuxemUdvAP2dqpqam4s9AT8I_1795769854
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes for the promiscuous and allmulticast handling of the ice PF VSI,
and two fixes for the teardown paths they rely on.

Patch 1 stops the service task in ice_remove() before the PF is torn
down, where it was stopped before commit 8a37f9e2ff40 ("ice: move
ice_deinit_dev() to the end of deinit paths"). Patch 3 queues a filter
sync when a switchdev session ends, and a session that still runs when
the driver is removed ends in ice_remove().

Patch 2 refuses to leave switchdev mode while subfunction ports exist.
Leaving it then orphans the session, and patch 3 resyncs the uplink only
when a session ends.

Patch 3 lets the eswitch own the promiscuous configuration of the uplink
while a switchdev session runs and resyncs the uplink filters from the
netdev flags when the session ends, so the uplink no longer ends a
session without its catch-all Rx rule or with a stale promisc state.

Patch 4 subscribes PF VSIs to multicast with one VLAN agnostic promisc
rule pair instead of a pair per VID, so a wide VLAN trunk on several
bridge ports no longer exhausts the switch lookup table. A port with a
vid 2-4094 trunk goes from 12292 to 4104 FLU entries.

v1 to v4 were posted to iwl-net, and v4 went into the iwl pull request
of 2026-11-13, where the Sashiko review found real problems in both
patches [1][2]. This version reworks both and replaces v4. It is posted
directly to net, with intel-wired-lan in Cc, as discussed in the thread
on that pull request [3].

The final v5 also differs from what I described in my replies to that
review. Patch 4 no longer keeps per-VID rules for any PF VSI, so the
per-VID re-add, the rollback and the vid 0 recipe swap handling I
described there are gone, and ice_clear_promisc() clears only the VLAN
agnostic pair. Instead of skipping the allmulti branch for a promiscuous
VSI, the subscription is reconciled from both flags in one place, and
with patch 4 the resync of patch 3 no longer drops the multicast rules
or clears IFF_ALLMULTI. In patch 3 a new VSI state bit keeps every
filter sync away from the uplink promisc configuration while a session
runs, and patch 1 makes sure that the sync queued at the end of a
session cannot use a freed netdev when the PF goes away.

"ice: restore DDP state during PFR recovery", which Tony sent to net in
the pull request of 2026-11-25 [4], also stops the service task in
ice_remove(), but before ice_free_vfs(). Patch 1 keeps the place after
ice_free_vfs() that commit f844d5212cb0 ("ice: Fix removing driver while
bare-metal VFs pass traffic") chose, so that VF drivers in the host
still get answers from the PF while they are removed. The two apply
together without a conflict, and ice_remove() then stops the service
task both before and after ice_free_vfs(), so one of the two calls
should go.

Patch 4 builds on the ice_vsi_sync_fltr() changes of patch 3, which
needs the switchdev code from v6.10, so 6.6 and 6.1 need manual
backports of patches 3 and 4. The loss of the uplink VLAN filters across
a switchdev session that patch 3 mentions is older than this series, and
with patch 3 it also shows after a promiscuous session. I will send a
fix for it separately.

Changes since v4:
- Posted to net directly instead of iwl-net.
- New patches 1 and 2, found while reworking the switchdev fix.
- Patch order swapped, the switchdev fix goes before the multicast one.
- Patch 3, previously "ice: preserve uplink DFLT Rx rule on switchdev
  release", reworked as described above.
- Patch 4, previously "ice: skip per-VLAN promisc rules when default VSI
  Rx rule is set", reworked as described above. It now also keeps the
  multicast subscription of a promiscuous VSI when allmulti is cleared,
  unless another VSI holds the DFLT rule.
- Dropped the Reviewed-by and Tested-by tags of v4, both patches changed
  too much to keep them.
- All commit messages say how the problems were found and how the fixes
  were tested.

Link to v4:
https://lore.kernel.org/all/20260708125755.706263-1-poros@redhat.com/

Link to v3:
https://lore.kernel.org/all/20260701133601.2118382-1-poros@redhat.com/

Link to v2:
https://lore.kernel.org/all/20260622113428.2565255-1-poros@redhat.com/

Link to v1:
https://lore.kernel.org/all/cover.1781786935.git.poros@redhat.com/

[1] https://lore.kernel.org/all/179495967132.3136.6714105968141020753@kernel.org/
[2] https://lore.kernel.org/all/179495967304.3136.16113490698897758196@kernel.org/
[3] https://lore.kernel.org/all/20261125124652.3843638-1-poros@redhat.com/
[4] https://lore.kernel.org/all/20261125224428.4126195-1-anthony.l.nguyen@intel.com/

Petr Oros (4):
  ice: stop the service task before the PF is unloaded
  ice: do not leave switchdev mode while representors exist
  ice: resync uplink filters after a switchdev session
  ice: use a VLAN agnostic multicast promisc rule pair for PF VSIs

 drivers/net/ethernet/intel/ice/ice.h         |   1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  39 ++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 233 +++++++------------
 3 files changed, 124 insertions(+), 149 deletions(-)


base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.56.1

