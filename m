Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2708C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Dec 2022 22:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B62E4000B;
	Thu, 15 Dec 2022 22:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B62E4000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671144674;
	bh=/WAv57dh4cHF1IXOC3NuuF+z3E8G66/hyoap4jH3xXQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=uWHFj/SwOyrlAfhnU8djInaw4vpif6/XVJ8qE7iyaqiaYTF1k7b52RfRpVTWb+DGP
	 f2nDIL2j3chW3YUuDrK83n6fVtjEdexrDxQMlPJ3HL9yodxX1vubiZWsqimwcEqZ5C
	 tgtfmf5CkRX33/36chBZXtjRTrPRrC6errHdBr5F1QjaKbezrighUp17IHKugfhgTx
	 s8IvHMKBb2i7CpKI/UHywl8uEYLg/QiHZwviM4HgHShRTZt5F/2Qb3Ente7SoRSBP+
	 Yg+cpwasFQu3Em3EBzQrovHul+RgiGo+8F2ej9Hq37CXnLdcCJDES2m4al2OO7GrlJ
	 clVFSQd+WGsig==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYD6xfrT06fM; Thu, 15 Dec 2022 22:51:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D8E340569;
	Thu, 15 Dec 2022 22:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D8E340569
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5E6441BF335
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 22:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4597F60B12
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 22:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4597F60B12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJdBgVSrEfQQ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Dec 2022 22:51:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 081F6607F5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 081F6607F5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 22:51:09 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-2LGHJ-BePpmIO208BiOIyA-1; Thu, 15 Dec 2022 17:51:05 -0500
X-MC-Unique: 2LGHJ-BePpmIO208BiOIyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFB593C0F696;
 Thu, 15 Dec 2022 22:51:04 +0000 (UTC)
Received: from toolbox.redhat.com (ovpn-192-38.brq.redhat.com [10.40.192.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A47652166B26;
 Thu, 15 Dec 2022 22:51:03 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 15 Dec 2022 23:50:47 +0100
Message-Id: <20221215225049.508812-1-mschmidt@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1671144668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YjHSeOcAQkQ7ENMLsxcSRW3ncebyKJH9WpbmehEsMYs=;
 b=jHrY8W6vlZM2Y2HEd+nbQRBGqcZosOc/WIhGLbioDHuT+5Kjwv5ecQRUdNsrgFhvdWTWYA
 hCDgWh37b90P2LdAWVuzQq+0P/kbhAr9aM6EAPLm+8bCJ/wUr8+eD4G9NVCmYexJO1UdMs
 REtHPowLMPbXCEoLICyEudUrLDsklDc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jHrY8W6v
Subject: [Intel-wired-lan] [PATCH net v2 0/2] iavf: fix temporary deadlock
 and failure to set MAC address
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
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
 Patryk Piotrowski <patryk.piotrowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This fixes an issue where setting the MAC address on iavf runs into a
timeout and fails with EAGAIN.

Changes in v2:
 - Removed unused 'ret' variable in patch 1.
 - Added patch 2 to fix another cause of the same timeout.

Michal Schmidt (2):
  iavf: fix temporary deadlock and failure to set MAC address
  iavf: avoid taking rtnl_lock in adminq_task

 drivers/net/ethernet/intel/iavf/iavf.h        |   4 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  10 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 135 ++++++++++--------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   8 +-
 4 files changed, 86 insertions(+), 71 deletions(-)

-- 
2.37.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
