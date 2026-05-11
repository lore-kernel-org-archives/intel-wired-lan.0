Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D457CD37AC
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 May 2026 08:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2CC4416BA;
	Mon, 11 May 2026 08:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id czkajf2GsWzu; Mon, 11 May 2026 08:26:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1C9E416B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778487961;
	bh=Ze/wmFuD8sCFawPL6pGFbVdK4znuHV7iA0kuF+AD1JE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1p4fhX/oVf5A14FSaKkN4gGHnsQ/MWWkwgVdI5TydPlgZv51Nuv9FxDnjy2/PoEC
	 dzg0+gWU0kuKzYPXoYUNbEj9u6vMuqvwjNTadUSiSa+caDodKNs/dse5dbJP0T2gbe
	 FXBArnfFosm3o+eGRHXSNBNZT4/+6WY2rCXf1E9GfJLCJtLY7dBsgxCqrr6whUENps
	 quKd68wNX3MLEnAuUkXdl3UieLY8VGrH+kMUrNQmCxBLwPhypZu0NRZzgxpSEFGS+x
	 2NEPtn4bZRtdGN2SRRv7MzbLVGbUfFa4QUd+uNG483hToEC3LQxsxfKFuUeUiOhlqk
	 FVsbmGTgJ5ZXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1C9E416B2;
	Mon, 11 May 2026 08:26:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0493D223
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 08:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01ED08445D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 08:26:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RSJCmlzwVJmY for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 May 2026 08:25:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 068A08445C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 068A08445C
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 068A08445C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 08:25:58 +0000 (UTC)
X-CSE-ConnectionGUID: GmybwB3CT0O7hKE7ScKCsA==
X-CSE-MsgGUID: U6krtbuYT56+gz9o5TTuaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="66900630"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="66900630"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 01:25:58 -0700
X-CSE-ConnectionGUID: KqmSBnn2RtCAfM1Mo47K6w==
X-CSE-MsgGUID: DhGTHj47SCuuiz2hCKLrAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="242357791"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 01:25:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:25:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 01:25:57 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGQ6ENh4NyvMbnnWEF5jGEWX2IoXf/SuBFFAnlFYLY/B9N23i73KS/Nq687qxDmOrCKOXUpmYiHXgteWJB28d1OzGMN8jGnOVOPCwDer8Zo4DNHH0DVjhnkj+vhiiSTTQuPcqFdGdXA4CJHzLHKAm+CR6rZ7Gw/+fOYA8G4YSi5P4l1/GO+00Qweod8sY+6ohRTAS8xEDEdMhZBrGS0H3YMDcGnfoChlKS0LQXRsa/2m3E08ToBF5fpmOqV2Dr1UoLHGSgsg52/2u1riILgARI0kEOCE+t9zs0vy+J1gQwT862Ai4JNYA6rcONTf/hF0JHg4gX07TB4nzt9VbKtg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze/wmFuD8sCFawPL6pGFbVdK4znuHV7iA0kuF+AD1JE=;
 b=YUknoomlDaGYAPtujDZSJBiISO0QCPJQHvQWh1sfYPre54HaqhEHCc2Ew+sJ/vFSsvdnmqija+tyG+heA3qR8M1vn8GT8NjE8qFMkYwO8zDZBpPzXEf5QYGfwRJXDpyVvBl4d9Dv5yVdrHzw7YJaRy3KGJ65stnDV4566rayc0nsI1vhoRW05N4fFjcQQU+/QqVRYDeZ9YkgDG/knOfNQ229iDqFtzNiKiR12n6KYiV7q8ieSanKfAVLdizD9eNhoKKJcftBRXHs5Dtl6K3QVcpG3UblOG7v7xUBdqC2YIziekNtxD3NETevXTApCw366cpiimnkMD+naoofEqdWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:25:53 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 08:25:53 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/5] iavf: fix error path in
 iavf_request_misc_irq
Thread-Index: AQHcyxeH6XNQjcNIdE+Fr+k09WPXKbXc4hiAgCvHPGA=
Date: Mon, 11 May 2026 08:25:53 +0000
Message-ID: <IA3PR11MB8985A677535A94094B79C02F8F382@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-3-aleksandr.loktionov@intel.com>
 <2a90e151-2e7e-409d-9123-1e261c1a24f9@intel.com>
In-Reply-To: <2a90e151-2e7e-409d-9123-1e261c1a24f9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH2PR11MB8816:EE_
x-ms-office365-filtering-correlation-id: e59afa15-3fce-4bf8-c014-08deaf36eaee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: QbJQFqxkoEdnGpUK8hBCt9f5DqCPH4NMYBJgrGG+ogMnAcZjcslEW6Kha0bkdJQsGlqfBBI5a7qPSKZVOBv9fKFBLiogKSphqW0aS8JOqJOBwMIfVTD5uQCOm6gaxncbnRMz9y6JBKSYHqu0Gu15ajRQ+VTqNrTr8IuoK4pFuOWOC6w8gECkBog1PBzHdNTMnhgXDUN2reNG8uvu552JMoVeRzlWU+/4fBLnu4Wv4zFZnzzwulUzzpH2oXI/xylv6DAzvBcRSwuocm8thfiT9Rin+xCn4YBXOdwd69EFDwO5N/0qcBc3nAoc8l399SdJS2HNYvgm1r184AXS7UTRubguC0TBiCk66g3xRXQQuec4+60RD9qdO9lt88YvepkS3fvf8Fb+moupeC+v8VSp3Sk+82a92aK0bl7BD6FEnPRGFbwBvCk0DOtl/nppOZgFPHK+HCbf80BuHEIy7Y1jdgTpTNjD3V3ldz6AltlWwGWq9LzvZbKzWRctYWckwSS7mooWWiOTyw1izyzs70i4je/nk86hgcXPjffPDQb7wVEZH824bv2FzSuzpOqHknErmwoS5DHKyp8bkL98+zDKd51YlwUHAefzqyX+x28SriOWJR48Ed8gdArdLrW8u0BSKnAr6/OrhfuAP4DBgSkxhMphvFylCITcksh9qDZ8x4dN7aalQa8gJgJIN/0L9zhn0CSHUWGZ8y1EFrD0sRQo7r3wM04jhZ9DrmhMnUKJB2IHBJAY41UlWKBTA0doKrAg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGx3QTNaRXczcThxZ3FUMUh6UHVLaGR6ZUhLa3ZPK0szWjMzdk9TWHdvYnNB?=
 =?utf-8?B?UWduNDYxckpTNC9UZlNzVHdjZzlhU3lNcVRKTGVjSWM0SllyOTFuUUt5MUtl?=
 =?utf-8?B?L3dEbXU4blFiNStMNjcxbmowS2tYUEY1RWdDei9OY1JkU3graXFCR2N4NTVz?=
 =?utf-8?B?YzJ3SW14UnN4TzhiMVJGTDIrcXBNNVVWcldhdmdmMmxVbmdYZzZxNzhFNEdD?=
 =?utf-8?B?RzdVNUhIZnJYV3haN1FPTVBUMG1tZUxUQVhwUEZoUHRsS1d0N3hpaHRiazBU?=
 =?utf-8?B?UzlHakZkdkkzK0RRUGJIS1F2MFVxWmxndkpnb00vaTRrb0tEWFVnb2hRTFFi?=
 =?utf-8?B?ZVFiQXVISTd4UVlwcFJRK2pvUURGSzErMVRYb21wVW5RQTlzdGlmdGpPZlE5?=
 =?utf-8?B?RzdybDd3SmJYOFkvQURlV3B2TVVjZkg4aHUwcUlwa09BZ2UyYlQvcHhGdlRD?=
 =?utf-8?B?bnUzRmhMVG1GK2pFSTdwckJ6TUlJTmFDSUhkVDFEc3lKSi9kTTFDWU8yd05X?=
 =?utf-8?B?NDFMcHVibFg2RkI1T1FkR1NvMjVyRWNIcGMrNFl0MXJqcFdQanVOeHJsK0Y1?=
 =?utf-8?B?RFppamFTaUlkZy9ib0g2bFNqUjQrQzcwMUg2YXRENkQzODVXeGszSWhXSEVL?=
 =?utf-8?B?OER1N2pYUFZZQStHQXE5dFhSUjJ5MzgvRzNlUXFGRXlJTGFuYVRpcDIra2VQ?=
 =?utf-8?B?RDRiUUFOblpxL1prOVc1Sm1LcU51MFl1THhndnhvZXpoUEpiZmFEV2hmWFpU?=
 =?utf-8?B?b2UxNnNjOXd5WXY1WlVxUmxURVN1ME9HMGZuSEpUUEpVWkZNY05zTkFYcHhp?=
 =?utf-8?B?cmxsVzcyM25JWnZndWk0RXZHTUl1STYrQjh2WjBMUm1xcXRqZlhnam00YWtY?=
 =?utf-8?B?YmVncmg2SEZvSU0yeE9yc0dLaUZmcHJJdVpGRDlJU29hYTNWREFQVnFiOTVX?=
 =?utf-8?B?OWY0RmlnbTQzenZzQXdidG82VEpmV01yUzNxaFR2VlJDVU1zWmpxMEhjUFVX?=
 =?utf-8?B?ekppSHpyVUszeXZMTmI1bE1ORGZCMVlzc3c5NDQzMUsvcm9tN0YvOTNBNVpa?=
 =?utf-8?B?eVdHVGxHZVFhakRvODV3UkxiVHpRUUd5QXZNR0FhakNqUFVTaHFSSU5SSWh0?=
 =?utf-8?B?OGtQczNBdU9pbXdEMFE2M2k1OFRVUVNzNFpUYnpWQ1A2Z2VEZjdaa25CMkJY?=
 =?utf-8?B?ZjhYK2RjZ1hLczZvclY0TDhTUnVQMlljMnpaVnFLT0hJU0JDUVhoREZRbHpV?=
 =?utf-8?B?Z0c5amdxTWRxR0pETFlUYk84KzZPVTJqRWJXNFZ1b05NOGlaTG84NXJmVklp?=
 =?utf-8?B?aWRaQVVGQ2R6Zzg1RzN2LzgrY2NvaFE0QWV6c053Umx3aU5rZGpsNzVvZmh5?=
 =?utf-8?B?c0gvc0EzcUJHMjZZNkNIMUV5SzRlM1VrT0M3T0s0dElZcHN4VXFMMWtFemxB?=
 =?utf-8?B?TzBTZ3BQcXNianREeVFiVjI4M05DdVhScXhVYTlHM0E4YkZrUk1iRHRqVVox?=
 =?utf-8?B?VFpFUkRFR1ZESE03djFtSEdlK05IMWllUk15S1E2ZDI1d3pEUTNua3hUKzNk?=
 =?utf-8?B?YUxhc1psVFg0eE5UR1BKd1M1d21DeGVZM2h4eXJOWlFNYkcwaUk2c25FSTRu?=
 =?utf-8?B?MnVJaEx2S2R1SDhmOHVmdHhnVUNtY2ZpVWRnL2RFcXNMRUlBeEFJSm9VMGQ4?=
 =?utf-8?B?ZVhiZU1EWHB4ai9ja0xHNDZxZ3BaRWRDMnZNSTBSa3Q0eHdNRmUrcVdIM3I5?=
 =?utf-8?B?VFFJVlpBbnhsN3NpV3NSU0JCNzk1bWdZeVVVM241VDVOM3BPYXl3a01mN1Fr?=
 =?utf-8?B?NEVsblNFQ2FFQytCSXBVVkhabExKZ21qTzd3MStUNDE5L2NRRHgyK1N0MTlW?=
 =?utf-8?B?RitjTi9CRzVleHVKOFNnRHd0UGNmNk4xelVyN2IrR29DbnFJd0tEOUtvM2lX?=
 =?utf-8?B?RGxNMitSODdMdW1uMjlkbEJYa2V6ak03OFIzNldKKzVOWUt3Yml0T1BuWWFr?=
 =?utf-8?B?M3lhVDczWWFXMVlpV0J1cmQvQUplNUtIbzVZNlRudHpEL2xaNlh1MHJOclFk?=
 =?utf-8?B?NmFIZWFCbDV3RU5qWFQwOVdaYlMvYTBCT3FGZDV6THdJUHFTb21PbkVVaEpi?=
 =?utf-8?B?Sm5maSthM044UVFwanJmdWpxb1owK1hiWG5nTzA5ckVjencwSTNDT3BIUFRM?=
 =?utf-8?B?UWtKb1h5MzkwNE1TNWRLcTN5aFZuelpOY2hoY2NqOVV0dG95Y0ZhUXdkZU1L?=
 =?utf-8?B?aDB5YS9lWG9LSGUrSU5BVm5tdDU5ek9tck8xZ0FIZkhHVlVZM3VaWWVOczhM?=
 =?utf-8?B?YjBQTGR3alZ5QmtzQkhZOU5HOHNQMDk0ams5L0UrMVNzenB0R2JCdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NJvV03xI+I9OsPY4Y2jCAs0Rrdj3wZBXFcZ5pQrFr4pM44bQUiehttZzOqW9FZhartbeInga54bNFeHM78ETxlsedNYtUiybswJWP8TWQRT+TinOt3NN4zcHe3VLBuY2YhVtcNfatd8iazSm2UmKQkD3/te37E96YbsnwesUnPAyE37ob96+IC819+vt1SiyE5DWRnpOWuIRD0mDqVCJ85VtHPhBrDoJzzjmwA+s/ZzfQyqvOnhdgtvEamiWFY12H49/rCPzKfOq4uILY+J+r/ws/cLfOwwdD3ZLqJzI4lS8s81fxqt4gCr8mKHZrJZ4lXg/9V0VmgJiDIMa6zWB7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59afa15-3fce-4bf8-c014-08deaf36eaee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:25:53.7660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhpPjjibexirlbaBn8P2KjiiCLSrYN1Hs97S9NIKc5nATwKOPsJEXOMT1+nGyvKoapTNxmDh6D5u72vvRSpl6txmFw6SZrj1ZNbcPdT+Nv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778487959; x=1810023959;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ze/wmFuD8sCFawPL6pGFbVdK4znuHV7iA0kuF+AD1JE=;
 b=hZeY1PSyM2xkGzA7X5KunDVhxHRRdMs/ZsN3/NuZkuxqjn67nurmOtPj
 xHwpHyBbsEQkA3ZAPBwlr2hdUvzktpfCQpcHorBCVrvhGJKE+gY+A4fSx
 vf4iildF3fBfmJqYUW3jSkDWF0waWLQILU0NZRUy+qb5BD5xUCeYJ12KB
 fzNMv0Bjd6XevJzWBERck01gEOngmK03R6MTclMIx1cJUpug/LavrIJL4
 TE2fjBv2aZO3gMkeeM1rsWNAlGUAHMzGdTwokY9W+Ik727mRyj0qolOrN
 tG3WJ9CjqZ8XEiRa0a3EwUZjRiBEdhxuYhGpRryP2Ur2nDlh7bQbM9k81
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hZeY1PSy
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/5] iavf: fix error path in
 iavf_request_misc_irq
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBQcnplbWVr
IEtpdHN6ZWwNCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxMywgMjAyNiAxOjUzIFBNDQo+IFRvOiBM
b2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+IENj
OiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9y
ZzsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXQgMi81XSBpYXZmOiBm
aXggZXJyb3IgcGF0aCBpbg0KPiBpYXZmX3JlcXVlc3RfbWlzY19pcnENCj4gDQo+IE9uIDQvMTMv
MjYgMDk6MzAsIEFsZWtzYW5kciBMb2t0aW9ub3Ygd3JvdGU6DQo+ID4gRnJvbTogUGlvdHIgR2Fy
ZG9ja2kgPHBpb3RyeC5nYXJkb2NraUBpbnRlbC5jb20+DQo+ID4NCj4gPiBXaGVuIHJlcXVlc3Rf
aXJxKCkgZmFpbHMgdGhlIGludGVycnVwdCB2ZWN0b3Igd2FzIG5vdCByZWdpc3RlcmVkIGZvcg0K
PiA+IHRoZSBkcml2ZXIuIENhbGxpbmcgZnJlZV9pcnEoKSBvbiBhIHZlY3RvciB0aGF0IHdhcyBu
ZXZlciBzdWNjZXNzZnVsbHkNCj4gPiByZXF1ZXN0ZWQgdHJpZ2dlcnMgYSBrZXJuZWwgd2Fybmlu
Zy4gRHJvcCB0aGUgZXJyb25lb3VzIGZyZWVfaXJxKCkNCj4gPiBjYWxsIGZyb20gdGhlIGVycm9y
IHBhdGguDQo+ID4NCj4gPiBGaXhlczogNWVhZTAwYzU3ZjVlICgiaTQwZXZmOiBtYWluIGRyaXZl
ciBjb3JlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW90ciBHYXJkb2NraSA8cGlvdHJ4LmdhcmRv
Y2tpQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9tYWluLmMgfCAxIC0NCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX21haW4uYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWF2Zi9pYXZmX21haW4uYw0KPiA+IGluZGV4IGRhZDAwMWEuLmFiNWY1YWRjIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9tYWluLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfbWFpbi5jDQo+
ID4gQEAgLTU4Nyw3ICs1ODcsNiBAQCBzdGF0aWMgaW50IGlhdmZfcmVxdWVzdF9taXNjX2lycShz
dHJ1Y3QgaWF2Zl9hZGFwdGVyDQo+ICphZGFwdGVyKQ0KPiA+ICAgCQlkZXZfZXJyKCZhZGFwdGVy
LT5wZGV2LT5kZXYsDQo+ID4gICAJCQkicmVxdWVzdF9pcnEgZm9yICVzIGZhaWxlZDogJWRcbiIs
DQo+ID4gICAJCQlhZGFwdGVyLT5taXNjX3ZlY3Rvcl9uYW1lLCBlcnIpOw0KPiA+IC0JCWZyZWVf
aXJxKGFkYXB0ZXItPm1zaXhfZW50cmllc1swXS52ZWN0b3IsIG5ldGRldik7DQo+ID4gICAJfQ0K
PiA+ICAgCXJldHVybiBlcnI7DQo+ID4gICB9DQo+IA0KPiBSZXZpZXdlZC1ieTogUHJ6ZW1layBL
aXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiANCj4gbmV4dCB0aW1lIHBs
ZWFzZSBDQyBuZXRkZXYgb24gSVdMIHN1Ym1pc3Npb25zDQoNClRlc3RlZC1ieTogUmFmYWwgUm9t
YW5vd3NraSA8cmFmYWwucm9tYW5vd3NraUBpbnRlbC5jb20+DQoNCg==
