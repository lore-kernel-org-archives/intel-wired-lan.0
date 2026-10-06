Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0798DCA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4E3540680;
	Tue,  6 Oct 2026 01:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SGMidsSseTI; Tue,  6 Oct 2026 01:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF09440681
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791251390;
	b=HYaY87148WxX0etc9p7ZLjPogGDQm+EB1/9EZhI7XuyM13Rs2eoidPRPOZwJJXYPPlbv
	 KRE+3iBtQVu8M/Vaw5b21n/iDr47hnoXcDPSJ/1ynaA5nNN9rL0+A1asQbaQKgkDTXf29
	 xBj3eBrAitf3BXMhoIr5XInQpxtlkfMHtCINBtWo+w/FXDEz5jcweCuvShRclnhiSGpMV
	 U3oGKVcfl/6lvtDRjR/3E8Ja9GH9qxwifK3hOPelKL0n5Mi7WHv9kRAwzz+4KJmbhkxfJ
	 lWl3rOin/qdJYH3V/gUma+JtwUQ7h2sOvMWJi5QRLqIIgX2W9ARMJWVDjc378FWK8Xw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791251390;
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
	bh=9z9sqVcSEpS4afAQJesDVYUcjz+ZrEtcuQLu77Pzba8=;
	b=YwijCerUY/94vKnEiHXv6lqLd2s9nur86IXc09R0bUlDkfM1vVGBpj49R/d5s8mJTjvc
	 CadTwtL3iQcIeBXOLjK+wxkYSePj1trvgdQk7bg47bk2wcDLboBDTIVy/XfoNrdA6gGkJ
	 RB7gjTJ77w6FR7cSYcuIzqjt/TxFJH/eDK8Gsqx1h0BgWOkvXr/ibtdklP+uSiiixGP8r
	 nf/GDVdTYZVe8CfsFy25T+GS2hJUHkhBTlrc6N+zXTfqRIG/VPyeJOC4hx0uYV+84h2G3
	 5JBH7mY/Vj9YnoNCClGCc+XbQQ3vLKMWtuQ1Mohxug3glDnoAvomBKxjPQpN11likAg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791251389;
	bh=9z9sqVcSEpS4afAQJesDVYUcjz+ZrEtcuQLu77Pzba8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dZpWQsR7aMdqsqfJT8Wi39KPnAGwEdhOnFJjw+9t5A+dTCCJi8OR3M9WYKbhUromt
	 ebu+RBN4JlGk3qyNp2pr6+CTNxdL0HMi5wrhudU39h7oFthcBHjARUgVeV/htKEGPs
	 Ei7UCOBTTOfqdH4io3l+ozqDcWTcZg5v2CYD0Q9XL2ajQSeUE7y6C5XSxD2SxBS47S
	 Bd3ll9eAz0CjCAGbax4BmGnTjEZSWicu+eiyBgFyZtotP0rVhhzTe55wYQwSWJCx1+
	 WhbPlW2KnEufIIUCFXz9HZMHAYgFE7yfGo9tOUYQCZhLb6uk74XD5mP7a4WyOo6M6u
	 fjGREe0Nvo58w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF09440681;
	Tue,  6 Oct 2026 01:49:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E32D32F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2423860699
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v9L6OqHPUBlk for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:45:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 35CA260666
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791251151;
 b=Y6BGPPGuqq1NQ0Ox2TqGiUl+WX+Z9jJ8IJ3kvQvosZROZbx8A74+TFoO+S9Ay1O6uKzg
 V3HH8+dX0PPtwOZjs4SjZOPItHpURjBkO308UZVh9XB2oIywBud4xBJUIH/bsXHyw7xIM
 JBv6Kks341e0QfFj8RppzMc9nxn+f9sNtQ3F1wz2T7ypPYjtKNW4lUeh8CCL+SyfwSCLo
 DkddK4XZ9hW6W+87+XyvUr6Uuas11JRpR4wIIC5RvpHhLeQ0j919+Y2jxguI+Qc5qoY1d
 /CX4lPu+UiLyTiZYxY0nhEPbjXQp3UN58LGYBstvEnluunNxRVFfHy12Ki43DTpGo7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791251151;
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
 bh=9z9sqVcSEpS4afAQJesDVYUcjz+ZrEtcuQLu77Pzba8=;
 b=R8oIMGa7wmWBnYQQlHORcIRk9S0em+QdZuZLHp/eY/lm2aifkLCdA0fL7+oN/Ga5gKZU
 /fL6uCKb0kGi+EEMFZGT17ad3SlzXduIHXzoeX0V12XZ7fTeBjYiWl3qqweGXLbC3qtxA
 ang/xvgZpbnL3nfgNReHGik9DYovML5vr3keuC+osJIop2htFYZLI4h0qMhQterLVuoOI
 VMXCXOhypQ32BV5Kz0EmAVkwi4r0WssPGagttx/6na016qpXpeP7f5aZIBo6APMJh5CW+
 2P886Vg5BissRf0YkynY6LFCftEFxGZWyUCHcRz1imZrJaMCM51hZI5NdLLv95o5StA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kVa1cGZn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kVa1cGZn
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 35CA260666
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791251151; x=1822787151;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9z9sqVcSEpS4afAQJesDVYUcjz+ZrEtcuQLu77Pzba8=;
 b=kVa1cGZnlBbD/MQr17+NugqUtrxR+mr9Hy58zk8S5R3JvepjTGPk/DAp
 uFNPeDYGcjOUsekJ8KkCTy0efZft9kgIwD/ZpHQ5c+I4poM/WXjjIQcvh
 fxksdkkbzLGnRiHbuqV8lcAWGf5TU6U3tIz+Od/spfzlXH1B4UAuS0sRd
 a2aNQd/K6aGejvH2cRupT7Xd0nVDnVE/gyKjKEVpAoaSFhYCiqLvlBPyW
 CVuhOXK7f7ILkYOMGmtEeop6iPVwDkZcVxRfrLo8fBnT8ZxqSUBujyY6+
 Y/2Xuaw7XvTWXoMqK7VSERKA/+YD+t0d2VPDto/XeuuGhh13nh69jj9Km g==;
X-CSE-ConnectionGUID: XqsyPlAaSTmLKTBZTldOsQ==
X-CSE-MsgGUID: L+j/MuHsRfKSOZOwnTDgkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91956996"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="91956996"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:45:50 -0700
X-CSE-ConnectionGUID: Y0cqU7sxSNWSSt82FiZZbA==
X-CSE-MsgGUID: MK+m+5R4R0eEEVNpSEjhwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276498911"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:45:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:45:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:45:49 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeEwGiOxWzhigJQWbe3ZVmllkm32+mrr+I7XGAfBccKRBgXL7oJJZMykspUm61PcWxwKox/QpZwoSGcbkWL5Zmz7voZXxuOYOqT8zhC11tYCiJE9aq+Xed0vePjhVQCeErmb6iIyS2q+qi0sCwLOWD32Cyg2iwyhtd7V6jp8zkA0Sb+vFd5hlmskQypsKUkd9DZBqyMpVGJHlx4yIi20eJSZf3hFFCC57l2zwGeaYyYaugufpYTcV2lcNHvpeEUSquC0edubaUMMRna3qhuJ9wS0nnYMjvAhcmOR113Y9v8sZFJPVWDXBiEn7c9b9YYMuwDIYfMiE/tEwtsc87+iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z9sqVcSEpS4afAQJesDVYUcjz+ZrEtcuQLu77Pzba8=;
 b=lRvIr46LyWmt1fR2ckFYFB2J4mJpPr809NDnQsg4jd5dLPP95UjezI2loo2zPN3/ZSyEQ1rowsOyido1aSPJTt/4i1plD/Pzy6J1pKQfZYmcHhVH/BIS5kos+DvBN2XKFL6lclVLQXcxT2rfaQcV7hMCpG1Ciamjl4F5Qd0wRaFibEzdYy5G+uSg+und5C2Gym2QAF8xnskA/DU8C/q01sCMBvxm1ItKQDIVVTa9x3qrRanK56Y9XoVGdcRT7+4VytaNQnUn5Y4TXCuH84+eQFw+kG3yJD0/HauMcN+QvKYEkLTFXd37AEFCubGTrajpuHcoqhdgHS1BC5NByeU6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:45:40 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:45:40 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-net v3 14/15] ice: don't clear in_use until HW clears
 ready bitmap
Thread-Topic: [PATCH iwl-net v3 14/15] ice: don't clear in_use until HW clears
 ready bitmap
Thread-Index: AQHdTUnIcGYKvnGGgEmLiJLqf13ppbbvzdyg
Date: Tue, 6 Oct 2026 01:45:40 +0000
Message-ID: <LV1PR11MB879020E49D1CD84B5410A0B890952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-14-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-14-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB4824:EE_
x-ms-office365-filtering-correlation-id: 859a5663-4531-4df2-8715-08df234b86f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|921020|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: nfEdeKnahniyej/pHVWUJfFeJmpv8gRbPw8rYUg4xPgs9N+EjHsawAhj/j0LIqU6+WSjh/d1/U62+5P39u4HpGYQAny+4aXUpSFHZVfWI7dxYlTkrEJzz6irCV1ibaG5+ceLzdSCqJyU97nvSUI6TUG2jgk7sJvRNaIlv4B4BVoGzyU991tAITwnu+mIhoKNcSE8/mZU+anCWJ9nU6LzjlRekWXN5CerVvTfRZlnwJ2zJZCXwOqHvZeTLIIysegsm6K89liiGCU3tesODMzUz3mcp+eIPj1XeigBp5w2xzggt5+WnK6XxAFZl4Jjj3cVuYtLNsk4aBTeSfFCqwi25DGSCiwgWFYvC/qKAYvs939KXjk+SecgesX+e2YOSPESBq139VNMAcLPIXKdeUbmruaKNEJbYMI9FybQl+Bis0mlC+ENHYAbcF4pULDLAgIO3ft6SMazMIBESnRs8yyfPZjQ35PJtR7Bjw3+ds80HJh1H85R3eGUOAv+ZcgSMcCqi5nfY++CVHo96TQIF5AseYG6boq1vBSPmnBYcIoMVyINu97gQSBey5ycE0cHC++0bt+C4aCGblhZtytOWKIqfWzqAsAiSfLkilxudGP7K4eNPZNFb3L9qdb/duX8fM/4q2tQ1nU9OM3R1NmRTEdmC+INpnzO0JIgaKjVS+Uf5gHfH/nzZLeZMAId6oFEA4LbzGnJyIXKC552ILpvyBYQhzl7tDYJqvNygdFvemevwL06KuYkLzigmLmiyGtSsImZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(921020)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm4xYzhEU0RhMGJzR2E3aVBkNkxWRWs5UFBhWUJaMmVCcHkyMGd1TTdBUFI0?=
 =?utf-8?B?Y1hiUnNVbVFBbTJUODhmYVlKZ05SM1lSSXNIdTRWL25JemlnU3JDMForR3hq?=
 =?utf-8?B?RWcyU0tRVmREL1dGWEJOYWc1NlltN0dUMUY5QUdhbks5cGFYSVI5NE1EanRw?=
 =?utf-8?B?VjJ6b2pmcjZGTno5bkxLczVDVjVZM3p3NXY3b0I2NzFnMFl1cXUrWVlpOFZx?=
 =?utf-8?B?YllqVCtuOFZHWEFWZXhDRlVSSGk1bndjTFo5VjcvOGJDUEV1VnJYbVVxaG9v?=
 =?utf-8?B?YmhQaktEUjIyek8xbW1iTGczVk9RT2NkVVozeEpNWEdrVzRhVUgwS1YrQUxs?=
 =?utf-8?B?bWZSdU91b3AyNC9sRVlJbnBzdnlUZk5iZHpPR1Rmc0pRWkczNHFZMEVnWVpq?=
 =?utf-8?B?QXZwWnFVTWdhZ1lRbUw5ekxCdHducUtjanV0OGRaRG1WVFpTaUZkUWdvdEEx?=
 =?utf-8?B?RDNjK0RadkdYT20wT0hMR0IyeGk1OExUL044cHljQWNkRmRMdTMxeERzeFM5?=
 =?utf-8?B?S0swN1MrbWcwSUE0QnBMeUduYTlFNGtMOHBuZHFQWmlYZVFnRjJhaHFVMFg0?=
 =?utf-8?B?ZWVSek5DbWZkOEhIbXJXTy85Z25QcjZNcFlsOUJmSDMxZkRXT3Z6Y3lCM0xC?=
 =?utf-8?B?VG14WmlibUhZRktSVG9jN1RqWWZvRkNRa1ZOM08zU1RUem52bUNmbWMvNUxS?=
 =?utf-8?B?RTJHTE1FUjdUQzYxOE01bjQ2MTdlMisxQUcrbTFhdFBiWnhFNUNTcWlmVnQ3?=
 =?utf-8?B?cUxsMzlnc2JjNVRnVy9uTDZGaTNqODQzcUtiQm5PTW1oR0FEMTk4RDRyaGxo?=
 =?utf-8?B?bTl0bUFmbWZwMUR2VnVEYUwxSHVNWFhUYXlBTjcrWm9IckxxNEhzZ2ExUEZU?=
 =?utf-8?B?WjNnVXE2cE9YVGZXOE1YRjVucENTYmY0STdXT3FJd051MytRSlFTL3NlTCtR?=
 =?utf-8?B?eGVicThkZnFaVFM3Y1pLNDB6VE1UZXp3ZVhJL2VQSHVabVR4bFhaMUFUQys3?=
 =?utf-8?B?U2VPUzBWUHVvVjQzNk9FUlZDTG9mNFV5K213dHhJcWp1cG9pOEdWU0MvREht?=
 =?utf-8?B?WVZQL3dYRkxqMzVld1dHYTZHVEpYYVFZOGRwOHV2Y24xMmhzUWsxZmV6dHBy?=
 =?utf-8?B?VDVRWThtUWJHeDVBR3kwU3Z0SE9weldnVUhyMGtGcnBpWSswK1FIN0F5MDFl?=
 =?utf-8?B?NEpEOGpudmZCajBNTU9ta3FQbUVacGI2RktHMzF6b3l5MkpDZVVNSDcrRVhz?=
 =?utf-8?B?UEVFMHR6M2x6TlhFN1VPVDdJQWg1OURLajhEWi9vRnJHQnBEcWtYZFN5aEtq?=
 =?utf-8?B?c0JJbVN4OS9BU01JakpzeHU4UVhNM1ZHaStuQ2hJYU02LzVscXB1Yk5mTnYx?=
 =?utf-8?B?ZW5iL0Y5RmNUaWl1RHNBYXArN3hNM0hqbW9ETEJXaXIxelFySE5LYWNDdEFC?=
 =?utf-8?B?dHhSTFkzMHduNE0za25LemhTY2JBTkQwWDhWV3ZEL1J5OXZtcnVZeU5CcXZU?=
 =?utf-8?B?OW5KczJJVWFkN3VXTlNTRmFjQU5FZnZaZ2t0YWtwdTdUQlk3cXpZVEoxNzR6?=
 =?utf-8?B?OGtmMWFVUUdxWWp0SzZVcUVlMG10RGhTcWFkOFVvaW5xQjU3VmZRb0NWOEU5?=
 =?utf-8?B?NUtaYWpnVERqMURYTzM1R1BZQ1E5Z3l6c0ZtZzFTMW9XczI4Wm5sSkplL2xp?=
 =?utf-8?B?WlVYNm9kZ0VlclFCSmNSb0ZLQmRGcXhBSkozNTJyVW5pSWNXcXFabzBscmRY?=
 =?utf-8?B?YVErcVczZHdJV2ZMbDFCT0hwcDExa21MTFlXZ3JUTW0rTWRKYkFqNFdSUGpo?=
 =?utf-8?B?TjFLNThWZ01hK3hWWUlnSEkxU04wd1RWalNFZEE1WmVDVFhZWFpZVGszUTFV?=
 =?utf-8?B?V2ZBaDNBL1ltMExrYVZsODJFK0dNaWg5aEk3SFBwOXA5T2NXRGhsd3JVcGQx?=
 =?utf-8?B?dHlMUmF1cDM3OHZHUENQc0RtcUJkSGpqMGZPTXhCQWlBYktrUm5BWWtmQmJV?=
 =?utf-8?B?ZjIrK1pTaklCNWc0RlZrOWRRYUxqNVhjSktZK0Vxc2ZmQ0Y0eXpwYjNoZmt1?=
 =?utf-8?B?eVJ1dEttMDBFbHlRWlFuU0UwRmIzMHloNFA1ajlpRWpQWXFIenJWbWhOakRZ?=
 =?utf-8?B?b2ppSEJaeVJSZUJNbEphV212a1BQOXlSbmVvUDJReXFNdTkwMmFLaW9TeVNU?=
 =?utf-8?B?NTBlODlrSXpIQTFrN0pnZmtZN0loZVlvRlMxbXFhVkd0eEJScXhqc0RvcTNY?=
 =?utf-8?B?bml0STFjZ0E3TzZ3QUQzbzZKUTZkMTMzZDR3OTBKbXF2eDBoM0hPbzZ4SHVx?=
 =?utf-8?B?UDZ1bGRsdk03QytCZnVwdnVHTEV3N1dZTlJSamV5ZDFVVlBEQkh6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a9Ar5QL/8NxpnfhNVLFeIfZaEVjLwX5iRqBO8TAboZfajvavIg1HRUKV8DNiIUN+2oFzTiVCj+n5ur9gRpGyNX0ni4w4+/xyIMIXsWmklI0nW1sloXVurlehFnrEba/ktEVA9HOZEIvFxddSAmjkxE3Cnds+O6SYQ5E9h8KVhRdw0xlLXy11n7TbAWa4GFyp7xxCkIXqcgiNuXmwD8uxYkdgaHUe0O7yrkt6b0bgPMkHp3JLIwHmwttuzwsQZuN8sB6SGy0Pk7ms59l/th1c3IpMgDaIBihGjkx6IptaYod9aDrHzMRjhQToZ6UsugGIDCSRWTRGmzYy1yqM50LUJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859a5663-4531-4df2-8715-08df234b86f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:45:40.3100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efqsMWn0BHM8gS1eVPlyE51q+GrtZUFlyPcUUEShrugVZDXNSegxMHo50N/4t+xBQ3HYq7VBWZhzICA0mSeEDm6Gay6bbf5cyPIPlpL7CIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
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
QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMTQvMTVdIGljZTogZG9u
J3QgY2xlYXIgaW5fdXNlIHVudGlsIEhXIGNsZWFycyByZWFkeSBiaXRtYXANCj4gDQo+IER1cmlu
ZyBhIGxpbmsgZG93biB0cmFuc2l0aW9uLCB0aGVyZSBpcyBhIHNtYWxsIHdpbmRvdyB3aGVyZSBo
YXJkd2FyZSBkb2VzIG5vdCBwcm9wZXJseSByZXNwb25kIHRvIHJlYWRpbmcgdGhlIFBIWSB0aW1l
c3RhbXAgcmVnaXN0ZXJzLiBXaGVuIHRoaXMgb2NjdXJzLCB0aGUgUEhZIGRvZXMgbm90IGF1dG9t
YXRpY2FsbHkgY2xlYXIgdGhlIHJlYWR5IGJpdG1hcCBvciB0aGUgdmFsaWQgYml0IGZvciB0aGUg
dGltZXN0YW1wLiBUaGlzIGJlZ2lucyBoYXBwZW5pbmcgc2xpZ2h0bHkgYmVmb3JlIGEgbGluayB0
cmFuc2l0aW9uIGV2ZW4gYmVmb3JlIHRoZSBmaXJtd2FyZSBoYXMgbm90aWZpZWQgdGhlIGRyaXZl
ciBvZiB0aGUgc3RhdGUgY2hhbmdlLg0KPiANCj4gVGhlIGRyaXZlciBoYXBwaWx5IGNvbXBsZXRl
cyB0aGUgdGltZXN0YW1wLCByZWxlYXNpbmcgdGhlIGluX3VzZSBiaXQuIFRoaXMgYWxsb3dzIGFu
b3RoZXIgcmVxdWVzdCB0byByZXVzZSB0aGUgYml0IHBvdGVudGlhbGx5IHJlcG9ydGluZyBhbiBp
bnZhbGlkIHN0YWxlIHRpbWVzdGFtcC4gQWRkaXRpb25hbGx5LCB3aXRoIHRoZSByZWFkeSBiaXQg
c3RpbGwgc2V0IGhpZ2ggdGhlID4gZHJpdmVyIGNvbnRpbnVlcyB0byByZS10cmlnZ2VyIHRoZSBJ
UlEgYW5kIGNoZWNrIGZvciB0aW1lc3RhbXBzIGluIGEgdGlnaHQgbG9vcCwgd2FzdGluZyBDUFUg
Y3ljbGVzLg0KPiANCj4gVG8gZml4IHRoaXMsIHJlLXJlYWQgdGhlIFBIWSB0aW1lc3RhbXAgbWVt
b3J5IHN0YXR1cyBhZnRlciBlYWNoIHJlYWQgb2YgYSBQSFkgaW5kZXguIERvdWJsZSBjaGVjayBp
ZiB0aGUgaGFyZHdhcmUgY2xlYXJlZCB0aGUgaW5kZXggcHJvcGVybHkuIElmIGl0IGhhc24ndCwg
bWFyayB0aGUgdGltZXN0YW1wIGluZGV4IGFzIHN0YWxlIGFuZCBrZWVwIHRoZSBpbmRleCBsb2Nr
ZWQuIFRoZSBpbmRleCB3aWxsIGJlIHJlLWNoZWNrZWQgb25jZSBhbm90aGVyIGludGVycnVwdCBv
Y2N1cnMgKGVpdGhlciBmcm9tIGEgcmVhbCB0aW1lc3RhbXAgb3IgZnJvbSB0aGUgd2F0Y2hkb2cg
a2ljaykuIE1hcmtpbmcgdGhlIHBhY2tldCBhcyBzdGFsZSBtYWtlcyBzZW5zZSBzaW5jZSB3ZSBr
bm93IHRoaXMgYmVnaW5zIGhhcHBlbmluZyB3aGVuIGxpbmsgaXMgZ29pbmcgZG93bi4NCj4gDQo+
IElmIHRoZSBpY2VfZ2V0X3BoeV90eF90c3RhbXBfcmVhZHkoKSBmYWlscywgdHJlYXQgaXQgdGhl
IHNhbWUgYXMgaWYgdGhlIGhhcmR3YXJlIGhhZG4ndCBjbGVhcmVkIHRoZSBiaXRtYXAuIENvbnRp
bnVpbmcgaGVyZSBpcyBzYWZlIHNpbmNlIHRoZQ0KPiBpY2VfZ2V0X3BoeV90eF90c3RhbXBfcmVh
ZHkoKSBkZXZpY2UgaW1wbGVtZW50YXRpb25zIGRvIG5vdCB1cGRhdGUgdGhlIG91dHB1dCBwYXJh
bWV0ZXIgZXhjZXB0IG9uIHN1Y2Nlc3MuIE5vdGUgdGhhdCAidHJhbnNpZW50IiBlcnJvcnMgdG8g
YWNjZXNzIHRoZSBQSFkgd2lsbCByZXN1bHQgaW4gbWFya2luZyBwYWNrZXRzIGFzIHN0YWxlLiBU
aGlzIGlzIHRoZSBzaW1wbGVzdCBhcHByb2FjaCBhbmQgYXZvaWRzIHJpc2tpbmcgYSBwb3RlbnRp
YWwgcmV1c2Ugb2YgdGhlIHN0dWNrIHJlYWR5IGJpdC4NCj4gDQo+IFRoZSBleHRyYSByZWFkcyBv
ZiB0aGUgdGltZXN0YW1wIHJlYWR5IGJpdG1hcCBhcmUgc2F2ZWQgaW4gdGhlIHNhbWUgdHN0YW1w
X3JlYWR5IGZpZWxkLiBUaGlzIGVmZmVjdGl2ZWx5IHVwZGF0ZXMgdGhlIHJlYWR5IGJpdG1hcCBm
b3IgYWxsIHRpbWVzdGFtcHMgcmVtYWluaW5nIGluIHRoZSBsb29wLiBUaGlzIGlzIHNhZmUsIGFu
ZCBhY3R1YWxseSBpbmNyZWFzZXMgdGhlIGNoYW5nZXMgdGhhdCBhIGdpdmVuIHRpbWVzdGFtcCB3
aWxsIGJlIHByb2Nlc3NlZCBieSB0aGUgbG9vcCBpbiB0aGUgZXZlbnQgdGhhdCBhIHRpbWVzdGFt
cCBjb21wbGV0ZWQgYWZ0ZXIgdGhlIGluaXRpYWwgcmVhZC4gVXBkYXRlIHRoZSBjb21tZW50cyB0
byByZW1vdmUgc29tZSB0ZXh0IHRoYXQgbWlnaHQgaW1wbHkgb3RoZXJ3aXNlLg0KPiANCj4gVGhp
cyBmbG93IGhhcyBiZWVuIG9ic2VydmVkIG9uIEU4MjUsIGJ1dCBhbGxvd2luZyB0aGUgZHJpdmVy
IHRvIGZyZWUgYW4gaW5kZXggd2hpY2ggaXMgbm90IGNsZWFyZWQgd291bGQgYmUgaW5jb3JyZWN0
IHJlZ2FyZGxlc3Mgb2Ygd2hpY2ggZGV2aWNlIHR5cGUgaXQgb2NjdXJzIG9uLiBUaHVzLCB0aGlz
IHJlLXJlYWQgaXMgYXBwbGllZCB0byBhbGwgZGV2aWNlIHR5cGVzLg0KPiANCj4gSW4gdGhlIHVu
bGlrZWx5IGV2ZW50IHRoYXQgYSB0aW1lc3RhbXAgaGFzIHRpbWVkIG91dCB0aGUgMiBzZWNvbmQg
d2FpdA0KPiAqYW5kKiBzb21laG93IHN1ZGRlbmx5IGhhcyBpdHMgcmVhZHkgYml0IHNldCBidXQg
dW5hYmxlIHRvIGNsZWFyIG9uIHJlYWQsIHRoaXMgY291bGQgYWNjaWRlbnRhbGx5IGluY3JlbWVu
dCB0aGUgdGltZW91dCBjb3VudGVyLiBJdCBpcyBpbnRlbnRpb25hbCB0aGF0IHdlIGRvICpub3Qq
IHJlbGVhc2UgdGhlIGluZGV4IGV2ZW4gaW4gYSB0aW1lZCBvdXQgY2FzZSwgYXMgd2UgbXVzdCBu
b3QgYWxsb3cgcmV1c2Ugb2YgdGhhdCBpbmRleCB1bnRpbCB3ZSBjYW4gYmUgY2VydGFpbiBpdCBo
YXMgY2xlYXJlZC4gSW5zdGVhZCwgcmVmYWN0b3Igc28gdGhhdCB0aGUgdGltZW91dCBjb3VudGVy
IGlzIG9ubHkgaW5jcmVtZW50ZWQgb25jZSB0aGUgaW5kZXggaXMgcmVsZWFzZWQsIChhZnRlciB0
aGUgc2tpcF90eF9yZWFkIGxhYmVsKS4gVGhpcyBlbnN1cmVzID4gdGhhdCB3ZSBkb24ndCBkb3Vi
bGUgY291bnQgdGltZW91dHMgb3IgY291bnQgdGhlbSBwcmVtYXR1cmVseS4gVGhlICJzdHVjayIg
cmVhZHkgaW5kZXhlcyByZW1haW4gbG9ja2VkICppbmRlZmluaXRlbHkqIHVudGlsIHRoZSBoYXJk
d2FyZSByZWFjaGVzIGEgc3RhdGUgd2hlcmUgdGhlIGNsZWFyIHdvcmtzLg0KPiANCj4gU3RhbGUg
dGltZXN0YW1wcyBhcmUgYWxyZWFkeSBpZ25vcmVkIGJ5IHRoZSBpY2VfYW55X3BvcnRfaGFzX3Rp
bWVzdGFtcHMoKSBmdW5jdGlvbi4gSG93ZXZlciwgdGhlIGljZV9wdHBfdHhfdHN0YW1wc19wZW5k
aW5nKCkgZnVuY3Rpb24gYWxzbyBjaGVja3MgdGhlIHJlYWR5IGJpdG1hcC4gSW5zdGVhZCwgbW9k
aWZ5IGl0IHRvIG9ubHkgY2hlY2sgdGhlIHNvZnR3YXJlIHRyYWNrZXIuDQo+IEFkZGl0aW9uYWxs
eSwgc3RvcCByZS10cmlnZ2VyaW5nIHRoZSBpbnRlcnJ1cHQgZnJvbSB0aGUgSVJRIGlmIHRoZSB0
aW1lc3RhbXAgdHJhY2tlciBpcyBjYWxpYnJhdGluZyBvciBoYXMgdGhlIGxpbmsgbWFya2VkIGFz
IGRvd24uIENvbnRpbnVlIHRvIGNoZWNrIHRoZSBoYXJkd2FyZSByZWFkeSBiaXRtYXAgZnJvbSB0
aGUgd2F0Y2hkb2cgdG8gY2F0Y2ggY2FzZXMgb2YgdW5leHBlY3RlZCB0aW1lc3RhbXBzLg0KPiAN
Cj4gV2l0aCB0aGVzZSBjaGFuZ2VzLCB0aGUgdGltZXN0YW1wIHByb2Nlc3Npbmcgbm8gbG9uZ2Vy
IHRyaWdnZXJzIGEgcmVwZWF0ZWQgc3BhbW1pbmcgb2YgdGhlIElSUSBkdXJpbmcgbGluayBkb3du
IGV2ZW50cyB3aGVyZSB0aW1lc3RhbXBzIGdldCBzdHVjayBhcyB0aGUgUEhZIHRyYW5zaXRpb25z
IHRvIGxpbmsgZG93bi4gT25jZSBsaW5rIGlzIHJlc3RvcmVkLCB0aGUgUEhZIHdpbGwgYmUgcmVz
ZXQgYW5kIHRoZSBzdHVjayB0aW1lc3RhbXBzIGFyZSBjbGVhcmVkLg0KPiANCj4gTWVhc3VyaW5n
IENQVSB1dGlsaXphdGlvbiBvZiB0aGUgbWlzY2VsbGFuZW91cyBJUlEgdGhyZWFkIGZ1bmN0aW9u
IGR1cmluZyB0aW1lc3RhbXAgc3Rvcm1zIG5lYXIgYSBsaW5rIHJlc2V0IHNob3dzIHRoYXQgdGhp
cyBwcmV2ZW50cyB0aGUgc3Bpa2VzIGNhdXNlZCBieSB0aGUgInN0dWNrIiByZWFkeSBiaXQuIFdp
dGhvdXQgdGhpcyBmaXgsIHRoZSBDUFUgaGFuZGxpbmcgdGhlIElSUSBiZWNvbWVzIHNsYW1tZWQg
ZHVlIHRvIHRoZSBJUlEgcmUtdHJpZ2dlcmluZyBsb2dpYy4NCj4gDQo+IE1lYXN1cmluZyBsYXRl
bmN5IHVzaW5nIHRoZSBpY2UgVHggdGltZXN0YW1wIHRyYWNlcyBkb2VzIHNob3cgdGhhdCB0aGlz
IGZpeCBjb21lcyBhdCBhIGxhdGVuY3kgY29zdC4gTGF0ZW5jeSBpcyBtZWFzdXJlZCB1c2luZyB0
aGUgaWNlIFR4IHRpbWVzdGFtcCB0cmFjZXMgZm9yIHRoZSByZXF1ZXN0IHRvIGNvbXBsZXRpb24g
dGltZS4gSSBtZWFzdXJlZCBhIGNvdXBsZSBvZiBkaWZmZXJlbnQgd29ya2xvYWRzIGJvdGggYmVm
b3JlIGFuZCBhZnRlciB0aGlzIGZpeDoNCj4gDQo+ICAqIHB0cDRsIHVzaW5nIGEgcHJvZmlsZSB3
aXRoIH4xNiBTWU5DIG1lc3NhZ2VzIHBlciBzZWNvbmQNCj4gDQo+ICAgICBiZWZvcmU6IDE4OS43
MSBtaWNyb3NlY29uZHMgbWVhbiwgc3RkZXYgNDMuMjQNCj4gICAgICBhZnRlcjogMTk1LjkyIG1p
Y3Jvc2Vjb25kcyBtZWFuLCBzdGRldiAyNS4yOA0KPiANCj4gICogYSBDIHByb2dyYW0gZ2VuZXJh
dGluZyAxNiB0aW1lc3RhbXAgcmVxdWVzdHMgZXZlcnkgMTAgbWlsbGlzZWNvbmRzIG9uDQo+ICAg
IHR3byBkaWZmZXJlbnQgcG9ydHM6DQo+IA0KPiAgICAgYmVmb3JlOiA0NTcuMTEgbWljcm9zZWNv
bmRzIG1lYW4sIHN0ZGV2IDE4MC42Mw0KPiAgICAgIGFmdGVyOiA3MTcuNzcgbWljcm9zZWNvbmRz
IG1lYW4sIHN0ZGV2IDMyMS41OA0KPiANCj4gSW4gdGhlIG5vcm1hbCB3b3JrIGZsb3dzIHRoaXMg
Y29tZXMgd2l0aCBhYm91dCBhIDEwLTIwIG1pY3Jvc2Vjb25kIHBlbmFsdHkgb24gdGhlIGF2ZXJh
Z2UsIGFuZCB0aGUgc3RhbmRhcmQgZGV2aWF0aW9uIHJlbWFpbnMgc2ltaWxhciAod2l0aCBzb21l
IHZhcmlhbmNlIGJldHdlZW4gcnVuIHRvIHJ1biBjb21wYXJpc29uKS4NCj4gDQo+IEZvciBoZWF2
eSB3b3JrbG9hZHMgd2l0aCBtYW55IG1vcmUgdGltZXN0YW1wcyB0aGFuIGV4cGVjdGVkIGZvciB0
eXBpY2FsIGFwcGxpY2F0aW9ucyB0aGlzIGNvbWVzIGF0IGEgc2lnbmlmaWNhbnQgY29zdC4gVGhp
cyBpcyBiZWNhdXNlIHdlIGhhbmRsZSBhbGwgdGltZXN0YW1wcyBpbiBhIHNpbmdsZSB0aHJlYWQu
IElmIHRoZXJlIGFyZSBtYW55IGNvbmN1cnJlbnQgdGltZXN0YW1wcyBiZWluZyByZXF1ZXN0ZWQg
YXQgb25jZSwgYW55IHdoaWNoIHVzZSB0aGUgbGF0ZXIgc2xvdHMgb24gcG9ydHMgbGF0ZXIgaW4g
dGhlIHBvcnQgbGlzdCB3aWxsIHRha2UgbXVjaCBsb25nZXIgdG8gYmUgcHJvY2Vzc2VkIG9uY2Ug
dGhlIGludGVycnVwdCBpcyBmaXJlZC4gU2luY2UgZWFjaCB0aW1lc3RhbXAgbm93IHJlcXVpcmVz
IGFuIGFkZGl0aW9uYWwgUEhZIHJlZ2lzdGVyIGFjY2VzcywgdGhpcyBjb3N0IGlzIG11Y2ggaGln
aGVyIGluIHRoZSBjYXNlIHdoZXJlIHRoZSBkZXZpY2UgaXMgdW5kZXIgdW51c3VhbGx5IGhlYXZ5
IGxvYWQuIFRoZSBoaWdoIHN0YW5kYXJkIGRldmlhdGlvbiBpbmRpY2F0ZXMgYSB2ZXJ5IGhpZ2gg
dmFyaWFuY2UgaW4gdGltZXN0YW1wIGxhdGVuY3ksIHdpdGggbWFueSB0aW1lc3RhbXBzIGNvbXBs
ZXRpbmcgaW4gdGhlIHVzdWFsIHRpbWUgYnV0IHNvbWUgdGFraW5nIHNpZ25pZmljYW50bHkgbG9u
Z2VyIHdoZW4gbXVsdGlwbGUgdGltZXN0YW1wcyBhcmUgb3V0c3RhbmRpbmcgaW4gYSBzaW5nbGUg
SVJRLg0KPiANCj4gVWx0aW1hdGVseSwgKmNvcnJlY3RuZXNzKiBpcyBtb3JlIGltcG9ydGFudCB0
aGFuIHNwZWVkIGhlcmUuIEFkZGl0aW9uYWxseSwgd2Ugc3RpbGwgcmVtYWluIHdlbGwgYmVsb3cg
dGhlIGRlZmF1bHQgbGltaXQgb2YgMTAgbWlsbGlzZWNvbmRzIHRoYXQgcHRwNGwgd2lsbCB3YWl0
IGJlZm9yZSBjb21wbGFpbmluZyBhYm91dCBtaXNzaW5nIHRpbWVzdGFtcHMuDQo+IA0KPiBGaXhl
czogN2NhYjQ0ZjFjMzVmICgiaWNlOiBJbnRyb2R1Y2UgRVRINTZHIFBIWSBtb2RlbCBmb3IgRTgy
NUMgcHJvZHVjdHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2Vs
bGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX3B0cC5jIHwgNzggKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5
OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
