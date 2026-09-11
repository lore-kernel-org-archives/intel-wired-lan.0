Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3365C88E45
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 15:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F30540766;
	Fri, 11 Sep 2026 15:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id exco2Hj-b6IO; Fri, 11 Sep 2026 15:23:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7DAEC4066C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789140206;
	b=WxR8zwpWPsRK36Md6xdlBYd/f42rfEgkaLS90M7cFr3P0kVAbeac5FnlStvxUDEZjWe5
	 f6DkYMCy1HhJ1T8eSL1TGYM03OBi6dfBbho5CoKXdaCGjdNVUPvxoVIkQgXl3g1ZwWn/K
	 EWVSo+U8JUfb72TBTNnB/RBu2kA3fT/8zfQJShUDs8udd+DVhFuwSuOXAxxcbMzBLqeen
	 jeUDXEktJaqPkBUmE/TcRBPsXmn3wdnEAMkvscmCD1QpWlZDzOTglWMlPqvb5E6stWBjV
	 m92mffMDw8SdvfzhtWm1OwgUP9tC63I8W82pQIaJ0X/S3Log0s7DqXus6ST4dz9InKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789140206;
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
	bh=tG/SWHwLfygpqnc8GQG4G9LUFtzId4wQYGwi6hJ4HE4=;
	b=pvCA3Bvs+TpSCflsHEfSKlD/yYOJbuJAkHi/fhLZfflpCehv5GmppWR/OqFQpt+teX5c
	 YifSkHFlx0IszPju0Iybb5zNzQ3q2EGFWQZmfgd498p83E4zrLC4q9MPuQdR0ypHbxpNA
	 GagvdeLeLh+OtwoWiogJWdcsXAV/LqguyGuvpd94/hX8oeuMZwJG4zinMgCj+5V1cFzbf
	 LJixHad1sBoJbqRjW0vziZZnmo2PxoqvcQD5/oOW5NxFNgyglXvTGrw8/rEfFu+SB17pb
	 MD5tGCayUH5f57vaBfZGBA28+PWV+WnGTwXbsXCBVlbWa41zGNVpwJT5ddHiD2SPSKA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789140206;
	bh=tG/SWHwLfygpqnc8GQG4G9LUFtzId4wQYGwi6hJ4HE4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+8xXpAXv03RJh8GtI4fVMiFyUXh0K6Yo3rfiPSpbm7q4bR4dOpXyLdE/nnI+8nTW
	 aZii8asf5RVvc/71fFk3pqAogAsEoccAFafaf47/OLDbvZFVjUgD3fW3a4yLSsRGZq
	 DiJtGzPrqXhXzwiQQI80kU6ffqpZmqBw5n7PAS65IJP0CtQf/SkqBRwjVwpCZI+eya
	 Vt3MNCl0b/fmGBhurvvsvbA4HdU0Yrfw/UE+gE99pWwhLw/gAZuCVeOudfaTSXgvfn
	 AUgs8H7NIujODzyjTqVXxER1NN+v6UWsJVTIQlHIS8MG6f1FRjCdRQvUNuol1svmdI
	 ivOWK7ZdN7wYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DAEC4066C;
	Fri, 11 Sep 2026 15:23:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64348786
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 15:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49C0280D92
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 15:23:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huqDEf8HfDJU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 15:23:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2573880D77
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789140204;
 b=fRvoXR4ywmbv+WxKSgvwWwvKnNB4mIiRNoT3AiLaaoXvrwmOcTYrEgF3QpEQs9ePHDX1
 7IhK6WNfVsn+4v01TCRgceEL6uhpSF5cz3CAVwL+htdihO/tFDCxiz7jChPyv5yLv6bZ6
 yPjmbg6UJj8stYRxGirSIozEJ/+JF6/6tvTxHZdpnnZWRsE84WHRwUxvaWyuZNkcH/NvX
 uWMA9CmWSzQWxxxB3vePnnipERGY17obkk3LTmn3SioORwdU1ki/LMncXMCh5Jzs4cMm6
 opFmPiCkjOm9nrLPipw3Yt9TgBAz98zMaE48gFOhw3JqDiy14SDMIiYkGYjo7OV3YxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789140204;
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
 bh=tG/SWHwLfygpqnc8GQG4G9LUFtzId4wQYGwi6hJ4HE4=;
 b=VWUorO9YmqszFFwXU2XxnZcc80Ndb9HQgSFJLteXTjdmERQTwq6rF4T+pfZopzrr2z3A
 3A+uhqMAf6ry7OIUwurZMCCAvives/b1gqaHrhcFhatAm4q2zJTf2Es+u92k38I3PbbRA
 JKnZguyEEMpwXiSOlurf42nj9dUVrZ2SL417Mz7tgG709ij32mW7Jc51XNYDX7yaS/Hb2
 L95mKMlqXLhU/LOXcnrUfiGtzZ+aAzav+w8pZAASnexQePwvHGCj5qW8+GKngx27KVss9
 +G6QpoBZIrth5Ao2m5OQFcejOXcP+9ceaf6S2FVQ+mzRmhNkOcsd1tAHxt6XbhZ2VpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fXFSHuh2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fXFSHuh2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2573880D77
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789140204; x=1820676204;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oeWlYRJbj5iSkL/f63OI7bD7XondGnEYaAUCBaGYb5A=;
 b=fXFSHuh2fRkbfeYmbHFXqcuX1mWR8fVKpL4Uzhu+DbuGjZyHYjPNMloD
 F8PUZ7KfpgxouOf9XX1fE6ymZp0Uo+FbNjQ2YfaG5vN928YEhAzEK+d+R
 VwHSw4Teud3gtQQeV684IyI6C9s+x/9Vbog8NmNK9RUZXyN+uicakF/ix
 qEle4/29eD5whr2HgBqRVQctBFvc458cjP+bnY4bsuFVQcCEi8OeogK20
 oQ8MXRyX8hfSDhWmYhA8nTV7WvcP9Gjhv6q7BIU+JCIazIh9zoB3LtMES
 Z5gntKjHwvKkm58gckWFelRpv3SCsGl1+bHTnyqIEFBlWG/Iz0zA/YQGb Q==;
X-CSE-ConnectionGUID: SgD1iiBRT7ivx80kqeNG4A==
X-CSE-MsgGUID: 2rRysWVnSj6Rx37dkgAqhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88546526"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="88546526"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 08:23:23 -0700
X-CSE-ConnectionGUID: GgkByG1xTkWg34cLp8i7tA==
X-CSE-MsgGUID: R9kSQDJBRiWssbaDXkJReg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="295434748"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 08:23:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:23:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.48)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTfSvXXQY1YEkPviWYAlEaN3wgFDM8zRtogOijQaEnRJlFNeUGvmgJ/1w8TipMOXk/5LwigMWBAwf6KtET95lcWvtDNQnPh7H5L9qqgif6vAtLthLzhlXBMTuFK5k7zJUajvR6HYANfewUiMowRCmQWkW/K4MzB0UiMRafzH5aVQwX+h9zKGwCnSap2RT3N+W5g7a1NMOOo+stAuOJon5852w1Y/DwKOMCEithCAPtE5DKyR/qydU8zmQUQREnYo7OMDu893fW/YyjNAJ0WsGb5SiOmpZEmvkw4aOIdtgD7aXLnf4p6NtvOXYIGx+ugKYOyKdmUSDJ6QielpmEUgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG/SWHwLfygpqnc8GQG4G9LUFtzId4wQYGwi6hJ4HE4=;
 b=BmzaaDBKc/Nnc+adJpD16nUbThg/Ez5AycNdwE33hWX0YpsW9Y286TwLYVMeOAqODJC7XpYcU+x3dErypWW8eRmAgkMcICNSnTYBiOZznk235PvkpYiz0TF0fk0mDLmE+VvSBQAG6IB7BxigQBdjqMeEIs9On8shJqI9VrxpOt3kDrvstce2WDjwP0UBdYEYckpPtBxaUIMBFG1qtd4E081zLMQ2t3paD81z1QcISl+OOEhMg95HIjbaKopzWdD1cXWQTrglwygP9OXHrE9gnBSY839xz6r9YExpayhJ2nzjD+BqUnZ81v3xS2JFNqtKm/Ri6J4gTPqz1nMI1VVU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA3PR11MB9014.namprd11.prod.outlook.com (2603:10b6:208:583::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:23:19 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:23:19 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, 
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 1/3] i40e: move ATR sample
 rate from ring to PF level
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 1/3] i40e: move ATR sample
 rate from ring to PF level
Thread-Index: AQHdGqxvOATeGbVkbEiDgO79g7oEpLbJajdQ
Date: Fri, 11 Sep 2026 15:23:19 +0000
Message-ID: <IA1PR11MB6241AC8EFC4ABF18A3208D4F8BBE2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260723140510.184819-1-mheib@redhat.com>
 <20260723140510.184819-2-mheib@redhat.com>
In-Reply-To: <20260723140510.184819-2-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA3PR11MB9014:EE_
x-ms-office365-filtering-correlation-id: a8bde752-f49b-40e8-b99b-08df10189c09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|7416014|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: bvm2g9Z+okH2VsWb1jNtV48JWx3jNJGzylVCdtiSo+2tUSrp9dMpSOs8WwRj90gOnVoY1K6IYZRYKvCRluyi+XUuNThErkbuhyzu1PIjZkoJx9tkSw7URvDxDmM3Oq7E5FzL55GHTVIXGf1QvEEZW0RTe9CeaciGwVo/9ammzYG819rOka/G5GvtqoHVfckV4+oLltvK5fQ4byGzwOv+qKQpDxsD4QjRdQhZRcPLVoOVAUrClYvxPSSEWAfHmGaU7mpRQ0HGe/hHpn8+hy0Pruj4X94LNID5Za4H0CPhHhybNGWXsIWR0oRcqrKETnq1n4EcIll9msExzn2lxuSumq2uWeiHyPDWdZMfDzqtUHzbHymlCtiHDJOTBo+vJh2RMyGPSF7pgfHzvYIfZhCogtpHUpUFM6waBFWlbD2P6pLT55Eeh0xj0/zNuIMhPCesT6ZbfsMQLkcUs+ElryzJOUSIJxbUQg+Q8HwE1arPDkeID5ahmv36Kx/r5OdPwZzl1ist+35NsxqKWF7k2qdllyIdyxeeuEQVHK46FyTE+rQa1KrwUgLbK1qsQuQvfXf/Gkq/PXqeE8dTVKNoR6fk5rUMzy+WIG4i15nHkrZch8JRS0XfoanKfKZ+BHOyS5zflsAWxlzqhceLzY8BFhvVV7Cr4ug4pkq5vgqMbOBEpDzdEl6v0LcxKQkk6LRdDIU/5dAWn1dF8fxbAauHxWxpUnMH7P5fthkSOO/s6oblWjU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FUI8EXYT17i/kocRK75Eb2yTRd/ufsZjtRgGRRaFjkgbtaqFkNSPYYUD/Sd3?=
 =?us-ascii?Q?GDGIdaJ56IQMs2VtxrIBhi6wRHPonZMiGKLzRaz0FBNGIeoPQvv+u52176wV?=
 =?us-ascii?Q?pCo4+AoZrameQedpaEoq9jDMZiLqp0bFB7kWgVLhZYYqg4yVNZufSA/CY1TJ?=
 =?us-ascii?Q?AvwWLDw7uJKFdoF6PvJu9PO/BYFnmHK243IKOYZgCaK1ARcVZyTbTaMMRTGU?=
 =?us-ascii?Q?5PwgDF7J0oFAmOHW/VYQj3E1aO/PV0tztpI4EdVKe0nWwY+HLhMf3bdkvSgq?=
 =?us-ascii?Q?Dak1jvkcdw7GoEIsF8tD7k7xwmqAMOmqQU0u0rXhTrOMyzssoi/RHuQ7c7wo?=
 =?us-ascii?Q?+amLhMQI2UPTlThGxZbLDKggwC0q7y447lJyAjAVxMAWvF/GmeP0l12L9r0e?=
 =?us-ascii?Q?jkYeDMz5AcaO22RaNbJmJeXnEMA3SsZwSpn7P0x9m+dCkRBj+BhyXMRjR/2y?=
 =?us-ascii?Q?s6L7KYA2PjN4ER2gYHqplk2zRQjEJU/9yqtReHhy8TYfx4fNd6a0nZ3y+sXq?=
 =?us-ascii?Q?zW2DwIXtYPvA4cUxcvTgfgjc3nBIQxn6MAgYBGp8dNOKVzAdvuhgn0T35lIE?=
 =?us-ascii?Q?+22895xZsDsHFM00v5TKC6ZMQJFWUb5TfRBCjD2C/BaJieYDfeL23Ou1Briq?=
 =?us-ascii?Q?qTtmjrhN9bkfTST/bcnXi1iPpKdHM4X0hXQv4krVoPy+N5RK7pe/C54f9Zgs?=
 =?us-ascii?Q?CGQrfQMnGrB3Rd9t2gGx3L/cX89R1LDscczp4vzdITsc1Rjd/x/ndWOkyb92?=
 =?us-ascii?Q?v1fDnrAQweOT6R8BYGDMNmxW75Hvm0daRhLAO71rk8bupDluBijAwuJJFJp5?=
 =?us-ascii?Q?Bial6m8yJNy+dLDmnYx7E9SqH+PYFt6Sk7ZGSpLvZomfVSpMisb03UOFYgZG?=
 =?us-ascii?Q?rihyRhYW16V4gtPdgYJZwrKyNT50B28FANlj5e97vTVFHE/TXB4Nbzbxh3MA?=
 =?us-ascii?Q?HwUVoiu2mx2lPQWNGd8/gKliBkHBoYYPJEOQzq7ipXfUUGjfcDf8lJguiLKt?=
 =?us-ascii?Q?Vc3zoyiEvL9cT6EWRyJ8K91cgOgsTqBeRTmB4hhowf9JovE+daZluHqLitUM?=
 =?us-ascii?Q?L6Uxf/CFGUFesUcl4jSueBGB4GHtYgFvAtZ3JYXx6lGgisUhE6PHmmlG7zq6?=
 =?us-ascii?Q?trAzcZ3ahPZ8NBUMvcHW8xHXO9agaJVc1MNWBeyZpEhgwlHKjqTycCTR+DCf?=
 =?us-ascii?Q?GXPOzQ2s5RrWtmvohCBn2OPDivjlfCEm3BV69jSJOQdnz/B5lUkPcwvtxvQv?=
 =?us-ascii?Q?d8sMjYHmYBZDXFqvmpKGVS2H1cYmEoREbRm6WgISyJvyprENWd9SaKvYe3QS?=
 =?us-ascii?Q?peKOtpWXPNNzgO0EeYgfoB61vBwU7OtR0mGwpXUfNAY3eDmCnik7zLCY6rlb?=
 =?us-ascii?Q?zEZngMKVs407bEM8kRVVnyOkVpo4dfYZ3cSAGtmHnxpjIVFUokN1gJTjrffv?=
 =?us-ascii?Q?OEWW8IHs8uhSXn8HyBVuK8pnGJTYSjjhaTZBi4jTmqMxIdssWdQJkeaYx18q?=
 =?us-ascii?Q?/s6vgAi4gOHJOs1cq6OEkZebc+GQiKiiCC+ggwDFh4Z7XF4lLA0VZeOp33aB?=
 =?us-ascii?Q?9Gxedko0pV+0g/BeIgQee16VKb6TbYWFipZa2R5WW4J3NqAWsW/FdyOS2iG1?=
 =?us-ascii?Q?G61qUwXBmAmYzIJgcF7OPPWRxV7irDKM8m4VYh5ZA6J5ID1TVz1u3id6pVWs?=
 =?us-ascii?Q?xvk3Jela1C1El3o2pq76E9F2tUJY8dvOTXvtrwR0HWyyRajF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fzDSXk14st/TxYmmzn9jExYi8cZpBswUSFGPPyo+xRJs9hHSJU5jQn0lq0Fi3YOc8/JCCKyVwx/nKsRU0STi/R8XUfAzNTQBsVByVcjDIjBj2Lzd+YXu/zeyxli+RaKbVpNZ2msLxOgpsI8M+aXhS5tAIC6Mf+MiJIDixsZjDaH3YrtdHV6ZWJBX68n4o5n6fz6lbdJ5InQzViM5DbyQDqnOEWvsSTQJka7vB/o2Lc3hsU7L8O7UVef74QYLwGP8HIExQM6Nfl/AlKQjmSYouWLvVH3pgsNH2gSobFdEtPBVCCvCKgeykxMeaF1Ob17Rkt/DH6G9vlEkT6+Jzouw/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bde752-f49b-40e8-b99b-08df10189c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 15:23:19.3012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBzuh0s0hY9/WuFhuyHUFoDhmgoaJv79L+lmrTmffC5L++VbKnYHGpphyDS/JoWTYePPUxfjlJ7KYjV2RfNbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9014
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of m=
heib@redhat.com
> Sent: 23 July 2026 19:34
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jiri@resnulli.us; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org; pabeni@redhat.com; corbet@lwn.net; Nguyen, =
Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>; andrew+netdev@lunn.ch; horms@kernel.org; Mohammad Heib <mh=
eib@redhat.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 1/3] i40e: move ATR sample =
rate from ring to PF level
>
> From: Mohammad Heib <mheib@redhat.com>
>
> The ATR sample rate is currently stored per-ring and initialized when eac=
h TX ring is configured. Since the sample rate is a global policy that appl=
ies uniformly across all rings, it makes more sense to store it at the PF l=
evel.
>
> Move atr_sample_rate from struct i40e_ring to struct i40e_pf and initiali=
ze it once during i40e_sw_init(). Update i40e_atr() to reference the PF-lev=
el field. Change atr_count from u8 to u32 to match the sample rate type.
>
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
> drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
> drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++------  drivers/net/et=
hernet/intel/i40e/i40e_txrx.c | 6 ++++--  drivers/net/ethernet/intel/i40e/i=
40e_txrx.h | 3 +--
> 4 files changed, 9 insertions(+), 10 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

