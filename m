Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E965CC982E6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 15:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1F5880BF5;
	Mon, 21 Sep 2026 15:38:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNikm8R6XIQ2; Mon, 21 Sep 2026 15:38:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3EB380BE7
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790005104;
	b=DEpGrp7BTVag+RcjUjDVCjcFYz/PpgX1IhWNDB5SQQDOnlIrQtGbv2ovf5ZE+6QZV1Q4
	 ejzCclLpET0FPFaYupNmW8SLA00ZqApcqirZCPjbb7zsNCKoO8CCBSMARv6PSkkMm5i3W
	 SsIxgHZAKEqemyoxuiT32yqTkE7sFhkJVUylhAi095a95MDoprITwxgYZH0f+BY8rayaU
	 W2C3rr6RZWYAv0KmjAMzZF+M6QR3EuOtj1iPU48xXxSWKBwyTz5VbspRlpKiaTlhkngRi
	 MI8+lusjFaz+t5vDdHUWZ0ItGXx6NcawOGw57gnK65ByCEFe0pyr9qAxbleVHMpW9Kg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790005104;
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
	bh=1G5PwWRPekVsWCXJhBC4O6pgzO4gtiPTmTiL9195cfs=;
	b=IrL0QbnKnkVh2RFy78N+IqKMRIuu/j3kz38vjWqRmPXATecufUDL9BVzxoowjuyi6flv
	 x572urZhKbsmXcNvtqeG2Qf5+uWtooYtDKWyED5X3fijK9yvnWbETmLQERRW3166LyOUf
	 biSRjkS8M6adM6oQfo0ch/uWHABNUoMSVWZ2sV/Kz3EnuUfYyOhf2iEpvBaWqZWbKtU3s
	 bnkM1kzoAfQu4mf6fOh/oGFy1So32WuQqLqt10/af/gRvkxkv4+B+8ByBq0QEwxW/3Kxv
	 6VXNeFPegayb12p5PS6KFPz6820QJpsVrtzitw232d3KvQXcP+VzaxOmKyYM+EuzuYw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790005104;
	bh=1G5PwWRPekVsWCXJhBC4O6pgzO4gtiPTmTiL9195cfs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J1AO6mDZLSvTq2BvsPdYevnH9kmMW67slgOClXyLQlpwNIVnuH9Hqz1qQlQBa9nUI
	 ezCMjwq1iYsrbNlY07QwLHEPfYg5Tumgw/J1b+lMyaTf3Xc3FGBrGzeJE+t4Tq7tCu
	 42j7j1xHhQBMHUJARxJiyWCe1xqBUGDDeLzVhUksMjcwMpOUneg7JMlNaBw/6aVBsJ
	 fHUwuZRPjkFyBSjlRd5ozSmlROqE3fh9zmazZVTdwosjTqXArT4cDxK4sbvT+a1f1a
	 Lo1CZwRHaMDAeEPvE/ii3M7VemxvT1OVwwS3PT4EIRwq+h3tnInp6pU0MeCrOgQ/ww
	 EfokXc3cg0PQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3EB380BE7;
	Mon, 21 Sep 2026 15:38:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A26A212C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93D4960680
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:38:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TRR8vnAjuo-b for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 15:38:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8DA766065F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790005101;
 b=pnAvttjxawT1f3+eSKn45x0MxjN9wRSvvRagvjM53yV+a+fv/bSYx3DCMKUmDey2I8xe
 WaNSTYVNIXJBWM5+RRcx7563UZk5ACIHVDhXhyuv9IUzqzYzT+0Ha0Tq8Qbe6wnad9vPI
 ss2MJhhEscnezT75d4J473Gtw8UfphjDKUoiB8eAvxi/fLx9bM+31//iFQmGSy6qOxsIw
 NfqIF6nZLgDv8rODXLwFlDyGTYZsyEnuROl6aDwgoBo26rr5ZQqopsMmxlMdvoQIEuTwV
 XaH0nfEj8GJUdkEw/O8unlllReNp1Bhtd4K8qomm9SCPGZ3wcdJ9hjDgIAk6C2q8kng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790005101;
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
 bh=1G5PwWRPekVsWCXJhBC4O6pgzO4gtiPTmTiL9195cfs=;
 b=phNFbA766fZi9Xoo9X9k9d++vL90raapa88peTG/egOksRAfSXQbpYjBdQx6Sc18PA12
 ldbcs9O/6uEAmFJQD7UmYDmaY3qVwACyEJW0upPfZST4O2ZZ2w2qg+B8plmaEs12uhUSI
 6rKK8G21PMm1hrIDZn89dyd6P6zTGlMMTgxg67MvOGqwEgplErVP/avIxhKMoR7DUohj8
 HHKrAQiw+E9CANRcnwlJh0P2GDkpWfwLL/kzIOVUeo1MmcAvzRlHDsCdFb2eO5Bt84ckr
 7CaxzX6177BhZ5qvTNv74bvcMjovBsn5yEcJLj6FydGEeMXWaLjA98L7KybzYPdlKZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nBssBLok; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nBssBLok
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DA766065F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790005102; x=1821541102;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Poad694m0qPvhSesT+th1zTiLEWmUAULNZZymKqZU9E=;
 b=nBssBLok+A43NjecDHPzIVoX4VbIMobZbr/KAd4GV5zzmbqnDy6P3eg7
 H/nx8c4r5bSJvtKVl18SPh4PCw579MyTsCnCYCKufy6RJtJzifxX3o2jg
 WIQXcleRXZBUVzsSCA5eoB80aHXikUSvJVrtZQ3FrCzifyxfhfmMvLrK5
 QEb89OeTzqsEUFcOf0Ce56YSjwTyz0DyqMY4QRIAw0/XMHjm+qi64se8l
 HgoC86d60vOtnugYDbUN5QCDpiyG4XZ0ARxJe+46TVVH+9hCXh7x03gVa
 Yry5xCKXMyGLyCsbG0x4SEfNIrMP1Jg0L6FJa1kM8FzUJ+V9Sf58fnkH5 g==;
X-CSE-ConnectionGUID: ACNardS0Rd6a76Bxb4ECTg==
X-CSE-MsgGUID: k+tyIOhXQQ2bp1Hnn8qUPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90398213"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="90398213"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:38:20 -0700
X-CSE-ConnectionGUID: +HOgJsw4R2agFYr7Hot+kQ==
X-CSE-MsgGUID: aJ6YuRU7SlyMNY4ysJRytQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="298939846"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:38:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:38:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 08:38:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwji47BGjDo/Shvr1q4Dx/rhAcQ69bP0WsPiJsaOgow4WcpPCDlnl+wGxPHabZ/ZYrNDprkSx7xcS/HBE4j+H4TFLFjTXylpV2VA5IulTCNMGiXTysMd2alB3bEDr+aIfLK2rhfj9S/5L73dPizqnat+UMkbfRB7bl/RGQWj+hzbbbNIu62/szqEXbTJaJkvfdQITtqNELgOq4OkSm9sYFX/aaDiB7jntpwLJe3zT27JAdDaZd4Eic+d2ENK6cz5/wRXXUPvI58KyxgYiSIba3Pe5ueX3YpX9zzdB5TEX5pzOSwTZNorK6Eu1dNJkcpDUfgjD8pzHRS0Rap21GWxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G5PwWRPekVsWCXJhBC4O6pgzO4gtiPTmTiL9195cfs=;
 b=TiB9gnEEab+PQWm3YffcAAfjgnwEl4aDcnNC35Yo0Y0grU9Q1Ur1vxhUT7+9WuyJt37e5RGK2EGapD4K1SkcsaM4EQKX3iBuaTsYVN/Lm2XmejOSQ6h0MpAitrwrGruHbUMGeeR5yqPqEhK1CrVYzVg8NNzn5gBHqRqSWGkG8zoOtCaIj//+u5NCnuJTD7jnIEEcipW5j7xk9z6L3L/pO+y3xBIEYZ+pKMDjIPVQyzbUxPDqeW+J2BDo51vcYSVWTLa2N8gYm7euustL53KS0OpykihxOQEABcshhQJceIvf2wg9jqtwwN9wwnCjYwjb3GbyQg+hPq9va18OLq+ZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA3PR11MB8967.namprd11.prod.outlook.com (2603:10b6:208:574::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:38:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:38:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com"
 <syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com>
Subject: RE: [PATCH] net: e1000: fix warning in iounmap on probe failure
Thread-Topic: [PATCH] net: e1000: fix warning in iounmap on probe failure
Thread-Index: AQHdSd6SKc1qfuTd60OoAKqrPmb1zbbZKdvA
Date: Mon, 21 Sep 2026 15:38:13 +0000
Message-ID: <IA3PR11MB898634DED4F39601AFDF1145E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260921125932.7943-1-nsvatoslav515@gmail.com>
In-Reply-To: <20260921125932.7943-1-nsvatoslav515@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA3PR11MB8967:EE_
x-ms-office365-filtering-correlation-id: d8d2b2af-db56-4cb7-3a11-08df17f65923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: 34f1LGC3juhIq/117xHwhTjJsAHDGmQbGY+0bWfpjx/5hS1YUkxOS26f46P7f+fAhFVgeth0Iw7SySHEVxc2/rV3351JtJLRiKFXq6g19E/F42fUnOm0sbNoqsV80ZSelpo5NFeEGYxKsGhjhVMXBl5f/fOnce213JxmCXrC5N96nQtFxANigkBOOrQ6MayN7Blpzv75Bh1agNJefhy3PM3TooEXHgbs9UKn8gFxJnPKiQKxEtY1v+IvYUZ9bfelswR2b0QQYlU+n9/gZee4unglj27h9hLHvQP7QUlcbHUbKT6dLUBIPVcJhTiwazXyR+BUppYtXkJaV6/sge65Y0IaUaQV7gbNm+xoR2O8ixvPC7vl461bh80skDpoc3nvDC9ZslUx+B6HAnr7eU1Oz8r1s/raybaN1nCQmQqyQvJZYYw+lQRLvYDymFPAiIuPuf1G0uPpAgRlc8pRpNxQVSKVuQAh7BTRNnIYzHLKnnFuJ5ARnNoaXE8oX0hPbHE5D7/AYR1acXiXeFYFthCmSDR6jIrxK9RQSPjK5cGrITvZEfXI0xKc8A562Lr/PoU7iZTxe1oGOI/5myGazvtXSvTG8jd5R4jwIZI73q4/vbV6jN05MU2AHB99XVJy2uiC0qaAmxmvhqJJdDow7GxsyA6+5CgpeZhVdB+vZb/18B9pEk+inPm2T/QGnogr/V9Wa29flUxYN73LcozT2zGJRv/nMc+Ia3SbongocRaPWjI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HA0IrYvDq5N8Ienr8UJ0a74qoOocvIKff9GwR0P6nLp1ls/zYPGI302pipWR?=
 =?us-ascii?Q?5H3YDror4GOT7QR9p8TsKjX4sKsFCUbc2n8FGgT9BABAY7h/G2kGJYP7be5g?=
 =?us-ascii?Q?lqVU8LcT52wk5/EjgawsNuBoOGOuy73Tuc7huDwH4mkZNlXBUZ0ojCCv0Bjm?=
 =?us-ascii?Q?w+kyE/qdrVGjzLiGI2KQhwniFEZwPqO3DxGqloIfFud8BC0G4f6UboC8Tnpb?=
 =?us-ascii?Q?3ZuuLb+32ebBi0tKdG4IbFV2B3FOOBjDWH/jDK2ShLcHBQkX3aKlInbMbO+O?=
 =?us-ascii?Q?T2sQeyg6EJRlRSEf8dk94fJwEcuZ5rA5kvKCV0lUlTuItR2jwObpjUSkyuOp?=
 =?us-ascii?Q?Pp6vcU8jt0+RoTzMLB3XSyp4Bc/Kf6mXk4m1ZChTefP69rMGwfiA4D+u2BaM?=
 =?us-ascii?Q?q/dwm3rcSKUsbiO72jTSz5F6RHIgjMxQgsqiQq9I3L8oyDVoxo0/rIrtD7ug?=
 =?us-ascii?Q?VqeIsBMGTkuwe2+8IDO0XR/AvZN8NaUSfc3CjJ+g/+5lbVljuLEzpsOBnzM6?=
 =?us-ascii?Q?O33+xNKXD8nSIAf50L3mHDeqvpDsLOjUdVuL1pVRq05nIAoOihL1OurejeMB?=
 =?us-ascii?Q?k6eFba9rv3Yg8MuT0a94u4kte8bQxPsIgJQoRCc177jdN76M7LEic2X339Go?=
 =?us-ascii?Q?caB/1tNrkT/IBtmTnvHlBcpetMmyFnNHGSEUK6M63Y+w3CZNLqTeIqqX5es4?=
 =?us-ascii?Q?jA8Yjjl1AHuw+nWVhcll7lGwt3BGIQcXlTKSjmmqPQHdkwChDIXwitfeFsmU?=
 =?us-ascii?Q?sEwd+wv1E47gkJeFcrI18O/bZ0D45bv9PYx38oFuDlZ0thgpTGGaO75nfPlh?=
 =?us-ascii?Q?Y3S56HP+DsyBfPiihxtGuRmOGWrjSMg8RSIMZSNr3bpzt2BUHUmG3yY0WRd5?=
 =?us-ascii?Q?jdKjA9ElK6UVcBAj5MRlAjXA+qtDqNThG6Zbs/ZRUGt8rloNygZP7dHDzDbF?=
 =?us-ascii?Q?f+RwtDZhUi9X7a12/ek+AliXpjzckMOhpx3AlbGHLIIQxsVGfreTwThNenUw?=
 =?us-ascii?Q?N7e8uH55b/3M9dxk2KSHhCxkLbYwizzzVU5MAbdcSQcCLElrtGuRxccOgP2Z?=
 =?us-ascii?Q?4elgW1g0I4cUTrWYh9lQOcFSpTjPU0fo1RmQ3KuuStMwCjY5HfUnNOsnDvzH?=
 =?us-ascii?Q?g6mBOUlKrrmJVfK/RkT6JECo2SqsJo2F26v+i9XLd626bRk5v4e57Z38GaI5?=
 =?us-ascii?Q?/DljZhOSJN5zeJmSGDL3uYDOQPiK22OYml4JtB4jeiqJhSowamjFIo99y5t1?=
 =?us-ascii?Q?oJjoQFy9QFYRYsgFY9WbuHrHM5LYQdxVQSnSjIeg0GOQqNTqNNggZTVO47we?=
 =?us-ascii?Q?tqoIelKRON7UEAT2jzYzF/TdFivYnOhKQdOY/lAoG0xcYuvdgdxCUzpLdUV4?=
 =?us-ascii?Q?3Xsk4c+pWO3Pw4+u3/XSAqYvDo3khREikp81gcE2hDiAOvPzCyvnq1rlFm5Y?=
 =?us-ascii?Q?pFqhJeomoai5XIMcY5UA2sEdY8yN70YYfztVpair3h3h2dRHD3dRnpBZUupc?=
 =?us-ascii?Q?U5nkFVUrBIajUAnASb/S6i4/x/PjqBVrsB56BvO9Sd+Cy4Vzh9ljeJSnyVxz?=
 =?us-ascii?Q?bQqXwGanqVjkAgJl/ZDQ6zQxdEEzSlzpGZz2mhxuWNAVmECI+GQpJlr5iWae?=
 =?us-ascii?Q?Gk4fQ9rqRDSTQn7WPMRHuGz6acIowic1DEt076+32i+R10Oa0dnt3er+X3tX?=
 =?us-ascii?Q?6frvqPGLdGrWZVfK181XJjvF+33bXBL7Leh+6IoFVhHEsX5UGU+elRofVg7s?=
 =?us-ascii?Q?qoBdlYrROnM2W+JPAGjssNfeYWKtk9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zECTLzj5L/r6UKTWkJR/G4ds9oDQm/mR1l/HrqyNvf4sFiReaKHr+sarC7FBrXRE8kWrDS7zXVr8tdjggkcG1RdtvewlyN2GtipAmnSQE5kE8oqb4Ffij95oDeAYYRVQFsdPl0W/J62UcUcPMsxTek0v5qbUvfv6ltfFs4UJyNVelO/msLCBCw7SoeaN5ddnGX2zszqDMvUNJTmV2+jTt006nN83/KU2uxHzAW/I/o1tfCf3UoMl7uobs+D2ZZ4W0q94Sg+zPWQQ4KNZp9w0P4NiCOXlBAsIbGGA0ZGN5ppl/5IvBG782lx3wymYGG6ARFayfC45mEmDjeM6MKJvQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d2b2af-db56-4cb7-3a11-08df17f65923
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 15:38:13.4513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPlgldWr/gvambrW2HGLU0I+eDnuyyk5y5RDJuQfDurxZrBXGmseSvSyWw3zAG1NBo1lW/gbMPrjD1SUP71tXuulLm06P/il6I8psTGjq6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8967
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
> From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> Sent: Monday, September 21, 2026 3:00 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Svyatoslav
> Nikolenko <nsvatoslav515@gmail.com>;
> syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Subject: [PATCH] net: e1000: fix warning in iounmap on probe failure

What configuration you have the reproduction?
What are the reproduction steps?
Is it a crash?

Please specify which branch you aim to net/next.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>=20
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com

Rule of thumb it needs Fixes: tag then

> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c
> b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..156903089fa6 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -	iounmap(hw->ce4100_gbe_mdio_base_virt);
> -	iounmap(hw->hw_addr);
> +	if (hw->ce4100_gbe_mdio_base_virt)
> +		iounmap(hw->ce4100_gbe_mdio_base_virt);
> +	if (hw->hw_addr)
> +		iounmap(hw->hw_addr);
>  err_ioremap:
>  	disable_dev =3D !test_and_set_bit(__E1000_DISABLED, &adapter-
> >flags);
>  	free_netdev(netdev);
> --
> 2.47.3

