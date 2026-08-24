Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A93C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 23:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3258360681;
	Mon, 24 Aug 2026 23:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmnL8aWcI-6N; Mon, 24 Aug 2026 23:55:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787615702;
	bh=hnz6md1JMtrvYzd07k78GlIucQ4vkvmI8y12ZlzhB0Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pbzo3AWm9vEM4W27bi9P5pVdaQb3PkvCPxuBO/7FfDu0KqYB37RQShJMrJnWYI2eb
	 eZwOqLli4uwFZfRUrur/AuNiOfrPJM1WUXae6d//MuTGwyJDybRVjU+LQ70ewSd+fL
	 6wbHVia/QhwtAkENePrHpSYmGFSuhCeVdrdJiUCY3EFYlauvikSiFjimIEhpYEzGRG
	 gkxw0C1dmKldFSenENl24HjNHZQcJP2A/f40z+CUTtp2dGQRZfkZsahnc8iKv0YiEy
	 U0Mw+7Na8lbP/Dgw8MRZ01WMxRoN/ZKqc6CAzjE6nvFPr9S33yXzUNyeYZTMCu5zqs
	 7uFaJZGMy5N3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BD4860667;
	Mon, 24 Aug 2026 23:55:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E306279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E313E4005F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLDdbAcWy6h2 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 23:55:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gjrWFQo0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C89CB40050
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787615700; x=1819151700;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1/4RMsR0ejHw0Fc5AplUYv6aHfajNYWpPbu01AMWEFs=;
 b=gjrWFQo0sjMLVnuyhBY11ZkvNmeuwp9RwjSR/s5+JrzopqX43zAIgEwh
 +WhoZCa/CmgHiXKj3a0Ka+VacjIHC+HgEJKNR/RTtRNvTy4N+5Tss70+k
 5+a9tp5CpjwsFk0Hm/tEEYLFLBz4A2Kk17wTsxXCFQ61Jyi63PLKgJq3e
 CFaemysXPDakgnUb85ovu+StaCeRP9473cfJfGlMaAqUyzKczBtDiM3ZV
 lN0o5C+F7VA8EShzDWXAX6hptffPWUU72TTOilBrFmQnRL54ZpAzAbHDN
 JJkstY1l3tkjZ4b6TUpLLJnXSW/Br15RxPxnSceP9gJNTenz4wxJqCqeW w==;
X-CSE-ConnectionGUID: gWgF1dOeTD2YzGTxJJ+Q5A==
X-CSE-MsgGUID: Rg90sCRbT1eVnGUMQBBtUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98753212"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="98753212"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:54:58 -0700
X-CSE-ConnectionGUID: /x/a88txSZeMP1P+dttl8g==
X-CSE-MsgGUID: RyCKWPx3RqOU8QACc9Xdag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="262830808"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:54:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:54:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 16:54:57 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4VzIURrgRALrxbZBdnDsSxjkDpOhfdDC6WIlo6tGjLILE408Ib+NnmhRktqmXpqByOJ7osJW6D5iWkt16CTvqcOca3w2rxKmDX2AvUFc5fQ7slFBTAEBLQfRdxNvMWrnH0EWhOAJv7VU03VUqQ3BtA75fWFfZ4f67k54sarmzq/m4h2RpmpaDPM2c5VYUj8Aq7NJX1H8RAko6b6tV8AHRcf32OCY5s5OB0/S7amM6qkw7OAcwZmYvbuXPwkly0x1jI7GcJVUfdUIrnVSG8sQZ7doW/h6EjkRpn3AFtOBhYz5KlIBN5tpjhNWtpAKdVnnbOv9nBKrfx1CQ2zzUbiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnz6md1JMtrvYzd07k78GlIucQ4vkvmI8y12ZlzhB0Y=;
 b=pezbiJxQGxS2lCcjLjY4K3ZxR7AhkB4I3tH03o0Jnsr/vDOq/FwFlxXHum9Drugqgpe4CdR2vLnm+CbKrUOMyR6hLgNGLuBmu74SFPPESlmZgD6wVKchBR2OuPps+pwww8YJnv9DYEoa1hrzPs1lSm61GHRQkNgV+DrzkDxMm0v3vzuOMXbJLeD3cOuva2HtigqShBqZPm2V0rwlC4R7BoSxK5c0xB5ig2rAX5fhVeXtYKgc1bhwR1wuu5iP4RbbPvtXR6162nPXDL+fnqHYgZbnJQNmDDCBzW85W7ogQTOA1bRJOk3lBPn6XGcxNBd7rZ/YJUIrfx4HxdT5iESqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:54:49 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:54:49 +0000
Message-ID: <41cf4086-aea7-41ea-93ed-c2ba0480a647@intel.com>
Date: Mon, 24 Aug 2026 16:54:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 07/12] ice: E825: perform a soft reset when
 starting the PHY timer
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-7-9d0731eb4858@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-7-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:303:85::16) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfc3a74-0cc4-4c0c-f862-08df023b151a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3MLAalaijN4Zt8ZpwhPkQdCux6fsocXAF40ficBU+rBSvb3MrwIkhfz8d9CN7ZFGDC0myKUFhpSbPc1Fzk+9/ebYpD+Nt+IfJ8oWzm5cbVTpiX/vrwb0U1C3UGmuPh4SejHOZTnQlxY62iDyTxYH8cfsNBVm+yIqPyRU00gRTcKP1Yl3hDca0DJ3ogbQsj3SgVLPUwSH8D7l6tq/HFmT6Qnj3oDCn4KBZsBrKavFQsb2CtOL5SeN6jT2ZCjo3XRIIb86hx32hdtHPGRzN3+CgSinqYMGJ+enn2GgtUTRZ9zSKPiJcueEtbmz4PcnbEGPGaMaI0LPXsFWGdQ206okXPe2DMe22nxNnB/xVv2P5rNSRUl3TgPeH4nfJgzsE/SsBrnE+U6yu3rEoXo1pSU13SyYuOGG5g3OjsU1Gj8nxPiQfSxh7V4+jL1P7pebQLfo/X3jpq335pujwHwGeE2ZvDn4tmPMCNseVK+f9jdXKb1+VyUEGTPj9C+tKW1vSa1aut5iL9Fi7H0g8g0RrLGhqHdO0wrQOhyBT5ZdzJuh8xN0HaRz5PkfH6zGOsAKTqSPT+w0oR6NSSwX04WMeSTk4i563eOatcFxBvQVnP+WVxmcHHfLWQlCPl2/B5bkeFBI9INH7niczDXtntEAmKJ3BMc2fsyuj1esy2YBqdh7rcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3BxQWF1cmh2K2VmRzVuU0NYRkVWTUd1U2srK0puU3QzcnFZWVJCcUxxMXZt?=
 =?utf-8?B?cW1KczZtYVR1OGRmRHZEZGpIcHNVakU1VFBJdnlXRzRBMWdOemFqZWU4b3Z0?=
 =?utf-8?B?YWlFTXZDbHY2eWtiZk15aHdkK3lKakV2WjFSN0xnTGdxbjNaWkpWNURYMklP?=
 =?utf-8?B?cTNlSFZ2V2IrYkZXa0dKR2tVZ2FsMjJkK2RaWnVsdmgvTUdoK0IyM0pwUEh6?=
 =?utf-8?B?R3NSYlVQWXdaTytHdTRoOERWbEJLdmZyQ3VDZVEzd3Uzam5JTzZPaFJyU25G?=
 =?utf-8?B?c1BJb3RQYklyOTFPOUgrNzlZejRSZHdybHRrZ3JFSTF4RXVJRXlqVi81K3FC?=
 =?utf-8?B?Z0Z0RklQMm9lRlZLYmZJU2JleFdnYTdVaU4wNGFCVzN4R2owQTRDR0x0ckVj?=
 =?utf-8?B?Tm9zV2xnVVcxdytmWFNXOHFpTlJxYW1nc3MweDJCem11MDRPaVFTOURWZ25u?=
 =?utf-8?B?SlNjbzdCaUsrN2IyMTU5NWY1YWhwV25tSklaYlZIM2J2c292cTRiRS9tc05y?=
 =?utf-8?B?UDkzb01sUzMxUVdjcjlDL21UdldnN2xreFRIKzVlOEh5NXc2cW5id0JpVW5K?=
 =?utf-8?B?WDVyd0pGbXp5U0xqVlhNTGNoZjJCei83NlhHNFh2bThiVTNaOUVjQyszU0xw?=
 =?utf-8?B?emdqQllmaE1BRFp4eGtjZk1RamhpWE1VM3NWRE5HL3g4eXM4SElwOTZWY25x?=
 =?utf-8?B?a0hGbWg0TjkvVno3b01aWnZwSXJnL3M2YkdlVFNmOEloY3g5OXhnMXBOYmxx?=
 =?utf-8?B?dnNlUTBoazB0VHZiclM1TE11dmZhZ2ZYSkpEaUo2c1kxUU9QT1NhS215dDFL?=
 =?utf-8?B?VSt5Y25hZWRmSWlMYUptUGRmSXQxU2NkdjRYemw5MFY4MlVCVUpSblM4SVN5?=
 =?utf-8?B?MlVIMjVTKzkydjgrWS91dC9aOUN6VGRSRHlodUJhZ1Z2eVNGVlF2dWFrbUV3?=
 =?utf-8?B?ZC9LOW51SEN0Nm9rMWpsTjN6TFMyRk1CZWJ4UnRjdGlMUU93ZHI4blZrN2ZB?=
 =?utf-8?B?dU5CVlRSUStRREt0dUZDVytjdm1NYWVLb25nMDhvK1ovQ0hSUExnQXBpQ2N4?=
 =?utf-8?B?bDZTUlV3QVlJa1Jjd0RMeHRzcDhjSm9uRnVPMnhXaHkzL1NHcU1UZmtsdEYx?=
 =?utf-8?B?dG5sbmRJT0JWaE16UjBEYXczYy9wTFRRcy9xYUNwVzJveGVDSHZIamZqNGhi?=
 =?utf-8?B?R0cwaEVJQzM0WFFwZERRcUVOSll4ZHhFVmtEWFo1cE5PcWM3Vm5yOGRvdmNC?=
 =?utf-8?B?Qkd5MDZvbUJmSWdycG55RFVBTHNKS01rVTZVZWt1VEJ1ckhoZW9TdnBBblhs?=
 =?utf-8?B?bGI0aHVCRmUzZkxSdFhBeHhRdzROQWplR2R3MjR4UU1nZFo4TWFmd3dFVTF1?=
 =?utf-8?B?REFac2hZMzJrMi9mZGJvSFRQd2RLQ2xLWGpRT2lLL3plUTE2Sy84YTVVelpI?=
 =?utf-8?B?K1hVRkEveXJXRXZHbzFOQTFVTW5PT0pBSkhyZmk5TVh6S0dFNHhsOE91cEhH?=
 =?utf-8?B?YkdENm95TmErSGtmeWROeVl0cW4wTkc1N0pSSENHa3VWeDA2YUhOZmNpekdI?=
 =?utf-8?B?SUV3a0N3Ly9SbGdJMmVqT0FzdWE3NUcyWGVUWE54cUJPMXcwOVYrekR6Y0Y5?=
 =?utf-8?B?YS9zUVFsVmQreUppUHNLT2Q5R1FZQW1QUlhudDRpNnhPQ2Y1YTVnQXJ3U2kv?=
 =?utf-8?B?QTVMTGo4REtsVkZtcXJDSWxWbFJmQW9PeWVXVXhLVHphK29kbmhRei9HdGF3?=
 =?utf-8?B?V21hbGd1d040UnYwZ0s1RVdIZmdIeC9qdHQ0bnRtaXdpTUV1aXdLd1BodFZJ?=
 =?utf-8?B?L3lQUmhydWtzM2UydUF6ZUtBMitrZzRtMGFvVGFRUTlNUklPdE1yRklabVlP?=
 =?utf-8?B?dzZ6NGF3a1I4aDZCRkg0UWxqb1VyVXlCOEtHYTQwSG40U1B6NDZ6bU1wMWQ0?=
 =?utf-8?B?U0lvMjUyRm5xZFB0TFkxd0Jzb1pmV3ZnR0o5S1VROENEVWNnYVlENXJvc3dm?=
 =?utf-8?B?TnRBWWdnTmt2VGFkNlNhZk4yVi9kbW5hTGxiZVczZEx3RHBORS9GYUhvODFz?=
 =?utf-8?B?RW13WFN1b2gxbmFSVGZVeTBmUDVpVTRlVng0UzdwTlExaFdWY1Y2Z2IyOGZV?=
 =?utf-8?B?d2QvdWorVDlZWnhVNlFHd0FaVENtbTZRbUxuNlp5SVZDQTRaWmhqdVhOdFYz?=
 =?utf-8?B?eE5mcWRoMTd4QWVtRTl4N2V0a3YxSTFYR1pUYXVFcFhBdFFVK3VNdzJadjZZ?=
 =?utf-8?B?U1pWUml0Z2paMWVoclFNRzliMit6dTFvQXZmQ2pTRjZyOVl1OXNLOHU0ZEdu?=
 =?utf-8?B?aHNtR3NjOFg4eG0vWklvWjJiaFduMDNiWmZpZDNyVkxHMkR1OU96dz09?=
X-Exchange-RoutingPolicyChecked: Bzom/AVfW+cPuuC8xakmzLvpqCQo7RJckL60oGbND27mhIfQ6t0q4LtMmnGpW/+JxcKEnED4khC0+qYAVUA6mMjuh9awWKsnyI4LfNIs+hKpiSNp7ypCzsGjIR4BlJjr0/EzPE0G3ABz//jmTobu7oDuDFB1sbB9hn1Rx3HHJwj+RH5VbXdk6hcnc2QMKbfJAJgilj9cBW9Qha4uhOg8aY/QcQQKVTZKbl3Xd0R7fSiIQLfP1gUWGVBL1NoOVtMA7vhkmfZDgeitYIPayc28sGlt7xJo8kU0hDJR2zYTNgOJkBaE775e+qMFS/sUsCow2wanbUdYuMH31BicAI3rjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfc3a74-0cc4-4c0c-f862-08df023b151a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:54:49.2022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzlTbvGf3GKo7KYxnu2Lf5vptdtFWF+NB7OKfwE+6cuHbbKpkymi11ek+6gtT+ICVwd1ULaEjZUlxa9raCDAxt/HZ1y+gVrzxzIWr3eOFZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
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

On 8/21/2026 5:13 PM, Jacob Keller wrote:
> To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
> soft reset prior to programming the PHY. This ensures that we clear any
> outstanding Tx timestamp memory, and ensures that the PHY internal state
> has been completely reset.
> 
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index b7d217ac31f3..10e973876608 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2119,9 +2119,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
>   * @hw: pointer to the HW struct
>   * @port: the PHY port to start
>   *
> - * Start the clock of a PHY port. This must be done as part of the flow to
> - * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
> - * initialized or when link speed changes.
> + * Perform a PHY soft reset and then start the clock for the PHY port.
> + *
> + * This must be done as part of the flow to re-calibrate Tx and Rx
> + * timestamping offsets whenever the clock time is initialized or when link
> + * speed changes.
>   *
>   * Return:
>   * * %0     - success
> @@ -2137,6 +2139,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>  
>  	tmr_idx = ice_get_ptp_src_clock_index(hw);
>  
> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> +	if (err)
> +		return err;
> +
>  	err = ice_stop_phy_timer_eth56g(hw, port, false);
>  	if (err)
>  		return err;
> 

Sashiko points out a couple of pre-existing issues that are unrelated to
this change:

> This is a pre-existing issue, but does ice_ptp_update_cached_phctime() use
> the ICE_CFG_BUSY bit flag as an ad-hoc lock?
> In drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_update_cached_phctime(),
> the flag guards iteration over the vsi array:
>     if (test_and_set_bit(ICE_CFG_BUSY, pf->state))
>         return -EAGAIN;
> and then clears it on exit:
>     clear_bit(ICE_CFG_BUSY, pf->state);
> Does using a bit flag instead of a proper lock bypass lockdep and deadlock
> detection?

This likely could and should be improved, but I am not certain if it
makes sense to try and do so in this series, as this affects much larger
portions of the driver and is a long standing issue with the ice driver
(and Intel drivers in general) :\

> This is a pre-existing issue, but does the lockless read of
> tx->tstamps[idx].start in ice_ptp_process_tx_tstamp() race with its
> initialization?
> In drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_request_ts(), the in_use
> bit is set before the start timestamp is initialized:
>     set_bit(idx, tx->in_use);
>     clear_bit(idx, tx->stale);
>     tx->tstamps[idx].start = jiffies;
> If a concurrent reader in ice_ptp_process_tx_tstamp() iterates over the
> in_use bits locklessly:
>     for_each_set_bit(idx, tx->in_use, tx->len) {
>         ...
>         if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
>             drop_ts = true;
> can it observe the newly set in_use bit and read a stale start value,
> causing it to erroneously drop a valid SKB?

This should be fixed, and we can fix it by correctly ordering so that
the start time is updated before setting the bit, (possibly with a
barrier?). I will add the fix to the series.
