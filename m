Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E791CA5FAD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C514607B6;
	Wed, 30 Sep 2026 01:17:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tkNtaAjSgBnq; Wed, 30 Sep 2026 01:17:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8E30B6081D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790731052;
	b=OL1ma2W4kxy72EPc73QuWW0JUT+DcG/3vaLKYJhasX/KFPoCe2doty0nMihuTqhEVTCf
	 VNsxVXwGetxa8LjHcILy9TOxgwoDiSXikpQPm+Akr/o6klyHgArr7msMT//HV4P6s1lhF
	 Tp/OETVuESTLGr3MOkPQQqakaLOrPD3RXkpFD/TNzk/H/aIttYK1OxulYqyFudiR9S5D9
	 Tot90LZOTzkfkokE7lafkhH6XYfqgPj8OeTgzd1ze0R5YNMnpqvFaYrTxI7188R5aIhMq
	 ou68x0AgyjtrAweKI3KCHVWOdLdqTJ7wudimuHFEPGOnMKPHar8/WRJfYgDQ03qYNaw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790731052;
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
	bh=PzbqeWlnq94/U3agsZ7/ULb5jkb5oiVGMzWsyuPSZHw=;
	b=YjHJlzugL5f0/xnpJz/bez636SpSOIWRK/htj3xesvZHq3d4nTg2X1MT3KdL0GuspRfK
	 so8cu7D5p7hEtgBn7efB1trzkk+j0ubDLFaQCAQnaefczSVSOzfVrQHvSQtruFknFNDrY
	 p5JMmk/iHTdmfJgNP/XD4rq2MCs0CJnbvQmcPguKW3VxQmqgiFowK7l80KG0pUq8z3zuu
	 /8ZiU0hWDrYFZIWvmH/WWYFok0qSGUFU62lc67qVkqwC5w0gI1933Za7cwewu323pA1bN
	 uOOo3/cW24/SD12FfFZkiaViAY2MPj2qfzJcWU3Vii2/oQeC4lxVHwg8+BY+9PIs53w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790731052;
	bh=PzbqeWlnq94/U3agsZ7/ULb5jkb5oiVGMzWsyuPSZHw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DcMaZ2uZ03z/GVeSiA7wQWBDmAJ9SgYG5JqM3K5Xait78qLA2ccOT0v7mDwl4vd1P
	 NF9ZibZF+y0tekPsq2ZgQGi3b8aWxjkmdt/kBviVsIGGahmYkAryfKYd8TyYZsHD5t
	 f0QCiRXpCzOp5cFjb8DnQCP8cRfOv3+sGtfXyPGH7/GjQY1X+VDJd42/Jm2D8FTS+w
	 WwQoCO2rmBF96dyhXevcYUwt++8tz8wM9OFj5TYG6WC8QSeGjnsINft3M98amMcgs9
	 L+q+FU4kpObbE0mY4g+UVAUQ2yZiUlsqm7wotx24YRsag5z2N2nClF0ZTr6RlK5+X6
	 tidBeSSvtSEfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E30B6081D;
	Wed, 30 Sep 2026 01:17:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AA8B282
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0835540542
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N5nONRYi_Yr0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:17:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 457244043A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790731050;
 b=B5637ScIuBonFc4TZlPvXvrX3MDp6idPszaDkXsaASK/TQm2UC5img1+GJrW9+VHLe7y
 CpOShVI3LckRMF3zMGQPVcS90xvFgbaD32WJLAdh0QZmzgwA29kDCTx1Tj5+UEQUL+Lzk
 mMZyKZ2vBjz2/bRqSur1SQW4Z2RJzQhCm0wwk6Nxdi0XOBBxWRWVO7OMJORYbbBN9Hvp2
 C0vgf442fif4DrqHeEqMLee1BzcfZm5HNpIH/RWTHG/a/XwqsQthRM5USod8MRjp0IlH8
 s3kKQC4qZFqM5Ycy+H+QAlfEpHggLBmOsmEp3enKIPeEuzAIvaTG0ejj7T7b10DLg0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790731050;
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
 bh=PzbqeWlnq94/U3agsZ7/ULb5jkb5oiVGMzWsyuPSZHw=;
 b=pZvEctZXRS0c18Wisywa96lcnmzqKzBdpQN1nh68C+rpTIJ3V4ua0fS3l6NJ/SqFMM6M
 NVw6tYiJJO4k6IMqvOG5mu7spalIWKXs/f5j6ntORfcsvsFbUmUn/RO8ANb1XeQmUY2gR
 tsf1Z7RirtA/DC2VaGMLddMu9R/ByVHwRsMbgkNnqWg+6pd3n7cC2SNE+yza/F04B/yCA
 3vd2SvgpyBuszX2AjqH5JJ9mrX0Glu6t1FdzfA8R8FQzJeq5hkQgLO/tE5N2GOuFAuvwk
 kzVTVac/YSflubl+cL+k/iaZA0ZafDDEqudDVxxWRPSHJvV7JAzK+MhvNO4pFn6PYNQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="HdFS/hIQ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HdFS/hIQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 457244043A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790731050; x=1822267050;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Zeo+Sr5cDJfVmWyslfaMbbyRIWsPETNTxBqVvYDLXOM=;
 b=HdFS/hIQTbBuB4gYRReRmFwYGqiHPuU5PQ9nyAZ2HvWZ0FasudXOVt2h
 2Z5DGIjMzRKvpd5vRlwUMnDHAvfPKzwTWg6UrF3Gy6i/L7KjoJo6XHjgH
 TbRNryDdzaa6pd5W4LBrWCJGQvNOK6k8zZ4Z7iLrweIcgNh/W2AgDZ76X
 Opm0aQEhCGQl4CIJw5sRQ5t+JZ7lPhChlCAOa9KR6LQ7csejTvXjYbe8F
 PM1+UulGwmo3AGUw/+kCF9c8CJNOgSE9bpJVQrXtGsSYf6/I3kf+UBp8b
 ok6mEO8kG9WnRHGwCMwKO0G6XPtTElBvvZUNbQcTguF6C7YbR6caMfZC4 w==;
X-CSE-ConnectionGUID: tFukvi9jSAWgs073tPQsJg==
X-CSE-MsgGUID: 2eujNr49RQytjP19ndb6QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="108948577"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="108948577"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:17:29 -0700
X-CSE-ConnectionGUID: hg0SAvY6Tle+icsW3mOs0w==
X-CSE-MsgGUID: IoF4NWpTST6uf64HXnc+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273314003"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:17:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:17:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:17:27 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:17:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngsJRAXn97NIEGYxjxI/ampasSx3WwOXm/p/ccFlV5oYFS9UYwXJ8tyY01mKZAga12R9QvGBWUWiwZQayGpOjuBy1PXJTNtH6P+6tDue/6VH5ElE6ZwZEwMAoi1ukgo7/XJF49Uey3cddhaJ2O8MQHhruuwqscr9FL1v9SJdGq7u+PE/YbyoTYkkrMtElXXMdyCLEJ3nLRp3mktvcEiUw1+osc5G+2l3ooAH3MXzIJEuV+4KTrDWAVTuidJVw6hs5vXMPH6GIg25VHQbct0Ced3AClcBhfKixnp/aBlrMm5fKj2flaPdAUmmbLIkmQ8sipPa9s7Ju09MGIvhetoPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzbqeWlnq94/U3agsZ7/ULb5jkb5oiVGMzWsyuPSZHw=;
 b=WS3yX6lJAnjX8ATgfUJXTbGeE/0pGwCwSsmA1qrgD5WViUlEfdyr0ja+E3sDVJNY0Np5tfr2GDatZegZlpYg0ah4KydzWqNwaukzjn7hOdiz/Q6nx4ZAV/068/igRKNvVR53iw+P6D9pDyGX8/y60XoQywwEX0P6Hac+m06LX8ubJCLZGuG0u751Wr4zHFRuasZ/QAIpE/OdFCKtV8Zy2f+haqWUYHTR26PUg7RxpcvaS+TqFZbrCTxA/VA9rXoUMPyRyaQRLFgz52nPteeQQf1mVliqi1Pm+/7UxGeKhTV3fKLiuGghFVyWGyhw/JdxLgeufGvkuEm7WZfeoxvfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 01:17:24 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:17:24 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, "Kwapulinski, Piotr"
 <piotr.kwapulinski@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 4/5] i40e: replace reset
 polling with wait-bit synchronization
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 4/5] i40e: replace reset
 polling with wait-bit synchronization
Thread-Index: AQHdJKftNLvaF6kpVECOfHu4+4YCDLbmqYAA
Date: Wed, 30 Sep 2026 01:17:24 +0000
Message-ID: <LV1PR11MB879085898C842D09630978EC908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
 <20260805065132.148625-5-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-5-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: d3c232ba-6776-4679-6c26-08df1e90958e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: Pelndg2JhLK2f94RrHVKYXGDUi8VeB3E8URf0TQG5GHiATlNNOyjujPAnWS+IUadIxUNPbpvP4pVnwYzPEqsuCEhGgCNCxWSnd8UkG5gKkAOR2r399ts4rdw/AUZ0vzXKqLoIFV9OtYTzA5ZhRkoolHIhnXNStWtMm8mvBUXrRMjtIL+m3QoARgOL3LQXDtQZM57v+72RgVxF/kZ9WYB247wxbhFiTQL0G76LWaUumRNyv7LR3S3NcuaTIXKhsI2fPzacv7lXnxWkzVf5Qg5i7oP+MtvUuz31jI4jkWa/2evPb/W27S+sCU4YwE2ckh9XUfVfl+ZoQww5ygeNl6iSCZsvhynZFg6S9XnN4wV1AnuD6gTRdVVwW4gPORNXCbAxUT8BoQ2YkAUWD+c8oqaB349z6GBBa8rfnwq2uZcw/vdHYKsfi+GoAMrn4k6MKy6j8TrRvOhambI+odjcD8T7k0EgZlgMQNGOU4InecEi/dzQbWant1wPBQ2xqQBqDhzri8I928EJMtfW1GyOsp0R1iO2YLrsR/FFvIPVNfa0Uv3g9EGYRfW6pboe6L+yGRdr+pS+t1l4tBaHMJV8UKBNdpUPtZ8OPpvLmr9BN1oyv4701HtQEK3EBZqoBUNCWH1Z/Iuwq8qxOjC48IuLsenOdq2eWmfQ4/LaKgNclRLqrgaH4nYij6locHtd5znWFh6twP9yd5WabTmScKnHWGlWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rG+Ks9beuuL6+iC5cMe2Mrfuk2GflWiDcpn0IIkQgk9YntlkWQ/B9QrEQQpS?=
 =?us-ascii?Q?KOM2ukrPRW+hMyzMFH7TklZxn31W/Xm68+GzWRlqZWCCN77jWUcJPJSLORBo?=
 =?us-ascii?Q?Oe99pOJpoanDO1wuAT13HiBzRZr6jEkLD8RAhw83mdfpq7nX5otnA3mk2brl?=
 =?us-ascii?Q?6nLyiIvBXQUEpWNUKAHFcuIzn0IQxyiinr4W6+6SQxl6jHyZNxE+EQ0CBWKq?=
 =?us-ascii?Q?D8udug9VstDZla4+2ZUYWY6vIoo9Tx2535U+lHJ4L3EZ/kCgMgBYxM2jIl6O?=
 =?us-ascii?Q?XMwJHl2MvTxvf5AaQ7s/sECTHnXsEXVdqRiILjJaoFfZfNVlgwR2r4pVSyF7?=
 =?us-ascii?Q?HftVPwkYJTwXFiL75AEiq+7HsU1TcYtxTbneaUFpJdQpdy3Kwd9N/GEugxmE?=
 =?us-ascii?Q?W2uvcXCYRVODWjme25p4lLVo+U0rZmnJFFgL4uDWoJbkSVdK4LHZMQsDEJq2?=
 =?us-ascii?Q?Ii03vLWQDPKNC3mEYXW/6+c207W2B05IfUKcYvsHBrtTPONRv0VfggHv/qjY?=
 =?us-ascii?Q?INN5zolcx62JJIYPd8jHKYum96xXxm09yokHHoO0QXY4o+xoSR7qy5S/hfB1?=
 =?us-ascii?Q?nEP/heRs6iXz+phevlaE4WVWlMM+PBz6IrNo4UejB8N2l64Y2ReFzozxcL4/?=
 =?us-ascii?Q?dFxXdbk2+sbMgTS6NGkJVuoX4fKZxGlwDFq9a7y/51KM8qy7h8dv1Dq6G8/o?=
 =?us-ascii?Q?MUbRzCHxaxtPhTGjEHqsMvZNXWT1E0+6juQz4lRpopIJ8X1dY3eHVRVMxt29?=
 =?us-ascii?Q?VidQ5Fycurh9ma7GWYM3xGXlugZW/VnwhF4YBUg3dWMD52LUU7uCg0mNSTWB?=
 =?us-ascii?Q?1qglBMEEwEct/PkV/a/7sR8Ebmqs6cT4JeMmmGnJK425Xya4T76wEKdGVbou?=
 =?us-ascii?Q?Dn/YG85auVB/l/ygeLOo+Zmn0s0Zp7XMZvXPguk/gU0qnXy0/eDl2LbqFRnB?=
 =?us-ascii?Q?5uVm+s/Azj/ExVxuOSLEepoeslfGeXXk+UXcr/pk7v4Br0/k24+frbmgbNQQ?=
 =?us-ascii?Q?LXSyo7Zxv7885cq5vzLlb9n/RTOVJ9EWHKWQmNEK8d85eTg8lM1oElBWr6mC?=
 =?us-ascii?Q?M41t9Kl1/3Nhe12lkc1pJIoKLxgq89b5TKELj9V95xJRwDKZgo+TpnYHMWHK?=
 =?us-ascii?Q?b0xAJFSxsU06o4WP9pmHJb20PV5q9HbjoU+usF2JjSlgU3x1q0Mfl5NKaA56?=
 =?us-ascii?Q?B41rAmjsie82K+S/MQ01Zvsd8KHo2B8f+/dhWFHsc8YAX9osyzAsGMOi+OMw?=
 =?us-ascii?Q?UaIJMfWayK8irYALmmEyLP9MaRFtZi40XFWuUQfVem0y4FKz3MtI0IzfEBP6?=
 =?us-ascii?Q?QEMu8sDG3p0wCLvbnVP/jDVp0DE0ToMzXU/GIUnU7Iv78VHkNA3oje3vS3qL?=
 =?us-ascii?Q?DT7ElkMOegk5fZrFngBmKh6CeLhh/lIyQZVgvm6+noOOcU2/3J1lq2xZPL1+?=
 =?us-ascii?Q?lYD8DP2F9iXt/QxNTbbi8yOSRayrMKzL/KK6wkyHG4/PoXBdf7IOmMnWpigg?=
 =?us-ascii?Q?10PlIOTNVDI43+pAoKPzPkt527PyXYAEeQfMTVMqZOmOoUCDF1kqlrINi1Uh?=
 =?us-ascii?Q?GwNljF5wT9/MUjPd1xJwp3Gz0EYOImIbP2Phxlqok18TwzrfSE8vRqcjl26m?=
 =?us-ascii?Q?sGpc3T8Tq8MYTI+0F/WvXyHGERiXdjCZlcH+6C8sJqWidsZuOdlkh3qU66Er?=
 =?us-ascii?Q?rmTeFSnYQcoMFhaw+yC3rZNMiuvFQOaCf0HDut4aQ77PspfUtO3QjKMSoAIb?=
 =?us-ascii?Q?ZzIfqLak2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X2dPZUSyeIdVSGWkBesioBcjt+yNqLo2R6JCrKN1K9PYe6ZKxZURELSgVJLmk+f6TzSn4qbDPHoSkfY4UkkjMjjGlew3jhPpAxo9KJR92mjj/atbOfYyj04vwbQGZ61LkiJVWkq9Pwt4VTF9x3DZhFxvBHzHdx/G7BCJ7nexNSf8jMR6lqj1IDMIOW8za1B6IhI2ae8+zosOftXDs1Kk7VP4H+9DqeVCHJlK3zLLUbW900oUzOZpokM1YhifpYURRQNXofL3UXmA2WBn0sHVNPj2ZFM6J4wHR4VHWIjUxKYfRng8oRV7w1XgJASuO5f5XQF0pskH3HbKejfJwcZksg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c232ba-6776-4679-6c26-08df1e90958e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:17:24.2564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mWwJ48P5WV1LaRfnp4xE7CMFXT+oN2TBmTh15MmPFn582XxEndFvOX9UBkH0s953P55VG2DSRzoS5n7K/vdLhtR+40WynTCS9zEi9DOwoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of x=
uanqiang.luo@linux.dev
> Sent: Tuesday, August 4, 2026 11:52 PM
> To: intel-wired-lan@lists.osuosl.org; horms@kernel.org
> Cc: vadim.fedorenko@linux.dev; Nguyen, Anthony L <anthony.l.nguyen@intel.=
com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lun=
n.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; richardcochran@gmail.com; Kwapulinski, Piotr <piotr.kwapulinski@in=
tel.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Loktionov=
, Aleksandr <aleksandr.loktionov@intel.com>; netdev@vger.kernel.org; Xuanqi=
ang Luo <luoxuanqiang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 4/5] i40e: replace reset pol=
ling with wait-bit synchronization
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> i40e_remove() polls on RESET_RECOVERY_PENDING with a fixed sleep while wa=
iting for an existing reset owner. This adds teardown latency and does not =
provide a wait queue for the reset owner to wake.
>=20
> Use wait_on_bit_lock() so removal sleeps until the reset owner releases t=
he bit and then atomically claims it. Pair the reset release paths with
> clear_and_wake_up_bit() to provide the required release and wakeup semant=
ics.
>=20
> Fixes: 5b6d4a7f20b0 ("i40e: Fix crash during removing i40e driver")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
