Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75566606A32A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pghtN3xZ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ma0+gTw+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53F1E60699;
	Tue, 27 Oct 2026 17:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kKkcxEXgw-cW; Tue, 27 Oct 2026 17:45:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7C95606A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793123108;
	b=MbAlJcUMAIji6eJu4cAswbwax/k2YMqOv/M/+VR0uULrLuV58PVL6O7QnVEFKs6RmVhB
	 tI8jDlZV0dvKz9SA1RlVW/NQ6Jbg2Y8LajXidXsvNkzArmSN8lp2cZOun73LcN3BMpP3u
	 FTrfgK6VQ1Tidt8vCALVCpTn3VBZHTGcIO8BE1/Ead/nQLYXqBdFjsoBhrYbPUFfOeAWZ
	 +GYEnPGBJrjuJmle8LAxobaoJwQzwzC/esNgPmeo0SdkgPBiHBNE/8YGfmj+FD6M+klvt
	 WSy+g7xREW9PZUPMt5zeKCXCD/cLKcyGW6WrdBv/cqoQlSDB47ptFhfII1VSQ7bbpkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793123108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l6xV6NkPo5guSqZeSxjD/nGJFAnZ02ADVrpIpiJyovI=;
	b=IUhGOdCH53A7rZPL8pm4BNuiAjfyMxjO92sEZX6rL5oeKWuVkCyxbL8nsFrEJTad+TN5
	 jhhiqpjUpwMWxlE7hzOu00G88BwmU/rR5rZY0sp2Yip1yrgg7DgggUNORbihPFodAXK8k
	 t+mPzbRKyG3CJLEoLLNvPlClbXCIlQ783a/9WVnRIw1Mhd0EqfseLHjnCc73eq5ZX6cgY
	 NUAxSrfOfsQWLjruS70NxVPBfs3WgZLIeZiFOCgOHJzeSsaMEoRe38mS4AeWKf0+stsqJ
	 RmOv4eRj9FxaunRAAbuw43Xm2PvpEnlJgj8ub+bzanHyE+4C1obykAjDTY8S28Dz4rw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ma0+gTw+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793123108;
	bh=l6xV6NkPo5guSqZeSxjD/nGJFAnZ02ADVrpIpiJyovI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pghtN3xZymKaD0ooctrz4/vb0pPxTilFGJJ0MGkT4iCKjw0XKg0rw82mfYBbTs61g
	 dlpwnzLmD0+2rgkZcyAVFU0F8AO3enX6COJLYPyeb0h02/EdRA/1a+m3KRuBAJwOua
	 J/GnqM/Q8qWrxf485zcMJK0MbrXxEMenctoDQ5uNbNXCDxIlOoKu3bdvywLOaMLwFp
	 P9bUmgDfNO9PemwcmRsx4BZJMkwC96chYRMfN/0PfSid8P+2pB2NBqneLgeB0XgkDc
	 5Dnx/8oniVN5FdyAGxXCRau3OpwK9pWBMmD6Tp07eCH3Xlb9wWstcaljeYXC3KfztZ
	 kM4HL1frJ2GzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7C95606A8;
	Tue, 27 Oct 2026 17:45:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EAE98473
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6F3F606A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zLX34cI-235d for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 17:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB5FC6068F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793123106;
 b=B5UzkJMpYuC4LL6mydDPHYNy4NiAezKDAmPUvmxyZ69X+WtqfT2yV8l0vZ5McjMB1B0V
 xVU7YSCIAIgSe2e52w/ZkXLG/VrskDx8hN4BOp18Jk8MugAWnJDBuevjqQ3YDkFz6b74u
 frj+6PqM9zZ/ChBqkj3Y805gNyXW39x8/Zw/q+TuWRhjxV/boXKxUdgwtvGk9FhXvR9IE
 Db4GhqvjYCR8lZ4FW8859yL0rNvEXMVVaZRv1GiL3o8vMTGkw90vZvN5R941/64f2B8Pu
 RdQRdWmhTmM6XO7DwYpKPt4gzdnU/6xW0xWGZitoxetxcERYW0+vKfwnOb3OEzkyoVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793123106;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=l6xV6NkPo5guSqZeSxjD/nGJFAnZ02ADVrpIpiJyovI=;
 b=Yb6s1NN+HsewiIWjleGMkLRr3J53jODxYjzYdr9Prnh1xcRNxTdd86Q85q30XGeB6XrC
 GCWATcEDXYoBx5Mh0jydLPBBHg1MRLS5Gme5Ir00wVTXLdqie3+z8XcWWDDMHGMhI+SKI
 uZJd65+IqpHuuo+QkX/sTJleTyPDn9yz9vlG7FY/Q+2k13HzVEwF/iRfsbI4CKfh+3rW0
 5WUu2WOETzdjCF8VbVkQBFHcwEeASDpUbb0cN+0Yd3bARdjendwprKoPxdahVCVmSyf6D
 P3rTdSiWx4cZ3rkm+/QRsqbeHX7k06DOZlM9Q+UNkXhc2pS27w+G3VsXKYsxzsmhAcA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ma0+gTw+; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ma0+gTw+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB5FC6068F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793123106; x=1824659106;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TIrLqDAG23f1IBr9WygNv1lytOLQMqZgle0CyfN60lk=;
 b=ma0+gTw+Wwuco2xRxNm6rZmROY6af3qsVxPOUbCTupWDv6Ohd079k8rq
 dUWmyVnGiytyNOIQJ1bY3wEAXtAqKTE71BL3mwEX6+QaB0u0AKufelrec
 O5h7dipelWFCWtWg14dmB1D4jGB2g88S2MVaRyTLBxqAWwyYocAL5M3QT
 XMLSG64L9Fg00TIrBm8QKa7B364NC0mJ4uuKlE5o5rJO2PRBrQykyQrug
 9Gqf12XPtQAtUxwcZAeMErNUWDQ/0DACUk9oKp0UB1bn8gVC99zls75GX
 Flf7PkUp7qu1EKH1EILeeRcahPZ9u63hxU1hEkYBnynlHnIpXpU16mGO0 g==;
X-CSE-ConnectionGUID: hqi+r9oaQBikIq2SSv9hgg==
X-CSE-MsgGUID: GRJJ0mVjTvO2WcTCv4z3uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1713375"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1713375"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 10:45:04 -0700
X-CSE-ConnectionGUID: TSCFYjR2Sy2IcrLNIq6D2A==
X-CSE-MsgGUID: w5LA0mteQlquv1tXAHnPhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4685689"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa006.jf.intel.com with ESMTP; 27 Oct 2026 10:45:03 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 0/2] ice: eRoT adapter NVM update guard
Date: Tue, 27 Oct 2026 18:45:00 +0100
Message-ID: <cover.1793119681.git.aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Parse the external Root of Trust capability and reject a PLDM capsule
that does not carry every component an eRoT adapter authenticates,
before any flash bank is erased.

Changes in this v3 respin:
  - Act on device capabilities read once per flash attempt instead of
    on the cached copy: a driver loaded while firmware was already in
    recovery mode has no cached capabilities, and a reset re-parses
    them in place. The same read feeds the pending update check that
    the attempt already makes, so an update still costs one List Device
    Capabilities round trip.
  - Reject duplicates and components without data while the component
    tables are sent, and require all four components before the first
    bank is erased and again before activation.
  - Name the components the way the user names them: fw.mgmt, fw.undi,
    fw.netlist, fw.pqc_manifest.
  - Document the invalid capability policy, and that the driver can
    neither activate nor roll back fw.pqc_manifest.
  - Report the new rejections through the netlink extended ACK only.
  - Drop __free(kfree) and the mid-function declaration.
  - One errno for a malformed image, and -EIO for an invalid capability
    value instead of -EOPNOTSUPP.
  - Make the capability verdicts sticky, so a duplicated capability
    entry cannot undo an earlier one.
  - Shorten both commit messages and the devlink section. The review
    tags from earlier rounds are not carried, since the update path
    changed; a fresh review is requested.

On the Manifest: the AQ activation select mask and the pending update
capabilities have no Manifest entry, so the driver writes that bank and
requests no activation for it. It can neither activate nor roll back
the bank, and the devlink docs now say so. Two points still need an
answer from the firmware side, and a Tested-by from a named adapter
would carry the rest: whether shadow RAM word 0x4E and component ID
0x12 are the right values for the PQC Manifest, and whether the eRoT
authenticates a Manifest against the active image, which decides
whether writing it before the other banks are activated is safe.

Two defects next to this path are not part of this series because they
predate it: an ice_aq_task left linked in pf->aq_wait_list when an AQ
command submission fails, because ice_aq_prep_for_event() has no undo
helper, and unchecked lengths in lib/pldmfw (a 32-bit size_t wrap in
pldm_check_fw_space(), and a component bitmap whose length is never
checked against the component count). Fixes go out separately; the new
module type ID only widens the first one.

Aleksandr Loktionov (2):
  ice: parse external Root of Trust capability
  ice: reject partial NVM update on eRoT adapters

 Documentation/networking/devlink/ice.rst      |  24 +++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   7 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 193 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
 include/linux/net/intel/libie/adminq.h        |   1 +
 6 files changed, 203 insertions(+), 27 deletions(-)

-- 
2.56.0

