Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BF9CA5FE4
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 04:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C378180EC2;
	Sun,  4 Oct 2026 04:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lET7dttib3ag; Sun,  4 Oct 2026 04:28:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6638480E8E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791088138;
	b=iVLVFu9BjYjw+BU4JjP0Xo/WU4g/6nrLcLXHdbNM2iC7EtJL+sw5WvfTth1W08m2QoYt
	 wqO//p3cqkU+n0WJTELHA8a79dJVAaHGdPrU9iYt1iVVN9IF7H16Rj/XJr1KGZyNThrGD
	 FYqa3ktegM28zPv9ruXsvaqmzZgxbBb7iZ8gc0Kndta/t0bqSt88IMtrzryyI2IAqNkTD
	 Wz2hCijoJG6RmsjE2nfJGYU5GHAivbwI8atmrrgtyKl+z+UIG2qHdqVqfrZLat6YpeJvG
	 QaBBAKAd08A51sNQBBFpl8u/QVTSm0ZENgeV9N1TSRRmzq/NOKedOJ0VuFIXhYNmpYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791088138;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=egUOjyplxj65rVieBVNuT2DseLkoWJCALtTpIO7/0HU=;
	b=fgISgeA4bmwg5AFSuns8UFgbDe3igSBR5Y3qVPVGytsPU/7YUdUtSO9bdmxMMUnLWS9S
	 r1Ly4jxGQLr0vzd0ACo0be7evQG6xTmhGQAInve45ImXRXdhBQ6KWuSaTS1UQKps0mfkQ
	 1Vqoy/JQ0IUT1QnDBhTm4Wc2G/BOX1VAnpVbda59ouhIi2DRnXujeQQSdUpiJSrLE+f9k
	 KlrqQVfC3sI3XRBv22ikPH8PRmnWcq1aFcB4SdU9vezOekOGgu5oBdmGwo+8sA9zctnT4
	 4L3BQY8XPbEd1RdDx43Hw2cjfLOPSTOcmjZPiTTjfn48CndT6KmAhWEZgMU3ji1dUqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791088138;
	bh=egUOjyplxj65rVieBVNuT2DseLkoWJCALtTpIO7/0HU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VAWUrA5y4GCUFpEkBCzRIiKHj9jc7o2GxpJ7xZuX+L6la7Lnfpb0ZbaCI6JWn9sIf
	 RRpN8pxJyEhWTL2jitm4JmG2IzhvVvVXiRDxV1BlDLZmp1J1yIo7IhbK/CBMntpSxY
	 8HgBYjiGoX7agdu0lUDXkmBIvXjtaj0t27c4IbArncDcwwvjnlJOkwHAt2NqpNjG5I
	 HnHp6g3NkDnFgSZPd3gN2JEaF9UuoTDqKNdJ60vTJaZqjFsFAkpfl1+d7D+HjG7Gfw
	 kT1O87542bh83nzh3baV9YtSE7L1vNC0Xh3E/GaVxKzukBOsB0TchDgmyueH1rYY6a
	 jhR8a5gKnQQYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6638480E8E;
	Sun,  4 Oct 2026 04:28:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54E861D2
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 04:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33D1540A4A
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 04:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eA9mpdUs7fuN for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 04:28:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CD9A340A48
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791088131;
 b=VJbHxZu0+656uZ6lgXpVxIEKqEQK+zM2Agqt/cQSQXy18mQYZ1vcMd+TQJsiemDe55gO
 24C2th2HWDzqQ1RhY+rqyS7Dxti690goWczB0ZNdXTeDDjoNYIrfCEvTbonm+T/0Sc8dC
 MlVjsVSkcox07moVIwZVvSNmXLnBfAMEEmOMXiFf64dSzxr8XuBwjIQztXtYH0nBbtKBz
 F94Vj+gvOESdXyARUQVJtMUbbRN3px6ucWonY8YwKrxoiP5zo6aU3Eds6Lb3pK/gNMPWo
 WWnTSo0FPfYlikwkKkfmU2J+2rEJUQ8T1HsDDqIDkZB/toQmmKgX05A+dmJmTxlKnmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791088131;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=egUOjyplxj65rVieBVNuT2DseLkoWJCALtTpIO7/0HU=;
 b=npigr5yl9MItiZg5yY5rpbo5is7ehxvGrlw0icrHDDg7MT1stxzCnFYB96y9K/yeQgc4
 NaZNdIpQzT2O6SlYcT7/LA0+hEUyHw8Q8DGVppHh/OYTr/g3cuM686GL5mJaD8XrxOecZ
 8jW73gvHO+lyTX7IPselWtHkkTq5CeR42hoGNm2BV9BP5MRJvcVW1HinlnQnkWRNsDln8
 6O3ac1D35KFFFtkDjpQ5Fq1gP50pQmkVSsgdJsXpGhCuKmmR01GiUPDv/I02WeUTkKsqB
 BwEMjnfd/vwWtOjgSnYK/OQAhebhcTWsjEdRY2lVoZog1bbZDBKNwbOXmi30nedrQHQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ktPcnc03; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ktPcnc03
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD9A340A48
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 04:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791088131; x=1822624131; h=date:from:to:subject:message-id;
 bh=07y3LxzHQ+ugSOwYeiIFX6q3FQF6HRrpy43cpIAQgWg=;
 b=ktPcnc03XHh6uXqeqvXXgTO5uJgULRBkljW9O8EQDUQ4cWA2VhZkdgsW
 3XLES0JDekmnvcsDVCZeneiJNAI4M2AOmfzcBMHNpKFDsOmhuntLJwdRm
 GoFPI7DP+S5U6wiZ/Xx9pnC51OKA+7u2QjSzbJ/0yS2IxI+DPKEUiWWOa
 KNx/4Hv0PEK/D9DcNjc+Oqx069k9BNNGti33OZuSBRpdlGeDQXjzaAKtp
 fGMNswdBkRJ0xN5fVYwgNqfQBcpIgLLCB9YVD/YObeCYhcsGS/bIZdaE+
 SuTz0ecbfm0dbMMdGJRxSpsowj35/A3UoHmj9xeqnPbxlb9tuXx3oCAfN g==;
X-CSE-ConnectionGUID: iPIcydVIRzWutfvditPeIw==
X-CSE-MsgGUID: XA+R9tlhT+epl9t1KwONhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="94283047"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; d="scan'208";a="94283047"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2026 21:28:48 -0700
X-CSE-ConnectionGUID: 2ExAz7S9Rau8F3VFuJMNIw==
X-CSE-MsgGUID: FqhYy83XQ+qIRc6uVm77vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; d="scan'208";a="275725224"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa010.fm.intel.com with ESMTP; 03 Oct 2026 21:28:47 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xDDq8-00000000USJ-1XQQ;
 Sun, 04 Oct 2026 04:28:44 +0000
Date: Sun, 04 Oct 2026 12:28:21 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:10GbE] BUILD SUCCESS WITH WARNING
 f49defea7668d8c68ec19fa085ef3da6075561c7
Message-ID: <202610041217.kgX4xt6l-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: f49defea7668d8c68ec19fa085ef3da6075561c7  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202609101851.WU5XzlC6-lkp@intel.com

    arch/arm/boot/dts/ti/omap/am3517-craneboard.dtb: am35x_otg_hs@0 (ti,omap3-musb): $nodename:0: 'am35x_otg_hs@0' does not match '^usb(@.*)?'

Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-2400-20261002
|   |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|-- arm-randconfig-2401-20261002
|   |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|-- arm-randconfig-2402-20261002
|   |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|-- arm-randconfig-2403-20261002
|   |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
`-- arm-randconfig-2404-20261002
    |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
    |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
    `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)

elapsed time: 1381m

configs tested: 466
configs skipped: 30

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2102-20261002    gcc-16.1.0 cocci
alpha                randconfig-r2202-20261002    gcc-10.5.0 smatch
alpha                randconfig-r2301-20261002    gcc-8.5.0  sparse
alpha                randconfig-r2305-20261002    gcc-16.1.0 sparse
alpha                randconfig-r2307-20261002    gcc-13.4.0 sparse
arc                               alldefconfig    clang-24
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                  nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20261003    clang-17
arc                   randconfig-1000-20261004    clang-22
arc                   randconfig-1001-20261003    clang-17
arc                   randconfig-1001-20261004    clang-22
arc                  randconfig-r2100-20261002    gcc-16.1.0 cocci
arc                  randconfig-r2300-20261002    clang-24   sparse
arc                  randconfig-r2305-20261002    clang-24   sparse
arc                  randconfig-r2308-20261002    gcc-14.3.0 sparse
arc                  randconfig-r2309-20261002    clang-20   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                           collie_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           ixp4xx_defconfig    clang-24
arm                       jornada720_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                              pxa_defconfig    clang-24
arm                             qcom_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261003    clang-17
arm                   randconfig-1000-20261004    clang-22
arm                   randconfig-1001-20261003    clang-17
arm                   randconfig-1001-20261004    clang-22
arm                   randconfig-1002-20261003    clang-17
arm                   randconfig-1002-20261004    clang-22
arm                   randconfig-1003-20261003    clang-17
arm                   randconfig-1003-20261004    clang-22
arm                  randconfig-r2100-20261002    clang-20   cocci
arm                  randconfig-r2106-20261002    clang-17   cocci
arm                  randconfig-r2106-20261002    clang-24   cocci
arm                  randconfig-r2106-20261002    gcc-16.1.0 cocci
arm                  randconfig-r2200-20261002    gcc-8.5.0  smatch
arm                  randconfig-r2202-20261002    clang-24   smatch
arm                  randconfig-r2302-20261002    clang-17   sparse
arm                  randconfig-r2308-20261002    clang-24   sparse
arm                          s3c6400_defconfig    gcc-16.1.0
arm                          socfpga_defconfig    clang-24
arm                     vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261003    gcc-9.5.0
arm64                 randconfig-1000-20261004    gcc-16.1.0
arm64                 randconfig-1001-20261003    gcc-9.5.0
arm64                 randconfig-1001-20261004    gcc-16.1.0
arm64                 randconfig-1002-20261003    gcc-9.5.0
arm64                 randconfig-1002-20261004    gcc-16.1.0
arm64                 randconfig-1003-20261003    gcc-9.5.0
arm64                 randconfig-1003-20261004    gcc-16.1.0
arm64                randconfig-r2101-20261002    gcc-14     cocci
arm64                randconfig-r2101-20261002    gcc-8.5.0  cocci
arm64                randconfig-r2102-20261002    clang-24   cocci
arm64                randconfig-r2102-20261002    gcc-12.5.0 cocci
arm64                randconfig-r2103-20261002    clang-24   cocci
arm64                randconfig-r2104-20261002    clang-17   cocci
arm64                randconfig-r2105-20261002    clang-24   cocci
arm64                randconfig-r2105-20261002    gcc-14.3.0 cocci
arm64                randconfig-r2107-20261002    clang-24   cocci
arm64                randconfig-r2304-20261002    gcc-10.5.0 sparse
arm64                randconfig-r2305-20261002    gcc-10.5.0 sparse
arm64                randconfig-r2307-20261002    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261003    gcc-9.5.0
csky                  randconfig-1000-20261004    gcc-16.1.0
csky                  randconfig-1001-20261003    gcc-9.5.0
csky                  randconfig-1001-20261004    gcc-16.1.0
csky                 randconfig-r2101-20261002    gcc-16.1.0 cocci
csky                 randconfig-r2107-20261002    gcc-14     cocci
csky                 randconfig-r2301-20261002    gcc-16.1.0 sparse
csky                 randconfig-r2306-20261002    gcc-16.1.0 sparse
csky                 randconfig-r2309-20261002    gcc-14.3.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261003    gcc-16.1.0
hexagon               randconfig-1000-20261004    gcc-16.1.0
hexagon               randconfig-1001-20261003    gcc-16.1.0
hexagon               randconfig-1001-20261004    gcc-16.1.0
hexagon              randconfig-r2103-20261002    gcc-16.1.0 cocci
hexagon              randconfig-r2202-20261002    clang-18   smatch
hexagon              randconfig-r2302-20261002    gcc-16.1.0 sparse
hexagon              randconfig-r2307-20261002    clang-21   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261003    gcc-14
i386        buildonly-randconfig-1000-20261004    clang-22
i386        buildonly-randconfig-1001-20261003    gcc-14
i386        buildonly-randconfig-1001-20261004    clang-22
i386        buildonly-randconfig-1002-20261003    gcc-14
i386        buildonly-randconfig-1002-20261004    clang-22
i386        buildonly-randconfig-1003-20261003    gcc-14
i386        buildonly-randconfig-1003-20261004    clang-22
i386        buildonly-randconfig-1004-20261003    gcc-14
i386        buildonly-randconfig-1004-20261004    clang-22
i386        buildonly-randconfig-1005-20261003    gcc-14
i386        buildonly-randconfig-1005-20261004    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261003    gcc-14
i386                  randconfig-1000-20261004    gcc-14
i386                  randconfig-1001-20261003    gcc-14
i386                  randconfig-1001-20261004    gcc-14
i386                  randconfig-1002-20261003    gcc-14
i386                  randconfig-1002-20261004    gcc-14
i386                  randconfig-1003-20261003    gcc-14
i386                  randconfig-1003-20261004    gcc-14
i386                  randconfig-1004-20261003    gcc-14
i386                  randconfig-1004-20261004    gcc-14
i386                  randconfig-1005-20261003    gcc-14
i386                  randconfig-1005-20261004    gcc-14
i386                  randconfig-1006-20261003    gcc-14
i386                  randconfig-1006-20261004    gcc-14
i386                  randconfig-1007-20261003    gcc-14
i386                  randconfig-1007-20261004    clang-22
i386                  randconfig-1008-20261003    gcc-14
i386                  randconfig-1008-20261004    clang-22
i386                  randconfig-1009-20261003    gcc-14
i386                  randconfig-1009-20261004    clang-22
i386                  randconfig-1010-20261003    gcc-14
i386                  randconfig-1010-20261004    clang-22
i386                  randconfig-1011-20261003    gcc-14
i386                  randconfig-1011-20261004    clang-22
i386                  randconfig-1012-20261003    gcc-14
i386                  randconfig-1012-20261004    clang-22
i386                  randconfig-1013-20261003    gcc-14
i386                  randconfig-1013-20261004    clang-22
i386                  randconfig-2100-20261002    gcc-14     cocci
i386                  randconfig-2101-20261002    clang-22   cocci
i386                  randconfig-2101-20261002    gcc-14     cocci
i386                  randconfig-2102-20261002    gcc-14     cocci
i386                  randconfig-2103-20261002    gcc-14     cocci
i386                  randconfig-2200-20261002    gcc-14     smatch
i386                  randconfig-2300-20261002    clang-22   sparse
i386                  randconfig-2300-20261002    gcc-12     sparse
i386                  randconfig-2301-20261002    gcc-12     sparse
i386                  randconfig-2301-20261002    gcc-14     sparse
i386                  randconfig-2302-20261002    gcc-12     sparse
i386                  randconfig-2302-20261002    gcc-14     sparse
i386                 randconfig-r2104-20261002    gcc-14.3.0 cocci
i386                 randconfig-r2106-20261002    clang-24   cocci
i386                 randconfig-r2201-20261002    gcc-14     smatch
i386                 randconfig-r2301-20261002    gcc-10.5.0 sparse
i386                 randconfig-r2304-20261002    clang-22   sparse
i386                 randconfig-r2308-20261002    gcc-12.5.0 sparse
i386                 randconfig-r2309-20261002    gcc-13.4.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261003    gcc-16.1.0
loongarch             randconfig-1000-20261004    gcc-16.1.0
loongarch             randconfig-1001-20261003    gcc-16.1.0
loongarch             randconfig-1001-20261004    gcc-16.1.0
loongarch            randconfig-r2103-20261002    gcc-16.1.0 cocci
loongarch            randconfig-r2200-20261002    gcc-16.1.0 smatch
loongarch            randconfig-r2202-20261002    gcc-16.1.0 smatch
loongarch            randconfig-r2301-20261002    clang-24   sparse
loongarch            randconfig-r2303-20261002    clang-24   sparse
loongarch            randconfig-r2304-20261002    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2100-20261002    gcc-14     cocci
m68k                 randconfig-r2101-20261002    gcc-13.4.0 cocci
m68k                 randconfig-r2103-20261002    clang-17   cocci
m68k                 randconfig-r2106-20261002    gcc-12.5.0 cocci
m68k                 randconfig-r2302-20261002    gcc-16.1.0 sparse
m68k                 randconfig-r2303-20261002    gcc-10.5.0 sparse
m68k                 randconfig-r2306-20261002    gcc-13.4.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2102-20261002    clang-22   cocci
microblaze           randconfig-r2102-20261002    gcc-11.5.0 cocci
microblaze           randconfig-r2200-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2201-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2202-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2303-20261002    gcc-16.1.0 sparse
microblaze           randconfig-r2304-20261002    gcc-8.5.0  sparse
microblaze           randconfig-r2306-20261002    gcc-12.5.0 sparse
microblaze           randconfig-r2308-20261002    clang-22   sparse
microblaze           randconfig-r2308-20261002    gcc-13.4.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                            ip32_defconfig    gcc-16.1.0
mips                 malta_qemu_32r6_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20261002    gcc-16.1.0 cocci
mips                 randconfig-r2105-20261002    clang-17   cocci
mips                 randconfig-r2106-20261002    gcc-14.3.0 cocci
mips                 randconfig-r2201-20261002    gcc-15.2.0 smatch
mips                 randconfig-r2300-20261002    gcc-10.5.0 sparse
mips                 randconfig-r2303-20261002    clang-22   sparse
mips                 randconfig-r2303-20261002    gcc-8.5.0  sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261003    gcc-16.1.0
nios2                 randconfig-1000-20261004    gcc-16.1.0
nios2                 randconfig-1001-20261003    gcc-16.1.0
nios2                 randconfig-1001-20261004    gcc-16.1.0
nios2                randconfig-r2100-20261002    gcc-8.5.0  cocci
nios2                randconfig-r2101-20261002    clang-17   cocci
nios2                randconfig-r2300-20261002    gcc-8.5.0  sparse
nios2                randconfig-r2306-20261002    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2104-20261002    gcc-14     cocci
openrisc             randconfig-r2303-20261002    gcc-16.1.0 sparse
openrisc             randconfig-r2306-20261002    gcc-10.5.0 sparse
openrisc             randconfig-r2308-20261002    gcc-13.4.0 sparse
openrisc             randconfig-r2308-20261002    gcc-14.3.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-32bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20261003    gcc-11.5.0
parisc                randconfig-1000-20261004    gcc-12.5.0
parisc                randconfig-1001-20261003    gcc-11.5.0
parisc                randconfig-1001-20261004    gcc-12.5.0
parisc               randconfig-r2104-20261002    gcc-16.1.0 cocci
parisc               randconfig-r2107-20261002    gcc-12.5.0 cocci
parisc               randconfig-r2304-20261002    gcc-16.1.0 sparse
parisc               randconfig-r2307-20261002    clang-22   sparse
parisc64                          alldefconfig    gcc-16.1.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc                      powernv_defconfig    clang-24
powerpc               randconfig-1000-20261003    gcc-11.5.0
powerpc               randconfig-1000-20261004    gcc-12.5.0
powerpc               randconfig-1001-20261003    gcc-11.5.0
powerpc               randconfig-1001-20261004    gcc-12.5.0
powerpc              randconfig-r2102-20261002    clang-17   cocci
powerpc              randconfig-r2104-20261002    clang-24   cocci
powerpc              randconfig-r2302-20261002    gcc-10.5.0 sparse
powerpc64             randconfig-1000-20261003    gcc-11.5.0
powerpc64             randconfig-1000-20261004    gcc-12.5.0
powerpc64             randconfig-1001-20261003    gcc-11.5.0
powerpc64             randconfig-1001-20261004    gcc-12.5.0
powerpc64            randconfig-r2100-20261002    clang-22   cocci
powerpc64            randconfig-r2100-20261002    clang-24   cocci
powerpc64            randconfig-r2101-20261002    clang-24   cocci
powerpc64            randconfig-r2107-20261002    gcc-14.3.0 cocci
powerpc64            randconfig-r2201-20261002    clang-24   smatch
powerpc64            randconfig-r2302-20261002    gcc-8.5.0  sparse
powerpc64            randconfig-r2305-20261002    gcc-16.1.0 sparse
powerpc64            randconfig-r2309-20261002    clang-22   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261003    gcc-12.5.0
riscv                 randconfig-1000-20261004    gcc-11.5.0
riscv                 randconfig-1001-20261003    gcc-12.5.0
riscv                 randconfig-1001-20261004    gcc-11.5.0
riscv                 randconfig-2000-20261002    gcc-9.5.0
riscv                 randconfig-2001-20261002    gcc-9.5.0
riscv                randconfig-r2101-20261002    clang-24   cocci
riscv                randconfig-r2103-20261002    clang-22   cocci
riscv                randconfig-r2103-20261002    gcc-14     cocci
riscv                randconfig-r2300-20261002    clang-22   sparse
riscv                randconfig-r2300-20261002    gcc-16.1.0 sparse
riscv                randconfig-r2302-20261002    clang-24   sparse
riscv                randconfig-r2306-20261002    gcc-14.3.0 sparse
riscv                randconfig-r2309-20261002    gcc-12.5.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261003    gcc-12.5.0
s390                  randconfig-1000-20261004    gcc-11.5.0
s390                  randconfig-1001-20261003    gcc-12.5.0
s390                  randconfig-1001-20261004    gcc-11.5.0
s390                  randconfig-2000-20261002    gcc-9.5.0
s390                  randconfig-2001-20261002    gcc-9.5.0
s390                 randconfig-r2100-20261002    clang-17   cocci
s390                 randconfig-r2101-20261002    clang-22   cocci
s390                 randconfig-r2107-20261002    clang-24   cocci
s390                 randconfig-r2309-20261002    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261003    gcc-12.5.0
sh                    randconfig-1000-20261004    gcc-11.5.0
sh                    randconfig-1001-20261003    gcc-12.5.0
sh                    randconfig-1001-20261004    gcc-11.5.0
sh                    randconfig-2000-20261002    gcc-9.5.0
sh                    randconfig-2001-20261002    gcc-9.5.0
sh                   randconfig-r2107-20261002    clang-17   cocci
sh                   randconfig-r2200-20261002    gcc-10.5.0 smatch
sh                   randconfig-r2201-20261002    gcc-12.5.0 smatch
sh                   randconfig-r2307-20261002    gcc-12.5.0 sparse
sh                            se7724_defconfig    gcc-16.1.0
sh                      sh7710voipgw_defconfig    gcc-16.1.0
sh                         sh7785lcr_defconfig    gcc-16.1.0
sparc                             alldefconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261003    clang-17
sparc                 randconfig-1000-20261004    gcc-14
sparc                 randconfig-1001-20261003    clang-17
sparc                 randconfig-1001-20261004    gcc-14
sparc                 randconfig-2000-20261002    clang-24
sparc                 randconfig-2001-20261002    clang-24
sparc                randconfig-r2102-20261002    gcc-8.5.0  cocci
sparc                randconfig-r2103-20261002    gcc-13.4.0 cocci
sparc                randconfig-r2103-20261002    gcc-8.5.0  cocci
sparc                randconfig-r2107-20261002    gcc-16.1.0 cocci
sparc                randconfig-r2201-20261002    gcc-8.5.0  smatch
sparc                randconfig-r2301-20261002    clang-22   sparse
sparc                randconfig-r2305-20261002    gcc-8.5.0  sparse
sparc                randconfig-r2308-20261002    clang-24   sparse
sparc                randconfig-r2309-20261002    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261003    clang-17
sparc64               randconfig-1000-20261004    gcc-14
sparc64               randconfig-1001-20261003    clang-17
sparc64               randconfig-1001-20261004    gcc-14
sparc64               randconfig-2000-20261002    clang-24
sparc64               randconfig-2001-20261002    clang-24
sparc64              randconfig-r2104-20261002    gcc-12.5.0 cocci
sparc64              randconfig-r2105-20261002    clang-24   cocci
sparc64              randconfig-r2105-20261002    gcc-12.5.0 cocci
sparc64              randconfig-r2105-20261002    gcc-16.1.0 cocci
sparc64              randconfig-r2106-20261002    gcc-14     cocci
sparc64              randconfig-r2200-20261002    gcc-15.2.0 smatch
sparc64              randconfig-r2304-20261002    gcc-16.1.0 sparse
sparc64              randconfig-r2305-20261002    clang-22   sparse
sparc64              randconfig-r2306-20261002    clang-20   sparse
sparc64              randconfig-r2308-20261002    clang-20   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261003    clang-17
um                    randconfig-1000-20261004    gcc-14
um                    randconfig-1001-20261003    clang-17
um                    randconfig-1001-20261004    gcc-14
um                    randconfig-2000-20261002    clang-24
um                    randconfig-2001-20261002    clang-24
um                   randconfig-r2100-20261002    clang-24   cocci
um                   randconfig-r2200-20261002    gcc-14     smatch
um                   randconfig-r2307-20261002    clang-19   sparse
um                   randconfig-r2307-20261002    gcc-14.3.0 sparse
um                   randconfig-r2309-20261002    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261003    clang-22
x86_64      buildonly-randconfig-1000-20261004    gcc-14
x86_64      buildonly-randconfig-1001-20261003    clang-22
x86_64      buildonly-randconfig-1001-20261004    gcc-14
x86_64      buildonly-randconfig-1002-20261003    clang-22
x86_64      buildonly-randconfig-1002-20261004    gcc-14
x86_64      buildonly-randconfig-1003-20261003    clang-22
x86_64      buildonly-randconfig-1003-20261004    gcc-14
x86_64      buildonly-randconfig-1004-20261003    clang-22
x86_64      buildonly-randconfig-1004-20261004    gcc-14
x86_64      buildonly-randconfig-1005-20261003    clang-22
x86_64      buildonly-randconfig-1005-20261004    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261003    clang-22
x86_64                randconfig-1000-20261004    gcc-14
x86_64                randconfig-1001-20261003    clang-22
x86_64                randconfig-1001-20261004    gcc-14
x86_64                randconfig-1002-20261003    clang-22
x86_64                randconfig-1002-20261004    gcc-14
x86_64                randconfig-1003-20261003    clang-22
x86_64                randconfig-1003-20261004    gcc-14
x86_64                randconfig-1004-20261003    clang-22
x86_64                randconfig-1004-20261004    gcc-14
x86_64                randconfig-1005-20261003    clang-22
x86_64                randconfig-1005-20261004    gcc-14
x86_64                randconfig-1006-20261003    clang-22
x86_64                randconfig-1006-20261004    clang-22
x86_64                randconfig-1007-20261003    clang-22
x86_64                randconfig-1007-20261004    clang-22
x86_64                randconfig-1008-20261003    clang-22
x86_64                randconfig-1008-20261004    clang-22
x86_64                randconfig-1009-20261003    clang-22
x86_64                randconfig-1009-20261004    clang-22
x86_64                randconfig-1010-20261003    clang-22
x86_64                randconfig-1010-20261004    clang-22
x86_64                randconfig-1011-20261003    clang-22
x86_64                randconfig-1011-20261004    clang-22
x86_64                randconfig-1012-20261003    clang-22
x86_64                randconfig-1013-20261003    clang-22
x86_64                randconfig-1014-20261003    clang-22
x86_64                randconfig-1015-20261003    clang-22
x86_64                randconfig-1016-20261003    clang-22
x86_64                randconfig-1017-20261003    clang-22
x86_64                randconfig-2100-20261002    gcc-14     cocci
x86_64                randconfig-2101-20261002    gcc-14     cocci
x86_64                randconfig-2102-20261002    clang-22   cocci
x86_64                randconfig-2102-20261002    gcc-14     cocci
x86_64                randconfig-2103-20261002    clang-22   cocci
x86_64                randconfig-2103-20261002    gcc-14     cocci
x86_64                randconfig-2200-20261002    clang-22   smatch
x86_64                randconfig-2200-20261003    gcc-14     smatch
x86_64                randconfig-2300-20261002    gcc-12     sparse
x86_64                randconfig-2300-20261002    gcc-14     sparse
x86_64                randconfig-2301-20261002    gcc-12     sparse
x86_64                randconfig-2301-20261002    gcc-14     sparse
x86_64                randconfig-2302-20261002    gcc-12     sparse
x86_64               randconfig-r2101-20261002    gcc-14     cocci
x86_64               randconfig-r2101-20261002    gcc-16.1.0 cocci
x86_64               randconfig-r2102-20261002    gcc-14     cocci
x86_64               randconfig-r2105-20261002    gcc-14     cocci
x86_64               randconfig-r2107-20261002    clang-22   cocci
x86_64               randconfig-r2201-20261002    gcc-14     smatch
x86_64               randconfig-r2301-20261002    gcc-16.1.0 sparse
x86_64               randconfig-r2306-20261002    clang-22   sparse
x86_64               randconfig-r2306-20261002    clang-24   sparse
x86_64               randconfig-r2308-20261002    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261003    clang-17
xtensa                randconfig-1000-20261004    gcc-14
xtensa                randconfig-1001-20261003    clang-17
xtensa                randconfig-1001-20261004    gcc-14
xtensa                randconfig-2000-20261002    clang-24
xtensa                randconfig-2001-20261002    clang-24
xtensa               randconfig-r2103-20261002    gcc-10.5.0 cocci
xtensa               randconfig-r2300-20261002    gcc-16.1.0 sparse
xtensa               randconfig-r2302-20261002    clang-22   sparse
xtensa               randconfig-r2307-20261002    clang-20   sparse
xtensa               randconfig-r2309-20261002    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
