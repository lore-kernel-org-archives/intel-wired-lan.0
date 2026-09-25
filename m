Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F383BC9830D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 14:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC2EE8110D;
	Fri, 25 Sep 2026 14:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9UfrL8rYIt5u; Fri, 25 Sep 2026 14:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D7D3A810F5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790346748;
	b=QqyqyC5o1gaCXynaamITpQ6+xhqhFBvJWjn2pp5pCrmMksgF7zPik179VshCleMn7KrW
	 73Zr/eza2xQMwVeV42SYLKYIjNQTzbUVXd06zavRij3RbTzg3PmsEbQ/0zQOE1Yef9SQ+
	 QxgujmTleV/EiiKoP6YIVQMuXxITkg0mOS4Uh1g5C4NP0YiwTQclJ9i8K5WK27s28elsW
	 O0LcmQX92pb+3bCvfX8r9Z1Uble0vBIlixhP+QiH8COFar+pBkOxhIz2tW8IrjpCpZFoT
	 zjQwKH1P1LtuHNZbIyOk6IdRZlE2Y69FJqjfCxByxI01fMUS3Awwa+xLU2lrRw3Nm2A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346748;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lBTF3rFtqIGXA14omU7+ggpXiw25VDEzcqTYFcD2nfY=;
	b=r3BhYs7i2c2mGZMPxmUPo0BFLr27SihQDh1NZzmCTpe0HWpCLYbSKlXI0Gboan4W/66M
	 mEPbrJIkH69ZhoNGPJmfc1au0QoYm0zKqYqdmHiAUUpn+fL9L44kTluwbHG3rFZhIXJe2
	 9HueL5hCn+Oov0TQnWfnc5GuNHKecD9YHnG3CxC+K2Ezi11vEPwSJPECvtAvowfrI4c2n
	 OZejTHgvfZswvqsc+6BDhRkWZjK3MKdwSKxJwKVbVPvkoxzJKvMaEUvutH98N4bwzSULN
	 unrpnOUFK7aeO8hwEeYiFnANHFpkx542/naeVu7DGcqqRDFsFhZIy2vOr5ZgAeqPCrw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790346748;
	bh=lBTF3rFtqIGXA14omU7+ggpXiw25VDEzcqTYFcD2nfY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A6bvH/7Qbk+REL5xT86OylPaJ7wX53tqR50n5XxloTYJBz8C2MP4MDia9anvCatZV
	 UlsYRGkNUqbcdBhcKX3eH+nQOcqDawe8LsrWAYv4uwdz5bs+52Oq8tPDoeSZa6dz0S
	 a7CoukRszIV1kz6GJgMwqLMhdzlgyBz5Y7rxTTegz/1GDr8cHMsRBXltOZRqHYeqiI
	 u7IFYIwTxpbJ2wxJe5Mnao4DB3NXG0cYJ8Ge31Pd2rvy407AWrKwVJi1QU/vWbRz7N
	 xfoGon4D4aGQF7Bab+WE0aDpBrgqEkNCnti3afJ6EFnlCSiUkTVMX2K+cYUOn/SD/L
	 d+zo8MfMzmlWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7D3A810F5;
	Fri, 25 Sep 2026 14:32:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6993D194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66E4740545
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7GqD0huxQWZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 14:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5896A40544
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346746;
 b=qDanqCwZbIUyQeos2StTtvD1PddGX+YnMDcx8Wdpcp9AfCM4KlOvACTOr7dUmkQUz0gA
 I3KbS85Tg2x8X4bQXD0t2oafnQEyZu6UG7yr7ubrVuUDYpPeVvQ8Qlq1+ssj8u9QndKby
 qO0NOjhHyhU4djNLvJlA3GcZWIbJCYezfxoEtEmTK2EM7FtbC/RZLQ+vGCRD9xHr8hrt4
 D1pz150pnosGzCSRBoC1Kdf1GhZoJr5xPRN2v4L6csKlI/WxcskS2qMa2nU4zu7QYBTTf
 yp8SZpBoGrR2WOdIa3yBHdIpTel/8RSqAlOU4IQP42+cvHYL7UENap4tCBAfSmM+clg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790346746;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=lBTF3rFtqIGXA14omU7+ggpXiw25VDEzcqTYFcD2nfY=;
 b=Rmb7jyNwhdmXvbFInNOtdzf7Dxh7a8cvyNJ9I47z973DnSLyb1BoYI40cQX6IkXSf/OZ
 PuCL/2L4uFtY9+3NB80VMKQQs6OzbqO5BvUcGDmt3WNESz6ilNyYpsbsDios/XfeeGCuJ
 lW1PnDyzEZJ3ZVlkqz+rgMMwLKnQB5gbGKoviKn+zpNuHwwPHnUU1ls6E8RnX0iXkxJaJ
 GndPsleNDC58qQZ6xnpMXKAeGwsbnCfeoshVW8h5XPN1RxQDxWSHztwFw5mdz/Bpv/Y7q
 1BhR7fkwJ6upPjCTP79Aat86+wHAIAr2xx/N/tcFwPXOVyQDMyxnWyUxAbOOGENxg5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HxU+7qd9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HxU+7qd9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5896A40544
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790346746; x=1821882746;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bUcs4mE/Y/eQa7dxQZFoby7x6SMJQ9nQaVEKzIFRWOk=;
 b=HxU+7qd90f3l3IuSLpfrjTR3KGPtUlnNPRrLEeq5NtN9HPOp809jsmq1
 aybakDgURfykIImb+1XmnQ/0O3b/jX+D1QSIWyQnMllH044cwgTyKyep8
 vnPPJhy3J4GFUeRTzz5OWtltkOIw0Hpex1kCeNtq5RFKJw30WU684mqsn
 6a7XkdfHetRec8SgQVa0U77vgHoArbUi8xDc7GTFAQF2aQB/yUBvaiiY0
 YG/6mCQ1sdP9RAuHXir6rMRd8Zdvt2U5zDfgCbH1OQU7vzivYGATa6L4b
 ZHaWn85P59CfzYYuIa1y6TNX5GHo+hLNEvhKkT5XH1e8RhxDmIu7nVNAH A==;
X-CSE-ConnectionGUID: +eYGL1kuTOqQvWVR2paSsA==
X-CSE-MsgGUID: zwOT5u3kTHac4w41FPaXQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89997361"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="89997361"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:32:25 -0700
X-CSE-ConnectionGUID: 3/NFnIycSGKhd6bH4RCGMQ==
X-CSE-MsgGUID: ZnHnZJlLRuiaKE2Y8U2kNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="277717235"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:32:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:32:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:32:21 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JliRc+mDffIjOZLGiuf1OlcgRShd/8jj4dMvQv85ED4FUI6BGaU4KZvMcVqPkrtMSKgCS2Cf+Z3JqgPUx051zZQeIzH1w1wRMUTvBUS457DCf4WznP1r8lJFW+91ZqsTH5AZ5sgdUfOv9E/IKFOt+e1uRDtC+rfQVh4WeiuddJLjk1ZkAme8bcZaA/Q1fz4UP20Z1dB0GLug88xZxQ0J2jQhIYyIr7OmZUnFeTulVtksomngNpjul2dt3V7LJOhf/9YYj9M16YvO+tiLuWSZkjMlDgUzNVkXIbOVATqTBbLB2jvmV3ozRg7JV2a7QU03M3iCPtHgijtRCmkSETmZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBTF3rFtqIGXA14omU7+ggpXiw25VDEzcqTYFcD2nfY=;
 b=MaPhnbzl1zwcAkMdDUF+be4R1/a9mXWjY4aP9wzlwunVJC7hhpvz1JMdiqP+qGvRipS9FMr4vwDYArReeH8IWM7UZQhkYxVlYtNm1V5xN242mZZLbZP5W3btv10zwoTHeL9svp+Fn+6FlzxSQMK1BtlAccNASinrH4ZToA3n9pD6dkfzY404Cdk8XMHkeJP2+AevIwIhiGVMKxEjxwk2rpmIQdkCZVjWaD6h4+TCa9lg4djE7fzMskL1UQ8UaepJkcKHtwlr1RpyoFfSAsau8xHjgWe5VhA/qn6FHJXG672LKiW1UnvLYrgrmn7UjvD7pM4OxsHEK8/KqVFI77gp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Fri, 25 Sep
 2026 14:32:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:32:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Schmidt, Michal"
 <mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "edumazet@google.com"
 <edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: RE: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
 reallocating them in place
Thread-Topic: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
 reallocating them in place
Thread-Index: AQHdTPGUO4ulikGpbEGSUebSlltLr7bfW02g
Date: Fri, 25 Sep 2026 14:32:13 +0000
Message-ID: <IA3PR11MB8986CA5932FC8AE0F35B52C5E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6238:EE_
x-ms-office365-filtering-correlation-id: 1093e492-1d51-4049-47ae-08df1b11caa6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|56012099006|6133799003|11063799006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0rQ4sjbeg247Sp2/7OF1J/pnckH+rtVLob0BGe/+QjTXjyErFk4rHyRaSmuwOPhdw2DSDf3jLpZ9KxsjXtxTYDUDohgIg1f958UxxrJg0pgytkA4iZuJxeeVWOmJ5/0wSfRzqBVfmZ2R2dgCaE1q1nvsLDcktbkmjdAccstw+L1Cu739Sluis2CoRAH5fctumyexkQzusEedppi9zCR5kqEL5gnOXOtcn+RCHI4Lr27mGCqvWh1/wisNoDsdsEUhYoNd3kBznnY/CCcULp9iRgGp3NEucNTKV19UcShgsECDDaR9HIm4x46k5x5ed7jbLNez4ehDAkqFh4/h0ciREXJzXkpXC2e47Q3IecjKvBeO4+epymF7D8Qf4ywb1My6yZaz5b0v8EyMCQ6Nc5vIYI1UPzXV8Ur+sDBNg1BlDo4/BVVIKYBICrIqKUzBPg/pINiqe5eM+gq1IKS7wouuHJsWXQDiNLzBUxvw0gSpGWtfUaKLOIxoR3GDfmUt8mRsxIX9BY9MSKn3jh3jTMnO+JQvzOHfoMcACE1FsujYEU4hjfID9ZK91IBRR0NUVjjCAmXIHifuLELtsXibkPTfYWFKhvxhfie4YTfl8eaL+GW9trE6ZP9AUJFnuqZ8ik/kg+LHhxkaoKEIREM6bvYFoTsSp7dJCh1wTPsf2Hge+0uwOn1oM0q+Gh9YxaqtDgQbPN4b2zV6PJMPo42SgajiU0tUPFBx4NiaRad4SHl6AwA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(6133799003)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9HgpHYhOaXhtWyEoKSCBlZjnIcGfFgUQ2cAjctVeuhoaIZCK42J5rXuYpCyI?=
 =?us-ascii?Q?BcTts19n/RhjjDpMcGpFngrwtdwdLI9IVSA4ZPj3pbSDoeQOL1gNIIi5I7Fl?=
 =?us-ascii?Q?DbSl4p3+jB5YfeIpm/TCICOX39uYCVY1+X+a+O1FgQ3J3MYjbIon6u8HHKHH?=
 =?us-ascii?Q?6dGdbe0u3zNn3R6IkX4FfNsqexfAimEb4TzIZou5ix4zYG7DIxNXxig+VCxj?=
 =?us-ascii?Q?A2ZJh1z56A9nlwkkkBVXiP5BwVtPJdTn/Doifrx5GggfBkKGfcowRtKaa/bl?=
 =?us-ascii?Q?n6LlJKuChTs9WClEx8QRrhb3BgN9HCpl6tp9lO798VQTTMkjllTl4uRElAYd?=
 =?us-ascii?Q?Ci13jNsmg248t3flS7CvO/qgifdjlC3EzQT8xtOWqaEmeZ47GA0eysi8TYz1?=
 =?us-ascii?Q?cUf9Ms0br1aw0CCKwXllcYQ7hwwigpVNdtflVrOTlylo56Thjwoi5QL4ycQO?=
 =?us-ascii?Q?ZJjWMt1ffIqanup/aJYv9ynrktDfb/AgjO8EcB2L/2oouAMC3HYFUIKBBtSw?=
 =?us-ascii?Q?4IQCJPIE75iP3TefNgTAs1J1A239I0sbaYozw3tQr3apJuvaQihban8F+59S?=
 =?us-ascii?Q?Dbwi1XwHegEu1bISQKAi/wmOI+o3WPoJWA7h4kna2/2Ib6C7DquNLYncPtmz?=
 =?us-ascii?Q?++49AQz5LPICmwiwzNP5F+WjPLaWurL8U3kcWXWj/9dmQ+DCf5EYle+J6d7X?=
 =?us-ascii?Q?BvenFDCOA/PN+6JXSi3GYjJt6NlwVZ6NQvaJJ/kS0PTlxIqVwEf8QgXqKDPV?=
 =?us-ascii?Q?rE2bhnZkcM90l1lY8y9xI/8jud1o8TAy/uA3e6hKIsW7DurK4iOup7x3zpjw?=
 =?us-ascii?Q?xPRpCEzVfZ8GStuMJ//msBMqORLa+aVYGV7t4M6mAuZn0xcOzHPlU6bk50BL?=
 =?us-ascii?Q?pVZYLy5wSYvkZRNwMVZ1vZ+H6IkC4GEwXuGaaupx0EOj/8BW9jxMcfYtmM8Q?=
 =?us-ascii?Q?7ZweLrrvPiKrXI8baep+KINmTj+GkCq5w4hwOOpkZs4oCVo5eZV924aEOIld?=
 =?us-ascii?Q?Eqrj1MSlMEJTbC8Pc/2Bw+tLJTJ4xEHqNnXf/SObuawz2c417UNDtPiGNCpJ?=
 =?us-ascii?Q?9PZQ+Adl0Zsn68KSEYJCqOyrSr6o+OfZjiFjIBjYuFaFCTXvZYjKIUs/hfPh?=
 =?us-ascii?Q?Npj8cKZGpeq6pJorY/8IHw9rUYtNz5WlhM/ZXu6Zmo/bhKO75VezUmPxcO+Z?=
 =?us-ascii?Q?OpphKG9U1gpX8FvxcJ7Ae8ND5THgkUKycFSO4onUNaOoXR9pF4L7QlP/vkzZ?=
 =?us-ascii?Q?B62hd2Q/CzqyjmB+Bi8GNrc2DnRQ+imv8fXjsenSwsH4EvcTjBcBd17xgbKc?=
 =?us-ascii?Q?FB+aPfBxuB+z4kHAOyhAdqea993JjnK45UGjGozksfalBhjyF4kDn/rGK83j?=
 =?us-ascii?Q?9T6xuft7+Qp+AtOB1jfp9HCPeXPdWFe0lVFQjoKTESSipioLTDsWVMoTXoc+?=
 =?us-ascii?Q?vpySCTZn0wjJVJ8IMIM1B888LrstG1vH++vH7w7v7+FVPpRvvUE9sd0wjWcm?=
 =?us-ascii?Q?ma05ThqmXkzg4mL8Wm9CN28vU6rJWvBYKNAyXKSG20V0dC8XVpDvtPty5vF1?=
 =?us-ascii?Q?eNMgLuU6TLYU5EsiZ2qhDnJJRMgZ7Fu1WqLFzV0fVaNwdyOBB7cEgDM9UWrx?=
 =?us-ascii?Q?BMpH72op4OAFoeRl+gLRm5KPbA70BCUm5SdKWbz9tW/IHTXMSAI35TLM+4bt?=
 =?us-ascii?Q?SQWVrtcmL3miBwbRN9nhZ5zAOOzriZXi9OqCOPTET5HdG8FXd/xtPh4UoPVB?=
 =?us-ascii?Q?OllaRBIDew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NF9InN2ewjU0Qb/l1IswfoVS0XEWO5qv4hLHlMtnHGj63sUDmdd36nHHU3mgCeKGa9WQVkIJLvdIUuboIoN/tAHZnOnnvlIMIb0ZFiFUKkAeegc5cPkabSlJqWNU5CPWMkBy03DvIQQ9YIE3Lt8tUQ0A0JVqS97ywl7MFu0tbwUUfFVhNXOIKw7Ruaw366rZUNMRPaM3hsg+VrYU7CUzBgOc9uAp3piI8FEiTPnh6eJhNgF9KkdrT4Bp3f1BMvri00Q8RUzfObYjDOND8UF4p8/pwjR7QmoUzxVZKndkuT50MaBTAGx3D8kuPEH5luyFQirhGCnLE/fqhazXtZ/KmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1093e492-1d51-4049-47ae-08df1b11caa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:32:13.7359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9t4eoxovjrBW3tT0pbFtWUjTlZojGFlUA0Xk94C5ytni0EkfKM6Yx6eYagB2smsmVek5tb+wQsjGIwqMrH5szXgjzqpwktRkACF63F8DuE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
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
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, September 25, 2026 3:16 PM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Schmidt, Michal
> <mschmidt@redhat.com>; intel-wired-lan@lists.osuosl.org;
> edumazet@google.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
> reallocating them in place
>=20
> ice_vsi_realloc_stat_arrays() resized the ring stats arrays in place
> with krealloc_array(), sizing them from vsi->req_txq/req_rxq. That is
> not what ice_vsi_set_num_qs() computes later in ice_vsi_cfg_def(), so
> after a rebuild the arrays could end up shorter than vsi->alloc_txq /
> vsi->alloc_rxq, and ice_vsi_alloc_ring_stats() then walked past their
> end.
>=20
> The VF case shows the divergence. ice_sriov_set_msix_vec_count()
> writes
> vsi->req_txq and then calls ice_vsi_rebuild(), so the old resizer
> sized
> from req_txq, while ice_vsi_get_num_qs() reads vf->num_req_qs ?:
> vf->num_vf_qs and ignores req_txq entirely. Once a guest has raised
> vf->num_req_qs through VIRTCHNL_OP_REQUEST_QUEUES the two disagree and
> the arrays come out shorter than the alloc_txq/alloc_rxq the rebuild
> installs. The reset that such a request triggers is a different path,
> ice_vf_reconfig_vsi(), which does not use this resizer at all; that
> one is handled by the next patch.
>=20
> Replace it with ice_vsi_resize_stat_arrays(), which allocates a fresh
> struct ice_vsi_stats instead, sized with ice_vsi_get_num_qs() and the
> queues ice_vsi_decfg() is about to return to the PF pool, which is
> exactly what ice_vsi_set_num_qs() will compute once they are back
> there, barring a concurrent change of the PF pool; the next patch
> stops relying on that. Copy the surviving entry pointers over and
> install the new structure, all before ice_vsi_decfg() runs. The
> entries that did not fit are freed by
> ice_vsi_free_unused_stat_arrays(); the old container itself then goes
> through __ice_vsi_free_stats() with @free_entries set to false, since
> the entries it still points at now belong to the new structure.
>=20
> Allocating up front also means a failure no longer leaves a half-
> updated ice_vsi_stats behind, with the Tx array already swapped and
> its surplus Tx entries already freed, but the Rx allocation failed.
>=20
> Put the allocate-install-free-surplus sequence in
> ice_vsi_install_stat_arrays(), next to ice_vsi_new_stat_arrays(), so
> that only the sizing decision is left in the resizer.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> this removes some tech debt, but it is not independently backportable,
> as it sits on three preceding refactors; the NULL dereference and the
> sizing mismatch are fixed by their own patches, which carry Fixes:
> tags
>=20
> v5:
>  - drop the false "requesting fewer queues than the PF pool can hand
>    out" reproducer, use the VF one that the code can exhibit
> (Clashiko)
>  - describe the real failure-path benefit, the old code already
> returned
>    before ice_vsi_decfg() with the VSI fully configured (Clashiko)
>  - split the ICE_VSI_CHNL guard into its own patch with a Fixes: tag
>    (Clashiko)
>  - factor out ice_vsi_install_stat_arrays(), reused by the new sizing
>    patch (Clashiko)
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 144 ++++++++++++++--------
> -
>  1 file changed, 88 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 134984077d5d..448d3c7780ad 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -557,6 +557,80 @@ static struct ice_vsi_stats
> *ice_vsi_new_stat_arrays(int txq, int rxq)
>  	return vsi_stat;
>  }
>=20

...

>  	if (ret)
>  		goto unlock;
>=20
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
