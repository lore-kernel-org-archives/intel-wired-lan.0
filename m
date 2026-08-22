Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C16C5B572
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0E7D60870;
	Sat, 22 Aug 2026 04:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9wZatlaUpog; Sat, 22 Aug 2026 04:15:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372133;
	bh=xJEHSAG5iQqFQDMBoaua7jxeypqo7Phc/1aRkIeMbWM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iXJso+aVHHnmrPEkiv9CJyhIaNODHLl+P1wFmFoWv+AkCZ8+7obbzARLf8VeyNIy/
	 HlrHSJoYt1v5nkio/yxh+fvJpmdremtgQ/jbjB3LE4IVibvltEmM+wzdbKVumklztC
	 H1L2mCvQhlUph6lFVVFuCYeeiFUcPPmEv+FPhMk83K0CqbpsG6A7bmQAlgb5V7ppfL
	 LacHP871xP/8u//cU5+qcWqdsl6NjTHHEYQD4Z4lyAcJqZGlPVhVEBgDfFam1Z7VCT
	 lXEJS5hvKzledh+1f0DuCzwJNA1WP1dwp5giqB7PJ1HgY6KgN6CsXJ+Dyocm/JtUtY
	 c4L0VlRd2+6Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D9AE606CF;
	Sat, 22 Aug 2026 04:15:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CCA7E476
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE3B680F68
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INgawBICOjrP for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:15:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kOecXTMh
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1610980F67
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372130; x=1818908130;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xJEHSAG5iQqFQDMBoaua7jxeypqo7Phc/1aRkIeMbWM=;
 b=kOecXTMh8qsBGV6RKWFTOT81Epqd8JKe6nkOc93iKzjizHUQVqmlpAj1
 uzczjQ8v/mn9C/JRy1Tpy89cDr0zmX3i06yUUe6U9YgbF2YxEe6ZFT05e
 qZmay3lf0CElIsG/WcVECxC6xep/VUPjcmzVziZ30U2P0ciKDtfc4quHO
 Rj2NTVXUl7W0ynPn7tPFh0WhknYEsYLT+BL7ypm3S8oG5laQPPehU8hyG
 PBqSNuR9otSXjU0EnEktgddIs8qN4iKL7mrmPgl/wfNhYWHicO0hELOuk
 8Yp08PA6i5+RZK9bRJTOsK63OstTnR1fg2KsnOK0azJi1H+bj6Qy9/eVo A==;
X-CSE-ConnectionGUID: Qmd2GariRlWVHE6u6YfKJg==
X-CSE-MsgGUID: XtqU48UvRzOBc6RokcJxww==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="98251414"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="98251414"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:15:29 -0700
X-CSE-ConnectionGUID: 2Vrka/VQTlKRodYmucXK8Q==
X-CSE-MsgGUID: KbGzvgapQCOMAYdr+mvUIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="290040470"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:15:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:15:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:15:28 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsKLB0NqIUeT1+UubCz6bGuKbD36LeH178bZwm1pYFYXTd1ZFtI0oTNw4JYjwGA2LM/ZE7YbdRTMFXPXRyRuf9PlZLi8gas8JZoL4lPsFlyuRu/j7RcegiuC31N2OA6FFkeRRM7KtBY8u2fE6lKcV/ECAW+uzl/9E05fPvpkAY5CkjALAefuT8oWg2ycqVQTBlhfVLUqndRonSAfZ+V181yWhVYGvFT4/9ddsGbSh9Qe+9ruWNaTSo7tbiVAEdJ125KBDTDESGSk0IB/kWxpmepAY9aN/C5TWpNycBlg+CDLmIIArZdgLJn7kgChu5LUgGddRBlA8oDanD0ZmQRT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJEHSAG5iQqFQDMBoaua7jxeypqo7Phc/1aRkIeMbWM=;
 b=JbrotS/Ae6G1dvXCEFWR/XviuiXXK6gYW+sSsbeNi33rwVV1Ok2C7EJ+RlKjEocmS779aiwq0C0fuBL2Zuw7cbAiL983ZoZJkQhDSHcMDXPccMcqWNGuQaRz9DzRqxsAZqJuoZOXLWPKz+bXZ1F6MpHvGUTnv9Of1/Bj5o7IDEK55wXwa/3OyM+4lNfHa65DNdRq5S3xCaFe+vDYfIYCD7b3IJ3EqSbW3fyDU/bqmS8VvCe8BBuBq0tQsgL2sm//zAKINkmkVCiVLaM50oDCz1Es9+YZuAz1ZSi/4N8LjmEANCoqeEclkZZultCWzrVaOG+seEeNet14kmtQJcfoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:15:25 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:15:25 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net 04/12] ice: call PTP link change only from link
 events
Thread-Topic: [PATCH iwl-net 04/12] ice: call PTP link change only from link
 events
Thread-Index: AQHdMctLrptoCfpnD0+N7rhHa3q0RLapdfLw
Date: Sat, 22 Aug 2026 04:15:25 +0000
Message-ID: <LV1PR11MB87908DACA513E150BCD0540D90A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-4-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-4-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 1f367626-fd5a-497e-c380-08df0003fdfe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: gm3gUshN7gLa+16T8F/B0kSaQ9NRYYwGkPLGkC2dcT5ymsVYW7MnurtDnmpcf+z1b6vhQE4GDRK5kmgGplzXZfMiHET3rosWc/Og9kOufcQAC2jFMCsw3+ZGQZ334lb5nRymxcrM/pS09McHBhfVLu1e56Vw2xLRop4OQPR6cpjVR3+uZZF+EuS4ePG7sp1Rk4+R4lDyFLpSPlimd3hf3avE0ja8Gy2aq1yoH5FT+uo7bLmr8vAwSlC0nPmCLQpJqd9WBcXVugEQBDogokHpG1xvugE9hN5uWfPiFfSgSXXiLfVBQ5sz+OHQcxZC/BAnKTC9BKixp/IhVihBho7RPLlh5ck7vBKUG+nYIkW7sznldRgygAAPenXL9v6qEg95sXMopXf3i0KmVNS3+Zzqs1mfvDUpei48enSGEcwJ3PzWIOD+tQiVWVELllfD9UWhMnfc0IxwEy44A7mZOkBiDeqcOH6bR59B6oInDUpAqby93MOsvWBo2r7q8Akg3L+lccKHo+HSZiA8Gb9dyhLcLJCjD5K6tjq/SbaEuqWA6rn8RmKTNj6fLYfLaf4R4ktloa+BcjBhKnhGI0V3p93I3oreREg8+LTiXAKnzRmLIvmre6n6TdMetPzZYHlsa8LH5qaGQ5bNZ7vx2IYfpXKTdJTSFOWP/Sv//gIkyoCYhZ8eh6A1bRInKvVRv6kPB0z2eb8/qdNz+9qkFwWxbl7XghPuODbfG+UWrCXJKTDNK0A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHMyc0NCWDRvYjBzdUhRQithaVVGT05mWGgwVmE4KzdQMUFuNVNEOWJ3dmJU?=
 =?utf-8?B?US9TNERTbVBacWRIaTRiTDJMU2hlUFFlSWc4aWRWOTNZdGtCejhvUllNOFpl?=
 =?utf-8?B?cmtwSk1ldnlJSHRKQVphWGZGQ3IzQjh0UnpHc2hETmgwWXUzWEdsb3orck5B?=
 =?utf-8?B?cnZEdjJqZ0xNTWtzUnV4ZVk1dDdaczAvQURldG9mZ1B0RGk0TEo5K29qQVJ3?=
 =?utf-8?B?RDB1WlFTclc1R25USXIybWhabHRXRTREeFR1cTliRHJjY1pKNU1SN1gxZFFy?=
 =?utf-8?B?NVRJWnRmL2tOTkphd1plVFhOM0VzVFl4U2xENlZWaVZVc2d6SVdRUFh3MEZk?=
 =?utf-8?B?dTRhQStWOVBlMGlrQWtDTEhNT21RL1M3U0VmZXVzTkhLVXJZUUljT1N0QTcr?=
 =?utf-8?B?Z3RmSmpleHdZNFFmOGhxM00xMi9XWkVBZ0RaY2JZdkNZckhDTXQvMUZSaVla?=
 =?utf-8?B?OHZlTFZIR2k0YnZDMUNDRUdXbHFHdFMzam40V0VGVTM1L2ZXbUtOelFKaVpX?=
 =?utf-8?B?emE0eFljVWJkckMvaDJ3VldwTVZxTjh4QUlWb3B6SFNGZng2c3dMUDgvUnpn?=
 =?utf-8?B?VUJHOXFLWWRrZjBkMTZQYXpBTTBLVWJ6bFlxa2pPb3g1WGpGakNLNFQyU09F?=
 =?utf-8?B?RzNOTHlJVWxGeVNLd0VUNEwwYzZzdGcxejNVSU5RTGxCMUxPaXB0UjV5Qy9N?=
 =?utf-8?B?eHR2azBnVE5qUGxVcmFkb3VGelJTOXRaUE8rc1lqWW4vSzZ4MkhOd3JwN2dD?=
 =?utf-8?B?RWxlOVJIV29NWjhkUWpaai9WR1NtTnZBc3JiVkdFaUcvMTJuSEQ0ZXFtQ0hr?=
 =?utf-8?B?M3ZIRk12b1dYdlJFb0JHcjByRWtRT3hmdEV4aWJzamJPMHp5dnhtbFBubENQ?=
 =?utf-8?B?c2hQTlJENkQzd29SRXBISzhDb1kycGZzdFBYaSsxSkNPQ3lLdzJ5LzFmMk1p?=
 =?utf-8?B?REoySVJPam9SRXpPWFBGRzJhblBaZ1h0RVlxSlBJZkRBWmNTY1N0eTkxSk1j?=
 =?utf-8?B?cmR0NkU5K1VmVzJUa2l3VlZNZzNKaHZibDBqTW0wRGIrS3F3ZUgvV2c2YzBs?=
 =?utf-8?B?YWxxcEZySGxPNGtaUzhudVJRVHNEbHNCQ3RER2c3akExbkpacm03NTUyRDhz?=
 =?utf-8?B?VXRBSlFUUWVVbWEzU21GTDhBSG9LTVlZZFFCQm4rcC9rMUxKcUFFNUZOcVN5?=
 =?utf-8?B?MXhrc3Z5SUczbkdBREFLbmhxSG5vNlNIUzh5dzFOY3BGSVMyc2xxWWtibStj?=
 =?utf-8?B?VGx0QzYyZzZoK0dtcG1Qd0x3MEVER0JrYVJUTXdneFNIMWxJNlNkdXhucDhG?=
 =?utf-8?B?K29XNDFKeUk4Q3JLSWkrdStNVjFNVGFGQVJUK1FHYWFOeVdlL0Y5Tkh1YXFW?=
 =?utf-8?B?OXpTeGRYaWd5WVlUSnNjKzZxdk5uU3BTOXNEU1B6UVpnelpwbTlBR1ZibDBj?=
 =?utf-8?B?ZG1ZTTMwbjJESWQ3aEFrSnZ1c1Biek5DMlpYZW5JWndMTWk1aDVRT1BFRHA0?=
 =?utf-8?B?NVBkbGVnTEV1Z0ZBVUFCeExWUjJOTDVodTRVc25qSXh0RkZDQm5XMTFhYmpV?=
 =?utf-8?B?b045dy83S2xVY0xaK2lPRVJwMnBnODAvUW11d214eTBiQm9Qdzl6LzhJR0ZJ?=
 =?utf-8?B?bzIrVDNaVzJYQUlNZ3VyZXdzY0ZnaVBNR1FxcjRJTmlLL2tWZC9GL1IzR2gw?=
 =?utf-8?B?T3MvQWRDVWFSL1MwT3NtdFdJSXR1a2dHbmt5OWY0UnI0QS80NEk2VHV6VFNs?=
 =?utf-8?B?dGZjWVljcjhHS0x5dkQraG0xTndGTlpJOWsyTDUrNDB2WmtiNVBYUndYT3lQ?=
 =?utf-8?B?T0xMUFVPSVkxQXYyaWJvb20zR1JlblVFc2pXUThZSWJDT24vSWE5MlZNUFYy?=
 =?utf-8?B?WWcyZmk2ZWMwa1dRRDBxb3lBYlNCSVlnemhQaXZZeDdmWmFyUUNtUjZ1ZlNi?=
 =?utf-8?B?SEIzMjFoNlYzL1czdHB2TXF5NHJtZU9EcGttRmNZNnlHWk5LL1d5dHdFVnJa?=
 =?utf-8?B?NGpKT2J3dU0rMlRPNFk2UmVIazIwSFRrS0tGNVJ5dUdyK2FrWHYrQXJNdGpm?=
 =?utf-8?B?UDZROXdzbXhsc0Uxc3RqMlpYQ3FRV3VGeGJZK3hXbVZNZGtWNC9Pa0ZsUi9w?=
 =?utf-8?B?Q2YwTDJrc1RZUTJ5UkYvZG1PZU4vRDNFZWQzcm1GcWoxSjJDbm1HbFVObVlv?=
 =?utf-8?B?ZG82ZEU0enBHbGMyaXZPbmFPUkpOTHBVTjV3TWx0TVB6WEw1LzBPZXFNYlVD?=
 =?utf-8?B?L3dYM1ZlNFczRFg3WSt2YWtDbklMSEpId1NZdUxhaU81TFNzS3ZxVUNLSFIw?=
 =?utf-8?B?allFV1Z4TkxyTytUV3l5SDBpdGRIMEZGWEdTcDllOTZIallRb2wvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UqVfzhnxUukpa+sWdsYl4Sww7YvygVsqMHqHBHzVhnXYX4+EhTKtfCgthPy0za9944YaYLqHTX5HZWhUdh3ZvRpSKTR0QLDDZD0cxeOeqqONsaiXII1geBBR/BylMopKqm4+qbr+1YCfUQ0MRCQX9cTLPuNR12RtYY8dtzJn+VG+nEi8JvHQz6yVRdi0qto4/hpcvLuOIxvJ8KB6ypB+E675ftITEeaV6oGzkRjH6wz758Mw/FrgdB37+F7R2gqfSIsG/otX25/aHjvv1BaO3YVEoa7TAUIe0DrqKSnnWveNH7Yaeqhak7UV2CyOL2N+G2fYTo9xbRE+2V8GtqYJMA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f367626-fd5a-497e-c380-08df0003fdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:15:25.5745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ma/POkQe2hferjYOpxpdHNU0gznOLkdl1WYlpayMxzOYBX17bzQR2YuMyls+vo/vy1CIdc2KkHIX3lkYi+YlFhOGKPFbQSj2gO35dEAkjP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB992400
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDI2
IDU6MTMgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBNYWNobmlrb3dza2ksIE1h
Y2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xh
dy5rb3JiYUBpbnRlbC5jb20+OyBOaXRrYSwgR3J6ZWdvcnogPGdyemVnb3J6Lm5pdGthQGludGVs
LmNvbT47IE9yb3MsIFBldHIgPHBvcm9zQHJlZGhhdC5jb20+OyBOb3dsaW4sIEFsZXhhbmRlciA8
YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+OyBCcm9zcywgS2V2aW4gPGtldmluLmJyb3NzQGlu
dGVsLmNvbT47IENhdmF0dXIsIFJhbmppdCA8cmFuaml0LmNhdmF0dXJAaW50ZWwuY29tPjsgS2Vs
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmth
ZGl1c3ogPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3Nh
bmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtvcmJhLCBQcnplbXlzbGF3IDxw
cnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IE1hY2huaWtvd3NraSwgPiBNYWNpZWogPG1hY2ll
ai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXdsLW5ldCAwNC8x
Ml0gaWNlOiBjYWxsIFBUUCBsaW5rIGNoYW5nZSBvbmx5IGZyb20gbGluayBldmVudHMNCj4gDQo+
IEZyb206IEFya2FkaXVzeiBLdWJhbGV3c2tpIDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5j
b20+DQo+IA0KPiBSZW1vdmUgcmVkdW5kYW50IGljZV9wdHBfbGlua19jaGFuZ2UoKSBjYWxscyBm
cm9tIGljZV91cF9jb21wbGV0ZSgpIGFuZCBpY2VfZG93bigpLiBUaGVzZSBkdXBsaWNhdGUgdGhl
IGNhbGwgYWxyZWFkeSBtYWRlIGZyb20gaWNlX2hhbmRsZV9saW5rX2V2ZW50KCksIGNyZWF0aW5n
IHRocmVlIHByb2JsZW1zOg0KPiANCj4gMS4gRG91YmxlIGluaXRpYWxpemF0aW9uIG9uIGxpbmst
dXA6IGljZV9oYW5kbGVfbGlua19ldmVudCgpIGNhbGxzDQo+ICAgIGljZV9wdHBfbGlua19jaGFu
Z2UodHJ1ZSksIHRoZW4gaWNlX3VwX2NvbXBsZXRlKCkgY2FsbHMgaXQgYWdhaW4uDQo+ICAgIFRo
ZSBzZWNvbmQgY2FsbCByZS1lbnRlcnMgaWNlX3B0cF9wb3J0X3BoeV9yZXN0YXJ0KCksIHJlLXNl
dHRpbmcgdGhlDQo+ICAgIGNhbGlicmF0aW5nIGZsYWcgYW5kIHJlc3RhcnRpbmcgdGhlIFBIWSB0
aW1lciB3aGlsZSB0aGUgZmlyc3QNCj4gICAgaW52b2NhdGlvbidzIG9mZnNldCB2ZXJpZmljYXRp
b24gd29yayAob3Zfd29yaykgbWF5IHN0aWxsIGJlIHJ1bm5pbmcuDQo+IA0KPiAyLiBQcmVtYXR1
cmUgY2xlYW51cCBvbiBhZG1pbmlzdHJhdGl2ZSBkb3duOiBpY2VfZG93bigpIGNhbGxzDQo+ICAg
IGljZV9wdHBfbGlua19jaGFuZ2UoZmFsc2UpIGR1cmluZyBpZmNvbmZpZyBkb3duIG9yIHJlc2V0
IHByZXBhcmF0aW9uLA0KPiAgICBldmVuIHdoZW4gdGhlIHBoeXNpY2FsIGxpbmsgaXMgc3RpbGwg
dXAuIFRoaXMgY2xlYXJzIHRpbWVzdGFtcCBzdGF0ZQ0KPiAgICB1bm5lY2Vzc2FyaWx5IGFuZCBj
YW4gaW50ZXJmZXJlIHdpdGggb25nb2luZyBQVFAgb3BlcmF0aW9ucy4NCj4gDQo+IDMuIE9yZGVy
aW5nIGRlcGVuZGVuY3k6IGljZV9kb3duKCkvaWNlX3VwX2NvbXBsZXRlKCkgYXJlIGNhbGxlZCBk
dXJpbmcNCj4gICAgcmVzZXQgc2VxdWVuY2VzIHdoZXJlIFBUUCBtYXkgbm90IGJlIGZ1bGx5IGlu
aXRpYWxpemVkLCBjcmVhdGluZw0KPiAgICBlZGdlIGNhc2VzIHdpdGggcGFydGlhbGx5IGNvbmZp
Z3VyZWQgc3RhdGUuDQo+IA0KPiBUaGUgbGluayBldmVudCBoYW5kbGVyIGlzIHRoZSBjb3JyZWN0
IGFuZCBzdWZmaWNpZW50IHBsYWNlIHRvIGRyaXZlIFBUUCBsaW5rIHN0YXRlIGNoYW5nZXMsIGFz
IGl0IHJlZmxlY3RzIGFjdHVhbCBwaHlzaWNhbCBsaW5rIHRyYW5zaXRpb25zLiBSZW1vdmUgdGhl
IGNhbGxzIG9mIGljZV9wdHBfbGlua19jaGFuZ2UgZnJvbSB0aGUgaWNlX2Rvd24oKS9pY2VfdXAo
KSBmbG93cy4NCj4gDQo+IEluaXRpYWxpemUgdGhlIGxpbmtfdXAgaW4gaWNlX3B0cF9pbml0KCkg
YW5kIGVuc3VyZSB0aGF0IHdlIGNoZWNrIGFuZCByZXN0b3JlIHRoZSBsaW5rIHN0YXR1cyBhdCB0
aGUgZW5kIG9mIHRoZSByZWJ1aWxkIGZsb3csIGVuc3VyaW5nIHRoYXQgd2UgaW5pdGlhbGl6ZSB0
aGUgUEhZIHRpbWVyIGFwcHJvcHJpYXRlbHkgYWZ0ZXIgYSByZXNldC4NCj4gDQo+IEZpeGVzOiA2
YjFmZjVkMzkyMjggKCJpY2U6IGFsd2F5cyBjYWxsIGljZV9wdHBfbGlua19jaGFuZ2UgYW5kIG1h
a2UgaXQgdm9pZCIpDQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2Fu
ZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQXJrYWRpdXN6IEt1YmFs
ZXdza2kgPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
UHJ6ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hY2ll
ayBNYWNobmlrb3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbWFpbi5jIHwgMTEgKysrKysrKy0t
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jICB8IDM4ICsrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pDQoNClRlc3RlZC1ieTogQWxleGFuZGVyIE5vd2xpbiA8YWxl
eGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+DQo=
