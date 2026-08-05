Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F261BC55822
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 08:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8850480B2E;
	Wed,  5 Aug 2026 08:41:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wy7BiaiSMG45; Wed,  5 Aug 2026 08:41:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5E8880B9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785919318;
	bh=6orkyJF34zQIlN1+ScgrPDDvJ1jwor76PMM0Cp2XkN4=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U3Of4h3L+GO3peOVt5ePzN24zgTIiGXQsaAjSNXxoAmh0YSJHEJL9t2gkHdB/pXtK
	 DsH2nptGweJMbtWBBtzsgcCMPCUL6IIOSRUUCn8iEiTi7DgU3JQJc6zAJaVjIF9kYh
	 lAtJzap23QdVUmgZio8YuWH2w8PRRNWxXsqZy6+Jn57y7xB/AcLqgVU0SFo0ySa+1W
	 XRjFinzS+lAmoFEDIGCdHqc7DUf8F4iQ5khz+02+tiCfV+qRWxZ1HtFVJYR9M+AMqq
	 QWyYA9EyxFzGFpeOVcJo+9aCBvTm1cYuNTo5twS2lOJakr5AsvFQiD88zwgaGyKsku
	 duf8tABwLD+RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5E8880B9A;
	Wed,  5 Aug 2026 08:41:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4398423F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 08:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C42E606C6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 08:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O173s0f4BAXS for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 08:41:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2078B606C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2078B606C0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2078B606C0
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 08:41:55 +0000 (UTC)
X-CSE-ConnectionGUID: lcUhbVzOTKmfdx1Pp4u0zA==
X-CSE-MsgGUID: KNu9ldx8SBa+jnrr41htew==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86602504"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86602504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 01:41:55 -0700
X-CSE-ConnectionGUID: fSP59U4RRICPGPeTLbIlLA==
X-CSE-MsgGUID: 9iY0V/lzRdqymM3a57qeAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="299966878"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 01:41:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 01:41:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 01:41:54 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 01:41:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiUm8L0+VmKsnr2ED70PW/YoubQGu6LCv4G9j2h+w+8QMYLAMO+OR+U8NRPdub5U0ZywusA0D08c31H6TbsHm1E2K5UBEBGADjodbluwuIuB7fLM45c1X7JFllaBi3tqxFRF50mqb6/zgmsZuyWT+UvTMCoaZFWFPQyZmQ/gdvjcNfh9jHj2LxjmrnjCF3vYjSoeHDylXXjIJvTcOPlGqSr3nVkBpFUL4tw3o+tnAemBBDaFsNntjoK3WNP0HT+NYwIAvq9GyNwsUxxrnUJOn8ztgKj55vn9Ud40FV+pedL3jjMiYAekPtdwIuVCC5yk7EvL/Sbi7vx3LSHty11a2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6orkyJF34zQIlN1+ScgrPDDvJ1jwor76PMM0Cp2XkN4=;
 b=fRueC+RBnBx08GD3IQhLGcbVIlFPhSD0pdVjr2m1gwaUS5W4tDMdpVjbkuyfid7mCNfzavMtD9DxV3ZreabkuakCyi51NrcXYf45HEHO+drAiV/NLI/GTbsIAqQoS1v1m7IUC1mVFx+/AIntUBPe/vZ53hF0LD8rkqKgW2Y699JWuaHDna//YtC8CCvVhqS6bHvgtMpMeyTvRa9t+FGN6lfUbk0//8okPONLXTRYsiEfDlORIGR0YJA67H3G88RAngsxI+bJ3ER+0ZzOK3KjhsNVeT1RIJ8uJP4wzc5ZQ9UxXoiAtzfrFJnZcdKSPCK5e9mUDh2qMf9r/XbRVMAqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by MW4PR11MB6689.namprd11.prod.outlook.com (2603:10b6:303:1e9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 08:41:45 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 08:41:45 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Oros, Petr" <poros@redhat.com>, Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "michal.swiatkowski@linux.intel.com"
 <michal.swiatkowski@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: clear the default
 forwarding VSI rule when releasing a VSI
Thread-Index: AQHdAh6xAT37SeS6Fkai9CSRvbDYD7ZL8iAAgAAH3ACAQ24y0A==
Date: Wed, 5 Aug 2026 08:41:45 +0000
Message-ID: <IA3PR11MB8985B2801F3C3D6C9E4568F78FD32@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260622081030.2312129-1-poros@redhat.com>
 <20260623102934.1072800-1-horms@kernel.org>
 <987aa5d0-9ca8-4038-b77f-94adba497e40@redhat.com>
In-Reply-To: <987aa5d0-9ca8-4038-b77f-94adba497e40@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|MW4PR11MB6689:EE_
x-ms-office365-filtering-correlation-id: 65e30091-0960-4977-9bcb-08def2cd61bf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|5023799004|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: wOShOLAWB6RpgjcPUKO3HNyRx//M3U4dI9p8rreNu4HszYIb3nbXexS0QRdAoFLy/Q3d9RIMu9QIFfpoTpPc8ha3cnvg0wv0YWML7+rp/4E8YqiePw4bop3BzYaXnOsYlAyud64yYc7H8fqSdF3tZ6VQK5M0hh/DuXeajkEh1wILLFzLdOle+u02HUdfx508o427Q6YflgI5SVifO612RW3llKe8vZprqz0/avJnWfwuB7Ka4xDj+cLxrOveUTCfpkKdvMy8zu+IAI/3/M9O9lECJnK0GwRRZ2TTR04thD0LlnS8bx6kp7Ei9mIDTLan5HxPi3Vc5eXhj/XfSwbKwITqBnHAmTtvQnlKoqSEM91q1sKvdOPwjvwkxTd1LLM5j1QdLIQp2Dxnz1ogmJSAueX62ZDdqoIjoZqVwy7EZTTvsH7KUC3DneluRJIXpkaKhC/ZnZVN8Ehn1kXX5UatBBmPfkjrHkz7aGDZUcmlQYZ8Q3v58pd5vCxoejWKl51JeLdGNKTUT9z0FImkQ3ypd5Wx8M1eOi1/FnkjDErdxSxnzVqipJqoaqwlabA486kOWVwiwbTklo9Hgf57CkMlND9Y+C1bXRVy8KDUNebmUUaLN2ck8Pxqetsy3KmDU9FnmnPmFakT7ux0DniHSTrMeIhZj+tbROJi45OUu++zMc0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(5023799004)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzlXOWxLZ1NnN0FUZ0tCR0N5TTMrNUxraWZTbzI4RVhsT09JRlI5TTBFRG1E?=
 =?utf-8?B?QkNJa1VyR3MxQ3BBb24yNVJTc0IvS0lqak45VVFSd3Q2SlgvSnFaMVB0R2tT?=
 =?utf-8?B?Ukc5bnA4U1ZWK3R6NkdJQk95QXZUUjVsS0VWbHRrbEhPbERFZVhvQnU5dU1t?=
 =?utf-8?B?alB0ejVFR3ZnenhsNXMyQlF4V3VDQUtxcWRYKzNzQWpnRDZWQjRjbnR3MWY0?=
 =?utf-8?B?ekdHRDhIa3I2eUN6OENHUEZlaWhEVzcyZC9UemgyRGlkZnR6YTJjWUR4RGZ3?=
 =?utf-8?B?RzNvVE5PYkhhbGxMOC9TRG5mSFhnTUxzS3VvQVZXZEJWaldDQlVIU0J3aFhH?=
 =?utf-8?B?N2tQcURUejJtUVRMUmpJNGtwQlNXcEdsQ0VBeVZpUHlHQTZDOURXV0x6ZzJk?=
 =?utf-8?B?MTVnQUpUTDJCSUFCb0gzQmVaa1JkQ2dVVURIejhyOWtRNEUzMGRDRldqVXVF?=
 =?utf-8?B?Sjh2Qk9VSDBvUzdZRkRFTW9jZ21VQmxFTnc4NzZIRlJ1dW4vdjllUk5HeTRm?=
 =?utf-8?B?NXVhQlFreXVteVpVTEhlcHpVMVhWbmZPRktaRVRxaWlwM1VMMU1BeDRnSjNQ?=
 =?utf-8?B?RlUrQmlpb3ZXZU04OHd1TXhxb05qWDFjT3orL1BlWiszL2VPVDNEeWo5dzVE?=
 =?utf-8?B?VzFtM2FUeDZQVDJzTDhtUXB4ZXZUczY5S1BCRkMycFV2NGtKQ3JRUXhjMTAz?=
 =?utf-8?B?NHcreWtKL1IxS2dsbGp4SjdLMTloTnRDMGlrdW0wMWUvQkEzYmI3M2VJZG04?=
 =?utf-8?B?L25WZzVaNWI0ZUVlaDRsZm9oekVIcHlaRkxib3psd2RkdzBDdms3TWNBZXBQ?=
 =?utf-8?B?WHljc1JmRytENWNlWmJ2UUNNVS90ZDZHZXBDam9raHl3c1FrTDZRU09RalJJ?=
 =?utf-8?B?QTI3cVpwQzBZR09EbTFmS2dJN1dKM3R1ODVFU3JXWjJBSWtZTlJLQ0IrMG5X?=
 =?utf-8?B?L3VyNDNaNkszUGttcFJkOEpxRHpIRDh3KzAzdzd6QytFelFadjI2eCtMbFEx?=
 =?utf-8?B?WnFHUnZkQVVvMVRHVXMxUE44eTZieVdVUlQwVEE3QjVDZTFWcmJ3ZjJoTTZ5?=
 =?utf-8?B?UWh6WFp2cGtqdmp1Wks4S29vcGFybU1sdXBKODJ4Z2hIMGw1cFRtZTJqK2p6?=
 =?utf-8?B?VmhTV2VXWkw3U1RhU2wvaFJPTWtYMlFBTUkvaUNCQ0pCZWhvQXRLSmdEMlgv?=
 =?utf-8?B?d09YSkV0YkMvQjY0OGFWdHdLUnVKZ0F2TUdVMWxyRVhiY3owVm5qVFVMc3Ja?=
 =?utf-8?B?TDd4ZWZkOVlUc3VnbDdQbnFqOVNCeERoeHRvK3Zhc2RQZmhVejZwYVRYK2dM?=
 =?utf-8?B?ZlBBNDVOUFU2alNHQktaeTZMYVlvVzJncWVQODNsMWUxUFR3MElvNWVpMGds?=
 =?utf-8?B?SHZkaGFnM1kwTGtGSEtFMW5jUTcyUzl1MFozTzFzK2R2cGhwU1lib05zNjl0?=
 =?utf-8?B?eWdYVW5ibUlRYlFMRWcrUTBaaVdtemJ1RUVSeXZDRWV1VjI3ekx2WG5scFVi?=
 =?utf-8?B?T2pkeVVoYXpBRzQxWUVBVWJFeWwrTXZTNitMb2RJWWZhUXRBUUp6ditRWVYx?=
 =?utf-8?B?QnVqeWJUYnQxZGRzR0ZzZVJaMVlYbDZRdmpsWVIwVFNjNEFhUlR2RE1oVVJK?=
 =?utf-8?B?TWo5S0p4Sm9oczBQNjJvVWNRU3RrMWhuMGVPN2xZYXJqa0Raa2wxM1ZkZStE?=
 =?utf-8?B?T0tmMHJUTDhoT1ZHNVBYUnViREllbnBlYzZZOW5uLytidUJLbUlFanZwS1VD?=
 =?utf-8?B?WTVLWWNJWW5EaGpGeDdNbHJFKzRXYXBWSmQ3c3h2VjJMOEtmU0pPSTJ5cVBx?=
 =?utf-8?B?WGdiWXFpVDU2MlBTN3dKRUEyT2pxc3dIcFMrL2FnVGxpNDA3S0pSQkNTNWNY?=
 =?utf-8?B?K1dCWDJmU2JNZi84VWlNSTdBcnI5QUVGcTNYemZSaE56djlzbmVmNG9ZOCtt?=
 =?utf-8?B?SG1nQldpL054ZTlFdlA3Z00yZWNTY3hYaVo5djQ5YU1oMmx0QUJXVnlpVVBp?=
 =?utf-8?B?Y3lJSjBWUkM2RDcwREwza1IvZkhiYTJFWk1IMFd4UDk2Q3lUdWk3UkhXS3l3?=
 =?utf-8?B?cUlFUWphVGtnRE9aL0dGRzBxN0xKQzRodWJTazNESDlnR1ZNZmtZcmhHNS9T?=
 =?utf-8?B?OHZQOFVyb1BIbWFQb2wzOE56dkw5S0NDcDhhZkZqQTlhR2ZOV3JUbFlxWU81?=
 =?utf-8?B?VytKSVlWWG9CbVNPdi96Q21SalFZU09obnlrV1ZXZy9GazRZYW9Oc25QN1JN?=
 =?utf-8?B?MU1CeDFRajJndUlOQjhCckoweTFDMk1halF4UW11a2k4ODFKZ1Q0YXVDa25O?=
 =?utf-8?B?WEc1MU1vZDNMNnJWNjlNbnFYY2JCRC9MSmlvc1NZZEpZSjdSZDBhUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p+OwKVDqdAryTmyuPncmiSssCy2CU1iAHq54AlFJsL5F+fWoYExifSGy6k0XdwM0VvMSC/joEDQEO+cwaPawux4lD6cdXQ3ljBVkQRwYW9BLyouTvdvYaemhav21oCPF50vGGHNgn1fnISZRiN8vXxkcZHQ7g/EJVQWIz1zhRKuFjkQ3rurPkaDUmmqPeIWkM6tjrHIXOIOPaDUPrZycMd4MB/rZyCHSLaRqbOHkmu5zNtbcVTFEFZgUPNDfijs3uj51MVnKKmlY+XeHU9F0TjAZM5VBwtf/bqDDfb5zcPF5uhEMzqVcgSw7ye0fqvowiMKnI7A845KoijBLSgq/QA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e30091-0960-4977-9bcb-08def2cd61bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 08:41:45.5050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PSpy+xy2jNr+ymjIoS0mhONqILeyVe1hiXXkm0n+ejU03FnyjFgIUv1IZ8ORbQQyOIR6ppCHa4aO2KLesNNclMTiqtUHYCDc8OXbmfgENo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6689
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785919316; x=1817455316;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6orkyJF34zQIlN1+ScgrPDDvJ1jwor76PMM0Cp2XkN4=;
 b=JcGDumi6onXCWBjq5zfq2orym+5HMc5vz9lracGXR+yhQbjX0x+dAcgX
 i4Y/FQExaj9jSAgtb2CcPkpxV6FWYvO/ny++8RUwG2Zx55ajW3vw3cUPc
 V+I4UDsVe/J0BxoND2t0KMF6/0mqxNEqayFSFKLRw7v+6U3A75vcuWEeN
 QQXRN0t0vsk9cRb0JO++kroQOyjRqQvqfvAfy8ZA5RzdarQ4JSjee/4bw
 hjdA8lFKDTdZPpTO9nPVEjpJJt3hpFylwF9H+KsvEAZAwR7Ks4TgLfdYy
 FQRD3gT83ZCs1Y+pGGKP9PLpgjf9siXABSmLCOQNOVWhmdgzBoRzwN5qX
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JcGDumi6
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: clear the default
 forwarding VSI rule when releasing a VSI
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
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBQZXRyDQo+IE9y
b3MNCj4gU2VudDogVHVlc2RheSwgSnVuZSAyMywgMjAyNiAxMjo1OCBQTQ0KPiBUbzogU2ltb24g
SG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
Tmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsNCj4gS2l0c3pl
bCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IGFuZHJldytuZXRk
ZXZAbHVubi5jaDsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsg
a3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgS2VsbGVyLCBKYWNvYiBFIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+Ow0KPiBtaWNoYWwuc3dpYXRrb3dza2lAbGludXguaW50
ZWwuY29tOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRD
SCBpd2wtbmV0XSBpY2U6IGNsZWFyIHRoZSBkZWZhdWx0IGZvcndhcmRpbmcgVlNJDQo+IHJ1bGUg
d2hlbiByZWxlYXNpbmcgYSBWU0kNCj4gDQo+IA0KPiBPbiA2LzIzLzI2IDEyOjI5LCBTaW1vbiBI
b3JtYW4gd3JvdGU6DQo+ID4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIg
cGF0Y2guIFRoZSBodW1hbiBzZW5kaW5nIHRoaXMNCj4gPiBlbWFpbCBoYXMgY29uc2lkZXJlZCB0
aGUgQUkgcmV2aWV3IHZhbGlkLCBvciBhdCBsZWFzdCBwbGF1c2libGUuDQo+ID4gRnVsbCByZXZp
ZXcgYXQ6IGh0dHBzOi8vc2FzaGlrby5kZXYNCj4gPiAtLS0NCj4gPiBpY2U6IGNsZWFyIHRoZSBk
ZWZhdWx0IGZvcndhcmRpbmcgVlNJIHJ1bGUgd2hlbiByZWxlYXNpbmcgYSBWU0kNCj4gPg0KPiA+
IFRoaXMgcGF0Y2ggcmVzdG9yZXMgdGhlIGNsZWFudXAgb2YgdGhlIGRlZmF1bHQgZm9yd2FyZGlu
ZyBWU0kgcnVsZSBpbg0KPiA+IGljZV92c2lfcmVsZWFzZSgpLCBjbGVhcmluZyBpdCB3aGVuIHRo
ZSBWU0kgb3ducyBpdC4gVGhpcyBwcmV2ZW50cyBhDQo+ID4gcnVsZSBsZWFrIGlmIGEgdHJ1c3Rl
ZCBWRiBlbnRlcnMgcHJvbWlzY3VvdXMgbW9kZSBhbmQgaXMgdGhlbiBkZXN0cm95ZWQuDQo+ID4N
Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGli
LmMNCj4gPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xpYi5jDQo+ID4+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGliLmMNCj4gPj4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9saWIuYw0KPiA+PiBAQCAtMjg3
MSw2ICsyODcxLDkgQEAgaW50IGljZV92c2lfcmVsZWFzZShzdHJ1Y3QgaWNlX3ZzaSAqdnNpKQ0K
DQpUZXN0ZWQtYnk6IFJhZmFsIFJvbWFub3dza2kgPHJhZmFsLnJvbWFub3dza2lAaW50ZWwuY29t
Pg0KDQo=
