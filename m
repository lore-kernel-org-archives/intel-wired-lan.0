Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B930C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0128A405F4;
	Tue,  8 Sep 2026 13:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ib-mio4re6w0; Tue,  8 Sep 2026 13:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 233E14057B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788872667;
	b=VAGABUlJQlIG2YHatd9ptBhfh6WyrIQlo1Mwided7x+8VE4g1etfsDJ/EVIAErc90WYo
	 hg4JUwRwEWG0eyzEcVLUNzWHidy8g5ibAa7g3WJAMrm/l1rBASlteKqhRieinOFpmBZ24
	 PDHIiNYrb6chO1ZaJmv9xEp39tyh7DUGpSBwretOcobzRCcLGVR8Pd+i1DVz6SQIk0kaE
	 FDlXlbv4FkTOiw2gkzyLkuFjN6mmfL/Hd9WAY81Sqi4UrcUu/XUQf41/orN5/4YTHw852
	 NQajeoZOpGHGhqOy3uGYNA4RQkuvGnJ2pYr4bIRYQLXV1z+m8s+zMZilq0PQGSGLKSA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788872667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hc6LsVDSw3ItYVXLZ//GSmHA54g6L+/epa9TwWrPhUE=;
	b=OAGrQT9KTV7a6Tl64sa3LwyvHpJG1XJfCCHCLNDlDZFrjtr92q2bJxo+apS/IZQQ5XMT
	 ItTXhhjkRc1UjOoJkhO1toIld4obILd0GfZbanNZyDYtD0ZdxCILBRkJW2XrCjy11Viyr
	 ISGJi6BZ/hcGu9qJSP+mvE/u6/4pxvZ0EfIMPuYJ6fHKKye8zRG+sQDV/PkOaKLYfG+0t
	 DItTY7Ryl3dbwD4df8/gsSYxHKc+AVwESmyAek54VaUv5rxUyN8Omk1cq8GyG3AaLcrez
	 JOn1ESfR1bpUE0YeHfPEvFzp9pKBAMKagCZuuGzbiJHSnSqgKxfLZJTEuu8q0YsEXGQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788872667;
	bh=hc6LsVDSw3ItYVXLZ//GSmHA54g6L+/epa9TwWrPhUE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0eM23WIY92V9AMPrIEVieGbjDotIkEdRoKHwMsCaX/PM8vaplS8zGWZGOqi5pfTjM
	 QcI99RpuP4xxD0cF8KQ+132fFfmP5etB4a12gJ7mgTPMhVoDJeD3E+DJAwobGJeD85
	 1ruAa2JhU3DafrPkr5p0wP6TZP26YOLnpjzl7+47F9frIhP5iISgvIo4X45IbVnedT
	 a2AA2NWixk0oVcwi9sYCsaw/OudjiFFO8MRZn48MNyV7K+UkPpKMbytAeq9L1ej0wE
	 ULti0IDvaXzUjwKPCbw99m4grQLCjfhVJ05uOwq0k676SGdAdpjPd9gHh0MBTq0Zam
	 GMeN4+gW7QBEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 233E14057B;
	Tue,  8 Sep 2026 13:04:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B31ED372
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4B5C606FF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QvshtpXBhMDL for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F0B0606F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788872664;
 b=NyHroim5s2g6+daxbpvHkZeh0VqR0IvumkYqoD0/deklgl32egIYIj1z/eXEZcKnMQj5
 jJ3LS/TAqSmjQAud2XonOmQ5W3RUe4BCi0Nsxq7Ge6bQQCZbQLOK6JFoEFjp+3j2yLJdo
 ls9yCZ1zGUp05GTR5cCp5NDrbfn7aJdeefRxZUkwHDddZUH1QgHZYRO7J2MbA+1qQbNIf
 86VLxfrfnIi4YTxlwUn3nYM6TQese/Q4v8ieCcnczf8RZRDYyOcz+mDieZ4n6n9wOgFnA
 TW6B31d2NIkSAEL1HFyiwNXTFl20d33gMlPfC2wAwkvx5v2Op1FUAbO0Z2ApDX5yxaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872664;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=hc6LsVDSw3ItYVXLZ//GSmHA54g6L+/epa9TwWrPhUE=;
 b=Jt/PTwpNj//nNNzJGMTH8TsYD72rg7jE0V54DHBNwS4jn8S4hA1VgLLlhEOGYcWLVeJA
 u83b18Lq3/5u3kSq2tLGG3RcWeEFidoVQC01o9+lzQiKLyibm59XjQNNkmqStSGoAzu5J
 v1cumfoC9GL+GehaswIGoAE+WdKvoihIOdwceb623fpQRNiP3/5hRaZfUMax+F4s477IQ
 JA2esk6SBykVTttMqY+3GbhhEsrx1HBVcOGNqvWlfXPo/L36mxfeBxopuoSceNUd9rYW1
 r6zsXmA/NxiGoVt3G6zwl4QOBVDgeudbeT1AqhF03BdkMXnRvpHm8T5N9gW2OXEKD0g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Kvum1xzI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Kvum1xzI
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F0B0606F6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788872664; x=1820408664;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Sps9f0FuUjFlDy3DFN05M3d94Dlzi7NE1RV3STEZ8Mo=;
 b=Kvum1xzI8dp82Fzjhkr2nurLBsKMoHbiaGucItxh6CtvfdWOTMYSJ27j
 /Wkg6xoFgMiNFMka8kZgkChK3wnAm7lR+S395HjuIazyEAdCRfoHxAh8o
 jrWDu8GDEpn0NSCGU3Q9SsEiLSIaQZ3JnxanetaBeBJd3kyjwLXvU7YxA
 bWRc5ViRxvAuSv/FZcMJq8fMOCEw94NEY7lU373tnblAZat5Qe16cjex2
 dKDvOQxLS/v5NBwl7q2DB/pyRR8m91j6AECLDlJ5Zc0d2ZZEMvxeVmPBA
 gTiwed+NrSJBdVoZWHgJASIF5UNBc/Da6+grL33gK3HsAjDGqhzxUknWR g==;
X-CSE-ConnectionGUID: z7DqXM8fQMGS9QnvUTQRsg==
X-CSE-MsgGUID: Ui+tWEMcQ/igSahbzb7fug==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99865977"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="99865977"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:04:23 -0700
X-CSE-ConnectionGUID: rkDbqRpqRI2X8OgdVt2Rag==
X-CSE-MsgGUID: P9a2S7W9Qz658hbiVbNIyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="300877968"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:04:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:04:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:04:21 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f228g01VwRqjtNqwIwgWZqTMd+oQ6oyITQRFPD0r1fknlTPhEp553qe/ZNLnkjRSECHhtTOynLYhYEwb20VrfcsWVjGZgkpkLoYgHt8Ygboffdyj1yE+gqoXdZW22FwB+bcmAHpbr/F1AAAWW55IaZXTi91qDjjS0uZPDnBm1CbpBZunR7Z76xpj+YAcM47NVdYRT+LnP/l6iSHrtgpdDjGVljjzP84TBKiswqsur5ywNE067tm4CyTGRX1N4NfefnNdESRbv8YM5Q+qZIsFTd/opTWNMlYtUPQaI+zLIB85QWj8fCCz3aj30s3L6eIHD8tr/PR7gqbfvVoW1bv8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc6LsVDSw3ItYVXLZ//GSmHA54g6L+/epa9TwWrPhUE=;
 b=SdALNzmWjMfwHhY5SHYfxvVhXdaXyEZWvZdjNPTJEtbzEmisY64gf8qsrvkYq/3/PUDOD82xKLr6je/mABO0RHapbOuItjY1KotOS+kMNsYktKQLlmd+fTWvd5cXQEYqVovgWYSIX5iyeXOhCNjXgu72u8YpSeGbqp4SXuJED4qQxOnWH5ZlkrRDMfkPbkMaNcxdNCPwD9D628DtpYgCqBeu/r9glnJnyxichO+mJ73ArcrwJWd6Z29wJy9W80AthMI52w4AXBIKH8ES07NQ9wzlzxahJ/06mkKEFBOKPhQ+dnEnmQ8+7TskgTvvp/nyGZJSofd9U93e6T6nLOYg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:04:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:04:18 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>
CC: Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 2/9] linkmode: make linkmode_and() return boolean
Thread-Topic: [PATCH 2/9] linkmode: make linkmode_and() return boolean
Thread-Index: AQHdPxOKeTD4TQUTT0itXugHvo0DSLbEptmA
Date: Tue, 8 Sep 2026 13:04:18 +0000
Message-ID: <IA3PR11MB89865B9A21B9F74F3E179F15E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-3-ynorov@nvidia.com>
In-Reply-To: <20260907215439.409858-3-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7658:EE_
x-ms-office365-filtering-correlation-id: 49d53f91-3d10-494d-654e-08df0da9b15c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: FvGtCyMD+tcBCwkezCtwfNJSJ6QZfrH86On2Jidq4e80dWPdpmsieNHDeR2ezwVCMpbj6NveIW5f0eT4sXsy+bfVFHij8seAHqz1CiwBoMs8zzfsVyfIkZM6XIdKRBrLZmOHZn3P7Zcm+WFWccFTyOCGR/Ns5ZxR3IIs84sblqPj9I/iZclrWKAg0VOs67Z7D4kmKaRMONGTkvZ5IO6gEn7BqNGliwdy3JQkG38PvUL6hizgoREpj7DQBeRod4DT5YI18Zk6Yu3zx0IANGjljrMGpTi9i+EAPM+g9MXxhwyoRfvin+SiROnHriW6HbwTMSYhXjceFp1R72yoXs7yBQmOUUGNwcMzV9zHLCav9drRDR/UBKFNOb2fQB0sZi49s15+vCehuQ8cT9v0N8WOkAkDmutxFvRpL8cgQXkg3hvejfS5XZzE0rmYAJ8T+k54oOfh2YiqkEJmpbsW7v2DQYccAjEs1fqLFS1TFuNNqUGCaLZzN/svpajFM3OpkmDsUHnIQPm93w+n5Bw2ih1EU/eyIohODiSiSp/AyHNHyB5ZI0kOvt42+hhDZFNQ8S3wBDvdzLb0MxfpruaGqIlhXYQQzX40hOmDwDClvfLm8rMNG6zgqK8I/SPlIX5SkITHahwpmpCcKGTfGlnxLK6HiCeJubR1GL3zLSsVg+J6eAgF/VP78Pj/XKYP0hUx+L7gxq5Hx1S/fjrwgo32Zsh0W3EvFNycqGfKS13OVWPyev2hdN1/F7Ust1kxpMcAn3wH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z3ODruO0ENBKS/uwlYXVWVAxyEQZTKj9zSZnExxywmvfuuIUlh1RCObB1VKY?=
 =?us-ascii?Q?biE2xcrFhxoZsSkwiPyWnCXJV++taegt9aReQHWSClGS8+968phm0+vNqukl?=
 =?us-ascii?Q?KDnzOpd/u75yne+J/SLQRS6G2xW1lpNgudXj1ndMcIcHy7+NUE5ty6Q/t8Zn?=
 =?us-ascii?Q?+9ZlOB36tmbaV7Od/aHjmVEbzDWpMBAO535FYglw/K5K17IvB/WEWJCyiihZ?=
 =?us-ascii?Q?6TDfgP0rvKGeuK+nvfMJuhcDcr7dxPcjsQJeONODY6Rbwg4nJdCGiCsUGKdK?=
 =?us-ascii?Q?4H0ofMy0tlKhu0lwvj9yWKIK0clclVaG7vumQ9pOf5qcqw7L9QvEWATcqdY9?=
 =?us-ascii?Q?DR9WeifDCL4B2tRMFewd53e4OzxzXxLILfnDupWUxXuxHVEw7HeeDDLAS4LG?=
 =?us-ascii?Q?HJmRKw6Qw3mrtTt6idzCu0mSsLTpOeE23JJ1ikST2cru3RUXwHtgvzJNL7HW?=
 =?us-ascii?Q?KlJnB6Kcw+nZaomYyHhE4E45ROj8CFB40BoHOhUvrkjx1lmaMHDfWBx/dsY0?=
 =?us-ascii?Q?MFLOcloymCEd3sCwXyraTMikOWjqKKkMRb/SFnZWGd1oz5lQt3WzSe+6Hzad?=
 =?us-ascii?Q?Rht+qQ1JXgqsRY1czptWt6URlE/A1YYPPjVAB+pc8r07Wjfc1W+VmBQ18Qex?=
 =?us-ascii?Q?skh7xC1ZVFivOwb89d7fEaSKI8U5sb52/gQjUxKDZQjkQRxFM5I2rsN7OHe8?=
 =?us-ascii?Q?anrUetRqhFtzmdfgmH8meo4lz+cD7P+3v5gY71nTTsPnrvHcBpAKwCJtxzVh?=
 =?us-ascii?Q?Ok2+SLRUwF9RE+pCt2GBPTYeB65tbm1ihAdMwOKW4UOZMDBhXi0nBDNcqYuC?=
 =?us-ascii?Q?qfUwiJTWv1yW/n0gGoou8XYw85bpQa/cEDzL9E+aUPHuXQPkc65XjGGFdBXp?=
 =?us-ascii?Q?psze+oDQMo7bTd2Ep3Em3MXPGspcH8bg/qggnZqnftTOjNnkBM7ugA3wiKkA?=
 =?us-ascii?Q?xi97/wRtTVKJM2/eMUxv2vELmdYw0/BooW+ZQ8UADizlhHXnz4WLzPGFehty?=
 =?us-ascii?Q?/0T6U6A6QgFk5LSHCXyfVR4JfbWNgCLlfFRTisQYStmtEDxtPXlpJ3EtQYsD?=
 =?us-ascii?Q?uT/pVBRkhABsR/S6AP/272OoBhplvEwGBAUTzXV65JE53U0RfeNnxuXt6/8C?=
 =?us-ascii?Q?+ru6Sp4ye2t0YofZIfjWoXxVwbOa7WCmfSt+kdcg6oP829DzRxtbUNrFwIzK?=
 =?us-ascii?Q?BsZqeslZedGu0ilcVbhWUTKfGv9J7Gi3QHakbFmhp0q/QXQVDaHKRJN5Aumi?=
 =?us-ascii?Q?l65YnfBwi22fm9rE3/kKp7zu772fRHVaqHEEbXhnqndjt5LFrtJzf+bF1Zf+?=
 =?us-ascii?Q?svpiUB2xtPlnDfAdvkxFxjwY86HijXXV+zlP9S15fUZHddtiAMwvBQn9jH16?=
 =?us-ascii?Q?vwcJFyqQbHXwyC/hS7Y22ZF1yUkK9jJbfzxWTiIEvBRODrnDlqFpNffWIwhx?=
 =?us-ascii?Q?c0xShqaAnt/AhKhAS/NC02KqaeH+BewocICut75M2wrbsmNZqBLCfpyqA4Kn?=
 =?us-ascii?Q?qvcTW5kmkqUSxCr2Jg5Ouw0blXCxbKX1jNKGLtD7Nj7PwmIf7Km3ka0AGTkj?=
 =?us-ascii?Q?gvSGbfX8DDnI9lyrn+eZZQHnL/TayOQ1Xwl7DbfjsQ5kX7RlRc3B89tMmCwX?=
 =?us-ascii?Q?Bx6CXIyMsrdeD49CrvTGkEe+d1G2Z5nYKDvxUZK9PBzO0Fl9Oz1ckQxOBUoQ?=
 =?us-ascii?Q?DvXUKMGsxB3C7SD/GP67AcQkaz3Xpx8QIefwyOjV6EVkXKjPlDE6VKb+BkF7?=
 =?us-ascii?Q?eEwIDNVkGl2lgWH9JCroJgllT3KDjHM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VtwKy5qXAbS6/KcRU6xdr4o/vKFhTKJCVBvbK4w4BKx98vOUjPsbEQR4sNH7eOVr8FGKuz9OYQuz1fb92QKEC4jR6oQbFRrbzpGhXukB707vtRocg0QnxEegzEmL7ZBL5SPgdGnrqJA0BGCzQPCL+QiUz/zbwrILj8Cf4NOHyImriJN2hbL+TrURZ7XS4sYut2kI91BokJOXFNfgu7pTRg9maYdPQqTiAOZFJSvmEBdkV/ZkVdpbx3kR/6CboAIgHjK0Op4j8HaXtnxFHncxc5JdTRzO3yCBLbAGoxRwnctZqn/TqEqEaG8B2Z7WqlecfR/nIV1WNav4PXu0EOTFlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d53f91-3d10-494d-654e-08df0da9b15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:04:18.5573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMb7syCYxtNIE3emiGwRv9c4F7eKt7cb/NhC0CEWhgq72QWjOZTA+IRadgmA5VjdEdQUE3Ux6u29iFvUADTC86ATfZwogGqFxQRsQ0bdIxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com
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



> -----Original Message-----
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Monday, September 7, 2026 11:55 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Raju
> Rangoju <Raju.Rangoju@amd.com>; Prashanth Kumar K R
> <PrashanthKumar.K.R@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jian Shen <shenjian15@huawei.com>;
> Jijie Shao <shaojijie@huawei.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-usb@vger.kernel.org
> Cc: Yury Norov <ynorov@nvidia.com>; Yury Norov <yury.norov@gmail.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton
> <akpm@linux-foundation.org>
> Subject: [PATCH 2/9] linkmode: make linkmode_and() return boolean
>=20
> bitmap_and() returns true if the resulting bitmap is not empty.
> Propagate that return value through linkmode_and() so callers can use
> it where applicable.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  include/linux/linkmode.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h index
> 3b9de09871f6..c08632c10c3d 100644
> --- a/include/linux/linkmode.h
> +++ b/include/linux/linkmode.h
> @@ -20,10 +20,10 @@ static inline void linkmode_copy(unsigned long
> *dst, const unsigned long *src)
>  	bitmap_copy(dst, src, __ETHTOOL_LINK_MODE_MASK_NBITS);  }
>=20
> -static inline void linkmode_and(unsigned long *dst, const unsigned
> long *a,
> +static inline bool linkmode_and(unsigned long *dst, const unsigned
> long
> +*a,
>  				const unsigned long *b)
>  {
> -	bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
> +	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
>  }
>=20
>  static inline void linkmode_or(unsigned long *dst, const unsigned
> long *a,
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
