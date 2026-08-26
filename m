Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3755EC61DBD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 14:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB420809C4;
	Wed, 26 Aug 2026 14:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oaCHEjH7cJw8; Wed, 26 Aug 2026 14:37:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787755060;
	bh=GJJjeH1fCAde4avsp6BZ4U9/7WGHxznHmW/jtpmPsiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSgjlLTcj0o28ggXT+X/G5/xdk84xLdLt/2iOwccuvREgOEQROZq9VdZq+AVsojE7
	 b7YYLLqV3M/gd3qAlwg+XTInZoQER27B+QC8p0qGGwDkgmIlPvPeV4wLTVWqWLRsC9
	 ar8IclYCUrh5DTp4RbKxPjvjllhsMHe9Vc/qLd7ZDv2YG7PGXuViiRI4sjCnvGC8nR
	 upYg/at+ksRk5UhncDU9sZo7/t/UsbJKIRTFy8+pRQzR9rxTIORJarMRtb/19JbHMD
	 oMb/+naz/xULzwQPBrOcgP6BGdrzb/LQAMNEwRbIz2BpBUId2rgIpBnlHZAaza7yOR
	 fu2041ecEdxLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2A8380992;
	Wed, 26 Aug 2026 14:37:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 22158396
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 14:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FC3940115
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 14:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AQvAH3D29-hF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 14:37:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mO/XzlLP
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05F3B40064
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787755058; x=1819291058;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TC0OkRhjUUdFeNQ+mtm8uAHBZtV7OvjOvchH+vTv8fM=;
 b=mO/XzlLPycTONmXFBe+kZukxW+oSJ9XtqOXyWe+Z8K2HkiTTbB0UH8gB
 vjz/fse73u8TfXvBTqm8NREfhU16pcIr8u2k4Msb/LyHUzMw/gXTPmZ63
 IsViFN1jn86EAEtS8ti2UuUvcp/BtjZz8J9dxS30x1mZ9XGChMnZ6gEUO
 FEY1b/HlXqHzxFr4ya5nOg0y2/0w5s3sPC2ZI7o7oeCHiogEb+gzJotaO
 Vw6rmo5me+v6ZMZeRoSeI6PONfbsR3oUr1+YNlgKPTS8slNoJbSQWEDt8
 8MZcbJnhQCiknpWqW6mTT5IcH1QTASUXO67gysMIQhK4088UOSutdnrR6 g==;
X-CSE-ConnectionGUID: 0KcudeRWQS+YajZh6GOX0g==
X-CSE-MsgGUID: 7Jt33n0yTlm46I9dH8TuKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99398627"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="99398627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 07:37:37 -0700
X-CSE-ConnectionGUID: w4u+Dbg+Si+4jd/oNNqvmg==
X-CSE-MsgGUID: PR2O1Gc8TeC4k/eU3TvEJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="291117041"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 07:37:36 -0700
Received: from [10.102.88.131] (soc-5CG4396XFD.clients.intel.com
 [10.102.88.131])
 by linux.intel.com (Postfix) with ESMTP id 6F5D020BF394;
 Wed, 26 Aug 2026 07:37:35 -0700 (PDT)
Message-ID: <b164ae67-2874-43ed-aa32-66ca42ae90cc@linux.intel.com>
Date: Wed, 26 Aug 2026 16:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v4] ixgbevf: fix link speed reporting for Hyper-V
 E610 VFs
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>
References: <20260824110834.2364407-1-tomasz.lichwala@linux.intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260824110834.2364407-1-tomasz.lichwala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This email covers the Sashiko review for this patch.

On 24.08.2026 13:08, Tomasz Lichwala wrote:
> When an E610 VF is running under Hyper-V, the VFLINKS register does not
> carry valid link speed. The existing code reads speed from VFLINKS, which
> does not reflect the actual negotiated speed. This results in ethtool
> reporting a stale or incorrect link speed.
> 
> The Hyper-V synthetic NIC exposes the actual link status through
> emulated PCI config space at offset 0x209 in VFLINKS register format.
> Read and decode link status from there when checking link on E610 VFs.
> 
> To avoid generating unnecessary VMBus transactions on every watchdog
> cycle, read the PCI config register on demand when ethtool or sysfs
> queries link speed, rather than polling it periodically. The cached
> value is used by the watchdog and link state notifications as before.
> 
> Guard the PCI config space read with IS_ENABLED(CONFIG_PCI_MMCONFIG),
> since accessing offsets above 256 requires MMCONFIG support.
> 
> Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
> ---
> v4:
>  - Read link speed on demand from ethtool/sysfs query instead of polling
>    every watchdog cycle to avoid unnecessary VMBus transactions (ethtool.c)
>  - Restore get_link_status caching for E610 VFs in check_link
>  - Add IS_ENABLED(CONFIG_PCI_MMCONFIG) guard for PCI config reads above
>    offset 256
>  - Add CC netdev@vger.kernel.org
> v3:
>  - Remove #if IS_ENABLED(CONFIG_PCI_MMCONFIG) preprocessor guard
>  - Replace goto decode label with if/else control flow
>  - Move get_link_status check into else branch (non-E610 path only)
>  - Expand commit message with problem description
> v2:
>  - Simplify error path: return 0 with link_up=false instead of
>    propagating PCI read error code
>  - Fix alignment in macro definitions
>  - Update comment describing Hyper-V PCI config offsets
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c | 12 ++++
>  drivers/net/ethernet/intel/ixgbevf/vf.c      | 68 +++++++++++++++++---
>  2 files changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> index 537a60d5276f..2463fccffd4d 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> @@ -83,6 +83,18 @@ static int ixgbevf_get_link_ksettings(struct net_device *netdev,
>  				      struct ethtool_link_ksettings *cmd)
>  {
>  	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
> +	struct ixgbe_hw *hw = &adapter->hw;
> +
> +	/* E610 Hyper-V VFs: read current link speed from PCI config space
> +	 * on every link speed query.
> +	 */
> +	if (hw->mac.type == ixgbe_mac_e610_vf) {

The mac type check matches both Hyper-V and bare-metal E610 VFs. On bare-metal, forcing get_link_status=true and calling ixgbevf_check_mac_link_vf() would indeed corrupt the link state — the CTS mailbox read fails (no pending CTS), causing a false link-down report.

Fixed in v5 by checking the subsystem device ID (IXGBE_SUBDEV_ID_E610_VF_HV) instead of the mac type.  This is the same identifier used in the PCI ID table to select Hyper-V mac_ops during probe, so the on-demand read now only triggers for Hyper-V VFs where hw->mac.ops.check_link points to ixgbevf_hv_check_mac_link_vf().

> +		spin_lock_bh(&adapter->mbx_lock);
> +		hw->mac.get_link_status = true;
> +		hw->mac.ops.check_link(hw, &adapter->link_speed,
> +				       &adapter->link_up, false);

This is not a race introduced by this patch. The watchdog's pattern of caching adapter->link_speed into a local variable before taking mbx_lock is pre-existing for all Hyper-V VF types. The ethtool response is always correct because it reads adapter->link_speed immediately after check_link returns within the same function call. The mbx_lock serializes concurrent check_link calls - ethtool and watchdog cannot execute check_link simultaneously.

> +		spin_unlock_bh(&adapter->mbx_lock);
> +	}
>  
>  	ethtool_link_ksettings_zero_link_mode(cmd, supported);
>  	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
> index f6df86d124b9..a84b62641e9b 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
> @@ -1,14 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 1999 - 2024 Intel Corporation. */
>  
> +#include <linux/unaligned.h>
> +
>  #include "vf.h"
>  #include "ixgbevf.h"
>  
> -/* On Hyper-V, to reset, we need to read from this offset
> - * from the PCI config space. This is the mechanism used on
> - * Hyper-V to support PF/VF communication.
> +/* On Hyper-V the PF/VF communication is through emulated PCI config
> + * space. The reset and link status are exposed at the offsets below.
>   */
> -#define IXGBE_HV_RESET_OFFSET           0x201
> +#define IXGBE_HV_RESET_OFFSET		0x201
> +#define IXGBE_HV_LINK_STATUS_OFFSET	0x209
> +#define IXGBE_HV_LINK_STATUS_SIZE	4
>  
>  static inline s32 ixgbevf_write_msg_read_ack(struct ixgbe_hw *hw, u32 *msg,
>  					     u32 *retmsg, u16 size)
> @@ -901,6 +904,40 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>  	return ret_val;
>  }
>  
> +/**
> + * ixgbevf_hv_read_links_e610 - read link status from PCI config space
> + * @hw: pointer to hardware structure
> + * @links_reg: pointer to store read value
> + *
> + * On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
> + * Instead, link status is exposed through emulated PCI config space at offset
> + * 0x209 in VFLINKS register format.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
> +{
> +	struct ixgbevf_adapter *adapter = hw->back;
> +	u8 data[IXGBE_HV_LINK_STATUS_SIZE];
> +
> +	if (!IS_ENABLED(CONFIG_PCI_MMCONFIG)) {


The IS_ENABLED(CONFIG_PCI_MMCONFIG) guard is intentionally kept for consistency with  xgbevf_hv_reset_hw_vf(), which uses the same pattern to access emulated PCI config space at offset  x201. Both functions read from extended config space offsets (>256) that require MMCONFIG on x86. In practice, Hyper-V E610 VFs are only deployed on x86 hosts where CONFIG_PCI_MMCONFIG is always enabled. If ARM64 Hyper-V support becomes relevant, both functions would need to be updated together.

> +		dev_err_once(&adapter->pdev->dev,
> +			     "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
> +		int ret = pci_read_config_byte(adapter->pdev,
> +					       IXGBE_HV_LINK_STATUS_OFFSET + i,
> +					       &data[i]);
> +		if (ret)
> +			return pcibios_err_to_errno(ret);
> +	}
> +
> +	*links_reg = get_unaligned_le32(data);
> +	return 0;
> +}
> +
>  /**
>   * ixgbevf_hv_check_mac_link_vf - check link
>   * @hw: pointer to private hardware struct
> @@ -909,6 +946,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>   * @autoneg_wait_to_complete: unused
>   *
>   * Hyper-V variant; there is no mailbox communication.
> + * For E610 VFs, link status is read from emulated PCI config space.
>   */
>  static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>  					ixgbe_link_speed *speed,
> @@ -926,8 +964,16 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>  	if (!mac->get_link_status)
>  		goto out;
>  
> -	/* if link status is down no point in checking to see if pf is up */
> -	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
> +	if (mac->type == ixgbe_mac_e610_vf) {
> +		if (ixgbevf_hv_read_links_e610(hw, &links_reg)) {
> +			*link_up = false;
> +			*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +			return 0;
> +		}
> +	} else {
> +		links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
> +	}
> +
>  	if (!(links_reg & IXGBE_LINKS_UP))
>  		goto out;
>  
> @@ -941,8 +987,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>  			udelay(100);
>  			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
>  
> -			if (!(links_reg & IXGBE_LINKS_UP))
> -				goto out;
> +			if (!(links_reg & IXGBE_LINKS_UP)) {
> +				*link_up = false;
> +				*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +				return 0;
> +			}
>  		}
>  	}
>  
> @@ -956,6 +1005,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>  	case IXGBE_LINKS_SPEED_100_82599:
>  		*speed = IXGBE_LINK_SPEED_100_FULL;
>  		break;
> +	default:
> +		*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +		break;
>  	}
>  
>  	/* if we passed all the tests above then the link is up and we no

