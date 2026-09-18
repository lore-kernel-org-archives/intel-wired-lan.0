Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4A6C982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C2E460E04;
	Fri, 18 Sep 2026 13:32:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EpImwHu8WiDQ; Fri, 18 Sep 2026 13:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9FEF860DE1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738360;
	b=b62ZyiXse/0i7fjkDev2Xs2/UpuVfdCpWQddLJyY7IiF05WU0xEggDAykTHRJOwG7IJf
	 dldYndrio+vIMXgX70pYisbYt/pumBbsnqMJ9GlmWeFZ7oPHXpC9bKf/cTxaa3y6DohQO
	 w3T9DZMtpgEtDBg4TRDFzJPe10Fc7a5aSRn1kSsfPDjzPSI5S+H0SkdyEKzNBuMw0NDxH
	 mQv6Vpzakkw9z67MsRcJeVqAOBKxi5g/0CvVjYv6/E7UKv/OA9IstGx30G3uAIn39xOV4
	 jz7YbSb75zM0SZa4dlGmz2Jzkf1/Y1UQ0OBe2w8K0KLTqp27/ETuJmn9gwsVvim7qQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738360;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OzVukH4Mm3+kU1VzTEz5Z+oY40rG5068rtc/7X4f7nI=;
	b=nBC9/o5AZodz7kt5Moyfry9na/eB2TExoseZBM9ivjQEVKyG308w5DCKwlwDGjJMYMdt
	 HoOq78/LE/rSGuAylnbFyKAXDddQNLrTjrsDLnIPLSWwKBwAZiixgK/e8Ai1kVg5jxJsS
	 xogMJJPj5C5EdSmhkFepl13bgQTbP3uYZ2rVJMuEvqI2cFEzHe6c1hxVBYZmM09ntni2J
	 aEBC0BHqpOFtER1c3V8sqiVhJUA3xikRSBhlgyPEoIRPmzLv0xJ62Jb3oPE7fy+640Ld4
	 EfMJCuI3YHXM/PdQNQOF3VWHH0eXHf8KVufukl4JmYXPfuuJTwmXWz1YCgMPyXiwuNw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738360;
	bh=OzVukH4Mm3+kU1VzTEz5Z+oY40rG5068rtc/7X4f7nI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ot7DOAHa35rYmTDNIJGCIVvptnEKaLoXZ+6cCxrOBsIrQLNm3a2GA2mMOGkVIlgYd
	 3BSpm4ZJ6aQyOsi1tn4t83DuO2u6OJAeMwzQlB9c8KABTDM7qRpkkkWBG10RomSdgm
	 hdYZKon8VUhflwWIxnNzgeYFGMiPcF/wkg0/vXnVSg19YAMeOrYGloJnfgC2xFOtBX
	 5VWw0suXXR4wltKpdcb7IYK0crN0GpfFDpkEuq+KjGsldeZrgPu6LWUdGNPI7zdvUs
	 RP0oP3qv5LGNgd3f1bAjpS9nFmNSMhegnqCxbbxz0hBXz09CsXK+sNzgmP0Qj9I43Q
	 2KZdJ/Vyk5ONg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FEF860DE1;
	Fri, 18 Sep 2026 13:32:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 91BC0A29
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 781A140524
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eN5oLILKw5qp for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:32:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B2BDC400B4
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738357;
 b=IwXNQEXhOZSVrD1ayH/en0It03dHcTzbz0XIg9GSjEir3J92s2R9DbQnOorpjKKeXd8q
 OByIAP4DKD+zYSO4AYHOgUOWMpW4uODniHZ1Ckkk4vvrx/qfRxK1hLsy8HTQWPqp3U8NO
 cCpn2yz8ymYaM+/cZnulnWqfiNA4tForbFkLxseyfgtXJwECvV3Eww5Bpn1s9RgkRM3bT
 9oYdKwcLkqYrvevm7Z+ytuBW5spfolIUQ3stQsiKT3tkjUodI/3o5OlzbCeApq2LS3rfU
 KzwVEFe3Svf5d1F9bRwlzNKOmUmxVQDplhbQR2bN9Vj6n3IW2V6PBKJGlHwvt2dxHXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738357;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=OzVukH4Mm3+kU1VzTEz5Z+oY40rG5068rtc/7X4f7nI=;
 b=q7RAS0jvrZJksDLqMa8v4HX0o/kulDx1GsJg5spj7MtZbCZAhu7qXrowJ7BWuucyfc8p
 lXz8XI49BqpEtbNoPWy6vRQw83++OatVd44KHrk0BD7s/b6MLz/sg8tJIf8wLqUB4VLK5
 HRqsHEBP20BlJwB0Q16e8PARmye5Cz0Wi+U6CqqcPnL//lMaQUXehCL1AX2tlvx+sMZCr
 88hFVOheVMEldUGoSDjSL3tQZ1VntzMmo3u1c9ryI5Cfcsy3vQmuX8FycXXgndnNYVoDE
 4o92n8SWCzkc32NsymT1mDhu6qRIquuR0AtlBL45v+D6XhYet3qZ1DgTMuhovVZot3g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UZLiPDwB; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UZLiPDwB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2BDC400B4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738358; x=1821274358;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gHTpFXKwL2ZqWGfSetLnqS0tikQNlo1jF0x0L1zCQfA=;
 b=UZLiPDwBq57jCoXOltEfUlVS0pZVK68dHlGclhygz09/s+hRgwbtNeKA
 GB7rxcXsrE5JxyBSpcLpn5qsNYE7oeB0axzHahBNiG+y0y077a9A4Uwxx
 TTNIxP5bTfmmsbgsdXPnjnU+cMRvXr6AdNPRvdLDPL3hVvJBHlwpUJ98j
 6IJkiyg/a1DOgsSt4XLKjzyDqkMbt4V5AHcXX2j4wQeGhIPB0P5kSLQMf
 3wmVVpH/fxKiBKFM9CgO918cagykhvEH+hUhtW4DtcX5BveQRweu3R4fW
 12jbIaPzF98q33a5pUnOtim7CIS6z0HhXUtfAZslgZgxMu3FC4wwsxy4s w==;
X-CSE-ConnectionGUID: lPwoTxjsR3uOEB1ftFW+sA==
X-CSE-MsgGUID: 6mJ554jHTEqICY8nWAZQrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776408"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115776408"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:32:36 -0700
X-CSE-ConnectionGUID: cYkKlW6NQjumJZGZlpnodw==
X-CSE-MsgGUID: Cx1N53GCQPOdsz+EFbWJdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835231"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v3 0/3] ice: fixes for pause reporting,
 autoneg and RDMA
Date: Fri, 18 Sep 2026 15:32:31 +0200
Message-ID: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
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

This is v3 of the ice fixes patchset for iwl-net.

v3 changes:
 - Patch "ice: support RDMA on 4+-port E830 devices": gate the
   "RDMA functionality is not available" dev_info() on the same
   condition that actually disables caps->rdma, instead of printing
   it unconditionally whenever num_funcs > 4. This addresses Simon
   Horman's review comment that E830 would otherwise log a spurious
   warning even though RDMA stays enabled on that hardware.
 - Patches "ice: fix asymmetric pause negotiation reporting in
   ethtool" and "ice: fix autoneg disable when link partner doesn't
   support AN" are unchanged since v2 (Reviewed-by: Simon Horman
   carried forward).

This series fixes three issues in the Intel ice driver:

- Asymmetric Pause capability was missing from the ethtool-reported
  supported link modes, causing ethtool to always show Pause as
  unsupported even when the hardware supports asymmetric flow control.

- Autoneg disable was only attempted when AN had already completed,
  ignoring the case where the link partner does not advertise AN ability
  at all (AN37).  Both conditions should allow the user to disable
  autoneg.

- RDMA was incorrectly disabled on E830 devices with 4 or more ports
  because the generic port-limited-capabilities path capped maxtc=4 and
  then cleared the RDMA capability bit.  E830 does not have that
  limitation and must be skipped.

Konrad Knitter (1):
  ice: fix autoneg disable when link partner doesn't support AN

Lukasz Czapnik (1):
  ice: support RDMA on 4+-port E830 devices

Tomasz Lichwala (1):
  ice: fix asymmetric pause negotiation reporting in ethtool

 drivers/net/ethernet/intel/ice/ice_common.c  | 14 +++++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 29 ++++++++++++++++++--
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.52.0

