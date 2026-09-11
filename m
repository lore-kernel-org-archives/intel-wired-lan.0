Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF894C88E53
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 21:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A603680F0D;
	Fri, 11 Sep 2026 21:02:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ejnsfAXDxDE; Fri, 11 Sep 2026 21:02:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD3B180F10
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789160534;
	b=IT6oszZMqfIpkVG+iDbXqQ/cnRi8jGxla87tr0I78nrFtvQkHUcFqosNuugsESqaWQRl
	 SAN1MAYeTX8kdtyA18N07NlrRPfzQ8h4RPjbGeZp3fNPPO9tU7BuZ4mDzXe4YpCtvemfW
	 PO6gPuXbbVGCO3kAKWbrPBcBHkYpP1ztjyc1NooG0gtjBL3MTtf/exbisNMfiI7p6X3jj
	 sTA1svw9e4lluNialBlMXuOh80ABQYCgMwedyn2QSyOkAcfiazERz8N7Uer4YeobFr1/7
	 P403xpryL9Ov1AZrkOGG46FVh8A9l2ftGnZaZFItEIzvDlg/8YP5nXdAil4ziCvpyog==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160534;
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
	bh=bDXS33xHpzQXh0xBSEtjShdq+/GV0Ptw5yXc+/CNTOc=;
	b=Nfwwht8gukuJOmsesWCjiB7uWDQXPzDMDUL7Ql0S7h77nvGdQrEZiE/CQtYFBekt4pGN
	 Q3P6Qy42biOsxFb2D7T3idcVXZD4lWZMn5ugII21NnQqreD59p6eix+0qWyI+VmxebveL
	 IO3PjFPLHxRHtMl+qs6l2T+n1o4Do6gX24VaWxw5TC8VyCM0zqcl6e+aWZTmTLr42hxjh
	 tKkFFJnesXk5Fc1f6qORpFnMDIvQ/G2yatljIi4pys7DV08O6et84fj3fL7esZmc88BMh
	 teWPNKF6FydmNab9ZX0c7lo+zo8rHWiylHnYXlU3+QSPEJoApp/SaERz6A4HUp0lNMQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OLhnJLmP;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789160534;
	bh=bDXS33xHpzQXh0xBSEtjShdq+/GV0Ptw5yXc+/CNTOc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p17Vu5HieqWuHjrUMtndbZrwKmPaJaENFwgQibYMYOT+/Nfs0PBroL4BEc7SPg8mP
	 kN0jb2Vf9c0BBTiVyGBTwP6YOcFDrkZ4rqOkQmnLenn9d3ba2myFw0GtcLE6ywD8FD
	 w7dQGjOcdgB0iIoJcXdiQB9odZH+poU3TegQ++mrkLMa23cnyxbwxNWrGgDSkL/niy
	 snauLbtASdxH+ZGPaS10tCH1AyPrukd928kQrYnlWLhNQdPZ09rprTw8bwQEwf9fkU
	 lFlxPFfkAI0zUVrpnjII+fTq3lToWbnir5AjrCS+PW/mzat6a0Pqzx/6g6zelNWyp8
	 a+NivcQ3cN2rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD3B180F10;
	Fri, 11 Sep 2026 21:02:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EA4032F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E49E80F10
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:02:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b_lmJWRYotqr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 21:02:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7631680F0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160532;
 b=BBSDDBGjwEP8CE0Q9jMq5valyTrUVN8TtRbCQ8MZ/bFYNID5OPilY+ckYnrHjbazHlN9
 6u0GvLMFsBs9oxeq57XPRJ66N1zwSYAupwd7heZQsnYE5bIwJU4wmsLgoIwWjjbKNiP88
 c0xL9zqEq14rBkEcq1j4wR7qf+9TxOm6ThTgzt/vuKtfsrR3S4dShqhOwnFpD47R10YqT
 p5sw14fh8lJIdKwVqX9IbpxPDlkmGgGX7SiGxZwQnW9MLqOhE4PbJEl1QGssfb04Oa8j6
 lBBRbTcAQMJEoydV4+sY+DvRIDpbtmxDZecoPm0I8OEl3pbIqJSSGZ/ZRivcA1Sd6AA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160532;
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
 bh=bDXS33xHpzQXh0xBSEtjShdq+/GV0Ptw5yXc+/CNTOc=;
 b=HdcJCRSrRGIC5GYw24wkBCZGHtbDaUcSgUa9vibJ1Qmht0wrZJItIDvtC+1s31sZ6aT7
 +L/xRcn/5zg8OoS32QFsNJuhyzrywCrPNIvIo2CT95q0p4Iq53gqvC8cokwrMs+QG5Pj0
 z1pfzOgWBjgkkcrni19YkdteU4RKrbfKI96NJdTcR3+6eAkYHIYyAxB2kueyXHil/Ej0K
 +l3KdRtLBGefi8GEhhdFnUKe3/dPlzW/IIU6M32XUoCFywRDVk/WT6crI5HZ3zM9zGK6C
 /17uw3CsEqOI49wHEFnWLMVzye1FIyZ0ybecyNX5RoUAeBB697wGimH290rgjkUxK8A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OLhnJLmP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OLhnJLmP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7631680F0D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789160533; x=1820696533;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cqH4h8EbsGlRxeFiWXTo5AECZQ3l2M4QsH+5uxQN+uw=;
 b=OLhnJLmP6suLiz+MUu47wUEfYJ5W/FEn8XbLYpuQUWKsd0fYRps+h3Ix
 jOwpg5cbiYbr2k1QjkgHXNimxirihjWVMmK75a3cmLP5pwdm9MWpBUE1p
 CNT78om/IqsAdZycO5ScpWO75ShtYww229XYP2+QamgUnWJpo+354D6An
 e48cFv2yM0v0z8uc6dbfK20+MsiBGSDjw5fnL7VUi95BMGKy2YamQPSLr
 pLWm0BP38bP71LiKk8hxBD8TpV6yJRx/zPPw6C0Q+e+0wJ9erNKHtBCxT
 2iarE5ECjCO4DYFAOvjLyqO1KzqxX8GAfV/zbzQn42l+THF01VzFGQrH6 w==;
X-CSE-ConnectionGUID: NcjV2IZjSs+XPuMtvFhUQw==
X-CSE-MsgGUID: 7XI//WW8SfWEcrBU1IcOzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="100224069"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="100224069"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 14:02:12 -0700
X-CSE-ConnectionGUID: gi1LDJJqTNeJ/WR8JbAtLQ==
X-CSE-MsgGUID: rJc/sZLOTz2q8rE4mRpF8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="265828442"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 14:02:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:02:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 14:02:10 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se3nE4BflcSfkoqtVChDzdcoTYsuu/3vxGTDze/PFDob6T0s9ZGe7lQjfZIHlV/hptEn5K2Kj7te5M+KD3uZP2CK9KMZN+d6VGdpwIc5/a9veo35Gm6/0DCse9WlSxniGq/60C+9kuSjlxgWMHuzGF0lG9V2CTyRqz/oKVax4riTz1eE9pU6ZPbGcx082tQBr89qtF34VLwQdMsjVWSRDmCFsH+o5+wKFD+TJE1qxgjPFvtJaCH6C97r1Wq7d5CMrKilBhGuSozp9Sj3Jc2/XyemYqI0PJ1jfdfh8RzcLuw9VB2hW99rCPw3yF1IjfPI8y5hbQy4yPbpVFD6DBzV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDXS33xHpzQXh0xBSEtjShdq+/GV0Ptw5yXc+/CNTOc=;
 b=JeakP5vcbGv010hmxTcRZ1PnEvxBlxTbrTL1BsYQhPibHDjfBXl28GPNx3jU4c8wBtUNwRf5ZDrJs++rRCcleYitOyZNEu81TqDbzuVqhk2jMzzSmvg+ykPbcHzOZJ/Eow55ZfqzCIpFa4EatpT5mBxVO3hMy38luE8dSpGWhoGj38gU5d1/0/3JEHjI6vUdfjdIL1ak7pmYMgrL6/xCg0P79vImpy4O5otOPkJCGJcBzGMfHswPzFuGs+UZNJEWwVlNV4rmmQK+i/KodZSfIR7ZRIpnhan45AeEwzOUJNpfbD3l8Tq1SmGY/dS1RWKULoGnlv9+XuM4qsTblDlGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 21:02:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 21:02:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 3/4] ixgbevf: fix typo "enble" in comment
Thread-Topic: [PATCH iwl-next v2 3/4] ixgbevf: fix typo "enble" in comment
Thread-Index: AQHdP6TIvTfms4qcFkOjpfc37Kgg2bbJ4jag
Date: Fri, 11 Sep 2026 21:02:00 +0000
Message-ID: <IA3PR11MB8986F1806DDAFD781B36868AE5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
 <20260907095446.27290-4-hemanth.selam@gmail.com>
In-Reply-To: <20260907095446.27290-4-hemanth.selam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 12d45696-22d1-4835-d007-08df1047ec67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|921020|38070700021|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: sZOp14lMBt5xxdzNYBUSsTjJi0kmF7JtuLmcfrgnYk6dxqYqGiMmt4xC3NpXDIusmlc97J4VTeoDk+1WVmGPP6xLmU8LJ4Jq1nLsjgx3utJbRb8K8kHGnDuPDGt+oUeUltP8rMBJRyZ/Jho44FyOeI7AVOULNwKvkFZTc1xXsKjYjg5P26xVTz91Kl2DyrffTfAF1+y36VnkjVGyXhYjfbz49Y9CSOeOimCri60Ls9aKYaKqNy5idr0qUIIote4gSJcQCRpa6l3c9sjJUpIltgrh9OluQ5hbvyE4wZ317HWd2ZD0Qg9Gkl8SAcfztBwL3jkAIozZvZL/vvFCj9jUKWVDJhWHYfVdoYmOGqDBO1rIBp+5TUm9+kgbdOJsQiVw7h0Fudqz9bFG5EaKesUsl6dtvljsgOVNu3hiXsROaZXjl1oijaccB8SdF/mTGSo6+a2VQP8HgQSHOwgQ0E2cw1cL2hllNX6se/AtROa2I7QuHcF1nwlFnsk/naIaxMdFF9Xf9R/OMB306HQHdsQFpbSuLOi4WexKcR2MmcS9oHqqtqe2nZFUe0jfZmFSMvQRFZqC9d8XqwYMaZC2dnt7rnU/Iwv80MrszOEH06po31ONDW4+OzVRcmVsRYdm7XNW602moLyU1Px3uX/XwefpCHw4A+Ht4oBIYxCgeauvveIqq6vCc1W+5ht2WdKWHget9W7X8G+dzCmf1VEkYBcyAssQkcZ1GsEoDaJgRMV3pzPjKkV2hO9nYAM3WwIzzjQo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BhW/n5CnRUhX+NS/eRxgN+pqCdkgxjCyu8kDmN4Se/ZLrGGtfcvLPDOwR7NH?=
 =?us-ascii?Q?kz8Sv/AMIeV9hmKCRflZvMcbHlCkT/hqE3jYX02Qh2rlIQZ1mku258YO2SGY?=
 =?us-ascii?Q?DwJ2DkkRkpS4G/WlAiah0j+yxQ/t/m6q33s75V3f8x6FJDCkDYSvNcyFIw79?=
 =?us-ascii?Q?kz7YSFQXVjjiXln26ipv12qZ8LM9YGFCtRkJ3idqpl063QDpBJC1c4euOUFD?=
 =?us-ascii?Q?1l+rZTylO+s2Gujc6suB7go1ajx3jb4g86R0WLiprk6NkM8e0cDHkoz5ASXp?=
 =?us-ascii?Q?Fgo9Di/2S4ki98dpSmdNHnBr5HqH9LdWMvI/u9sRNfWwMKE3+S5IT9NQ15bW?=
 =?us-ascii?Q?Y88bL80z2EFLDHHSAscilvI3c6ryzFe4BfAJ8y15cNUUcy1kvIuCjjGO2ORv?=
 =?us-ascii?Q?0uhM+Z10ym0FwWMA/ckSATOOrHctULNp2/9rKVH6nlJoGBpXomex8Jvjf0DA?=
 =?us-ascii?Q?FdbU3a5qVe5lmZ4YKVzA2Mvt9d/ZCNd8zOIOZs8KQ1qeQeSmQpe84BMRxrPo?=
 =?us-ascii?Q?izLSLcegBId6Dk4Yj6jeq2o8GtC3OogiYNmKNl6bJEVmsT1ha46tlsETGElD?=
 =?us-ascii?Q?3PDj1uP5CNkXN1IOlwcUIq1UhPOZxjr1b5iRzUVmTnxwm17J/RdJ5QWiG0vk?=
 =?us-ascii?Q?j1oMo8mMuwEUCrenBGqnij08Ax7owW6Q1YLq7aJqMAbiUEDN7Ux6MezZWV73?=
 =?us-ascii?Q?RiGzf+9F+aQFobnvUwlTZdxqjFF71M0/OIjn6rRRrS0egaSKGu2mEAOSlGmt?=
 =?us-ascii?Q?dK/udDvROgfSh+kiwOZqYV31UtFSJPPEDS3Jbr5SEABeVZrxB8jAk/eedPRA?=
 =?us-ascii?Q?2hPddfap1WNd4ZhV+i/445k0NXWHMKJVmi+FlKVxZNjNRy3FK7UtNxPaiYMO?=
 =?us-ascii?Q?P+Cb8itsbUpQBEwdnIloSe58AyV1YZjrRXJVyPzB3zTL9BQyWCVtxPPiP0aW?=
 =?us-ascii?Q?t+zwo9xSKhaS/CA/fD1eWQGMafKZI8TwuTQzFCUjSum71gZ7DXsDbofkcYzf?=
 =?us-ascii?Q?kFwUBCwZbU2eGQJ1BpZQ62QISnvKb6ukep26OPswWlf4QnUi5OHsK5UA6AMo?=
 =?us-ascii?Q?UuW7F9gZiKzJm/wKepWLVAMILnUzn0KCFiJXpDvBVFI626+wHSKWKIY8bS6R?=
 =?us-ascii?Q?VSuwpFWmwHXLJJVQ2sm3Sn8V5ePMijubLyIPc8nPG66O+WBpgXZzJ/EkCP37?=
 =?us-ascii?Q?8vbx7ukf23fakSs5C2XH1zVh46RbDhACCEKih7ThQ8jqIkDMChyOGCrHgbc8?=
 =?us-ascii?Q?ndgw8dFVPDjX2j9xWzQws0kGdBG5Y9PtjYq27hZ7w+RwXN/XSAWdWWIvyoAr?=
 =?us-ascii?Q?az2L5CwzVKYUUxtpTsk3u1G13W8ENyl7rc+XfOM2X6ZtshseWN1W0+LsjYIh?=
 =?us-ascii?Q?rIuTpwupLV3fGhfbvMDRkwUHUpfQYU7wzGVqmTDYteennxUN7dsteNY7cpU6?=
 =?us-ascii?Q?7VcKiRH4LvnaV9nUEZqCMLy85+8ugH2/UTeBncHGC9ozMWp3d6gMKI9i/NpP?=
 =?us-ascii?Q?+gVkVLpzpqnS/HnmWgbox0eWtIV7QlaOYOt2fQ39QLTB/1r5swScu91nVh4z?=
 =?us-ascii?Q?MC/DG5Qe9qGqNe/Vd6H2Yd4YkEbps5SNmq2s3e0Z3Zphcnr3SCHJ1HY7zDBj?=
 =?us-ascii?Q?foTetJOeyWtZbsFjU+p73Y7xhlBJ8pvh8XAXa7PR9CBEp8YeymWG7PKlq+JW?=
 =?us-ascii?Q?qEz4PlitjOBcsLVvL52d3c1UZV9lIxIAzoW9qdzcFsYzfW5QY260Xokze5JE?=
 =?us-ascii?Q?CL2c9ueI0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QZaoaWRL5FlWUrDnrseAb1/IgmuGQLNZkCNWbSvXIWCqeTHZ0fofPVbvXhhjZJqIZBbNWDP3vfsyfJGF3M7fX/IkF2lvdh6MxaFklwmBv6hxypiiw2824ij1pEWLqIeOV0JpZwUhpJkIa2OIccOTZxURR2Dv3RwwaReuTR8h9/db2ATZB0o+BG2A7dw5RHklN0p7e12MVkwHVyQ3xQTJ4xyDNBbm0LtbQMF7pZdagsvpPflINqUSGg7+uaoxa9vnaN6e7mMUU2GFhLOvAaIqF7fac0OxQeJ3OgllmiT0F9rHuVl2oXYR0l6yhsYh8Cy/yHex98hbpodSkTzfdWwigg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d45696-22d1-4835-d007-08df1047ec67
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 21:02:00.4795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cvL5L8eilnpbrc1+d75ny88T7AP7ob+FufKdjA7uNGOhk5jiCdADHeWz5dm/ip0He9b6syGWWOa+Cu0kumZHdIfsJGm8asZQ2tin7IWIms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
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
> From: Hemanth Selam <hemanth.selam@gmail.com>
> Sent: Monday, September 7, 2026 11:55 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Randy
> Dunlap <rdunlap@infradead.org>; intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: [PATCH iwl-next v2 3/4] ixgbevf: fix typo "enble" in comment
>=20
> Fix a typo in comments, found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt. Only touches comments, no
> code changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>=20
> Notes:
>     v2: designate the patch to iwl-next and use a subject prefix
> naming the
>     component, as maintainer-netdev.rst asks; v1 went out with a bare
>     [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff
> unchanged.
>=20
>     v1: https://lore.kernel.org/all/20260907064528.6602-1-
> hemanth.selam@gmail.com/
>=20
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 7ce46b4b4821..7eb4acf59dab 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -3995,7 +3995,7 @@ static void ixgbevf_tx_olinfo_status(union
> ixgbe_adv_tx_desc *tx_desc,
>  	if (tx_flags & IXGBE_TX_FLAGS_CSUM)
>  		olinfo_status |=3D cpu_to_le32(IXGBE_ADVTXD_POPTS_TXSM);
>=20
> -	/* enble IPv4 checksum for TSO */
> +	/* enable IPv4 checksum for TSO */
>  	if (tx_flags & IXGBE_TX_FLAGS_IPV4)
>  		olinfo_status |=3D cpu_to_le32(IXGBE_ADVTXD_POPTS_IXSM);
>=20

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
