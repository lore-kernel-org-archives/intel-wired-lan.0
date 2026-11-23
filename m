Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15129606A31F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Q5zWUPoM;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HV3yJfov;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jcn0LJAC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFF5A40522;
	Mon, 23 Nov 2026 07:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fBicDVfXiEv; Mon, 23 Nov 2026 07:15:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB27240519
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795418101;
	b=fOvIxaXBQueohg3HK5vAYHDDBKNuBTZ52pVoCvSJ4bbhd/yPn9R1wRNrJuttbO5Kaawn
	 9VuMScjOiZyaEumaiJs49bQzIFJqywyXwRJeXVF6qdyjsob1PsvnDsjHXHMdi3+6MmGjh
	 htpv7QAzbC1UwZEGBXQbUncIo1q1VH++hDlCjPWdJpM1qoyzutCR+AHoTphNNr4WbhamF
	 tIg3kDeiJZeoHTbWeRcqkR2GvFs6TP/sTY1xbwgLDNuXHCISI+HavZ3MrIKvtrzj0P67q
	 MX1KYQJ0lVdKTpVPz+yg2X4GW52hIdPznpiN7Kx0HqfUaN0cVz7TdOZ63leKCGI0BJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795418101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
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
	bh=QOcFW9gIVyqv58LB3ES1Xd3FCBP/mFGVSVogcMHirx4=;
	b=iNJFL9EK3zjkj7wmHzbN9tsfXLPRzvXNtTRVfti7USMwNQulil+kpbNO3Ru6KfTzzRVD
	 NL+lCdYzGEz/I2uv128ZYJrIahN+P9DZJLPtM8rf78Iroc8JI1ma5XJCRMIPe/4caHvZz
	 2AafMGmmRdJN1mGL3unIZ1YzhOMAEUjAiqWg6tRBvefQOsjpjn3OTq00ubCvMmGrE4gCD
	 iR6F2r6n1xvDKvxguIOxJjUC6mEpx71CuedzuMjypevraciebHjnHwSPkiNEcbqaanq/0
	 HYsd2KzIhf0svVJN2W1l7uTbU5mmEUMGKu9ChMPXXmAJorvupNOLv8WBo+JErFELUmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795418101;
	bh=QOcFW9gIVyqv58LB3ES1Xd3FCBP/mFGVSVogcMHirx4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q5zWUPoM72KGhDGPz0DnoxTLalohm/yTO3BGv+nsT5mQOrHiFkWpxtx4yV2c7qL55
	 SNPEq6fxfu6CEG3cVycSN/fkQfnGcavsTMqQVHY79eeO68Ua2LNMqfNloZ/6/4jORw
	 9OpuWCoOxYEVuniI6Skf4IYFtJCoXtqB1uHPZnuuP/t1lY+XMt80eaaaM2FEHHMP2Q
	 891easc4lFwMjJrgMNKStl/emGDWe3AI8KAarMBuIz1Ptv74zTiAIFZT5c0m3SlEWd
	 H1uz87nGvnTGuBk7QFWa53w6VzWUuJPA7Oeptsp8arU/oXtc8gGJzwECFlOEWCcC4g
	 pBa+EBe25Mwew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB27240519;
	Mon, 23 Nov 2026 07:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C1F94310
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A86AC400E9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ov03Lm793VV8 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 07:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B2DB940081
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=ayush1x.singh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HV3yJfov; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=jcn0LJAC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2DB940081
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795418098; x=1826954098;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QOcFW9gIVyqv58LB3ES1Xd3FCBP/mFGVSVogcMHirx4=;
 b=HV3yJfovX1E+uIrGh6Hbomlo7ur7gnWiG8l2NPejR2LJdhufF3W2MSj1
 wsgxAKLfNnQ9TudKmufQGEgQeYWmQQr+8SRwenxNdz6aRbkKmt/iadMg5
 QiqhWpKcwhXXFjeCX2+tQsowRffkQHw7Tat5nSIFTqkItkbt3eHgacdN0
 1E2H1zRbfs2ruDUCaU7U2h6xN5IwGDvoVaHxeESQxJe/OYfv5qgfUeZwt
 ImH7cfgSm5KgXvFYTxneneXeKEfePNniYSEcge6pe3ckw88lOcbUQL1jY
 jDY8VWP/z5ULdsum2w7Ita16qmOIP9Ei3+SqKBt9DvQAttHxKB0G1YwOg Q==;
X-CSE-ConnectionGUID: nFgCp1qNQsmTYvioljchyQ==
X-CSE-MsgGUID: 7DQb4LN5Raq/ZvDiTaYbDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4227160"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4227160"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:14:58 -0800
X-CSE-ConnectionGUID: DPGUCm4YS/mROYyWccl5ug==
X-CSE-MsgGUID: NZwRXQBtQDedtyQW3fYHbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="12932272"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:14:57 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:14:57 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:14:57 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:14:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOcFW9gIVyqv58LB3ES1Xd3FCBP/mFGVSVogcMHirx4=;
 b=jcn0LJACshnN1IQ2D7Uggch5t0YdT1aejl4CPia9sFXNN7EesxnoSY7BC3lHYp2eG7dWs5Tn+xhRQEquqnGbqyNgBgja899/odmCWBVEujsEt0xUZlNJnl4bkS/9VTVobHRpRg1H8hkJDCJmsMShMJBZrVkvnOK57YiPDZiQVsI=
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by PH8PR11MB9854.namprd11.prod.outlook.com (2603:10b6:510:3c4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 07:14:53 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:14:53 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>, "Olech, Milena"
 <milena.olech@intel.com>
Subject: RE: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP
 command
Thread-Topic: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP
 command
Thread-Index: AQHdTT4H0y4HrBKONUCrziJIKaBXirc7mi3g
Date: Mon, 23 Nov 2026 07:14:53 +0000
Message-ID: <BY5PR11MB397684996B4FB0B4600CA16FA5452@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-3-grzegorz.nitka@intel.com>
In-Reply-To: <20260925222824.270640-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|PH8PR11MB9854:EE_
x-ms-office365-filtering-correlation-id: c8eb9762-c753-4456-49a7-08df493178cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|56012099006|4143699003|11063799006|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: SFJtDrDXFSSBeXdFNFm9SYL4TrOT5c/a04XiALdC+zytRvuwBkQxbC1wa8M7El9+RY2XXBzwL4iHLuTe0sYLJ7rqyJgfbmlnjVDKsR2/mA24xsIwClaRtgDRJgScxwxkSu4cWX6udrcrNhskNWGemONoOI0oF8yp++1IoxyIsUoyt4Iw+zni6/CIfZnzMxozbnC1R2EXBMoOuQBKSlQ8JqY/7al0B+7dDnWgshuem1sN6C4yVn78CNBWMNFeo7MVghbCM01vS7To5BHBwYiWT6Zksem+Ydp+XxMtBV6iaqbUW34NPJyoFUl25EQeios+bAnM+tXhVqLB1U5/ja27OlAybE+wSh2Gyanf7I+lWH3ioSRsRsZFuxD2EJPLs5nkjS7aeTpqR6adJ3XIIbZuZcla7t+WYc6VRg/mbw5BkJ3FNTJdmylyKxwyXeghnQLO+NzWjE99/Kkew9zdkGa9z/tnIv/nt9VIgKmC1btY5HtOdYLhUe1gKpt8ycDV3wEFJn5oGuDg758Ik4DeYHqc1nfGYlAS9onyph7D85c3dYNcVwe7Ck2bMpDA6m5FQXvkvJY7RodCoPvsJjSlSaUx2XqVI8Mtn7kX4Q0rTNi2RRIHgdrXqaaSq55OV2A583wFj9nZx95k8GcjgP/ouueTLa9b1qLjJZyLbVwxgn9MqLyPWFyoFDvGfEwqzBFh86Ae289o5WilhiVvXzbE61/nGLAKyr+BV+j5zFwGulpS45w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3976.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uIqjwLfjQ5awG9KbzLAvEx3sifbDjfDhXa7tc9wnc8CyODMHUiAMpSGlfVT9?=
 =?us-ascii?Q?a4wRMUx9roq12e8U6K7J3UZWbg8mEGCrt7mBDPdW8zAutN4zNPlcEmaXyDFx?=
 =?us-ascii?Q?Tlshb3fleA1VXKzgbg4j+nuI2Wb3RXgs+QfHXkHiYOqz7h9Ey1vjlcQ70QWz?=
 =?us-ascii?Q?EDM88wqWbElYjlLf6PtBOUuFlgYlnlFim/G7oZDXbwn4oSbs2mUvLxFvN0yZ?=
 =?us-ascii?Q?cHrLwt5KFQJ936GhorTpk+clWa8UQX3XyDbkfXlHuU2AyWK505cXS09PxYdR?=
 =?us-ascii?Q?rdZeUd3rHoOw2CRQV1OW93WTDjrlu+DJBkv4koX14917MAs+5i5XLpcFV+8N?=
 =?us-ascii?Q?7TfCG2SoEhi2/0zcd40HnKFPxrST3n1cs8/HUXFhuDayzP8/188mKK+9lrYU?=
 =?us-ascii?Q?3cVZUbDAFK8iTstV+FWDYpxYmJZNvz/McFImXE676sH8BcAoyFGNQ5OtZXrM?=
 =?us-ascii?Q?XHHX5baJpmha09gDySinx1vKltuQ1LuHd5Mv4Vo5PvgzSWn9WEGqOODWvoIy?=
 =?us-ascii?Q?DVkW25sf9yht5jPGVh5neZz9ghA0hozDbRUuuZqJWAdxKl1qxxY70ye5WEpG?=
 =?us-ascii?Q?4u7L8kdLiiNlYdu4BkVrjblejdQbNg/CNVrsXogX0kdOb1ZtfG3m186tRNc8?=
 =?us-ascii?Q?ynkQxN9Sg6waudhTZZE8jt+5Dn7QpbRUOE9m2/05UdAt6gyMRknuqFxFq2cK?=
 =?us-ascii?Q?pbokBInTPBSMS+XR5Q+Qeqh/agsOfNnnmsmAqZKXFlXUweobgpCfEZLnykCs?=
 =?us-ascii?Q?k8rCVZQP6ySxYClXcB585oAws308vptdKBqYGNJAMwxIvMf9mT5Ht8J4M8Ph?=
 =?us-ascii?Q?c3EHqMsbJutsG1sQVcW+aBIsldVdpLWzjHFLqmQeyueTpLxLd5lgal0UrlZc?=
 =?us-ascii?Q?8alUfyVf3ggUTpwrOtK45oKe2W1FG5EQd7f6C51Hodnnx+Y16DKd2AG97HbI?=
 =?us-ascii?Q?upZ/0xIu7yyvv0Fjk81GOq9ZPPMawO4LJtMMdN+F06TJOQ4i4XBFyImY7TB4?=
 =?us-ascii?Q?X9r/xgKm4WtMBa3vBu1PGrgv1gRkxHv+cm4x2z39KNH7uuj+KbPssoILuxC3?=
 =?us-ascii?Q?+NKzf1pLbBrlRMZSsfS1A4o5GNMnyXVThB80+vPkyxK+H0NEXYbt3RmHiYHW?=
 =?us-ascii?Q?sVnhqOFxVif0EzOG3c9WO3PN3izK2St3myc/ipyyA6jmcBCygsEL7y9bD/2H?=
 =?us-ascii?Q?Yvr+eEPPKfXb17icFkamvp5NQ7lsu1NuUZR4ScfiJliBc1WQTwSlAfVjkBqL?=
 =?us-ascii?Q?ITFg5ETS32s/JVoIdt6DwzvsS8JT5jqQU3ghNP01OUSfJ+dVoakmrl5F49Ol?=
 =?us-ascii?Q?xuJm0PBXB5UjZ6pt5HWhyanxNZHt9g28Pld9FTVcz6Yvf9w96H1Bm/mRuPOw?=
 =?us-ascii?Q?lCPRqZOFWptjhtftvfC8Ocw00Y+F9nR9XhLrxI/5n7irg7bk50RGFLFFBj5w?=
 =?us-ascii?Q?YsTKhBIFRo+eaJtiyiIWqXdWlb2+/HP3KkhIzL1euAQ6pMlk9kATcYkvgFfJ?=
 =?us-ascii?Q?V62aMccx1GExT984e34HJAVDMfuTqdPelDkAaKxUFcfAhcB2TdhoerrAqMh0?=
 =?us-ascii?Q?Fh5Zq6n7Z8Y+eIQYsofVissXeu7Kdr6JeRUzpawQcR+uvQ+F2qgOI2dXpd77?=
 =?us-ascii?Q?zzxEWb2ZmAqw7PkehCnMWepLj9cdxApc9RPgPn3MthpbsABKEIeeWvi+kAN/?=
 =?us-ascii?Q?dRewV2RYqJa1+dWYxSh+nPvnhiNSL4JEcyKcPrN2Hh6f1AywR2Jse1yZiF5w?=
 =?us-ascii?Q?s2FC+8VDQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: av/jCLIDjT+1Y1vF3ukxYd73yoZMMmTKbQbVNN7yIoIk/Kz6EdP2/AnHfo+Rl6PWmqMVuYpZmkoznGd6PW8H6bitqz2xrR2+ShCNTB8liNlQ5A1og44ypoCWCel8mXMaCFu/zCz3AbwGI6lqCkmrOeqwFNoPi5NJdBno/X368xMU60+tbIfQj3KPwzI7A9E0oIXqaXQdoFpUlg/foQyr1mqYhChyXHOqtLNDdRfUY7azE5A8CAu8JdxTmyRDr7XY581QSShJpDPjDt6rGnT1ognX+dpWkq0aoMx6KhYuG/oyG92ODEKjXta4zG0Hj2GOSTisQdprJHUVQZMkOBXknA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eb9762-c753-4456-49a7-08df493178cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 07:14:53.8226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojzTZy7UJUKxtLzLxSXvkAfkXBtrsKZ9lAv1xwAD8pRB2QPx2SbrfN8OVtt+PJzaJ0wVO73w7JIC+/jbyN4EUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9854
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Nitka, Grzegorz <grzegorz.nitka@intel.com>=20
> Sent: 26 September 2026 03:58
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; richardcochran@=
gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw <przemyslaw.kitszel@i=
ntel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kubalewski, Arka=
diusz <arkadiusz.kubalewski@intel.com>; davem@davemloft.net; edumazet@googl=
e.com; Nitka, Grzegorz <grzegorz.nitka@intel.com>; Temerkhanov, Sergey <ser=
gey.temerkhanov@intel.com>; Olech, Milena <milena.olech@intel.com>
> Subject: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP co=
mmand
>
> The cross-timestamp capture path programs GLTSYN_CMD with READ_TIME befor=
e starting the ART/device capture and clears it with NOP afterwards.
>
> It was assumed that this change was needed for E823 devices, which turned=
 out to be not true. The hardware supported by this driver does not require=
 it.
>
> Since GLTSYN_CMD is shared with other PTP operations, touching it here on=
ly adds a potential race source.
> Remove the redundant source command programming instead of adding another=
 guard around it.
>
> Testing hints:
> Verify crosstimestamp path, for example with phc2sys tool, on
> E822/E823/E825/E830 devices. Please note that the phc2sys tool performs c=
ross-timestamping by default when supported by the hardware. This can be ob=
served when the reported delay is 0, indicating that the system time and PH=
C time were latched simultaneously.
>
> Fixes: 88c360e49f51 ("ice: Support cross-timestamping for E823 devices")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ------
> 1 file changed, 6 deletions(-)

Tested-by: Singh, Ayush1X < ayush1x.singh@intel.com > (A Contingent worker =
at Intel)
