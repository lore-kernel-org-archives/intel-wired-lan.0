Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57931C88E53
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 22:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1352F60614;
	Fri, 11 Sep 2026 22:12:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSwRVC2dJyLv; Fri, 11 Sep 2026 22:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6853D60617
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789164771;
	b=WJR9b/2Udjwij6ibRjHSuStOyKKyglgVpN0Yul5QKR6f8xkz+AmOdQSdxke09khxj431
	 BCx2iinr4QZ7Mlqfvtuvz82YJJLTUodDgUJSgcYNzUIuWpiD1lQPjWwO25PkeG9p3labK
	 cBK2H7PfNI477Rw5sHCZgOcZS9hHRsNR7ZWssj4SZ6u8z5Y8HnjXw9Z4KWZy+GrQ4HKd0
	 x9mu+ubzIcbD3Jb2SgrVMILwY5/B4Er4GS8aaPrq69jCuyBYcNXabSCRyDi1Dl3GOuXRU
	 Jhf9dCl10o4b+cvsXrQSbsGzVNpus9sXdDlS3J02DsqXuDN1l+H4VPNhFDdyZ6PPitA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789164771;
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
	bh=OPpWPR3h+Zy3S9RnL5pKRcIJNA8NQqPHwKjUwdNeux0=;
	b=HKRx3KpbL3Ir0q0ICskCeUnvy015QUeWiQUehKQ4jzfnParwLo+HB8lnjL3fobd8qxqd
	 prfYhLwYwUEYWGJBfuSKfHxGIqfm5qYjtXpapAAVQs1HPexu1g+UZhTP9TmFngI6RiZHj
	 yiSJ0C/LbP8dNEJNR02zOTideHFmNFX+07x7OK3vuFEs/6qaw5CI5J3TToeLtXB2plJaI
	 /uo7BuFYts5WUoo/lOryOmx/+ZV7t3iBpwn/iePJr5j5/IJGcJAt8skaFDC34u0lnGFjN
	 Xd1DJ+zarC4rBd719gZBaS52JXLsj305V+62IuOh0h1O/Hy8JUeN0IId3Z23dh748Lg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789164771;
	bh=OPpWPR3h+Zy3S9RnL5pKRcIJNA8NQqPHwKjUwdNeux0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JuBtDvol7j3h3KwTFxzC9SD3KFI82V/+ZRdx4NDbYlsbzw/8+qfn79apxJhB52evA
	 fYiA9EQwMBZSJ+tkqDIN6t3Yl/oYS7AzDqoQZuWz3Ttmc6XCKgUhsnKGCka6dKS3nQ
	 xhlFFEKLz6iXMGc8Gv7GdAbZvTOgKOi9CZMyAyyl295jraxsBt5qhtPgs+OTfsifZv
	 EZk/Qv1cDiTmX1QK3I95EQ1p96TLCn1E0v0HDn1uhxnNjOE4nOutQSvcfzQxj/1URB
	 23MdQI2U1fPOuCUFUBMlvjMgxq4a0APNfMpBMFmMzZ+GBhA3JODwvqsXfaQwPeynk6
	 KPX4SW0HhNVAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6853D60617;
	Fri, 11 Sep 2026 22:12:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 687DF2E3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5AE0140061
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JZhmJoYykEr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 22:12:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D1713400AE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789164767;
 b=a1lAD08HOk21CqrsSAiQsL6eRH8p1tsTU1Kvr+ev8haTa6fOOBOwzoKWrDkRg1w9SU1M
 X+5jfw4yXOG4w+GVoD8nGUQhOUFH6ESTeA+spb1Za7LrFXobB6rb+dPnmPXCU9tVDRp64
 KBX5PJwDSgSjOpI3r7wLC1H8rXZF8NRXYH1ZJRDylkjmAb0fDzxDrmwF2uxdBkmIHTohc
 6zo46J74KRdvCeY9h2oF7qHytwFlhmvrQsnWwFtB9rK/IuM3O+834snsW2C93gMHYI0eQ
 ZS00EB325sP98TzRT3RuoFpXjvrRgs7ik112syayvnLfqbu56gyuZk2FIJUMOGzZgFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789164767;
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
 bh=OPpWPR3h+Zy3S9RnL5pKRcIJNA8NQqPHwKjUwdNeux0=;
 b=rEHt8ErgxmY9qls9B+1tKB6M1iVp6xoXDn+2h2eQjXZHDZbqiS6HCH0L4aZaP7UT4WCa
 utvyC5/Q9vKkY2i3p7WSjfZ9ewt9svAOvJ/PoGn5TeBPBxH5oE/IQcvyROKIsc5pSbslh
 aJE0RkS9Z2qM6LKEuPjzcqQmzwfjB4iFP+QIN76ItzG00htxvEuto66SNKcYpoFtmMgPc
 Fv4bGaakiViq3cVOu2nHXJFQ69sEcVvwbn6ewc7lDLrdkhspshfnypy8DHg5nkhZc1rOs
 b4T8bLs8OEgDnfrkdgCBbiroUOlc7LLhbS4pKquRN7UEPa7Kivjai+0E6L78uqkv0lQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Uxs0q81F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received-SPF: Temperror (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Uxs0q81F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1713400AE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789164768; x=1820700768;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vfNwfLLSfUYTidjYV6wJYdWs5UeaeRXIAQs2axnm/2A=;
 b=Uxs0q81FDCd5m+ORx8RtkRs9SNm9vvKb9MI167L0t/l6FEvIcmOLIUex
 g3F750CI+kY+9BY3zCdT9TYow1HoI3FlcUfdiDtRGwuHAHbQSEuPJRKj7
 bzDDL3Ik9UJEnJl9GSvoZ1j7haRsHKY1sG8HFpLmT8gdyUa0aFwVwK0+t
 qTGkEg3Vnb7p6beKP6W1+Ajn86oemAlKBzBEAVLpZ8MKacWzn4nolcNBt
 B9fc697UrBh4WUpG8jwaH8nBKmqGVnvFeRX5jl3O/piItuIwhJRxR4hCo
 7fhl3Hlfj7dZd0bsJ6YZYr+bB3m7armfya5nGSiJroMO7OhAh38WqITFa Q==;
X-CSE-ConnectionGUID: LkX3R+BVSKSPCf+E83/XFg==
X-CSE-MsgGUID: KpuIgimbSUqBs9N0DcGrvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89472420"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89472420"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 15:11:08 -0700
X-CSE-ConnectionGUID: JHcwptmPTLG68Z+BwwgGYg==
X-CSE-MsgGUID: m6Wd/+wKTW2reqDGAXYUMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="272010249"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 15:11:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:08 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwBXhrM/OdF4H/xdDdZo5gvIN4t3dGpTO2Ef8LW9JMe+7Ir8+6bNk0BT8yNM283KjJ06YKO4uincu9+1+7DPv0D/PIh3aUS6wja5EjO1brCDVBXzajhCWwfINoOZDMq57Qh/4PxGeveIGSGebRRUlfLL0WfWVEuhFkRs5T2MDSG4uXF9uNa3+/Wqa8JePgQuKIBTDUZI3uhWJKxMO0OYFsEYVY6VNixcJadKtVoZxtxCZ8d0nFOYkhzARzYCnn4KI6sB+GdI7LPXw5wHZ8oZim/BsMxf6cp6brNb6vJM+RhYS0SX1g8+UCrxGYj0NwL7wlinFTtTfVglrvT5W+kQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPpWPR3h+Zy3S9RnL5pKRcIJNA8NQqPHwKjUwdNeux0=;
 b=JzezcDHWyjFYmw/+z+cUUZCzcoNWFltgZAjbaYV401iDNU0KitL1l97GTvFyu+03DjHzz4PHrpC4f1jxEHZk/ejy0jDAfvYezO/5E+rIkK9My3SlHdawdh8MJ1hfi+oJsXl/ze7RGheFKCOMaesFTFN0ubR0RPtf1sw8P6Yvohv5U48oMwp2NEgXI814Ks+PENGXrcvC7QDz0HdT7tcd5MgG2zl6iXI+7DSphvjn3VRBrod7QrXHhpLdgqInBiv8K8LGgBWpXDmTFfU6CTuBSPUwV+kY9ZkVjXOOeZSSSXjaDbYgVB56rBpJcRi92HelNhpKAfFiY6/1hYArigEoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:11:04 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:11:04 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 3/6] ice: dpll: Use switch statements to
 handle pin states
Thread-Topic: [PATCH iwl-next v5 3/6] ice: dpll: Use switch statements to
 handle pin states
Thread-Index: AQHdOVgXk5/N9sFWvEmIM3s1zmcjbbbJ/9Fg
Date: Fri, 11 Sep 2026 22:11:04 +0000
Message-ID: <PH0PR11MB752201ECE05556C37ABB6177A0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-4-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-4-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 9ab1fb5d-f5b6-4948-42e3-08df10519270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|3023799007|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: qxCmWg5jQbxmWtbEkhuPkJu1M+zIhd/q3QFLaUo2yfvt6eppiGh8xBYyoOD23VjqKv9fquswqPmOtHDt7181CVtP3pi5kXuJJvkLy1WuWaJKlIpDGxVWWi/zjLuCCrfzvwEd11W0W24KWPm0UB2PSQcS7PLH/gD1Xm+kWTV9HoR0imOE27Uf3iuIw3h2cMw1TWKDyFt46XlM+zMmz5iScUfG5SljTaprhX83PrGp+Y/d+aeWL4yDqYpBdAINkXaz9abj6sfOJm2qTe69cgOe1UUDDq32iNR9YMbOAkavA5AZexUd8BEYG9lYyNPOTlCl4jaVsE6qjrXwvUj1OMcl1n+nHA6gK9q/GmFRFVa4bZxPRV/snWFxo1SeiCe6VmcqDtosmlATfWr+K91MtRAiFE99HPdjKB10N70idCQBvdHQadZ2oWU9uzd3aESglVoL5pUCVzQ25Jo0gDU/50hzALxl2rAJZVlGI4GZThgED98TC4WkC1wCrwZ2fGmJazU1nne0ueXmcIZia6lOsb2bMm9+XexIMAaPSt1kTLiDaISzqGzlFJ8uq0qBKi9cpUI/24QJsQDj25KLLhscPPMJ8UKU8bKgv2WPtS1vl0g+fqjn/3UXuuYBuLz+HY6DGw3sQVACCalL8DpKx2i1sgH2iOEeAk4BLeNZjf3WJMGHqu+J9oQkwlWLwS3d48HuXbYcsB+yRZCFz80HhEaK5CuRtkPo5tS/PzeUYGcUuxzpIy4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(3023799007)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sfOd6AUpUbQ3O+qx5Ce2eSb69glk2Bwn7Sma6mjutIbi7olNv8DtdyMBh62Y?=
 =?us-ascii?Q?WVrxeCkB8B6Pemed0rfzdPKpC5+gCJVu9Z2JqPSI0MgJ8UGeeqiXEQLL2rgJ?=
 =?us-ascii?Q?DXKD1U8/srGoQsTtt64NtMwlDu1HXRqpgBWLrRf0JC6oK6zRf3jjjLAvz+cY?=
 =?us-ascii?Q?aQqkzi/R6oT8j+sbO2W/ldfyoKBMPE+fptWVmHHFa111tQ4xS/PWVJu66fYZ?=
 =?us-ascii?Q?TSI26qFKoZjgdpDCKYiYgOxfLBPv1AGArpS0XUnq0E958XbUdBkVyeHXhgaQ?=
 =?us-ascii?Q?STVGN5Bj10ekh3wkj4nLYYYan90aEWqQm9ERHGa4s4LukYeh3Ey3O9KwuLT0?=
 =?us-ascii?Q?EgtBgQKH/HDBsYI8v/Xo/mUfC7In4RMWkOcPG1nBI10U6IoKvbGgST/72nqN?=
 =?us-ascii?Q?1AtX0qGT4/XLyW5wV3aoSzfKNCLp4NDD1bIPZ9sN59B2vz2eYr+bwiz4YxuI?=
 =?us-ascii?Q?Nhcrh+pA9TZqL5ZHCD8jYd1GqJ419I3r0SXCT9mhLiRTW8n3LFMWeyJ0KzL4?=
 =?us-ascii?Q?mtmTImJWIggy6uY/fypXDYF3FbGq9sN3jaF7SWOKFdfVU58DXZe/tG5hdV6s?=
 =?us-ascii?Q?C9M+0jUcM6seAP4uQxS/fX0/ml1EVcp8DKUsD8h7+AwoZ0Sp0Nah0Ileu6kr?=
 =?us-ascii?Q?T6q/2agP7C3KyDqPUFgyQiVUBX9QGJYz5Uv+BkBN/3LuhB2hJsXw0lMcu6Ql?=
 =?us-ascii?Q?RCF3iEkXBH/7B8TfT54wlxdy0CkaYTJKrBBE2ycS6jmVyVNvlWoy30VlRY3J?=
 =?us-ascii?Q?p8YA36ueWij3fuWBckXMj/0mApklJz08SR5CzAdPaVx372B/fNlS2rkxeBHi?=
 =?us-ascii?Q?GCsQs/lwNmpdo/vZU9h8LaF1HYtB1sfk2iCt4sxwjo9r7vq00gBSfo4Nz98v?=
 =?us-ascii?Q?DCd3wJszPlj20bnPFvI7EQV/b1Imwj1rAHsC6n/YokXtKmNS0GMf+Zghfj6F?=
 =?us-ascii?Q?l0Dm72QCaBLDV72Ur1OSNn4B9SAFV2s3CVqeu64uxfqva78huZZfxT+xSAQQ?=
 =?us-ascii?Q?UG4D9zKSkQFEvRP+++tZ5fFhDS0dWvv9Ua/mg0ZzMWMIVm8AG+mclhsaRS4G?=
 =?us-ascii?Q?1v2+y5IeByGo2HisT8P7Qc5qfrA7lMJHfzhAbp3WKLJ0rYUWWWM57L3edq0x?=
 =?us-ascii?Q?VSXh6n0jn0EgCwXa9X5ljfu6u8vXHPrzJSo2KkcKnsZ7DkhGp2mw5mWVP/TN?=
 =?us-ascii?Q?+nmAT0Vnaz5IXpo8dQGuMzG9P7kWE1N3mJ+zhIP8101nxUnYhmWUB4IsRXP0?=
 =?us-ascii?Q?gUWuDrTr+XvpU3SSXy0SJCN+Q8vE4UaU/5meqG9IortQKU+s72sSZCDzNrbZ?=
 =?us-ascii?Q?4BMpgx9WuUiJ2gxZ1tJ04AUxRzsnd6a7PALpb8SoXqQS0fe1b2OTjFX7TNZb?=
 =?us-ascii?Q?x1cIAzfmoggDp670a7tBN5tAveBU9ERwZKufgwo0Xx29zSrVadZlo3NnQ+Cp?=
 =?us-ascii?Q?CbJNo2NoK8UUpaZrhxTeEwTJCuPP9wo3Dd3mDQ3xsrYFDCA+Cui/AJAtfvgi?=
 =?us-ascii?Q?7os1UtRsBXhTrXMq8i9ZGdPfBJ2JlnneGqzm7mI9jxigqqHllnHjb6Jk315q?=
 =?us-ascii?Q?NipNS+vBJNPawtw4W7bQCXypr/9y0d/7vqGL+O7xTRNQ+2CmjqNK1GEU6dAU?=
 =?us-ascii?Q?njBpXxSCvRY/cIoAohQdO1jGPeqZY+fuDxjWWWEWNpkYIM0Eu1rkzO6eE3JK?=
 =?us-ascii?Q?+ufLaPgoE67hBoCe7ovmvL0t19fpLRHcGdhqwJPuAed1meLLyZV6hVJUAGHF?=
 =?us-ascii?Q?BfjktBrHbQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vjkYXYClfFPPvxTRmXYSlFA1mTCMgA2O7exiuDEMHx/2R5a266X00dDBw8yEBqsyx8Y/+Y7i8bqHFwAiGyxyXSnXPzf6dk1g/kzaTsGeK214MZQnRuUnjbyKOAnDbjjPksdKmBYFtHpwR6rJjbvn6GN9DKIJy0cMZsABpnBGZ5ANp0nYZHXMLMW6DH68GGEFMyw7g0FMcYFC7pBJv0r3LrFHXpnRQCeeyER36G97L++S3jARxorpvOJZ4v3T9zTTgpQ7uZnujAbrvRWhCV2Sn5KGzYSW5Tyh1BjEmnjJ41tKdD+CYyfyTN2tH/vMBinGK8DtnC+f8WI0sIgqREfNiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab1fb5d-f5b6-4948-42e3-08df10519270
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:11:04.4742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odIRno676WJK24LBfqCTtV56IDIGBCrlidJTgM2q3fm08l942caANQ1UhV9Ot+xOOeEOryMP2YDuuF11NWXHRq1WOZ82VG/H+qPe98Rum3s=
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
> Subject: [PATCH iwl-next v5 3/6] ice: dpll: Use switch statements to hand=
le pin states
>
> Use switch statements to handle pin states to make the code more
> readable. This also makes this code more future-proof, should any
> new states appear.
>
> This also changes how direction-mismatched state requests are handled in
> ice_dpll_sma_pin_state_set(). Previously, requesting CONNECTED on an
> INPUT-direction SMA pin or SELECTABLE on an OUTPUT-direction pin would
> fall through to ice_dpll_pin_disable() and return success. After this
> change those requests return -EINVAL without issuing a firmware command.
> Because the DPLL netlink core does not filter pin states by direction
> before calling the driver, this is a user-visible netlink API change.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 72 ++++++++++++++++++-----
>  1 file changed, 57 insertions(+), 15 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
