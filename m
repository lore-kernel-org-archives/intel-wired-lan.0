Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A92EC98304
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 20:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A8D1845E3;
	Wed, 23 Sep 2026 20:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UG_NOiukY3Ic; Wed, 23 Sep 2026 20:28:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 64D3C845DC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790195301;
	b=fj3zxB2UiU8oTtUIOUrm0KdDhMe9e4s7kPeEmHOYxJJGEYyOr/iCt7yCkXIBIScFrnLN
	 MFAJBY+S0XPOQBmyfdFd4YcmsEAXOI2lXVN7xJBnt07mvnTETsBkeh6NwHitA73YXgyuQ
	 k7HIGdcmSf77mDBbQ/1Oqr19rp2B3+7r18nAvuSeeJbbB+gGdK7Zi+NC8JKP6HaH4ySLB
	 8G6MHZqiTUsMDA5EOe3d4ruCD4bP2MqooIcyUrPL4MlaCnFITSD2vbP8cbY4Sf86Le11M
	 tlUrCvR+vos+W6fGyrycjh9kZa+0nujofLlerrMatnQYARJoVt3v7kWWmAxImfUkqYw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790195301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KHrMVug70pT62lRCVwziLyZTTYKAui9DKG9wkKG7z+s=;
	b=SuSCVWVv4+hLqiXCfvQXIXZ9u6R5rqthhNJURpubFFq2G6jnURlMRS/8Zuwj/f21thba
	 5XmJc3qf3SFfftgZRjWtJNrnBgrlVZAe1NLq/3msUSwp8EAY+pIY1zNQf9rrfyeNvVS7X
	 tWpc42+cG/oPHobz+7HMcRwgAXfQUSj68veVd4v0//jA5FSch/BK+0/GSyIdjhTCH2c1R
	 R51P+9BXH1j/JGnnSssE3Fz7U1NSgbBklQt+h2/JB6eazLYEflzvONuu3wFEcHOdsK+wj
	 mKVwYCaH702W+NgxY+luOX+f6uzzhhHBlHrPZh35EV5MsJxe9Re+JZG+OIqQPCrgDEA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790195301;
	bh=KHrMVug70pT62lRCVwziLyZTTYKAui9DKG9wkKG7z+s=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iXo2O8SQ9EcXNoBhdzL0eM1O6YGrgjyc51I1bwi3WNUlVKZSHl667iE+kqMbLkVhn
	 k5G1NG0k+lPt6axHRAgQBQc1k2Hl4VR+UY7dSxDKtTFLdKJkHv4rgvae+aM+ji1tft
	 xlPMPaVVazt58RZKBrO36c/z2kpZ8fk/NxbUiNUeRrtVWlfM2+eYeKla3U1DD3fVd+
	 3+w0mPQN4UsJ+myumJX9//tW9vi9CgHPNqWgeuFQUGAMIO2I5Fx+bUOAJ27oEzB0qG
	 Id9CDKLJmCE9rcZU5yEQDE7MERTqYr4rcSIS5/PO/rwyJV7VA6cBWOKXtL4gxvekNp
	 EvQihQtoaljyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64D3C845DC;
	Wed, 23 Sep 2026 20:28:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7804C3A9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 20:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E8C540270
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 20:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KCWtUH_7EwuU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 20:28:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 64D4A4008A
Authentication-Results: smtp2.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790195299;
 b=RXl+FEAgj1ceVFxNHZTKOuf347bBZU88ryyF7brHloeNBbKM2Dv3c+XqT6m7/DIcMXr5
 R+AFK76GsvjhuQIcqtvdWG5fYXHGTk3NCtwqi+CNgTafnjSDjvAhNHGBj3CnJaIWtE74F
 CmzSNX0lXZlF7dGlvlzT1F+VKogMcx6SMHd9NNbsODc0vkut1H8zv1gMolsqwn+li1US0
 zj1Hd/2lXShbblfxjOPJgleDb2m5Qyw/dPqJoVTLWO/BbuAO9M9MoeFeW7yZHkC7Sq69u
 lUrOaZ9odBKlBvJ+qPbLTe+kHF6d6wkV6Cd+5GYX1Fup0Yyi2rKzojVH68ptGkwI8IQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790195299;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
 References:From:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=KHrMVug70pT62lRCVwziLyZTTYKAui9DKG9wkKG7z+s=;
 b=iWv3bLHjiuUdzFKW7KZH/KiRQ8gpwkPpaHcOEOcSrOmKhpcPZdJt9W1TQc21RaMdlbra
 2JKFao2e7WgQvhsVM3QAmN90v1vLFiAKflbxVoWFLe6NqGqbh8Kj+1G5oV6H2qTqF/Z7p
 Pe/h0LqxJB061m3Uqmxkzoa1VPEZc71XvvqCSkgFKAn50D3JoqA+r8RL/ptZQlR7TnuPn
 J3b49wzTP+Ni9aeG+dgxlde1YLEuWzrQLUeyup8l6BrPoF90zzFbAR/PdxLjxFkcWmlzZ
 FA26uXEWNH8nQUMRzSrgyUvW8wWHF90MP27VgxidGymM/sv6DazEGsAlhoM1DZNyRBw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MK7tw0WV; 
 arc=fail smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MK7tw0WV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64D4A4008A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790195300; x=1821731300;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=RscWvK/p2K7SGe5wCS2ypuRd15u7X+pHs86yuimTP1o=;
 b=MK7tw0WVtVC1C+JWObkUo9sxvEI1ay4Yqz/gfgp1fsanKQorNwMRH/up
 0D0/tRXVT67akn5hCPpy94pIOIok3b9Sqd6Aa/G4X4fMZKqRbbioVKyfN
 3H/APufqhHJtOgdqDFKVbBEFQV4VOaQb3u9uWB9ImduZLPYND6ccxV0AW
 Q7Zgv5F5wIa/YBbcTJx/TSihvATeAUpwQqvrAifDlSFN+dULcGXOa0U67
 MKFM1aiGn/vddElACjYB2oauAU+hoUX0TbMkjQ1tr1iaWwJ1O8p9ziZGn
 P+BX8PAYf2Rmio3us+u21s2X9AdMtcOCynycXsUHlpvq9zBNwPSsW/b8W Q==;
X-CSE-ConnectionGUID: BfxivN+lTmmJX9A7wWaEFw==
X-CSE-MsgGUID: qj/tNKa/RrGvqsvMeUVZwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90957619"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="90957619"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 13:28:18 -0700
X-CSE-ConnectionGUID: kH24wuoRQ7ml7DcBfDDvew==
X-CSE-MsgGUID: qmiz/oQWQY6fOOpxg1gf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="272956240"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 13:28:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 13:28:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 13:28:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 13:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZNzDYmnJrMxyxkK+LJ6ku/E4YeiYHstt3ppkQg2XISdmQb2eC+uBzUzDPyqr05ihTsBk0ZP4uhSst8I/u5OgjEfBIdYOePT8xkbzli1ywNoVktXOBWKrrPA/tIdxNG6dB4d8flYEa92NT+PllZsLIH6jOnAgAIVxMDFUt/bQgKXlZh2jkpUf9O+RMJSGEgoBzw/EgOPaU/sHDv1nv4Ic4uc50MThFLTWOsUIJLuOJuhGuB3B90DBIpDF9wguUCr+C+LYs/un7lXm8bWEKD/fMPhvLUMISs8WKb+o2cx/hEWROGTLhgTi6pzcsLMc9w5bZlVs66FWORtyrCAEmL/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHrMVug70pT62lRCVwziLyZTTYKAui9DKG9wkKG7z+s=;
 b=mf2rPblGkVZxa/WLwlct+qqRmR2KObkWpCTBbRSPeMPNkeihusR4Hxge4z8bjZP7QDLBX4+/gHiL/d/xw689TV0Ak/rdpfQCrroIVf3vtJGT4gHtsB68uzK1YG4yChQCtbq7skibfdPf6jyWbx42aIQREVHQNwl81sbSqdKqx57fcGN167A4NiSf9uvoWsC3XCoZ/MNv6aDqFFblvoz6mgQldPYNUPk1eOYjUXNKFHq+TgLM2KGaspXMjY15J+xCRR+Kk0T6XWLTY07Pa4t+w6gHjczUWa5EMbbjHPuhm+/MtHXwn76KzQvE5LK0A53V+rFx284vG9vYvYFKEYDNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:28:03 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 20:28:03 +0000
Message-ID: <39ca7fb2-7da3-44be-98e3-cab13294b68b@intel.com>
Date: Wed, 23 Sep 2026 13:28:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 01/15] ice: use reference counting and SRCU for
 PTP port access
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
 <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-1-e55b692d0e6b@intel.com>
 <IA3PR11MB89865E16941481F634A03E9EE5822@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <IA3PR11MB89865E16941481F634A03E9EE5822@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|CYYPR11MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5d54de-e0eb-4cf9-7a71-08df19b12ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|5023799004|6133799003|18002099003|22082099003|56012099006|4143699003|921020;
X-Microsoft-Antispam-Message-Info: P17TT9wZItylZJNX721NbUKVXtF1/VhcVGZCxsJ5hFycon69WksG1FDDb/0XMi9VXA/CgXkarJpcAGJSWvVxHtxT6xIgqLBVkmKoqKI461imP+PZ0vEymNy7rowZiItnLXYFs5W+VDK3OA8VS5Snd2IZ8KS3f5IvymXsXGYv9o3v6ueFLTqd1YHCoNFEQ/AjMEfi1LxkNwWD6xr2KmGJtuE1eAnjT72A4RoWqg/QgBizVHHsVs+8kox2MNZiRQe7PmRZcbSg1pWAnXGpe9gjDv2lv1Cnt98Q+EFzz9a/PovI0rDKvTmhY8+QuGzpcnOjQjT9U0kYGOVRww9qNYGnbseTFjw3VR4uHEB6nfaHOgdSUU7KPUpF1uoko+Nfz0FTJxHuBbebPXV20uV17fq3lfoebHZQJFQodfBcfSmsTFmcMeaCM1XZzNxSeQ8zx3m60y6wlTRzZ33AnMbKRiFljhKFKE9yeErg1ZfxtlkWEhrIKhbslt1VaF+qj5Cc7DCEEvLze4kGARAQLwe6SxlAfbZZGy6GLrSIYHljJT+F/WY/0RHNG1OCWUnWV909lTOZnW3TC8qW/o0QKXlb9eLNT4yUnuUiglBloljo+H4W/Myq+D/6g33HJcy1Nao5qlCV5QN05YGp2OD6KRfS9Gwox/gaYdDRYA9KuyD3YDqiFV2C3na+3q5HwzWRB356lR01PZPo6iTjg0lHTl9P26fjoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7364.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YThHaTNHMzIvZWEyNXk3MGtUM3pRaXdkQzFQTk1mSkVZU0V3aTV0alJWdm5s?=
 =?utf-8?B?OERBZ0FsTExia2kwV0tiL3B1Z3VqeERVc0l6M1FGK0JGaENqeTluUFdrT1pZ?=
 =?utf-8?B?M2dNbzF5MFUrdnBCTEhRK1FEQVF0VGtYcmlnS1BXWDJNc1ErWmxmUHpsZXFV?=
 =?utf-8?B?RmhDK2NUTmhSMmZjSFhrTjhDa2IyR3Zuc2xhOFpiNVA1Q2VzSU5SdFMwUlNL?=
 =?utf-8?B?TkEwcGVJRllQWitSREh6Y3hhRi9IYTlqUXBrQlhuaHQ4NU5zYnNUanM3RW1r?=
 =?utf-8?B?V0RCa05GdUNMTnZreDZ0bWNycTN2aUNGK3VJV0l6Uk82WWxtRGhYSkZYdU9z?=
 =?utf-8?B?M0I4K0gzazlEMWtqWnZLZklMQW9sVjVENVhscUJ6dkxjV0FOeGVZVzk3cGU1?=
 =?utf-8?B?MU82cUtybTJXR2lpWnhMR3c2SUhXMFpsRmFzNmI3UWFmc0NMOGhxY1JyalBC?=
 =?utf-8?B?RFhIOWMzdHhGcitCZSs2UUxLSGZrSk9sa2JhYzBZUHBJTVI3d0lBV1RSbkhJ?=
 =?utf-8?B?SVNTUGhJMnpLc1c1dml2Yk1QT1cvNTVsYVRzUVdwRWJFMUNjRkVqNytEeEc1?=
 =?utf-8?B?Zkk3L1lNeDI4dEFBdnJoaEtkbXMzbzN3a091SU1NNys2MTVsUFM1SFNMdnRH?=
 =?utf-8?B?SDBjZGxkN0dTNWtBU2VONWcxN2NWZlVoaVEvTWUyVFdEVTNic2N3dnhHTnR2?=
 =?utf-8?B?Y2lQWFArYUxFSXRSeTFYUmoyT0pQZitXckZDOUducVRYTDRwZ3lZbnVQM2hx?=
 =?utf-8?B?TllMazFjbGRKbVArS1V4RW9PZHBDM0Q0ekxnRXdtVmtTcHBTeFZXTUtkeWVz?=
 =?utf-8?B?c0JZVjl5d2UyRFhKM1I2akswYzNhanZRb3N2MGNIQTRKZXV6czFha2ZTcXNV?=
 =?utf-8?B?SGxHWGtId0cwZ3FaRE9pT09NV0hwVjJaOHA0SFlYWVg2SUpWUUJWLzFjL3BT?=
 =?utf-8?B?QW5KanJGK1VPYnhueDUwdVJ6eUVSSmtzWW50Q2xrSUVxM3F4NnRIVXN6M0Mr?=
 =?utf-8?B?N1FaMCtDMkcvUy9WTzJjL2pZZkU3dGtja29LeEtPbzJQa0wvcFlkWnNTRGl5?=
 =?utf-8?B?K0xwOFlkK2dEaE8zc1VabFIxTW1IRnBsdmV4bHFuVkpNZlVnaDFFUHlGcWxs?=
 =?utf-8?B?eTVhSG9ZOGY1a2VaMEEwSlR0YnZVT0JydS9uWFVReThESEdNNFVkTWdmMEVU?=
 =?utf-8?B?UmNJSWdrTzNhVkdZajJBb1A0UEFhTG5CQjIwUUlRUG1zWnVrY2oxQUR6b3ls?=
 =?utf-8?B?OEJjNVRTTTlrQjZpQ2RMWExJQmh4bDdXVzhvMm5ldTUxRWtOOUh0cnB4UVBV?=
 =?utf-8?B?OU9QR2djaVZoVnJwSWxyZW8vUWRLbEV4NTFBdmNRa2RtK2pvOEROQTFaYkJi?=
 =?utf-8?B?NlpjaXExQVNBTytmOHdITDZNaTlRTkJSV3Rzckc1bTNOWDdHdndKMmM5NFVD?=
 =?utf-8?B?K2JYY3VsQzVWa08ydEI0RE03RHZDWEZnak5BV3B3THJIMWo0WHJjcWp3eEpM?=
 =?utf-8?B?cHpHeW9iMWxRYm1BV213L2NBb3FYRngvaUk0NlcwVzA0WVh4cm14czRXaDFz?=
 =?utf-8?B?cnF2SmhRb2FlNi9VQml2ZFYyTXYvZGdFRW81UTFneWRGeFhKTVZLK3prZGUw?=
 =?utf-8?B?TVRKOFA1K0xLMzBmYmtEdDNhVTNSOG1UY1dWQkJ4djY1bEhKMGR5SnhTMTJX?=
 =?utf-8?B?b3VMVUlnN0hnRGcvY2tWZlZ6dWtielVrZUkybHphWGlTZFRuNjRFZjZiRW9w?=
 =?utf-8?B?S2ZQa1YxdUtrcGpCQ2pYaHBZdzVJUDRDeUF0UUJOc0ozZlpyQzhLWTdaa1Zw?=
 =?utf-8?B?Qyt4aGRGYTZvWkN4YUt1Y2ZMZXlHd2ZBS2RlTDlPalVvc2t2RWcyaXRzOHNP?=
 =?utf-8?B?aFl0cXR2dHV0dGtNeHc1Vko4ZGdKVWcvcHpaNEJKcWN5R0M3SlFaN29FRm5X?=
 =?utf-8?B?aGF2M1BGS3lkVVVBWVcyR3hISlhoeHhHd1A4dGREc2VpVFVyRlBuMWdSNmcz?=
 =?utf-8?B?SjZQZkd6UlNzZm9kRW5HdDVQWHhpdkpoZjN6Tm9sT0YrVjMxQjR3ZUluL3Yz?=
 =?utf-8?B?eExUdkt1RzJyQkplN0VKNktUL1Avam52REVZUStnM0gzaGRZTzk0eWFscVpI?=
 =?utf-8?B?RXFEUUkzWnN6UjN3QmZNRFB6d2lWazRGWXl3a1FyRnhsdXZmZnNTZVpQWG96?=
 =?utf-8?B?U1ZiODNyRHNSRUhoR3BYdXRYaWFzWHR0NXllWWdtOEt0STRXS2EzbENPYzRJ?=
 =?utf-8?B?cDgzTHFFOHdnMzRra0RyWnl3VzRpZ3JhbEJidWloU1JqMENwU2lEdHBmK2Mr?=
 =?utf-8?B?M3FVKzh5MHBPR3RubFVqNGJMZWNBL0pVcGM0ckNNWFBWU3VQUzB4Nng4b0dy?=
 =?utf-8?Q?QVfSp4D14LS3kOu8=3D?=
X-Exchange-RoutingPolicyChecked: tNY8inyfgqsKc3PiU9xZlN/Yz7EJ3Z05JVj94GRAmERPr3goK/G4gDkPotOokxAczOxJlCCAWtHiCymFM5BSR9/Oh0aLX4XmYPys0pjMJz4B88hR/0CicFep9I5YmqWfH+U1K9JOC87lnvRSztESE923osogmAJokypbrO3B5OXyYiQmZdcaDntIcnp2jMZpLpvZrDIU+u/ltd8GK/mG6eRhGukPmJ2dTh99tNV4266t8cPdscKutYAcNDYhvVdudFYMlplbfx34PMNWIHpY3/DYOqIOwLB1cdtrQNz3wU/MBZ7UgVeWNOcSQZp/p/E5Ort6MyQPS0E0q+bojsX2cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5d54de-e0eb-4cf9-7a71-08df19b12ac4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:28:03.0356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIi3tAupBdILYNd8IhRCsMy0EWe67j1udkSTaQqnCEJLtxVCwnNZAhXl8lqqvErETfcOXChDrelAlxIbQGRvmS/73s1dMArg24wAux+Apzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8432
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

On 9/23/2026 2:47 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Jacob Keller <jacob.e.keller@intel.com>
>> Sent: Tuesday, September 22, 2026 8:03 PM
>> To: Keller, Jacob E <jacob.e.keller@intel.com>; Nitka, Grzegorz
>> <grzegorz.nitka@intel.com>; Kubalewski, Arkadiusz
>> <arkadiusz.kubalewski@intel.com>; Intel Wired LAN <intel-wired-
>> lan@lists.osuosl.org>; Machnikowski, Maciej
>> <maciej.machnikowski@intel.com>; Korba, Przemyslaw
>> <przemyslaw.korba@intel.com>; netdev@vger.kernel.org; Nguyen, Anthony
>> L <anthony.l.nguyen@intel.com>
>> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Machnikowski, Maciej
>> <maciej.machnikowski@intel.com>
>> Subject: [PATCH iwl-net v2 01/15] ice: use reference counting and SRCU
>> for PTP port access
>>
>> The ice adapter structure maintains a list of ports associated with
>> the adapter. This is used for supporting PTP, where the clock owner
>> must handle many operations that require access to the PTP port
>> structures of the associated PFs.
>>
>> This is implemented using a linked list and a mutex. This sort of
>> works, but a few places within the code do not acquire the mutex when
>> iterating the list. This includes ice_ptp_flush_all_tx_tracker(),
>> ice_ptp_restart_all_phy(), and ice_ptp_prepare_rebuild_sec().
>>
>> Fixing this is tricky, especially since it is not clear if we can
>> simply acquire the lock around the complete iterations.
>>
>> The pattern of use for the port list is read-mostly with modifications
>> only happening during PF initialization when elements are inserted.
>> This typically only happens during early boot, though a PF could in
>> principle be removed or loaded at arbitrary times via bind and unbind
>> operations.
>>
>> The use of a mutex does mean the driver can sleep while holding it,
>> but it still creates complicates with lock ordering and prevents
>> iterating the list in any code path that *can't* sleep.
>>
>> Instead, use SRCU primitives for the port linked list, along with a
>> reference count on the port. The kref reference counter ensures that a
>> PF will have a valid lifetime and not be removed until the reference
>> is released. Note that this change focuses solely on the port list and
>> does not make an effort to resolve access to ctrl_pf, which is
>> currently being investigated by another developer.
>>
>> Use of sleepable RCU is required because we often iterate the PTP port
>> list and perform operations that might sleep. Attempts at implementing
>> regular RCU have thus far not proven to be acceptable.
>>
>> The remove path first removes the port from the list, and we use
>> kref_get_unless_zero to ensure that such ports are skipped when
>> iterating the list. This ensures that once a port starts removing we
>> will drop references and no longer be able to acquire new ones. This
>> avoids loop iterations chaining together to indefinitely block
>> removal.
>>
>> The ice_ptp_release_port_srcu() function is used as the release
>> function for the kref_put() call. This uses wake_up_var() to wake the
>> removing thread.
>> The waiting thread will block until the final reference has been
>> removed, then it will use synchronize_srcu() to ensure any outstanding
>> SRCU critical sections have had the necessary grace period.
>>
>> This flow ensures that accesses to ports via the adapter port list
>> will remain valid until both the SRCU critical sections have ended and
>> all the references to the ports have been dropped. Strictly speaking,
>> SRCU alone might be sufficient for existing code paths, but the
>> reference count allows the option for passing a pointer to the port on
>> to other functions if necessary in the future.
>>
>> One major complication of this reference count is that ice_ptp_port is
>> embedded inside of other structures and not merely allocated. As a
>> result, we can't use the standard pattern of kfree_rcu() to just delay
>> freeing until references are dropped, and instead are delaying PF port
>> teardown. If any code path leaks the reference, the driver will be
>> unable to teardown.
>> Instead, a 15 second timeout with a WARN() is used when waiting to
>> finally allow PF teardown to continue. This has the risk of
>> potentially allowing use-after-free, assuming some path really is
>> stuck for 15 seconds. However, this both less likely and a less bad
>> outcome compared to blocking indefinitely on a reference leak.
>>
>> Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead
>> of auxdev")
>> Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_adapter.h |  16 +--
>>  drivers/net/ethernet/intel/ice/ice_ptp.h     |   4 +
>>  drivers/net/ethernet/intel/ice/ice_adapter.c |  11 +-
>>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 145
>> +++++++++++++++++++++------
>>  4 files changed, 134 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h
>> b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> index 4f695f32da3d..93f041943bdd 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> @@ -17,15 +17,19 @@ struct ice_pf;
>>  /**
>>   * struct ice_port_list - data used to store the list of adapter
>> ports
>>   *
> 
> ...
> 
>>  	struct ice_ptp_tx tx;
>>  	struct kthread_delayed_work ov_work;
>>  	struct mutex ps_lock; /* protects overall PTP PHY start
>> procedure */ diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c
>> b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> index 2dc3629d6d0f..84ac5ee5a739 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/srcu.h>
>>  #include <linux/xarray.h>
>>  #include "ice_adapter.h"
>>  #include "ice.h"
>> @@ -66,18 +67,20 @@ static struct ice_adapter *ice_adapter_new(struct
>> pci_dev *pdev)
>>  		mutex_init(&adapter->cpi_phy_lock[i]);
>>  	refcount_set(&adapter->refcount, 1);
>>
>> -	mutex_init(&adapter->ports.lock);
>> -	INIT_LIST_HEAD(&adapter->ports.ports);
>> +	spin_lock_init(&adapter->ports.lock);
>> +	INIT_LIST_HEAD(&adapter->ports.list);
>> +	init_srcu_struct(&adapter->ports.srcu);
> In theory init_srcu_struct() can fail, so error code should be handled, isn't it?
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 

Oop. I think I was looking at some sample code that didn't check it.
Will fix.

>>
>>  	return adapter;
>>  }
>>
>>  static void ice_adapter_free(struct ice_adapter *adapter)  {
> 
> ...
> 
>>  }
>>
>>  /**
>>
>> --
>> 2.56.0.rc0.395.gd1f3524e15dc
> 

