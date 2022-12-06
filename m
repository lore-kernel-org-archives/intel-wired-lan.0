Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486B7C63703
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Dec 2022 09:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D797B409AD;
	Tue,  6 Dec 2022 09:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D797B409AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670320271;
	bh=7X1C5ZNqtm5dOcaQZeBAkyODMwrAlUH/C3WS6Z9Wvj4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=sgc0B1f0ULGOtl+ZvKkOLvD4zv9Ks8uGII3MxN5IOyHpzdNe44Tz27f5PbsX+I8Jm
	 ySEjF1I4JpIVuYL+OwC8+hV7uV+52GLVRVKBmzDlZCAYJh3+Fjjc2gm7kuz3d6LAAV
	 qg3h5jyRnoEnH55Q6Yd4XK5eulTU6eKRrBXmpVxwXhc4xInRCYRA0vSAhjVPbYeNKR
	 OAhbFBwGKyCe+0VS/OCY6dUZEQ8DaHhFTKLWWWX1KOM5re+nPAufChLr77E3pK3L5b
	 6Sl1Cy0UmtosX6AbEgZYAwzHMBIMi+atN1UruuK6+GYg25EEZ5IowcPs2H+Aopt2vz
	 7WwAQPO4GhkzQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1e1frdf04pl; Tue,  6 Dec 2022 09:51:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA04F409F1;
	Tue,  6 Dec 2022 09:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA04F409F1
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 79F0D1BF289
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 09:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FE1D409F1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 09:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FE1D409F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KJi3keU-dWeZ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Dec 2022 09:51:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79AB5409AD
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79AB5409AD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Dec 2022 09:51:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5E05E61607;
 Tue,  6 Dec 2022 09:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F37C433C1;
 Tue,  6 Dec 2022 09:51:05 +0000 (UTC)
Date: Tue, 6 Dec 2022 11:51:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Message-ID: <Y48QhnqUEfNEcC8u@unreal>
References: <20221206030805.15934-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221206030805.15934-1-jiasheng@iscas.ac.cn>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1670320266;
 bh=OqXrkel/gqs5cVlkVunVtxkFHQXH2a23IGjNXD5nSpI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T5ZMe/9QlZREU2UsUVObCC+9cMPh7m08dwqr+1zNIaV6sDQk1hx3E92N/9nMDhFNu
 KDYxsor+tV0TRZrRf0zH+wDiLdkKfj5VVM7ZKm+rjrfnHN7u7ULZAsHbCGKEeWRG2W
 BEJy71fgXwcSW1cTVa13KKD0Rx+uigtvFCQBx1VU+nXLfMijyQCXtVzD7XgyLQJkzK
 iTQCRn/zQrjCWmYrKMHU1iY67jRYUwAvfB24iS6bd8/DcJvmi7NCkGhQdOtXFFZegI
 /3AjwjnVIbkdrsWvLL8TX0bGLNn6A4/UjC40xdksSdwlxEWzg5I1i25ytbIOI01fNL
 A+/hzHR5FdROw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=T5ZMe/9Q
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Add check for kzalloc
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
Cc: intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Dec 06, 2022 at 11:08:05AM +0800, Jiasheng Jiang wrote:
> As kzalloc may fail and return NULL pointer,
> it should be better to check the return value
> in order to avoid the NULL pointer dereference.
> 
> Fixes: d6b98c8d242a ("ice: add write functionality for GNSS TTY")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_gnss.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

The idea is correct, but please change an implementation to use goto
and proper unwind for whole function. It will remove duplication in the
code which handles tty_port destroys.

Thanks

> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> index b5a7f246d230..6d3d5e75726b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> @@ -421,7 +421,7 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
>  	const int ICE_TTYDRV_NAME_MAX = 14;
>  	struct tty_driver *tty_driver;
>  	char *ttydrv_name;
> -	unsigned int i;
> +	unsigned int i, j;
>  	int err;
>  
>  	tty_driver = tty_alloc_driver(ICE_GNSS_TTY_MINOR_DEVICES,
> @@ -462,6 +462,17 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
>  					       GFP_KERNEL);
>  		pf->gnss_serial[i] = NULL;
>  
> +		if (!pf->gnss_tty_port[i]) {
> +			for (j = 0; j < i; j++) {
> +				tty_port_destroy(pf->gnss_tty_port[j]);
> +				kfree(pf->gnss_tty_port[j]);
> +			}
> +			kfree(ttydrv_name);
> +			tty_driver_kref_put(pf->ice_gnss_tty_driver);
> +
> +			return NULL;
> +		}
> +
>  		tty_port_init(pf->gnss_tty_port[i]);
>  		tty_port_link_device(pf->gnss_tty_port[i], tty_driver, i);
>  	}
> -- 
> 2.25.1
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
