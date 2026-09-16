Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BC7C982C3
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 14:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 285396068B;
	Wed, 16 Sep 2026 14:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHbKR65pB5Dy; Wed, 16 Sep 2026 14:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 57E62607F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789569717;
	b=cBl+pUCeWtTAHqVR6lF8EFNB6SDlf24jHmB3+Vuc2ce3CVRyNoZwgBJz/KogDu7Jqa4K
	 dh71GRcr3CeWW1BQmtRjCcHJSInApHC6C8r23KqmmzYdJmpfFlegT+nKnQdOv6irWS5i2
	 kQcShhxjukV3Li/Yk4OPDdbll4/dOGNH+qplW93xqb/VqTwGohGcMCMQUE0Ck5FZ8EcsN
	 yZ5uErljndEs0eRBAZU9xi1bVSRoKbuiQWOMjU6SAEUOiEa4Uq343QsCOWJ5MWemG5OuP
	 GkYuAjRk6KTrOYesd8TqEV/rgmdzCBb2pOo3z1ptJ6boR9TiKypSZrZssxcLYoKreIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789569717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sFlWEYEuFEzStzCucMbgaPBHMyfR9qMQvTp/sk32Kd8=;
	b=bFO5iiG0+8rcTxFEeD6MExgx5Ig5CzjBd84+zohpimfoA5YnbnYxfMWc/kYy7ev5/snJ
	 JfXk0Ge2cTWqQdDVoEjWanOm4amfVe+8xMwVDQFv1jDyDEguRiD+9/G3MpdMPV7+Gs8bu
	 WcOh/IEuU40PRGdYEQg2yueIQagItEH8noHu3GlNUS4orizla5IQ29rtkvsppR6GeqhEP
	 CvLY1WV63KbHH4BB3Oc//6rWreC+NM6t8rJOy6SMX2eZNv+AsFnsbEijHnFf8PxS8/Yhb
	 ZcuXEIKsCPW1+uMTWOLQqRuXQYpqrkpMNMWP7OFttwgp0z73yYC386wGUaXsyxHzo9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789569717;
	bh=sFlWEYEuFEzStzCucMbgaPBHMyfR9qMQvTp/sk32Kd8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QO4LbGLH4l6ze4FPmnFIkpT+hLUcK/uAUE3LmZ2D89FMkeIfn/90Ul2I63m5RQz4V
	 wnpBOOqyv7Zt/3IVJ3JUh6dTSlKNFu7op9g5TStN/c4J4ohgtqNDOiziHD8Q7T99H8
	 A+ilkoQ6Y+HofMmm1ErUVNEwe5mkWWsxonGfaH3tfgIEtJzqRRfIrzMLtTGl+xwisf
	 Lsgl5woBW/XdAU4QAwkxqRqb4zxLP9ccLfilMssxc5FVFovTvg/XKJjH2o8b45P01N
	 geLGtaI00k1sF1emuYjzfGla2AbwJpdLhWbsG5u28xvKSS2XkQq509kRglNzhj1NuO
	 +mLzIRkpjWunA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57E62607F8;
	Wed, 16 Sep 2026 14:41:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 30616493
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 222F680EA0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2U6bQaLun3DU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 14:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2ECB180E9D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789569715;
 b=nN3ZmDy2hVGRRihrUTDETcoUdYJ4UfoZIwKnzHSObCrauTEFIfjpAFwTKa8zXcuo4k4r
 VP0tOoXx8pXV9KLto90T3FFViBsDqOL8CcbReu63HSgf10+iweRUvPqILyCJZBbtWZxRj
 rxs6ngB68d/RtrrsmQs+S3PENsP5vfnNqD9IRwraaS2zfs3HL0AZHCoVy9znVFpnoT4Wq
 gIhsrX8+5xztBS0coJIyRhhK2THzV8ZN1FVkYPBx5mocIkHJMdYuTjIT72Xls5JHDl8ay
 e4IlwkYO8l/dfoBCeKHBkLHB7NL+FMALjLC+jS2b9pVqnIFcDt8vKtvD95BcXMeLGkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789569715;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
 bh=sFlWEYEuFEzStzCucMbgaPBHMyfR9qMQvTp/sk32Kd8=;
 b=QNJrYF2SIKJtJ/TSul0iH7mMhX8TelN0Y6y+8Y8wkrCEgnpxtvFs8ge6hvxl+fe7SJGx
 43ZevJ0o8H5aVPkVY1FI31rwTMqnmW2Kj+vbngBRhUyOmmqbTjEppsbILo/NX7qcgU/wy
 niq1cA7S9ApWNlIWKlzKws+mU2wBuWDn0R3+jeuKpkOneB8YnVIge6t0Xhb69mJgAdTs7
 /2DOZJB47Fdo0WnQklx/J9UMVMvtD0ycRCVxDDY3ZH87Ep5OtcNGuHoBABrV8FgAAokVT
 E3+L9wik+nIy/H44eO8M4lUMxrs0dc+24JXL/v4m3ViOUU+9a56nOhoayPUIsFnJQaA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="APR/HxK5"; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="APR/HxK5"; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=APR/HxK5; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=APR/HxK5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2ECB180E9D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789569713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sFlWEYEuFEzStzCucMbgaPBHMyfR9qMQvTp/sk32Kd8=;
 b=APR/HxK5cZMXxMDQUEeOV2SquSZRCs4zl5z2x8dDxXF9MMqofT5a1cMVJZwnrQzimcLJje
 Xe9VlcbUhpTCMeOxqc8+N8BnW+/roOTBllzo9EmHOerkvXkSGFg7NIZTmFGCplpk6DPADL
 AxLp4NoH1kke+s2t4AYZwjT1Hu0SX5w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789569713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sFlWEYEuFEzStzCucMbgaPBHMyfR9qMQvTp/sk32Kd8=;
 b=APR/HxK5cZMXxMDQUEeOV2SquSZRCs4zl5z2x8dDxXF9MMqofT5a1cMVJZwnrQzimcLJje
 Xe9VlcbUhpTCMeOxqc8+N8BnW+/roOTBllzo9EmHOerkvXkSGFg7NIZTmFGCplpk6DPADL
 AxLp4NoH1kke+s2t4AYZwjT1Hu0SX5w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-ntJ2QdPXNYyZFbfPHfBWfw-1; Wed,
 16 Sep 2026 10:41:47 -0400
X-MC-Unique: ntJ2QdPXNYyZFbfPHfBWfw-1
X-Mimecast-MFC-AGG-ID: ntJ2QdPXNYyZFbfPHfBWfw_1789569705
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA89E18A6962; Wed, 16 Sep 2026 14:41:44 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 425E819560AB; Wed, 16 Sep 2026 14:41:38 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
 Kiran Patil <kiran.patil@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 0/2] ice: fix TC flower filter priority violations
Date: Wed, 16 Sep 2026 16:41:28 +0200
Message-ID: <20260916144130.2699902-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: jCzKel_gLf_SdNWhRIT4Qa8RWKLFgFOjuxfLl5obgRo_1789569705
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Two fixes for TC flower offload in the legacy switch mode. Both
address the same user visible failure, all traffic on a port silently
disappears after installing a filter chain that mixes offloadable and
non offloadable filters.

The first fix covers filters matching on ip_proto alone. The driver
never programmed the protocol lookup, so a filter like "ip_proto udp
action drop" was installed in hardware as a match on eth_type ipv4 and
dropped every IPv4 packet.

The second fix covers the interaction between software only filters and
offloaded drop filters. The E810 switch gives drop rules absolute
precedence over forwarding rules regardless of recipe priority, so a
lower priority drop offloaded into hardware overrides any higher
priority filter that stayed in software. The driver now tracks filters
it could not offload and refuses to offload a drop filter that would
bypass one of them, keeping the drop functional in software instead.

Tested on E810 with the OS default and comms DDP packages, including
the original reproducer from the report, L2TPv3 pass and drop chains
with and without session ID matching, and a shared block bound to two
PF ports.

---
v2:
- track one entry per cookie and filter_dev pair so a shared block
  bound to multiple devices is protected on every binding, and the
  delete path drops one entry per DESTROY invocation (sashiko review
  via Simon Horman)
- collect Reviewed-by from Aleksandr Loktionov on patch 1

v1: https://lore.kernel.org/all/20260910154824.3603687-1-poros@redhat.com/

Petr Oros (2):
  ice: fix TC flower filters matching more than the ip_proto key
  ice: don't offload drop filters that bypass higher priority filters

 drivers/net/ethernet/intel/ice/ice.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 196 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  24 ++-
 5 files changed, 212 insertions(+), 13 deletions(-)

-- 
2.55.0

