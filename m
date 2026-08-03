Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D75C55175
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 10:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8994B80994;
	Mon,  3 Aug 2026 10:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utcxXISb8KSH; Mon,  3 Aug 2026 10:05:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74A3080C7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785751526;
	bh=/gLI2r/8rG5B5WpQpSPdr1tHhab1yUbjiwP7lX1ro2M=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tjHhPxqG1mjqG+4mKNzF5ief/aVqAnZXwegvUCwvu1rmZkoz6qJCY2wuMaakdYH5e
	 vfIQwksNy6TIEGT7Vo+DZhj8lvHgno2LUHVINRAFsLVRm31xT8qs7FO2HBdELAHWq9
	 lWjtRw2oCN85N22QtCGRZn8l8LJZNPk4c8B63b3PjcQWu4ojIvwNfvf63ytvUADmLB
	 JlTn0bkIHyRwEJPdOJIfs2A3TZO2UtFZrdnu67wjI8F8nACY2mRpK3WJ8hkvlYAmmN
	 eLcYhOZHWR31kJxeVAuLQMwzoTmB6mvduSrwva3uYyBduC8VNIhxle8M+zqVxN/FDt
	 0lvpX4oSi63VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74A3080C7B;
	Mon,  3 Aug 2026 10:05:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0988B36E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 10:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 070F080C7B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 10:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EaUmbvpUXyjv for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 10:05:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1DA5880C45
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DA5880C45
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DA5880C45
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 10:05:22 +0000 (UTC)
X-CSE-ConnectionGUID: 2z4UJtiZR1aSvPERc534nQ==
X-CSE-MsgGUID: fkOk6QLMSuOPzIexfNji7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="103684279"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="103684279"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 03:05:22 -0700
X-CSE-ConnectionGUID: gXCx4fPeR6SQAAJBmo+avA==
X-CSE-MsgGUID: zFixKgjkQnWDHIypS/VPUg==
X-ExtLoop1: 1
Received: from unknown (HELO [10.217.160.239]) ([10.217.160.239])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 03:05:19 -0700
Message-ID: <2e3101ea-13ab-4c9a-913c-999eb15207be@linux.intel.com>
Date: Mon, 3 Aug 2026 12:05:17 +0200
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
References: <20260731111008.1266444-1-robert.malz@canonical.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260731111008.1266444-1-robert.malz@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785751524; x=1817287524;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XAo4DAYZzBUe3nOpgZa+4cRRLUuo1rQA/pZfXkcJujs=;
 b=CeO/pBWYFfa+X2ZN5vPvH+uP79aP8AnJGPFr8wv56bjmqRymYuPh2mjy
 AQy3fqrRqhA53xVb/d+8UX+AQaIZ9LqOgpndmBV3w+kocdy/JXeCLrawv
 tfEfBiyO6g4J6WMk4olL8g1QSilWuePQeDzORWZDNR36ndAB9MLUfR+Rd
 0XImVWNkf50B59/+FvnaLV+qmeKSdTTFNf44vPyeCkLDmCnQr+iX1BLfK
 lNiPfX7DFA9t0eLzvSV0AOcGZilIr8HKxfwCxVTK/8+fdI5qheLWChYpu
 kXQaiEZt2Yelg+2oiXrIqHB4ylFTNkaBUK/yxtPiW8Y5z+OpTuyVKnLM0
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CeO/pBWY
Subject: Re: [Intel-wired-lan] [PATCH iwl v3] ice: acquire NVM lock around
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



On 31/07/2026 13:10, Robert Malz via Intel-wired-lan wrote:
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
> dropped.
> 
> Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> ---
> v3:
> - Log the failure via ice_debug() when ice_acquire_nvm() fails inside
>   ice_read_flat_nvm(), rather than silently aborting the read.
> v2:
> - Replace the save/restore of sq_last_status across ice_release_nvm(),
>   which could race with a concurrent AdminQ command, with a new optional
>   read_aq_err output parameter.
> - Add missing "Return:" kdoc to ice_read_sr_word().
> ---
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
>  drivers/net/ethernet/intel/ice/ice_nvm.c      | 79 +++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
>  4 files changed, 59 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 22b7d8e6bd9e..5a1ab9654fb8 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
>  {
>  	struct ice_pf *pf = devlink_priv(devlink);
>  	struct device *dev = ice_pf_to_dev(pf);
> +	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;

RCT
Also scope can be reduced.

>  	struct ice_hw *hw = &pf->hw;
>  	bool read_shadow_ram;
>  	u8 *nvm_data, *tmp, i;
> @@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
>  	for (i = 0; i < num_blks; i++) {
>  		u32 read_sz = min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, left);
>  
> -		status = ice_acquire_nvm(hw, ICE_RES_READ);
> -		if (status) {
> -			dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
> -				status, hw->adminq.sq_last_status);
> -			NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
> -			vfree(nvm_data);
> -			return -EIO;
> -		}
> -
>  		status = ice_read_flat_nvm(hw, i * ICE_DEVLINK_READ_BLK_SIZE,
> -					   &read_sz, tmp, read_shadow_ram);
> +					   &read_sz, tmp, read_shadow_ram,
> +					   &read_aq_err);
>  		if (status) {
>  			dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
> -				read_sz, status, hw->adminq.sq_last_status);
> +				read_sz, status, read_aq_err);
>  			NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
> -			ice_release_nvm(hw);
>  			vfree(nvm_data);
>  			return -EIO;
>  		}
> -		ice_release_nvm(hw);
>  
>  		tmp += read_sz;
>  		left -= read_sz;
> @@ -1945,6 +1936,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
>  {
>  	struct ice_pf *pf = devlink_priv(devlink);
>  	struct device *dev = ice_pf_to_dev(pf);
> +	enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;

RCT

>  	struct ice_hw *hw = &pf->hw;
>  	bool read_shadow_ram;
>  	u64 nvm_size;

...

>  /**
> - * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessary
> + * ice_read_sr_word - Reads Shadow RAM word
>   * @hw: pointer to the HW structure
>   * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
>   * @data: word read from the Shadow RAM
>   *
> - * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_word_aq.
> + * Reads one 16 bit word from the Shadow RAM using ice_read_sr_word_aq.
> + *
> + * The NVM lock is acquired and released internally by ice_read_flat_nvm()
> + * around the FW read, so this function must be called without the lock held.
> + *
> + * Return: zero on success, or a negative error code on failure.
>   */
>  int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
>  {
> -	int status;
> -
> -	status = ice_acquire_nvm(hw, ICE_RES_READ);
> -	if (!status) {
> -		status = ice_read_sr_word_aq(hw, offset, data);
> -		ice_release_nvm(hw);
> -	}
> -
> -	return status;
> +	return ice_read_sr_word_aq(hw, offset, data);

ice_read_sr_word() is now a wrapper - can we remove it and use
ice_read_sr_word_aq() directly?

>  }
>  
>  /**
> @@ -856,20 +876,18 @@ int ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *net
>  static int ice_discover_flash_size(struct ice_hw *hw)
>  {
>  	u32 min_size = 0, max_size = ICE_AQC_NVM_MAX_OFFSET + 1;
> -	int status;
> -
> -	status = ice_acquire_nvm(hw, ICE_RES_READ);
> -	if (status)
> -		return status;
> +	int status = 0;
>  
>  	while ((max_size - min_size) > 1) {
>  		u32 offset = (max_size + min_size) / 2;
> +		enum libie_aq_err read_aq_err = LIBIE_AQ_RC_OK;

RCT

>  		u32 len = 1;
>  		u8 data;

---8<---

Thanks,
Marcin
