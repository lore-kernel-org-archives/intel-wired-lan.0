Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7FBC55184
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 16:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AFCE4060E;
	Tue,  4 Aug 2026 16:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XYM0vQsKMFtD; Tue,  4 Aug 2026 16:05:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD9BE40611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785859512;
	bh=F9+e6trDnS5dzVVgfLPEalTMb10U0a6DgjtMxIqEZcI=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=168jjH5jvm1Ur/fhxjHMjjzhq4GcD6vl2CMdMwg6sAwqZgkg/xRknETYUgNESJgar
	 fhuvXCBnfp93uxz1BnkYDbFXnx+M6WD95mCMy901+IYGC5A0FuvnCkpRToqBhsGHW2
	 Xi2011JN/GcFOuwQaCqmazWK1weVH4zslM+Zq1vz8CYRExXF9MyS5zcnCbHpndEVU0
	 M3DMMzk1XJJFoS3/ODkS5xeK8u9xJMOjKvspVRJUrsGy12+RPmdGMkN5FGD3WS/W4o
	 e6nNOqiz43cvnuKMjFA9hdKrw0Rx45XGwY3P2yLzS57ULBXHMe/D9QjN/HclvrpHvm
	 YZVJuB+atKsJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD9BE40611;
	Tue,  4 Aug 2026 16:05:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD2FD2AA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 16:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93BE180B59
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 16:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPxbfTpNM_Vs for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 16:05:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5EE2180B42
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EE2180B42
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EE2180B42
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 16:05:09 +0000 (UTC)
X-CSE-ConnectionGUID: I2Ngy/24SfG0pfcoWhPLFA==
X-CSE-MsgGUID: u+QTXcOCTNWaB7yoUki8sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="103955493"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="103955493"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 09:05:03 -0700
X-CSE-ConnectionGUID: 6OWvW/zEQlamFuZ/OHC/ow==
X-CSE-MsgGUID: qmjsC0YGS3aGztoeLNJPPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="255252961"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.94.248.216])
 ([10.94.248.216])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 09:04:59 -0700
Message-ID: <0e4bdc1a-48ce-4860-a0f0-201bebf6d716@linux.intel.com>
Date: Tue, 4 Aug 2026 18:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Robert Malz <robert.malz@canonical.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260804083537.3997889-1-robert.malz@canonical.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260804083537.3997889-1-robert.malz@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785859510; x=1817395510;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ayczpbs10IRaGQSyxSkR7xRoVkbToh4EoscVg0eS5dk=;
 b=YBaW9rtVvdyHBId2Mo/qnt4eQTOfBibPFj2gyA/h+Treb6ekPfN07UoH
 fgNcUWTxhNcZSADzPS9DLQS8dvj7BXz/wYGLBEe6I4TJ0g7Am+RILGVdb
 mhvdiHZKe9R0YiMs3ACNN2VMQXPIWHyBla+NcgzDEOTrs7Cvftg7Kx5IV
 jZfVeODQDcGEWdFI6XJHC+owrmi+OpHQRsRbzwFs2SlXydjJIkc1X+lf8
 muYtXkTGVEljVExu4bMMvPHrCH97F+qdn47IezUazPrzBiRL7fHFt5D36
 eKjs9ACGjkKqcPWmhuK5br2XFI9Nu0W+EWZb5y3AK7CXvWB6BwVQYLy/z
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YBaW9rtV
Subject: Re: [Intel-wired-lan] [PATCH iwl v4] ice: acquire NVM lock around
 each flash read
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



On 04.08.2026 10:35, Robert Malz via Intel-wired-lan wrote:
> FW caps the NVM read lock at a maximum of 3000ms regardless of the timeout
> requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
> multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued under a
> single lock taken by the caller. Reading a large region can exceed 3000ms,
> so FW reclaims the lock mid-read and the remaining commands might fail.
> 
> Move the lock acquire/release into ice_read_flat_nvm() so it brackets each
> individual ice_aq_read_nvm() command, ensuring the lock is never held
> across more than one FW read.
> 
> ice_release_nvm() issues its own AQ command and overwrites
> hw->adminq.sq_last_status, which some callers inspect after a failed read.
> Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> capture the failing read's AQ error before the release; callers that need
> it (ice_discover_flash_size() and the ethtool/devlink log paths) use it
> instead of sq_last_status, others pass NULL.
> 
> Callers that previously took the lock around ice_read_flat_nvm(),
> ice_read_sr_word() or ice_read_flash_module() now call them without it.
> The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> dropped. ice_read_sr_word() is now a thin wrapper, so ice_read_sr_word_aq()
> is folded into it.
> 
> Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

---8<---
