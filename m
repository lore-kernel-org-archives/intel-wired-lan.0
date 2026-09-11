Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B90C88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 22:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E517960617;
	Fri, 11 Sep 2026 22:12:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7PBobgg4Lmw8; Fri, 11 Sep 2026 22:12:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4162760635
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789164772;
	b=C3fsRvNMXQXkB/6KH5cJs6HZvnCvJtkKHFGLZnTrNGH2NHtp1p7gu54F2ouvUzRHysvA
	 7j+DwpHXCZVgzkky/phzEUg+XuN2+QHk9qoA9zkxQIKNH9WvQrigBD+JLDaLO9MVEhKEa
	 pbGBqyzSftBdB9Hea7pH7ZE09YrGgF2WDkJH5ldqKq7Wty54uCmpGFaB752rMRiCLztRM
	 0+3LRgaqRy5ePNcNKZ9LYqB0G1DgvsfiQo8ehWdtxolKfIbB5fhNpe+QyRJ8o8MUgdvKL
	 F8owD6AdrPC9ZgFG0Eqd/2YuMXGZP8qBOr9XYxgydSwzm5Sq7kcs07Y9fpyBAFfx13g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789164772;
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
	bh=XHB8mMUqqhhYrrgNFaKj74C/Em9iAscDvXpk7CO5crc=;
	b=ex64PzFPXDQLvjCtpI2dpFIQT0jaEqZI5o/B8GRKwxHYecuBuDI7gJQRszsC2M18Lf+W
	 YtXT3+htiEWCmBGmum0sfoyi+GotRHUiuvIZYU2mPBPsx3+cMimi88l3fQ3vMiFLSMqzY
	 sQVk+aaTIrmY5GhdrDGhz9TGZhtNrKzbT5PM6DaS3gQlaCEgutliWLweuy/BBMit9f+Oc
	 xr2OzSeKugpKJOaILU+rJhyTPLPQwyknjzxO0M5yUca9Y2v6EVnWp610FrDJdUeNGlAS4
	 NTltdtz+JBUGq2Ov56YeW87IYVJRg/dfTA9LtQc7zvYO3l7QhUOzBxSbqjAxpCB2u+w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789164772;
	bh=XHB8mMUqqhhYrrgNFaKj74C/Em9iAscDvXpk7CO5crc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9Vnt/bHa4z1YiAMbjQ0GAU4L/0xRFwiQwoHr4WGzRVKf4janmfLjmLlhV2lh6/0ip
	 Dvej1WsGQH2oTBWMBJd4w36A5odwMrNHDESWZsyfw4SuRxibqtbdTo0YYlZs1U0Jqy
	 RK7UHwp0Hd+R4AAl3p9Gf0gV9sVbhixyjVh82UmR8vFKEs/0MlNEm8tFG54qYxzajP
	 /gF7NmqOAh6BnApuBKw8I/lXClqYJI+jCFeUFKeHakGjqhxym6c1yVaeiM26XRoseh
	 co1/58WNclBox0kJ/HIXbGFz7XVmsxQHWzR8V0RZi8+/ot/0NH6hn6Mf9Ms+gXbNEo
	 IjUIThTP/4ipg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4162760635;
	Fri, 11 Sep 2026 22:12:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C55C49D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32161407C8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bj-VDp7rgmEf for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 22:12:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98005407A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789164768;
 b=XkL/wh4h5cGogIaejIxJ5GP1ETs+YWzO0cZAUuwk0eZlSmaUugp16FTTrPlKJXIb90r3
 TBlJ9dzmjAHT4aAh7/IrJXJ4TYK0Kqtbwaa+Cz9YsP+iN/R6y+6aHCTYQGLBekfp714BC
 bSkA2F6xBw9FuqzWlg3PJRnEQD8KfcnZtElR1EcBjcvek5gfEEPv751B9ZxvFxA1S0img
 wsZwyZAUcG8ZWZrXwxjBkeXBIJ+koa4fU0QeqVj6CAX8aYGtOiSAlbCocZJrb4BUX5v8M
 oj5pf8xBPYWvukjcuJE3C2YIveD6Voz5Z38ZxYY8JBkDe9ZDTTRY0T8NToi6E8tAyrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789164768;
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
 bh=XHB8mMUqqhhYrrgNFaKj74C/Em9iAscDvXpk7CO5crc=;
 b=EzVjYGsnJZEBzkpbpAHjd3JW+LFm4L+gsKPuqkRL7ppnEeRPdpe8ZLsbk/oh6gWlm1kC
 7kCT9RYVVXjZtdyl3emT851KLEmtprUqgbA+6ZoSj5hpR7hbiWWervBkaemI3A0160ZXH
 GeQ/I3t19zHgIO66Ee++bsUCz/11xk4UFHMtbdxvlTK+ym5dg3DluTASoOnYYDnrXdWxd
 NR/MlrDKCtAsNw/iKkF0wm0TCg0FQgYL7U0t2pYdAZ2jl2mVRBSpN3TkSlM2uuyx82nv+
 OwOzjP3fgIxpTa694qj4dpeN3M9L/sdI2WD9F7Q5RcxWw0iaajtAzQNrwfDoZk87YBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AqDRBK92; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AqDRBK92
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98005407A1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789164768; x=1820700768;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kJburd9JBE80jMNQ4C1vm1Qx4ijYPoFKi4aQ85Ub214=;
 b=AqDRBK9236aGCmiS9xHlSxd6aRQMu2vHunvIS8hXX8VMkQRKxVQvlO4w
 dg7TFtsOT7iAP2C4Hq8zTMcg42P45+98V9K0/YqXtl95a6tC3x4gsU4M/
 0feU4AzQ0otvAlkdZXEjUVgNH7bAj6LyZJySk+/5H2V1d0wK9k91QXqkC
 TqzcBm95VzVedP9/5X+/GyA4Ne6MX2e6sSJG/JaRLsNS/Xi1MOoUoWJgB
 Vi9tXYmq3o/vGckdeafglNep2tB8qd4Eu1uWeY8Rt6g+8hS0WuEvD1mGn
 1fQ/J/DO40+OWSbMBeeRZPY5NWWiJUUTXFTjLmd69iYZiylXz4n7LyIxC A==;
X-CSE-ConnectionGUID: rn+fJW6+QyigdqKWMr7+6A==
X-CSE-MsgGUID: qDKSeiAUSnKiTvMLyEudvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89472471"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89472471"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 15:11:30 -0700
X-CSE-ConnectionGUID: pTZefYxWQcGyZN8zR0W8RQ==
X-CSE-MsgGUID: OvrEKpIpSXi2qSmHDzEtMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="272010280"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 15:11:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:29 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxeEnzbNnLeLeseWwQ0PRHshy1YoiNnzScy5RAX8b0n3G/ScnynLy0tL23FTCVb2gS2JvuzQb82xThESKe6QVEGtdeCo/noli3uuYCoC0km3ncb7wLZXqISqIcPrGYnuNYE+MwkaAzpYvKGfw5kCubQzDiLAyNAijvQkU3SHaaOeYtC6MElVi4QEKtSFOCWNRGg9NMbFG0rTDf/CZ2rK1IaJbSPJ5r6cWHLpcBGX/UA0Gs8DhIOafq+pOKDNhpW4IMgS0rmjXoDotWtroEvIAahvH0r5WidNMA+WKz9SqAEvVENFlwusul12QBJ/2vJ4+iVgvtMfKTdaCdnGgV7Eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHB8mMUqqhhYrrgNFaKj74C/Em9iAscDvXpk7CO5crc=;
 b=IUCdiKVZC6/2M2py4oCbmnR9G5DJHGTcxWkpJb6y6k3TdLFBF1Ip3HkhfRSfW/QQ+891B0AjToySUOpF0b76s1jCaIJAr22cBFYI32ghTkOMB3TIbZLWRi85BHTkmjw38vE7KXbXlWwY+lSDXwiA+s1q0x8I+qbfdO41qqmucSlIYSjhXGyznxQjjgvrQ/s+5fvUop6f4H1PmQwU88nDhAwVhhOOATtEoiNvybjz3T7PuwNAzn7Hbfj2eS0zQOHzLnJpDuO4Sh6Qwz3DD38TpL+/qGyAcqkxmBmH56zXQDII/EYvcDKhXEMHl+Wee7WnD1cwDIJlEpgK9r7vbS4pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:11:19 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:11:19 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 6/6] ice: dpll: Rework the SMA control logic
 to match the requirements
Thread-Topic: [PATCH iwl-next v5 6/6] ice: dpll: Rework the SMA control logic
 to match the requirements
Thread-Index: AQHdOVgXoO7LPnl4rky6Fu395UGwWLbJ//2w
Date: Fri, 11 Sep 2026 22:11:19 +0000
Message-ID: <PH0PR11MB7522246F9FB265614789985FA0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-7-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-7-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 71794d67-ee65-49fc-6378-08df10519b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: IUKr1ABii4+PwgwxRffjMJiZ0Osfe4ez7njdTYbeXYlPdIAb3NyUHZowEi1mP/dKsU2JvzUR/ewnsbJagk3W9aLX1GMYsUgPpJoBArXy6pj0WvfuPqPnlOOdWW5kCflj50uob2cVzmXDuvcn3zu/nRYfPDEbH6dTTW81wVMSZClhYlRY8fYak3/unoLNgXmptkQbHEYJZlVx9/A+qtyfumClbikGgODoZ1nH6GRepw0uWmeFSQ8JGfBzAMYdZt+0hKQOpIXnGNHvZqruUZSTPbh2kgmitjUT1XVh6u0bWAg3A7eBGlCTkqPycB5cChlTS/jPtzqLRIuZN/nMA2SKz4FMyFu9l6AE5b8rc3iu1Dw8w2b8HXCmiBzp00mvnrrrk16FHUWD9P9IqaXpl7AS4jaEaNdDjluaQW1rSmpB37WNZqnpjwfYhywcZmHmNT7o4efkdhuCaElbKN37CPHor/bA0jz/J1hu92hXxcWgmDnnjrxmR5DyzuoSURpBhTa+O30KiCjsXufeCOjwqOFZxBiAVoP3v4L88JPiYdhPVmBzFKnYJJjnv4f6AzaPFB195exG2v3nd1HfcKdgATAEykuEaUfJn4DvnxFhgyZtseqlnM3lVAOIamVhTlYfugS7Tgn8MJSitn6Rez4m+/ZehrgqlcHhp9lkvEVAg6XAYeixDcRVzN27RechAa6Wj3TE7nZTnFXM42ZN2Nf+jYm4pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?shELb9lIPFY7R40Sdu6dl6FuSRZ0LNuAzqWKzNqHa63ou/UBZSmilnfMBURq?=
 =?us-ascii?Q?jOIhHiddvpuJuK/jWE+XB2IR5YMfpSvdRfZmanlrDaxNnt/0u8VPOAMh+bYC?=
 =?us-ascii?Q?5VSkGEeyIF281s+IxXIu7Si8hcEJbQv+DW5hprdPCSBIOwARzrUo7DpXc5jP?=
 =?us-ascii?Q?ggQV6aV77rArn2j1F3F8ddEgFWyuXdqgJyiYXsolYyw//MrLlUxSMzjvzTh/?=
 =?us-ascii?Q?CFVMQavEIkOMtRR6drBsdIWXo1Nr0Jc7A5nb5mrsbIhZUTbI998CAZ6Kw7Gv?=
 =?us-ascii?Q?duBvechtj17I6YBcsTEI2+XCN1CW4saNlPdlN7cE8PQuJMixeAr9ihs0cEA7?=
 =?us-ascii?Q?tYkDtY/09+tE5/mNE9H/70nh0mSj1tZDaILEsDP9vbM3bfyqa9HJozSbrlCm?=
 =?us-ascii?Q?g1gpW5BuJT2pKGPclgy40xP5POETTOm9gYyRHU2bOsFoTSblnWNAEUN9Gop7?=
 =?us-ascii?Q?HxysB+u8OxGf+HEk3Tf2Wxn0Pwf5N5kVHlP0ZWVpX3mL07/7HJnefYqUxc6N?=
 =?us-ascii?Q?sBaWEyhG0EkUSYsCztgZJGxST/YXFwathFnBR7kyOUO8yibgm6M/bXX3IvNi?=
 =?us-ascii?Q?CyLayHU7M+CkYahK68Zho8CDWf3SiiKw2t2xx3YloYYhcqgISSn9b5HhQcy8?=
 =?us-ascii?Q?+L/tOqGqpxSA4JCXUT8nT5VPfYuKl8eoXTRy/aelmHXLTNs+6xauaGFSiBEC?=
 =?us-ascii?Q?jSxcfiZvM62OSkvK0+tAJzDrY46QBcXDae09UDPocuA+a/Y5CGw9Bpj43cIW?=
 =?us-ascii?Q?cgWpLDjNQMYNKtBHNcblvwkZmTJ3KBQXwrjouWPmt3MzNetV719MC/BOvsZZ?=
 =?us-ascii?Q?9osgxJvtxYt1spXW12oZgVlW6u2SVziojeflsFBIUYcQoqP/oCfhuvWdxEie?=
 =?us-ascii?Q?ZN4t0PWd7VRMFUGr28t1QWpdHy+DPFiRThT29S++RAQJRdfGcmm8+I5GqDey?=
 =?us-ascii?Q?AWQbNYwu1Sph7ciSTRhALC0Tny83QaIRxXgnMvbNTgvEnNE+6ZYOeOQVRGs1?=
 =?us-ascii?Q?witGPmxL6rVSbX2GLTei9D5CyqarhJVXUHmwpF7cKBl7Mn7XxiKD2gc2ZeGx?=
 =?us-ascii?Q?59oZ2megGaVISfHDjwtaX8wYKjcMDzE0jNGK5JFeeBsJOk4dwQ0/DIZiRDCj?=
 =?us-ascii?Q?n6+GUZHDV7bADyRYRzN6gfwwu+1wNfg/GvNWYqinPKMwdXgn2e9aQHSrG3wt?=
 =?us-ascii?Q?mlXhE4p6qtNSckh3f7PCDrLQsj8t7Huu/qDUJmBDnzYVx6l9g/ihtA5ZNcLi?=
 =?us-ascii?Q?JcsVu4/Qg4tWvHsUz6Xq1aHMRfCdlQE/8LZ54IA3qGT20ewt9eCGany0yP+K?=
 =?us-ascii?Q?/KkbKEk3T2QoG1gFJPnswxxxyd/XsD1Bp9l21+p3I84lzFZfwNAHbDXNHgze?=
 =?us-ascii?Q?iMBFJl+DlI5SGx/EBva0H8mHDrlQRRe6GUkMdJy+KCztpo4etDGT9bkOFrcS?=
 =?us-ascii?Q?YZaqSgZwjP0kh8OBMEYXR1+h6ryztYI3SQtbcUfwM5rUv7cppM8JParcTgUl?=
 =?us-ascii?Q?dnX+Jm1OwHrePVdH50bVM/Jik1wso8zY2MCY3OgDCwZ/2dikLqy5ybrfeTyp?=
 =?us-ascii?Q?EFiw/3NNm+szXVngvQyZ8Y7DPod3Lu3R579l3UEFQbLMi65Divpz8Jbrtse3?=
 =?us-ascii?Q?a7UT4iinXcBzsrmmjci64AHEmLfPn1/gYQasU4LzRuHSdk2jSas9AoMA5kwz?=
 =?us-ascii?Q?YoR4zM0aq+Cd7xJj1QcFUpfBGXD69Y89AVDoEDXJyhs6dpiNUvZ4k8xUoLPX?=
 =?us-ascii?Q?BWyYv5Lcew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ydz7Jqc3IFnpC5mbEzr1+EBsnF3126/Kq7Cy/ikd/FmsVKpcg50UWFRCt3gadQUYsDk8IYT/5VFgwm2DQeduxIJ9/jvqnDu3QOlFeWUoMFAMWhw5hJm9I1s7I8uDrxfimsqB5JbTlrsWrZiNndvvAQOF9BATiOXREGbKTRdsZYlNLdBMH1/Kb/YZvIDtgHdCDaS7wmLWl040+jhVfC6Jwvixl+JLLlqQvKnzagC6Hzf1HoaUPMo7BoHbISzZ3BdiwqASoOkvdolYRIspahhd2OiVCW3NAbR2fIswLFCcmMo3Ssz12tv+hLQP8uwuuIcBpgGEaWMU7jHaZdrOFmF9DQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71794d67-ee65-49fc-6378-08df10519b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:11:19.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHF6OZy03nqO0aA5Li6LbieAkPgAaJr2i4oIGJqxOYBsS+BB1YtFJBFmIS2oWW0YHaQn9ShXRTxGbgfe8g99fdmIVf7HxGYNNf4Uun3G35Y=
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

> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Monday, August 31, 2026 7:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-next v5 6/6] ice: dpll: Rework the SMA control logic =
to match the requirements
>
> Make the SMA control logic match the requirements:
>
> Setting SMA1 as Rx automatically enables U.FL1 as Tx if U.FL1 is
> disconnected.
> Setting SMA1 as Tx automatically changes U.FL1 state to disconnected.
>
> Setting SMA2 as Tx automatically enables U.FL2 as Rx if U.FL2 is
> disconnected.
> Setting SMA2 as Rx automatically changes U.FL2 state to disconnected.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 180 ++++++++++++++++++----
>  1 file changed, 150 insertions(+), 30 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
