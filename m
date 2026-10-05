Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4FECA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 16:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B76F406CF;
	Mon,  5 Oct 2026 16:11:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H-t036aPCueP; Mon,  5 Oct 2026 16:11:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1C11140638
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791216680;
	b=rI08SURfUyjmS7F0gjnIev3zik6gyJM8drqn6jQG5Nev47gH0QGKT4+AVPm//my2Tg7u
	 MZfvEHCRALstljw5t0ENgPDY/eW8gnqXZ/A7kqEp+x3GmfcPAIbvg1wNH+sf+Y5BD0owp
	 RqEL1t6opjrACH90V5jvuZeyhOmSg6NsK7pFR3gu514GYH1aXWxjABC1gqAZY6lK4n+s0
	 CFq/5ax36nX/lqICfT+foBTtIEM61ZOvAKNAK/vdRolH2P0neVrsyRiLSY8IZrzYR59td
	 sscmtSAOLoONSBwVkVk0uJE1A63qV2ONqpJkk3adCr+bzRmxBWxj6pMboWMCSgW0FDw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791216680;
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
	bh=Jj93X27MDcdG51QxjU2Cj5Ck21FGvr16wpIjzVXf/80=;
	b=btuN5dkVWBaqmkthC5Acbs6j4Gk46uZwgOWcW3oxOkh4wVvgGgn468l2pXRhvLmDr8Av
	 X5/a3evX1LBsAMEzhuNBKLovNa+p1vqU+dVl2T3WOZmVmHcbkWAA8Oz/hi4nbIk+04toh
	 eiEmaLbkFf6j6sdlDaoWxU/7PKYtNP5FawG9BVFuYJ8BtuLjkESwba5dT79rFd40XL94U
	 rSG1x0k5tiVlrWZ3BbGND03xoZwl94Jt4gFfN2kxc1Qn5nHUHOTpuQQVSgg+kFSekl4ip
	 gr/5JQBjup0aK05B3qxvsOtMm3cktt4IDVqwpkfuly4mXs35RZdTESfN+oaEOGvcamw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791216680;
	bh=Jj93X27MDcdG51QxjU2Cj5Ck21FGvr16wpIjzVXf/80=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pSRUFYPuTF2a87TYZokyKLdkRzC/exGX13f6ZzRchbJlhyK0MAfXqLQ7rEnqSKrW+
	 3N44uZ+OF24UuDXCUrvqhWL/Pd+aUJPUCgZmhclpSayXNDVzhJBaGbbJeey8DP+6eg
	 ISvnHRXE1tBzbeWjpyWVmu3zUV+xT4mJofeFRDU0VrAc38y/wHTeqKyNjJyOzdnc/e
	 wBYeZKUDHOoS89reAqc1Acu1iux3gzTSFGokadOnJ+xxlHWdkD9M9RBdOxMRkcd+9k
	 UjdMc+03Tn6yulr4eaY19Hzpod2JC2jYXyJpoDPZ2AkzmPxA8WlYSnKFZy4NqgQbNa
	 ZFbBjH6HNG+iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C11140638;
	Mon,  5 Oct 2026 16:11:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 965F7338
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CFF940201
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ES_FjnEo0eV1 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 15:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8EBE6401EC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791215883;
 b=bfYcnHwrHFxBt2q6vorTSA+DkO3JuUQ8Wo73Gwy6zfeAr8dVw/lpTG3PbLqLddKVSyjx
 CTyCCfKeMBDA0/scfgxC/dfG872UreicDgkqOqp4yq7U451nWrkdcJnpLMiA7MA7icdNQ
 TuQDCix4IfnlUTDJ1HjQVH14R02Bt2Xdm8xvM7ekGnDOLL735iNZJ0vaZXWk0vuiAHnMv
 sng4Af6ok+VhXSjUu9p2WGK3o6pv2Bhq8y/r6VTZ5waAt7BKOvK5X/xo8IQ2KnA86jPhH
 Yb6nPlBqY3Wd5y7+9oRdCwg+NrCZllsVhaOJdtdBUwfPnxepYPUwusbUfBEyhi9NHJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791215883;
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
 bh=Jj93X27MDcdG51QxjU2Cj5Ck21FGvr16wpIjzVXf/80=;
 b=Lve/hR3c7gVrmblDO8uRmYsm4Zsqy0/Ve6qYwDxfEmenWa7bFcrZCyYPtfT12hepyb+o
 ZytMkqtNjHcKQ7du/evWPBXgbPioGvtIuADL60L+ZkNXHcCM2L0iVwF8DydN16P0/aCPS
 T7FtkcLYjacWSECUtjpPl/n1PgqeeEjUCRuum19nsykVvWmbNHwdAiuWPScB2MVSDteeP
 VVUq929qiXa+jy9AaWY3t49iqEVUq65ZSbg+fyu0pyJ4RJ8mSEtXiQ/lWwMDz9Pyw/Gip
 5zf7st7WKQr6NGJ7I/Uu2rO6lLjmNEnzHeVczAw0WCEvjbKDWVthMxTZgt1a5UUGzcw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oJzDHlUs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=oJzDHlUs
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EBE6401EC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791215883; x=1822751883;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9js46AShPGXnleBv7CUmNywq3uwDbAEV8IX5HSoGO0c=;
 b=oJzDHlUsu8jWaCxaCHHWHKd81zPFW3UbmphlHRTvll0O7kfyLMp9DscS
 DRJIso1/aqvMc+am2bML3BltJhlZIUmLKL6WECMg1zfqnJj1dFCqeu3ss
 a2Vrcd2WcFy755CYxtEcmwf8beYEd1r4nrllvlo4Sur0mVs3XBCcd9Rhw
 3jrQhkBqUW74FFCb+e6FWzSFb1QUC2kPgOxNS60p1AV6BDDnZHTOvQ/1M
 NAwzuh1xP+3xnon9bYuwXKTUDnsZ843AFmsXdjclYzC6E8BcNAuqG6jvy
 KlxYZd1HZZmEiEvvBRDHNU+gdlAjFXTUfQFRRCbR2T8dsolLOhJ/NvDcc g==;
X-CSE-ConnectionGUID: yhglYFd7TJK2fuFQrhLF+A==
X-CSE-MsgGUID: +Eql7mOyTEuwdZOZFtLCkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91022082"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="91022082"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:58:02 -0700
X-CSE-ConnectionGUID: HevB1GDjR+WTkSdo9HKHHQ==
X-CSE-MsgGUID: QL/sVgJnQROCRlmLSsdCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="276974666"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:58:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:58:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:58:01 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:58:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgxet7KHoMlUF9qkscMu4MzshLLYsavgf/Oubi1cP126wSnUMtrJKkB54guV5FBH3uWF/7OnynWC1ukTgVTLLXW7Lc6wKPqChu4WDJW3L2InmyKc+d2Y6w/E9wPKS77idxC97e0ADq56FfuW0Fh9eX4neulH9m5ELqXEp4bOTKhaYNOfcsnf8ko+z9qZMeMFaKAVXufbgaxGZYAYdmVYknRsOYsG99fpsyMpZr6rlOTCIDQIFhAMOuc9s2nah9gRwbdzp8wrwR0DilJXRdJ+1geJpAjZloCwglJyLVqiU2MQmQgZJnE4vlo9BRUWj+6eELdaL6O1rtb167QmkAlJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj93X27MDcdG51QxjU2Cj5Ck21FGvr16wpIjzVXf/80=;
 b=q0Jvrb0RveOFAMknSC0svyuU7kG5PRQiB6ewhO5r6w13e5mItKC6eoNOZz1Iesvf5UPpqC19TGFk3a1/2A0LyLjua3oglkJSNfmPnOWo+jiC525JEwDjjRM2zov7ZmobH8mbSWNHUNDvne5Wz+kYRzRbT5NcZjKdPcoIR0FVAq+o0AJSATc0U6aaQzjKU4I3DizgF2eNvIAV53x/nVCIsbQm6CK1F8Q1vqnHyQK1NT+pllLwhdMn8ncpiPsf/hhLK/o0Uey0bbSXib/LE88SbNgViD813FiR0jGjSCSVLlSvFldY+pLn4HuzCPoEG6FucSk5e3m6GzteMGcD8kkdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH3PPFCE69B97EC.namprd11.prod.outlook.com (2603:10b6:518:1::d4d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:57:53 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 15:57:53 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>
Subject: RE: [PATCH iwl-net v2 2/2] i40e: avoid resetting BQL state when
 freeing temporary Tx rings in set_ringparam
Thread-Topic: [PATCH iwl-net v2 2/2] i40e: avoid resetting BQL state when
 freeing temporary Tx rings in set_ringparam
Thread-Index: AQHdMW1W+5Y2uPnuRUCH/uuF9ja3XbbvYYhw
Date: Mon, 5 Oct 2026 15:57:53 +0000
Message-ID: <LV1PR11MB87909BC97400D33B41E396FF90962@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
 <20260821130157.1451118-3-aleksandr.loktionov@intel.com>
In-Reply-To: <20260821130157.1451118-3-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH3PPFCE69B97EC:EE_
x-ms-office365-filtering-correlation-id: caaee67c-c8b4-4152-6928-08df22f96a5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: IldPpig9EdAEHr3zyAIvBDv+A5b1i8XOvwalm1yDhlrnOUhN9pAyx+p222/CaYJQakr2jtoXRvWa0FvZqnDLhMZFiLTurc9HRFyPtv/Je5ApAMFv8TglmaBtio44zB0H5nqLLMJywtnzhdP0y5ZDb4eOcVaKD4xeuhIXgKrgL29CYJKiZwVuH71n7zwP37kSYvZ/HUKfBZVvDlYmqVWgfKsLRySeVt46DA/twaL9DrVPMFAA9wmv1xXUiKxeJRzjkz4p8fSiABQxG7pF6ggEsmHzvDRkC0bKkp9Ds1A38iFDuw/FizghB9E4OoDpvas0j5jhog7GeRQIHM0pq8hTSJDb2JXKfI8qYJnNvyKxg5X8eYPh+LHheX2wavd5wDnurYKGlo+iqvUqFPHrZ9J39Opzk2x0qyQqwyFk1XjMvA42JV3yFO2N5lWFVBu5KTVcpgHP25AUGMoKxOy0By7IW81ECKubrhFY9leplzonTncuopK9oFYFG2WSIzrzZlRUrL2DBp3zWghRmklFzXGTxfhmg91vOTuJVaPbXj4Ri9k0Qp9aSIWbWovFj8TAqBxhUQkj/btK8J0iXNQmj+wD7XIt9EZVXfs/1fb8ZWvf6YruKvoW2Ap+0G4cRd+NXJat4rGrD4Z4In+/t3NVual5XuAsFpZLbKhCZoXgmfg3MyAk4naQVJR1aIa4WGryLTtuCyp/gOdC3gGt3zzz0QmLSEZkrgJSoVd48XOyHgfxjm8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iEzr8vaSGchgfjKaGNmw7fsYGApMD8/6mqjx6Zp27DnenBh+6s0j3MP8ztwG?=
 =?us-ascii?Q?xHXNvg69b8tdayUYoOzflRupiK3e8L7/CeNQcF3dyAM6lm79MhwpD38B29Vu?=
 =?us-ascii?Q?TcaGeUnkUbeBBPIKLltCbjAud3aZo7otHqY+xnBwdgUfn3fVedMJpATFn4mA?=
 =?us-ascii?Q?WRq/3oy+lh10g7ZhBusNEIF9vKVV3di6JcBEgRZcvY+WMft+dSdPtb9JNUc1?=
 =?us-ascii?Q?0vXIC1p7SisHdL3Of7B1v7qAwKz8JKPFhBb+88aDu09+AHFf3NyJ+MhYeDXc?=
 =?us-ascii?Q?Jj13VffKZEZ02cjhp8PRjJpsccFIAg6vTfDLmr1l1zMi7vyU5WmMVkHqPxnz?=
 =?us-ascii?Q?pptUyeWvl9w2CJ5wmL0VKdzz+s+R0bSGftlxKo9GF/RUI/GL5+VCwSdluhSI?=
 =?us-ascii?Q?R8WAl7olmCItakTRbAyRAfn4YbcOuHKfDkw06+HrJM9VgGHHpsHwkPeoEXco?=
 =?us-ascii?Q?wB/H/F78Pn9M2CdXyq634N6UgqP6J4akkziuv1EiomhgHaAdVLp5+JqFD6vd?=
 =?us-ascii?Q?j6t7v91k16puVsfV2GbH4QYofX9FvPxEuuCRP9ekuA0LF4GI7KWgmQw9IStj?=
 =?us-ascii?Q?6KFJP4mH0zfrUFSnJEPvReRrXBoez8ZwaAolOpe+DfqCGKxlekfL6fBcmc7+?=
 =?us-ascii?Q?pYnVvumiU1wOfaI7H95HIfHuOJmWkfMkIIcF4qJHSzoqlJld/5kXYoscEsLn?=
 =?us-ascii?Q?EUpwxxXpr/3dAdQ3Rhtk/rkFYalSz1OVD5fV6d8GuLIucU/kPFAFOLI5T3+3?=
 =?us-ascii?Q?pRjS3P+n7ZaET1sOEfCCgmFB/j2zU08Ii6YeEUP/UNLTPTFAyPim24ModCYy?=
 =?us-ascii?Q?y19/FAEu3X1twl4shFxKTphm+FMP1c7WFnUUJvqTnc6u018fVwtwsX6Cvdkb?=
 =?us-ascii?Q?UnVhuAh7vAK24bKJN7W+3sQR3gj+SuMnYJSz95GubC4JaXTSeOp+puTsLBpd?=
 =?us-ascii?Q?r540xmsp5SopTkai7QZlEv1JgI2xJucTFGb0PswfhV2yKRMG+3BomcsoCCNe?=
 =?us-ascii?Q?edBg2tbvQ/zch0TWdATkKWXfFRodYjqN97MaICYeKJ5uTXtgRpnhpBAB5IQK?=
 =?us-ascii?Q?XXnJYrxDigLeeX4KxWv/5l+RJX05v5JwleYMlerlXfFRL8D4Bx6vXc51SCeh?=
 =?us-ascii?Q?rNYbgYQ8Hvu55a5VWHG/NhKGEZIUSiJNhfKoozWuc4mYE3WEvFgruwCYaogf?=
 =?us-ascii?Q?GKoP7/wU/zx1pmw0g1lnG9AqzaPQbLLy7+wYK8EVdnWJevWLbZ56d6xg+PQJ?=
 =?us-ascii?Q?wl444L9eH9D10SieHYEukWWFTa8gkEMNIH8Kn/dl04UgazEM7g2RMR04RFjm?=
 =?us-ascii?Q?ipqZTAXsZ6U8rwgBtW0MFl1YSKxYhN/v3JSbxG3jvI2hoOuSSLHXVvHzDwqj?=
 =?us-ascii?Q?nRqetUI5nIfQ0N0zV47XH7/IaI/uTWA2UYNAs7Inw1dZqsG21b8p8G6K56U5?=
 =?us-ascii?Q?nFQgj5YrGpiwG654AGOHTmdSluI3dRSNeWN44UN8UxYfU5Jdov5HBbPWLZKY?=
 =?us-ascii?Q?3ebUJkZqLYHPcQcF6I0E4yE70ID6qLNqaI5ssGU6tYcBvZsry8FcE34udqKG?=
 =?us-ascii?Q?e0D8Rg29ipg/8TUns4wh9kLKMMbAmtuDpMIVJihyzEfc1PsUdlJQLyLN15eF?=
 =?us-ascii?Q?rq2FwGiZUs4PIF6G/HPd7CM9YzKc+cgZ0Nv2QRyJgFPRDxlmmXLXq1QLvObD?=
 =?us-ascii?Q?PEOP3MRBytAfHSZ1D9ppOa+f2trtaPh61IREET4DQsyo1rtkPdOBhL/e8seK?=
 =?us-ascii?Q?PYAGS6/u4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GEwKVr3BwS5E0yFEeLuWQFh0um8T9eoc8G541ECEIs3XszQLLYwPI3nLXk1nO0mv0AWBWMy+dEunYfrsii4xp2+c0uyA7vti7EHjjwBP8+zyLfy7cRwBDXNckWSnvSxTp/WIRsZmA9KtUaYwg0EI3YdXOirm8yKGdb3YAnQdsK0PuPS/4kZIE26Z9FbCK/gjUydhMiXxNlNMSuCjEkb9a+vysgKW4ESREr0/cygGYxyrjs/qiDLPBrO+FVzAKmv4yP8gG7IuE+tW4tPODNlcD6qELNUyewwE5Ooq2jzFSCmLCR352SoEXYpoKhtbshk+ED82CAKEMAC/d/uAzLSMeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaee67c-c8b4-4152-6928-08df22f96a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 15:57:53.6305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TL/xiqLAn+euXrwpD1hFqwUwCINa1S9XCbd4G3VNSSf0xXrigkO/hLAHjuY7tCEJk+cAfQt4I8rGWea9aW84qWuKtRccQxldajiiF65I5KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCE69B97EC
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
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>=20
> Sent: Friday, August 21, 2026 6:02 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>
> Subject: [PATCH iwl-net v2 2/2] i40e: avoid resetting BQL state when free=
ing temporary Tx rings in set_ringparam
>=20
> Temporary Tx rings built by i40e_set_ringparam() while resizing descripto=
r counts are shallow struct copies of the live vsi->tx_rings[] entries, so =
they retain the same ring->netdev and ring->queue_index as the live ring th=
ey are staged to replace.
>=20
> If an error path frees one of these clones with
> i40e_free_tx_resources() before i40e_down() has run - either the
> i40e_setup_tx_descriptors() failure unwind loop, or the free_tx: error la=
bel - i40e_clean_tx_ring() will call netdev_tx_reset_queue() on txring_txq(=
tx_ring), which resolves to the *same* netdev_queue as the live > ring beca=
use netdev/queue_index alias. That call resets the queue's BQL/dql state (d=
ql_reset(): num_queued =3D num_completed =3D 0) while the live ring is stil=
l actively transmitting and completing Tx on that same > queue.
>=20
> The next time the live ring reports completions for bytes that were queue=
d before the reset, dql_completed() can underflow its own sanity check and =
hit:
>=20
> 	BUG_ON(count > num_queued - dql->num_completed);
>=20
> i.e. a guaranteed kernel panic, not just a warning, given a queue with ou=
tstanding (queued but not yet completed) Tx traffic at the moment the clone=
 is freed.
>=20
> Reproduced on real hardware by forcing i40e_setup_tx_descriptors() to fai=
l partway through building tx_rings[] while flooding real Tx traffic on the=
 affected queues:
>=20
>     kernel BUG at lib/dynamic_queue_limits.c:99!
>     RIP: 0010:dql_completed+0x285/0x2a0
>     Call Trace:
>      <IRQ>
>      i40e_napi_poll+0x74b/0x1700 [i40e]
>      __napi_poll+0x10a/0x200
>      net_rx_action+0x2f7/0x380
>      handle_softirqs+0xcc/0x270
>=20
> Confirmed the same trigger no longer panics with this fix applied, includ=
ing repeated resize/traffic cycles.
>=20
> Clear the clone ring netdev before freeing it in both error paths, so i40=
e_clean_tx_ring()'s existing `if (!tx_ring->netdev) return;` guard skips th=
e netdev_tx_reset_queue() call for the clone. This mirrors the same > idiom=
 i40e already uses for XDP Tx rings, which also have no netdev_queue of the=
ir own (ring->netdev =3D NULL in i40e_vsi_setup_tx()).
> Only the temporary, about-to-be-freed clone is touched; the live ring in =
vsi->tx_rings[] keeps its netdev.
>=20
> Fixes: 9f65e15b4f98 ("i40e: Move rings from pointer to array to array of =
pointers")
> Cc: stable@vger.kernel.org
> Cc: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2: New patch, split out of the set_ringparam NULL-deref fix (1/2)
>     after review pointed out this related but distinct, older,
>     pre-existing hazard on the same error path. Trimmed the inline
>     comments to one line each.

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
