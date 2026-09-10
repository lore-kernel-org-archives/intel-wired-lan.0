Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF6CC79F9F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 15:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A9D54081C;
	Thu, 10 Sep 2026 15:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rMO9W7BCtg7G; Thu, 10 Sep 2026 15:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BFA514083B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789055378;
	b=pBBXq/M5tPl7EgK9+j4G5INS+KI8b9XkEo+byYPqthfEG6NHVyJmqNmXu9Cs/mF+oPbo
	 cc5vvqQ5SzAKHo/kFdsoheluGCTBQHf0l9AZZuSLk19ERxn9Q3WRIt/TfScw+hG7tXVFL
	 5+vaOFbdtt8vJHNSKKYjUwuarK3Dz68+/IMfMi2hhDWafVfVpd2RbE4ZQ7ElMR0Wc8Did
	 /9aP6fB8p8LD2wNssx5+Xb7/d5xxjBmWm2V4vj592AMtqR92irLVwSzoNob0BzXwH8ceX
	 GG7TqUON7aEtKhZK9RVMJSIy5MfJ/3MgibCBEp38mLgJSCLw6TJte/3QqunyP3nayIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789055378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-C2ProcessedOrg:Content-Transfer-Encoding:
	 X-TBoneOriginalFrom:X-TBoneOriginalTo:X-TBoneOriginalCC:
	 X-TBoneDomainSigned:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Yshyf3Fv0vvyf7p7UbWV0SuvDTq/4gC9jwwz1xnCFUI=;
	b=HwJapaejWnLrIAPsZ+UWQqHzrXniIrTIzNJ+XhuBBXTWZY2CSY8y6UY8QhxTzDnzG2NM
	 sUjgx+EwGzQAQcjcSUcGPDsCRpYDuCwlC1XyhvFjimqg7SrVHp21DZOXTtvOeki78HlmI
	 xqXAdYB+FkVikuLszq/1RVslA4F2xx4MV97w5V6gg8b5sPlqIDQFFsTX9S8RpVOXABLBB
	 wG0nqJbnV/3XzWf2CivX7MzZTZPHfqmeIXicb4uvnQnbXdw0DzNk5KbQILVqBGICKD7C3
	 BOPw26JbR3ocdrXwNxZP1LhhswM7g7iboRWUYzOmTktxNFZxZHzLX3uK0dvFEFx4vxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789055378;
	bh=Yshyf3Fv0vvyf7p7UbWV0SuvDTq/4gC9jwwz1xnCFUI=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y8+hahX3aWzokccQYS4iKLVLnMy3m0QBNNQ6sTF/haN7gaqRi68UFnfZOONlXk/Jo
	 ILBZAz/eobVZ8TJatlVzwzNDKYwV4PQMBpJ5E2lbMezQkn/BAh0MtWHZyn/nV9XPZY
	 ILOSEe0Xar2Wo7/UViTUcOirReVnFUZ4jHtQrszSCRXm8kMjqixjVgmUXuuKGkqgRp
	 QMiHdNJh294RFGW9hhgf775BfMahSTEMPOMEUFZkLgDjnUaSE2nlInapvYZ+46gSGg
	 CuHY4/fhY85tCeyJdfetCP4tYwhRLb5zDgSPgE0vQQ5LICqQVXUGuOUHBg8BSNCEvD
	 R+yphn258NDNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFA514083B;
	Thu, 10 Sep 2026 15:49:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 178E543F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8CFE4006B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:40:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHRFaXarB0no for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 11:40:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 877BF40024
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.228.58.149
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789040455;
 b=dSoiK7Ij6tGQ/zcoIm4YfGeZS8FlHKXfZu7T6pkp7JP8qTuROynQi6aYtgrdPd1pFuHk
 HIQgpo7IyOio4WUJ2QsDN0OSRw79zDSoK11Q1dgK6w2xik09SdcB07m4fisdZR+hSkgDq
 acLQTc4UUK0RQhNklGtG5HwqAlwQPv61SMSxNHgg7NKwrsD4/Lzd0k5ksba4KLls3ATW0
 eGQ5y39nysXSBIue9CkyW9mvw/1UzsFZScb+aCMlM/wXPICAwDOiLoHNpEcLQvFcKvzkU
 TN/CLqo6QHYip9njsr5QaagW9x5QyfI1FilMAAdYZHKdmisBpXT8Hn5oqvDmYTuvdEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789040455;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:Received:Received:Received:Received:From:
 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 X-Originating-IP:X-ClientProxiedBy:X-C2ProcessedOrg:
 Content-Transfer-Encoding:X-TBoneOriginalFrom:X-TBoneOriginalTo:
 X-TBoneOriginalCC:X-TBoneDomainSigned;
 bh=Yshyf3Fv0vvyf7p7UbWV0SuvDTq/4gC9jwwz1xnCFUI=;
 b=mz/VoSl8g1g2U7eqkH49hT3waE2YEOVmHZ3BZfj2E8gPHlhVPNQ2hmOwDUdpjenqNVHg
 Oi0eWe9XMd5VfgmGqCU91nlbNJKLgbVnPoxoGbGKf2keeIYo2AQDzaCGw/vlLOtnQAVU9
 7lksG8s8e2w8bPo/BPdKmF9c9imbs0nyr3SgDD8hdtwYA+zluwGR5hfcexyfP+bi7eM03
 LvJQeX1ZdlHtixI/Nns8YyWSuPRtqk7JhAoIzuUb23fOhAKn5RzGyVrv/BL8WcnEyHrUd
 RQD+Hihc7QZ1Hi6WG9Vxv4w1rNOeH5zvF5zbjxU21AS6alJCnkwf6ThK0/zBKnY+E3A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=dspace.de; 
 dkim=pass header.d=dspace.de header.i=@dspace.de header.a=rsa-sha256
 header.s=dkim1 header.b="Xdjt/aXQ"; 
 arc=none smtp.remote-ip=80.228.58.149
X-Greylist: delayed 65 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 11:40:54 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=dspace.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=dspace.de header.i=@dspace.de header.a=rsa-sha256
 header.s=dkim1 header.b=Xdjt/aXQ
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.228.58.149;
 helo=mail.dspace.de; envelope-from=prvs=706d339fd=pkneuper@dspace.de;
 receiver=<UNKNOWN> 
Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 877BF40024
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1; t=1789040455;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Yshyf3Fv0vvyf7p7UbWV0SuvDTq/4gC9jwwz1xnCFUI=;
 b=Xdjt/aXQi+8aLXdNyQIv1ydAdmOeMssDxG9JbQWp1oyhZZVUK5S73let
 SC3okwUD8gOHyRu/JVRuxHP4jOxtCf7PKlj2+DWw807+bqMkpKDQbRWR2
 DhkmvWym7eUPe8XysGP8vkjFTi9ZSkw4rcFgfPZha+qjMGltbOqu+tyUR 4=;
X-CSE-ConnectionGUID: j6+iw3OxSpqZQup+gmUsiw==
X-CSE-MsgGUID: x1cxu3oQSsi+B6UccK1KkA==
X-IronPort-AV: E=Sophos;i="6.27,95,1787004000"; 
   d="scan'208";a="5467919"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
 by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 10 Sep 2026 13:39:44 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
 by Z1-1000 (Postfix) with ESMTP id B55C160037;
 Thu, 10 Sep 2026 13:39:44 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by Z1-1000 (Postfix) with ESMTPS id A834A60036;
 Thu, 10 Sep 2026 13:39:44 +0200 (CEST)
Received: from PascalKW11-NB.dspace.de (10.71.5.241) by EX-DE-PAD-SE.dspace.de
 (10.100.196.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 10 Sep
 2026 13:39:44 +0200
From: Pascal Kneuper <PKneuper@dspace.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
CC: Daniel Baldin <dbaldin@dspace.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pascal Kneuper <PKneuper@dspace.de>
Subject: [PATCH net 0/2] igb: Fix i210/i211 Rx timestamping loss and packet
 corruption
Date: Thu, 10 Sep 2026 13:38:52 +0200 (CEST)
Message-ID: <20260910113854.13279-1-PKneuper@dspace.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.5.241]
X-ClientProxiedBy: EX-DE-PAD-SE.dspace.de (10.100.196.14) To
 EX-DE-PAD-SE.dspace.de (10.100.196.14)
X-C2ProcessedOrg: 563f5800-21cf-4d8d-8aed-fddd1469e4ee
Content-Transfer-Encoding: quoted-printable
X-TBoneOriginalFrom: Pascal Kneuper <PKneuper@dspace.de>
X-TBoneOriginalTo: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
X-TBoneOriginalCC: Daniel Baldin <dbaldin@dspace.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pascal Kneuper <PKneuper@dspace.de>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Thu, 10 Sep 2026 15:49:37 +0000
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

Hi!

This series fixes two issues with i210/i211 hardware Rx timestamping:

Patch 1 fixes a silent fallback to software timestamps. igb_setup_tx_mode=
()
unconditionally writes RXPBS, clearing CFG_TS_EN on every igb_up() (link
down/up, MTU change, or reset). Unlike other drivers (igc, i40e, ice),
hardware Rx timestamping fails to persist across link changes.

Patch 2 fixes frame corruption when enabling Rx timestamping at runtime.
RXPBS.CFG_TS_EN changes the packet buffer layout. Toggling it while Rx
queues are active creates a race where descriptor status and buffer layou=
t
disagree for in-flight packets, corrupting Ethernet headers and dropping
frames silently. Fix by quiescing the Rx path around the change.

Patch 1 must precede patch 2, as the quiesce cycle in patch 2 invokes
igb_up() and would otherwise trigger the register clobber.

Best,
Pascal

Pascal Kneuper (2):
  igb: Preserve RXPBS.CFG_TS_EN in igb_setup_tx_mode
  igb: Quiesce the receive path before enabling i210 Rx timestamping

 drivers/net/ethernet/intel/igb/igb_main.c |  7 ++++++-
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

--=20
2.47.3

