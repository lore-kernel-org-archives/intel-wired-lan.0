Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6E606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=d6dFRans;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QYLBR/MQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9903960607;
	Mon, 26 Oct 2026 22:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Sd34-eYc7So; Mon, 26 Oct 2026 22:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D553E606CF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793052450;
	b=hszBA5dZdw3VAOhGXVZHcBBiw/N1BIcxNtYZ1XyIkhcnQKo5LXmII6g4YCYGlNdS6jPi
	 7Guzx6lWWsosJUU4YlLptu4OkYVgXnHZ8J4D9uHfdxHRbDMshZIR2NN7FMYx/P/T4epVU
	 mZTW4tAQJqjN9a3u6qAg19eHyjPD3eXpZnQZ83FVPN3+JlcR7bO6UkYiWMS/b5zXF56SW
	 xVj0EejKO95AuaBwJnWC8F8nPBs1yGr6gTuhL2//398XQhrHj/3rimNW2RbKq6CDJsUHt
	 kZtSFmqM+vJ+D3M00B23fXuSxt3cUuwdIeRU0n3qYQyzzqw3Q57EXK+4b09Hi005lkg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793052450;
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
	bh=+S/ZluCGECNBnnA6oz43gP81AjKeEGqS2lSPzMpNjOg=;
	b=Vc5oUaNOcw3/gaIbxvJ19NNKHxFy6QZ+zEZ1PgQZaGtj6Qy2xU6mAZN8cOaXOMybhyh+
	 DH2Jrf9fiwV9fMm2fHeardUrkWn3pakCJNLXT0sDj0p5WO0+fA3HHe1GlKFGQLqOcCJnZ
	 5G5rqfKx/A1ctkzjwQipM+djwESiGo25uZrmoCf9ceY0J8AuD986uTfn4krKWAZvl8qOz
	 T/p2q1lHrhUWouZ6Dhq1AoSwF8Ke2WZXGdtZpJhfZ7V7zaN7FddRgnnC/3KDVOabnP8LY
	 zkeNHLwWn/PaMXPFqHTPKJdBr+J/kJjnt3Kx37Pg8Lk5S02L+wjYlONzLyNSSFpjzhQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793052450;
	bh=+S/ZluCGECNBnnA6oz43gP81AjKeEGqS2lSPzMpNjOg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d6dFRansPPW/vxkPLRYrdfKU9MY2wJoYcjilVOBbdrCTi39nsDcCix6BmRQmkYlnX
	 jzX1HAXXco9plfXxc3SuHHyxkNeUURdex+LJY7JcXbBTUWpMdRL+10TSEJLOpw+B3N
	 O3rpva3dGEPniiCWBJQbMBPG3zowTiF+ZKOqjezPI9X0m4WmwtofGfYmkdfRf0YK+9
	 ogqEFkJ1qRsCA4PgUIUClEgPqwLDWWWqIg9U0VIja7PsF3Rxt5Rct8Yl3tQyMZ3T2x
	 1oNMUYEpgYjZuc0DIyiipaNM7+YvNDd7c2O4RMyf3UMBSdbdLMGmxFWCEKXPitFSb7
	 4PzepgIroefkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D553E606CF;
	Mon, 26 Oct 2026 22:07:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EE13380
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50A3240611
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xgq5wHJocsvg for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69BFB40604
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793052448;
 b=jnU4ZMNoLKVbdSue7Z7+krqNDu8hXqF5bD1Am/DGsPnXCEVsk7h485mwgfa9Pm6A4SYS
 zJUvLIMUp4rd2eK93jbAFQ81wMmoc9XIYDP+SkyEhR1xCJeUICXFBO/XEiWVfDU10zTnJ
 EVTyKwqjYNmDE6u+q6FnCbFuhoHR4roPJ2hb1m/JH9Conxn01qp786m6NQaJ9Dkkm0M8u
 YQ0ZQWCFCoXOeeiK2+hMxKLz0g00uSYrDhs2dLNaYu16YRAEdJMVFxMqlHLPiIqJL4B0O
 MHj6Pz439yuGZUhskfGOZJxbJk+7REhW250sFvG0ipFTu0lOsOGkxGXQCvPLM308NyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793052448;
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
 bh=+S/ZluCGECNBnnA6oz43gP81AjKeEGqS2lSPzMpNjOg=;
 b=Lao9Vw6Mx0sBd+3Fh7MVqJ2G1FRQL53YXn5eY9KZxr5MVRVqtyIYKjpuOFaJyKtn/25C
 Uhs2XsJx/VSrxClCQwKUyyfqqF4ocquqBu/wkhb3vfhkQqGzTLpQpwcUjEOnC6B2dLKbA
 PG4ojLGh6KWbhK/8AiQWQgbYYALPeHwLYZjR3+JmqgAnU62K01z2P+RpuZz5IN9BlJoK0
 KARkvccrOiAgLkhpaD9lQZkMRwj4CPkKPjZMfyHSIpoYZOGwhaLDe2843VWgTjRuKUJuo
 ulvDYe+nu3Akp2xEwkXs6M4BZKtQyaZwsbb5bVdXZqH8Jm31M+5adLR0fnAcufTZLBA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="QYLBR/MQ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QYLBR/MQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69BFB40604
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793052448; x=1824588448;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FKvgmWPjlHGQC7TC524LiLYXkWCrroSNqUmfP/f9wTI=;
 b=QYLBR/MQGBklPoYps2Rhv+wB12tiB5vHM+A5logOwc2ReLACVMZtpt+P
 P0NlNdgm1ceRIMuXvT9aleIPsF7qq38DXMIJjTZYuKspF05+mUdnt8XAn
 VhkzRcc9pBxhbLLtrmsVACvqTJTwJ1xD/om/RaCVp/66RugMUXWCqDqDu
 gfjsjdWfnUl8k53mBqg9RW9G2gLdwdMQEq7oBoMYKGey3mOTXsg8yY/RX
 zwVZz6FUkgk/8PwxF4yFwUiierxhmHi/ZFMIBK7ozwSo1CPLr5RF01Vyh
 GqXc5aYoi68BM3pQ7mgiOi8/zhpYkZ9ul/QHkk1FMUM78qyA2m+tj2mAJ A==;
X-CSE-ConnectionGUID: oEGbPQQiQq6cR8Zl2impAw==
X-CSE-MsgGUID: +BjajDhAQ52FDB8w5rA3nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1614393"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1614393"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:07:26 -0700
X-CSE-ConnectionGUID: +NJ4UvKVTdqxG/bnxhWh8A==
X-CSE-MsgGUID: t3/TIRTLQxuR7RkH+aCOMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4459127"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:07:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:07:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 15:07:25 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.20)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:07:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxcuJrT15h43CiDT4DZ3kJd193dKJcvT30e7nzbU5BSDb7mafDyxseResdC7TXv19Qwp4CEQ976eqeZyYEZkWB4x2m0J9r+r1iP32mERsCWkbZRkbz+FfSfjw0f+z8ISfdkwDjPv97V+ezVaWPy7uFf0mFxPw1qQBHo9Og64jamOjSZ8OMFe6WHD0vTKTbpVp/yBjcLod0A/VUfXRj0Oya0lEY94/I5FKxoquFpnG18dAnfT1XRNxSlNF4RlTzvTQTijwwL9rbn6CWtCOoptBmSvJhhMIYANOAPoESyxXJG15osF0n1yotKOs17DLcNB5cKsr7NEi0a1Bk/oEB+nJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S/ZluCGECNBnnA6oz43gP81AjKeEGqS2lSPzMpNjOg=;
 b=NKP2ZVU5k6+phSj5+RR1HaSnA2V9JquwFd+fQx+evVWtnOjxZm8u5Mlh8kdv8WjjJP6wt2nXZ36dDZvkpVqG1v9xA9GOVLYcg14RoxekEKwWNIQRex4+PbHvWuF8tne37a3JnBLeo6uY1IesU2HGWYUpYURKDoRtfPPOa+2/HczSA3TY0pZxU72i8zM5cVxcmfBCJyqz/JB+yXgehmCqi7RDZznc/yZLn/X+RllgFxiMkpJwE8Ihy7pLhN9OssS+umT1CXXUZzgitrMdVEwgbTJfr8yIq3xhMywxavNhe+0VxzuCQZBqRxm5+doMd66pkrbL1rKxcQlxtpNb5J3C2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SJ2PR11MB8347.namprd11.prod.outlook.com
 (2603:10b6:a03:544::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 26 Oct
 2026 22:07:16 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:07:16 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Ilichev, Konstantin"
 <konstantin.ilichev@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH iwl-net 2/2] ixgbe: fix Rx hardware timestamping for VLAN
 tagged packets
Thread-Topic: [PATCH iwl-net 2/2] ixgbe: fix Rx hardware timestamping for VLAN
 tagged packets
Thread-Index: AQHdZWfsnJ9ti1A8pEC9XefWJHqUFLcQYdeQ
Date: Mon, 26 Oct 2026 22:07:16 +0000
Message-ID: <CH3PR11MB566895E39F529F38C69A906909E5612@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261026163658.2733471-2-przemyslaw.korba@intel.com>
 <20261026163658.2733471-6-przemyslaw.korba@intel.com>
In-Reply-To: <20261026163658.2733471-6-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SJ2PR11MB8347:EE_
x-ms-office365-filtering-correlation-id: 62c0f7ba-5332-46d5-dec2-08df33ad7f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|261026140227099003|38070700021|261026121527099003|261022105027099003|261021123027099003|4143699003|11063799006|261009223027099003|10067099003|56012099006|261021121427099003|261022075727099003;
x-microsoft-antispam-message-info: z7vl4FG0mFQHV2e4K2xJAPe0pMJoXrwVgxmtZVVCy0qkrQdImSdWBPxuOvJAdC0BMao+yD/KjtrB1kB4KP7TKp77e+v2XN8DeDT7D4CTIuD/LXU8CmO0khIxfIUaB9YfntYUqx9g0k9VqVYC5nPeqBUrdgLmvE5iMoTYa1PkheHc7O8GDQoz1pqzTwxiQxTj7PYpqzSiTA5L2v4yOmm2DzERSyhh5OIc2ZCkJgfETiZ3zcmILc014gSGKxxlLEgX6nDgInXAQZUsEgObwEZWnvf+TSEpH3WFX9AHEj2K9R+M9p4BOwp3BjW0NF1hwjOyAsETkr87FC6z9fsdH2g8hT91d96Q0Yk8cz9Uq7u187RUfN5DrnHQxVZ3IgQJTTRrOPjveYENWVZ1saowgTKQkAX8/8QTXo/e6M/3Snk+l8yCgWbbsRhiKOlgEFZYvjFt04bbtrzaqoCCLaTgcKgjPAvefPVMUzGy1s5HyhuJjmgBT9TEWpL6N4NBL9XRf+/4SJwxeN3qkSBrf8Zf5pVle6/y/cZAHbyq86NoGz3Zj6jiLndWbOLR7MIaOv3gXVm4DfAqiQkSdwc11H7VEy+Cs6xorlyWJG/Sf4l9SIinzLvZEzVDXRY5eY/g0q7jSuVyG649nVRvkU+227f5hrpVqHY6ZyIwpBthGYksPb9ax0OQ6M80Do+0TjjxgOFKSMvEy2mvlBGRsKood2aWC4xj2QTl0fi8RfoJrcNc9NWVOEk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(261026140227099003)(38070700021)(261026121527099003)(261022105027099003)(261021123027099003)(4143699003)(11063799006)(261009223027099003)(10067099003)(56012099006)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qtwdFPvsKn2hkbPGB5hSkm0GkQAXPmu7PrdooDzRUwp7BgZKW4DFTQi/RXNx?=
 =?us-ascii?Q?HBY18XcdZaDtHy0kJGP76sd2LJcn9aMHpsISebZHHL+UMXQm7k0haCoJzsBH?=
 =?us-ascii?Q?vaXa6ByLYV7h/2WRiRMvueHL0gucxXx9fc5ufvelgJ1pQff5zM6xDkyRJ7Nd?=
 =?us-ascii?Q?JvJm3+v+iLpzFRq4L3q0/JBhcptgrUFC0mfNS47czFW4CFBLdF4E4fTB5fQz?=
 =?us-ascii?Q?4Lz/omD8oa/CHk1Zqjl1cyMZpOWattaqv0UR2E+xzT98Ck958MNny1OGAOuS?=
 =?us-ascii?Q?A4icmGWqb+70xIidwJVobCgQVjOiIrNFFepJdTzd+Tl1tBYVWzr7ASA1fIrd?=
 =?us-ascii?Q?0IPbQw9zlNvjJP0gPDKI1nxGfKJIDBnk+xYxTtFO0emcQfJtNYx+cDzLzfdw?=
 =?us-ascii?Q?FTHYl/Ztd89h947SQd39vm3DW5U7g061TpDiGEqBf05YtYbx+4FKeirvPg41?=
 =?us-ascii?Q?LnAzzi8Nda30eNvhvP0nMuQWoElZ6djT5K33UnXDw7JWZUkD+i80Eco7N9KS?=
 =?us-ascii?Q?Epnt7RXg+jSkX2dORzt60K8zn7NYMfDBTyAWYclY8FrVbZ4VYOnbiyF/kXZ8?=
 =?us-ascii?Q?YmElCqI+nca47qHFwOv6z3gc/oXlHk0VP4JTCKm26yc3yioVh2bm3NvN7l7d?=
 =?us-ascii?Q?L3p2EwOhguOAgIDgteabOv5F6ferr5wVRXE8iOhDwLAuqBnYKucWMhX0H80z?=
 =?us-ascii?Q?4yBgBwAAnRSEo0HBwy+UjEXWhR+IaH/y6yypwi5WuwTlykQfF7fC2d+nhH2x?=
 =?us-ascii?Q?atRsmFc3tq3oH+sWppCAjvVRxcu/XilaQpop9FuYWQ4hm790wljE75HD1WF9?=
 =?us-ascii?Q?IUWYQfHgpEgQukKccporZNwNbho4+zJR4vPnNn7d5yGfOmaafhvu7MTOAwCI?=
 =?us-ascii?Q?e+nkWZGQu2V6frXH2ZjnD9iXKct4D7ANu3Oj0RIJkAOUQj2DFWDyHqlc3hQD?=
 =?us-ascii?Q?b3QixOew2ZyQVss5WoXXJrv8xFe/J0XSSsaj9LURQqArVDxhjMeU1/u7RlL1?=
 =?us-ascii?Q?UymfQkhva8SL17Lihj1sM/YPNQc8C/HfGOcYSkPfUH+zrGikvkP1z2OFZgy2?=
 =?us-ascii?Q?9tSv2qw1/fKtGay2/QrBDgDWqfXrKcRfmRZXbD0X/CSNEolhbrMGzUjlBAGi?=
 =?us-ascii?Q?QaL1UnFJd1ae/BSYijFrkf81PzLdt1VMvSEutm+isVLSfij+70hXeeYlvdJc?=
 =?us-ascii?Q?3cLT+oYyoJiwiestapraUhTysoN4zo/R7QUkQ/PDA6bLckJVwoh75DSWJOF2?=
 =?us-ascii?Q?y3P7cXPpo0lzsxqkxRkB4yf3xuKAlBJI2FY462c4fWA2DB8xGyi1IFPIegyJ?=
 =?us-ascii?Q?fgToJW693b7GNLbbLcg6zb2s/S8NNkkAjIfziMmlVcTKGjn/9VZiFyZy3fl1?=
 =?us-ascii?Q?wepS41G5HvrdJFSxPGFiqON9M6B5JS6dPIquB3gQsAhku6CliitTVUgYXC1h?=
 =?us-ascii?Q?8SrBM0tHfpkRxUAwhXCN9WDN3WG3x1aA+nCxSYDkykOGETrDS4YBh03jqMuZ?=
 =?us-ascii?Q?tH4giYwLEjgjqwhJ9IXrBCQ8VVSkkDj0fPTobv5PssGwYkTFb8B+Uhfi2d3X?=
 =?us-ascii?Q?7K4XRBRWfThkumw77DcKc5HQdRhEMPLOII/DNViraLMhAoLUqZ5M4aZoFSLD?=
 =?us-ascii?Q?iYcySaBgHQTrPCxszDTbGDIMdt4hOnZb2n9u3sILeY7Z2ETqVFJnMojcpnqJ?=
 =?us-ascii?Q?Q1+mVjCOVbB0HJNjkmXTp/EDZ9c3ErAfUzQYFvbEf+FstX6c8+NWYPU3vz3F?=
 =?us-ascii?Q?SJz7e5JprpFa/NR0yUWfe4UJal2dF+I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3HLuEcjjaP01WBqsHaz3r+eaptG/rmPrT0uubt5HM0zUEPCiefa0cf6YhuFvCqElHGoUU35YMM3Z0Icw6sI3nDcsOpB/HOAebNaf4HsMJ351FqIM1as6YmFJftH2IjnGeBZJjravIHaBuxhAJHTFYb8OnYzW2Fyw/X9cEsBFiEGFE1jBG2+3eLdVi5dkGfqO6WCiPjhoO0jG3RTo+mRLofxMSdYcHSp7vs3JW8o0457bBg82UgCV3ABIaDacDjR4VV+i14gT4AHnEQPw+Eif1lCkXJaf2hN/ibnld0WvNRtdxqhZ2mJ5I1S+F+iLTlx2NYcmNMLMMBTgaHAUJDN6eQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c0f7ba-5332-46d5-dec2-08df33ad7f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 22:07:16.6371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOF7c5RdE87c/ytEWMiycYiypl/mNyTIaHNFU2otJrqELZLbjAbiqBLeA0ufLfC9e+hBXroGC9CX2kVATHnLCzc2o1BsWdgpOC2AOq/k3v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Sent: Monday, October 26, 2026 5:37 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; Ilichev, Konstantin
> <konstantin.ilichev@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>; Olech, Milena <milena.olech@intel.com>
> Subject: [PATCH iwl-net 2/2] ixgbe: fix Rx hardware timestamping for
> VLAN tagged packets
>=20
> Timestamp in packet (TSIP) is enabled by TSYNCRXCTL.TSIP_UT_EN, which
> covers untagged frames only. VLAN tagged frames need the per user
> priority mask in TSYNCRXCTL[31:24], which was never set, so they carry
> no timestamp and IXGBE_RXD_STAT_TSIP stays clear.
> ixgbe_ptp_rx_hwtstamp() then falls back to RXSTMPL/RXSTMPH, which hold a
> single timestamp latched until read, so a tagged frame is given a stale
> timestamp left by an earlier packet.
> Filter type TYPE_ALL also clears IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER,
> which gates ixgbe_ptp_rx_hang(), so a stuck latch is never cleared
> either.
>=20
> Set TSIP_UP_MASK along with TSIP_UT_EN, add the missing register
> definition, and extend the clear mask so the new bits are cleared when
> Rx timestamping is disabled.
>=20
> This covers 802.1Q priorities 0-7. The fallback itself is left in place:
> any frame class the hardware reports with STAT_TS but without TSIP, such
> as a QinQ outer tag, would still be given a latched timestamp.
> Suppressing the fallback outside IN_REGISTER mode is a separate change.
>=20
> Observed on a machine in real use: ptp4l over an 802.1Q interface never
> converged, reporting path delay between 444 ns and 31 us and even
> negative values, while the untagged interface held a stable 3 us.
> Reproduced by adding a VLAN interface and running ptp4l on it, with no
> kernel modification and no error injection. Tested against that
> reproducer on two Intel E610 10GBASE-T ports connected back to back at
> 10 Gbps, where ptp4l now converges over VLAN as it does untagged. No
> kernel selftests cover Rx hardware timestamping.
>=20
> Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 6 ++++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> index 8dc6a009b62c..4be7450beea8 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> @@ -1084,7 +1084,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct
> ixgbe_adapter *adapter,
>=20
>  		tsync_rx_ctl =3D IXGBE_TSYNCRXCTL_ENABLED |
>  			       IXGBE_TSYNCRXCTL_TYPE_ALL |
> -			       IXGBE_TSYNCRXCTL_TSIP_UT_EN;
> +			       IXGBE_TSYNCRXCTL_TSIP_UT_EN |
> +			       IXGBE_TSYNCRXCTL_TSIP_UP_MASK;
>  		config->rx_filter =3D HWTSTAMP_FILTER_ALL;
>  		aflags |=3D IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
>  		aflags &=3D ~IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER;
> @@ -1112,7 +1113,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct
> ixgbe_adapter *adapter,
>  	/* enable/disable RX */
>  	regval =3D IXGBE_READ_REG(hw, IXGBE_TSYNCRXCTL);
>  	regval &=3D ~(IXGBE_TSYNCRXCTL_ENABLED | IXGBE_TSYNCRXCTL_TYPE_MASK
> |
> -		    IXGBE_TSYNCRXCTL_TSIP_UT_EN);
> +		    IXGBE_TSYNCRXCTL_TSIP_UT_EN |
> +		    IXGBE_TSYNCRXCTL_TSIP_UP_MASK);
>  	regval |=3D tsync_rx_ctl;
>  	IXGBE_WRITE_REG(hw, IXGBE_TSYNCRXCTL, regval);
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index c2bd104e64bf..78067b49216d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -2283,6 +2283,7 @@ enum {
>  #define IXGBE_TSYNCRXCTL_TYPE_EVENT_V2	0x0A
>  #define IXGBE_TSYNCRXCTL_ENABLED	0x00000010 /* Rx Timestamping enabled
> */
>  #define IXGBE_TSYNCRXCTL_TSIP_UT_EN	0x00800000 /* Rx Timestamp in
> Packet */
> +#define IXGBE_TSYNCRXCTL_TSIP_UP_MASK	0xFF000000 /* Rx Timestamp UP
> Mask */
>=20
>  #define IXGBE_TSIM_TXTS			0x00000002
>=20
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
