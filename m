Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB274CA5FCB
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Oct 2026 15:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6147440B8E;
	Thu,  1 Oct 2026 15:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLDzsh2hqNTK; Thu,  1 Oct 2026 15:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3CE4440B71
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790867305;
	b=aP0xwGRVXdu7nePCKTJ4ipLvW8wJTlGtCN/6/O57Qaz43BdHmOMo1F4F6wNGj1uKD68p
	 sgvufY9M1e8D2K0P4pY5MHvArImUsHfEoEAnZ6P/00PwZtHXVJzmEo5A1BdOgh9kuVEqM
	 s6R5sndsULAiTJxIw9QgePmq4i4TD9iD7aYq2CDOjw+u4HzMasU/6OYBgQWn4DR1RWbwe
	 92Dfxh0NzUXsvpfKV0qHzcbKgwCt5ah+Pf1lWRANx7YI9fTY772YgrcDdhwfsvWGLE9Wy
	 28aI0YylIpXNf1HuMsELmpicZbDs99XCEbaamGC16lF8VrilAKAd1fyiMfYpEx6b9bA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790867305;
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
	bh=cgDmdDuHxPyizgQ4CUwCsKTOFOYm/sIuZQS3CvqjYjA=;
	b=ExjXwIJRzwy4LRpZWeAo21cffL6wk0J3CUGYXbg7qP1VsgGMTm5W+VqIMETeZM3QEeg3
	 N2jwenSIZildBgCQCnA0R06HbktZ4C1sKKGdZ7SsxlGT6dPO9xB+EK9kU8XbROufDbHaQ
	 UUXbhM+z1TFs1dHB2yFY4pOVnLT+ykQp+kmTKFfGZPbdThJDxMiGckEy2apzk1Gl8GX0P
	 JbCiFnUiy5qdFHTnTSIKXRauFFDkK8IzVd0BEwpWJ0FfXoGWIzSV76k24ced+SX3kG58A
	 aL5sfar9ykdohg6JERCr9uWdn8xyeL/JbYYIUKpAaO3xifQq8bJKqNJMVP6iZIz0OKA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790867305;
	bh=cgDmdDuHxPyizgQ4CUwCsKTOFOYm/sIuZQS3CvqjYjA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QyNEieTRABgRHfSr5i2GaqBqS3rFvDvPnRIjdJNvF8L6opafB5rGY/ciXiKqkJOB8
	 QGJzjNoKkOax4YMqHs8QH4cJ4z2sErerL51I5Sx4NInxIRD245WzU4cPB/Hpv73APO
	 GJTxxZNYGKdcaDHQXdz3jAUZMWIMPEeL1Ncx7i9I7zUWY7MQgBtd4UYZl1YbpJ0Dg3
	 KFQbML12U+bXWcea8iaG9fGqIlFM8c9vcfSm1+hSBUu/+OTYqGiBMsvaBtObAS7wNe
	 GqHKLOb0VPu9p8Wq2WwZyStdyzXs11P8KfEdsNPkIYVucwuCgtLfVBEimrflibSRtD
	 IJbkm8Ci66qIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CE4440B71;
	Thu,  1 Oct 2026 15:08:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B731282
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 15:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D1426083A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 15:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hjh2SflY_dOt for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Oct 2026 15:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C4D006081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790867302;
 b=pCMEce7HkXBqECFBKnDcz5ccee5RJM6KAQFi2TRXXHe4ic6wMCSlph/5FqE7SRLfiYC9
 zU4Pf3DK/LE6IF/ukBLTuUPkCGLlJf68WtJbQNf6aErJl7yY+4Oefhb/Ox7fcG0rCol5U
 TI/1d8jTIhFK+78HZJ/V4bDjjKxtnJFoNCCME7nl/8MGglyhUt4MOPmegGjs2ovBssuPc
 67+3chMGmSKsXfrlnA7XUl4lr0zX4p/d226gUqyj3r2hKa6Qo3VXlVNwbeYllr8zdKjlZ
 liJXWFWlQsEIe56XHKjfaE+FM/OzO35vgbCJSwSEzCaFNIC+3qng7V8COr4vfXB/ilg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790867302;
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
 bh=cgDmdDuHxPyizgQ4CUwCsKTOFOYm/sIuZQS3CvqjYjA=;
 b=pSn4IHdLtrOo/EdTFLLyXaGeTEdVkuS+flJaQ/lMnzqqTsJzIRiHLlLC0LpKaqmeshxR
 rB8IJwU0QF8G7ejWIuI0xfBDiORRx3y+8+Y1/ZoEQt8xGVvn8HNuaATM6e8j20E3yPGRL
 MCTglr2+18IK+DeNcrUTtaFQDdjBKG5p4BizQR7FXd95i8CaITKdg2/jVte5wXX8wD5gB
 7tb3/eneVqwG8QJKQmy2UrFTK4PFapsnUotznnT9Pu6MML3slPr7OKxXdx/zhzU152TA8
 5egLVaGsVQM8kqlMgPTH0c+ejiF0sqORevE9sL4GxvloaWE2FxOCR1HM64/mVb/E8rg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UCyFQsih; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UCyFQsih
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4D006081D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790867302; x=1822403302;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cgDmdDuHxPyizgQ4CUwCsKTOFOYm/sIuZQS3CvqjYjA=;
 b=UCyFQsihHxPzYNfiul2jp1VyiGi9Rv6r0gLs0z8+d8B8YlViBysoToc4
 hN9X2e35Rsr6+yjqEqjcwuHjgvHQEJn4hng5peJpRR7k1Hnpv8AH4k63J
 KivBc3ySy52qrtf6pNQhhn0YpMK3aQlNMlqANIJwXklc0QNKBBWT7rto9
 7bdJkLMB+im6IAC/4dgMlo6VyJnyZAmxN0j0/MqgIQ9OwvKGBUFwaQXHG
 vk33W9Xpm4SpV69UAZ5lRzcJ2UqPZpfjy6OMvnf7a6Vio5nsGj7U+jYVU
 dNJ8/IfEHOUEY9tkYUismm1Jth70RifLRUsNs7WxeoY3PIPdrpdcVrdbt A==;
X-CSE-ConnectionGUID: dJt0WJI/R2m2ztMXjSB70g==
X-CSE-MsgGUID: 2BYdUtFURFCav+WNmsX1oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95436008"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="95436008"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 08:08:18 -0700
X-CSE-ConnectionGUID: kAmYSvw+SMuVEf0X2Ii8ug==
X-CSE-MsgGUID: nkatFKBcSNGF9sC2ZqzQJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="313976018"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 08:08:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 08:08:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 08:08:14 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 08:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No5DjPW68NZiQG49m39g+yW0ozWlJFe32C5p1rYTnUmqM6OwEhv3yhsdno76ivyfjShLI7WooFYHtDpbfcHQ0BIa3eW0WsJMl0luHunU90zFgbk9FLtZR3En0DbP4x3haXjIQtU1nX18dghctU90IaFHZ7wGr2U9uNMFLs6wCre2dsKZ3PA+BdH6sXyOTeyzycm6sbSt4VOAdDRfbtaNE6WShgdnnm3NDuBPfiqX4nMe5kTJV0ZvjyxTZgdqMf3xbjWBhN0DDu5ap060DW1dx8X2wrRGnfAacjtKmdKl8Sblg/Ax7YO8UTqtqwkN6gGSY9uCZ5OcHnAqhyEJz5otew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgDmdDuHxPyizgQ4CUwCsKTOFOYm/sIuZQS3CvqjYjA=;
 b=CJkgSLyPDeTtm8xWj+lEb9sic6VbaX5jCnYep0aBLn94WsUnRkMjEfDqFbqZ/+4viuLdqgAoeOYO8FhbIeepimy4dEKiF/EmtqzL5fgZ7hlm7o5osR89zVO2EKmVzLeGLge4mqC2zW9XLf6tdGli4v4x4cvIYTdS9G6qgyLkollLpW8pWEyiQkage+fc5NC6hJQzIHvyPmpQOOPeOSyNC0V7IpJOQJRzG3FUeIEyd3g6/aSeNDngDqJimq9sNiecfAZZQmRoPbcceo0Fo9ndkswnhryVx7JLhw+JHCPOa7BTOETqdsEN0jjC8/qOTSGZx4mw4r/NnvKy8/uMdMYXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:08:07 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 15:08:03 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH iwl-net] ice: Skip PTP timestamp processing during release
Thread-Topic: [PATCH iwl-net] ice: Skip PTP timestamp processing during release
Thread-Index: AQHdUZti+21oTQnlr02U1Z+At7h1UbboxNqAgAAByzA=
Date: Thu, 1 Oct 2026 15:08:02 +0000
Message-ID: <MW4PR11MB68643FA37C8DDF40B7A83863808A2@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20261001115232.13681-1-sergey.temerkhanov@intel.com>
 <20261001144918.531AD1F000FF@smtp.kernel.org>
In-Reply-To: <20261001144918.531AD1F000FF@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|SN7PR11MB6654:EE_
x-ms-office365-filtering-correlation-id: 1bc7742b-bb67-40d8-6793-08df1fcdca28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|4143699003|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: KeXB4flAIw0Op4ysZLC9+ZuIlE4qBNRAp0dQ7qFWmRuqA2xmX4nzBckSIzB4zYY9jDo2cYEl31g4euPsHOhje2M6+nsucuXI6dPKwCmHb1wNreMRljbv7rSx1eWuWa09uf+yjHdLM/Jt/vRfdE+03OZLoK4xualkQGlLuYRJDNdCozFln6/EBDxKG4dkAUmO13Uj6bRDL0wphqHO+n2m537rPdENXwuTAEC//IHLQytQlo4c1yqYJGquwi9MKw9EUeBfK1w0hC+l1XafmLk31KXzmO23fbQ0RT27w5SkFPSGUaDxmBz3Zx9K5awa/Vbey5Xalzo2D2mMcy18g7QnIW38uVe8Qt4jAs/EwYqpNRK3DF46xqzAFvbCpRqr5f3AfT+9bxGYBxaQ1rf99M++g/k46Y3shvV2FAtsm6T65uyxmMLL+qDYfey/uNQwWST60dsXWaEO7HbCokv7l99ubHJs/XROrPHMbGHXZlCMxoAn0JjNwG5cVabSZpqTSmCI1FFtebWA7PECKXI/vD1PBYjc5/pHine0mctkq2dQ1BIlon9anVttXey6PBb/J5FRu6WJE/247ldhu1OCmJNXliPfmCd2/+YsOHlDYd5v8A/cvf58QjoYi5bRtMbwt5VvKdCMriX7jsKWQl2rdkyErRHNq+9Cld4CTLvd2d4FM2M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6864.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(4143699003)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkhvVGZhMndIRE8vbUNYQXlyandLcU1XK1oxdGlPMnVZOVBvV2pBRlBjVDFw?=
 =?utf-8?B?czh0L05tVnY2YVRsTTNCTXVqbC9vaVdmK2M3NURHa2JCRmZTREcxNHFEUEtO?=
 =?utf-8?B?SkMxbWhNdHZGY0k2bDVoZFJIUUhhM0Jtc1hTVlRPTU95dlFGRzJRYThBalU5?=
 =?utf-8?B?dEo4ZHRqbGRFQzVod1lNNlpBK1RxRUwrMEptTHFYQ2tFc1JvNExIRGhxaVJq?=
 =?utf-8?B?YWlqYnA5NGc4b0toNGdJZUxkSVdTTUIwS0wwMkNQQ1lIQWc0dXZjVmN3UE5o?=
 =?utf-8?B?UkVvYkhPQ25Pb0k0OTF4VGhPS1BpUFVzVFZ6U2Ixa2JpUHlQOGhWNzNjRXFX?=
 =?utf-8?B?S0JuaHFacEh1NTYxU2pmeE5rWG4weXlzN0xmNUxoQ1RqZlV3TjhCZFRXaURx?=
 =?utf-8?B?RkhPVjl3c28rbDlGcThVT1plUzREdjFSZ0JNeDJFWHdJV1ZHeHJKcFRwN29L?=
 =?utf-8?B?K2YvVFA5dzEzV3d1bmdEMjNiS1BKVnhiZlFQNnVWeHNyMi9MRmU4V1hkeUgx?=
 =?utf-8?B?OUdsUWpSSXlZa2UyYTlSTVpIU01Xa3RONWNOUGcydkJwa2N2VHhmZnZ5NkN6?=
 =?utf-8?B?WFNXaFFEUHlCNHRQMWM2cHdoU1BZMG9TdUxydjNpTjhaUEY0S3UzdnY3V0pa?=
 =?utf-8?B?M0dUdzRRYkZzVDh6SEhKRFczTnJlQmlRYVVsdGFKdFg1ODk1VldtaDgrQWJG?=
 =?utf-8?B?S2p6ODhkU0dkVENJemRHQlU1cEwrUlNkaWtIYndQQWRIeXRldk8xUXlOcVMw?=
 =?utf-8?B?cjcxKzVKaXQ2dFB0Vlo0RjdSWjBUMXRrbFhIWTZManNub1E2UklET3phR0g4?=
 =?utf-8?B?bjZiWGRFRWNhQWROTWp2Z3RrVTZ1aUlpRnd5bStXOHZ6S3kyN0VpVlA5ZjQ0?=
 =?utf-8?B?Rlg1YVpteVdUSDc4NjJJMWNSMmJBMzY0U2ZuRlh0eFVUNFFpYnVRekNvczJv?=
 =?utf-8?B?R3gwREJJWDFwZEVBQmgxU3JieFpVN2xEbVBaSDF0bVJJemxPUTJiQi8zQWho?=
 =?utf-8?B?VWJURXlFUUFudUFmN3dnL0tnZlVrU2tXMkM4T1RVVDNhVFRNMHZkY3pWZ01v?=
 =?utf-8?B?NGhONktOWTBnOVp6QWJWTGpiWXpDRnFqd25ycGZOREF4UWg5YjNrSzg4Y1VC?=
 =?utf-8?B?WHFuZUFLVHVMNkc4U0RoWlBFVkpjNGRRZmdpakdTREFFUGx5Q05jK2FXK3lL?=
 =?utf-8?B?YlhGRGFGU1BCVnQ0Z2xjTnNvVnQyZ1FjWjhoejdRUUFTUVpuNndNUEw4UzBa?=
 =?utf-8?B?NjR4bmdpS0FjTEFaeW5JSkdlbmtaTVNBOXZjU09CRTBaWGN6SlFqbXRnUU1I?=
 =?utf-8?B?bmcxT1JLL0ljNFFsRmdDb1FzekV0d3Z3WHk5bTNlcDgzYUI3MkNPUmFKd0VE?=
 =?utf-8?B?bzFFbDRTejEvSzV3Y3hUcmMra1ZFeXVON1dhaXZpWkF0Ymdocnh6dUFXQzQy?=
 =?utf-8?B?ZnFZNWMvS29PL3BnVHlFRGM3b2dFcXFVdTZyOWo2cnBBTUJSaWxoVzdkYUVS?=
 =?utf-8?B?OThBeHdsWXlwLzNFTHpGOTVVTjlFSDdFY0tOTERyV1lSbGMwejQ1T091VFFD?=
 =?utf-8?B?bSt0V25hUDNMRFYrZ3ZPOFpCTEhKbHMvVGgyV2pKNGlWZXczQjd5SVJhdVdW?=
 =?utf-8?B?dlVLTWg0RlFrelk5RUZwdzRyN0huMHBWa3Z5VDQ5M29na2NoRzN5bjg2QU1r?=
 =?utf-8?B?OVBza3pDdndONkRkbU9DVE1CazZBS3ZkK0kzZGpYUmFFN0dqSGVxZWo2YnU1?=
 =?utf-8?B?aEdibDR1d2lTSmlPamhHcU9BMXJsckd6TzNOclNCNVpGcStpSmpUMHdiVzdu?=
 =?utf-8?B?Qlg4SFo1ZUV4cUZVbC9sa044Q2MxWTRsck9uaExTVHl0aEFoNk9VNmI1RlE4?=
 =?utf-8?B?NlRvLzJWT2lGd3FFNk1aR3hhTk9DMnhjMHR5b3A5MDhPSmdHNWxTMFJjaFJH?=
 =?utf-8?B?MXo3YlpvUEozMHdFS2swNGx5VHVvUXhCSmRhMkZQN0lzKzBvY3VtQUlDM1U0?=
 =?utf-8?B?cmVpRlAxdURGZC90T1NFZnMvRzJoSStxM0gxYjRKdDVWTmp6ODhrVUZST1pW?=
 =?utf-8?B?TXhWeEFSNFdwOUcyUFNhMEFJSG9HTGcybTI4TVRJeElRM1I5bHNEbk5mUzRK?=
 =?utf-8?B?Rldic2xCa1FSWWFYd2o3WEZhVExLaTJ6ZUd4UXRuVDZTL3luU1hYYkJ1OUh3?=
 =?utf-8?B?ekVOTDdMQlVmUGNydXVUbS9JKzRxTWROT2tINkJwU0VwdGZuc0FRY3hFbHVM?=
 =?utf-8?B?VkQvRHhVTFBRZnIvbkdORkZ0NDdMbEh4NUp3V3I4bndMemdQSFlQWVcvcHNp?=
 =?utf-8?B?ZktHTXNxK3crZHg0LzhpcFRLbzV6Y1lXMXhIODNyRzE1ZWYxdmNYSTdyOWVq?=
 =?utf-8?Q?2wJ/JGmX//HInly4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yFhj8Vb3Umdd1pJqGU/OiWWJpj4k0BgqCPvAetwIhhSvmEwqIjzeHzlboEu12ZstTTSosxpPuSSxVN+jItB3W9WSIh8ttFOERC4HTQuJ3Jimbx49QBNtU6VXTg28WF3h0faUgAbPxAdnhpeMN+WZQakTXs4s0lofDPetrgauHbBOplj89vlu11O/nj0rp2iyVRokyMoz3+6v6ieXT8RWyOcHCpJDO8JOcJI1I+xJQrJbRlG4+j4ZMut4Ychtkzq9XMjka8ToWyUn5H757L3oWfRli+7sH2bd0sw/Md2a5nt7hzoam1d/7S79DY0h0qEz347VhMSa5+1t8EsUbNi/Lg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc7742b-bb67-40d8-6793-08df1fcdca28
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 15:08:03.0100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bmoxsic6XaC8TySS/IUO9Zf3dqMYHhIUaW4ptGsxHtkdG2x7OQok//JeQvhndV6DSGXaZYGfvDmjj85cbpLX3Xqo4VtnHfIJOa77cp0qhtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9i
ZXIgMSwgMjAyNiA0OjQ5IFBNDQo+IFRvOiBUZW1lcmtoYW5vdiwgU2VyZ2V5IDxzZXJnZXkudGVt
ZXJraGFub3ZAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBpd2wtbmV0XSBpY2U6IFNraXAgUFRQIHRpbWVzdGFt
cCBwcm9jZXNzaW5nIGR1cmluZyByZWxlYXNlDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29u
dHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKQ0K
PiB0byBjb25zaWRlcjoNCj4gLSBbSGlnaF0gaWNlOiBlYXJseSByZXR1cm4gaW4gaWNlX3B0cF9w
cm9jZXNzX3RzIGNhdXNlcyBpbmZpbml0ZSBpbnRlcnJ1cHQgbG9vcA0KPiAtLQ0KPiANCj4gY29t
bWl0IGJlZGI4MmQ5YTMxZTczNGMwYzUwN2QzNTAzZjhkNTYzYTkzMjZiY2YNCj4gQXV0aG9yOiBT
ZXJnZXkgVGVtZXJraGFub3YgPHNlcmdleS50ZW1lcmtoYW5vdkBpbnRlbC5jb20+DQo+IA0KPiBp
Y2U6IFNraXAgUFRQIHRpbWVzdGFtcCBwcm9jZXNzaW5nIGR1cmluZyByZWxlYXNlDQo+IA0KPiBU
aGlzIGNvbW1pdCBza2lwcyBQVFAgdGltZXN0YW1wIHByb2Nlc3Npbmcgd2hlbiB0aGUgaGFyZHdh
cmUgaXMgbm90IGluIHRoZQ0KPiBJQ0VfUFRQX1JFQURZIHN0YXRlLiBUaGUgaW50ZW50IGlzIHRv
IGF2b2lkIGV4ZWN1dGluZyB0aGUgdGltZXN0YW1wIGNhbGxiYWNrcw0KPiBvbiB1bnJlYWR5IGhh
cmR3YXJlIGFuZCBoaXR0aW5nIHVuaW5pdGlhbGl6ZWQgc3RydWN0dXJlcy4NCj4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gPiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gPiBpbmRleCBiMmRl
NzYwNjVmNDZkLi4wOTVkZmUyMzE0MGQ1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3B0cC5jDQo+ID4gQEAgLTI4MTUsNiArMjgxNSw5IEBAIHM4IGljZV9w
dHBfcmVxdWVzdF90cyhzdHJ1Y3QgaWNlX3B0cF90eCAqdHgsDQo+ID4gc3RydWN0IHNrX2J1ZmYg
KnNrYikNCj4gPg0KPiA+ICB2b2lkIGljZV9wdHBfcHJvY2Vzc190cyhzdHJ1Y3QgaWNlX3BmICpw
ZikgIHsNCj4gPiArCWlmIChwZi0+cHRwLnN0YXRlICE9IElDRV9QVFBfUkVBRFkpDQo+ID4gKwkJ
cmV0dXJuOw0KPiA+ICsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gQ291bGQgdGhpcyBlYXJs
eSByZXR1cm4gY2F1c2UgYW4gaW5maW5pdGUgaW50ZXJydXB0IGxvb3Agb3Iga3RocmVhZCBzdG9y
bT8NCj4gDQo+IElmIHRoZSBQVFAgc3RhdGUgY2hhbmdlcyB0byBJQ0VfUFRQX1VOSU5JVCAoZHVy
aW5nIGRyaXZlciB1bmxvYWQpIG9yDQo+IElDRV9QVFBfUkVTRVRUSU5HIChkdXJpbmcgcmVzZXQp
IHdoaWxlIHRoZXJlIGFyZSBwZW5kaW5nIHRpbWVzdGFtcHMsIGl0DQo+IGFwcGVhcnMgdGhpcyBl
YXJseSByZXR1cm4gYnlwYXNzZXMgaWNlX3B0cF9wcm9jZXNzX3R4X3RzdGFtcCgpLiBUaGlzIGxl
YXZlcw0KPiB0aGUgdHgtPmluX3VzZSBiaXRzIHBlcm1hbmVudGx5IHNldCBzaW5jZSB0aGUgZ2Fy
YmFnZSBjb2xsZWN0aW9uIG9mIHBlbmRpbmcNCj4gdGltZXN0YW1wcyBpcyBza2lwcGVkLg0KPiAN
Cj4gSWYgdHgtPmluX3VzZSBpcyBub3QgY2xlYXJlZCwgaWNlX3B0cF90eF90c3RhbXBzX3BlbmRp
bmcoKSB3aWxsIGNvbnRpbnVlIHRvDQo+IGV2YWx1YXRlIHRvIHRydWUuDQo+IA0KPiBPbiBFODMw
IGRldmljZXMsIHRoaXMgY2FuIGNhdXNlIGFuIGluZmluaXRlIGxvb3AgaW4gaGFyZCBJUlEgY29u
dGV4dDoNCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmM6aWNl
X3B0cF90c19pcnEoKSB7DQo+ICAgICAuLi4NCj4gCQlpZiAoaWNlX3B0cF90eF90c3RhbXBzX3Bl
bmRpbmcocGYsIHRydWUpKSB7DQo+IAkJCS8qIFByb2Nlc3Mgb3V0c3RhbmRpbmcgVHggdGltZXN0
YW1wcy4gSWYgdGhlcmUNCj4gCQkJICogaXMgbW9yZSB3b3JrLCByZS1hcm0gdGhlIGludGVycnVw
dCB0byB0cmlnZ2VyIGFnYWluLg0KPiAJCQkgKi8NCj4gCQkJd3IzMihodywgUEZJTlRfT0lDUiwg
UEZJTlRfT0lDUl9UU1lOX1RYX00pOw0KPiAJCQlpY2VfZmx1c2goaHcpOw0KPiAJCX0NCj4gICAg
IC4uLg0KPiB9DQo+IA0KPiBPbiBub24tRTgzMCBkZXZpY2VzLCBpdCBjYW4gY29udGludW91c2x5
IHJlLWFybSB0aGUgT0lDUiBpbnRlcnJ1cHQgZnJvbSB0aGUNCj4gd29ya2VyIHRocmVhZCwgY2F1
c2luZyBhIGt0aHJlYWQgc3Rvcm06DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX21haW4uYzppY2VfbWlzY19pbnRyX3RocmVhZF9mbigpIHsNCj4gICAgIC4uLg0KPiAJ
aWYgKGljZV9wdHBfdHhfdHN0YW1wc19wZW5kaW5nKHBmLCB0cnVlKSkgew0KPiAJCS8qIElmIGFu
eSBuZXcgVHggdGltZXN0YW1wcyBoYXBwZW5lZCB3aGlsZSBpbiBpbnRlcnJ1cHQsDQo+IAkJICog
cmUtYXJtIHRoZSBpbnRlcnJ1cHQgdG8gdHJpZ2dlciBpdCBhZ2Fpbi4NCj4gCQkgKi8NCj4gCQl3
cjMyKGh3LCBQRklOVF9PSUNSLCBQRklOVF9PSUNSX1RTWU5fVFhfTSk7DQo+IAkJaWNlX2ZsdXNo
KGh3KTsNCj4gCX0NCj4gICAgIC4uLg0KPiB9DQoNClRoZSByZXBvcnRlZCBpbXBhY3QgaXMgYXBw
YXJlbnRseSBhIGZhbHNlIHBvc2l0aXZlLCBidXQgaXQNCmRpZCBwb2ludCBhdCBhIHJlYWwgKGlm
IGJvdW5kZWQpIGdhcCBvbiBFODMwLCB3aGljaCBpcyBnb2luZyB0byBiZSBhZGRyZXNzZWQgaW4g
djIuDQoNCldoeSB0aGUgZGVzY3JpYmVkIGZhaWx1cmUgbW9kZSBkb2Vzbid0IG9jY3VyOg0KDQox
LiBUaGUgcmUtYXJtIGNvbmRpdGlvbiBpcyBub3QgImluX3VzZSBpcyBub24tZW1wdHkiLg0KICAg
aWNlX3B0cF90eF90c3RhbXBzX3BlbmRpbmcocGYsIHRydWUpIGdvZXMgdGhyb3VnaCBpY2VfcG9y
dF9oYXNfdGltZXN0YW1wcygpLA0KICAgd2hpY2ggcmVxdWlyZXMgdHgtPmluaXQsIHRoZW4gaWNl
X3B0cF9pc190eF90cmFja2VyX3VwKCkgKHR4LT5pbml0ICYmDQogICAhdHgtPmNhbGlicmF0aW5n
ICYmIGxpbmtfdXApLCBhbmQgZmluYWxseSBiaXRtYXBfYW5kbm90KGluX3VzZSwgc3RhbGUpLg0K
DQoyLiBUaGUgcmVsZWFzZSBwYXRoIGRvZXMgY2xlYXIgaW5fdXNlIGFuZCBkb2VzIGZyZWUgdGhl
IFNLQnMuDQogICBpY2VfcHRwX3JlbGVhc2UoKSBzZXRzIHN0YXRlID0gSUNFX1BUUF9VTklOSVQg
YW5kIHRoZW4gY2FsbHMNCiAgIGljZV9wdHBfcmVsZWFzZV90eF90cmFja2VyKCksIHdoaWNoIGNs
ZWFycyB0eC0+aW5pdCB1bmRlciB0eC0+bG9jaywgZG9lcw0KICAgc3luY2hyb25pemVfaXJxKHBm
LT5vaWNyX2lycS52aXJxKSwgYW5kIHRoZW4gaWNlX3B0cF9mbHVzaF90eF90cmFja2VyKCkNCiAg
IGNsZWFycyBpbl91c2Uvc3RhbGUgYW5kIGRldl9rZnJlZV9za2JfYW55KClzIGV2ZXJ5IHBlbmRp
bmcgU0tCLiBPbmNlDQogICB0eC0+aW5pdCA9PSAwLCBwZW5kaW5nKCkgaXMgZmFsc2UuIFRoZSB3
aW5kb3cgaXMgc2hvcnQgYW5kIHNlbGYtdGVybWluYXRpbmcuDQoNCjMuIFRoZSByZXNldCBwYXRo
IGlzIGFscmVhZHkgZ3VhcmRlZCBhbmQgaXMgZmx1c2hlZCBvbiByZWJ1aWxkLg0KICAgSUNFX1BU
UF9SRVNFVFRJTkcgaXMgb25seSBzZXQgYnkgaWNlX3B0cF9wcmVwYXJlX2Zvcl9yZXNldCgpLCB3
aGljaCBydW5zIGZyb20NCiAgIGljZV9wcmVwYXJlX2Zvcl9yZXNldCgpIGFmdGVyIElDRV8qX1JF
USAvIElDRV9SRVNFVF9PSUNSX1JFQ1YgaXMgYWxyZWFkeSBpbg0KICAgcGYtPnN0YXRlLiBpY2Vf
bWlzY19pbnRyX3RocmVhZF9mbigpIGFscmVhZHkgZG9lcw0KICAgImlmIChpY2VfaXNfcmVzZXRf
aW5fcHJvZ3Jlc3MocGYtPnN0YXRlKSkgZ290byBza2lwX2lycTsiIGJlZm9yZSBjYWxsaW5nDQog
ICBpY2VfcHRwX3Byb2Nlc3NfdHMoKSwgc28gdGhpcyBjb21taXQgY2hhbmdlcyBub3RoaW5nIG9u
IHRoYXQgcGF0aCBkdXJpbmcNCiAgIHJlc2V0IC0gdGhlIGRlc2NyaWJlZCBrdGhyZWFkIHN0b3Jt
IHdvdWxkIGJlIHByZS1leGlzdGluZy4gT24gcmVidWlsZCwNCiAgIGljZV9wdHBfcmVidWlsZF9v
d25lcigpIGNhbGxzIGljZV9wdHBfZmx1c2hfYWxsX3R4X3RyYWNrZXIoKSBmb3IgZXZlcnkgcG9y
dA0KICAgb24gdGhlIGNsb2NrLg0KDQo0LiBUaGUgb2xkIGNvZGUgZGlkIG5vdCBnYXJiYWdlLWNv
bGxlY3QgaGVyZSBlaXRoZXIuDQogICBpY2VfcHRwX3Byb2Nlc3NfdHhfdHN0YW1wKCkgcmV0dXJu
cyBlYXJseSB3aGVuIGljZV9nZXRfcGh5X3R4X3RzdGFtcF9yZWFkeSgpDQogICBmYWlscywgYW5k
IG9ubHkgcmVhY2hlcyBjbGVhcl9iaXQoaWR4LCB0eC0+aW5fdXNlKSBmb3IgaW5kaWNlcyB0aGUg
UEhZIG1hcmtzDQogICByZWFkeS4gRHVyaW5nIHRlYXJkb3duIG9yIHJlc2V0IHRoZSBQSFkgcmVh
ZCBmYWlscyBvciByZXBvcnRzIG5vdGhpbmcgcmVhZHksDQogICBzbyB0aGUgMi1zZWNvbmQgc3Rh
bGVuZXNzIGRyb3AgbmV2ZXIgcmFuIGluIHRoZSBvbGQgY29kZSBpbiB0aGVzZSBzdGF0ZXMNCiAg
IGVpdGhlci4gVGhlIGVhcmx5IHJldHVybiByZW1vdmVzIGFuIHVuc2FmZSBQSFkgYWNjZXNzLCBu
b3QgYSBndWFyYW50ZWVkDQogICBjbGVhbnVwLg0KDQpUaGUgdmFsaWQgcGFydDogaWNlX3B0cF90
c19pcnEoKSBoYXMgbm8gcmVzZXQtaW4tcHJvZ3Jlc3MgY2hlY2ssIGFuZA0KaWNlX3ByZXBhcmVf
Zm9yX3Jlc2V0KCkgZG9lcyBub3QgY2FsbCBpY2VfcHRwX2xpbmtfY2hhbmdlKHBmLCBmYWxzZSks
IHNvDQpwdHBfcG9ydC0+bGlua191cCBzdGF5cyB0cnVlIHVudGlsIGljZV9yZWJ1aWxkKCkuIE9u
IEU4MzAgdGhhdCBsZWF2ZXMgYSBib3VuZGVkDQp3aW5kb3cgd2hlcmUgdGhlIGhhcmQgSVJRIGNh
biByZS1hcm0gUEZJTlRfT0lDUiB3aXRoIG5vdGhpbmcgY29uc3VtaW5nIHRoZQ0KdGltZXN0YW1w
cy4gQm91bmRlZCwgbm90IGluZmluaXRlIC0gYnV0IHBvaW50bGVzcy4gSSdsbCBhZGQgdG8gdjI6
DQoNCiAgICBjYXNlIElDRV9NQUNfRTgzMDoNCiAgICAgICAgLyogRTgzMCBjYW4gcmVhZCB0aW1l
c3RhbXBzIGluIHRoZSB0b3AgaGFsZiB1c2luZyByZDMyKCkgKi8NCiAgICAgICAgaWYgKHBmLT5w
dHAuc3RhdGUgIT0gSUNFX1BUUF9SRUFEWSkNCiAgICAgICAgICAgIHJldHVybiBJUlFfSEFORExF
RDsNCg0KICAgICAgICBpY2VfcHRwX3Byb2Nlc3NfdHMocGYpOw0KDQpUaGlzIG1ha2VzIHRoZSBy
ZS1hcm0gZGVjaXNpb24gY29uc2lzdGVudCB3aXRoIHRoZSBwcm9jZXNzaW5nIGRlY2lzaW9uIGFu
ZA0KbWlycm9ycyB0aGUgZ3VhcmQgaWNlX21pc2NfaW50cl90aHJlYWRfZm4oKSBhbHJlYWR5IGhh
cyBmb3IgdGhlIG90aGVyIE1BQyB0eXBlcy4NCg0KPiANCj4gRG9lcyB0aGVyZSBuZWVkIHRvIGJl
IGEgd2F5IHRvIGNsZWFyIHR4LT5pbl91c2UgYW5kIGZyZWUgdGhlIGFzc29jaWF0ZWQgU0tCcw0K
PiB3aGVuIGJ5cGFzc2luZyB0aGUgdGltZXN0YW1wIHByb2Nlc3NpbmcgaGVyZT8NCj4gDQo+ID4g
IAlzd2l0Y2ggKHBmLT5wdHAudHhfaW50ZXJydXB0X21vZGUpIHsNCj4gPiAgCWNhc2UgSUNFX1BU
UF9UWF9JTlRFUlJVUFRfTk9ORToNCj4gPiAgCQkvKiBUaGlzIGRldmljZSBoYXMgdGhlIGNsb2Nr
IG93bmVyIGhhbmRsZSB0aW1lc3RhbXBzIGZvciBpdCAqLw0KPiANCj4gLS0NCj4gU2FzaGlrbyBB
SSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMDAxMTE1MjMy
LjEzNjgxLQ0KPiAxLXNlcmdleS50ZW1lcmtoYW5vdkBpbnRlbC5jb20/cGFydD0xDQoNCg0K
