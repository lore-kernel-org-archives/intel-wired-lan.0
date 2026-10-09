Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57DFCA6019
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8316440917;
	Fri,  9 Oct 2026 12:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uisiX17sLfbH; Fri,  9 Oct 2026 12:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 807C34090A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548090;
	b=Gkq5oHNBDLDhOMj3RgNQWhGxeux6kRLaYQTVtHv12FkZq43rRNbcQmZ6rby8E24AZd7y
	 7D1Crtqdg0TFBLcO6sBAoocbBdOPc8i4FqTsL7Hm5/ai3+aWN2f4d8XuyVcg9HRsNvc5e
	 kOmHqcIC3e8PE/mS42HcrMncg88GYMYKiCeDbAPqDv2OFMkEmWjutZnzJu+g2Cv93RbmX
	 S+QviT0gW4a5pJjPvd7Yaw0E1sk5Ar4T+2c7cvKoQSw7vjhWVvkqrX6hhus0VSYNtDlSn
	 L5PPmgZKiHIO39NsFAAjlSId4gGOvN6XoF58akUQdMboTYsx29mvi5f8ToMEKB5K9bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DnkZ4Ea7NgqQNPA7+2iej6RCYLadmhBSvzmFliZgmu0=;
	b=YrunNqHFVpjgmMiaNAXjh7kpwJAKxYf2GvXzTMUx2HO9JrjXGeUA/5XLjNwHIhRI/mTs
	 4jKD1D2hAPVP/5QQf2YJh/J0npRK6rsVF+thwKPwOt+mBJaOopqqRKQiFbciOxk5PtR4P
	 vPl1ZfAMOGZ3Ivn/3rmZgmFWQujBnjuhwqrQG33p7ExyR5u5Bv6/Xn0rVtGqtwo2JN/RW
	 EnRE7rvXXS7P8CbSoB95q/6sQ7KgeFD1FPD0c6gjWsy0V6Kbc/ubP80s3DRvgWIEYswkQ
	 iRBHRUy97cJFQCc5igQFa5RjjF7ZJMpCcxkeLDezriiCqGIeQhcjp+kBVSlfiNVOf8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RZQofn1S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548090;
	bh=DnkZ4Ea7NgqQNPA7+2iej6RCYLadmhBSvzmFliZgmu0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RkugXPBt2Xh6r4dvEj7yTpuXYu6FFfbs4B6JWaJEYcZuk2Ndc77KSoi+Gs7h9eQBt
	 HWNimp0VIu+mKDFnnHM20LDfjewVUOBgRwigt2MB4y8l8txo9UaLHtEHmvMYeZ+aAO
	 PoffEFJ2Yg+bSJZrQXVoRebIcSUTry2O/XSxHM6eR0efb7A4G4WSv+7UMwalVNbOkc
	 9hiAVldUV35uHLUkDhjaKROjiB1kxayshdOkDPjvix68H9C0OAlOH7JrrdUG3hQf7N
	 9eNGwCuGLpvTA0vCrqXsxwMUWhxE39QlODXdAo9T9FXdyq0tfurrK1pY1ea3N/N56M
	 aDoioWvQqYRRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 807C34090A;
	Fri,  9 Oct 2026 12:14:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C054317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4959640902
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M6Nhaeuja8LQ for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:14:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE538408FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548088;
 b=gHPbDbymLp9ADZb7YWsyjG31LwJ7u99AhJg6qEZJFN6VrMACCFKiDv8vvAtn8eGT9xYV
 aitl6Hp7YbyrAgxJSyEM/rFO4SfrEn2X5rn4iGZFQqlhcIEzvtPgo9bNUjK5bsttKCUtp
 LcFt09ACFyxNUO0N87YRXgV7bWicm06WHd4vYipgVZWg3YPX3hvXurFpkcbQi8huekvDf
 1p37DRR4XinASwAiJ+Rx957k3f779mGdEpsImUH6+0C5cRYfvOhf+JvUIm3wmZgxidW1n
 SCdojKD4STYxVATe3ArBJw4rpQqA/lS87hn6Uxa7sOnpB2M/LKcqKprR1COETkw7GMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548088;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=DnkZ4Ea7NgqQNPA7+2iej6RCYLadmhBSvzmFliZgmu0=;
 b=EdEgUQrUUm8UGKPIRb28PiG3S/0isBEFHNuHyJcdwT6CMV0S1BurqobOaGaD2enAvvT7
 gO9uARJla4Et9fRoWcLWuxqHvSBghedI+PTtqFzI7XVme/D2xqk0fxPZ8Exv0YyPpGDnU
 MnMK4sYs6tp4cjRoBn6vh5U/sqzvoksTlP3PzRr7DsqW0fWcj/AE+fxgv+9PZA+GZ/Ed0
 Snz4SGK7jlJTglHDfzLCcwml1r3Atr6xhilzymfknh3a5bPtn8/d7DY74+CbLeDFGKYYf
 UGRD0Bw0oIsxFxF8Gl7JLWbWLPBdCkXAcMtjSlGc/rpKsI7M+HN3zVSa72pePvjZNJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RZQofn1S; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RZQofn1S
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE538408FF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548088; x=1823084088;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZDsN0eq5/mxh8k5VilroUP9LRauv2GW83vbX2MoSXog=;
 b=RZQofn1SXi/HLt4VYG+kh7Yw/XogpAwQ+c0WYvTheUFXZQMCzf19+87N
 uaX0Oq/ofnQHln34PFVDLszdT9R/RYyppTro8V7nplRSjfoI2XTa+9gxo
 F1bGt+vvKYOgxJ09PVfNtfa50X17vdhp/M73gfzOkwA1HDhyP8syQZIXb
 3jW5N1vWQXqCFozh1vU5+FIoXrSjZj3J5thBRbczFrHwXEMPtXa50AyPB
 /vK+eMZ4/1Hm5GQ4ehljTpgVTWTXBh6A3+W8Ki4DYOAy2+xY89xQqkhAz
 JMc3YdXR3mVwlzE6jQ8SPeyvc/bHEEA/GpBi9x9e+81TvtTc9FrTOqNfr g==;
X-CSE-ConnectionGUID: zk9mDjQxSg+i4ROmILEHww==
X-CSE-MsgGUID: W0YvqtkaTju1uIHQV+3kLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251071"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251071"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:14:46 -0700
X-CSE-ConnectionGUID: O7qflKM9Tdmx8yRbDGvcZw==
X-CSE-MsgGUID: HILfhuYpSlepiH+H7S2zkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420368"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:41 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id A2A7228799;
 Fri,  9 Oct 2026 13:14:38 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
 skhan@linuxfoundation.org, rdunlap@infradead.org, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 00/14] devlink, mlx5, iavf, ice: XLVF for iavf
Date: Fri,  9 Oct 2026 14:04:11 +0200
Message-ID: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
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

Also available here
https://github.com/pkitszel/linux/tree/xlvf-v2


The purpose of this series is to allow iavf to use more than 16 queue
pairs, in two modes: up to 64 and up to 256 queue pairs.

In order to support more queues for VF, we must give it a bigger RSS
table (GLOBAL LUT or PF LUT). There are 16 GLOBAL LUTs on E810, and one
PF LUT for every PF on given card. Both kinds could be (re)assigned to
a VF, while a PF must hold at least one of them at any given moment.
GLOBAL LUT allows VF to use up to 64 queues, PF LUT lets it use up to
256 queues.

RSS LUTs are exposed to the user for assignment via devlink resources
API, which I have extended to make it possible.

Devlink changes:
1. Extend shared devlink by two callbacks, that give the driver
   a constructor/destructor for the priv data attached to the shared
   devlink instance. The constructor gets an additional param, used in
   "ice: represent RSS LUTs as devlink resources". mlx5 is touched only
   to adjust to the API change.
   ice uses the shared devlink instance as a "whole device" aggregate
   over all PFs on given card, instead of its custom xarray.
2. Extend devlink resources API to allow user to assign resources.
   Before, only the driver could assign resources, without any way for
   the user to interact. Now the driver could register an occupancy
   setter (.occ_set()) for a resource. ice RSS LUTs are exposed that
   way. It was proposed as an RFC in Feb 2025, link in the patch.

There are also patches for, Admin Queue extension, GLOBAL RSS LUT
alloc/free, and two rather big "new opcodes" patches, by Ahmed (iavf)
and Brett (ice).

Finally there is a patch that adds devlink instance for VF and
registers devlink resources on it, combined with all the glue code to
make actual use of the whole series and accept the larger number of
queues for VF. This (the last) patch contains usage examples.

There is one resource added that just groups GLOBAL and PF LUTs under
it, so there are 3 rows of data for each device (PF/VF/whole-dev):
$ devlink resource show pci/0000:18:00.0
pci/0000:18:00.0:
  name rss size 1 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 0 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
      name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
Technically the aggregate "name rss" line could be eliminated, with
just the two last ones kept (then renamed to "rss_lut_2048" form, from
the current "rss/lut_2048"). I like it as it is, but this is just an
opinion, I'm open to discussion.

v2:
 * drop "ice: simplify ice_vc_dis_qs_msg() a little", already applied
 * devlink: propagate the .shd_init() error to the caller, so
   devlink_shd_get() returns ERR_PTR() now; register the shared
   instance only after successful .shd_init(); document the new ops
 * devlink: document the .occ_set() mode of resources
 * ice: prefix the shared devlink id with "ice:", handle errors of
   devl_nested_devlink_set()
 * iavf: stop multi-message virtchnl ops (queue config, queue-vector
   mapping) at the first error or PF NACK, keep the op pending on
   timeout
 * iavf: fix queue and RSS (re)negotiation on init, reset and
   ethtool -L
 * ice: serialize devlink RSS LUT changes with ethtool -x/-X/-L, RXHASH
   toggle and VSI (re)configuration, by new pf->rss_lut_lock; make ADQ
   and devlink RSS LUT reassignment mutually exclusive
 * ice: limit VF queue count and PF RSS size to the capacity of the
   current RSS LUT
 * ice: create VF devlink together with the VF, rework deferred VF reset
 * many smaller fixes, mostly after Sashiko review; per-patch changelogs
   are under "---", together with Sashiko suggestions that I decided
   not to apply, and why

v1:
https://lore.kernel.org/netdev/20260508124208.11622-1-przemyslaw.kitszel@intel.com

Ahmed Zaki (1):
  iavf: use new opcodes to request more than 16 queues

Brett Creeley (2):
  ice: add VF queue ena/dis helper functions
  ice: introduce handling of virtchnl LARGE VF opcodes

Przemek Kitszel (11):
  devlink, mlx5: add init/fini ops for shared devlink
  ice: use shared devlink to store ice_adapters instead of custom xarray
  ice: add helpers for Global RSS LUT alloc, free, vsi_update
  ice: rename ICE_MAX_RSS_QS_PER_VF to ICE_MAX_QS_PER_VF_VCV1
  ice: bump to 256qs for VF
  iavf: extend iavf_configure_queues() to support more queues
  iavf: temporary rename of IAVF_MAX_REQ_QUEUES to
    IAVF_MAX_REQ_QUEUES_VCV1
  iavf: increase max number of queues to 256
  devlink: give user option to allocate resources
  ice: represent RSS LUTs as devlink resources
  ice: support up to 256 VF queues

 .../networking/devlink/devlink-resource.rst   |   5 +
 .../networking/devlink/devlink-shared.rst     |  19 +-
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  21 +-
 .../net/ethernet/intel/iavf/iavf_register.h   |   4 +-
 .../net/ethernet/intel/ice/devlink/devlink.h  |   2 +-
 .../net/ethernet/intel/ice/devlink/resource.h |  26 +
 drivers/net/ethernet/intel/ice/ice.h          |   3 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  52 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_lag.h      |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   5 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  36 +-
 drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
 drivers/net/ethernet/intel/ice/virt/rss.h     |   1 +
 .../net/ethernet/intel/ice/virt/virtchnl.h    |   4 +
 include/linux/net/intel/virtchnl.h            | 136 +++-
 include/net/devlink.h                         |  37 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   3 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 134 +++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 334 ++++++++-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  11 +-
 .../net/ethernet/intel/ice/devlink/resource.c | 644 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 107 ++-
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 103 +--
 drivers/net/ethernet/intel/ice/ice_lag.c      |   6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 178 +++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  60 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  15 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  41 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  69 +-
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 468 +++++++++++--
 drivers/net/ethernet/intel/ice/virt/rss.c     |  37 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  42 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |   6 +-
 net/devlink/resource.c                        |  88 ++-
 net/devlink/sh_dev.c                          |  57 +-
 41 files changed, 2478 insertions(+), 296 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c

-- 
2.51.1

