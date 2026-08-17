Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52714C5B572
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 15:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 176F1606F5;
	Mon, 17 Aug 2026 15:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0NvsoPtQqrD; Mon, 17 Aug 2026 15:55:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11AB1605E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786982155;
	bh=/TaeFIphfV/gLEjwLPwY8Y2yiFTy2RGY5Auxsa34Vlc=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=J7yYDsrItDlodYN5LnlbbO3lXY8VKmjxlea/22meYLTseJbC9jQ03YcIEM7nV3/k1
	 Bdrbt9T/85OQaZzMgkRoGxfL/SUFkUibAytAonUJqDK0SHsThR81RyGvolQ+Pkv7/L
	 aJWtvwXxMPk3U9N0LjcyoYclJTl42uYm/MPV9rmFLQXkc+IJ6AQznZAXP5MPdYOpr+
	 5nwtg/lXO0M2BhBI3og9j09TlY4ElCauQrIPHEgVl/Et63gc86G5nxeyAx3ILGMvkX
	 dSpSMURerw7A4epUEYpyW6okNMBcy1u5EMJgYZ3DpAxfCwgQzSPVCPP+mCBP6DqjQ3
	 KwUR5Z3zqSccw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11AB1605E7;
	Mon, 17 Aug 2026 15:55:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CB70194
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 15:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F26D940741
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 15:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FNnzhO1QzzVy for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Aug 2026 15:55:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2C33A4073D
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C33A4073D
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kvjIke+V
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C33A4073D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786982153; x=1818518153;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gVOBS/stZEtmI0fc52hEHm1vUjBE+/pfdCE7W4OvEWc=;
 b=kvjIke+V0aDcfwq+FPVjXaUii2OO2XQLsfMetuEym/thWg/fAy0nUVe5
 spZH4bTvDD3jp3NYF1RFuRgk0huh78V6UzbxScpv2Xk5KPS25iMLMPJ0E
 sW+o5Cd6Y1arNGVbkWdayojwdUFSPXOQcxL75Aw0ce4kqSlQ36p634dH0
 njb4dRs8O5BRjuTLoPEriwmXo7bnCVU7rLVdxolKdz0+NHuvDQpr4y9tw
 08HRO/lBoklNhuBbA3r9F/rv5suAMI8mFgM8wA64Ed/utUPJQB8CRSQry
 riAJIcDaOS8ULRh9V54CzA1d/h9GyINQprCPHq1gFH2062hpInC0Ni2ss w==;
X-CSE-ConnectionGUID: R9wecB1TRDG81P0bXb+iFQ==
X-CSE-MsgGUID: MZcbKLhUT8iDR4A2fmZZrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98612504"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="98612504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 08:55:52 -0700
X-CSE-ConnectionGUID: Y974g+SjT1+/2mKNtYxNzg==
X-CSE-MsgGUID: d0ZBGM+CSwy4iuOCVZbD2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="303180485"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 08:55:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 08:55:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 08:55:51 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 08:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkMKqk73mK1IqsCPHRrjASE2W46cVoUs2UB/vYKopSe5tMyc1vYWL0K5rzsqqLXWCd7yOrfDiYbDoWPLQHyaIiuAvcwbMvNdSEWkG9dqipWlqFtFpXSQdNeCYuKX1DmILbxQEA+1EUJtHo/07cdPBBTVX7uPR1glrwzoXvOUazqaiNgL9s8wUo/MsxeRzDqnBlWL3drgZ9eCISsPG/9Yy0XCifNgVQfLk4xKBlwOBZCtYBO/L+GV6yAGnXuKOZlRj5e1kwpgv8JUOffrNR/Oow9HTawqqGuznWDn1ZUQQ5Amos/ziFLIGO+Qi1t8RgDSB7y+FT7HQgHz/V5L0E+GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TaeFIphfV/gLEjwLPwY8Y2yiFTy2RGY5Auxsa34Vlc=;
 b=j0nXEuobgAg+OD74h2aNhELbn0SwM5OPwgFDLTHvrUlyhsqLaaM74ukOobwNkzaH7wR/ixp3IHSx+l+bXxKlmRi31r/Zd+o8PgAOqpt65qQkaPONY4GIeF3srXKE6woL/Sc35lRQD2NXTR3baN/hEzytoRX4E5j/h33vgXmGMzDnMVw8Na0wBF86rInBOcZq0btxz5/iWSnKf83kuo+GSm6NdJKhC86daGme1LjmnOmBvkVuRj4Ijx1s7oAliyRhuMQGBIri0ufBEoWe69JZeCU2x7hwZ8oIN7nBg/JFh2a23cjzRoWwro2DDA8LMzt+hvOzNEoahCD8SYOh5hfVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:55:47 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:55:47 +0000
Message-ID: <dba117b9-c24e-4226-b2ae-3d559e2b4cc2@intel.com>
Date: Mon, 17 Aug 2026 08:55:44 -0700
User-Agent: Mozilla Thunderbird
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
References: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SJ0PR11MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ace7741-814b-47db-d0f2-08defc78009f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: TpdeFLPLQ9PshEIRyzPrvUWsOTvKXfxa0yKHrTeIDBdFBfdYus4Hp0Jo0LWtuwMzndHyzUQc78pQFupww7otCLJEA/BCyrR7CoNDBWe/IHtZntiO7gWWaW5bCJ7Jnx8J4OvgPkKfGZN+orrK+3BmMcNYXSxKvujxhu3wrT+IaMglWm6y5V7Niu3+XYs3UdY/uq7JUmEhAy05Guinl0bhH73bZs/lvgb20IYlBUBk87I+agwYD8j/fV+NT3NDvZg/RqGDd1G8uIAVkqb+47wt5it2bnbKUpz46ordTChjifMl9ZvLoC5S4mWFFADmQ24tnWnzRsPFrD+2i1Mo7JqSm7nMOGVEYqMIpll44W4QA5CiAULYP+BfVhBBZrKwzeZTlYXHYYKiL3gytpTtAu/lg/bVJgpE9ZujuTk1gamGdpjEdQ6aBj26uy8B6EQ+PgBn4p9+NvnMfcOxTjqtQGKXSXsins/nJsNp/dXT5GZHsw0ikGLyMgO3jRdwfwbZ1wRiDgcfirYI2+iCFy92gSMRl39MH6m8bN152MXyp2BGhPAuXU2hmzpCHzLWS8+UrgNdDy50tIGSDw+e8yt1Z6n3L32vn0INSU00SZEMpUg07NSlbTXiNkM+GJ3jRhy9f9sIYQh1groaSDFivZICyns9LSSxZc3W1uDtV2tnM7aoUlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NyWi9BVFltTG16bU1mYkdVYmFHeVhZbXlkOFJWZHk5bUlSZG9ycW1HdDc3?=
 =?utf-8?B?cmFtQTB2Y25qckNmNjdpYUNtUlV3dGc0dnNSdWdUelZMRGE0NHRPZkt0QnFq?=
 =?utf-8?B?NG9lSDVnMmowZ0pQN3htUzlYU0NQQjJpZWF1MVUwZ2k2dlRwRnVzTkU0UWJo?=
 =?utf-8?B?WDhUdG9XcCtsZmM5RmtqWnV6TjYwOURuR2J5N1VMbDZPdnZoS2pwVmVKdzEr?=
 =?utf-8?B?Y01vTkxHZ0h4aHdSUHFmL0FEd2FmTnRnV28wSDJsVGJyKzhsVlAzTC9IWHNF?=
 =?utf-8?B?VDdsWXdJOHZjbFRVMS9XMTR5WG0xamtGT0ZERmpEVndYQmJpb0h5b2VSYmlK?=
 =?utf-8?B?NXRkdUhUUnp0OGtQUVpTK1d4eG1QWjFpeFp6UUV5ME53Sktyak5nakRwdmV1?=
 =?utf-8?B?WksvUVpDeXNScEFWY1I5cHF6VFRPSmlEWTlPN0VtVi9NamN3cnVYV1BWU1pC?=
 =?utf-8?B?UWJUTHY0V1F4TG5IKzY1OHZnUDZjcWlRVWRIVjdTSFJuSSs5SkVyRnoxakdQ?=
 =?utf-8?B?a2h5MnlCcU5DOEVWUkRzUGU3cXdQS1QydENCM0U2TjQ2azZneTIwbWRBY2ln?=
 =?utf-8?B?am9ENTVsaEphaHYvblduKy9QcHZTN1c5Yzkza3FoL0U2VUdyTzRDMjNSL0Ni?=
 =?utf-8?B?VHE4WW1JNGpqQURyWDkxZlVMWGtMQkVlWCtUenBLMW5tZGZFb1p1TWRzcFh1?=
 =?utf-8?B?bVRtSmRrVmFqaEd1NTJnMUpad3lZY3IyZmE5SVNhdTVDdzhUbncwdXZGQjBq?=
 =?utf-8?B?enROc1NkcDlqZzlCTDNvQ0NvQU1DUXhjU1BGZ2dEaXFJREw3YVExNzFnUzhX?=
 =?utf-8?B?QU56NU55dGl5R0Y4elBNV2ZFT3VSblZ1Wk56VHkrTm1iV1ZabG9pMUtRKzR3?=
 =?utf-8?B?MnpCQnNIRURpRXVTdWk5cERPRzNiUlpwelRUajFSWHozQUxTMEd1a3dPSmk2?=
 =?utf-8?B?M05BTGwxVW1UbDdtdm01QjVIR2hzVUl2Z1hzeHp2SVNpODRwNVNkamtld1RW?=
 =?utf-8?B?Mmgvekl0MHBlSlFsWDBSdE1na2tNalBIYXJwQXdmdDVrMEgxcUtYQzYrdGpr?=
 =?utf-8?B?L1MrZzh6bnRDcTZBNVhxbE9tWVRCZVBpeUsvV28veXA0bmUwdkc1Q1p0b2VV?=
 =?utf-8?B?R09KZ1pqWnJFeTFUYW1oUW9kOUlFRkpJeWsxWnBYQ3pRVVZLbGhmMlAxUmpQ?=
 =?utf-8?B?RXV5cFRZNHNUTEE2dUNmYnhpN1VQdm1veW1kL2MxTDBuNzdObWk2Z0FQUklu?=
 =?utf-8?B?YzF0bXJKbkdyUENKYTAwU2FKNUQ4UXZSbGdVK0tzMjdTaytwY2xrV281Z1hk?=
 =?utf-8?B?STZ0alhrTDAwU2UyUGJOSjdmR3FuM1dqbTFsbHhhdVgwRmVWSmpvZ3pOaFRR?=
 =?utf-8?B?SVFCN3lVTjFsdTdEVE1HVkRZbFFFVzFjZ2E4R0RSL2FBd2NyODVKWDcxUTFw?=
 =?utf-8?B?THpNNkU3TTIzcXF5VGNaTHU1MGVRejBSZlRxejIrYkJVU1k2VTVlenBXc3ZN?=
 =?utf-8?B?N2JsS2M1b2VZOXgzZ0NZcmg4cEtSRWk0ajlNL01uTFM1ZmdlbVNHNEh5aXF1?=
 =?utf-8?B?TzR0elJJbERtemY1QldMQ0lDV0RZU3c4UndXaXU1eFRtVVVFelZGczhzOXpB?=
 =?utf-8?B?Zi9oR2Z2dm15ZEcwMlA5cVdwaWNneFRDZTkwbFN2cDRnU2p2alNRRVMwUXR3?=
 =?utf-8?B?dUs2S1lBdmtDY21UNXYzaUVUcElORmgwVHJ5S09BM1RQS3EyT2NpOXdvR25T?=
 =?utf-8?B?NS8zQkhhRFdkbWZINU0zZFJmdFdmbmNwSWRKN2lNTzZHcWtjL3pzdG0xSFEr?=
 =?utf-8?B?TnlJLzFjM2tCdWdGUnZ1aWdoQ1JDNVVoY3VjMWNlVTFJVXdDNXhoMkJJKzE5?=
 =?utf-8?B?aUxtYzFrbEdLWlQvUHBnRmU1alRQcVdOYzBzdG9wVCtLL2JkRmt1UVovRWhi?=
 =?utf-8?B?SFdCTU9zNnQvT2NpZHhmNXc4NFA5Z0pKbjdrTGNnVnM2eXBiTWErekNOUDdX?=
 =?utf-8?B?cVBrZVdNelc2TVZRYXJPQjRNYnJEbXpaSkhTUkd4TEdQalU5ZmpyTFA2ZTBy?=
 =?utf-8?B?bDBxV2R3MVFJQkdleUwvaUlKRWhESlRoNCtDanQ4SmR1aGJBaVhwWUZtTmpa?=
 =?utf-8?B?L2dWbWtpVHp5QWltY2p1bXdLbG5wN1lTOSt0K21FbXVWWWYrWlFpbVJRS3hk?=
 =?utf-8?B?Y1BxZDhmZjUxbGZBb1lkK0RWVTZOd0Z3QkNCcHR5b29oSFlkMnZmTTZuckk3?=
 =?utf-8?B?QUNYc2pxcC84RVIzeGRCck5jY3F0dk9HOXdLZ2xYekl6dzdOSGRiUTluUEg3?=
 =?utf-8?B?UEUvZ2ZES3dLR0VoTjBISHRrNU5NckRqWmZ0QXpVWit0MkVvN1grN1pHaUpB?=
 =?utf-8?Q?xdZ8yvLvEM6Cm4WY=3D?=
X-Exchange-RoutingPolicyChecked: a+f/fEyitmRqwTH47tgueiA4aFll7mIH/2/HQqGE0xNWE3JOQ/MKe6XIb34Kkobpozk3etEMENdGclIisViHQ2NsXFyoh3IfQn/wVBy7n0ayplKju2o5JPmW0KLG97aeHkYpKtbvzAuukC8ngRzXao+NGBmqQJ1qpH4jMilOsyfsCveIFvWwH9FLigLPY3JBmlZO9TNZKrHEJ28Bt7v4npAI7eC4rZRe+KGGDU4gaftUlvnWHSlpmxF2Y9u70YVyVPL2tvbhntdpeQELIxBL8YRioryn8VoL/xgJIVgUx11FpakqRzJNFMHfWwOfgfl2wKzSBKA5GuzZ8epJkEIFEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ace7741-814b-47db-d0f2-08defc78009f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:55:47.2146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uySI7FXjqfGam0XHhbk9LypYEOFDhpvMdoBK1/twbbIrGKCaIVsjuEk1e/s5/dBeZ8pN4IInTsYbmRehtjZnK0a4UM6hd3JN4yUvhnu29x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH net 0/2][pull request] Intel Wired LAN
 Driver Updates 2026-08-12 (ice)
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
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 8/12/2026 1:18 PM, Przemek Kitszel wrote:
> fix an issue on ice which increasing VF queue count causes
> out-of-bounds access of the statistics arrays
> 
> Przemek Kitszel (2):
>    ice: move ice_vsi_realloc_stat_arrays() up
>    ice: fix stats array overflow via proper realloc

For the series:
Acked-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>   drivers/net/ethernet/intel/ice/ice.h     |   2 +
>   drivers/net/ethernet/intel/ice/ice_lib.c | 195 ++++++++++-------------
>   2 files changed, 84 insertions(+), 113 deletions(-)
> 
> Previous revision of the fix was part of our last bundle [0],
> but here I'm improving only my patches
> 
> [0] https://lore.kernel.org/netdev/20260804222205.1580328-1-anthony.l.nguyen@intel.com
> 
> changes:
>   apply Sashiko feedback for edge cases, see the patch for details
>   drop the rest of the patches for now - with the caveat that some
>   could still be merged directly from [0] thread
> 

