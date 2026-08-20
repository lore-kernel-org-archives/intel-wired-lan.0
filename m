Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79174C5B572
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Aug 2026 00:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D34A60604;
	Thu, 20 Aug 2026 00:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSAns0vzQhWK; Thu, 20 Aug 2026 00:02:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787184174;
	bh=FxMsbKOe0xscJKnGcnCDRTmWEAB3NlGcsl2ccEexZss=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3/REAKEOdHsdbRjqAbDBvhtGPvu92tJcrLz/fBEVMlWZb25ZfSzQb/APrlS0pfqmD
	 sKIv3wHPWmR7Bscwkei1G89yZtIFf1Ij/6w5phf+SfAV2ZvjrSM16xPFy4Qz5n18LB
	 vKcNsCvssXVct3d47y2NJXUQxq2wmockTXdgzPjTqpAn2xPDGCRQssSg4dBtv+Yla3
	 1G2g0TkWcMZRgybN9VmHOfZBSoqXpPuFAr+K2sTqSiEFlbyIJrDS0tFh3nEcR6H3xY
	 aj3jEQBLq8/LAqkT+O0WRBKQVMYkY0iGL0VG9ZrX9k4ClWny6JBFN+i581DE1elUkn
	 w0rgFotpj7aCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DD8060619;
	Thu, 20 Aug 2026 00:02:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 66B38323
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 00:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52C1B40080
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 00:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ROAJGuMEUno for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Aug 2026 00:02:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SAbsxejn
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7ACDA40055
 for <intel-wired-lan@osuosl.org>; Thu, 20 Aug 2026 00:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787184173; x=1818720173;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=QylxBENEeKhdDzbbvPCdygkpa6PA+hHe0erc93S0qio=;
 b=SAbsxejnDY591B3z8P07cZh/ajDnXyrR6+FlIdIDLfilbJOGTCAjleZo
 f9Ofq16VoS0kCC/mNSgrfvbT5aXThVIu339alkvQ9gbRSKbZK2uKJJV+o
 zS6/Q5M6clfA3NchWILZzQVV+ERDwS4GNDnymxlBW8g0AlIJ7ctLvzajJ
 84OVDCgDrmQHNLusRqf42hy7cyoEjtWoULOz+AJFRkTYRostNGANXtW+u
 GVr1yukl9cWsWr+sclFYWLJBTonXcWOt9OdyRGSJABLk2hGJV7bBfVA59
 UUSB2fTuFT9OQ8VbMYR6c5gvCu0lN0XZWnKHAzE/E/rHenNyOb6gh3BGk g==;
X-CSE-ConnectionGUID: ZTDwSJSnRg66eer9zTJYNw==
X-CSE-MsgGUID: aCpvKZlOSVq8hiPrUMEbrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98381373"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="98381373"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 17:02:52 -0700
X-CSE-ConnectionGUID: Szn9OonkSgOvCDpM/3ou0A==
X-CSE-MsgGUID: konSg8MOQ92Bl4YR12ydTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="270001068"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 17:02:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 17:02:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 17:02:50 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 17:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBHlCah63R67Ut2lqnhIoUYIwCDDbJ+FulccDCW6Z2my3lF/XXDq/cdT9VuX0CactSLVBBkcPxve2dzmwAXy4ZCv/Tw3bru+J+X3wpc4tJpbv9ZyVJ6aeu80HIWrPguaXfJSSNbKVVId5lWzVXMIk9s/duSg1bjg6ZC4nnod5ykdSSaVtMLDBIr9ymcIrZJUeyTHcJX0lj2iQ7t1M7zwyitQHfdJT0Je+GAHVIJMoTR+k8+NyJ/wDJtltGS5EVH2GmTT52LeuOBjgIrugIwxq3Dy5uVep1pLEKs7a6QVXQG+uYHS/x32vIRUVVRdmqNrOPEXRyyfzHu3LV0lI1038w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxMsbKOe0xscJKnGcnCDRTmWEAB3NlGcsl2ccEexZss=;
 b=OZ5upe7p+C1LDWrGRBUPHNiQtdGj7DqJjyRCcPWlHwdqa20fritLWGDQpBN+wjA89f7GqXOWUp+WsdUHNE33EQXGa8AkKpeSRJDzo71w3cNx4QP/jpPTAAkTZtgk04wOAiZZG2GQAaU2VOo5mPegpe2Fe8yMwwFNgz5/8Qnywodvn5P/H1CW2L+sKOgnxp/vxBueVxaLjIkZZlOD1k6vJOzwi6TNS56L7YD+T3m9lAEUg3sKR5QnrWO8CKU9fFJnMU3vjP0p+EwNa/22ZOk2Jqae7phHO0EnveoRgEMJlT6OHLTnbekk3UHY3WgecORUumPZ3p6dObvWgfLykVkLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SA3PR11MB9485.namprd11.prod.outlook.com (2603:10b6:806:45e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 00:02:32 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 00:02:32 +0000
Message-ID: <e72bd1d5-9b67-46c6-8ccc-81edd0bb6f8e@intel.com>
Date: Wed, 19 Aug 2026 17:02:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [BUG] ice: E810-CAM1 custom board - topology/netlist
 resolution fails (EINVAL on all AQ topology commands), no I2C activity on
 GPIO expander bus
To: "Hoffmann, Fabrice" <Fabrice.Hoffmann@ipetronik.com>,
 "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
References: <FRYP281MB3387C2011F156C1D4F36C05291A72@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
 <FRYP281MB3387040C3F87F8D9F0A99C4291A52@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <FRYP281MB3387040C3F87F8D9F0A99C4291A52@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SA3PR11MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba55628-4883-4f10-af13-08defe4e5547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: D+AkHMvglMEMLgwubmFZM7H5jpVcntKEcE2egLxaEuRlNK+goLOHnqDiqk7ndgrJMLJjFZYUZHo4zwuwPk9kdpyQxFhcJtX98DA7oyZgSAa2LCIDk0wHvILB+OjISt5w8HINlOrRP8I/30eDHAsOt7E9DSBxHsRTb6v2sLMTboST3LcBqVwWvjMzjqCz2sKvRg7p0PSG2jCnxOhTgYEWF6ZDGWo2MgGjvRbjfYPRhyS75+0jmD6QswS1euXlnYJL75gI8T7nks0TCsRCRhl1EKMOXQds0wfe7TeOFWh8smO14tP6YgjFI3HecNnSiAJIULjYZPQ47UQ3ni75QYCGHsCxzGkaDF/2Jx2z54oMF18LXxhoG053Q+SxFAIXEeSsAcEBTpUh/+i8R87qBrpUTF+VM16W5GqTl7+EIKUF5tkAne/yby3hZdBBjVKkw0hBjoNN2K4ajQHl7TvvFWkIxTTUNc9Fw50yTn+RzWf88fLWZNxqjMIon8nwiOSABy+SAFjevhCQl3Ll2fs2MbJMsdYQzjBHFMSJuy/m8S+cpk7OyVslTOpOtGsVKTYlFqBjLSOoi1twhwaBT+9NyfTayytfKqkOuJe8CbRS2QXszZ3o8L0oRlthUjloH9DD1FbgbhHfvBZi/qkgiFCbiGohk4ubgZaUMSlhHHBDq8gOFD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8230.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZDc2Z6NTQrNnE4a3hXeDl3VFVVRnpuc1EwTHNCVjJVU0llM3JjSjNwTFoz?=
 =?utf-8?B?bHA5VGozN1ZleG1IZ0piVG5KSG5CRWVoRzdPd3ROL3VQcE5TTFZ4ZkRkMjBZ?=
 =?utf-8?B?NDFQQncxQ3YxUzFBRys3VFlHRVJIdk5oWEprN3V1N2NzMFZzOFFRZjZnZnJU?=
 =?utf-8?B?QlU4QWRWc082UDllT3JxQVdWalgwMjdYLzI3VXVlVDZmOVhpaCtUNnViU0R0?=
 =?utf-8?B?N09TYWZ2RmxZak10RlFoU2tXNEFIRXp4bzdqOEQwc1pCeWpRSXRJOXIyY3F0?=
 =?utf-8?B?TWMzY1pyTU5IRERwWnpYaTdIYWJTZDBFTFd2OHpBOFAwL2VWYncyNFhNd1Aw?=
 =?utf-8?B?aTdPd1dIcUp4OXIzQlhRVkZ3eTlJRWM1dXRmay9kcFB5bEo0cmJxb3l0emRZ?=
 =?utf-8?B?WlVCWHRsbGZya2syVjBUT2NzdDJqWnZIdXI1UUhNMjdIMzFqRFZLYlNCclRx?=
 =?utf-8?B?SDFYd3BtSWx1UmVCd2grZkpxdENSQ2hBRUUxYjRNTkhTbEhZTk5COTlGeFVS?=
 =?utf-8?B?QTl4Qkh2U0xidVZqUzQvZmYvS0xvUmJNZnc5RnF6bWJvWXgxb1NRME1mcFhm?=
 =?utf-8?B?WUIveVJUWkNZd3A2ZHg1S04xclpKYTFONnpZTmVkOWEvUW5sNVVLNFVQYlc1?=
 =?utf-8?B?cnIzcWFsMjRuZUZPRnc4ckhOTXpWZ2dib0ExRXl5ai81c0R2Uk1BeCtOYXdI?=
 =?utf-8?B?K0FmclZlekFzYmVmWVJWNkRSdEJ4N2x2NW1qS1BHSklnQUl2ZmYrTHhWWEY3?=
 =?utf-8?B?MzJKM0dTN1lOb3ZJRjJSdUdYa0VydXQ4KzFzekpIMnQyTDVzS3RjK0pjMHpY?=
 =?utf-8?B?OCtBK2Q2L01NNllndEMvQW9HMkt0eUhhdmsrbWIyMjV4OWxSa3ZwaHlpZkZj?=
 =?utf-8?B?b2p5R201a015ZkpqWWhsR2RxSk9SWFRlQzI4NjVSWnRsMldRc3lZcERSMkpq?=
 =?utf-8?B?ejRBTlJQZTF0Ujh6VkpSNVAwb2xOSVp1YnEyZCs3Ym9aK0ozQjhwVlVrWnNX?=
 =?utf-8?B?a0lNclIxS0JpZVV5Z01uNVJrbVV3dEtHM3I5QW9yenE3Um1FRUVEemxQazhV?=
 =?utf-8?B?NTZvNlRtTzd1Tk93VTJ5ekJsMnFQVHNVdXdaMnR1M3c3MFRHOXpXb3RFemph?=
 =?utf-8?B?eDhqSjVxd1BtUi9FOURvRThFUStlV1hDcGF3NTQxTHFhZzVNOEo5Sy90a2FE?=
 =?utf-8?B?dXE1OVR1bHM2amdOMS9vdm5GcE93dnQ2dUVyYXl5VU94eUd5N2RQQUVlOXRO?=
 =?utf-8?B?ODZ3ay9jeHkrbnN2Y1FiTGlYWTdUQ0k5WVEwaFF5cEI3czNRbk5laDdNOW8y?=
 =?utf-8?B?TWtkZGd4RXo1NCt1R2pkTW9ZcTNUWklQTUNYbVdwWnFRb2VxMWtVRklIKzV1?=
 =?utf-8?B?QU51K1hLU0xDamppWDFwd3BTc0h3Sm5BdHZscGVkU0NKcU5BWVp2Uy9La3lW?=
 =?utf-8?B?aGY3UG42TG9ZUFAvYnpsMXNqd2JNL2YvcERsbHpZOFJhTmNjZkY1R2pORDl1?=
 =?utf-8?B?SDBzV3ZiYmJIc1EvcjVrR1oyZmpVVmFiMXpYRFJIbDR4VDdzaHV2ZmpsU1Zn?=
 =?utf-8?B?RUZEUWkwYnhmczBPczhQaEltTnh4TEM5aFdWVnFMR1BMdmhYdjJDUHkra0ZI?=
 =?utf-8?B?R3VwNWdtSGZEZGwyQkhFZGdwWk9YZkJXdk9yS01wTTZMTzBERFRJbzVzZGxr?=
 =?utf-8?B?U084MWdsVFlDZXpEKzhuMG0vNlZQWjZVOW5SaEc2cmJ3T1VYRmJlRlE4SzdW?=
 =?utf-8?B?THRwNmp1U2tjNXAyeGtZeE8wam1WSHlYcWUvaWUydW1NOWlBRHJybmpaMG43?=
 =?utf-8?B?VklsUXBxcUUzdUVheXVVN3k1RmtuU0lHbkVzOTV6L3pxNEJmNVhuSXhjdTY1?=
 =?utf-8?B?di9qVHFFdzZzeEtBM0dtOVNqUkd4ZGtIZFFuVkRUYkpGZGtGaWgrckxmV2hS?=
 =?utf-8?B?U010QUZHcVdSczVWb0IyNlNPQVFBbGxiMXNvYm9FZWlMVFoxa0p6czdtRTND?=
 =?utf-8?B?VkMzdS9USzZiQjhjNjlPbE1QZ0xzYlRXU2kxZTZLczN2Mk8wMEVDU1MwcWc2?=
 =?utf-8?B?Y1BzVEpsMHBCUng3WXoycnZKOGxCOEdnZTZFNXFMU0cxUFVyQkxDVkZxQXNq?=
 =?utf-8?B?WkJVRys5TGY4cjh6b2t3RkFRdXZFZjFRaGFmVkNXVERGdkdwZUc3ZVF2eC9J?=
 =?utf-8?B?S242eGV1SUNmdk1UNUthQXRnSUQ1M3pORGVwZWg1ZHpYYm1WWHUrY3FoK1Vw?=
 =?utf-8?B?OEgzdW1DTTBrd1U2dTRsaGppMXpoclQ3YTQvQ1VBbFQ2QnpXMnJudFA4cklS?=
 =?utf-8?B?a2JiS2xrQnpOMlBkdGdNbXRyUEF2djRvWkMvZVVGeTlrZS9oYjBuZWY0YXU2?=
 =?utf-8?Q?FlCtBkcnISinfrFw=3D?=
X-Exchange-RoutingPolicyChecked: D89ncRIyfAf3ekqr8V/RXHieR4o2WSXjZ3ApIr/pPV4AFYBsnoZiC0TbLo2aYoab2V5rg3Qfa7EJJvubpVFje/y0tHERm+SG5OHIkMegYLT+o139Eu691kUDWESJ3SbAgt6ZNKHDZcTbjZwlVJX4tUctZhpesZv7YDWfqcG96KKFk5xNnI7LmPZYRT7VLA7v0yauAtcsC0anUXjcZ2S5OttORQbuT+Pi0KvB7rtXpP8998rxaEyM63/1iiTg0Wk+oqtynhZHo7qrz3N1p7iAombQMfGfIClSJPFAmYJJy4elh/16LqSPkNjX61KZUtdLLHGbfSIeVXH160DyhqJWvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba55628-4883-4f10-af13-08defe4e5547
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 00:02:32.6274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDdPmM1bZZNRzWdvtpVjgbDbwRNkcoZa8T1Lx4FnAoaK3Nnw9dvAyHkFbRJ+1EulndC8i7plMY4PsKYXjmpp3iB4MExTG3Dp5Ust1NBhWUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9485
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



On 8/18/2026 11:47 PM, Hoffmann, Fabrice wrote:
> Hi all,
> 
> Follow-up to my earlier report (no replies yet, but we made concrete
> progress on our end that narrows this down significantly).

Hi Fabrice,

I'm working on finding the right person to assist you with these 
issues/questions.

Thanks,
Tony

> We built the ice driver from a 6.14-based kernel (our original test
> system was on 6.12, which lacks the devlink health reporters) and
> tested the same board on different host hardware. The original EINVAL/
> EIO behavior on every topology-dependent AQ command reproduces
> identically on this new setup - so that part is confirmed independent
> of host platform, CPU, and kernel version.
> 
> With devlink health now available, we finally got a direct,
> plain-text firmware diagnosis instead of raw AQ error codes:
> 
>    $ devlink health diagnose pci/0000:05:00.0 reporter fw
>    Syndrome: 274  Description: LOM topology netlist is corrupted.
>    Possible Solution: Update to the latest NVM image.
> 
>    $ devlink health diagnose pci/0000:05:00.0 reporter port
>    Syndrome: 275  Description: Unrecoverable netlist error.
>    Possible Solution: Update to the latest NVM image.
>    Port Number: 0
> 
>    $ devlink health diagnose pci/0000:05:00.1 reporter port
>    Syndrome: 0
>    (ports .4 and .5 likewise report Syndrome: 0 on the port reporter)
> 
> So: the "fw" reporter (global) reports netlist corruption on all 4
> PFs identically, but the "port" reporter only flags an actual
> unrecoverable error on port 0 - ports 1-3 come back clean. Combined
> with the dmesg output being identical on all 4 ports ("Get PHY
> capabilities failed status = -5" / "ice_init_nvm_phy_type failed: -5"),
> our working theory is that netlist/topology processing walks the
> node table in order, hits an unrecoverable condition at the first
> cage node (port 0), and aborts the entire walk - which would explain
> why ports 1-3 are simply never reached/checked (hence "healthy" by
> omission) while the overall topology init still fails for all 4 PFs.
> 
> We're fairly confident this isn't a NVM data-integrity problem in the
> usual sense:
> - The board is already on the latest available NVM/FW (5.01,
>    EETRACK 80021FBF; nvmupdate reports "Update Not Available")
> - We reverse-engineered the Link Topology Netlist (TLV 0x11B) from
>    our image and confirmed it's byte-for-byte identical to Intel's own
>    E810_XXVDA4 reference image at the node/IO table level (PCA9575 I2C
>    GPIO expander correctly present at Bus 4, RESET_N/INT_N on native
>    SDP5/SDP6, matching the datasheet's "4x SFP Native" reference
>    schematic, Section 17.2.2.1)
> - Re-verified this against the actual flashed chip content (ethtool -e
>    readback) after a fresh NVM update - identical result
> - NVM Update Checksum (AQ 0x0706) reports valid
> - GL_MNG_FWSM and GL_MNG_SHA_EXTEND_STATUS (read via UEFI Shell/BAR0,
>    pre-OS) show a completely clean boot: main FW authenticated (STAGE=
>    100b), no POR_AL_FAILURE/PCIR_AL_FAILURE, no EXT_ERR_IND, FW_MODES
>    bit1 (Recovery Mode) = 0
> 
> Given all of that checks out, "corrupted" seems to mean something
> more like a structural/semantic validation failure specific to the
> port-0 cage node (or something processed immediately before it),
> rather than actual bit-level data corruption - but we don't have
> visibility into what that validation actually checks.
> 
> Questions, now with concrete syndrome data attached:
> 
> - What does the firmware's netlist walk actually validate at/around
>    the first cage node that could produce "Unrecoverable netlist error"
>    (syndrome 275) specifically for port 0, while leaving ports 1-3
>    unflagged?
> - Is there a way to get more granular logging out of this
>    specifically (we tried fwlog modules i2c/link_topo/health/adminq via
>    debugfs, and can correlate some opaque message IDs with specific
>    AQ calls, but can't decode their actual content without an internal
>    format-string table)?
> - The suggested remediation ("update to latest NVM image") doesn't
>    apply since we're already on the latest - is there a separate
>    netlist/board-config bundle that could be out of sync independent
>    of the FW/NVM version number?
> 
> Happy to share the full netlist dump, oscilloscope captures, and raw
> AQ traces if that's useful to anyone looking into this.
> 
> Thanks,
> Fabrice


