Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75BECA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 01:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 745FE60638;
	Sun, 11 Oct 2026 01:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TY15ontGB2Z2; Sun, 11 Oct 2026 01:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CBF660677
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791680640;
	b=QPOi+B5QMN7yfeuEYrQS5G0XIkbye4F+W8aESFA6s3A2H8ksSs/rEQS6w06zrydZ4VeB
	 2s69rRXcJRzRBINB0+2lbbzSB2QNftN7/qT3zZKRREXjIQqIHeAOGh/5+CNsSY1dM2MPS
	 XqqPYrrCzj8VFBq6vrrxQjF7G944+Yoh4cR/4LNsX6j94LPgH/pSg8X2lJrb1x559QaEs
	 FFCWc5Om6wo4bcfQO21oF2P1o326VbqWANsn8+ITteBptFeS705TBFSXWlaGoZbUrzwNh
	 fsXkrZdftI/ZxT3xigE0DviuaPb1l013gcF0ce13r3slgd6E6VZW6N+2WhkNmS5vUsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791680640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ES1CghXWbtLACAxddslCOZ7K9Q9iodYYJNnfjDd4gek=;
	b=UIWvSdU+EoyRhEn1q/IxZCra9RL2m10KzLnTmWpaXe+jqm9ubM4QEEgZ3YdTHg0C1/6R
	 vW98CF4ZMzZDFTyI0JEsRvE9vOyp4tkq1H1h7OfgnkkIRKgcqqqGwYE7IHEg8HM1eg5rp
	 +2FLsarM8PK+loCOWN9ZZqIWTQIypJPHshsBzD1TloyBLWGLvqa46erO3w//LjYFElOsZ
	 stQghpMMhgilqtSTeUE3P2WqFvFx2e/1Ek5EOB6ba5r+EA26Kc4ywBz+I3KaPYT5acuOb
	 SCbYyd+/xdLU5uWs5itY/iqU5aU1S6+Bhe3XIXVpLeQAVdksr6V1qNLGD/nR9kk5Ydw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791680640;
	bh=ES1CghXWbtLACAxddslCOZ7K9Q9iodYYJNnfjDd4gek=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Tc81TEiHQXYkpPyeB1RrFUsnmVxzGvOhSlHjRjhcfaRw6yotX/En2iQRb/4ajOvoi
	 ndklmKCkafMdHEsNR8og4tVZg+ETu8yHkg9xEoyQpfvHftrsIAqpAzR8zgPcbuH23a
	 jeHNA7L+5N8UrVIKBR5TeJ0Q/B2AQk6KFZsalJmV/cNV6WzVUiOh8Uc4WOtrCPRMEI
	 M23FxzBE+eg7Q6pHCfDJBr/LJSbZ7zTfcw9EPiio5hv4+XR9LiIFAL9k320pisGxIL
	 bNgqcf8seQu17QXB4udblbIJFL4yRcHkzCSW8MSqwSsqrCB3/IpAEKUBFS7QEnPmkO
	 V3scFKyukDVOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CBF660677;
	Sun, 11 Oct 2026 01:04:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE81105
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 01:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7BF580D88
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 01:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqCHyoOGUVCJ for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 01:03:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5AA8A80D86
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791680636;
 b=R/bt4Uzd4rmKhG5fTXy7+7PJEGljGMtS/jYLND2yYIetEeCA7A0TvEPaO8l0nSKVRuqI
 oeXVCaBUMsCcLSIzi87PWYNKKgnFY7fqwa0qGjn4rll9hIOBcmKpvZPGB+xcADhTjeCrm
 FzWzNGi3WHIhljaYu1ScmTmnniEoodkyKoDUW+JN7bUarUS7/itnbVb9GJnULsYtz7Dhr
 TfwyTJSsVz+dVL+HzYb9WWDL7gWAQLIQvx7zSiO7Jr11qeFnD1V4pnjpOOH8LC2CUezeo
 lvnoz7zc4POBDkC7+QXd2yz1w1gGsRT536e+cEFd+10HLC+MuMooP2vRm1diDhH2c9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791680636;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=ES1CghXWbtLACAxddslCOZ7K9Q9iodYYJNnfjDd4gek=;
 b=DZeiC02xUfZBaVXgpJfR73OodF/OE94ZOngvjBRzOkcjS4uSW4ra5igkrkPWzNaD5Q3H
 TnoEQ5Fz1KKc1rZbqxlMfy48mpvbe/QKjFweQQf4V32ctG0lIVIihlja9YWo+FMWDUIFn
 D1duGQzY0axCsRSci64A8OWrdYIASRFQel8PzjPrLw54aWA4SnV00YTUTnR5NNEdgo9El
 Efzb6uqxavrF4jp1RMk4VonVQ/vQHuE2j41PYF7/qe3vAyBWfwSFLfHQguOPNYPldWy9Y
 7xzKGcBsI2hMlFZ+L4FnDb098zXkHo4L/GBPc7VUzW9ZDvNdLwcO/T5CDxnF/6BklMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UjL5w2rc; 
 arc=none smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UjL5w2rc
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AA8A80D86
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 01:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791680636; x=1823216636; h=date:from:to:subject:message-id;
 bh=KWEWizX+A8RiBVrAktl8WKOzLNTHmNvsXRHm53vnndQ=;
 b=UjL5w2rcI3hOixE0s/EtmsE2PWGAlYGh5YZ+PkfKBytBLqAyqTJmXXr7
 LIbtct0HEnSp95wyZDmoGEunGA1bjwg+fjpgLBeav4cfgHzHIncY92TIE
 UG0lhdQV7DaDOjJ1s8Vn0uhif2TXbUvxChBzqDH9f14692aXGrqksvnY8
 6vepALRmIbaGObcntUcavx0gs3cW2B7kcOBE+2oM+OTp1OKy+UCUKPxNs
 VuIPkus90NcukhtuqQs8RjJrLn2s6E3PQY1Fyhwx9WYDoBnQmf702e6gT
 1dZOlb/5EIwlk5dsRp4UWJbORP6vOjbT9vaohRIcoroc8PYCjt4DaPHSq A==;
X-CSE-ConnectionGUID: 4pgGrus8SUe6Q7ZeajPw/Q==
X-CSE-MsgGUID: /i0VYiQOS8eVJ9drrNIVCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="315100"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="315100"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 18:03:54 -0700
X-CSE-ConnectionGUID: 1fNvneOMSaGuG24fO/459w==
X-CSE-MsgGUID: 1i58fe+hTO20hr9VyRUZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="774996"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 10 Oct 2026 18:03:53 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xFhyg-00000000ACi-1eXI;
 Sun, 11 Oct 2026 01:03:50 +0000
Date: Sun, 11 Oct 2026 09:03:13 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:main] BUILD SUCCESS WITH WARNING
 d8674294aefef02266c4d47ad10131f1bffbe534
Message-ID: <202610110910.IfNy11sh-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: d8674294aefef02266c4d47ad10131f1bffbe534  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202609101851.WU5XzlC6-lkp@intel.com

    arch/arm/boot/dts/ti/omap/am3517-craneboard.dtb: am35x_otg_hs@0 (ti,omap3-musb): $nodename:0: 'am35x_otg_hs@0' does not match '^usb(@.*)?'

Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-2400-20261009
|   |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|-- arm-randconfig-2401-20261009
|   |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|-- arm-randconfig-2402-20261009
|   |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|-- arm-randconfig-2403-20261009
|   |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
|   |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
|   `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
`-- arm-randconfig-2404-20261009
    |-- arch-arm-boot-dts-ti-omap-am335x-boneblack.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-evmsk.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-guardian.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-pdu001.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-pepper.dtb:lcdc-(ti-am33xx-tilcdc):port-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am335x-sancloud-bbe.dtb:lcdc-(ti-am33xx-tilcdc):port:endpoint:reg-is-a-required-property
    |-- arch-arm-boot-dts-ti-omap-am3517-craneboard.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
    |-- arch-arm-boot-dts-ti-omap-am3517-evm.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)
    `-- arch-arm-boot-dts-ti-omap-omap3-cm-t3517.dtb:am35x_otg_hs-(ti-omap3-musb):nodename:am35x_otg_hs-does-not-match-usb(-.-)

elapsed time: 1227m

configs tested: 583
configs skipped: 37

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261009    clang-18   cocci
alpha                randconfig-r2100-20261009    clang-24   cocci
alpha                randconfig-r2102-20261010    gcc-12.5.0 cocci
alpha                randconfig-r2104-20261009    gcc-9.5.0  cocci
alpha                randconfig-r2107-20261010    gcc-8.5.0  cocci
alpha                randconfig-r2202-20261010    gcc-8.5.0  smatch
alpha                randconfig-r2300-20261009    gcc-8.5.0  sparse
alpha                randconfig-r2303-20261009    gcc-16.1.0 sparse
alpha                randconfig-r2304-20261009    gcc-13.4.0 sparse
alpha                randconfig-r2305-20261009    gcc-8.5.0  sparse
alpha                randconfig-r2305-20261010    gcc-8.5.0  sparse
alpha                randconfig-r2307-20261009    gcc-11.5.0 sparse
alpha                randconfig-r2308-20261009    gcc-11.5.0 sparse
alpha                randconfig-r2308-20261009    gcc-14     sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261010    gcc-8.5.0
arc                   randconfig-1000-20261011    clang-24
arc                   randconfig-1001-20261010    gcc-8.5.0
arc                   randconfig-1001-20261011    clang-24
arc                  randconfig-r2102-20261009    gcc-15.2.0 cocci
arc                  randconfig-r2104-20261009    gcc-14     cocci
arc                  randconfig-r2106-20261009    gcc-15.2.0 cocci
arc                  randconfig-r2107-20261009    gcc-9.5.0  cocci
arc                  randconfig-r2200-20261010    gcc-14.3.0 smatch
arc                  randconfig-r2201-20261009    gcc-16.1.0 smatch
arc                  randconfig-r2202-20261009    gcc-8.5.0  smatch
arc                  randconfig-r2300-20261009    clang-22   sparse
arc                  randconfig-r2300-20261009    gcc-16.1.0 sparse
arc                  randconfig-r2302-20261009    gcc-11.5.0 sparse
arc                  randconfig-r2302-20261009    gcc-8.5.0  sparse
arc                  randconfig-r2303-20261009    gcc-8.5.0  sparse
arc                  randconfig-r2305-20261010    clang-17   sparse
arc                  randconfig-r2307-20261010    clang-22   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           moxart_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261010    gcc-8.5.0
arm                   randconfig-1000-20261011    clang-24
arm                   randconfig-1001-20261010    gcc-8.5.0
arm                   randconfig-1001-20261011    clang-24
arm                   randconfig-1002-20261010    gcc-8.5.0
arm                   randconfig-1002-20261011    clang-24
arm                   randconfig-1003-20261010    gcc-8.5.0
arm                   randconfig-1003-20261011    clang-24
arm                  randconfig-r2102-20261009    gcc-14     cocci
arm                  randconfig-r2105-20261009    gcc-9.5.0  cocci
arm                  randconfig-r2105-20261010    gcc-8.5.0  cocci
arm                  randconfig-r2106-20261009    clang-17   cocci
arm                  randconfig-r2107-20261009    gcc-15.2.0 cocci
arm                  randconfig-r2200-20261009    clang-24   smatch
arm                  randconfig-r2202-20261009    clang-24   smatch
arm                  randconfig-r2301-20261009    gcc-16.1.0 sparse
arm                  randconfig-r2302-20261009    gcc-10.5.0 sparse
arm                  randconfig-r2303-20261010    gcc-8.5.0  sparse
arm                  randconfig-r2305-20261009    gcc-11.5.0 sparse
arm                  randconfig-r2306-20261009    clang-24   sparse
arm                  randconfig-r2306-20261010    gcc-14     sparse
arm                  randconfig-r2307-20261009    clang-24   sparse
arm                        spear13xx_defconfig    gcc-16.1.0
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261010    gcc-10.5.0
arm64                 randconfig-1001-20261010    gcc-10.5.0
arm64                 randconfig-1002-20261010    gcc-10.5.0
arm64                 randconfig-1003-20261010    gcc-10.5.0
arm64                randconfig-r2101-20261010    gcc-10.5.0 cocci
arm64                randconfig-r2102-20261009    gcc-11.5.0 cocci
arm64                randconfig-r2104-20261009    gcc-8.5.0  cocci
arm64                randconfig-r2104-20261009    gcc-9.5.0  cocci
arm64                randconfig-r2104-20261010    gcc-14     cocci
arm64                randconfig-r2105-20261009    clang-24   cocci
arm64                randconfig-r2107-20261009    gcc-9.5.0  cocci
arm64                randconfig-r2202-20261009    gcc-10.5.0 smatch
arm64                randconfig-r2301-20261010    gcc-15.2.0 sparse
arm64                randconfig-r2303-20261009    gcc-10.5.0 sparse
arm64                randconfig-r2304-20261009    clang-24   sparse
arm64                randconfig-r2304-20261010    gcc-16.1.0 sparse
arm64                randconfig-r2305-20261009    gcc-10.5.0 sparse
arm64                randconfig-r2306-20261009    clang-24   sparse
arm64                randconfig-r2307-20261009    gcc-11.5.0 sparse
arm64                randconfig-r2309-20261009    gcc-11.5.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261010    gcc-10.5.0
csky                  randconfig-1001-20261010    gcc-10.5.0
csky                 randconfig-r2103-20261010    clang-24   cocci
csky                 randconfig-r2103-20261010    gcc-16.1.0 cocci
csky                 randconfig-r2104-20261009    gcc-16.1.0 cocci
csky                 randconfig-r2106-20261009    clang-24   cocci
csky                 randconfig-r2202-20261009    gcc-12.5.0 smatch
csky                 randconfig-r2300-20261009    gcc-16.1.0 sparse
csky                 randconfig-r2300-20261010    gcc-16.1.0 sparse
csky                 randconfig-r2304-20261010    gcc-15.2.0 sparse
csky                 randconfig-r2306-20261009    gcc-11.5.0 sparse
csky                 randconfig-r2307-20261009    clang-24   sparse
csky                 randconfig-r2308-20261009    clang-17   sparse
csky                 randconfig-r2309-20261009    clang-24   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261010    clang-17
hexagon               randconfig-1001-20261010    clang-17
hexagon              randconfig-r2100-20261010    clang-24   cocci
hexagon              randconfig-r2103-20261009    clang-19   cocci
hexagon              randconfig-r2103-20261010    gcc-12.5.0 cocci
hexagon              randconfig-r2104-20261009    gcc-16.1.0 cocci
hexagon              randconfig-r2106-20261009    gcc-16.1.0 cocci
hexagon              randconfig-r2106-20261010    gcc-8.5.0  cocci
hexagon              randconfig-r2200-20261010    clang-24   smatch
hexagon              randconfig-r2302-20261009    gcc-16.1.0 sparse
hexagon              randconfig-r2302-20261010    clang-17   sparse
hexagon              randconfig-r2303-20261009    clang-22   sparse
hexagon              randconfig-r2304-20261009    gcc-11.5.0 sparse
hexagon              randconfig-r2306-20261009    clang-24   sparse
hexagon              randconfig-r2306-20261010    gcc-16.1.0 sparse
hexagon              randconfig-r2309-20261009    gcc-14     sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261010    gcc-14
i386        buildonly-randconfig-1001-20261010    gcc-14
i386        buildonly-randconfig-1002-20261010    gcc-14
i386        buildonly-randconfig-1003-20261010    gcc-14
i386        buildonly-randconfig-1004-20261010    gcc-14
i386        buildonly-randconfig-1005-20261010    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261010    clang-22
i386                  randconfig-1001-20261010    clang-22
i386                  randconfig-1002-20261010    clang-22
i386                  randconfig-1003-20261010    clang-22
i386                  randconfig-1004-20261010    clang-22
i386                  randconfig-1005-20261010    clang-22
i386                  randconfig-1006-20261010    clang-22
i386                  randconfig-1007-20261010    gcc-14
i386                  randconfig-1008-20261010    gcc-14
i386                  randconfig-1009-20261010    gcc-14
i386                  randconfig-1010-20261010    gcc-14
i386                  randconfig-1011-20261010    gcc-14
i386                  randconfig-1012-20261010    gcc-14
i386                  randconfig-1013-20261010    gcc-14
i386                  randconfig-2100-20261009    clang-22   cocci
i386                  randconfig-2100-20261010    clang-22   cocci
i386                  randconfig-2101-20261009    clang-22   cocci
i386                  randconfig-2101-20261009    gcc-14     cocci
i386                  randconfig-2101-20261010    clang-22   cocci
i386                  randconfig-2102-20261009    clang-22   cocci
i386                  randconfig-2102-20261009    gcc-14     cocci
i386                  randconfig-2102-20261010    clang-22   cocci
i386                  randconfig-2103-20261009    clang-22   cocci
i386                  randconfig-2103-20261010    clang-22   cocci
i386                  randconfig-2200-20261009    gcc-14     smatch
i386                  randconfig-2200-20261010    gcc-12     smatch
i386                  randconfig-2300-20261009    clang-22   sparse
i386                  randconfig-2300-20261010    gcc-14     sparse
i386                  randconfig-2301-20261009    clang-22   sparse
i386                  randconfig-2301-20261010    gcc-14     sparse
i386                  randconfig-2302-20261009    clang-22   sparse
i386                  randconfig-2302-20261010    gcc-14     sparse
i386                 randconfig-r2100-20261009    gcc-14     cocci
i386                 randconfig-r2103-20261009    gcc-14     cocci
i386                 randconfig-r2103-20261010    gcc-12.5.0 cocci
i386                 randconfig-r2201-20261009    gcc-14     smatch
i386                 randconfig-r2305-20261010    gcc-8.5.0  sparse
i386                 randconfig-r2306-20261009    gcc-13.4.0 sparse
i386                 randconfig-r2308-20261010    gcc-16.1.0 sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    clang-24
loongarch             randconfig-1000-20261010    clang-17
loongarch             randconfig-1001-20261010    clang-17
loongarch            randconfig-r2100-20261009    gcc-13.4.0 cocci
loongarch            randconfig-r2103-20261009    gcc-16.1.0 cocci
loongarch            randconfig-r2107-20261009    gcc-16.1.0 cocci
loongarch            randconfig-r2107-20261010    gcc-14     cocci
loongarch            randconfig-r2200-20261009    gcc-16.1.0 smatch
loongarch            randconfig-r2202-20261009    clang-18   smatch
loongarch            randconfig-r2300-20261010    clang-17   sparse
loongarch            randconfig-r2303-20261009    gcc-11.5.0 sparse
loongarch            randconfig-r2304-20261010    gcc-8.5.0  sparse
loongarch            randconfig-r2309-20261009    gcc-13.4.0 sparse
loongarch            randconfig-r2309-20261010    gcc-16.1.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                         m5307c3_defconfig    clang-24
m68k                 randconfig-r2100-20261009    gcc-16.1.0 cocci
m68k                 randconfig-r2100-20261009    gcc-8.5.0  cocci
m68k                 randconfig-r2107-20261009    gcc-16.1.0 cocci
m68k                 randconfig-r2202-20261009    gcc-8.5.0  smatch
m68k                 randconfig-r2202-20261010    gcc-13.4.0 smatch
m68k                 randconfig-r2303-20261010    gcc-8.5.0  sparse
m68k                 randconfig-r2307-20261009    gcc-9.5.0  sparse
m68k                 randconfig-r2307-20261010    gcc-14     sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2103-20261010    gcc-10.5.0 cocci
microblaze           randconfig-r2105-20261010    gcc-8.5.0  cocci
microblaze           randconfig-r2200-20261009    gcc-9.5.0  smatch
microblaze           randconfig-r2302-20261009    gcc-13.4.0 sparse
microblaze           randconfig-r2302-20261010    gcc-15.2.0 sparse
microblaze           randconfig-r2304-20261010    clang-17   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                          bigsur_defconfig    gcc-16.1.0
mips                  decstation_r4k_defconfig    clang-24
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                            ip22_defconfig    gcc-16.1.0
mips                     maltaup_xpa_defconfig    clang-24
mips                 randconfig-r2100-20261010    gcc-10.5.0 cocci
mips                 randconfig-r2101-20261010    gcc-12.5.0 cocci
mips                 randconfig-r2102-20261009    clang-19   cocci
mips                 randconfig-r2102-20261009    gcc-16.1.0 cocci
mips                 randconfig-r2103-20261009    clang-24   cocci
mips                 randconfig-r2103-20261009    gcc-12     cocci
mips                 randconfig-r2103-20261009    gcc-9.5.0  cocci
mips                 randconfig-r2105-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2106-20261009    gcc-9.5.0  cocci
mips                 randconfig-r2106-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2107-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2202-20261010    clang-18   smatch
mips                 randconfig-r2301-20261010    gcc-8.5.0  sparse
mips                 randconfig-r2304-20261009    gcc-16.1.0 sparse
mips                 randconfig-r2305-20261009    gcc-15.2.0 sparse
mips                 randconfig-r2305-20261009    gcc-16.1.0 sparse
mips                 randconfig-r2307-20261009    clang-24   sparse
mips                 randconfig-r2307-20261009    gcc-8.5.0  sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261010    clang-17
nios2                 randconfig-1001-20261010    clang-17
nios2                randconfig-r2100-20261009    gcc-12     cocci
nios2                randconfig-r2101-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2102-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2105-20261009    gcc-8.5.0  cocci
nios2                randconfig-r2106-20261010    gcc-8.5.0  cocci
nios2                randconfig-r2300-20261009    gcc-10.5.0 sparse
nios2                randconfig-r2301-20261009    gcc-16.1.0 sparse
nios2                randconfig-r2304-20261009    gcc-8.5.0  sparse
nios2                randconfig-r2306-20261009    gcc-9.5.0  sparse
nios2                randconfig-r2306-20261010    clang-22   sparse
nios2                randconfig-r2308-20261009    clang-24   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc             randconfig-r2102-20261009    gcc-11.5.0 cocci
openrisc             randconfig-r2104-20261010    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261009    gcc-16.1.0 cocci
openrisc             randconfig-r2105-20261009    gcc-9.5.0  cocci
openrisc             randconfig-r2107-20261009    clang-17   cocci
openrisc             randconfig-r2107-20261009    clang-24   cocci
openrisc             randconfig-r2300-20261009    gcc-13.4.0 sparse
openrisc             randconfig-r2300-20261009    gcc-8.5.0  sparse
openrisc             randconfig-r2301-20261010    gcc-16.1.0 sparse
openrisc             randconfig-r2305-20261009    gcc-16.1.0 sparse
openrisc             randconfig-r2306-20261009    gcc-14     sparse
openrisc             randconfig-r2308-20261009    gcc-11.5.0 sparse
openrisc             randconfig-r2309-20261009    gcc-11.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-64bit_defconfig    clang-24
parisc                 generic-64bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20261010    clang-24
parisc                randconfig-1001-20261010    clang-24
parisc               randconfig-r2101-20261009    clang-18   cocci
parisc               randconfig-r2101-20261010    clang-24   cocci
parisc               randconfig-r2103-20261009    gcc-8.5.0  cocci
parisc               randconfig-r2105-20261009    clang-24   cocci
parisc               randconfig-r2201-20261010    gcc-10.5.0 smatch
parisc               randconfig-r2301-20261009    gcc-9.5.0  sparse
parisc               randconfig-r2302-20261009    gcc-8.5.0  sparse
parisc               randconfig-r2305-20261009    gcc-8.5.0  sparse
parisc               randconfig-r2305-20261010    gcc-16.1.0 sparse
parisc               randconfig-r2306-20261009    gcc-8.5.0  sparse
parisc               randconfig-r2307-20261009    gcc-13.4.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                        ebony_defconfig    gcc-16.1.0
powerpc                         icon_defconfig    gcc-16.1.0
powerpc                      mpc5200_defconfig    clang-24
powerpc                     mvme5100_defconfig    gcc-16.1.0
powerpc                        ppc64_defconfig    gcc-16.1.0
powerpc                          ps3_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261010    clang-24
powerpc               randconfig-1001-20261010    clang-24
powerpc              randconfig-r2100-20261009    clang-19   cocci
powerpc              randconfig-r2101-20261009    clang-24   cocci
powerpc              randconfig-r2101-20261009    gcc-11.5.0 cocci
powerpc              randconfig-r2103-20261009    clang-18   cocci
powerpc              randconfig-r2104-20261009    gcc-15.2.0 cocci
powerpc              randconfig-r2107-20261009    clang-24   cocci
powerpc              randconfig-r2107-20261010    clang-20   cocci
powerpc              randconfig-r2200-20261009    clang-17   smatch
powerpc              randconfig-r2201-20261009    clang-24   smatch
powerpc              randconfig-r2202-20261010    clang-17   smatch
powerpc              randconfig-r2301-20261009    gcc-8.5.0  sparse
powerpc              randconfig-r2302-20261010    gcc-8.5.0  sparse
powerpc              randconfig-r2303-20261009    gcc-16.1.0 sparse
powerpc              randconfig-r2305-20261009    gcc-16.1.0 sparse
powerpc              randconfig-r2306-20261009    gcc-11.5.0 sparse
powerpc              randconfig-r2308-20261009    clang-24   sparse
powerpc              randconfig-r2308-20261010    gcc-14     sparse
powerpc                       tqm8xx_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261010    clang-24
powerpc64             randconfig-1001-20261010    clang-24
powerpc64            randconfig-r2100-20261009    gcc-8.5.0  cocci
powerpc64            randconfig-r2101-20261009    gcc-16.1.0 cocci
powerpc64            randconfig-r2101-20261009    gcc-8.5.0  cocci
powerpc64            randconfig-r2104-20261009    clang-24   cocci
powerpc64            randconfig-r2104-20261010    clang-20   cocci
powerpc64            randconfig-r2200-20261009    clang-24   smatch
powerpc64            randconfig-r2301-20261009    gcc-8.5.0  sparse
powerpc64            randconfig-r2301-20261010    clang-17   sparse
powerpc64            randconfig-r2303-20261009    gcc-13.4.0 sparse
powerpc64            randconfig-r2304-20261009    clang-22   sparse
powerpc64            randconfig-r2304-20261009    gcc-10.5.0 sparse
powerpc64            randconfig-r2309-20261009    gcc-10.5.0 sparse
powerpc64            randconfig-r2309-20261009    gcc-9.5.0  sparse
powerpc64            randconfig-r2309-20261010    clang-22   sparse
powerpc64            randconfig-r2309-20261010    gcc-14     sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261010    clang-19
riscv                 randconfig-1000-20261011    clang-17
riscv                 randconfig-1001-20261010    clang-19
riscv                 randconfig-1001-20261011    clang-17
riscv                 randconfig-2000-20261009    gcc-13.4.0
riscv                 randconfig-2000-20261009    gcc-16.1.0
riscv                 randconfig-2000-20261010    gcc-16.1.0
riscv                 randconfig-2001-20261009    gcc-15.2.0
riscv                 randconfig-2001-20261009    gcc-16.1.0
riscv                 randconfig-2001-20261010    gcc-16.1.0
riscv                randconfig-r2100-20261010    gcc-12.5.0 cocci
riscv                randconfig-r2101-20261009    gcc-12     cocci
riscv                randconfig-r2102-20261009    gcc-8.5.0  cocci
riscv                randconfig-r2106-20261009    clang-24   cocci
riscv                randconfig-r2200-20261009    gcc-10.5.0 smatch
riscv                randconfig-r2300-20261010    gcc-15.2.0 sparse
riscv                randconfig-r2304-20261010    gcc-8.5.0  sparse
riscv                randconfig-r2306-20261009    clang-17   sparse
riscv                randconfig-r2307-20261009    clang-17   sparse
riscv                randconfig-r2308-20261009    gcc-9.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261010    clang-19
s390                  randconfig-1000-20261011    clang-17
s390                  randconfig-1001-20261010    clang-19
s390                  randconfig-1001-20261011    clang-17
s390                  randconfig-2000-20261009    clang-21
s390                  randconfig-2000-20261009    gcc-16.1.0
s390                  randconfig-2000-20261010    gcc-16.1.0
s390                  randconfig-2001-20261009    gcc-15.2.0
s390                  randconfig-2001-20261009    gcc-16.1.0
s390                  randconfig-2001-20261010    gcc-16.1.0
s390                 randconfig-r2100-20261010    gcc-16.1.0 cocci
s390                 randconfig-r2102-20261009    clang-24   cocci
s390                 randconfig-r2102-20261010    gcc-10.5.0 cocci
s390                 randconfig-r2103-20261009    gcc-11.5.0 cocci
s390                 randconfig-r2104-20261009    clang-24   cocci
s390                 randconfig-r2105-20261009    gcc-15.2.0 cocci
s390                 randconfig-r2106-20261009    gcc-13.4.0 cocci
s390                 randconfig-r2202-20261009    clang-18   smatch
s390                 randconfig-r2300-20261010    gcc-8.5.0  sparse
s390                 randconfig-r2301-20261009    gcc-16.1.0 sparse
s390                 randconfig-r2307-20261010    gcc-16.1.0 sparse
s390                 randconfig-r2308-20261009    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261010    clang-19
sh                    randconfig-1000-20261011    clang-17
sh                    randconfig-1001-20261010    clang-19
sh                    randconfig-1001-20261011    clang-17
sh                    randconfig-2000-20261009    gcc-16.1.0
sh                    randconfig-2000-20261010    gcc-16.1.0
sh                    randconfig-2001-20261009    gcc-16.1.0
sh                    randconfig-2001-20261010    gcc-16.1.0
sh                   randconfig-r2101-20261010    gcc-12.5.0 cocci
sh                   randconfig-r2107-20261009    gcc-16.1.0 cocci
sh                   randconfig-r2200-20261010    gcc-9.5.0  smatch
sh                   randconfig-r2201-20261010    gcc-15.2.0 smatch
sh                   randconfig-r2300-20261009    gcc-13.4.0 sparse
sh                   randconfig-r2301-20261009    clang-22   sparse
sh                   randconfig-r2301-20261009    gcc-10.5.0 sparse
sh                   randconfig-r2302-20261010    gcc-16.1.0 sparse
sh                   randconfig-r2303-20261010    clang-17   sparse
sh                   randconfig-r2304-20261009    gcc-14.3.0 sparse
sh                   randconfig-r2305-20261009    gcc-13.4.0 sparse
sh                   randconfig-r2308-20261009    clang-24   sparse
sh                    sh7724_generic_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261010    gcc-16.1.0
sparc                 randconfig-1001-20261010    gcc-16.1.0
sparc                 randconfig-2000-20261009    clang-17
sparc                 randconfig-2000-20261010    gcc-16.1.0
sparc                 randconfig-2001-20261009    clang-17
sparc                 randconfig-2001-20261010    gcc-16.1.0
sparc                randconfig-r2100-20261009    gcc-11.5.0 cocci
sparc                randconfig-r2100-20261009    gcc-8.5.0  cocci
sparc                randconfig-r2100-20261010    gcc-12.5.0 cocci
sparc                randconfig-r2101-20261010    gcc-16.1.0 cocci
sparc                randconfig-r2105-20261009    gcc-16.1.0 cocci
sparc                randconfig-r2106-20261009    gcc-16.1.0 cocci
sparc                randconfig-r2106-20261010    clang-20   cocci
sparc                randconfig-r2200-20261009    gcc-16.1.0 smatch
sparc                randconfig-r2200-20261010    gcc-16.1.0 smatch
sparc                randconfig-r2201-20261009    gcc-11.5.0 smatch
sparc                randconfig-r2300-20261009    gcc-16.1.0 sparse
sparc                randconfig-r2302-20261009    gcc-16.1.0 sparse
sparc                randconfig-r2303-20261010    gcc-16.1.0 sparse
sparc                randconfig-r2304-20261009    gcc-16.1.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261010    gcc-16.1.0
sparc64               randconfig-1001-20261010    gcc-16.1.0
sparc64               randconfig-2000-20261009    clang-17
sparc64               randconfig-2000-20261010    gcc-16.1.0
sparc64               randconfig-2001-20261009    clang-17
sparc64               randconfig-2001-20261010    gcc-16.1.0
sparc64              randconfig-r2101-20261009    clang-19   cocci
sparc64              randconfig-r2101-20261009    clang-24   cocci
sparc64              randconfig-r2102-20261009    clang-18   cocci
sparc64              randconfig-r2102-20261010    clang-24   cocci
sparc64              randconfig-r2103-20261009    gcc-8.5.0  cocci
sparc64              randconfig-r2104-20261009    clang-17   cocci
sparc64              randconfig-r2104-20261009    gcc-16.1.0 cocci
sparc64              randconfig-r2105-20261010    gcc-14     cocci
sparc64              randconfig-r2106-20261009    gcc-9.5.0  cocci
sparc64              randconfig-r2201-20261009    clang-24   smatch
sparc64              randconfig-r2301-20261009    gcc-13.4.0 sparse
sparc64              randconfig-r2302-20261010    gcc-8.5.0  sparse
sparc64              randconfig-r2303-20261009    clang-24   sparse
sparc64              randconfig-r2305-20261010    gcc-15.2.0 sparse
sparc64              randconfig-r2306-20261010    gcc-14     sparse
sparc64              randconfig-r2308-20261009    gcc-13.4.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261010    gcc-16.1.0
um                    randconfig-1001-20261010    gcc-16.1.0
um                    randconfig-2000-20261009    clang-17
um                    randconfig-2000-20261010    gcc-16.1.0
um                    randconfig-2001-20261009    clang-17
um                    randconfig-2001-20261010    gcc-16.1.0
um                   randconfig-r2102-20261009    gcc-12     cocci
um                   randconfig-r2105-20261009    clang-17   cocci
um                   randconfig-r2105-20261009    gcc-16.1.0 cocci
um                   randconfig-r2105-20261010    clang-20   cocci
um                   randconfig-r2200-20261009    gcc-14     smatch
um                   randconfig-r2201-20261009    clang-24   smatch
um                   randconfig-r2201-20261010    clang-17   smatch
um                   randconfig-r2202-20261009    gcc-14     smatch
um                   randconfig-r2302-20261009    clang-22   sparse
um                   randconfig-r2302-20261009    gcc-12     sparse
um                   randconfig-r2303-20261009    gcc-16.1.0 sparse
um                   randconfig-r2304-20261009    gcc-8.5.0  sparse
um                   randconfig-r2307-20261009    clang-24   sparse
um                   randconfig-r2309-20261009    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261010    clang-22
x86_64      buildonly-randconfig-1000-20261011    gcc-14
x86_64      buildonly-randconfig-1001-20261010    clang-22
x86_64      buildonly-randconfig-1001-20261011    gcc-14
x86_64      buildonly-randconfig-1002-20261010    clang-22
x86_64      buildonly-randconfig-1002-20261011    gcc-14
x86_64      buildonly-randconfig-1003-20261010    clang-22
x86_64      buildonly-randconfig-1003-20261011    gcc-14
x86_64      buildonly-randconfig-1004-20261010    clang-22
x86_64      buildonly-randconfig-1004-20261011    gcc-14
x86_64      buildonly-randconfig-1005-20261010    clang-22
x86_64      buildonly-randconfig-1005-20261011    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261010    gcc-14
x86_64                randconfig-1001-20261010    gcc-14
x86_64                randconfig-1002-20261010    gcc-14
x86_64                randconfig-1003-20261010    gcc-14
x86_64                randconfig-1004-20261010    gcc-14
x86_64                randconfig-1005-20261010    gcc-14
x86_64                randconfig-1006-20261010    clang-22
x86_64                randconfig-1007-20261010    clang-22
x86_64                randconfig-1008-20261010    clang-22
x86_64                randconfig-1009-20261010    clang-22
x86_64                randconfig-1010-20261010    clang-22
x86_64                randconfig-1011-20261010    clang-22
x86_64                randconfig-1012-20261010    clang-22
x86_64                randconfig-1013-20261010    clang-22
x86_64                randconfig-1014-20261010    clang-22
x86_64                randconfig-1015-20261010    clang-22
x86_64                randconfig-1016-20261010    clang-22
x86_64                randconfig-1017-20261010    clang-22
x86_64                randconfig-2100-20261009    clang-22   cocci
x86_64                randconfig-2100-20261010    clang-22   cocci
x86_64                randconfig-2101-20261009    clang-22   cocci
x86_64                randconfig-2101-20261010    clang-22   cocci
x86_64                randconfig-2102-20261009    clang-22   cocci
x86_64                randconfig-2102-20261010    clang-22   cocci
x86_64                randconfig-2103-20261009    clang-22   cocci
x86_64                randconfig-2103-20261009    gcc-13     cocci
x86_64                randconfig-2103-20261010    clang-22   cocci
x86_64                randconfig-2200-20261009    gcc-14     smatch
x86_64                randconfig-2200-20261010    gcc-14     smatch
x86_64                randconfig-2300-20261009    clang-22   sparse
x86_64                randconfig-2300-20261010    gcc-14     sparse
x86_64                randconfig-2301-20261009    clang-22   sparse
x86_64                randconfig-2301-20261010    gcc-14     sparse
x86_64                randconfig-2302-20261009    clang-22   sparse
x86_64                randconfig-2302-20261010    gcc-14     sparse
x86_64               randconfig-r2101-20261009    gcc-14     cocci
x86_64               randconfig-r2104-20261010    gcc-8.5.0  cocci
x86_64               randconfig-r2105-20261009    gcc-14     cocci
x86_64               randconfig-r2106-20261009    clang-22   cocci
x86_64               randconfig-r2106-20261009    gcc-14     cocci
x86_64               randconfig-r2106-20261010    gcc-14     cocci
x86_64               randconfig-r2200-20261009    clang-22   smatch
x86_64               randconfig-r2201-20261009    gcc-14     smatch
x86_64               randconfig-r2201-20261010    clang-22   smatch
x86_64               randconfig-r2300-20261009    gcc-11.5.0 sparse
x86_64               randconfig-r2301-20261009    gcc-11.5.0 sparse
x86_64               randconfig-r2303-20261009    gcc-8.5.0  sparse
x86_64               randconfig-r2303-20261010    gcc-15.2.0 sparse
x86_64               randconfig-r2305-20261009    clang-22   sparse
x86_64               randconfig-r2307-20261009    gcc-14     sparse
x86_64               randconfig-r2307-20261010    gcc-14     sparse
x86_64               randconfig-r2308-20261010    clang-22   sparse
x86_64               randconfig-r2309-20261010    gcc-14     sparse
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
xtensa                randconfig-1000-20261010    gcc-16.1.0
xtensa                randconfig-1001-20261010    gcc-16.1.0
xtensa                randconfig-2000-20261009    clang-17
xtensa                randconfig-2000-20261010    gcc-16.1.0
xtensa                randconfig-2001-20261009    clang-17
xtensa                randconfig-2001-20261010    gcc-16.1.0
xtensa               randconfig-r2101-20261009    gcc-14     cocci
xtensa               randconfig-r2102-20261010    gcc-16.1.0 cocci
xtensa               randconfig-r2104-20261010    gcc-8.5.0  cocci
xtensa               randconfig-r2107-20261009    gcc-14     cocci
xtensa               randconfig-r2200-20261010    gcc-8.5.0  smatch
xtensa               randconfig-r2300-20261010    gcc-8.5.0  sparse
xtensa               randconfig-r2301-20261010    gcc-8.5.0  sparse
xtensa               randconfig-r2308-20261010    gcc-14     sparse
xtensa               randconfig-r2309-20261009    clang-17   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
