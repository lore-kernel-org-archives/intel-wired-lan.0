Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2878EB64DA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Jul 2023 18:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DD2A612D6;
	Wed, 12 Jul 2023 18:25:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DD2A612D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689186343;
	bh=Efva04Sf4MO0RHrCDwwIVFkcpEgL9e93da2waBpx4Kk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=27cem2wEpeCCnXXmPFm7jD9G0HBxcD+jHOaec9FJKiXEY056b5Am3Bem83hh3+c2Q
	 yRJDxAZ+V/GIVTLCRI9tNikaMHMwDVvoeusCjSp2lm0/J4rUJnXR4kSZmdFB+DDPjl
	 OPavHtxvzBvJhDRWcRg/gL3iyle88W1BPSGqO2oRRaUpC5O2uF8JfDbdetyMc/Dnnj
	 qiWgLTOsYvYwzLLBH1MQaTcxo1ffwTU1vy3lspPfaNwfBTd4N0f+GmtWPR//NuVVVV
	 KFO1/hZ+5DK6EEtr13oLjoXfrm7Ek/AV76iFxb84JBGzOIxYEa+hXFOkolztsvVO/+
	 VRc6vAVAqKd7Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y0ozswok4QBB; Wed, 12 Jul 2023 18:25:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 630F7612DC;
	Wed, 12 Jul 2023 18:25:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 630F7612DC
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 522A01BF3BA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 18:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35AA5612DB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 18:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35AA5612DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3wsbcm5XE4yv for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Jul 2023 18:25:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5337A612D9
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5337A612D9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jul 2023 18:25:40 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 86E5861874;
 Wed, 12 Jul 2023 18:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6E9C433C8;
 Wed, 12 Jul 2023 18:25:38 +0000 (UTC)
Date: Wed, 12 Jul 2023 21:25:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Message-ID: <20230712182534.GF41919@unreal>
References: <20230712130210.33864-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230712130210.33864-1-jedrzej.jagielski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1689186339;
 bh=ULH/st5gl+19kdRgKh/qaSmVJysjJgl+dLliG1WryAM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gI4QDnNlekKSj5NnXe62Wcz0lQkvl5FhNFbrNTeuhZpZe0aY+Pyu9YdfrNZejDhfn
 s58Awk1FbMXcH9ZvLAKqdNzUpKUAjVD48bshA5aO79S/P8j06QbXU3GCOsysQOQ5pQ
 DJXnGQoSNfi9Z/y1PkO3OY1jiwhBpvoBBG1UQIvkp0JCKUMUVC8CambsBfINY3NkU2
 Q9xClgHkOWa/vADQFAaZJAPNZT1wqsf4QVGottteyxKAXeZMkFZxT9uQ0cKq6162hZ
 VN+NXBVGHrFe7JDEQibKVPeSUviXIs9s2H4zvXvZl5M2bdomsZZuDIZWEg4UIU1qmh
 Erh8Tx1G/42wg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=gI4QDnNl
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] ice: Fix memory management
 in ice_ethtool_fdir.c
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 12, 2023 at 03:02:10PM +0200, Jedrzej Jagielski wrote:
> Fix ethtool FDIR logic to not use memory after its release.
> In the ice_ethtool_fdir.c file there are 2 spots where code can
> refer to pointers which may be missing.
> 
> In the ice_cfg_fdir_xtrct_seq() function seg may be freed but
> even then may be still used by memcpy(&tun_seg[1], seg, sizeof(*seg)).
> 
> In the ice_add_fdir_ethtool() function struct ice_fdir_fltr *input
> may first fail to be added via ice_fdir_update_list_entry() but then
> may be deleted by ice_fdir_update_list_entry.
> 
> Terminate in both cases when the returned value of the previous
> operation is other than 0, free memory and don't use it anymore.
> 
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2208423
> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: extend CC list, fix freeing memory before return
> v3: correct typos in the commit msg
> v4: restore devm() approach
> v5: minor changes
> ---
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
