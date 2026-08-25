Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EABC5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 00:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4923680C0D;
	Tue, 25 Aug 2026 00:37:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKqZFJNqGJAk; Tue, 25 Aug 2026 00:37:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787618229;
	bh=o3toiUSdJjyN4oya9iGRcihfR6y0/YUfC4IxVcY1U6M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NTUHxCu3MUWvMtUbUF7kqQGljNOeVg3YXhUeZaTBbVKjUQTiH+o/La7nnZSWRhUqt
	 W7NYBkHxqPzMnFNOQ/Y4muGM+IeFjEim+B3Z4EzgCdPkyWWYiSoOEDysQosCSfEXc8
	 rX4zCIVfGs6aJCp+vPS62tmaEdpqoTJngSwQyB96B+vvcla2HmRs6PkiZgFtc194hY
	 okS1iu4RI8pI6GVadCHCGJOBLHZCAbPUE0C/SubVxjoenir4sq0KtmgvbTzPWFEpBW
	 1cA22FjtFHDPyEyK0yrlmamaq1zoN2bjeTzzbCqMyE41zG+e4mLC86IXRtyg73vTrk
	 qbt15itfDkWlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56FD880CDF;
	Tue, 25 Aug 2026 00:37:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B23A35E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01FB5405FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IFNUNxIZXFt8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 00:37:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jBG2fGmy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C88CE405F1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787618227; x=1819154227;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3IpB7KBaMxorcUXBY40QY5k4Ckn/brBTE+JckWUNDxo=;
 b=jBG2fGmyOe9log091GqxdCT9KVMlVQZoJdwK9Rp/c9IKp0Fh49lZomy0
 bMkvX+GajTqzTV3c3hZKY0mJ0TOX/xBx5c5IhWS61/WooGMdcGlCa+w3Q
 YFoIMZdB82kQXZpYmlxncx1h+iKiky40Hpvb8Pje29PvpO/cw9q7qVv+M
 01LdgdkuzLchOR2gGPlhVM1UEjnNmeg5kRxmlGQteStkYsL3yft+ZO7bT
 mhyxHucAM87LEvhrrUSCEOQ+LDv2fhTBVzvSUBuEu2Ql7qc2bUDI0lPpv
 razAiPkModjSGzwRy8bioDkEUUzBdyPMA0nrHI8kNKkMC0GNbScEQnLoj Q==;
X-CSE-ConnectionGUID: SeWdMIbuQvCrjBl4D2W4IA==
X-CSE-MsgGUID: Dz4hkws5R3evN5PAngTkQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="105459527"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="105459527"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:37:05 -0700
X-CSE-ConnectionGUID: taCRLeQFSuearxXLqWhinQ==
X-CSE-MsgGUID: ACOufXVoT9ipoANFlPQGdQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:37:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:37:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 17:37:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:37:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbQb1qMYkAGgByhGhhXnhbNHbepN6BVqMjY2CSmWuOQcpQ1ewZquJQLuh9mFJ8d2LoA2JGWunKnwgAafYRJDTov8ybSor1hJV11F6dOlbnMNCfKp9NiMircyPXLUET6wCcsSLLG771ZcduZfoFXAi1H8XguX4X1616Z4jF7to5PC3eeOL9OWaUTWutqSjnEBOTnhOcbB9LmOcFsspVRFKGOsKiLg6HnuKbMXfWs1uACIpH6rrRCUl34GVvPHOhEvoo44R8Dl4nB1yy6k1H207O0/40Jj1UVGEcxuqrncEy4uy9pNo21GfVK/LEM8sDiC9xZP+m8Rc5N0CyEaI48efQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3toiUSdJjyN4oya9iGRcihfR6y0/YUfC4IxVcY1U6M=;
 b=vb6Q5AExRqvYkpVjlOxNmByy8LnxErJ/2e6twQ6Aml21ux5bO/ebiBTJEdkXsQkouzoyAvCJhqYDqNl17S7eHb+H/BmaEe2Y7ozj3Ap1gLeY4YLxQZ0g1O5xJFeLg+EemgAqXhYYS4xboc7L3ZBdH3hoUUQqAPNhwaN9lWPKda4lum7m9D5Q9l9C0Vy8XVr1ulHCV69LQMUAmdtQmVSzz93qJ7Ym424ZX1dYZOUXlnLKAV+v7grHIn3785BwsrtkrGEbGFB9kla5pjzNR4AP/mUO/fbEKHW/LI+Cuqm1VXc4M1bBuXCSfvO0+pv/Ta4nBWqco8PTRAJ0Kt7DxfIiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 00:36:59 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 00:36:59 +0000
Message-ID: <3e84fc3b-8b46-4c76-9d4b-edba2ade63c0@intel.com>
Date: Mon, 24 Aug 2026 17:36:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 12/12] ice: don't clear in_use until HW clears
 ready bitmap
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-12-9d0731eb4858@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-12-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c14815-3561-4944-8ade-08df0240f8e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|3023799007|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SlpLS/z4q4MjKH6b6B8qChm6RmVLh8djwT2VvR8LekI3fr9O19Bpj9KU+dy8vO3+Rxb9hZ2lxq/0LmlQCEYSOdqccleUpXv1ueZuspsMQU5u9ECLzpGQE8RtV+eEPU0h8nTS+KayfYxqP6AqtF+o7xrlGtR7jmzDItW7msM1jZfOTCsOWp/1xwD52ECoOrhxAHezTsH0QsaphLChyNMeBeo+ugRbkWAvd+fchzxMq+karPCxUaI922zFAbgvsWIM0030VbhmdSbjz47DISDSORZD7+/pmxkyHcbwNIqcVVAP3QfASItBdsNojgDjYyAdKx4faoIDs9/bANEJGJJzpo3FE/wJxRg8zYuuZYZXTGpgTPSqXfA0Piz75XZ1KSjTG7703l3x6Eg7lSPyavupysi4qw1+GYeoXF5Cv1C1Ls4grtezefhBqWFNqXzO3HGA1i68Z+eusKS7xa1TIihBCpA1o8IGjxEB7TfheQHoAytLQrep+BKCeeBSvqYLlJKvGVc4OT1WjHviVnLtqUqHzjTWG7eOqkMdc/RRWcjF9n+2PbuPnrYmZ+trd8SvMmydtcTclSgid4VFMbyVzTxczsgQ89N9mnQi3atOh36iYcc4vG6Tj/4cMH8CcGBS0HVcjEZhW/M8IVMFQXxe9o6C3ZW0tLBEFKR+j523AAkSmwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDkvb3FOazR3TldRY1V0NWNqNlcyeG5WaTBDd3NGNHZTclJUQk95ZW5iNERM?=
 =?utf-8?B?WkJCMDBlVEJyKysveXVKZjNhYTRLZVRnVWh2TUg2MmtIK3RZV1U4MGlMby80?=
 =?utf-8?B?cnFKL3cvMGRuZTFCVzU2enMxTUJvUzJqZHgybU9yU2lKd3orKzE3cGJJem42?=
 =?utf-8?B?UmVkQnI4MHk4cEZ2dldNSUl0MUV0c2VrbktONExwSHU2VXgxNG02NXlBalNJ?=
 =?utf-8?B?NGErdVg3aTBwWnkvcW1scVlPZ2pOcGN0UnRQOGN2aXl6OTNnSHpaVjVMVXc0?=
 =?utf-8?B?R2djSFpIUGRuYVdndUVzVko4VU50cjhlODlpRGgxbk9UU21KSTF6YnBXLy93?=
 =?utf-8?B?eUdJZTcrcXkzbmorNWY0R29FdFZ5VUR2S1BPY2VacThhSWkrQmZQaUhNK0hh?=
 =?utf-8?B?UlRpTnRKdW8yOHVTZHNiSmppd05yNldOdENVWnFLV3JiUjByOFN3dTV3Znc1?=
 =?utf-8?B?d2tGMzFrd3FVdHR6b1FseWFXUHN0cWE1QWFpbFpIdnpWeXdiclNFOGtTS1gw?=
 =?utf-8?B?b00vNFZzVWNwOCt4Vzh4UjM2QkE1UjV6MHNQN290SDRMOEp4Rk9uRlVpQXBR?=
 =?utf-8?B?YUxjKyt5S0ZGYnhGc3JQb0JpWk9xZStIOEwrbHZHSDRxalJpbGxjZElNcE91?=
 =?utf-8?B?YjFza0p4SzlxKzkrRFpKWUxjbUlnci8xOVlraVdWQjMzVEdXemJSWjdOMVE5?=
 =?utf-8?B?Z3ZQdURKRTZEdUVlTXlGbERvc2N2QUxvd2VEQTFudUtYTTRrRDhneG9HWngy?=
 =?utf-8?B?UkRDKzIxcUhURzEwNW5iSlNTUHlIcG5jTVJmTXg1VEg5NWZyQXlkSkJvTjQ1?=
 =?utf-8?B?VkFoMnNrRmhXS1c3WEJJOEV1RUEvZzhmdmZodml0RjBxK1dWU1F2YVcrY2Ru?=
 =?utf-8?B?MGp2NlpjVVdOMC9YZzNvQjNZZmNvNGtoaDFrM2hXbm9IcGlYdWYzVGNVYUlG?=
 =?utf-8?B?TW5zRG5haHZ6WllVaVpqOTVpL1FvVStDaWJGRVorcmRkWlRkOUJ3NXEwRVAv?=
 =?utf-8?B?VXViOU5lMmsyNUhZOERnaXczWnZSMDVZbkNucW9ieklwbXdIU1M4dWhEOU1m?=
 =?utf-8?B?N3Y3cXZ5QmVmWHpzTkd0R0RaZllUNEZTOU9ybnQ1VlRXSWRrOUJqNloyNVNX?=
 =?utf-8?B?TzgzZ3k4clZxUXNFQVNBZ0QvK2oweVVOQXJmNWJaVHZJS2tLM3Vnb1NVRW9Z?=
 =?utf-8?B?L1d6Zm0wbUZTWU8xUjVTOVowYjBWaFpaRldSLzFCTXAvS25VM0ZOTWNmQlgy?=
 =?utf-8?B?MHc0cHB0WEZXM1BVQkxGc21YdjJFdkszYTR2QVk1UlpXOTMvRmo0amNtTmhP?=
 =?utf-8?B?NnQwMlFrazgyekV6bGY4YUd3MUpveTVnWUNUZHFTSlVqTU9ZTW5HM0dUOExW?=
 =?utf-8?B?c0QyWG5XRVZKd1lHcTVTbjFDUTI2Qjl5Rk9SZXNyWVFRYjJROUxzWEJnOUlM?=
 =?utf-8?B?T0djQXNBekNwbis2TkpnY3hLb1k3YnNFYURiWWJYcVlRemFTTkhHNG9nZE1B?=
 =?utf-8?B?cVhIR2VQckpiVjJmMDJ4aXdFS2paYktsTEtrT29KYTJXakpoTElwMjFyYVB6?=
 =?utf-8?B?MUxnM2IwRzB3b2pDVnhpVlM4YmtWL2VvWGRuOEo4dnYwNE9XMEFDUzQ5OEFt?=
 =?utf-8?B?dWNGdmN3WmN6dTBna0xZQUlhVzB1ZUNTRUhWSVZoSUphTnc5bGNsMWFEZUg1?=
 =?utf-8?B?R0hTNEpSSTExNUZKYkJUT3d2azcydjlpZ3N6OTkwTGJyUko5QVBDV1FXOXJS?=
 =?utf-8?B?cHZoTWptZmhMTlNkWnlnWFViclF0N2dOTVp4Rkc3UjFiU2RqVENWLzlVWVBp?=
 =?utf-8?B?MEp3T29QWHZwREJ6MmNLdklxSHBkeTgwcXBBOURtOVdLVGpCSFpFeS9hck9r?=
 =?utf-8?B?Z1IwdVNtckhZV3VPamY4cDhPTjNiTHAzcTVHeW14M2Y4QUFBRnNua2NSZVRE?=
 =?utf-8?B?YjVpZFA4cHByMjVEZytXSFc5N2VCdzNzZnByRm9PRVllOXRmdklDQmwxVWxz?=
 =?utf-8?B?VThMeisxK1ZpT2NWVDBMdy9pZDR5UHhrSi9xY3FjWDdJV3Y3czNtalpORVhx?=
 =?utf-8?B?c0pOSm9tVHBRTzVCU0Q1cW52SnNaR0cxWTU0RXdXaVdMR0VtVkhGK3gvVHpa?=
 =?utf-8?B?Si9MSkR0cyt0TlhRT3QrU25PQTNSREZPSlh4NUFIMlRVdE52dGdNaStGMVVW?=
 =?utf-8?B?R1hLbDc3eDNYUzRFNGFBYTg4VFBiZTZiN2M3RVpaNU56RmpEY3Fkb0hPeEpk?=
 =?utf-8?B?bkI5aXJ5VHRWbFZQRUFYZkIxNENtUWdPR0dGZE1TUkE0ak1PeFAyc3VHQ2Vy?=
 =?utf-8?B?aFR2dHlScitUL29UOUZsQjFBN2xXaE9JWXNvL2JMQjZNaXJhbDYwZz09?=
X-Exchange-RoutingPolicyChecked: APNdB+wJHfoRiNCkoLL64nSvXTV67C30Y3o9zJfIuyYBL0SN1DicVDpq4jJyso9v08Al+QofFA99N4yWbAkMa2nEXWVY1c37iEFcjd3xRVZq55q9x3grJHnCExniqwDS/yaV+78zuRkBFmk/wJOeZJVlE3owZDWwKCEV2/OBdHOlXxg6eQwn0/U+/LsEaHxNTotQllsNqSW19Lde0aVRiJ9annLb4DzXDDCL5hL+gKIS+bou9WYN5v36MFc+cujb8e4XVU/tzmRdaoYlO/3zXBcVjfopSYE34iTzjjWvOrQoL46pfYxDaEUvMjwE9/XrxBM5Sro2deYmVu0ROlACSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c14815-3561-4944-8ade-08df0240f8e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 00:36:58.9891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0Te5eZPyaOcJgY7FdvddWox9d8U558vdfFpt25GUHbmCuR8vyXB27XAHw8w9t/22btnCvcymiHw90JFm5onLsdyfCRzDZng+1l9VaFH5Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
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
> During a link down transition, the E825 PHY has a small window where it
> does not properly respond to reading the PHY timestamp registers. When this
> occurs, the PHY does not automatically clear the ready bitmap or the valid
> bit for the timestamp. This begins happening slightly before a link
> transition even before the firmware has notified the driver of the state
> change.
> 
> The driver happily completes the timestamp, releasing the in_use bit. This
> allows another request to reuse the bit potentially reporting an invalid
> stale timestamp. Additionally, with the ready bit still set high the driver
> continues to re-trigger the IRQ and check for timestamps in a tight loop,
> wasting CPU cycles.
> 
> To fix this, re-read the PHY timestamp memory status after each read of a
> PHY index. Double check if the hardware cleared the index properly. If it
> hasn't, mark the timestamp index as stale and skip processing it.
> 
> Stale timestamps are already ignored by the ice_any_port_has_timestamps()
> function. However, the ice_ptp_tx_tstamps_pending() function also checks
> the ready bitmap. Instead, modify it to only check the software tracker.
> Additionally, stop re-triggering the interrupt from the IRQ if the
> timestamp tracker is calibrating or has the link marked as down. Continue
> to check the hardware ready bitmap from the watchdog to catch cases of
> unexpected timestamps.
> 
> With these changes, the timestamp processing no longer triggers a repeated
> spamming of the IRQ during link down events where timestamps get stuck as
> the PHY transitions to link down. Once link is restored, the PHY will be
> reset and the stuck timestamps are cleared.
> 
> Measuring CPU utilization of the miscellaneous IRQ thread function during
> timestamp storms near a link reset shows that this prevents the spikes
> caused by the "stuck" ready bit. Without this fix, the CPU handling the IRQ
> becomes slammed due to the IRQ re-triggering logic.
> 
> Measuring latency using the ice Tx timestamp traces does show that this fix
> comes at a latency cost. Latency is measured using the ice Tx timestamp
> traces for the request to completion time. I measured a couple of different
> workloads both before and after this fix:
> 
>  * ptp4l using a profile with ~16 SYNC messages per second
> 
>     before: 159.40 microseconds mean, stdev 45.28
>      after: 182.07 microseconds mean,  stdev 43.43
> 
>  * a C program generating 16 timestamp requests every 10 milliseconds on
>    two different ports:
> 
>     before: 604.35 microseconds mean, stdev 345.32
>      after: 990.13 microseconds mean, stdev 625.64
> 
> In the normal work flows this comes with about a 20 microsecond penalty on
> the average, and the standard deviation remains approximately the same. For
> heavy workloads with many more timestamps than expected for typical
> applications this comes at a significant cost. This is because we handle
> all timestamps in a single thread. If there are many concurrent timestamps
> being requested at once, any which use the later slots on ports later in
> the port list will take much longer to be processed once the interrupt is
> fired. Since each timestamp now requires an additional PHY register access,
> this cost is much higher in the case where the device is under unusually
> heavy load.
> 
> However, *correctness* is more important than speed here. Additionally, we
> still remain well below the default limit of 10 milliseconds that ptp4l
> will wait before complaining about missing timestamps.
> 
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 54 +++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index b337247c94e0..0e44ed6b0ae8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -620,6 +620,22 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)

Sashiko says:

> This is a pre-existing issue, but I noticed something about the tx->in_use
> logic in ice_ptp_process_tx_tstamp().
> At the beginning of the function, there is an early return:
>     if (!tx->init || bitmap_empty(tx->in_use, tx->len))
>         return;
> If a timestamp times out after 2 seconds, the driver frees the SKB and clears
> the slot from tx->in_use. If the hardware subsequently completes the capture
> and sets the ready bit, does this early return prevent the driver from
> clearing that unexpected hardware timestamp ready bit?
> Could this lead to data corruption if a new packet reuses the slot, reads the
> stale timestamp, and clears the ready bit, thereby passing the verification
> checks?

I don't believe we can fix this. If hardware fails to complete a
timestamp within 2 seconds *and then* completes it after two seconds we
end up in a bad state. However, if hardware never completes the
timestamp and we remove our timeout logic then we also end up in a bad
state.

In principle there is no possible "cutoff" we can make that correctly
handles both cases of either a super delayed timestamp or one that
simply never completes.

I believe 2 seconds is a sufficient cutoff to practically ensure we
handle all cases correctly as it should not be reasonable for the PHY to
hold a packet for 2 seconds before transmitting it once enqueued. We
could increase this to a larger time and be more and more certain.
However, if we increase to infinity then indexes can and will become
locked should a packet be enqueued which gets dropped before transmission.


>  		if (err && !drop_ts)
>  			continue;
>  
> +		/* verify ready bit cleared */
> +		if (tx->has_ready_bitmap) {
> +			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> +			if (err)
> +				continue;
> +
> +			if (tstamp_ready & BIT_ULL(phy_idx)) {
> +				spin_lock_irqsave(&tx->lock, flags);
> +				if (!test_and_set_bit(idx, tx->stale))
> +					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
> +						ptp_port->port_num, phy_idx);
> +				spin_unlock_irqrestore(&tx->lock, flags);
> +				continue;
> +			}

Sashiko says:

> If a timestamp request times out (i.e. older than 2 seconds), the driver sets
> drop_ts = true earlier in the loop.
> If ice_get_phy_tx_tstamp_ready() fails and returns an error, this
> unconditionally executes continue. Does this bypass the skip_ts_read
> cleanup block that would normally clear in_use and free the socket buffer?
> Could this result in permanently leaking the SKB, exhausting the Tx tracker
> slots, and unbounded timeout statistic increments?

I think we probably should continue but mark the timestamp as stale just
like we do with checking the ready bitmap. That way we safely handle
that case and avoid storming the IRQ.

Sashiko also says:

> Removing the hardware read error fallback here, combined with the early
> continue on error in ice_ptp_process_tx_tstamp() above, appears to leave
> in_use set without marking the timestamp as stale.
> If the PHY becomes temporarily unreadable during a link down transition, does
> ice_ptp_tx_tstamps_pending() in IRQ context evaluate to true, continuously
> re-arming and triggering the interrupt in an infinite loop?
The IRQ will storm regardless in that case because the in_use is set. If
we mark it as stale that would stop the re-arming of the interrupt.


> +		}
> +
>  		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
>  
>  		/* For PHYs which don't implement a proper timestamp ready
> @@ -2764,10 +2780,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
>  		if (!tx->init)
>  			return false;
>  
> -		if (in_irq)
> +		if (in_irq) {
> +			if (!ice_ptp_is_tx_tracker_up(tx))
> +				return false;
> +
>  			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
> -		else
> +		} else {
>  			return !bitmap_empty(tx->in_use, tx->len);
> +		}
>  	}
>  }
>  
> @@ -2790,41 +2810,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
>  
>  bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
>  {
> -	struct ice_hw *hw = &pf->hw;
> -	int ret;
> -
> -	/* Check software indicator */
>  	switch (pf->ptp.tx_interrupt_mode) {
>  	case ICE_PTP_TX_INTERRUPT_NONE:
>  		return false;
>  	case ICE_PTP_TX_INTERRUPT_SELF:
> -		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
> -			return true;
> -		break;
> +		return ice_port_has_timestamps(&pf->ptp.port.tx, in_irq);
>  	case ICE_PTP_TX_INTERRUPT_ALL:
> -		if (ice_any_port_has_timestamps(pf, in_irq))
> -			return true;
> -		break;
> +		return ice_any_port_has_timestamps(pf, in_irq);
>  	default:
>  		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
>  			  pf->ptp.tx_interrupt_mode);
> -		break;
> -	}
> -
> -	/* Check hardware indicator */
> -	ret = ice_check_phy_tx_tstamp_ready(hw);
> -	if (ret < 0) {
> -		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
> -			ret);
> -		/* Stop triggering IRQs if we're unable to read PHY */
>  		return false;
>  	}
> -
> -	/* ice_check_phy_tx_tstamp_ready() returns 1 if there are timestamps
> -	 * available, 0 if there are no waiting timestamps, and a negative
> -	 * value if there was an error (which we checked for above).
> -	 */
> -	return ret > 0;
>  }
>  
>  /**
> @@ -2915,7 +2912,8 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  	if (!ice_pf_src_tmr_owned(pf))
>  		return;
>  
> -	if (ice_ptp_tx_tstamps_pending(pf, false)) {
> +	if (ice_ptp_tx_tstamps_pending(pf, false) ||
> +	    ice_check_phy_tx_tstamp_ready(hw)) {
>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>  

Sashiko (and Aleks Loktionov!) says:

> The ice_check_phy_tx_tstamp_ready() function can return a negative error
> code on failure.
> By evaluating it directly in this boolean condition without checking if the
> return value is > 0, will a negative error code evaluate to true?
> Could this cause the watchdog to endlessly trigger spurious Tx timestamp
> hardware interrupts whenever the PHY read fails?
I'll fix this in v2.

>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> 

