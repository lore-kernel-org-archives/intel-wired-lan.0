Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142F606C652
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=abgMxHF7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoIWwHkX;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoIWwHkX;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoIWwHkX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 848AB80DD7;
	Tue, 10 Nov 2026 09:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZExxAWcpqz5; Tue, 10 Nov 2026 09:44:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B79D80E3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794303850;
	b=SxnXJRE/gUVFdds6d57MbAlxkCPa3EUVZJ3S3fQTq7LEwwZF4SmQ83Do3tF+zKi1f/ui
	 fNXdC4P6CIgZObDliTXpWU4P9N3gFRUdaNpbqGtw/l2MLTDPWA1Yrxov1mgs6TUradzwN
	 tnWoNSWbR9wu52Vwcz/AGZWaPMel4HwNLird6FyreFZJU15ZVA5SyMrf3RtSavAj+4O/+
	 1CbIRS3e3o/PlH3YJbClt7ivez3y3PRdkKMfYX1Fz0GUrma3QQp/Ye5r1fo0ileJ6ACO4
	 UdNi3XhrMGvCYarmnYEczVOPnANExoCFd8e9hLW9ybFaTHLb2OByIsON9i6X4DSjr6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794303850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hdK+pDEbjtxXIas5PTih8G25EZ5jkuMrar1Qn0ux3aM=;
	b=rlsortEMNRcRUhBWzQIlnHNZdOAqXBaBrLuaLaVtdH/H4gU6z3jLfbgEyCb8kBn3zvIt
	 zaq+OX2b9kNC6XYKZFP2RqGxkkrjGp+uCXsFocg+RMTeXWx7AqZ8oNrMc7Q+lFSdywR2u
	 v2lmDFJ0TqMhCxHM/X/Za/0/orT++omPKL47rW6ZmnDLVGdP7dZKKZaFjpfKHDzz7b35u
	 GH+JoeXXm0sNR0kvVl7GNbpjVDZA2cLAUuSTe0mMi4HiCWbBS+Cpnp2W6RvEb57Tb5OIb
	 fxUt865gEuq9rj+u4QkpdTMWDZ42ysgr7/w6H09wW4zXI/Nr4op/6NQKoLnIOj0+Q/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794303850;
	bh=hdK+pDEbjtxXIas5PTih8G25EZ5jkuMrar1Qn0ux3aM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=abgMxHF7S8LCyVP2oeitybTGeQo1SuYoGsEa4+E2M5JJVWNyi6j9Oufv4h1qHjpap
	 ytYkAL2Ugg+HhrsINL1aOIz/et3qIjzQI8bCurwATAvYUw/mdnK5RAJDWbj93EYELw
	 iIChIPLkf5mcpvKmlVGqdnhCD0d8GmrY0jX/307jlSCIUcNGYZuDTpSJAW5xixgKDR
	 HZNBqoLDymcQAsZGF6AZcIXcEcaVRB0iYSwJv5EOQY7TRipprgIiXci6L4hwxKI0TX
	 lgQ+siKDw75abbb/tRaJWYPHUVjkRJsP/D9g5YWQW5PiAipBIiX/kyUX28kmxNpH1W
	 ZapQ5VrL9719w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B79D80E3E;
	Tue, 10 Nov 2026 09:44:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29F2B1FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BADB60768
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SQL4pUVOLcMk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 09:44:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A55860760
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoIWwHkX; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoIWwHkX; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MoIWwHkX
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A55860760
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794303844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hdK+pDEbjtxXIas5PTih8G25EZ5jkuMrar1Qn0ux3aM=;
 b=MoIWwHkXKjYtue5xlkexwXYRjthuNvym9MCG2QAI9eMqnQtaXpzWLd0Z18uub7wgwjX2G0
 vcv22bAePvcXv86cuZGAXIi7He2RkiMJsUGestytsJmArCMAhG89nfdJQxkJNwcvyiy9qQ
 lUBH6AA942wst7ctX02FoBHCkzKiSq8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794303844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hdK+pDEbjtxXIas5PTih8G25EZ5jkuMrar1Qn0ux3aM=;
 b=MoIWwHkXKjYtue5xlkexwXYRjthuNvym9MCG2QAI9eMqnQtaXpzWLd0Z18uub7wgwjX2G0
 vcv22bAePvcXv86cuZGAXIi7He2RkiMJsUGestytsJmArCMAhG89nfdJQxkJNwcvyiy9qQ
 lUBH6AA942wst7ctX02FoBHCkzKiSq8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794303844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hdK+pDEbjtxXIas5PTih8G25EZ5jkuMrar1Qn0ux3aM=;
 b=MoIWwHkXKjYtue5xlkexwXYRjthuNvym9MCG2QAI9eMqnQtaXpzWLd0Z18uub7wgwjX2G0
 vcv22bAePvcXv86cuZGAXIi7He2RkiMJsUGestytsJmArCMAhG89nfdJQxkJNwcvyiy9qQ
 lUBH6AA942wst7ctX02FoBHCkzKiSq8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-q5guI-8xOCuxhWOGmMLpKA-1; Tue,
 10 Nov 2026 04:43:58 -0500
X-MC-Unique: q5guI-8xOCuxhWOGmMLpKA-1
X-Mimecast-MFC-AGG-ID: q5guI-8xOCuxhWOGmMLpKA_1794303836
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 662071956047; Tue, 10 Nov 2026 09:43:56 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9277D39203; Tue, 10 Nov 2026 09:43:51 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Petr Oros <poros@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michal Schmidt <mschmidt@redhat.com>,
 Jakub Ramaseuski <jramaseu@redhat.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] ice: dpll: fix updates of the SyncE CGU registers on
 E825
Date: Tue, 10 Nov 2026 10:43:48 +0100
Message-ID: <20261110094350.184185-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 4VYpmOGtEKF6OfnLQDSh0OMNHoAclKql9NYDmLhzUtk_1794303836
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

All E825C PFs share the CGU registers R10 and R11, which hold the mux and
the divider of the two recovered clock outputs. Both patches fix how a link
change updates them, both found in review:

- Patch 1 adds a lock shared by all PFs around the read-modify-write
  sequences of these registers. A link change on one PF could undo an RCLK
  pin change made by another PF.
- Patch 2 lets a link change set the divider of an output only when its
  port drives that output. Every port set it from its own link speed,
  which is wrong when ports run at different speeds.

Both were tested on GNR-D with dual complex E825, details are in the commit
messages.

Patch 1 was also patch 2 of the net-next series "dpll: do not serialize
driver callbacks under global dpll_lock" [1], which needs it. v2 of that
series will drop it.

[1] https://lore.kernel.org/netdev/20261106121005.1327603-1-ivecera@redhat.com/

Ivan Vecera (2):
  ice: dpll: serialize changes of the SyncE CGU registers
  ice: dpll: set the SyncE divider only for the port driving the output

 drivers/net/ethernet/intel/ice/ice_adapter.c |  2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.c    | 11 ++++++-----
 drivers/net/ethernet/intel/ice/ice_dpll.h    |  4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c     |  8 +++++++-
 drivers/net/ethernet/intel/ice/ice_tspll.c   |  8 ++++----
 6 files changed, 27 insertions(+), 10 deletions(-)


base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
-- 
2.56.0

