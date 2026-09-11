Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D6AC88E50
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 22:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2382D60616;
	Fri, 11 Sep 2026 22:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vDDI606Rz9B; Fri, 11 Sep 2026 22:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1AF560615
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789164752;
	b=eEHAlcQQId5unxtMHbbKyYsbHUwKHj9Qw35qxuc0hnoXoQxorAD1EXOWVDlE2goOQHhq
	 kzcFyu+bVWPF28xnIS6aRxeRJ6nBzo/H+3+2f9Jc+VDGv+744qVtQJ2l58zVjCbRy+OCN
	 PGq5Hw5tG7iSo66xdeUr0vPMZ+lOTwS3CN8t1b+FI0q1kVAAJtSE0ofVcSVIMO32P78Rn
	 NpKxsUGwOYsuwALZK+i1vfNKBdO2/o2RavTVDXO/P5TIeOCOz4F5R7hetX2zU5BlJIk6N
	 ZcfqtTGHJkr+ecZRVA5Gk/82LQDgh3LsaEsmCJVvVaP9OtF6bq6LslCROOXpskuLTWg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789164752;
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
	bh=Syk4HkXygVAQ7kXf175TtSMZVigmllN4Mn85GWerQsw=;
	b=bkttPRrpstyerXfTwh/EIyQGv1gR/6W4c6HOpHrN8SraoO4pTunDbCuzJJQ36QQKvEi3
	 ftlhmRRXgN+alQaXCrLDEyw9GwKRC8xmCKMa+7hE7ZUEJRoJYBNOxcY7B7rKbURcbb0AI
	 34UrTZ7LYYv2FPlEcL9x8UMCsMssDUE6oV/cEzss93zeGkVSh7x/+YhkxdwdDzqF+mZXo
	 DAA13XILYFz3aTcbQmxMLyPr6SDLQZYGSUHx/CGNHro0aruWwinXZhoh8KxVlYQL9mvv4
	 BL7tly2zsqouVSKbHVEpqvvnd2LdMhCIPJR42cStFbwJafzDccqpF4hyOCTazBA5HaQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789164751;
	bh=Syk4HkXygVAQ7kXf175TtSMZVigmllN4Mn85GWerQsw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z15zyZEsNeYZKFJahcp/LrtaZ5I45BEvhr0Ru82oEVQ3Jk3tLinKt9QciPZOKCyXh
	 tdpymT9d1SFV21ap18/w/CfkhMtHDYgiOnkObZ/7zxvN/zCUQNYJ8xRB916KpBe7gd
	 +JO30VW+FCkQ1qORaYD/IEcCNYDWZYpiCkYStfNvKzQJdtxYEQQzrUr2WcpDsrcrac
	 7zLmUIDKPA43DrvRraqNgOxQNarjvKJd+7Q+xQWlk/89V5nSWkZCiz9ib09JDt5+B8
	 3gVcXRhmzrf4HxePOI4xhQ7fwYle6yahYjHDxphZRfLNwogrZL3P3WEo4wt07HP2Dl
	 dKExZk/N5SYEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1AF560615;
	Fri, 11 Sep 2026 22:12:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FB9949D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 360C64008E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 89jwTEge2B5o for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 22:12:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 28ABB40061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789164746;
 b=K6kotTkd0g9wu7y7lv9hHTZIJ8fxiQ4hdq7n/jLt2pkYsfj+roMXUH+8dOoryvmLnu3U
 A78VC2VQ36a1LgsJG3HA6q9jkKEnrXm8GF4AX1SDbKAoFeCjjtFwH4qlfGtVZL+vN+9Pb
 i9qIKJsr/yVC5HQWatiD2aqkj4ig5ch2R9kbBV/eUedXE6Coc8AxOm07TUHACGZ7Uy+N+
 yCUPJFOpdaFMloi5XGAb+MZSx9huvxItYEJikcivOV48m/WPSqaK5cyi52lbxTH6qbZMd
 vQGlkLgIHQ4kt5xCvYoTbnMLZI09DuVN34PgyA+TE78cutamCKuWWYFbiHpTBPrYr+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789164746;
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
 bh=Syk4HkXygVAQ7kXf175TtSMZVigmllN4Mn85GWerQsw=;
 b=XFOWVBiwC1jqMnhlezlpURn94BO5/Gtu1epduRDeSMicsOXMgKLUD0O9P7HQ5PorJz9C
 +NcGhlV87zvvnV0RlpzrwkVNwQnIPjjrPQazA+KpaZ9tugbNJzKRqqPQ0nw2NXk+CdNrq
 lrd/9lag34IXOT6h+6dhct93CH5dq3gSnKvhlR2A6P0BRT3oi6yxK017kbHyGOG+XfZTI
 47HsszAbPLE5Iu43tUvVkCASHIsx4taFDWZjv4lYqVbZ6UiG1jTgI/tKwTDvlUOP5m05T
 Qk5E4fhhfPRqrzZ2oQw3E3JobFdGgPEC3v829mtPewtqPKUiV5JmwVxAwxOMNbd7KPQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gk7HcWoQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: Temperror (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gk7HcWoQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28ABB40061
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789164746; x=1820700746;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F2RwRAx+drjoS58RSIrwJi1m0OwHDakRgrvuBENBPeo=;
 b=gk7HcWoQ0OAxu+EAJdVEGfN8tnCLgaWbMU5aOh7GKKv/JL/JtgJJ6RiW
 0oYZo7Q0ex2l1RkulKhT9KXgq8A0dW/VjHdHsn3aQFsY6lIuJTXImLpoH
 QsfeP9XT823vCDhSFxh7P/DTFEJ0oBupU3WUu+G2SmnW5hGTmC+xi1IpP
 mWreLP7R0+6dcjKNtfXu6eMRf+JjR/zzl21Zli0j5ai9V3M7bD83fE+Js
 cmKIlfECxTBfCO4aUDC6hrY0V7etGPmnYGBsKyHePBsrnhm+qyyesI36H
 UzkX+cNKkGxYUYUF9aINJtDUUX60sKk71AoDUAsjDnAqTDwPATaQIj65F g==;
X-CSE-ConnectionGUID: N7clgMobRqmuDZpYYNdwUA==
X-CSE-MsgGUID: RyQcU5SRQTuODe8D37vjGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="100294052"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="100294052"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 15:11:17 -0700
X-CSE-ConnectionGUID: T8Yhev2eRlCKYSoae6TC5w==
X-CSE-MsgGUID: J5nigoJyTTSODHr8CMRauQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="268354909"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 15:11:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:15 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je9En/SjDrBWuZrbLPN0cG8Qbyrl5VF46fF0LOG8h31B7KelYcakogmvOq4N6xZ0+yJwqKcsx5UyJgAMh5oAiDt+lE4zTGM8pKwkG58WgjzhMNVi4+Pa+adUtO4NVyt9PowTgp4opM1bsEdNkgFmjSgZMoxgQ/7X8xluqyVHnF6sxYBRVI4EuqwHFSF6PnJxollavOW9InvauuvQr9P2CLPqy1wcRu+KQM3UoYErCS8oUUvTDKbJfeQ7M2KxAT2eL+8dEeXcT6D5RKuyivo/zoWIwzRTsYLBTmTySWyu+E4X1Zy4LJX/IqZKEZrouqiHuq2RVLAbe3sFQhN70TDSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Syk4HkXygVAQ7kXf175TtSMZVigmllN4Mn85GWerQsw=;
 b=pIUqCoF6GeHAVkYsCZrXnai+iZp2rZ+vQQloYs1QsCZ/FjIxkgLmhgKQ45UfGQQSj91TpmTVFpKV+1OiGPAJ66YpDROW2iViMK6dUA9OfYdTiqGaQs+QSyoGIj1wY2xDOr0FFsirrSEt9vd25C0ZNeoc8fTxVPtky7X+ij0WcBSBemu+hQYtLr2ntkexM8ZX1DeRHUou28brCJVyBetjh9T8aVmhE8Z81um2rPZPNb7/bXFOWogE92bsMyNnjQA/gwI9KGjPaqCjO1NcZ1brHa8uWRf2sOfJnJ7Og2c9KaxW7xHHNYrFzU2ThWRc2piD1qI2a3wUN2dDiStCvUVY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:11:13 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:11:13 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 5/6] ice: dpll: Rework U.FL muxed pin (SMA)
 control
Thread-Topic: [PATCH iwl-next v5 5/6] ice: dpll: Rework U.FL muxed pin (SMA)
 control
Thread-Index: AQHdOVgjAmykPREnFEevxS3TkLzOKrbJ/++w
Date: Fri, 11 Sep 2026 22:11:13 +0000
Message-ID: <PH0PR11MB752266BD8A126D10D834CB03A0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-6-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-6-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 18e9439b-e002-417a-d800-08df105197f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: +akVDbOKPA7bnZ++25Vccm/+NN4EsbXBuRXWRTrYbpjuGuER9j0dqekQ77pxIGqKWOPx6qmRuIFuDJ6Uz8GJvmoSML96f4ajtu0HEa4q4wZmp2vZfcneaHvEsPrK041rHGcV44/zoLe2V8VOMs9BBJn6U9OONiIJ5O/mmaRD1CQmpUIVHAaZP+26WYK2+sOWtV1AdyO006LKGH5buNOJ1M8Uomfdqc5owYq+E37/SIFBzPU8gnQbV0OYdIsPo+yj+A9WmxFVufQqGj4G7kMZkpmd6enjzZn3e+VQ1lkm4H6tMZzS0KwM+Ob81Q80N43oBn2jakIKkaP6diay4ynrhd7jDQ6oLq6chwsnvHDMhM+EGZOyjK20z4rCgXfyw0wKxeZ6IuYZiGtlqRJj7BOdzZ8usYbnt74eJapA3ZsARLAJui5JcB/wgsKlQmfRKMVd/GpcMQQ0LkTrZOkMug2F3Ev0NUo/UfraCyqVCLyxvzgyhDRTqTLkBxOVWqBYnGlRzZn82z1+vRM1a86120n1/0Q30dWe3bHTlef579I6Rloxbnm1COuNd81PXZku4wISAzdQtZ2BmGrhM6fuIGmwUNtr3tqwIOxZCv45372YRRBGAKkrbDBesWVmbhFlhKcPI3/sQm8XQPjD5ChzTBPS/jc1TN0xwUMOM1wfJAifmf9oi1Y9TMx/guosGgq2K3+upCSnFhwb5FS/q7v+lHyYloQ78aMiqEpXx/wZSs0Fpe4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sr0f4w0c94KY3A8K9EuCCSHbxdk3UXDr/VzubLdbcefW6gQmvRY69GE7oNAc?=
 =?us-ascii?Q?kZscnBwVf/dcmOzruekYbK45RTqxRTRAGoBM93c7BrhxeBOZn7Bkku+fvgcY?=
 =?us-ascii?Q?JAz9KPEdzAVIhh7/87O8KDLe89NGLwDV0Y/B3rNP2YE+hUh3HX8QC8ZMcxID?=
 =?us-ascii?Q?2FaDX8Jg5MXLsVB9hfQB0YrU+40yPRI21dVEnaw+vx6t/eI4leYpkniybgnT?=
 =?us-ascii?Q?vs42G60oFGZ2vE6hUGxFkAeO1MOBiB5qE1iKSupvHUq25Kvz3AHl31Befhyb?=
 =?us-ascii?Q?pWK+Ka+EgHLuvQiG2X+DH8tlEOxFhNslVutGa+fZHzXSurMLaUhzgttzayfg?=
 =?us-ascii?Q?63VpNIW63dHa52RHqwr3Ek3D35cyAqgzp9xD3pkc9Jmsn1mJFv/BQIZSb2GF?=
 =?us-ascii?Q?PW70ZREZGkhT4zHoLPQvH1oMrZjfvxIIkds+OEhKY4SqOalcS9Po+Zfq3RRR?=
 =?us-ascii?Q?LLrcuScFPtiJGuERV6prdE1Pvwr9QHqqDWNUU+qtSQ78tmjxvLzz5vl84SIh?=
 =?us-ascii?Q?smJZT+fdRfgaDj/Trmjl8srHAkl+HXU+yVFMQCsIVNt2Y0ekNMC74fKJXVre?=
 =?us-ascii?Q?bRqTKHXOmR33v139sY8+bfK4ygL/AlVVv2FFocs+c7P9ZEdGU0zN7ieMLRCx?=
 =?us-ascii?Q?s39/OAQOJ/9qQRuuToy1Q2Objlpy51e+2MgujzdPoRc+rrSXROHPip15N2GW?=
 =?us-ascii?Q?5rtF012LRtE50oSsYSLMck/64t8aEa2Hi1aSEc3BEi8VRk/3e3E1eJVgr6zt?=
 =?us-ascii?Q?ROoQSPO9NQ0wUYDZTew0uEHvQSaXURSSGgncUR9OqLXyjQCT31JYzFjhLJ/X?=
 =?us-ascii?Q?xJuAn9+niwoxLk3Hc3Pt6OxLv2Aakgru9h4QC/N1R/0k+04sSEnMLtHwz8qn?=
 =?us-ascii?Q?9pxC8UFv1MQLirswwciO8v7QjsGvYfiIwzP9IFpEGLVqvhGhQ/tkd7yz0ywE?=
 =?us-ascii?Q?Vus3PhFlGfPE15j1XlrwM3cgy2Z9Cz6Oxx2Qe+euVNtHxZ8FGaMzwbudnxer?=
 =?us-ascii?Q?eAY1nQJsC0PcGVFo/XY6OiYK5RhwIBrBs75kk0iTW6cWRtbtjMTksG7N8+VT?=
 =?us-ascii?Q?Q1OXsH1oNwCOb8M9+HQpiIfC6G3Uw4SDNjOik9gBpLSTcQ5koaYW2r/yWXrz?=
 =?us-ascii?Q?g2SQB5YVxk9a5B/9MNqGLEUa7w4p/58ZnKdF0dUUYbHKP4T86kSJXU/GmSof?=
 =?us-ascii?Q?6bDmFRApSwXeMT+411kg0ceRoiqa7TW8h5RqXzQIi6hoKAxXneW2TMeUXTwW?=
 =?us-ascii?Q?40XTX9UIwBelC+3Z0E82KiAcQ7houNsXagTROB0cS/Mtze8c4JTKvNfevF7+?=
 =?us-ascii?Q?+89pkANJODCqTCn5sTLU8NXkDaRf6bvUyDbztltmNci3N37y6b/CWSoFf8AP?=
 =?us-ascii?Q?r/AxO71Ajs64h78VYXxDTLSTBK81U3pem2cgeZUnUEzw1+4RVHQR+NV6KIb8?=
 =?us-ascii?Q?obvjr2ejYZQg6rPOCTyKLTcgLA7vrZkOz64qBpEtWLgh7SIYTbIsfTpStNNU?=
 =?us-ascii?Q?wKwpSt4BK9D/9zexwQESxKBlMISxwbFp4naJWqDBhyQQ6fC848TcdFmaS7bV?=
 =?us-ascii?Q?UvevT3zi4jGrNSnWDsjOgM+VN5YBc5Uytj24CX+s8XmbqxvfIdnr5iaGhQqT?=
 =?us-ascii?Q?mGJmwal1PLuV1g5vC91rLhY9lwsaoXLeEzlaagxAq8jlg5DyHM3n2OecCMfc?=
 =?us-ascii?Q?iY3uLEmIxaEache0jkB6LdvXgs1waFrpbjGMcLH8NwCF488qdwccflPU/XuM?=
 =?us-ascii?Q?jXHAf/JsbQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tsPA0tkuC+YKOXNQ2Qi02Gt5TKUgtFxn41LXX1SuFRi0coqsPWS9jPdliZgDs4C3msnFu3YLHU/LApEv/dScJYc2zf85FykLGJExOFX0X4lFzmjdbJ27wRjA1Lr1IqRORxj3GanmO50oGanChbgJ4KZWxiO9vRNadV0RE1tHZl/v9vtDYwuak1jodWb3j9HhUkPaIBUoTZCVNfdn47TMBf3UMYeRHcPMGc8lRmogI8s4rBxD/Bbg/V08TQdNVhk/Bq7Z/aiH4FpkPI+XDr7RdvkQz3ofPALV6a5yw/FT/4FjDSTG94MUf9wbjWP7ooCL48M45yoIEkNibY80AXegvg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e9439b-e002-417a-d800-08df105197f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:11:13.7176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIBblvlzWTGup7lagGUzQ1uK9wjNywfqa9OPUVVRzAf8gBGV1Ihuwq99PWPInMhicp0FNndgpN2ZReifz+gmbQO6qCUCoXbqT9STW0Crf5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
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
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Monday, August 31, 2026 7:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-next v5 5/6] ice: dpll: Rework U.FL muxed pin (SMA) c=
ontrol
>
> Rework multiplexed pin control to match the state change listed in
> the design requirements.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 191 +++++++++++++++++++++-
>  1 file changed, 183 insertions(+), 8 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
