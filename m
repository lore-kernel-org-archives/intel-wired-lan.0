Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD27C98332
	for <intel-wired-lan@archiver.kernel.org>; Sat, 26 Sep 2026 11:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ADAE606DC;
	Sat, 26 Sep 2026 11:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4Ijh5czq09R; Sat, 26 Sep 2026 11:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 91544606BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790420950;
	b=poTIqHLUoOpCVYllNRNcdz6dKtjJJnzvk/p/E8Yvtt+TEv/O6kv4q8nHGCuluySFS2j+
	 5du6tx7du5w3K27ZdNbQabD+XTOYYsXISVcBrtosc437q9nnKIEIl39U00XD15G4kY6Hk
	 Jn7uP2Zsdbtnj9Aq7vMQg49YSIurtQsaJINSojsDOtOZDiCh54T27nDmS3bg3t8GF1X7+
	 91bhLKsAKzDJRPRki+Y6lBHGV9OwfU4AInA66esJhWQXWhW13mdPY0kT6TejeMwUPoHTd
	 USNhsHBudmke6d/RMTAWA1CfVJZiyCEylTmxQ//GhA0/G0g05q54TS7NJ3lGTGmrAdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790420950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JZCKIiUuWdFfiQZaEQ2obKO6eFfq4tY+023ERwT5FlU=;
	b=TUWhqEzgTLTqh+WrD/4zGIotvpd3fG1kLUgNw7+fayaa7iZ8hAP0u4CNdiegIjQ6AZm4
	 sJSNFAMLvnJPsyL4exdGLs277K9CYEuSk3kZ+bWhUP988Wp+JeiQLduPs5k/RhmGuKxRn
	 lwf4L/io+e+RduFwHRZJAkkKcnNNNBIFdNBUuUDmkCLBYX2gUr9xahccVvWR+NEXEVi/U
	 3yBwPfx4y6TIZQOI3VtIoIitEZBsfa/pHUexEDXhgO3PGR/pO1KVaC8BaH520UQ0M8azw
	 a2vBXl8WgM4lmDDV4XDqOWksJoeEZc84I4SEDRslbThjHQWzHeAA07OvJq0iax3sPdA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790420950;
	bh=JZCKIiUuWdFfiQZaEQ2obKO6eFfq4tY+023ERwT5FlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q/G4ZG5yMko9TuMTqNVu/iTTFqM6Gx2xZbwIEmvM9329sHG1gAjqWAavlkEVWtIab
	 BcsodHhFjgIANKJrhPYNVEeINy3o75b931rE4Tp4c5RflBvMuQHhcRatvsTKf3UYQg
	 JlnweSTtapquiVnK8RNzKLxHUkUj9oJ6YtsG16HbcJJpxwvBLrf8JtHUxuywQvbdeo
	 gjvX+P64oJsXwQYdDsbnb5GpBq8KEh70NP5J15DaTY48NSK5imwjtcLBDVVgwm5MKU
	 oDzW9eb4trmzVR1YIpWd62wqKMvujQ0I5+b9K7jVhGNYPr/vMYMHMZxoc6sFSj5fFJ
	 7fzk+E3ZbNfPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91544606BD;
	Sat, 26 Sep 2026 11:09:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D07A194
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E63C681184
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jEfywo6bprFD for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 11:09:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B934581166
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790420948;
 b=Uw8BafV+A55UeuoE6einval8NZvNusRgPMlwOOBrAXax2JD8N3WAcS0UCswkg6ESALzz
 2wab2Afr+7QFUZlMLtlR6550CD/KT44YlWndBtn8Qp/9kPTBY5W9mwpr0vPdI9hjw7MsC
 H9JuNUDVzxwJfAppKqGHcx23wW0bRjicGRrbGctn25bUd34/GcljPoQHG3NLpA41xyRNk
 u/ibbJNbeQvORNy5xn0LnO5bpkPattcXmyuCngJBkj3n+/DZGrHah/fHzSz8feuVPZhdo
 IWXVXJskw6ipBzOYaDfOtdcc/ugDPf817YaXrSvBu3BU+rIyc3I7CH7D9PenR8dPrlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790420948;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=JZCKIiUuWdFfiQZaEQ2obKO6eFfq4tY+023ERwT5FlU=;
 b=hngKU6AlSlE+vkPpJ82UfFsXhwBFwyZX7jtHtZFE5Mxu3o1T9s4HHoI7YIozJs/fTrW0
 cL87GGI5sduoCzI+dnbIemm4iI4dBZ//Bb6F7BLAFUVqhxJq5tJGMBJ3gHG4MUOLROwvZ
 965TXYByD/yP+Tk2/Klr01jlJ1L8YZrS2IbSPlIImRU3W0S4ooauWtfnHg9DimdfbgYXX
 JeZcXkugsknK67D5A+ycReCTvbUrclclEouXWhV2l+9BOT/hWtQMEUXdVMtFdRuwtVGw0
 5Rt0dtpOcdsYwmbmBYljl9jHhcWIyc5pM40P8WXDl+vuC97V1pfPbkKGlk/kuObySOw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Smr9P4hm; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Smr9P4hm
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B934581166
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790420948; x=1821956948;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DKiUHwOK/x73XxFXAzjap/JskM7x2k2D+Zd1wUoYq4Y=;
 b=Smr9P4hmM6kRcSLhFBjzoY38EsaN3+ASbrR/KQsOEcmC6CTgpD6M8QVB
 t4JaRV/SE/9ln/uQXTR8AejjxShopXq0nm+aalCbCKo+fJK7XGp+Gw/+G
 36jYiDV8nOO9BfubiyipMpOi3D1i+VTOSUJKrPU8ZjPc2d/oMwg7AcEb7
 dOlqjAX257XKk2Il2v0w7pIi8cInSNeHlHJkjko4WbM3yocDF/vre2dtC
 +RDqKnnyXbRI9wgrTKcxeaQhcFG7nbieTmSn6MFLYpTddmlXzgfoi3oye
 1MZCxtHytXVxaFv4pYZ3CozVFD0lBGsZViV9RfC3lwjT1GgxXmhIa/Tq2 Q==;
X-CSE-ConnectionGUID: eOFm2bYqTmKzQ4m+98Rczg==
X-CSE-MsgGUID: 2HJTkWs+Se2h7thsamg/Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="107570104"
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; d="scan'208";a="107570104"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2026 04:09:07 -0700
X-CSE-ConnectionGUID: JkIKC/OmQoms6DP43x8YKQ==
X-CSE-MsgGUID: EhbnnXAWQReuHjusOFEfSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; d="scan'208";a="302499075"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 26 Sep 2026 04:09:02 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xAQH5-00000000Ljh-3rNY;
 Sat, 26 Sep 2026 11:08:59 +0000
Date: Sat, 26 Sep 2026 19:08:25 +0800
From: kernel test robot <lkp@intel.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
 aleksandr.loktionov@intel.com, horms@kernel.org,
 grzegorz.nitka@intel.com, vgrinber@redhat.com, zoltan.fodor@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: Re: [iwl-next v15] ice: add support for unmanaged DPLL on E830 NIC
Message-ID: <202609261833.lptlCpVW-lkp@intel.com>
References: <20260922132946.3241002-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922132946.3241002-1-arkadiusz.kubalewski@intel.com>
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

Hi Arkadiusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1562ff70880100d14a32b6b68eef044f1a334df1]

url:    https://github.com/intel-lab-lkp/linux/commits/Arkadiusz-Kubalewski/ice-add-support-for-unmanaged-DPLL-on-E830-NIC/20260922-152945
base:   1562ff70880100d14a32b6b68eef044f1a334df1
patch link:    https://lore.kernel.org/r/20260922132946.3241002-1-arkadiusz.kubalewski%40intel.com
patch subject: [iwl-next v15] ice: add support for unmanaged DPLL on E830 NIC
config: x86_64-randconfig-1014-20260926 (https://download.01.org/0day-ci/archive/20260926/202609261833.lptlCpVW-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260926/202609261833.lptlCpVW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609261833.lptlCpVW-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/net/ethernet/intel/ice/ice.ko: symbol 'ice_cgu_get_num_pins' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
