Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30C0C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 04:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E4AD80F77;
	Sat, 22 Aug 2026 04:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fC3_CmxphJb; Sat, 22 Aug 2026 04:16:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787372171;
	bh=95iloDU78JhQYom0+gMOKXtmI0z6qFYqjCEu3IC+pTg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5VJZSqsytL47TwOPRtSxvsqPvAGpPwktjhMdX34sqKd+urASaLpoR4go46H6WzWKW
	 7Soz91zYCJMxNKEMpcMkymoxVsVTZpbL5H92HByDVKYhIE8VguF6JGHX6ugTHjSq9A
	 6ndddWxSQLdqDadiq4rVZPPj0roHo72ogotHJRri5aYGz0oo/T6TbC3EzydvqvSn99
	 XKY25eJjPCA0K2IhM0KgPteGaeu9KINvGcfl8REhxwaX0IW4l4xkOGgn+LBOWxuYzd
	 a2zp3CHYZZUct/LBa+S12nSrzI1GpDr7pGxICinRxBQesClQWZZGuwnH/nmKjhK1ao
	 meYDlNaPIe1KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC90D80F68;
	Sat, 22 Aug 2026 04:16:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16E3E476
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08F7640125
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHnW3hBnV4UJ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 04:16:10 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=k90lcNQy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2BCD40097
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 04:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787372170; x=1818908170;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=95iloDU78JhQYom0+gMOKXtmI0z6qFYqjCEu3IC+pTg=;
 b=k90lcNQyaX6hHXhxH4yUYzIc7hbPkfIf49A8tYWDrYjH5PVocB5XgHbY
 5PBSwRqK8TVQGhzypAypCX3Sc1sw2hP+LicGnYSD0wFuIaMOqE1PwD4u/
 K6/YVmxWcFAfR5aDH8/DAFMSdcyAYRytzN7Nb5SVpKK90Xx5R1CTMn02i
 rtdi54sFgtufDeG19ypt3R23+N/MSpu/Gb9ooLk2a6JZB8oMxxZufF0yX
 iVvF882ks5KXUy8YCNcaU6fZLkELmPLc4BCHgxYh3zDmPmx+sOCTeVtmv
 QAeqZBOE66Cb9BWOknafyMlaYFEBOMbH16a/68blJEqk9ljlUnYZNswRU w==;
X-CSE-ConnectionGUID: M9inAy/+SHeyfuqO49TNqQ==
X-CSE-MsgGUID: Sh0KxR3CRbyTNQY7BXTgiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="98251436"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="98251436"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:16:09 -0700
X-CSE-ConnectionGUID: cLBLMfsoQTuBle+HfT9JBA==
X-CSE-MsgGUID: 8xjIqFFHSReqIxFsE4WNUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="290040571"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 21:16:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:16:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:16:07 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTZleJxIgxcfrP9RVoRxEOP9u5SiCByDyz2W6vIZbIaYEaLJDUgu36208rIJ+iDL9pVmnlM3+MlF2vu+9RIafnFLF2UMP46+kqUdyoQQtgQyu1XawDnh2V9P8j0UWHBXAGWUQMCOcGQC7Ad2tOuo71rB+p3QkmYKqqindenpDRnDsL84IMu/hDurvwbRYk/VMSEmJWpCLdlpSAVMUTpiNRcaLoVdvLAEI+re+442r4bk1lSPMUBlKHHJ21NsERuABDSu/DXMLPCAkb6J52iVfvy6mX8UYcDVyrMx5XCAa2f1qv1mZH2JV/gj6gqyGoBwp+qojlJs+O8pv7YmijwwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95iloDU78JhQYom0+gMOKXtmI0z6qFYqjCEu3IC+pTg=;
 b=geA1sVfsYL45gkkW18X+/GUpd8VCmZHxpgJaaSo1PiXRYUNF8GgoS/Y8AzlzP1U8QvMj1rGg0GA2JQFeRk78zebuJ5Yqm84iHk0Pr9syCdy0G6gEad1pmbgd0hNplNjNLlALI34jWK0oKOpB09EgT0sSDkCgeKGv17Q7v2X8sNww3iwgEFoyiKUsHCcVV0M7FdIJ/KgVWZHOPjvIOBzwORfpYK9GYFRzub3l3mT5aXZ8bSvnkPPT8hfnPNeMnFptdRKOhl9fSjub0DVt5HjeaKETmuNO8wz+qG3J6KOMuh1DTn2yRZLjOimeHW/s3SPPh9NGVbTp7GEmhCiYzut9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:16:06 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:16:05 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net 05/12] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Thread-Topic: [PATCH iwl-net 05/12] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Thread-Index: AQHdMctMgUyE3VMQw06C/iDnvEzuIrapdiHg
Date: Sat, 22 Aug 2026 04:16:05 +0000
Message-ID: <LV1PR11MB87904D7D9330FD3947B3E56E90A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-5-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-5-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 9c5a5c8d-92a5-4408-6197-08df00041603
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: sosvHBLU2TsV6+3ddEGTpA4VKOaFzH3XRkCcDpogJw6rqX3eR2AWL+OGoTGKD3ilE0Q42vJMb8L6q1AafqC2YoO+773kpFloVhUWMSMx1oy6waCdWld7jfnsPBS6UWfuLFO25VMiAodHFMXJe0zQ1q0IA8J1rtSXTvai6QZ5M55qEdfeDmZtZtFKs1AOm8wVLRxONLVhMpMCLOGabF+nB5B3gGZUtE6Gg3Kl1uFCGrwzRSLwL2qjlpEFHroeW0rxd9aVRrIhNwpcIx6LNdm7F/efBQEZAij6PxEw5XSITszGbrRXpWnCL+U2Ui2yX/l1WMB+THedNFR6uc0S5vAqpOtn/uKKNcOUOC+9Lo0wKUA9WTBwT3bcUYnSH9o8s/VXm4EEFVnT1meiSjvqAnAJ4WIncTxzq4qfvd1JpE6swQuY44D8Bmv9L1wpR/AdizXdNeW4aymleAFIm1cQNwFUvVr8PYo+xWNxOvgvqru7rMSiqEfZtOlxwJDBSzVHnNelIWvqjaSP/45w/H5ra/hnde8a4sFEoJu3haexqYb/OAJ/k2EPim+Ae62RnluF/FuErjfQT23ziniECVh/nGhf7pF7X18ehtOTo2KHum3iyePejG0dh9a6D08v4FxoRoFcWCarw+rP+2SkH+ur03M5b4QmdaqPkDNoCk7Y691b/i4ZM9fJl2PH3aFQ9DWiyceF5k7WYMzBx1M9UdLhZ7nQ/NaAvBZ2GX7ZnCV3l43dhUk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmlPQy9QQm9IZUQ5eTZLQ2lQcUhlTExsVmUvZE5ZeEs2R0ROSWQraURHQjRO?=
 =?utf-8?B?ayt2Z2t3UUxSVENVbW10aUtZdDhsQ2NWSjN0OHhMZ0hrWURoK2ZWM0xhcFJ6?=
 =?utf-8?B?dmVpSXEvZEVMaVpzMEo3STF5RFZYZXlDbWx2RU5LM1VoM3pmM3FsUGsvWmEy?=
 =?utf-8?B?NWc0dU1maytRTVRxdzhwTTUyM2Z3RmRURmJMNk5uSlRlSWl2SDRET1Jyem1i?=
 =?utf-8?B?aCtQREdaYzBsU3VnU2pFa2FFeHJyUS9XTm44SllsK2h2Sk1CNTZ2ZG5mc3hR?=
 =?utf-8?B?NWRlU0phM09abC93ek5zV1dtbE9ESTBUbENzM3NLRDdvZ2NGMSs4K1pmMFZa?=
 =?utf-8?B?MktGZ3ZwR1ErMTM4S3htYlpqa1F3aHF2aUFPQ1E1LzNDM25PZDdJRXBES1lt?=
 =?utf-8?B?VTRzcXB1RUZmeWd0MVJSOEkxUmFwUkl3NkdxTG5ndE9CSGhPcEFOTXVnbEdn?=
 =?utf-8?B?dzJaZmR6bGt3Z1dpeFhiM1JEaDBzWGMwa3N4NWUxaTExTWtJMmp4WHg3VStm?=
 =?utf-8?B?WkVvS3YzbFhQK3NKSlZIQ1NDbGlhOFBxc3I3dThzZklocUFLc0wwSk9McWZT?=
 =?utf-8?B?OW9QTjU1R2ZyVFBqRlR0ZTNuWkRST1NvNFI5cm9GdWIyRFZJRWFWYmZ4cDVj?=
 =?utf-8?B?ZkR5TDc1WGdVTExMakpLKzFyRFlnR2MyMXJaL0xndURmODF0cVRHMXZMTmoz?=
 =?utf-8?B?MEY4d0FCUS9Sb2tOVGNwZ0s4RzZjNzRQY1NrZXNuRE13V3BDTzN4Z1VKbmVl?=
 =?utf-8?B?Y2dBZnY2Zm9vNlY3K1kvTktJdUdEYTd6MnYwajBQV3JobGdzQmxXNlpDZDE5?=
 =?utf-8?B?REl3VDdydzJYMEpXM0FncmtwREIyZStCbS9sRHJEM3dDU01sV24rcTBWdzB5?=
 =?utf-8?B?TWJ6OVk2N0RIa3lkTTZCNlpWYklSZkZqc1FWalZJRUZSY0Jpa2VuN3hsOFNa?=
 =?utf-8?B?VVRJZFl0elo3NzRwbDdQbXlPb1lGMG5HdHVLWGZWbE4zSWhpdW5oTmxueXBX?=
 =?utf-8?B?N1ZXQWVNSjVLdU9OUkRPam92blo3VXVURlgxYmRqTGNoU0VZYjdlU3poMkhU?=
 =?utf-8?B?cHd0WVRPTTY5NGlqY0ZKTnk5WWJQWitaT3JveUZTdHNCZCtnd2Rzd0l5ckZs?=
 =?utf-8?B?dzVrTTVpL0JKQVRqMVVoTEx4NUptRUZlSXNJeWNZZG1telU4dGZUSDRBRlQz?=
 =?utf-8?B?dUk0c3BiL3ROYTNkVWk1b1NkUjR2QitwVDkzTG9Xb0lQOFdhaE5VenJ3aDFU?=
 =?utf-8?B?QWFHMGNaUndtWk16aVdTWE9ZUERVZmQydGVXamV3SFhoWSt1TC82VU9WaVl1?=
 =?utf-8?B?aHdDR0RUV2Nqd2VqUE1temdkeEp6bGlZUjdkUnZTV0lwRnZTZ0hLZmNPV0k1?=
 =?utf-8?B?djVEMTNmNTM3OEhnTmZpaU5rcnV6a3BJR1ExTUwxbHdtMUErNDI0Rnh4Vndw?=
 =?utf-8?B?VHdmZlgzWnZ6cWhjbXphbTNSL3JoQWpZZ0VCMmdKV0w1ZEVGaGgxRlhQN0Zl?=
 =?utf-8?B?ZVdvZm1LbWhuTXF0VU1FZWhoRnBtTVZrUzBVZW1XU0tBNTBRUTR5NGVQQW5S?=
 =?utf-8?B?VTRWN3l4T05OckxadVB0WVVuN205Y1RJQmdwSWJ3TVVqRjJ2RHp2TUVzR1R2?=
 =?utf-8?B?dGFodGlMTWdwTXlKY25lamFvRE54UkdDUGNQOGNscitPT3Q5T2pHNDM4bmdX?=
 =?utf-8?B?RTIrNjdBMlgyTzh2aGFHYzd1VXVoWVJLa3VicGtiVEllR29XNmFnQ2laVE41?=
 =?utf-8?B?NFRNSldIYjl5R3FsQnZtNmhZeXZvSDUxVCtHUVp5RHZUVE5tdS82L09DdEdq?=
 =?utf-8?B?MzdpcmNReTZndElyMEh6bnplbkRZVlFycWxzZUlUaXY1VlBrbnRDNEJPU1hr?=
 =?utf-8?B?V0JHMytIcEZVb1pzWU9NR09wV1EvMFFjaDk5ajhVQzhoVFBNNTFCNW5DV2h5?=
 =?utf-8?B?aDczQU9PaWdpTGU0d05DRnhpVEtoMlJNUmpydFlhMkZDbkp5U2lJT0pWSHpC?=
 =?utf-8?B?Wml1cFI3ZEtkV01VMFJuZXJKa3JTUkZ6cVpXRjdYamExb0dZQ3BDUklCT25l?=
 =?utf-8?B?aUdnamZJRHg3dDZyeGtMRHRMb25nL2hoZUhMSk0ySUgvTHRVUlBWTko2MmVR?=
 =?utf-8?B?WWkzWUk5dm9kVGdhVG5pS2JVazRobytGak5aV2lWeWdYS2szMVNNeTczNFo5?=
 =?utf-8?B?Sk1ZMlpBK2JSV1N4TWJ2U0REcExDZTJ0QlI1K3l2VmF2SWFndldXRU45b21U?=
 =?utf-8?B?eXFHQUMxR2tlcUU5QkthVTBIeXR3U3g2TlExVWh6aStrcUUvc2NVZmpRb0pU?=
 =?utf-8?B?Vk9MZy95TzRXdTZmTkFWZkdBVzJReE1XSDllWDMybVI0RUZ2REUvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UUIjyjHmn0vO0tI2qH7vX1hEurg8OB+O7BMTOzt9uaT8TWUoFIgLYNEEK0ifbrjwac0hh/jcC6vd98uFBk47y91BjRuQjfADWlmP3cfPW4qkuhq+NWzS8fVpQHCkQCN39XMuBhuykzqqMC4q/4kv/dU/qniYkl4mkf6tzuYUWQU/jm84IyE8jy2nTUSbeZ5/2rzhkYNV8yFA7/+SdsPPF2TiPXwQc96WnsLM5JcoIkdmsFJGEWblc9X1IH3HbiMs88VIqn/63vu4mPQORcMW23sJf4z3Lk85Q0ZXbxSeUZwBahhS3Lsbxr0Of2UhwJ+oOsTbL4eapc3bHSc9aW9w1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5a5c8d-92a5-4408-6197-08df00041603
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:16:05.8472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1VTcRGfquPDDEsQuhDd4jCJ0up4VvdtZVwxuWvlhrNBwxYoO/Zbit9r2tKHr96HJ08dz6DR7na5qwRcjnEBiP1Vla58UISodIGe41PmBpI=
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
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBNYWNobmlrb3dza2ksIE1h
Y2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBp
d2wtbmV0IDA1LzEyXSBpY2U6IEU4MjU6IHN0b3AgY2xlYXJpbmcgUEhZX1JFR19UWF9PRkZTRVRf
UkVBRFkNCj4gDQo+IFRoZSBpY2Vfc3RvcF9waHlfdGltZXJfZXRoNTZnKCkgZnVuY3Rpb24gaXMg
Y2FsbGVkIGJ5IHRoZSBkcml2ZXIgZm9yIEU4MjUgZGV2aWNlcyB0byBlbnN1cmUgdGhhdCB0aGUg
UEhZIHRpbWVyIGhhcyBiZWVuIHN0b3BwZWQuIFRoZSBlcXVpdmFsZW50IGZ1bmN0aW9uIGZvciBv
bGRlciBFODIyIGRldmljZXMgcGVyZm9ybWVkIG1hbnkgc3RlcHMuIEhvd2V2ZXIsIG9uIEU4MjUg
aXQgb25seSBjbGVhcnMgdGhlIFBIWV9SRUdfVFhfT0ZGU0VUX1JFQURZIGFuZCBQSFlfUkVHX1JY
X09GRlNFVF9SRUFEWSBiaXRzIHRvIGluZGljYXRlIHRvIEhXIHRoYXQgaXQgc2hvdWxkIG5vIGxv
bmdlciB0cmVhdCB0aGUgUEhZIG9mZnNldCBhcyB2YWxpZC4NCj4gDQo+IFdoZW4gUEhZX1JFR19U
WF9PRkZTRVRfUkVBRFkgaXMgY2xlYXJlZCwgdGhlIGhhcmR3YXJlIHN0aWxsIGNhcHR1cmVzIFR4
IHRpbWVzdGFtcHMsIGJ1dCBpdCBubyBsb25nZXIgc2V0cyB0aGUgdmFsaWQgYml0IGZvciB0aGVz
ZSB0aW1lc3RhbXBzLiBUaGlzIHNvdW5kcyByZWFzb25hYmxlIGF0IGZpcnN0IGdsYW5jZS4gSG93
ZXZlciwgdGhpcyByZXN1bHRzIGluIHRoZSBpbnRlcm5hbCBvdXRzdGFuZGluZyB0aW1lc3RhbXAg
Y291bnRlciBiZWNvbWluZyBvdXQgb2Ygc3luYy4NCj4gDQo+IFdoZW4gY2FwdHVyaW5nIGEgdGlt
ZXN0YW1wLCBoYXJkd2FyZSBpbmNyZW1lbnRzIGl0cyBpbnRlcm5hbCBjb3VudGVyIGFuZCBzZXRz
IHRoZSBhc3NvY2lhdGVkICJyZWFkeSIgYml0IGluIHRoZSB0aW1lc3RhbXAgbWVtb3J5IHN0YXR1
cy4gVGhlbiBpdCBjb21wYXJlcyB0aGUgdGltZXN0YW1wIGNvdW50IHRvIHRoZSB0aHJlc2hvbGQg
dG8gZGV0ZXJtaW5lID4gaWYgaXQgc2hvdWxkIHRyaWdnZXIgYW4gaW50ZXJydXB0IHRvIHRoZSBN
QUMuDQo+IA0KPiBVcG9uIHJlYWRpbmcgdGhlIHRpbWVzdGFtcCBoYXJkd2FyZSBpcyBzdXBwb3Nl
ZCB0byBkZWNyZW1lbnQgdGhlIGNvdW50ZXIsIGNsZWFyIHRoZSB2YWxpZCBiaXQsIGFuZCBjbGVh
ciB0aGUgYXNzb2NpYXRlZCBiaXQgZnJvbSB0aGUgbWVtb3J5IHN0YXR1cyByZWdpc3Rlci4gSG93
ZXZlciwgaXQgb25seSBwZXJmb3JtcyB0aGVzZSBzdGVwcyAqaWYqIHRoZSB2YWxpZCA+IGJpdCBp
cyBzZXQuDQo+IA0KPiBTaW5jZSB0aGUgdmFsaWQgYml0IGlzIG5vdCBzZXQgd2hpbGUgUEhZX1JF
R19UWF9PRkZTRVRfUkVBRFkgaXMgY2xlYXIsIHRoZSB0aW1lc3RhbXAgY291bnRlciBpcyBub3Qg
ZGVjcmVtZW50ZWQgYW5kIHRoZSBtZW1vcnkgc3RhdHVzIGlzIG5vdCBjbGVhcmVkLg0KPiBUaGlz
IGxlYXZlcyB0aGUgY291bnRlciBvdXQtb2Ytc3luYyB1bnRpbCBhIFBIWSBzb2Z0IHJlc2V0Lg0K
PiANCj4gQWNjb3JkaW5nIHRvIHRoZSBoYXJkd2FyZSBlbmdpbmVlcnMsIHRoZSBQSFlfUkVHX1RY
X09GRlNFVF9SRUFEWSBiaXQgaGFzIG5vIG90aGVyIGVmZmVjdHMuIEl0IG9ubHkgY29udHJvbHMg
d2hldGhlciBoYXJkd2FyZSBjYXB0dXJlcyB0aW1lc3RhbXBzIHdpdGggdGhlIHZhbGlkIGJpdCBz
ZXQgb3Igbm90LiBTaW5jZSBjYXB0dXJpbmcgdGltZXN0YW1wcyB3aXRoIHRoZSB2YWxpZCBiaXQg
Y2xlYXIgaXMgcHJvYmxlbWF0aWMsIHRoZXkgcmVjb21tZW5kIHNpbXBseSBub3QgY2xlYXJpbmcg
UEhZX1JFR19UWF9PRkZTRVRfUkVBRFkuDQo+IA0KPiBOb3RlIHRoYXQgdGhlIFBIWV9SRUdfUlhf
T0ZGU0VUX1JFQURZIHBlcmZvcm1zIGEgc2ltaWxhciB0YXNrLiBIb3dldmVyLCBjbGVhcmluZyBp
dCBpcyBmaW5lIGFzIHRoZXJlIGlzIG5vIGFzc29jaWF0ZWQgdGltZXN0YW1wIGNvdW50ZXIgb24g
dGhlIFJ4IHNpZGUuIFJlY2VpdmUgdGltZXN0YW1wcyBhcmUgc2ltcGx5IGluc2VydGVkIGludG8g
dGhlIGRlc2NyaXB0b3IuIENsZWFyaW5nIHRoaXMgcmVnaXN0ZXIgY2xlYXJzIHRoZSB2YWxpZCBi
aXQgZm9yIHRpbWVzdGFtcHMgdW50aWwgd2UgY29tcGxldGUgY2FsaWJyYXRpb24gYW5kIHJlLWVu
YWJsZSB0aGUgcmVnaXN0ZXIuDQo+IA0KPiBGaXhlczogN2NhYjQ0ZjFjMzVmICgiaWNlOiBJbnRy
b2R1Y2UgRVRINTZHIFBIWSBtb2RlbCBmb3IgRTgyNUMgcHJvZHVjdHMiKQ0KPiBTdWdnZXN0ZWQt
Ynk6IE1hY2llaiBNYWNobmlrb3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jIHwg
NCAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBB
bGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
