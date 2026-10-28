Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4B0606A32F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ItC2UamD;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J+kTvb8B
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 932E0822A3;
	Wed, 28 Oct 2026 18:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPyHJ51bi9jR; Wed, 28 Oct 2026 18:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4E7B82660
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793212401;
	b=ABlQnmC73Akq+7JiA0lVjHuzdfl33/uzDo5ytWtmq3egkNq7yBvP+u9UVM0paePcpz5Z
	 OUSGe3WGuan9dEF6EyvthCVWzcziWIUSriHZ3OdAYLW+4AA3ENUDfa0CMksBZkGkT89X4
	 XkNedkD5bWRKS4zuipkjcUN//AZMmz/xgQgshEwEBerzSVmN866nvm6RkgFPrD71/t1PM
	 Kscmr8vwQxpCInoM6AcBfn313MWLLLTa+uN3tkuGqSRXWI2LHYQH5TCHXZW/lZ9ur9c6i
	 R0mVJ7owx4osV1oCyuwSXve2n/3+vW48O8yv+2UtAVIwMDxVHenj389wmexgY8a+ntg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793212401;
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
	bh=eZJ1ohIB7vDxLIAXfLO0nVJPtisqtWdct2oI4DvTGvk=;
	b=RhBkYTa2RcZkWH+JHnr9bqAx1Iw6WGdQo4ecT+Qo99TIDBOTmuDsWUOgf+yR6YbuuTpV
	 TFJKPS2GOj5HDWcFqyFbsoPquYjieb+VU1NtXeaPsK2s/ihUuC1iKeMm2a8tb9LnQIuyW
	 OxOhDdn0BHdHlK4kM3lDFwJ4v+R00CQAUGPeHawCdzyerWcE6uJs+4/9HXrV4b9pieVoO
	 M+P92GUrCRvDLo8EjUNhYo7SdAXxZD6sA4LQXacApfCTrsHHtrmjC1YWGkoDQpEJeFTC8
	 SbWKrDofKUJAlahPjnVlqT7G+u5VhgL1k4Vr9mR6MVwJF3cmzuQiHs+HSHrOilS7gcg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J+kTvb8B;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793212401;
	bh=eZJ1ohIB7vDxLIAXfLO0nVJPtisqtWdct2oI4DvTGvk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ItC2UamDXhO9RAhoq16GMFuUVVkW+yW3xc13f8YT6MSmXOC4ylevIkXd4ciz5QZ+8
	 MWN7Pemb9gJ03AJ5qKw8+Ss8N8hmJxvW/B+gbTh/l51kN2yDlv9Ph5gvotq79UKWlq
	 YVAZCs3YslCfw5vKwvKTw2k6vNSH5t+uAWMeer4ZQKbltHgDNOQGdL1lnxDXBESEYB
	 uZhEwV2MHdaaQzp7hjP7P7aMSTnv+Aw1uN5E4WpwBMx/hogQWXLMf/zxvMLSC3jhtp
	 TzxG13DwLpP23Hn/jzQLN0aAxAov+Jn1na8nzKlP8lspD78ByLFWAPIQNvlbpcfsI5
	 NtRWxlSxOqqiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4E7B82660;
	Wed, 28 Oct 2026 18:33:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDF67362
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0250A821E1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pSo3mfx0_EDJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 18:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E190782135
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212396;
 b=e7+S6urixazgPyofMy+rxws9csqCJIF4T0a/aD/3dt/zYLz1iR1zZ7ebIoUdKwByvizX
 8v+4XTtTsgfB2LGl7VLXO5YJI4jITkAmZ1uVmkGKqWgigcIGdUXWz3juZlqhqD/BIAMfU
 xwmYeA352TvLZDkL+1sAS6x53inNp/RcOF8p3VOzesq+sI625ixB6ne1CpZyQIVf+Ielv
 59gBoyYWMtIfnjhNp0NuadRSbk1nEH/K7EUa3fgs96+VcaaZ4YBJecRCJYmf0owSM1c9x
 zKj4x/YLbYc0voSRV7q3s+sz5Vzamb1/qtKheqSXtgZkX8mi4/o0xO8zcL2HGbnNmKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793212396;
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
 bh=eZJ1ohIB7vDxLIAXfLO0nVJPtisqtWdct2oI4DvTGvk=;
 b=mSn48S6A4WDBhkYyYbcaHX899b27IRUOf5QJHcQ95BGKMJ3cwr2/oJ4W3NiiQzA07dzk
 +IoeBOEWOVuivUVk1PgYCm2FnQ18ZIDjCGfl/ilVynNJ2cQIUEHhx4pDYwekSesFrvdOy
 x/gNmSIQRr8bNL0tzU/YXd5fgRdORWnDyPybnoKdBTBrXTagFukUV8/dH/IJ5UaeR6q8O
 Rnslc5//Fb46Py9X6CFsrK+24kmu8FhJxqRCNhcbFTL11XR1iEM7xCnAmCiaxMj2C6mEl
 RN4vTh3t9KDsrLP4I+69IWJ7mzJMvDp0WykJGciNtJ2HS5qbhGCBi1gpmJ5BPk2FxeQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=J+kTvb8B; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=J+kTvb8B
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E190782135
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793212396; x=1824748396;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eZJ1ohIB7vDxLIAXfLO0nVJPtisqtWdct2oI4DvTGvk=;
 b=J+kTvb8B7HSFBGMeFS7FpwZrm82iHcvWXAyRCYwEKOwbbb7YGq/nzfzC
 mMzDfyvt8k7AqCt3q0Swbq4YVA2AC+Rn35R04Zs1ticQgkqrpig/fVSaf
 MkgShwu1Jb8zsu/XJWvnZA/cPR29rbxAmF5nkDS5ylFtSIUO9Q2yxn2B+
 qeyjxHPKf4AAbKEWXk3GTsYUZyI3OmMYAqegDHWNYGVpGNPVbkbtwVKaw
 YYKlc9g58ysykidhhpGNYJXG/SSrZ9UgajDoLozd+xlt2/5lF39NzVsz/
 Us0wDz0vIaMvKWIBFEA/m0zJxaU5mpvB0Iv5DM0ioAzb6GJFc3VXYbKv+ Q==;
X-CSE-ConnectionGUID: eZs+JSDYTH6bcx5X8L94wg==
X-CSE-MsgGUID: DmkGvhSiQKex9YhraFSc1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1959497"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1959497"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 11:33:15 -0700
X-CSE-ConnectionGUID: bC7shjSgTNapr/XCBjAykw==
X-CSE-MsgGUID: 2d8Aj3lPROqXyX89ZKi7HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6683003"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 11:33:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 11:33:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 11:33:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 11:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd+0X/DsJ/aA7iEMz7gWZSTXc5EoDQoG+L10xVmB92doXPprSY9ZA5avvGsW6FPmvF9gEIyMRRjmY6+Xh06CVT5yTWjx/KKRZILiddfLPDvrVw1fJF3XxEH7HSlKtNoPNH5Nt81HjNev06Pb8QSt/SrX55lRUaVH/5X7JLgLaOjECsOMzImSDa5A7WxXMpm9wQ70sAukLxN+vSsuTL8BAc92ohy+tPuBvYTTlwjPMXEGDd6JX8MT4FrfsflDfBhnU5ylUGnF9Bmz18wksuR6e5RnR0jeUDytmXCrOk+86Zufoz9sICWvnEzFVXKZ5grI8vdGTqCoL2TxeEkQNpe3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZJ1ohIB7vDxLIAXfLO0nVJPtisqtWdct2oI4DvTGvk=;
 b=QaUcFQiO+bt9I7MVAXp+S1Y2+9mR5tLld9SnxPtlwFJIwRvQIa1fzT7PsCS5FGNpzGcEoADoKvXSqEqU9oGuwXWc4EB0RodQvN1Zu4zLxG2mndb9tBaJlrk7RPs7eRy3yudYJisD11Z+bajf9NierCB1yvkRnCibOZ7Y4nZ7OqMCJ9gXrD5yG0Ml/6iQAAaWq9w9dSsIllchq6K1awnHLQDAFpeM+RgkhtLc98TZt4+kgDXyF+dS7Uz6hrhx8yXGIhQuYanelXqC/nEiJcEU3QRZQJZ9hIIdZI6BELJaDtodakxL5Ch8HYGYOu4mtt96U1cdkWxP48LIMDKjAElVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SJ0PR11MB8272.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 18:33:10 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 18:33:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "choiniere.vincent@hydroquebec.com" <choiniere.vincent@hydroquebec.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net] ice: fix NULL dereference after disabling RDMA
Thread-Topic: [PATCH iwl-net] ice: fix NULL dereference after disabling RDMA
Thread-Index: AQHdZU4+zzBG5aXNJ0ym4ZC6J6qNKrcTSuHQ
Date: Wed, 28 Oct 2026 18:33:10 +0000
Message-ID: <CH3PR11MB5668958AB7C8DBC881F0E5ECEAE56F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261026-ice-deinit-rdma-null-v1-1-7d2130d1809a@hydroquebec.com>
In-Reply-To: <20261026-ice-deinit-rdma-null-v1-1-7d2130d1809a@hydroquebec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SJ0PR11MB8272:EE_
x-ms-office365-filtering-correlation-id: 963d7cd9-a7a2-485f-679e-08df3521eaef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|921020|5023799004|11063799006|56012099006|261021121427099003|261026121527099003|261021123027099003|261021135927099003|10067099003|261009223027099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info: VdpRAm7E2+/sFmT+EDfC82olLc+hFP/TCmcAP+xft7xg123zbvP1RGA+UvxwmBhgJ0neXThuJmaNE6oTyTa/S9WcAXmSn/8Piw78k6fMgLhvpugaHJ0m793IW8nuknLAkCtMXckSX6lQORjQlNP5PqbFRGa8xi+3+gkf6LLRAcZPTMZVgGPxV52fGe79ngLW/i0Vb9fPofUiGbGn00/AH/4sCbOS7oTYblpY64BawgN9JntEMutwoFp1hJ0YrcMuwHFnuN7ZLSGO0rb/Y1VRfg73Z3ictaG6BcKV33VGPx00WlUG12cligL+U5s8JojZvIEyU9Z9GytaAC+a04543p6T6i0ECcdcYkt3+fV/z+oYMFFQ9YP7i0FdFbS2iNucJ/BQazdPM8ro8tYiO6ViC6VALTNaJTDFu4Em7GvPcBxySL5L4EsyaGLPVH5GXPUjNplmOza+av5aBTdDI/rTJpoVgsEkzPeoqyaEytbmRFW+QWCDF5Yf4atBwBFX5LWfVuepVpEj00OGyD1kd/q1kai1UKFVJ51N+r0/QZ9PGHfAREBl1J8L5GC+OUfkmkiaPqxukVTCXLoRdfe1hF4RD1/JR8D9gyIaTtgQsK8iJUscIMTm7boayGEW9GWmr/E59iG8HSn4zs2oa2IIZ/9tSsnJ6WVUJPbJQuC4+y5ld3H/+3I4I2LuH5fGfHrTFIqBCzqcBIVEMBGdPV69eoDhMflZWXrxbNu+GVRoFcv6CWl+0OQ8FKwwm1aYN3dePhEW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(921020)(5023799004)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261021123027099003)(261021135927099003)(10067099003)(261009223027099003)(261022075727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEorSHZYMkdVQmVRdysvUE42Y0JnQzFsaEtZYXd6bGtlWUV0QkNRMjNiMXBE?=
 =?utf-8?B?QTBSZUpVNEF0Vnh5dmVjUUMxUkdsaks0elJab3ZBODdyYnlKUUdXOGRaeGE5?=
 =?utf-8?B?TGhiR2FRaXAyaVRsU1ZXRlJSR2tiU0puVFIwYnp3aEdsUWgzeXdVQ0hlUFZJ?=
 =?utf-8?B?QnRyVWVacXlkMHE0STU1WlltUFNHSDVDQjVyQ0huck1aRDdRRnhaVmorVW53?=
 =?utf-8?B?NkdQRk5FMnFCUnMraGVxOE5qTTE4WnBXTXJmTWcrQWxFSkFWQU01Z2xhb2lj?=
 =?utf-8?B?aUIxRzFGcVYwazFJQVA4QlIyRW11TkoxQjJhN1JJblYwc25KTkExSDkrVm0x?=
 =?utf-8?B?NmsrSnEyYzZQNkN5S1p1UVovcWphTUpaamQ5SVl2UjBQbkROWDkyaHJMSXBU?=
 =?utf-8?B?MEVsOG0ycWVZbnNsZHZCUjJ4L2VjeW8ydEVxTk5uaDJTaTRtaGcrUHdXdnEw?=
 =?utf-8?B?TEJ3bFM4N2lXa3FSVjFjdUc2MzA4dDI0WjRlMUZKY2V4K1BIZElsMStWRFd5?=
 =?utf-8?B?VEhNbHBYQTY2eU9MY3lMdHErTUlCQUpramF1U3hjeGNTdnJXQmExMHpGZTl2?=
 =?utf-8?B?K3RVZ3RuYkloajRzcklLbHRVS2xTM3c1aHpuaHVHYWlCU2VyWm5YMHdnbWZy?=
 =?utf-8?B?UWE3SDRSTGl6cU5VWm15ZStraW5uV0htQksvNkUwRzVkcEM3WFBBSDZUVjBH?=
 =?utf-8?B?RG5aY2FPams5T2FXazIyeGJwY3doMUpTUkRJMzd0OXF1UWgzeDVucVdYdmh2?=
 =?utf-8?B?V1psYW1QRHhrM2R3UUtWclc0U3QzeWpZMzkvZkdrZG9FQXR6Nmlja0I3Y2JE?=
 =?utf-8?B?Q1krdUp4UEJDLzBrZXdiYmR4TXFvOWxyTVdIemkzRnNZMy9Ka0hxVFZQNk44?=
 =?utf-8?B?LzI0azFucEtpZUQySFRVd1huRCs2ZnZJZHNUWnV6T2pGbmZhV0M0WklyVkxR?=
 =?utf-8?B?K2JkZ1NQTVQ3ejBWS2VMRnRURjhxdjA4cm53Vk45NndtSWd0NDdPTjlGbVRY?=
 =?utf-8?B?VDQ2WVdSVXB1V1N4cGdNU0s5OHZmRkJzQ1VUaG4reFRVbllEV1Q3OVdSTEJR?=
 =?utf-8?B?OVVSZ1B5alFrWUxLbnFlOWQ0SGhKckJ4THpiT1ZGaVc0NmxZdGI4SmFmZVlB?=
 =?utf-8?B?Q3RkL2RmL0VQdjdBNjEyRmEzSjV3NFhjZmZmSzNBcnlwTEpqNGF1VVg5RnVP?=
 =?utf-8?B?WHhhQ3NMM3V6L2hrTGNheVdHOHVQeS8xcjBsVkNsWGJWV2FSVTlEdFo5UXVy?=
 =?utf-8?B?b2t2Q2VhSUFZY0JXTityQk9nZnZEYlk5ZWVpajFwaVpnSTZFcENFSG52SFBo?=
 =?utf-8?B?QytVMkpBT1dlTWVFREJTcDdtbE5QS0Z3WHE3VUhHdXMwRHp0UU9pbmlOVFZx?=
 =?utf-8?B?YVNJQS8rUURwWFdqTTJsWDZKdmRJb3A2SFo0eWgwNDlGYXJPNTNtS1gvLzRk?=
 =?utf-8?B?V1NiR0NDa3FOR09BOHVSMGVTemJHekE2a1FuaEV4bU5UQkZrZmpyTVlFWnQ3?=
 =?utf-8?B?aEhTUlZMODgyRlF4QmYxY2sxdTVvd21BS1JBa0tNQ1h5bnVEMktHVlJITFE2?=
 =?utf-8?B?T2d3by9LQWpMaEVtcm5SVkdvQnA1QjFyeUR3MTJmRHhGYjdWWmU1RUtQcG9u?=
 =?utf-8?B?VVhENXUxSFNDTjBaZWI3dEloRzRwclltampDV24wcHgva3FlSjdKZCt5M3Fn?=
 =?utf-8?B?QnBNaURFS0Z5THhoZTFwajlJVmY1clhuKzFVNURBYVoxY3oyQkY0Yy9LS09a?=
 =?utf-8?B?bXdWcWs0TGRtSkJIbG02d3BGb2ltd0I5bDAzVnZxa3ovVTQ2NmVrNVV3d1Zw?=
 =?utf-8?B?WWkyZFZZbEdJME9sb1ovOWhoUGZvaVRWemZkcjJUUE5uQXd3L0ZEWk5BSmxa?=
 =?utf-8?B?dXhKdzAyRkFGbzVuR2pSQVlEMmhELytvZ0FIanFWM0JwMzI3ZFg2TWExVllK?=
 =?utf-8?B?V25IUFkzNlJrREd0Wmc2ZnRaT2JRMGJrM0VlSksxbDA2eVpDTXhXNHpDR0RX?=
 =?utf-8?B?NVpoMVllRDUzV0xkaDlHR1JaR1JrYkpxRThEak5XVU50ZkhSczVmNjhjcXBW?=
 =?utf-8?B?clJFN01pemcvN1VOZFViNGtXOU5PWlhJUC9ERmNDeWlKOWdHWmFGWlNnQ0Yy?=
 =?utf-8?B?WlYrOXo1aXVDc0Y1WEFoNVVjZVZ4RjhSNEpPK2JDMW4wYkYva1JZWUFTeWVW?=
 =?utf-8?B?WXlyTFFFelVUZldnLzJhWmFvMzBibkZFbld1dndyWWs3SGRnQkNPK3hOdFdD?=
 =?utf-8?B?OTdHbStMOGxFd1YrVmRsR3JkZktsckh0cW5VQTdmZmpXL1V4VE1HRVhGVDIz?=
 =?utf-8?B?Q3RUdHBwaEZQY1BsaGx2VDZqb2VveVBITkhSTVJ1dU1VVU01dGRsOVBidGNq?=
 =?utf-8?Q?1G7xFC4lP+UVC8y8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kXgFlo/iPWC9dgCASEELYKxkfUqhy65RaV8kybK5BseT6W3wlREk4nq75rUPyvW4d4NHdrsj2kMf5UGyfgclk5UxsrZVVg4OxdRhTsbZKMbQNStXVA40zt4MpiFXGHccxAaD1H832Ji90sbYup2aZIO85gbkT1W5RXLKGXb2Lj4Pc6npviY0Pr0H29xAkkrFNWW2gmqqBaH0Ugwo84fCy7qN7n/8MCjwS8WFV+TIjYA/8+H+IafdPKbtra/H6S1dzTA8mA+xusbi61+uDJ5G4le96ZUhZbBI1C8s4rYkan/2I8MhyKnz09Wteq9DxNB1mZozV8Cc3V/KdySJJufbRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963d7cd9-a7a2-485f-679e-08df3521eaef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 18:33:10.1121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3uDC53w0TRAPcIyLlAGWc1icKr9QTnlhESLKq5d+BaP+DzDbytKVpMATM4rC5EyySrFBXhrVK4xeaeMmkGDIxxqi6L+7lNm2Q0wpVmh7woY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8272
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBDaG9pbmll
cmUgdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK2Nob2luaWVyZS52aW5jZW50Lmh5ZHJvcXVlYmVj
LmNvbUBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjYsIDIwMjYgMjozMCBQ
TQ0KPiBUbzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsg
S2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEFu
ZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1hemV0QGtlcm5lbC5vcmc+
OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVu
aUByZWRoYXQuY29tPg0KPiBDYzogTWljaGFsIFN3aWF0a293c2tpIDxtaWNoYWwuc3dpYXRrb3dz
a2lAbGludXguaW50ZWwuY29tPjsgaW50ZWwtDQo+IHdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
Zzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgVmluY2VudCBDaG9pbmllcmUNCj4gPGNob2luaWVy
ZS52aW5jZW50QGh5ZHJvcXVlYmVjLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXRdIGlj
ZTogZml4IE5VTEwgZGVyZWZlcmVuY2UgYWZ0ZXIgZGlzYWJsaW5nIFJETUENCj4gDQo+IEZyb206
IFZpbmNlbnQgQ2hvaW5pZXJlIDxjaG9pbmllcmUudmluY2VudEBoeWRyb3F1ZWJlYy5jb20+DQo+
IA0KPiBpY2VfZGVpbml0X3JkbWEoKSBjaGVja3MgaWNlX2lzX3JkbWFfZW5hKCkgYmVmb3JlIGRl
cmVmZXJlbmNpbmcNCj4gcGYtPmNkZXZfaW5mby4gV2hpbGUgdGhlIGVuYWJsZV9yZG1hIGRldmxp
bmsgZHJpdmVyaW5pdCBwYXJhbWV0ZXIgaXMNCj4gcmVnaXN0ZXJlZCwgdGhhdCBoZWxwZXIgcmV0
dXJucyB0aGUgcGFyYW1ldGVyIHZhbHVlLiBPbmNlIHRoZSBwYXJhbWV0ZXINCj4gaXMgdW5yZWdp
c3RlcmVkLCBpdCBmYWxscyBiYWNrIHRvIElDRV9GTEFHX1JETUFfRU5BLg0KPiANCj4gV2hlbiBl
bmFibGVfcmRtYSBpcyBzZXQgdG8gZmFsc2UgYW5kIGFwcGxpZWQgYnkgYSBkZXZsaW5rIHJlbG9h
ZCwNCj4gaWNlX2luaXRfcmRtYSgpIHJldHVybnMgZWFybHksIGxlYXZpbmcgcGYtPmNkZXZfaW5m
byBOVUxMLiBEdXJpbmcgZHJpdmVyDQo+IHJlbW92YWwsIGljZV9yZW1vdmUoKSBjYWxscyBpY2Vf
ZGVpbml0X2RldmxpbmsoKSBiZWZvcmUgaWNlX3VubG9hZCgpLg0KPiBUaGUgcGFyYW1ldGVycyBh
cmUgdGhlcmVmb3JlIHVucmVnaXN0ZXJlZCBiZWZvcmUgaWNlX2RlaW5pdF9yZG1hKCkgcnVucy4N
Cj4gT24gYW4gUkRNQS1jYXBhYmxlIGRldmljZSwgaWNlX2lzX3JkbWFfZW5hKCkgdGhlbiByZXR1
cm5zIHRydWUsIGFsbG93aW5nDQo+IGljZV9kZWluaXRfcmRtYSgpIHRvIGRlcmVmZXJlbmNlIHRo
ZSBOVUxMIHBvaW50ZXIuDQo+IA0KPiBUaGlzIGNhbiBjYXVzZSBhIHBhbmljIGR1cmluZyByZWJv
b3QsIG1vZHVsZSByZW1vdmFsIG9yIFBDSSB1bmJpbmQuDQo+IFJlcHJvZHVjZWQgb24gYW4gRTgx
MCBQRiB3aXRoIFVidW50dSBrZXJuZWwgNy4wLjAtMTQgKFBSRUVNUFRfUlQpOg0KPiANCj4gIGRl
dmxpbmsgZGV2IHBhcmFtIHNldCBwY2kvMDAwMDowMjowMC4wIG5hbWUgZW5hYmxlX3JkbWEgdmFs
dWUgZmFsc2UgXA0KPiAgICAgICAgICBjbW9kZSBkcml2ZXJpbml0DQo+ICBkZXZsaW5rIGRldiBy
ZWxvYWQgcGNpLzAwMDA6MDI6MDAuMCBhY3Rpb24gZHJpdmVyX3JlaW5pdCAgc3lzdGVtY3RsDQo+
IHJlYm9vdA0KPiANCj4gIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRk
cmVzczogMDAwMDAwMDAwMDAwMDAxOA0KPiAgUklQOiAwMDEwOmljZV9kZWluaXRfcmRtYSsweDMw
LzB4NjAgW2ljZV0NCj4gICBpY2VfdW5sb2FkKzB4M2YvMHgxNTAgW2ljZV0NCj4gICBpY2VfcmVt
b3ZlKzB4YjUvMHgxZDAgW2ljZV0NCj4gICBpY2Vfc2h1dGRvd24rMHgxYi8weDYwIFtpY2VdDQo+
ICAgcGNpX2RldmljZV9zaHV0ZG93bg0KPiAgIGRldmljZV9zaHV0ZG93bg0KPiAgIGtlcm5lbF9y
ZXN0YXJ0DQo+ICBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXR0ZW1wdGVkIHRvIGtpbGwg
aW5pdCENCj4gDQo+IENoZWNrIHBmLT5jZGV2X2luZm8gYmVmb3JlIGRlcmVmZXJlbmNpbmcgaXQs
IGFzDQo+IGljZV9yZG1hX3VwZGF0ZV92c2lfZmlsdGVyKCkgYWxyZWFkeSBkb2VzLiBUaGlzIHBy
ZXNlcnZlcyB0aGUgZXhpc3RpbmcNCj4gZW5hYmxlX3JkbWEgc2VtYW50aWNzIHdpdGhvdXQgY2hh
bmdpbmcgb3RoZXIgaWNlX2lzX3JkbWFfZW5hKCkgY2FsbGVycy4NCj4gDQo+IEZpeGVzOiA4NzE4
MWNkNjk4NWYgKCJpY2U6IGVuYWJsZV9yZG1hIGRldmxpbmsgcGFyYW0iKQ0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IENob2luaWVyZSA8Y2hv
aW5pZXJlLnZpbmNlbnRAaHlkcm9xdWViZWMuY29tPg0KPiAtLS0NCj4gVGVzdGluZyB3YXMgcGVy
Zm9ybWVkIG9uIGFuIEU4MTAgUEYgcGFzc2VkIHRocm91Z2ggdG8gYSBLVk0gZ3Vlc3QsIHVzaW5n
DQo+IFVidW50dSBrZXJuZWwgNy4wLjAtMzggKFBSRUVNUFRfUlQpLiBUd28ga2VybmVscyBkaWZm
ZXJpbmcgb25seSBieSB0aGlzDQo+IHBhdGNoIHdlcmUgY29tcGFyZWQuIEVhY2ggdGVzdCBzZXQg
ZW5hYmxlX3JkbWE9ZmFsc2UgYW5kIGFwcGxpZWQgaXQgd2l0aA0KPiBkZXZsaW5rIHJlbG9hZCBk
cml2ZXJfcmVpbml0IGJlZm9yZSB0aGUgcmVtb3ZhbCBzdGVwLg0KPiANCj4gICBSZW1vdmFsIHBh
dGggICAgICBXaXRob3V0IHBhdGNoICAgICAgICAgICBXaXRoIHBhdGNoDQo+ICAgcmVib290ICh4
MykgICAgICAgTlVMTCBkZXJlZiwgcGFuaWMgKDMvMykgY2xlYW4gKDMvMykNCj4gICBybW1vZCBp
Y2UgICAgICAgICBOVUxMIGRlcmVmICAgICAgICAgICAgICBjbGVhbg0KPiAgIFBDSSB1bmJpbmQg
ICAgICAgIE5VTEwgZGVyZWYgICAgICAgICAgICAgIGNsZWFuDQo+IA0KPiBBZGRpdGlvbmFsIGNo
ZWNrcyBvbiB0aGUgcGF0Y2hlZCBrZXJuZWw6DQo+ICAgLSBSZWJvb3Qgd2l0aG91dCBhIHByZWNl
ZGluZyBkZXZsaW5rIHJlbG9hZCBjb21wbGV0ZWQgY2xlYW5seS4NCj4gICAtIGlyZG1hIGRldmlj
ZXMgcmV0dXJuZWQgYWZ0ZXIgUENJIHVuYmluZC9iaW5kLg0KPiAgIC0gaXJkbWEgZGV2aWNlcyBy
ZXR1cm5lZCBhZnRlciBhbiBlbmFibGVfcmRtYSBmYWxzZSAtPiB0cnVlIHJlbG9hZA0KPiAgICAg
Y3ljbGUuDQo+IA0KPiBObyBLQVNBTiBvciBrbWVtbGVhayB0ZXN0aW5nIHdhcyBwZXJmb3JtZWQu
DQo+IA0KPiBUaGUgZXhhY3QgdGFyZ2V0IHRyZWUgKG5ldCwgNzA3NmY2ODRkNTEzMmU2YSkgd2Fz
IG5vdCBidWlsdCBvciB0ZXN0ZWQuDQo+IGljZV9kZWluaXRfcmRtYSgpIGFuZCBpY2VfaXNfcmRt
YV9lbmEoKSBhcmUgdW5jaGFuZ2VkIHRoZXJlIGNvbXBhcmVkDQo+IHdpdGggdGhlIHRlc3RlZCBj
b2RlLg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfaWRjLmMg
fCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2lk
Yy5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9pZGMuYw0KPiBpbmRl
eCAxMDJkNjNjMzAuLjA5ZGZjZmZlYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV9pZGMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX2lkYy5jDQo+IEBAIC00NTQsNyArNDU0LDcgQEAgaW50IGljZV9pbml0X3JkbWEo
c3RydWN0IGljZV9wZiAqcGYpDQo+ICAgKi8NCj4gIHZvaWQgaWNlX2RlaW5pdF9yZG1hKHN0cnVj
dCBpY2VfcGYgKnBmKSAgew0KPiAtCWlmICghaWNlX2lzX3JkbWFfZW5hKHBmKSkNCj4gKwlpZiAo
IWljZV9pc19yZG1hX2VuYShwZikgfHwgIXBmLT5jZGV2X2luZm8pDQo+ICAJCXJldHVybjsNCj4g
DQo+ICAJeGFfZXJhc2UoJmljZV9hdXhfaWQsIHBmLT5hdXhfaWR4KTsNCj4gDQo+IC0tLQ0KPiBi
YXNlLWNvbW1pdDogNzA3NmY2ODRkNTEzMmU2YTYxNDVlMWRhMmZhNzQ3NzFlY2QwNTJlNQ0KPiBj
aGFuZ2UtaWQ6IDIwMjYxMDI1LWljZS1kZWluaXQtcmRtYS1udWxsLTYxM2YxYmUzM2Y3Mg0KPiAN
Cg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPg0KDQo=
