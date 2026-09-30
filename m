Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E0BCA5FAD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 01:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D10446081D;
	Wed, 30 Sep 2026 01:23:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4aBa_VA1bRA; Wed, 30 Sep 2026 01:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3B03D6082D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790731392;
	b=aV8OmClQsG4eNEnMxGySJxiajzfl08IR8VI325SAY4sFRY7NLL48m8HAqirOvS0c2eJf
	 2PDN/zsBY4txjLUlj88UTzvyyrMgZs+JBSUOgQdSQZFMCjzYK6EIqism7d0LEX5+/TDRw
	 amfb9PfyiI/1o7ELdEvNy8s84OSQ4ZBTYC9mzKyQ/Z182KVzL1H/msLw3i1vtgpalyZUe
	 N806hSIb7guIx+dfafa9yEyuopCzFLEwn4HjnZPJdcPftK4RaR9q00BRSBQm8bDR0p6FB
	 KmHSLTffMLlhUe6+ixiapgiAs8slhsPM6IJcuW7RciymN5lEIaibgyintkCJ690FWZQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790731392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Received:Received:Received:Received:From:To:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rrmE59AzzI+i3eKv/jmDFeBbLKCjB6hdXyodT9tqi4c=;
	b=A1PA8SKEam2ZiW/hZKo06eLbkbyMFwbayaTcpxa5h1KhoAitE1UeIIxCXME1jq6AS9RJ
	 CZAOFapDT35v0t82DZaAJKzuyb2vaYg3mpvIYGs2UcUviP70jiqPSWCed24IWJ/KFBHxh
	 c7+aaLjLzYEu81xczQn3q5bgVuntetizNfiIzmHVcUXPNQBHbZqVci3GLk9Y/XC8p0J3y
	 97oPbnKQs2zyxnrzi0E6ZlDeJUxtgx170HZYklBJ4ATdQ8Dz+u2e32tyJ78TZidhdKfuC
	 qTvtWSYICzz9ZqPMsdDIBy3ix+CUJBD2rJxTrDyn312lonbqSHqDGwaXFsSKO+NvjfA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790731392;
	bh=rrmE59AzzI+i3eKv/jmDFeBbLKCjB6hdXyodT9tqi4c=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gAtXG6Jte2vb8Lrlp76ZLByhYFC0YMQoqEbLNF1Ky78U9mEshmZPlPr5YS5He3x0p
	 981L6YpPNLZhsz6gDQ1tCmYKyzEK/ggYNu8elCeWdYG+UiSS2ezeItbuN85fvgK+b+
	 /jF1S9X1foIDaZVkBroVvKF9f76zcf+2/MpTrk3cSJ3Nt3iWh9R21wdgaOkOmkAte1
	 EBO4A8nkzYjQVS5AD3uEjoKF17F/5GxKyqSyVkXTS2uZdhkW6ptmfKVO17oqqEvmvJ
	 77cMFniGnsvHEGe2A/IogoazYLwzeZGtR557XavkFdha1pwQ9G/4quRTUsDcoL+dMn
	 Gr5WCZgN/iS0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B03D6082D;
	Wed, 30 Sep 2026 01:23:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB4D124E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B11FF8108E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M9yd9FtJwTdT for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 01:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 091348104F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790731390;
 b=RFJe8HDMwE9TyGa+qcVQ3jCPblYP5dcGKbkrruMvyuFqMJFeIJtKQpGExt2YAuXEVuVz
 3xEQHiDt44HTyQkwV4YXcgPSQz5GBlNGkGjGBdBIh0ZfWEMm+LNmFkf88x2nCrf/xeqZs
 7IEj85fpYwyfdvvSz26dacl5cCd8e7MgDKoxNiyPa5SJkiKyT9UNI9adbzmpgZbZxGmOo
 xsDq+sXrSPHncb6WvPECs0GjxnI+H53/Mehv/RFtuOgg+I0aZfuKc8WoCq/trCAlLMgL3
 4w2+Ap33l7rv/rP5H1QQeF/6sS2YryrO1qqDBGC6mc4QOuWMJqHNqJfTY9DJadYJYOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790731390;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Received:Received:Received:
 Received:From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=rrmE59AzzI+i3eKv/jmDFeBbLKCjB6hdXyodT9tqi4c=;
 b=XpL6DLwOP68rkG3nTXsiiu0tQzwpBDNcfipIRDG98QpS4q9U3CPWKma+CbRJerqThPbG
 2B/SBEZwWqrZpDQxcx9w4NzEmFkfxFLvQCTST//9GbOJKADcYXvEaBJ5DgOmB/WzZsOwd
 vExcrSoiyIjfHW2BQRNoxDlI4U/3e793QnmZd+/o6oyPYY1n0fm1/F4YW7/Vb/9OYK9KQ
 hJV3K0t6ZUNQ9HGJFUYFkm8u1MQRdwIFiFFGsr8QTlerJAJpZMP6u/zQz782iIb7H+XUA
 RyVliKZxHdWnERgUi0WLnqZKsddfTJzaZC7OZP+vaOsdOU4g6UcRmDIwZZ/54/rHyhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cJn3YElQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cJn3YElQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 091348104F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 01:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790731390; x=1822267390;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=3iE8XuPRjUNBX/JtRh51wZIy8JBnShvDxVGCWbtPvwA=;
 b=cJn3YElQB3c6u3aiyxsbtVCIpgP6x3VE73i6wannpK9Ffl/mg9lh8ZNO
 RLTv/t2WVLrclRyvRq4C40rTu00dgLy7MHkX1tbYNBY/oIHIuQPrKWbQO
 uO6PfODlQazWhwJ2yfWQc/uBuVQuB1TTuxYtAaK+3F8sLdf9shCjYCSDm
 IrGCPqQAqRKY4DmcS6h3Zw9i4rTMOCRIwWZWiylrUBojkaarrm/yWzka7
 cpFucUghQkGOC34c9wPIyUxkJjBH+ZiKJEZu7EbhDtBQRN+akYU6OZAJ1
 3RBJcqnxiYmc+5ektLrcwnPzlF6l+q6l1qryxlF3Ox8G/NSe5ptIkKusx g==;
X-CSE-ConnectionGUID: +iCd/0KyQfaK6mxHgyn5sw==
X-CSE-MsgGUID: q9ZU1U3BQ6CZ0cASXytD7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="108949239"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="108949239"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:23:09 -0700
X-CSE-ConnectionGUID: cdmNfV7MRSmWDNVeyVC6pw==
X-CSE-MsgGUID: 56MCokWeTUaZ9SU2oU64vQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 18:23:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:23:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 18:23:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 18:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad5tinCQVtAQRxvw0y7zbDaLRKS91lNSNf1CblOZG/6wyxbQl1L307SdTRYT3gUoRvIR3GwyBv+DYgAVOj7FdPsRQU5HwSkAWh20vffzR+HMqyTQR9m1LU0jrg59cgN9YPfhlwWhUPzSdg0l1LFnNp8oZcvK0tTvwQ/M6oAE9prSxrPZWYdUrLVxDiTcPu5Sft4HbKej+x/Ka0YUBNTX23vzGZk1sYU63J/J0Rm2wXc1MPemNZW5xac/OFU+91CylrB4vKVb1LyqvlC51bLF18qjFpaEQkF9dZgPrhIzmIofcGPi+cH1mBdWSvEXzGQ3nBi400cAPTo4tEznoc2yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrmE59AzzI+i3eKv/jmDFeBbLKCjB6hdXyodT9tqi4c=;
 b=mDub2nxBtwNeuL4RRa7pSOpfgMsYUXQ9TFZnbIgh67nW8r4YfRUCwuBEURtifJZ4pl031J49/qnm2zoDgN0hTuwIjknRWNLn0DL2AZQHMI4ktJsQEMcxgoAgiDRxe9XKlYJEHLAIZOdbsgIa8hvlGU/1Or12zP+umUsMpqH8EP8zAj+JhsCM50t1yStjyc/ew4RAwfppkjvc3xTSjteH7Ga+Xp3xL8UsQej78QAYGYvm3GCfTTAH/o6OvmpRg9NK9sTTVpbmuFaN4U7gBxGs8oV/OyRa0esJICKCw962w8dQhv4FbQwPxrjiizDtfaC0/JV1fV9XKbnZL57gVvJ7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 01:23:05 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:23:03 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Yury Norov <ynorov@nvidia.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Thread-Topic: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Thread-Index: AQHdO6cc25SExhqePU6rdsDWV7TNJbbmfRcA
Date: Wed, 30 Sep 2026 01:23:03 +0000
Message-ID: <LV1PR11MB87905603EF3F3137AAA63DF0908B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
In-Reply-To: <20260903132037.81346-3-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8291:EE_
x-ms-office365-filtering-correlation-id: 90da55a3-0342-4480-0873-08df1e915fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|921020|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: qetO6g8tV65JqA/61VKDGaGqT1uKs9lzoz+J3JWTsipHFshd9uI+39uo0ct/8y87FJw2axTIHmO+m50GNT/2ksX1OLw17VN+mubHIDX0J6UT0vR3R2N7vFY7mzHcOGQkT8WDzjwu3ngzL0r3epsOStPdxFdo9wZQiPajMZDXhvY74jcLWziawnsmWty5zjpAWP81moM0PMyF1q0DUti5o0rrhCrdCm6BeG2ADY3ft8H0ITG2C1Oau16wfxhYG+zSuWhzJjO9p61f9jgCx3akf7KcLhSx5CSjRMt1rxoj7abAslQhGlUH5ibhQEWTLhDtsIMCdP1gCHRxkGpWPSKWEIa26ircPaD0b/ZlWdWLPHF3ivJgcHaz9O0S31GHVgnP8WiHIA/cUwH+2tYJrnS/usY1Zx4Rt56Volax0FGhdf46sgMXUHyLlFUYLeH8MlUAcWzR0q9n5i8qgn+ihcUnel9baRBYBSTdJDE2vTaOjHI9drbhcOgVENidLif/WoAPbKfADII/ex24Q8dgcVE5xQA/6hqCmPtjjdj6rs+Nm3tKqmxhTHWIftV4Qa1rNt984ER/JKAN9ZpCWrwEoVpKIYwoHTCnZov84LhmLNMYlfF2xKSHIFBQOw437lXKuk0KK/sxjVl92Fdayo7nSlzdiVbMhm+PcWIcK1htyJyBuyhq7oe+PfyrgfXhYs7whe7XL0XbBE8hCI7qaPNU9+daZXinfGV43pZO2o6XlEi+UXY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(921020)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ChL2j6Z4qOSbD3jwb4bwPNRGCrrfd9EhaI2vBfmTpx+nFb2da4iDPqUW4dHZ?=
 =?us-ascii?Q?or/NjzCDWfsQr5cg1/XDfZrQwQSmSV6jr9nPOSOdEgjKolgEM8XsIckGKG3x?=
 =?us-ascii?Q?AEEfTQogirrvEdiA7pbIrA1VFIG7Y5KpIbjjrmFXFeVJZQKSID+5Cb+tE0sO?=
 =?us-ascii?Q?pkftF1b4B46mJ5e9g02o58NmYM65UXFr/0UPrjmNs4Fcph2ADWs6lIJWPZnW?=
 =?us-ascii?Q?aDKY4hOTax22rSHlWtgIoajQN0hLR2Vz5bqoDOM3vm/g8BdRbW2yvAfdScBb?=
 =?us-ascii?Q?r46XKufIF42DNhFf1xgrA/5q5qbNP5cZy6fk4VPFDfMPNPqzDKbC5BVutfB6?=
 =?us-ascii?Q?qwbbRsoTkvW9P+dYBbnIro0j4eozmGzjnd/ZIu3zwb1fydYGLgJ60oG5cIHC?=
 =?us-ascii?Q?y3zMiSyuxdqcAQpButWBhw8xZPt3wWCKEHFsjTNwL/Z7JaNdDzp2ILU+wozP?=
 =?us-ascii?Q?WsCawfzSGspX1TG0gjObzTBz7jGiy39WABEi78QWhP0qXqKMQ+FoMkOOltVS?=
 =?us-ascii?Q?hRBjjXoccLlwdz5hMpR00SRUQQc7O0hfq/MpzcmNRqlCaJSkAHyrZKeB06N9?=
 =?us-ascii?Q?R2Jq3EYBfcmaoS+pkz6Jn/Qi8Ws/qPUUO38Uh6zFauQHvYNDBMgYLmqcgcoP?=
 =?us-ascii?Q?bYZm0bbMHpFaziCSINomjaVM5eZrkSvwFsRg9ZiJDel/EQACho6/+gLSiW0y?=
 =?us-ascii?Q?qidriTHK8o0Ul5nkb/rwKqHhRyLrx/ivcORFjmwBD0nXMOp5i0XrifHYGLeB?=
 =?us-ascii?Q?4idxJpcgPiUzDL8m/eam2DeWD2VFNjFA5vEw3uXmBrPjuYMmmEU9fJxHqyN/?=
 =?us-ascii?Q?8x2re+6ecEiTnTftmaUDk4pVVyVjS54O3PEGuTtnY/GDhs6D4tFeDmN7tu7q?=
 =?us-ascii?Q?AOKULQdiDDwfetD6xxFdMdwmunkMgPnsISk49G/C5m0WeRyRwVt4+1jtkQoa?=
 =?us-ascii?Q?Ey2bcR7u8uhQ9ht1oUsbFOvrsEscuoUyDEbXlyqEYQ5Y+e+t8dLghfVuzLNn?=
 =?us-ascii?Q?VwB2xOqMOrEhzLt3LVo3Leoaj5G61jcCz16V9qdoq7W3nYiGoIkIn3evIo8A?=
 =?us-ascii?Q?9HcDjV+tVH+DOxDUa15S/9C70HnORtgFNKerYXRV17aRvV59lcSsTWvKlHsJ?=
 =?us-ascii?Q?BpLoc5yYHWyR1c9UA214xZ8mdGMxhD1bN+aUIiyh4iroWFotPl9Acb3l7IQZ?=
 =?us-ascii?Q?IJbwM10k/giLAAQf74OhiQGDhA0hLG0nXbrAqH2TTTlejg9Z+mVsyyCy1WhK?=
 =?us-ascii?Q?b4OAyL/Ka4cQ2f4Xxb4ztyrN6IXuZUjfx66EEdgk1tZf+tUqxyCzV6gdCtjS?=
 =?us-ascii?Q?uDsdSWjVBjq5fnoZ8wNBGbsDJkuq7/sJNfJzcaLxls1svp3Jswuw4MQ2psNt?=
 =?us-ascii?Q?maRJuu+Eelp8SyyZSjP+UnC4bTrwL8vYSK/M7cQDLBqi/Gc01WnwwFfLLug5?=
 =?us-ascii?Q?vjCqasMYBU6v4E0KojGU67B3v10YnhaQZ+AQbOy223l/ixYJSkHj+UUT6LzV?=
 =?us-ascii?Q?BSykS3F/T6lcqgJODbQrNkD6OR0otOauDlKBF489Lz9y7H7PsCL1ceT76pcZ?=
 =?us-ascii?Q?n5VZ95gr018fKGkT2DymVxQm0tuswVQP0YWXM7QeAWkFo7asFp48v3mUIAhU?=
 =?us-ascii?Q?yWy1HDEYF6FLGYC9B2SsdiLXFOSnIiovjMtEdV8wT2gOgtgqNJnSTk+8gNdm?=
 =?us-ascii?Q?cCd5kPU3iAkfhbKs56jh/4xAyDIcz2udPR7DQEOljdwFerb5ElRNU+5lA/+y?=
 =?us-ascii?Q?VGLPXjCxjg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VVsG4jj4bxZgykSAKa/L26HkyBptPSRstlfkttaGsT3kRbLtLrF3ggGRrZ3/LIl6lfZWpht8grbW/38/gMePfYV0zksI/o9eAyJQ0pjxUZnnYwGy0mE0jyxi/8Nupjc3kBVREyFpgFh1i1NDmdT0MwYL9NlAADJJf1U+mvpQO8RevgkBown2MgR7KybNH2PmmPuokvUYWZiSKthr5CDLD+emzf8EaeWiP7Yiee/VlvbjwxAOMGeD3NSAEouOWC+TKNISMumh3QGsiTVanlaWQI1PvKSkEZcbrDIpfzgG0/d1HMkjw25Is3CEGTpPyjF+EYUTmm9RyhZOsIsVDsNiMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90da55a3-0342-4480-0873-08df1e915fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:23:03.6619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnyhEwCNPIyPvldxMagtaJQW3yQdHJqFXqTxHQrQ9LjFxfBev67y62A2LocXc8trS+/O7v1NkMbb+Nz3aQ/c+zfr380l15acoSwhpU0i/lg=
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
> From: Yury Norov <ynorov@nvidia.com>=20
> Sent: Thursday, September 3, 2026 6:21 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-wired-lan=
@lists.osuosl.org; netdev@vger.kernel.org; open list <linux-kernel@vger.ker=
nel.org>
> Cc: Yury Norov <ynorov@nvidia.com>
> Subject: [PATCH 2/2] ice: drop pf =3D=3D NULL check in ice_pf_state_is_no=
minal()
>=20
> The function has 3 callers, all except one explicitly require pf !=3D NUL=
L. Add the corresponding check to the remaining caller, and remove it from =
the ice_pf_state_is_nominal(). It makse the fun function a one-liner.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---  drivers/net/ethernet/=
intel/ice/ice_main.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
