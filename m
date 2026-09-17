Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA08AC88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 09:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB44F605B5;
	Thu, 17 Sep 2026 09:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qid8Gfi7icfF; Thu, 17 Sep 2026 09:43:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1C609605CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789638199;
	b=DJA/R5eUjEfqeNeZKaEuOzoAk+kQXcD00/Dieq/eoVmVmutKrzKE/kG/PhcszDuJILAK
	 2lqgoLEBl+Fvkr1b2iSrd3qUVdUnnLL26Dx6FKulQP5zf/RegKHhw91K3ApKTDdWzQciF
	 2sRXkIacm1qjJ85PsWark+BKty92Yo0xprTYy6vYDXlqS7bpJRV62Snf9rUfPgg+eERkD
	 TevBChLAg+QCzCeZcpg/iUOoJ7wbPlH0EFIKJlyflNk07cPXTu7OJcypOXKJ8kSgnNBMV
	 qTH6F60mTMgn2xAcT/uiJY1mxEsrubq5egE5jDZLtZnCuVqOI9A/ZlKGkg24OzoK2uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789638199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k1pSfHTQ+P2Lh1QsLaYYjdEF6ydqH38cuFP/a6QRs/U=;
	b=tL+mk7pTGkPegbxq87PQ2gcjr+UL4W/tzyN7RTiN38tRuxKpaMmXbqvRZMbLRIEv8eVY
	 /bBZ+y9NENYwZjkrao+kneGnfst3YORipBg0HJ8bC7CkY7QGj7UY5QA3EZIRmdp8pJZWd
	 LFEdM9XzdPkwxMoj05HK7XpKw5C+q4VOdye1O+dOQzJzCZTlw4R/ViH2jWiQjpzCtarrv
	 641/knJ25cx286MnNC+KQ55v8VtlvVdL+7EqNJFGqD5efzpV0R9IDBMJGYiONwk5H6SFM
	 A/puoYBcycbzDdxlyLrqRRjhmYfpPwgl1U/sZVfehSNunzgMFSZWzy29SWKzJaO+KiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789638199;
	bh=k1pSfHTQ+P2Lh1QsLaYYjdEF6ydqH38cuFP/a6QRs/U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TC49SVvE19fnVgUCFzAx4NAeMwuoat4sYt/xvrYDURT9rlzVV3P/wq46uJ3UXiGVQ
	 BfVGfaPuP54OSaPUnIkiVlOveXs+fniT90p6d/GXl6rEgJUNeXd87K86cAYvRdSjgB
	 gyhficbtjtNsM2p9Zhe53g/0m4DiwvzHA28KTB4Vc04zUMkOeWTnMy5JeNbEsLVUPY
	 0HjQ6IBUfHuGxValGC3c7EKTvRRzNrBAdz3QcO4B3Ka1SUsLImM2dmTbEDqXFspZqV
	 3piWIdRCEHIFSThC8/vrgLNfWzIIZKSfSw9B+P9WiWE0HQUtQElo3F/n1B74o/iLsX
	 8DLWuLLBZ/9lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C609605CC;
	Thu, 17 Sep 2026 09:43:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C476C29B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA2C280EC2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U_Miq93JnUTg for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 09:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E0FEF80C8E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789638197;
 b=DLF7cDTqRJ18KMpJloGtCktR7g/WM16qL1y4y2QnYvWS1emDOOkePL7u/386WPjjCYhg
 4RVLL+y0/FnMt0A2ogipIX8W9Q3ZnM5Wkq1YYlUckrdEqaizEcbVwK02zj2ax6+WCgIiB
 TdgLQkqc977nIHfrmDhf/U2pMft761CNuKi+v/QaUB6RU8SRubRXeE4VxKw+NfpMXAsNL
 zQ+l8MJfcJbYRFVDBQJJGfvRBSe3sbemjbvv8BLQFeUne5Yw9h/YYF0+65mvpaXczbwQw
 jpnPfkp1P78aoecc7061cj5xhuYg0He5MSsT1tzOWZK21UV76TrU7oVtOt9ZsS7bsVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789638197;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=k1pSfHTQ+P2Lh1QsLaYYjdEF6ydqH38cuFP/a6QRs/U=;
 b=Cz5G20UOGKkoEgfyFIV2ElRbPi8eAQTZ8rYm3L1FN12CVXIBlToDzlsdMtXVnfQXl/ol
 /KugUGc7pI7v3q6w/RG7s+pO1FK3M6UxQO2fWcXZgrT6c6KALHiI7Zk21HEYrEfKl61w/
 +Z0oJuAOk03gRDdp7Nw+/BbeY1h1xdOVqoR6AdVH4/l6UCGAtAXxhKCE/7hvY6zLCHMEp
 GYVr/V9Z9ywkWUSxQs/MVclqdAUWN2gLSu0jdPyjC68Ou4pNV9uzAY15fjhaOjD8KJ4vP
 CAk1ZUX0c4l9kC0dk4iCMqcj+Vok4PWgKUKiyLIjQdOHIw3GK46PsB6E4WHucpsS6sA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lC5f0ndP; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lC5f0ndP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0FEF80C8E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789638197; x=1821174197;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MN2DxHf8TLY4aIv7zDHBhmbNiqc1Vxe97NR6yAmJsIE=;
 b=lC5f0ndP07g4PrXk4ykWOOyz9Md6aA3iMl/ExiYA4Di9Gnz2YKxQWUMH
 klXEnzwu9oCn5OQ5uG4rB/x+EDXRXXjX5pixqRcucO583feK7dYGSSo7k
 XBKTs3fKwaZ99O7FmjXM0mhUyShu3tFJHOZ6zrASpZjQR11N+W3CJNABT
 lve47aX/rEX+3OqSfLZIK2nXjy4yGVkYPnTH3soCnsig3RTgFdNtkhj4R
 HZpqd1SiyCz7K6LoUKx4fPaUCwKKleZf2mfghPH8/RPasCDfdrnTXvCpE
 0nNyXUCjKAXWOTb1D5mU6IQcRgZ46Z2JbgwPLJCQ7WKDoFFeWWHUJSeU+ A==;
X-CSE-ConnectionGUID: meWUdxdeTmmr/6bIVqqRyw==
X-CSE-MsgGUID: GyYe+EciSeeoe3+BhhrFOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100706497"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100706497"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:43:15 -0700
X-CSE-ConnectionGUID: WbyJpUSGTfmTAnhqX1YA3w==
X-CSE-MsgGUID: MTuqmTMDSmmR5gym5OjbsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269400567"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2026 02:43:13 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH next-queue v1 0/2] ice: eRoT adapter NVM update guard
Date: Thu, 17 Sep 2026 11:43:10 +0200
Message-ID: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

CNSA 2.0 PQC adapters carry an external Root of Trust (eRoT) controller
that performs full-image authentication on every NVM update.  The eRoT
does not allow updating individual components; it requires NVM, OROM,
NetList, and Manifest all together in one shot.  If you hand it a partial
PLDM capsule today, firmware rejects the write mid-session (i.e. partway
through the PLDM component transfer sequence), after the erase has
already been issued.

Patch 1 detects eRoT presence.  Newer firmware advertises it directly
via device capability 0x004E; older firmware does not, so there is an
NVM-based fallback that reads the eRoT presence fuse (SR 0x1016 bits[1:0]).
The result goes into hw->erot_present and is surfaced as ICE_F_EROT.

Patch 2 uses that flag to gate the flash path.  Component identifiers
are tracked as the PLDM component table is walked, and if the full
required set is not present when ice_flash_component() is first entered,
the whole update is rejected with -EINVAL and a netlink error message
before a single flash bank is touched.  The Manifest component itself is
only ever accepted on eRoT adapters in the first place.

Testing: validated on real eRoT-equipped hardware.

Aleksandr Loktionov (2):
  ice: detect eRoT presence via device capability
  ice: reject partial NVM update on eRoT adapters

 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  7 ++
 .../net/ethernet/intel/ice/ice_fw_update.c    | 80 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c      |  3 +
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 39 ++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  5 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |  6 ++
 include/linux/net/intel/libie/adminq.h        |  1 +
 9 files changed, 143 insertions(+)

-- 
2.52.0
