Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C57606A32D
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sY4eOqjk;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mOn5WUp9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34F0A40719;
	Mon,  2 Nov 2026 10:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xbjvQo30KOkY; Mon,  2 Nov 2026 10:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C40D40730
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616395;
	b=I2Lj8OBRTBlvCceorLRyZRNwY9jwVjJuGHPiSJE4k5KDcVTL++Rtc2fE8xnied8vTDWW
	 QY44DJqzNRq7Atltxmbujx9ga98rvCN6sCAk1qSm2oibLr2zJF1mevzSkR+NjI3OqhUN5
	 9qRV//LxjjfT6zG0nvqObkVUuTc3xPmEpGPVwJ9G/s7j3OxQREh0vDxj5vsi2z8GNwU/N
	 nWgn9gHr0WiAZ+WsaGMS+vJkmrY9BEkqxGa9d+c04BXpJf9OAXDkct6stBCpTHgFKKs3/
	 i2OMOreOQU5gV6klapnpB/RPGj/WxqTwYT2ksmzHhEIZI4o3yihJ5uzLpFgHKKvCc7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zHSmpNjZA4OHD0kaKYRjCibed8j1ZDUSgLmnw5VW5yE=;
	b=UJxzGkbxjDX1eFyuL7ZvM5HmepycDZ4PesI2JrOL6Tmr5E8m1bUjpMCsC8EUkgPpCD3D
	 nhI04Aw9YDU0hP/BJUjMjtBZB/2m8rjcWmuH9cdab73dFc0omaQjzGJkz3OwIyGYoK6En
	 jl4t2ieGD2Eg8OwV6SxIHDrv0xVRHQYrPoYB6iThiOZfFyDOIW0ghBtol8cQ1OSQzk+CI
	 kReqaGaXhIJ0dbTr1gcpuL7FGJsGxRZgsvm+msKKP0QuRLpQjvBVS8/2VqVZP5bZPus+h
	 MXjs8xc3J8hmS8zTtO2CvjUxAElMqgLlsjrdP6mEB+Zu2wKb2qcyIFUEQiFOVwb1EHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616395;
	bh=zHSmpNjZA4OHD0kaKYRjCibed8j1ZDUSgLmnw5VW5yE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sY4eOqjk10y+O9zUJFOpg5yhN3IADbGZVbExBxFDb5n6H7dQsWX0WooyL7RXGGWa2
	 N6vuLwwRTA/qvbed75Hjet7EzyL/93URb8i+EHIA6hVd7Yfsn+jrlcK9plKbTGxsAc
	 QzLPHEx+1WNC9fVikz7fYf7pK8ZYPLbX6bVpLX1chbnDm3j2hixJZAJmxAUJ44HLfD
	 tMKXLzrGBvNWr2uLM4YX12gSCpa8ZVvineEo6wA0cVAGESteW7K7rsE3smdrb56b63
	 iyy96wBfFosZrI70CD0gqr3mVd7/U/gtxZ3lBev8RR9lN6OHL8AnDRFd6cy9HHu/0r
	 mwi7wmJu5/ceg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C40D40730;
	Mon,  2 Nov 2026 10:46:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 54566362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A6D86076F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0UKASZDwPN-5 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 900AC60687
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793616392;
 b=E0vX0/LJXuM4zc7k+F5JvIUvGAEVD0cqYkj/9K8bwFsrlmMieSWFBitFUHHUQk2OiqIH
 KMY2b4J52YnXGzqrTLtzn6E15FWeZJb4PJt8xvLVcLsoiGsijLqtE8YIn7+qjrQ5LI+nq
 LD6ut91jBaVmiQUf9jvh7ZRcSqGGKnUtXfGCYlJz9YqjE5MdZgYAqKZylUFeLmGQeiIa/
 UEkgyJ87qWPSAVHT+odv+A2m06At51DAdiRkVp3y4VRbwL/CQGXJfljO7dsofjT5OEBss
 myjanckHumH9+XKuGmd8fqbiOLpx3zxmDuWy35zZFIzNE3FHhrVggGaGyVHRJxQ/+MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616392;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=zHSmpNjZA4OHD0kaKYRjCibed8j1ZDUSgLmnw5VW5yE=;
 b=oe+uCVWinM3m4EZf5fLW5OmQsw1uDSlkAcO2F+h1HpZRw3xVhgLgFcLwfcAwXPJ7cOD9
 I+RGhYYmfkufH94ZW1Gr/ABMj7hZFJHbulw8s0TEFBXiPwGRT3fdnqYt1RNCxqwkpPSe+
 ikn7OfP8yT88TTDMEEwlImvRWh9J6ClJgM5l8ORhKO28zNWAXiOXZPA7KuyvQfvxysX89
 OTLA+o8SJ+h5mE4eS5bXSv6Y2TrXSRRZfnYNZlCxIQCujXTa0VGV20i98czFVLvHOfVQX
 ET3vViOVr9ZjJ+i7L23T1q1V1YFrBN4SZGwcMTiSIjTpWOAD9iHtQV7mCeJ6BdWEe1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mOn5WUp9; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mOn5WUp9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 900AC60687
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616392; x=1825152392;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D4V9gd+Xqwjl12KLRjwuCHhH4KI+pNnwUUv/GRXM4aw=;
 b=mOn5WUp9vmKwGnRwMYG6kb60p+RjAaMT2+MC67RXmk++Dr5gdTd1vbEf
 NhZ1w22Oss8zr29Nq0iBEc6y1zfGED2+yRmBarta5cE2re5hqJeEGCJcT
 YzZV4ZOnrnkEV5HDnucTqRNOSdhgW/S7VpLje6STrvveM13qkLjSmUdyt
 LSwCBKz3b/54/0zDydjDKy+EIzth+7YTBAHhXm89Yn6LR6wOX2qIho1+X
 ot97oljgIpyHZOt4vu2dvDUKgqErbmah6T/Pzw9jbX8sSd1i7ejnUnJ3U
 oUq9I2Cl7GCCJUcj2miWMBJOGqIORb6zn2XpsyZ+B0qp4atZZ8ja5oKUz g==;
X-CSE-ConnectionGUID: FRuyQAeWSumibvzr8r0wjg==
X-CSE-MsgGUID: ZUTqDJ1iQxmYYh5flYwqgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305018"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305018"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:46:31 -0800
X-CSE-ConnectionGUID: cK87MUbwRJG1TYiUYD7kgQ==
X-CSE-MsgGUID: GLlgcrQxTSCZmT0RG51kfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6011998"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:28 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com
 [10.217.184.18])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id EBC1728769;
 Mon,  2 Nov 2026 10:46:27 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 0/6] ice: fix DCB lock ordering
Date: Mon,  2 Nov 2026 11:50:15 +0100
Message-ID: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix deadlocks and lock inversions around ice DCB configuration, between
RTNL, pf->tc_mutex, the PF devlink lock and pf->vfs.table_lock.

RTNL becomes the outer lock of all DCB configuration paths. dcbnl ops
and ndo_setup_tc() already run under it; patch 2 makes the LLDP MIB
change handler and ice_dcb_rebuild() take it too, so patch 5 can drop
the now redundant pf->tc_mutex. Patch 1 goes first, so that a dcbnl op
does not wait out a reset, whose rebuild now needs RTNL.

Enabling DCB in switchdev tears down the devlink-rate tree, which needs
the PF devlink lock and pf->vfs.table_lock, both taken before RTNL
elsewhere. Patch 4 only tries them, and only when a tree is exported,
which it tells by rate_node pointers, no longer left dangling by patch 3.

Patch 6 is an unrelated fix of the ice_init_lag() error path.

Reproducers are in the commit messages, each verified to trigger the
lockdep or KASAN report before its fix and not after it.

Petr's "ice: fix RTNL vs auxiliary device lock inversion" [0] touches
the same ice_setup_tc() and ice_pf_dcb_cfg() code, so one of the series
needs a rebase. With this one applied first, his patch 2 is not needed.
[0] https://lore.kernel.org/intel-wired-lan/20261023070258.730168-1-poros@redhat.com



Przemek Kitszel (6):
  ice: don't wait out a reset in ice_dcbnl_devreset()
  ice: take rtnl before tc_mutex in DCB MIB change and rebuild
  ice: clear stale rate_node pointers in
    ice_tear_down_devlink_rate_tree()
  ice: don't block on locks in ice_tear_down_devlink_rate_tree()
  ice: replace tc_mutex with RTNL
  ice: register LAG event handler last in ice_init_lag()

 .../net/ethernet/intel/ice/devlink/devlink.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  1 -
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  | 52 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 46 ++++++++++------
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   | 35 ++++++-------
 drivers/net/ethernet/intel/ice/ice_lag.c      | 15 +++---
 drivers/net/ethernet/intel/ice/ice_main.c     |  8 ++-
 8 files changed, 108 insertions(+), 52 deletions(-)

-- 
2.54.0

