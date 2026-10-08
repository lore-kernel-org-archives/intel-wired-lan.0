Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DEACA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 14:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A57881279;
	Thu,  8 Oct 2026 14:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CGkyNmwyIaQ0; Thu,  8 Oct 2026 14:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BED308127D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791468865;
	b=k86ZElo7Z364/snIMWZdGZlpDXX574Jn2MxZdO0cG6XxO8keFofgkksNxtoycLopuETj
	 1fVzUXeXTl9yNxpVo75yJ+n5fJSxREEzc2nAV46GcsHc1Gd5VEP+Ceh8pOHiRmmGdQt3t
	 5xIKepHAzuzOef84P4ulOnXeMTavscxQCCa2D/eVXz5u/wuDohvuOl/buAv6aZYvuWnZt
	 KLQFS3zydINYQ1nErhBy+49SDniy5rHr0Lb2JwoCPCvjgUFhYpNrLREcShjBceqafdk/c
	 9Sup45R9TksQV7GUxYLYLzormHHpys/weNyR9FCuJKdC3j5LpNs5TpraZyA27xU6kSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791468865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ibF/PN1NA2JJQPtIKje7V9AFdRdpBsEcpTX55mfZh6E=;
	b=l57N8xAFhTgpgNn+ZpDmbZ1bWuXLurXWApElPFuMl6sWqe6hruTIFrMZ9J28I459KxL9
	 JRGvKBRYMw/JPZ6eCMJLiBiVSJIyFPxv1V/00/ZE1m7mFu9DL5UENsIs5CDFXO9t2VNIN
	 SQ+6Yys8hfA0iTRuYsGDQXomk0d4t6U//9FrfzogHz0uDedwFlzG56gZjtBL04gwzsKBV
	 ZeNDxw2N03lN8Y/MZfRmDwXLsLd+2DZIlC6rQbmbBn8aboZ4Z8e2rgIuFCO/Nvg7jVNtT
	 G3icadqRLW3QFsNrXIx2alOw4W6gBjISUueC+nU1zN3BM9PDn5hSIlZbSpZhqqdcnsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791468865;
	bh=ibF/PN1NA2JJQPtIKje7V9AFdRdpBsEcpTX55mfZh6E=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uA4rALr7pyHH+NcXJzynWML9JTuGq6c2svHfMHUCMiYeR/gmDPXQPkHskkhTyxKX3
	 TZx99WZhvX7MWNr2x0xqQ1+llri7kZIX2VIPfZMqvaSoS19FaBYeCPGYeANNzMYV4p
	 maUFWsP3nChedi2Z6JBNnOU2E2fEM3qdplIUK1sn+yGaRq9Se3/XvhZtxun5DjIkDB
	 Qv0sHkIso4yZ5F+jhTUVQMfgZ/o0epFHe0HSAmxieVzIijAgavskOF2PWkM3P5GRKE
	 0iTOpOFFEBt1heD5DqMUCcCdFawp2OcXH0agUV06DKhPlMd9P7HatiujBX/yvWEkaJ
	 9UBd1Lss1U1gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BED308127D;
	Thu,  8 Oct 2026 14:14:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35CC21A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27BBB40B07
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0zCz14j19MO for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 14:14:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 32B2A40ABB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791468863;
 b=CLBFTWVH42tF+9ZtsU4lsEVOg+YCM++h/I9QuBnds7O08PAK9Lqa1srnFMp0TLQRJ7/v
 wk6N2GPsUpe686YQynwxKRIu7qaRWIpkIt169zzCXRwxtM6Z/JCQk9JBFCBc3FHMzYMlo
 KapW/MR3CZsXrvB4Vix6sfKcta46SwGR3DowFx6fSRR2guMCf+N7c5+q02TBPRVtExYLs
 JJGLxxnqmTNir1CL2XU53Vs1B1cD0E9EK1SN0DqFpEvd8i6qElrdl9u1Ww1vB1IK4ERt+
 4f2FbRqTFeMqARmH/4sGy1DWPhVhDjfjDlTiRDdcd4LX9QgwVTbilIuEpmXDkNNLcCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791468863;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ibF/PN1NA2JJQPtIKje7V9AFdRdpBsEcpTX55mfZh6E=;
 b=UsKMSEL8I2aRhz5OzGATpDgLAuIZRRi6wucFfIgza5vko79n34khX4KKQ2nTNKx3730Y
 5oVAz879F8I/DjWWdhPZAZMmh4oN8WD0FrJzXq6uUMHkPiMz0pRwlGlZxwjJKOhsQYRzm
 I980q1ipoNMEpAe2+K6nR33Co3xRYyPNCZviReFi3r4dyKiUamPAcHuvyDJIQNJ2r0bf4
 K3DiytBLBe3m+SPG3/554DW9zxInrprnOcPwLGraKmMBFB87umky7ng5tQVyCv4JCW/tW
 AHwYRjsAIgtquGz2rkbeUeb1SKztmjR2r5X//mKWU5576J8m+ftoO2RR8yHMIbOITEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PsF9wvOO; 
 arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PsF9wvOO
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32B2A40ABB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791468864; x=1823004864;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NYybnfSA1zFeTi8w0Bt6cVDeGkdWUVGTBg9ST3MT5sw=;
 b=PsF9wvOOwkd34OCqKnn9MXRz3C572cO7gfMmPx+eNPEySgXCN+YKCdZy
 cPCS6Cf17+WbMThhcbA2pbQHqyflG/2kzuhQKjnTgk8OVThywfEhzFpgG
 MUf//JtMSV9f9NafReW63nr/+v1YeecrGOoW5hnut6ahgGUEOT0M9lEzc
 SCiW7t9sg7DcP9DES8U3HCZK1T855wC39rNVXTkmmLR2cQP1q7RM+gLPa
 m1Os/pqGo8MB8H/8Yt4JL+7LDqlKELHH1VVsSypAv3KZwAeAr9O0H6d4x
 j6s1Z3xRrV8OA60Tqn5b18V/ZukQ2BXyzlt8O/G1FVWlffEmsVXE+dmUM Q==;
X-CSE-ConnectionGUID: d8z/yWVzQ0yNDX2HDokR1Q==
X-CSE-MsgGUID: ki3WF8NDRwme8kyb0/xcyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="250626"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="250626"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 07:14:21 -0700
X-CSE-ConnectionGUID: yw0ex2WiRSaAP8fXUIVwIw==
X-CSE-MsgGUID: 5hDW6pKvQ6OnqBNtMslYVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1887314"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa012.fm.intel.com with ESMTP; 08 Oct 2026 07:14:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 0/2] ice: eRoT adapter NVM update guard
Date: Thu,  8 Oct 2026 16:14:16 +0200
Message-ID: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
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

Parse the external Root of Trust capability and use a fresh device-capability
snapshot for each flash attempt. When firmware reports eRoT presence,
require NVM, OROM, NetList and Manifest together. Reject single-component
requests, duplicates and incomplete images before erase, and reject an
empty applicable component list before activation.

An omitted capability is treated as absent, preserving legacy full-image
and fw.mgmt component updates in normal and recovery modes. Manifest is
accepted only when firmware explicitly reports eRoT presence. Older eRoT
hardware whose firmware omits the capability is not protected by these
early completeness checks. No fuse fallback or hardware-ID inference is
used.

Explicit values other than 0 or 1 and capability-discovery errors stop the
attempt before pending-update cancellation or the NVM write lock. Recovery
mode bypasses only the unified-update capability check. Cancellation
already calls capability discovery in the base driver, so that query must
work for recovery flashing even without this series. Its error handling
is unchanged.

The AQ activation-select mask defines NVM, OROM and NetList bits, but no
Manifest bit; the Manifest flag remains zero. This interface limitation
does not establish a physical layout or implicit activation with NVM.
Manifest activation timing and the firmware contract still need
confirmation. No firmware specification was supplied for that contract,
and this series has not been hardware validated. The component checks do
not authenticate images or make updates atomic.

Changes in this v2 respin:
  - Treat omission as absent; retain a separate invalid-value bit.
  - Define and initialize the scoped capability allocation together after
    overwrite-mask validation, without changing lock scopes.
  - Explain the missing Manifest selector with a one-line comment.
  - Document the legacy omission limitation and recovery query dependency.
  - Preserve the component and finalization guards, original author dates,
    and two-patch split. No review tags are carried.

Validation: source-extracted executable parser and update tests, including
automatic-cleanup accounting; strict checkpatch, kernel-doc and whitespace
checks; actual W=1 ice.ko links for both commits with matching base config
and symbol versions. The tests mock firmware I/O and PLDM image parsing;
they do not establish the hardware or firmware behavior described above.

Aleksandr Loktionov (2):
  ice: parse external Root of Trust capability
  ice: reject partial NVM update on eRoT adapters

 Documentation/networking/devlink/ice.rst      | 21 +++++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  6 ++
 .../net/ethernet/intel/ice/ice_fw_update.c    | 87 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_type.h     |  3 +
 include/linux/net/intel/libie/adminq.h        |  1 +
 6 files changed, 115 insertions(+), 4 deletions(-)

-- 
2.52.0

