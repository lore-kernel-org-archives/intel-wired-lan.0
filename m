Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE5CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75CA140670;
	Tue,  6 Oct 2026 01:40:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tA6_U9cZrbh7; Tue,  6 Oct 2026 01:40:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 745DC40606
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791250802;
	b=Xwv5jlIqy/WWCnFET6IhwBnYD4Sp9cNJuO4xGjaBgZolxUGZF/3oqLILwe9U9m84bo6v
	 iQS56ez4y12gOejojC4WtRa/iDs/AI6lNth2yOKvHYa/xHQ8A6E2vlAwt/qUzn4SHrHJe
	 jN9SlBrhh9AWPZIijbYYeqgWsj/VYH3sBGH7rJXuQCJbRTd9+De4lqAJUDnfjI5PNPMyl
	 HUSB+2ouyde0x7U3bbeTRPlaSyqlgxHe4CpsOjTUpek0RPvFMFbpxi3b1yJAvJ2Q9BqtX
	 LO9bFRvOolhd6HQJcxIZ+7NCi7jwnreS2EkSQ5vqWtRYehGvUZkv3mWMPCFxKJnGG3g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791250802;
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
	bh=SeHQP+aGnlLmq1xpoaGIvB7EXEX6T9sGQ2OuQojAToQ=;
	b=PfzDHwAg6KRLz/+rRlU2tt9UDejq046q8T6SPjrmduK8PI+9OWj27sP7U3l8XkBCVEaG
	 wWa7ongVypaHxF4z61cyeae33RLu6aBpRA+cQGEOKlEMA9Xj5jZyi/c19UFsEZFIz+gKk
	 /sQvKrjqi4aV6vTYGSoAxLfa7NfD9RTiOCEYL8p47UBkbd82feRFeuMcyIT/4+hk0ZP5V
	 GIo9iWJykJgFIG5KDKYeOCB1GqB3VPVsdSmH2qXfTUfzJh/8jcGxVo6XbS5kk4TPPMqoQ
	 9TPXVk2n+Dk6ekglPgKsX/5z/LbVMlVIPcztyWWeKdd3qP49wP0bYYH+wJ/5PaFxibg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="QMW8VJ/t";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791250802;
	bh=SeHQP+aGnlLmq1xpoaGIvB7EXEX6T9sGQ2OuQojAToQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2LXq+KkY0oIZBgykuGild1DJothxJpHpGhBoMthcHkiTmQDWG6MbaYKDXaFluuOgd
	 tbtrjVrgEA1IXNzrUcZDJvcICVSXYq0pGx/YHbEFiviv04b1jrUM66RuKZUTqq0Pv9
	 GeCqTMCzGSPazSQKTtOAzZAEjwsgA75Zwho87zbr1/xBiS1Wj7OMcz1z5l2CHXrnFc
	 MU6vIUHKFXo/JlpqJaTGfYvaQ4AcJsWzWh3qHHMB647tI+q2U8GhZRqt+fjqUGUqg7
	 PTiUJ1QY5xHguHSUQ7oAtRKJ4W0zGFWpYeTeQ+hfGHsNuYTWnEY7NGLJhcagcRbBxD
	 O4zaMxOZ3y0sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 745DC40606;
	Tue,  6 Oct 2026 01:40:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D68D1D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2A2940606
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmAo3PhP8c2V for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:39:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4C4C4405FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250799;
 b=r7CwwxOYGbPVGla7zNwnEiC2R0MAQhMIkljNf8lQZURAqaTEjSZBTkibaoj9KTSuImiF
 BzbZV54ynwdkwBZnPnR1EBr71BhkVaNZQ1JYANuG1aI6CQLxfZVnmFvqjs5xNlUjNwfJQ
 jMPXz8lFBXEk3iJjuKSu//BcQRRId3e16bTewRvgraiWmn7bOLthxISbUqf8/p0qeynrv
 JABIuqBsThHCYKzYYLE8TVL/W9O1YVENQpW/D0lCwz9HEkZdMQHZKVbCGWoKpKMKK5QL/
 2tu2BlHv5J68tBLbwS//79qrxtvncCri35667EoSY4rUnu7NWDM6WpWsfnlmnfAsWSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250799;
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
 bh=SeHQP+aGnlLmq1xpoaGIvB7EXEX6T9sGQ2OuQojAToQ=;
 b=hSYEHtkafkkZ4SYlZbHQYC0CtIQzRy31WLi9j3l4X70c4wwrlTNaIWZkeFuIhBKtobbf
 m8kThxYu2I1JoKb7qXiMSqkRhS362Zf4UE0l/aILURjHix/6JhQZeESfqYxEC13SCN5ro
 EDfbTlrl0IxjCvek+N9xnmCzg9MzSwUPcPIVzlLFdOMKR2T6UOFNcyMKL2E55y+uvwAjh
 ZkppnaHnTmpnJnBFln+vZdEUcVEmWsVOV++wxA1uuVCmlvHfi3w/PO+QYYTILYdndTj1Z
 LwgO4y+rZaQC91+N4me50ah2x4eFGn+RtpoaHSsvqS9tX7fVfmhMUQUaS2dRQPaUA3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="QMW8VJ/t"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QMW8VJ/t
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C4C4405FF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250799; x=1822786799;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SeHQP+aGnlLmq1xpoaGIvB7EXEX6T9sGQ2OuQojAToQ=;
 b=QMW8VJ/tFG7BSDTnTNC4pH7ZxsZ1XAZbpn41yvXhvdB8id9pPmSGbFJP
 ZF7n85JB7gpAivEFT/dFGMM9iHiO9PFaXBVb81a31VkXi0nRaDYz3JxyU
 579JmGKNP/C4rkO3Zop43PLzHq1NqtSKS65WglJ6a/Y8gRd1NaE1Ey3b1
 nh3rVroBQmykt25IG4EGcmhVxTbcI8LM7+MT5G2VKRAs+ZmeuzQ0N9aE8
 Yiyy9rwuxRIGv0FLSHWPH+XdoR1q6DZojIqWaSOnwathFGcZJIrSIPThG
 No2OH2ntKcXCudnb31aLYtfCOBjhT+5BkkGNEdmD4lD5dfl51rtNyi6z/ Q==;
X-CSE-ConnectionGUID: 64sn35o7QqeDlzCLXyyf4A==
X-CSE-MsgGUID: XObrvnlNQRKNEvdZi1nzlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94641907"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="94641907"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:39:58 -0700
X-CSE-ConnectionGUID: f0TDrvS/S0GPRV+VcaRqPg==
X-CSE-MsgGUID: I19hJK3QTBemNK7GvtTo6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276517906"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:39:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:39:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:39:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr0UO9FhE2oiClI02OrWYEnp2sfjJ0T8PZJls/ih61n5TUoqWi6e5DG9a9s+3v8g+cnq+tdr8AiTr9ARsvHN+s/3LGj6q/4jpwIAVQ46bw2Ei3Ibb8UHdj/Wx0fuugKtHjcstxjLc3X3GtW2ER0dh00AmKxEcPf0jsZLv4eyQZThDeIlytnh763TwBhnICtVZOUHrDT68Emv/weqzpncPWyEL5s6xM5iIs6gy3uEbCqsbyFFNC9+LXmEGcMdN4MCDLnEi278ajlMoOjxGiP1wHZ9Pze6F8CN8iA4RpMyBnsU4lYFFTC4RNjJq+FcwdKX8i3A/uIulLcDjNM2GEhXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeHQP+aGnlLmq1xpoaGIvB7EXEX6T9sGQ2OuQojAToQ=;
 b=V2tvfa8pCpRegIfaxwY+pC/Q877L0Tmaq65gQJHowZH2seNJd596ixZSVElgBqTnHbKb2j75UPWtcBLuAhAi55VxXxZGM4Cn8kjzItat8SQsfS0j8qnXZK7eDSmTpOZJzUlUvp8WEFdAcbEd1rLqdRvn1ZRZJ6t6oXeM6iLHlgv3HupBardF+9Sl0Yc8KjjnYXOOcUQT9CSIQNr9OxHIYxoe4uXQ3nGInIrHXYGdhwPq1dH7W8xIwe/LFzuJE9uMtztfiILZj0KiMqe+XBIxA1HlklSYEPdyflHX3L1FcHlDDkZEmjZTdQUa+eSzjTWxjZ9jxlWm+aqMffJPR+LOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:38:45 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:38:44 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-net v3 04/15] ice: set in_use only after preparing Tx
 timestamp index
Thread-Topic: [PATCH iwl-net v3 04/15] ice: set in_use only after preparing Tx
 timestamp index
Thread-Index: AQHdTUnBeDxS3WAiCEm41f2f4pakRbbvzCpw
Date: Tue, 6 Oct 2026 01:38:44 +0000
Message-ID: <LV1PR11MB87908BB5EAD73A91054DE3D890952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-4-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-4-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: ce9e309d-cc58-4a67-8f5b-08df234a8f58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: x7bLB6gc009BT42978rlX+xNgdtnTnrob/T1X9XZKVJ5ixWSyV/QVRSHtch2NbfjRZwinb/KXaDbT+nmUN0xjfnFQIEy8oIcY+sF07lXCQnjimcz5aKbJuI4+C7NOEcWwaVwBZ45JxMe4gz92i8NdxN3QxWIFshJCybolev0fE0WtwDVrVbGXV0gJNpfdjNEWC5N+f8UT9MCTTG8jIvB0eErW2VvKRyVGU7Wgh6in43SCt9S15Mk2DxGxuC6ewYaBq9aYjztV87pLnciwSdIxphO//mrKIAHoOLzclI91Qc3B3vySefTv6XlQmV/PeTyKMn3BnQRIyf0a29rBy8OI6QNK8kCa8PFUrESRX9zqGeAM5UIuj0KcNen+FZfABsh/NxO4greioufwgwtc0wIJpzmTz0WQVvtAiDnzq8kWNDTFHo8s31pP/fGG2PB9BwaXCjSANgPG+tfBbV3AOWA6BN7VNh38PInx9qdGoozZov/YHB1gQ8K8DDhzPI4TjqaPTHssht5FgdfIICGSPXHA5mj6hYrp/59QS6W6gGeUa/AAsuM5WFWpgjQMZl8xIhEnSFKSqf3Ggg4ZJ7TqRgznSyWZ0xsPnH1GgTQQSHQYYm5eVWOXM7l4xB/PFpnLkxyNuFmLDdm9Xud7OxGQ3Aj+OYLYLDL60g2Pu3q7Mesg++PRUlCt+hgDeIp5nQOf98V
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGNla3FZWXJkbzZVMFpmcCtPT213dXBsc2VYeVlzanl0YTBuS0NiaW9LTXV6?=
 =?utf-8?B?SDRMK0ZKVUdmVWQ4M2pRSmlhQWo5b29hTkpVOUtiS3JJWEV1eFF2YlVDeGdE?=
 =?utf-8?B?QjRnSEdlR2pFNmdpZHlPZGxQd2hEb3kvM21OQm1wMEJUQndSN1YrOVNJOGwx?=
 =?utf-8?B?aEI1Ui8yVmlKOHdoUzI1aXRQd1Vpc0wxc0c0Y0RNaTVKS3ByWnZ0ZW15SERK?=
 =?utf-8?B?d3pCc1NWYjFhbkgwb3VqcnFEN1c1K3VoYkxVQm1wdHloQ09Ea24za3RYdTU5?=
 =?utf-8?B?NEFmdXJSbDlaaHROWW9GRjFUYVJNUnhVKzUyYzdramdYZGVNMDJHU0hpc3A5?=
 =?utf-8?B?R1krUUdHT3NjOXZjSEkvU0JoNVU1VGQ1NzV3OGdKYmswdmZXUkQ0Y3VKUTM0?=
 =?utf-8?B?bko2VldhR2FJR2E3NjlTSmZtZzgzUWJza202cDhlSjlsSnBwajNYKzh0TnpK?=
 =?utf-8?B?SmdwVFBzRCtvSElLYnZuZHlmT1dzK2hMc1JYUisyVEgzbUtQZTI3dTE3ZXFQ?=
 =?utf-8?B?bGFKTDdUeEtKYWRmN0tUdmZ6R2ltL1BVb2dCdkxxcUVzSnFmQUhuakZDSHBM?=
 =?utf-8?B?cjQ4ZTZNNUFFWUpnVzJzbEsreWlZUmIvbjZYcWREemVad2lXRlRPbXJCU0lk?=
 =?utf-8?B?QTNwbHkrSmNzV3VuRWZHMG4vUUJDQVNaR2dKSHRySFVhMmpqOU9WTWxzdS9w?=
 =?utf-8?B?SndEdGl1ZC9TVndZS0VRQ2N5MzJOL3BUNllsWmNqb0todHRLREVnWmExMzV3?=
 =?utf-8?B?MHNtdmpXZ3VGejVFUWVvYlJMUTc5RzBWUU4zajlVMFppUWVSeFFXelJ1OGlS?=
 =?utf-8?B?dDBmaWQvM0JLbDR4cFhsZ2o3cmo1aEZtNUFIMUlpdWtoQlBhYjFDeXdFYzN3?=
 =?utf-8?B?Z2x2bEZDV1VacE9lcmJvcGZCa1ZOU1BHZ1FPa2QrZHRBeDVoQjNMcTlGTVpO?=
 =?utf-8?B?TFphWjZ6WXR6ZEhYeXlrQWRGcmlUK3A1WGFONWtHeHg5QllPN05TNGd5c1po?=
 =?utf-8?B?VTF2a3dpNVFQeVM3VkdDcFZjanBibW02d28xQlQ1UDB4NHpwdkU3eGtrYU9B?=
 =?utf-8?B?cFZKRjFud3ZIY2gyYjJ0SW51amxRczJEanhjL2w4VGlDMW5DaS9HeEw2Qk9J?=
 =?utf-8?B?WE9VNlRiSWxudE5WYWpWMlloaUw5c0dQTU5saDkva3RlWjBJbkI4ZURiTndm?=
 =?utf-8?B?NTA1eE8rNFBNTFZ4RHhZT3BvNytYdE03eGlTNnJLWDRxbEVCUkIvejlnTnZ6?=
 =?utf-8?B?Nnp3cXozZFVPUEhUamh0UzErbDc3aDY0bzRKYXhqeUtFOWJZVVZQMlBYemZE?=
 =?utf-8?B?TEx2aXJmMnJEbmhSeEJINzBDUDA5R0Z0M0F6bXlOVmJaeHNjRFdJK2lZSVJO?=
 =?utf-8?B?YVRnTUpBVktPcVFPNWxjeHYreHRFcmtiZDdjUitJcDdwWmEyRTZCYUFNeDZs?=
 =?utf-8?B?M3BIRHFqNmU3YzljNUtsWFMwYlNtbmpFMzVwZmdpWVJpUjZ5OEZHWlczQkw5?=
 =?utf-8?B?LzRnVzJoak1UZFlMcE9kUGYwTk1BNnQrNFVyUUJpVUpxSVpYaGFJMkZFRW4z?=
 =?utf-8?B?d0xkenJmcTMyTTE1dk5DYU00S1hEd0lRYXJ3K0FBZ1YzWkx2Q0tGcWttMzFM?=
 =?utf-8?B?ZVA0cWo4VEQ4REp4QzlhL0NnVVJyM1NxbWNjeWZWNy9TT3I5YUQ2Sm03WmU3?=
 =?utf-8?B?VE5YNUtOei9TcjFzcjlLNUFpdUFrRksrb2V1S1ZmYVZaY1VDREFWcXZDb0JF?=
 =?utf-8?B?YjhmQXYxTEhCV0RxZUxseHpCTjNobndwUnA2c3R3N3R2Z3N4dEsvajBNeURW?=
 =?utf-8?B?K1QxZlZrYjI1bkVxVVZUZ1ArSVBFZ2kyMlJGeGs0U0w0cXpaMG9iVUJkZWVD?=
 =?utf-8?B?ZWIyYytEbzFQa2o3aFh3dXRndUZJZER6dnNjeUR1N1lHRGcxa1NrSG5jQ0hl?=
 =?utf-8?B?cTFLNkV4MkZwV3UrbDlRZmwzRE9sME51VHZMamo2ZEp2YUd0Q2Nwb28reDFr?=
 =?utf-8?B?dUV5amQvUFBhRmZMeU83TGhKaE1wNFhNRVFSZHhmQUJnMU4yd2UyakVUZVNl?=
 =?utf-8?B?blFFU3JMOVpXVXZDbjNhNDRTTjdZaGt1MTlaVnJJNU5jSCt1c1ZrVldwWnlq?=
 =?utf-8?B?bFhjK0Q3T3dGOVdMM3RFZ1Y5OTNyc2o5Y2Z0THJQbTlIRHBYQUFxdnRBcmNO?=
 =?utf-8?B?eEd6OWhEcmVSZS9jN0RsT2FBTHlzL3lQaGlMQi93UEVRMXVyODYxK1BIU2VQ?=
 =?utf-8?B?STVxcXExZ2piN2gxZ3NyUDQ4bUxyVlpscGJPQ3RzVXFtWGltSGl3K0c2K0pq?=
 =?utf-8?B?U0xkWkYzQzJudFg5KzljSDN0eldabmJ6WmlTc1p4anVBSEZvMXY0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4e8YBKmNQ05Vb2gCW0iU//jCSGHcESG3BE2zu+vpA25vsooG8eVLSPxUTun706uPxSbcJGewOb7hjIEr/oT3M1iD3VTnVTmk3yazWRRkrogVQGjWBY0vfYDIrHBBVYoqsMSALHZ6PcRE3OFPFUwPF4N0JxlkloY8GnoyxKpRQARMRU5LjmLWvV69YEciaeovB8EVJS932wQRPf7DDW9DqxAwlp8F+8/+wBt764M8e+WygretI383Es19aOiSI5Qj22ExImqGy8eZjHDD8WM6mYA2ESyBtDOwtVRoeYQTILc+6cadDSCDUhhDPUbp9owPFCu+qptyvmmKm4EJMDV0lQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9e309d-cc58-4a67-8f5b-08df234a8f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:38:44.8841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6Cgs5HPDvFjPBwu2vN9P99FLZkp/6ENT6/yXAe4K+gaqplfrTYF1SKEpPMzvgbgwLcS91nL7FA7asO5q2SAu+/+k9MWa948hd3S3ouLSmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDI2
IDQ6NTcgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+OyBNYWNobmlrb3dza2ksIE1hY2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRl
bC5jb20+OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEtvcmJh
LCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9u
eSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IE5pdGthLCBHcnplZ29yeiA8Z3J6ZWdv
cnoubml0a2FAaW50ZWwuY29tPjsgS3ViYWxld3NraSwgQXJrYWRpdXN6IDxhcmthZGl1c3oua3Vi
YWxld3NraUBpbnRlbC5jb20+DQo+IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVy
QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMDQvMTVdIGljZTogc2V0
IGluX3VzZSBvbmx5IGFmdGVyIHByZXBhcmluZyBUeCB0aW1lc3RhbXAgaW5kZXgNCj4gDQo+IFRo
ZSBpY2VfcHRwX3JlcXVlc3RfdHMoKSBmdW5jdGlvbiBpcyB1c2VkIHRvIHJlcXVlc3QgYSB0aW1l
c3RhbXAgaW5kZXggZm9yIHVzZSB3aXRoIGEgcGFja2V0LiBXaGVuIHJlc2VydmluZyBhbiBpbmRl
eCwgaXQgc2V0cyB0aGUgc3RhcnQgdGltZSBhbmQgc2F2ZXMgYSBwb2ludGVyIHRvIHRoZSBza2Ig
aW50byB0aGUgYXBwcm9wcmlhdGUgaW5kZXguIFRoZSBmdW5jdGlvbiBtYXJrcyB0aGUgaW5fdXNl
IGJpdCBmaXJzdCBiZWZvcmUgZG9pbmcgYW55IG9mIHRoZXNlIHN0ZXBzLiBUaGUgSVJRIGhhbmRs
ZXIgd2hpY2ggY2xlYXJzIHRoZSB0aW1lc3RhbXBzIHJlYWRzIHRoZSBpbl91c2UgYml0cyB1c2Vz
IGEgbG9ja2xlc3MgZmxvdyBmb3IgcmVhZGluZyB0aGUgaW5fdXNlIGJpdHMgdG8gZGV0ZXJtaW5l
IHdoaWNoIG9uZXMgYXJlIGluLXVzZS4gVGhpcyBpcyBuZWNlc3NhcnkgYXMgYWN0dWFsbHkgcHJv
Y2Vzc2luZyBhIGNvbXBsZXRlIHRpbWVzdGFtcCBtdXN0IGJlIGFibGUgdG8gc2xlZXAgc28gd2Ug
Y2Fubm90IGhvbGQgdGhlIHRpbWVzdGFtcCB0cmFja2VyIGxvY2sgb3ZlciB0aGUgZW50aXJlIHNl
cXVlbmNlLg0KPiBBZGRpdGlvbmFsbHksIGJsb2NraW5nIHRoZSBUeCBob3RwYXRoIHdpdGggc3Vj
aCBhIGxvY2sgaW5kZWZpbml0ZWx5IHdvdWxkIGJlIHByb2JsZW1hdGljLg0KPiANCj4gSG93ZXZl
ciwgdGhlIGV4aXN0aW5nIGZsb3cgbm93IGhhcyBhIHZlcnkgbmFycm93IHdpbmRvdyB3aGVyZSB0
aGUgSVJRIGhhbmRsZXIgY291bGQgc2VlIGEgdGltZXN0YW1wIGFzIGluLXVzZSBidXQgcmVhZCBh
IHN0YWxlIHZhbHVlIGZvciBpdHMgInN0YXJ0IiB0aW1lLg0KPiANCj4gRml4IHRoaXMgYnkgb3Jk
ZXJpbmcgdGhlIHNlcXVlbmNlIHRvIG1hcmsgdGhlIGluX3VzZSBiaXQgbGFzdCwgYW5kIGFkZCBh
IG1lbW9yeSBiYXJyaWVyIHRvIHByZXZlbnQgcmUtb3JkZXJpbmcgb2YgdGhlIHByZXZpb3VzIHdy
aXRlcyB0byBzZXR1cCB0aGUgaW5kZXguDQo+IA0KPiBUaGlzIHdhcyBmb3VuZCBhbmQgcmVwb3J0
ZWQgYnkgU2FzaGlrbyB3aGlsZSByZXZpZXdpbmcgYW4gdW5yZWxhdGVkIGNoYW5nZS4NCj4gDQo+
IENsb3NlczogaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwODIxLWprLWU4MjVj
LW1pbmltaXplZC1maXhlcy12MS0wLTlkMDczMWViNDg1OCU0MGludGVsLmNvbT9wYXJ0PTcNCj4g
Rml4ZXM6IGVhOWI4NDdjZGE2NCAoImljZTogZW5hYmxlIHRyYW5zbWl0IHRpbWVzdGFtcHMgZm9y
IEU4MTAgZGV2aWNlcyIpDQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5r
ZWxsZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2VfcHRwLmMgfCA5ICsrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4
YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
