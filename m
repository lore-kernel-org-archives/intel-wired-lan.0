Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDC610ED656
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 10:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE59D83D17;
	Fri, 27 Mar 2026 10:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EzHKRHf4x21x; Fri, 27 Mar 2026 10:47:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9616C83D0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774608461;
	bh=jMdsUqHfgnsQkhI2OvQD6m9n3OTU7yZcRoiz6/Uc3Aw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZekP/kqk5cwgqNkXQ3JOShE0kN0dsmX+DYHKSf40Hsg2H3NKk8Je0xY4TYggZT0Xg
	 f7f+TQlnWCwa+bb/5ooy0fziMolM1pK5gfRDRD+YPrX5Dfpyc7djCfbrauMtig2XkL
	 02sNMSaNF8eCqYxPD5LkXpAQMJhU2XLbCNOQ+FiQESk07ODCgMakdCM6ix4j6yqPbS
	 afG1NID1dEG5MilX/Uh9IDS3cNtfcIajarsAKj+91Fa1jmFbuJzgH0f02Jk27Tnrla
	 iA6uy2cqJGDfh5MzPUDQIrgXqm+fvjvbUpRnr/kOowDHrEP8e0ZzGauMwfzif3ky2N
	 dQPRf4AoBasIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9616C83D0E;
	Fri, 27 Mar 2026 10:47:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 815FD2D5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 10:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F0826128B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 10:47:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5k_BRgFyYX8G for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 10:47:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ADD7D6128F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADD7D6128F
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADD7D6128F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 10:47:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 81E516132B;
 Fri, 27 Mar 2026 10:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D73C19423;
 Fri, 27 Mar 2026 10:47:34 +0000 (UTC)
Date: Fri, 27 Mar 2026 10:47:32 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <20260327104732.GB567789@horms.kernel.org>
References: <20260324153542.674859-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324153542.674859-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774608456;
 bh=r8OjbGRJ6dRl5LnFR7ool+5ejKgvKJDtEWK8kYX9IKY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i1e2SwED2RVc9xwPFJddwd7l0aG9w8ww3zAFuC3hxAl4vGwrPcmOsoV3toopAjA/7
 E+5SR/x1Bi6ptb/m1EaVXNwOyXx/mtnR3SyJnwAfxbmpV7GOB/RUqXZOZJskYAwM8o
 bebwwg7A737E4jpYTVzge/4LqV+/e4A9dphKhsQYrGb6U2U7cWMQCVoDIimlkS89Om
 2LTv4rKhkiNHQ9ZHpWVI/KkVAMjojTBwkwEKIqr51YbNYw6CoHqwyOWnPyBBKJfhQ4
 M8ILvVKuT++cygF5tgUmzP9rcHIwFCIRKwnKThBayO+LJG8qLo00FUi2PchnBrGlw7
 pYBAR1dQQZ+CA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=i1e2SwED
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ice: add 200G_AUI8 PHY
 type definitions and wire them up
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

On Tue, Mar 24, 2026 at 04:35:42PM +0100, Aleksandr Loktionov wrote:
> ice_link_mode_str_high[] lacks entries for phy_type_high bits 5-14
> (all 200G PHY types on E825C); ice_dump_phy_type() prints nothing for
> them when ICE_DBG_LINK is set (e.g. 'ethtool -s ethX msglvl 0x10').
> The loop also iterates all 64 bits against a 5-entry array - undefined
> behaviour for any matched bit beyond the end.  Add strings for bits
> 5-14 and guard the loop with ARRAY_SIZE(), falling back to "unknown"
> for unrecognised bits.
> 
> ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC (bit 13) and 200G_AUI8 (bit 14)
> were absent from ice_adminq_cmd.h; ICE_PHY_TYPE_HIGH_MAX_INDEX capped
> at 12 caused ice_update_phy_type() to skip them entirely, leaving both
> invisible to 200G speed requests.  Add the definitions and bump
> MAX_INDEX to 14.
> 
> Wire the two new types throughout the driver:
> - ice_get_media_type(): handle all ten 200G phy_type_high values so
>   E825C ports no longer return ICE_MEDIA_UNKNOWN.  AOC_ACC interfaces
>   map to FIBER; bare AUI4/AUI8 to DA with cage, else BACKPLANE
>   (matching existing AUI2/CAUI2 logic); CR4_PAM4 to DA; SR4/FR4/LR4/
>   DR4 to FIBER; KR4_PAM4 to BACKPLANE.
> - ice_get_link_speed_based_on_phy_type(): return ICE_AQ_LINK_SPEED_200GB
>   for both new types so ice_update_phy_type() enables them correctly.
> - phy_type_high_lkup[13,14]: AUI8 is 8-lane 25G-per-lane; no
>   200000baseSR8/CR8 ethtool modes exist yet, so approximate with
>   SR4_Full/CR4_Full - matching AUI4 at indices 11-12.  FIXME once
>   those link modes land upstream.
> - ICE_PHY_TYPE_HIGH_MASK_200G: add bits 13-14 for the minimum-speed
>   floor in ice_mask_min_supported_speeds().
> 
> Suggested-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v3 -> v4: add ARRAY_SIZE() OOB guard in ice_dump_phy_type(); cover all
>           ten 200G phy_type_high values in ice_get_media_type(); add FIXME
>           to lkup[13..14] for missing SR8/CR8 modes; rename subject
>           fix subject; fix debug enable example (ethtool, not modprobe);
>           add AUI8 speed mapping, lkup[13-14], MASK_200G bits 13-14,
>           and AUI8->SR4/CR4 approximation comment
> v1 -> v2: add ICE_PHY_TYPE_HIGH_MAX_INDEX update

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

