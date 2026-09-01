Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0957C624D4
	for <intel-wired-lan@archiver.kernel.org>; Tue,  1 Sep 2026 13:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48A0780BAA;
	Tue,  1 Sep 2026 13:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3MpM1r7Dw73o; Tue,  1 Sep 2026 13:00:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788267617;
	bh=LWPCJNfmzobKrCH8EpHzaXzGVOAVAljXRjSlFjMMvJU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5NjprwUjkV5IJHZ/QVnHq9I5N+RzrZBLLRLpukGOXC+WKcMTwI9QRhsP9VeevIBuI
	 M/a6JxWFn+86mUgyP1VIncSr+jIY72vKmF04GoZNYwZ54SvDYU2JalyNB3fhdjGCoi
	 xfKd3ZiTaNsJ4h6HjOhbPuikFQKU3ErX/Yy9MaUkUQExk7vPkzI/IKzwD9lzBB9dLW
	 c1KduRdeq5h+41hf1z9WNlcbJetQ+/crQMKWFq4Fcp5HjEGNAbuG5AbT7CQJ0HxBsO
	 tjImTRQJGslODc+Whcv/pBINO29Mazl/fUcEFbfhUF0QGRgPEG0rxFlblq37mKHPfj
	 kksulMnebBOoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30E7680B3F;
	Tue,  1 Sep 2026 13:00:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2B782FD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Sep 2026 13:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BEE44064C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Sep 2026 13:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZnGK294mJiN9 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  1 Sep 2026 13:00:14 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YmBZzxw6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F66440422
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Sep 2026 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788267615; x=1819803615;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LWPCJNfmzobKrCH8EpHzaXzGVOAVAljXRjSlFjMMvJU=;
 b=YmBZzxw6BdNT57lnvyeQL1tiGBWtb+LLm5f1BFbRX8Khk/gGlXCJKlaV
 ApGVVBZ/Qj0sr9UxmnHb91emNwcbLy8R3x1yHIE1KaCDOXkOHcmIjYAjy
 JqoZN6d+hHTjbikms9Z8WqYmyrN3TwEiXb8PBWdVPJOBNwfAhHPFQJS7b
 qT+dptx01LVSGPzfRpoJIplZ1ZNNa9OPgxU8SQ8lOqs+Yuiz+qdsQqeCq
 4NN/+vdVGvkltOUzKfv2XUsc+q3XijHn8W84nieJaPwyU56VChGGkUiio
 ccp7w86LnOic1WvKqgS+aznTTs8oylqktrbWcCS2vDYMtiaJilHJBVuFT Q==;
X-CSE-ConnectionGUID: /mmJhulQSoOA5fgMj570ow==
X-CSE-MsgGUID: VHllqIKgQSCyaCx5v4tLsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88742650"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="88742650"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 06:00:12 -0700
X-CSE-ConnectionGUID: pk3bTNrbSF+jkul0PbllhQ==
X-CSE-MsgGUID: qqQRZeMMTwSBRdzv64NFNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="265852410"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 06:00:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 06:00:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 06:00:11 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 06:00:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+SzmIBkQ315I0+/8bzn/LHguC8n0txqWjFrgcrImOzqYxpFFH7vljUS/4wfc2cRM2Ybdg9OZaMtU8S7JonQci5QpNLi2sZwCmInb2d2erdO7YOOI4e848HBNPBx8/D4cFfK93Y+M+o1xr73Ld1osxTGZ33+u+R58IuTQ8MH+GwWeCjHgWrn4F/FnDFp8FUu5g0A2De4FHrS+QEul7gSipZ+k3C/vHt2iOP3s7fxLKCLWTSgdQRqy1sKI08m1xT7rxTKuKS9PDsFw7PqJG8cxFnys8QV6r/P2hh48/3/mXX15LJEgfZ1lAtqgBnyDMDqfD+O63Lar0EduEZMG3/UfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWPCJNfmzobKrCH8EpHzaXzGVOAVAljXRjSlFjMMvJU=;
 b=R+GDQzI5b5w9TXFPiswXHL5UUNgtSn8xaKOCJvrvhwf8msVmgBAftfNI1UckhTOdK/U3gafmRJV7OGtYAE3uP+ncvcCcnkRmCyVjZDFrtGGvivK6uVJeNxRaSThNWpr26y2cJK8JLRswPgtsqs5uSg837c6zJjayUv6jnksjydbOQjM+hy4knxV8eTJg9ZIR0M6Nk1ukNYOqliMhQa8KkNWCrNEOYBD7t5nEyTBVt05QXpEMznvU7lmdTZITE8rpbGMVREUm+oPEE9+vsXNq72rI/YS+q734jkQjsWG9EEW6h0ybgL8iwwtIqUg3raTfGg7AvsxNDwHGiHAI/X+kQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by DM4PR11MB8225.namprd11.prod.outlook.com (2603:10b6:8:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 13:00:08 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 13:00:08 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v4 1/3] ice: Convert ctrl_pf pointer in struct
 ice_adapter to RCU
Thread-Topic: [PATCH iwl-next v4 1/3] ice: Convert ctrl_pf pointer in struct
 ice_adapter to RCU
Thread-Index: AQHdOWNlRhMpJrMca023AR5wJYjqWba5rDsA////1dA=
Date: Tue, 1 Sep 2026 13:00:08 +0000
Message-ID: <MW4PR11MB6864F50B159178DBD911C68780A82@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
 <20260831161100.216773-2-sergey.temerkhanov@intel.com>
 <db7fbcb4-743b-4ae6-9893-0e09caca15a9@intel.com>
In-Reply-To: <db7fbcb4-743b-4ae6-9893-0e09caca15a9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|DM4PR11MB8225:EE_
x-ms-office365-filtering-correlation-id: 593c95b6-b58e-4d99-ae92-08df0828f326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|5023799004|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Gj8XnvrAgoh4hiNUfY4vU/8IPEkgwvYq+1pBQhY1fvdECBnzx4IYySdCXMK/uVjKphtj+48e4rGTCUC++m+SMiY92xAKFTwt5GigOarNgtPFGkJobzFvb7XDzSgEI84pYpcgWXAGryCsErvC/l7FsYZj+3TC3mY5u08Ag6yoiU+ls7F0895GJPhj0CDBpDqNkOAr3eFC3Du3OS0oMOXYiIRRTGkXyK69rpXg49lltEm9vbiRXnOcJnIgz9yYiyYhxR4XNyOABb73Bd0fDRv9lnB9jQqMjRVPSgsWjhhjrWMayOYMoQmMNBQIusUUf2dGlv/SR8hbr+RybSUCxQ1imca4kkKFctk4B310Rt1QcNCIPmi6TrrCQ8WKDXU8Lm1qffT6LBAIDTPEiuIzkHx+9lZmI2M8GXS8k9f3GpaldRce4usTFmMgsS7I1lp4G0Xvo25fUOMkGS10atBOnvhjquHwGlIJlRirwzdhBAF/b/opHS9ODmL1vXT++YQWRRp0E60xS8h1/AzO6CINpaopXX3+3VkVYTp7lSqOeX0kxyKEA7ZfD4sgKyrWbaXFUTERkr3OfiaLpxqOCo8Ur7m5Rd7FP/Rt6YlIiz2DKWS8Sp1o72N8JqXqgeeMJJYeT/dBmxKDA9SjmPy21jw3koM2aCbFLHoj/b3Eo7kzxDm8dWPafZ6zcexCexSsdpQrifCJKWc5uQ2znqv6mTTPHVFVngMCHZFIo/PDpHNOKC8buJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6864.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2FPYmRQaVdlUWNFUGJjd1N3Mk5idnk0aSsxWFJuZlM4TkNCUlMxWjFEM3Nj?=
 =?utf-8?B?My9wVXMzMWsyY3I1bXlZSTNSM1lrRHBIbm84bk93TUhsSno1eUhiTFhLSEhB?=
 =?utf-8?B?L283UlNtTG01Zmk4WjZzRzU1OFZWSzM3WlVKVlhEcFRPdWdGNXlyU25wT1JV?=
 =?utf-8?B?QmUveU1nbkFMZjRUWTg4QUllWUdtck5ma3VoZ2dPd1hyanZ1MktBTEZ4eVM2?=
 =?utf-8?B?MDQvNGZnYW5vbEVVMEU1ZDFoSk9pb3JMZ1doeUozOXVZWDFTZjJ0aWsxTGE0?=
 =?utf-8?B?WWRKR21kNW92M2twY3BIK1p6MndFcGt0VFJzaTVhMWRoOVQxU2lZbGEzT1Vl?=
 =?utf-8?B?dHNNZW1EeWJUUGlpOWpScjZ2Vk9vOGtyYldMZWMxVllIVWt3MHVsSlhWN05D?=
 =?utf-8?B?TVZzak1JdmtsQVljK2dobWRGZHdMMGhSemUyU1RLcENrL1d3VklEZ2JGamo3?=
 =?utf-8?B?T1kvRHloSVhhMW92MkpyZjdVTHo1QjdFSkExajdodFdOOTArdGRtRzRmdWsy?=
 =?utf-8?B?T0JaOU5CVUpoa2FDQ2JwdUdPWTlrdFFRWGQzSlZMRHg0aUV3Um5Rd1JUelhx?=
 =?utf-8?B?eGZ1OStmRHdEbllqdFlXSktDVWU3MzBOUjVLaDJNblkrd21MRXR5ZWEwMkRF?=
 =?utf-8?B?T3J1eEtlUHE0QXBjTkxLYWkxbWRUenFBUWV4R09lYXhFYnREN0R1d2dyV0E5?=
 =?utf-8?B?VjFONGY5bllPYVJTZmFSZzRQZHAzckVGNEtZWGZVZ0d5bnZjbWMvdU5sZzhn?=
 =?utf-8?B?UUJMODhWdlF0dHN2VGRDQ2RDSkdEeFVvcVI5Q2NudmhFdjhVNDhhbHlMdmUx?=
 =?utf-8?B?czRES2RVOUNrNWNRMDI0ZUh6aFNZNGI0R09IZ1VFWTlJbUZOaUV2ZW13Vk9i?=
 =?utf-8?B?UkROQTBxNTBFNmJkUmZYQnMyaTNROUZ5T1RDZFppZkVGV2s5WFFxMVkvRk15?=
 =?utf-8?B?NzBiWWlVb1ByVWRFUng4UWpaNCtLSGFxdTc4TVBkK0ozdEhsMi80aTVaUkp4?=
 =?utf-8?B?QzBUVjdmeWdkOWNqb2dIRTB1dTZoQ2p6cVRPcWZwUjNiOStGS1NKYUs0OStq?=
 =?utf-8?B?UUNKR3U1T05NT3VvTGJQMTFSOGJ1bWoxeUEyQ01YenU4UE9UbTJhd3U4Ty9O?=
 =?utf-8?B?TTk4YXdDdjBoWGNIVnJNMkw5L0JIYnBJMUNGMUdKT2lvZ2ZXa0VyN2VoT0NM?=
 =?utf-8?B?QldaUFo5MExvN1EvR1gxdlNpMS85Qjk5UklVV1VWRzFVZ2p2ZjhYSzhZZU0r?=
 =?utf-8?B?bjBTamp3Y2xBd2YyWGtKZ0k0L0pqbEh3dFNnSFo4a3p1SzArQjMrVk9Nc25r?=
 =?utf-8?B?ZFkwMGV6WUpmeFR5UjBxY1JCdVJPUXhxYnBsUEZQUXcwM25TeGJEZHAxQzI3?=
 =?utf-8?B?b1FVOVRpTjNkd0xqVUxVT2Y5REVkNG1xeGdjakdxM2ExV3hpV21rRDlqcWMy?=
 =?utf-8?B?YVFhdHhSZitJTVBsTjVqMDRlbU9ZRGcrdmRZYXo5dDVEdUw4UlVOUDBuTnJR?=
 =?utf-8?B?UE5CVkwrcHFUZ2VhYUxTWUY3VHhkbWo5S0RmbDhxYkRqNUxVc3lrY05Gc2t5?=
 =?utf-8?B?M0pMRlZ4SE5zcVFSUjNtUGE0UXZpaTdMTmZ5TjN6dHhoY0FjZHkyNEhHbndt?=
 =?utf-8?B?NXpwTTZtQ21wa0NQd3cxYVF1K3lpaU55TmUwNCtSbExkLy81Si9SVCs1ak1U?=
 =?utf-8?B?OHUwczYzL3JiWGx4bkNGR3U5VHFGaHhWM3hUYVZSSHhheUtwVFlXRnNLREV6?=
 =?utf-8?B?VjVtWUt1LzQyWE80WlFaRHVYTWI1Rk5QYnIrY3hjSjBnbUNRTUtVZnBQSGNK?=
 =?utf-8?B?OEVjazZ1RkNZd2swUWNheGhTcUZCdVIycGwvSDNCOTFUdG9XN21walV1VWNS?=
 =?utf-8?B?WkJFRzE0VFhmQnpXV1lWdngzZmNtVnRUTFN2c052WjhscmRsWDVrWUNKb3Vs?=
 =?utf-8?B?V3daNlh2b1ZLK041Ynh6bGVYRnJvQ2swd2V5NDFITVJXN1NxWnpYUjhodnFp?=
 =?utf-8?B?ak5wRnhYY3FKYTZ5RDFLMkVXdEZlSU02WEdrQmM4amsyOFdjMmJqcHZLaGNL?=
 =?utf-8?B?VUVWK2VKWXQ2d0FuVjg2Wi9UZitsNU9XZHBKYzJ3ZW4vdkVnVnAza2FyVzda?=
 =?utf-8?B?ejFDNjllK1dsVW9xZk1ZZHBYL2wwQ0RCM3E2MmdmeUZHbzN0YWM1bzBGdEE4?=
 =?utf-8?B?TUR2SjJzMndUcTB6T1hoblJ1SHBUMVFtazdTTnFsdllaNnRRQkFvQkl4bTZq?=
 =?utf-8?B?L1JpZW52alZNSGoxbktjSnJPQS8yd3RkbXlJWGM2WnZSS3o4SjQyelY4TDVW?=
 =?utf-8?B?SDFnRTFMeE1NNS9hcjgrVk9kd2FhQUZpTFUwM0pDelNWb0kyNERWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ctiTEFaFb19+LBdyOn9cYATyL8GkRoB5YsZ3oLWV2G/QKcjqC5yz3gAyO4MhTz/AwoJHA0zRcHe2HNeF1KQJxTOuO4JKZnMgNWQQ6YDOvabwuggyiXRqa9F1e2H3UAq+SstXWM8QEFHH8LbRY7nMtd7kE+dFXLAs3R/1CTLbcOIVmEznafFoW4PBufBG4D5zgVCPaFqA9ySLZ+pQGyX8fsw+sBf+9ozKAhsw6MdyuMBflwNiqQoSc9DoB9i67i4+K0WWyzAEtTkAzk/s+1WDXvbUgRsirqfnFjtzbxJRV9aF67FisSLQqR9++tZf6xnchN1gxHmWbPBaA6UuseRMlA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593c95b6-b58e-4d99-ae92-08df0828f326
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 13:00:08.0751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JedrMsjH5mw+nWqnkE8kejPie+YhV3w33ir2jTtr1bMCjdjFKiH1Ry2tSFt5P7lqjkCeNF22u3YvRRFUOceegrrAVNDI3sG5btU4x3K+8j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8225
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLaXRzemVsLCBQcnplbXlzbGF3
IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgMSwgMjAyNiAyOjQ0IFBNDQo+IFRvOiBUZW1lcmtoYW5vdiwgU2VyZ2V5IDxzZXJnZXkudGVt
ZXJraGFub3ZAaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3Jn
DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggaXds
LW5leHQgdjQgMS8zXSBpY2U6IENvbnZlcnQgY3RybF9wZiBwb2ludGVyIGluIHN0cnVjdA0KPiBp
Y2VfYWRhcHRlciB0byBSQ1UNCj4gDQo+IE9uIDgvMzEvMjYgMTg6MTAsIFNlcmdleSBUZW1lcmto
YW5vdiB3cm90ZToNCj4gPg0KPiA+IEZpeCBhIHBvdGVudGlhbCBpbnZhbGlkIHBvaW50ZXIgcmV0
dXJuIGR1ZSBhIFRPQ1RPVSBpc3N1ZQ0KPiANCj4gdGhpcyBpcyByYXRoZXIgY29udmluY2luZy9z
ZWxmIGV4cGxhbmF0b3J5DQo+IGJ1dCB0aGUgcnVsZSBpcyAiRml4ZXMgdGFncyBhcmUgZm9yIGFj
dHVhbCBidWcgZml4ZXMsIG5vdCB0aGVvcmV0aWNhbA0KPiBvbmVzIi4gKHNhbWUgY29tbWVudCBm
b3Igb3RoZXIgcGF0Y2hlcykuDQo+IA0KPiBXb3VsZCBiZSBiZXN0IGlmIHlvdSBjb3VsZCBkZXNj
cmliZSBob3cgdG8gdHJpZ2dlciB0aGUgYnVnLg0KPiBPciBqdXN0IGRyb3AgdGhlIHRhZyAoc2lu
Y2UgeW91IHRhcmdldCBuZXh0LSBhbnl3YXkpLg0KPiANCg0KV2hpbGUgYSBjb3JuZXIgY2FzZSwg
dGhpcyB3YXMgbm90IGV4YWN0bHkgdGhlb3JldGljYWwuDQpQbGVhc2UgY2hlY2sgb3V0IHRoZSAi
Q2xvc2VzOiIgdGFnIG9mIHRoZSBuZXh0IGNvbW1pdCwgImljZTogWmVybyBvdXQgdGhlIFBUUCBj
b250cm9sIFBGIHBvaW50ZXIgYXQgaWNlX2FkYXB0ZXIgY2xlYW51cCIsIGl0IGlzIHRoZQ0Kb3Jp
Z2luYWwgcmVwb3J0OiBodHRwczovL2xrbWwuaW5kaWFuYS5lZHUvMjUwNy4zLzAxMzg4Lmh0bWwN
Cg0KUmVnYXJkcywNClNlcmdleQ0K
