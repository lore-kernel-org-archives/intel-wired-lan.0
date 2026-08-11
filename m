Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C42C5AC67
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Aug 2026 09:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 109E640758;
	Tue, 11 Aug 2026 09:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZwCBAPZxeiKT; Tue, 11 Aug 2026 09:34:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C005240753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786440880;
	bh=Du7NI3V9bdiNPL2pHFVDOjdmyslbwr54p/68gj2xIkI=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f6Z5vWJ4C4JrBgB2Hm7KSTh00svX89rJ6YJAcApYgtYIgl3SzxWYD5b1ekOBNzMDC
	 5FQjCGyFPKroSBgpLPeS0idSJOq1rj0IriYBNbpcDfYq6WgGD+Cj/LNh9yB8JT3Szp
	 aSj2bJdipf5GCulwHZQOGb0TvwgqmPpcM6v9LiJoqjPL1Ayt8I+qwe9ijHWr4h1tE2
	 PFWIkqBw+KPFrwPz9UUub88mStBMu2bKjJk4n6zFz8pmQZIlxss1kidppYEWtHe5aA
	 OCGbiJGRdgVbdjDDlNU6GYAQRLlK3WQ4YA4BpenbPYvJk7rX3ci7FM+s6LUxYNLtem
	 xikT2ynq3H3zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C005240753;
	Tue, 11 Aug 2026 09:34:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36F3B28A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 09:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28EDC605FF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 09:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 48jW4WvUUmZW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Aug 2026 09:34:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=patryk.holda@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 61682605FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61682605FC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61682605FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 09:34:38 +0000 (UTC)
X-CSE-ConnectionGUID: vXnpebDHQSGlcSlCMEzqSA==
X-CSE-MsgGUID: hxRRuUuCSsORCkRt5AwGOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98114688"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="98114688"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 02:34:37 -0700
X-CSE-ConnectionGUID: xFitscxKRVWe/R8vAwOJJA==
X-CSE-MsgGUID: DcK1u+HfQDyVl1DwGD1xew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="259979949"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 02:34:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:34:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 02:34:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFAQ3lmhAHXo98bEqMVrCw4mbjp2JWWtlefTwviUxJhTIgnUCr2j8KgMSlw/nXjB1cWAljaU+gSM9+bgUKpFe8r8Ry6jpVUi65Pfqkp9TaiidymBgKnRfwPAgXXTbDVaxvBuC5UXDonIbbsTcp3eNqo/FlFYHLRtHrbhKdlfNnpvp9amgKp694V/nGUwZ9KOB6lAPug8i481PGqqc5pZ1fiCyloZlaEVjAmP5D3/M8Aw+/YPBzViyrdzLAQwSlX74yK7ugElPBhCSrxCICzFJ32yDG5kSlG0wExP2XT9omXvG0IcY4QuPdxC1olkWr+yFtBaJQds5k7JcXMtGKHvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du7NI3V9bdiNPL2pHFVDOjdmyslbwr54p/68gj2xIkI=;
 b=TB/Z+ymEVEULA8ZhaFJa8ATuf06VrKafqA5O2XveNXw2N0c2t/Rs8Au56tCo8bSaVDzvkFraQUT8qpXF4pdqrwKNrUYOUolr5YAb71AzuconFpP4wC6AEMDuhYZT+WLts2bm++ghdzbwxKzRcp6PyKlM6nDbhycO+Ql7bb1qCdRHHyuQJ+fZngTthIJFEwQcs+bZvIEViivitu2ZoBi9Nz7oHUrkXys+MxniY9x3CEu/y98/Alltkraa9AuilkdhYhvYMemCOiUtdmzWQaaipM+bNC95WJHh+e5ktzz5Ukb0Lhip16diBJ+YhXSGCjQjG8Cn7M3KBHaDdK5XO5DGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by SN7PR11MB7568.namprd11.prod.outlook.com (2603:10b6:806:34e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 09:34:27 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%6]) with mapi id 15.21.0292.019; Tue, 11 Aug 2026
 09:34:27 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Chenguang Zhao
 <chenguang.zhao@linux.dev>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Chenguang Zhao
 <zhaochenguang@kylinos.cn>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, Jason Xing <kerneljasonxing@gmail.com>
Thread-Topic: [PATCH net v3] i40e: xsk: fix multi-buffer XDP_PASS skb
 construction
Thread-Index: AQHdG4Ct/dZtYm+xyUeF1LYYuCkawbaYsgGw
Date: Tue, 11 Aug 2026 09:34:27 +0000
Message-ID: <IA3PR11MB9301D0DE5EED82A87B09DF538ADD2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260724015328.229726-1-chenguang.zhao@linux.dev>
 <DM4PR11MB6117EB6F9538C7BBB808C24682CF2@DM4PR11MB6117.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB6117EB6F9538C7BBB808C24682CF2@DM4PR11MB6117.namprd11.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|SN7PR11MB7568:EE_
x-ms-office365-filtering-correlation-id: 3fa20af3-abb7-4888-a8e3-08def78bbd14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|921020|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 5BATV5keV2yN7AT3A8kaUGnTe7Km9/VJbw19lIaFdedqSp9nCC+wqaa/BaQQCguzhAPbZ80G+P3PVBlmmCCrF6S0CALoEZtDGFrlPH/mL8MfJJgD2fuoCXkwcedYs0Gljw6iRDPKi+r0YDA6bZs2yvZY9lMa/7y9ftZTok7agRjC/aLDCu7SMsc5AiruGjatQ4xbfSNJhNDUTCwKeEZUxfag/B4eP52/DEbqII145udgQ+U8kmPsJY7QC3gGcoAGmQIXEoeq61gED3sntTurJQI4KNgDlGZvXJ1Y9EMPFhifZ5p+tXqt9GK30VYyqfHzYvaCeU37YTYvFUNKugphvDUnNxqCSyfwPsLAo48UJbMcb2e5LrYVLuQUt7wGc746NTMj6hKm5CSWIATtBrDSRpdtMd5b3yvlRkvLpVOfP+17EasTGb9d6RAANybYyCTNfJyUQVUYFcwtoVY35JcKJHlpgN0l3O8Tqg9jbtL60eFMnZ7I60FICUOZTY4A2eKL+LVM8NSDubFg7vXAa+30zUpHLjDEkbDJ5udf1QBzgYgDXrSoA3L0ln539WhqnbKXnGbyp6QnOfU08wKaUpbuOHNYwAVzbn72VfKfkUXsrsKILavwUnYSXqj0J3JPw/Hx0lhnhbdoo7zkfEl5aH5ieYy1JL0foMt/2+uzupVLHjs/U7pME6sU5x9P34EvJcFEqJSZMqZz8Ah+wKF2f8wn5cF35D0YTruC1hY5cVSppXVsVzq3jNDzWmeECMhFmS9o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9301.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(921020)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?niYv8+L00s3tYj7+O5A33b9NZ5kJjJhVYjOASkAQQzInFzYcXSs9Zl6/oH?=
 =?iso-8859-1?Q?++ettaZozBGfKk3OzfADCWj5oOJs84MXbDf9wQ/ugDCKxCyNGz8sZfmVwu?=
 =?iso-8859-1?Q?/0N2+fFDbC9h9LlrnkDnKF/vAj/pYSpLxhuPHPvkiWpT4p8GK401pBjQBf?=
 =?iso-8859-1?Q?16Co2zJzhF9RsJVINVj3kVrfGRtgwuprPW6BNN3lui3/Jn8Ja2MRCBC7hu?=
 =?iso-8859-1?Q?FX0PeP44WAqaxvVwIlAxqM/7S/EW2Qi7V6ssS5djHFJT9hyS/v6WJ9ltqR?=
 =?iso-8859-1?Q?37QFnoSA04vVctNqpJgUeQcs3Twx6CEJ9kTkkVUp1ZUCWEuWe16ot7jIHW?=
 =?iso-8859-1?Q?eDk7KGB84EDVmWbO/tZB1O3j+MfitKl9oSSlgIhZlWyEB4Kl5C4eKe76Sf?=
 =?iso-8859-1?Q?kyBnyfCrvsWHvJOxkSVk5EcWDCHu2OeONY42Eu2KsiuahlyogzdOtl7MmN?=
 =?iso-8859-1?Q?KMzW7tsB8FrJVVeyn+7DOh1ESn3WjA4jCbqDviapkqderED/bcrULKXe8C?=
 =?iso-8859-1?Q?LrWVz8gR4MyldeLVCcgwFNEyxV/201Y6Yepkt3yRIJxP6C/rtwljpuMvAq?=
 =?iso-8859-1?Q?jqEsTlFtmzHcqCLzb2abpOAdetuqjzX6/BGWs1SHjlvdDuJnjjtUzk1V7G?=
 =?iso-8859-1?Q?PoGPwzxVy2oOxl8gLshUOFpH0/tazdc3/+9GrcgBWXEYYUgkwldEQY65PH?=
 =?iso-8859-1?Q?j+vYupQH22zPE0ObSnv7sFIejuWLB2tl1ktjESDVv/aRBnmPdCpeYyzbVq?=
 =?iso-8859-1?Q?ex2eim9pB1O8dSxzvrpn6tHH8n9IV89AWAHijBl+5wpM6UeqMfRFWoFGkY?=
 =?iso-8859-1?Q?5dlX4E9+QsLnEnS0Yk3kvruB+Ct69CahbzBUcmMb+NPGN+0CteVnzM6aNT?=
 =?iso-8859-1?Q?ENX9tcom3KRMdKq+mb1Bg/JgjF4oGDK9NfmO1v/9kVTi/VQ2pL/PZD+b2v?=
 =?iso-8859-1?Q?VIuIjCHGGoCXn+EbH2prAGh0KvKh1xB5n0myfZNQOjAUK8I6B9gjKHuRuR?=
 =?iso-8859-1?Q?kfKHccEFb6atcfaRT2HCrkdRxsp9Fl1Sidj3k+DC6F6iZux/IT0ZrWprT0?=
 =?iso-8859-1?Q?ZsfwKMdynJHzS8SwON+RQbGwedmUr4ZP6Nhwx6G3Fq5xPm85MkyWDDCtbe?=
 =?iso-8859-1?Q?35xu/GkdAx726lxwxuqs/CSUyDiOBrGGMq9zSVWlinPEnflv9lk8uQzPrg?=
 =?iso-8859-1?Q?yJxD3Cm91sQpinKBwX9XPejJfLrugFKa/MXQtjflZ3vO0JCA/Lmd1gWD/9?=
 =?iso-8859-1?Q?y0/3CGTrgqmc+0pZX5XwIyEn5TJ/r6PY/LSN3ICVONaLlGA9qMtqetQdfj?=
 =?iso-8859-1?Q?Py+NYWpq5GxrMlmZEtterV6szgatG2iFom4VPEXL+zQOdOsy6QyBPLOils?=
 =?iso-8859-1?Q?aMATTPSyAOV0z35QuDbSmxXvLlWhxhDtc4rkgu4b9knqgX1FJ6k9uhEmYe?=
 =?iso-8859-1?Q?bTnEotFpYPnQTehN3N/lJnGpUONIUpPeM6phpWHxvOJLBF2+Tglv2jVkYt?=
 =?iso-8859-1?Q?j2Xq7jrhjJQXBA+xAQlS6W2YvdOksjIxCxHxffnMkBFkzghxXVovVOrrW4?=
 =?iso-8859-1?Q?Z/ABc17T8XI6Qy5awtZmLbYveFp8TYvKpqdDHGcRYqxlA+SErN/NZeX2Na?=
 =?iso-8859-1?Q?z7VP10vioMSHq3Xwb00Wl5mH7+VPuOEYr1eWFBADsXA/lh8C+ztCuhAqLV?=
 =?iso-8859-1?Q?rZVLC8Em/1Kt43jVW7/gDhEdSGii4d7iZ5GNx9GEmrg9cus9o3Yhk36kbw?=
 =?iso-8859-1?Q?DafqPG2T013BLAc6NiEV8lIq2Q+5EaHlEWJQDUOWen1kyhpQT8xAwJIGZY?=
 =?iso-8859-1?Q?lYe3mOvHTg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qRDzz3ZB2r3TRUnMQOBYClwt7EQhKJIpyrjY4zbyeolSRD6JrA/xglHGwrPvjTADrDCHjcxTw+smmv7F9aB8kV4M++imxuJqdpUTWN14h6J0MbqCDd5OJRJAr+liCWPq1vQ5cf1koGrakNv7moIL8D+TJd8V17uFrgDMStORoYLCxNyNUq9V9TxhrCXLRWXZL7+2dyN/OeO6KEvR+Wdc4GMyfqsd+G0207z2IrkyTUCH/iG1Uvxzz50GIYkZX8xfvbQNxx0JeKP0hJLygL7uipDPSxraBFPTCxVPbI+GRIMf94ngsCIjTnzur7CZVaJqb3mbIIHEdsjaL1z3SbEQXw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa20af3-abb7-4888-a8e3-08def78bbd14
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 09:34:27.7502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47BoDufO9eUirUbvRTGmYnPuT8cZL6p8XM9c6yX4qTRYCAMXJUN2c6sV5upL12HIDo6I3yAvlB59C5oTgReDLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786440878; x=1817976878;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Du7NI3V9bdiNPL2pHFVDOjdmyslbwr54p/68gj2xIkI=;
 b=RH1io3500QdE6GJUGAgmbeATm1F5/6b3+a0vShrkubPROZ69ULh1Z9vX
 5vaplMVY3TwZ0qh/kuTGYoIR6h98FbFgoi6sgqjF0h5JDneE8WZhBXG4J
 w6wBRuH41i/jZXhbYQBJlsisvGy/H4qN9X2j3xpNDhRnsQGDq44PFFM6X
 PigM6z30DJVHHLcDUvyRbflK0DPTNRz1vEczEsINBd90UDhzRBN8oOpDn
 53SzzJJg5UiJIn+g1eDRALN/QINa9Acbku1EEcSS/Gtx12PcUCt6K0tWk
 6RAzbliHHHpWSmSy5PezkDhl9xLHPkPO6M/rPRlsyqHZ5fr8UfSuFZBb6
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RH1io350
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net v3] i40e: xsk: fix multi-buffer
 XDP_PASS skb construction
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Fijalkowski, Maciej
> Sent: Friday, July 24, 2026 5:25 PM
> To: Chenguang Zhao <chenguang.zhao@linux.dev>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Chenguang
> Zhao <zhaochenguang@kylinos.cn>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Jason Xing <kerneljasonxing@gmail.com>
> Subject: Re: [Intel-wired-lan] [PATCH net v3] i40e: xsk: fix multi-buffer
> XDP_PASS skb construction
> Importance: High
>=20
> > From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> >
> > When AF_XDP ZC receives a multi-buffer frame and the XDP program
> > returns XDP_PASS, i40e_construct_skb_zc() copies frags into a new skb.
> > The copy used skb_frag_page() as the memcpy source (page metadata
> > instead of packet data) and passed a virtual address to
> > __skb_fill_page_desc_noacc(), which expects a struct page *.
> >
> > Use skb_frag_address() for the copy, attach frags with
> > skb_add_rx_frag() so len/data_len/truesize are updated, and on
> > dev_alloc_page() failure free the skb via the shared out path so
> > xsk_buff_free() still runs and previously attached pages are released
> > by kfree_skb.
> >
> > Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> > Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>=20
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>


Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


