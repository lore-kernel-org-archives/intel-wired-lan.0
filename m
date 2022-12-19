Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F35C4332F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Dec 2022 15:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FF77600CC;
	Mon, 19 Dec 2022 15:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FF77600CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671464861;
	bh=DkVtj8LYTD2hrEKrm9LbVqKrn1MD8x5tmJy1KV9PjcM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Hpr9dXuj2kEuO1ZdqD9CCqjdrGdZJQG46cslj6pmGjfzKyFl6K9nY2QDr9nN3Rx6J
	 ygb3eGYWeISAYohRupDfkf3OAE0zs0+kOz3/kxXeISZ23KncOuSKpAAZ2vnLIjI4xK
	 U11Rj97LkAs8wTj16VpgU4o2f3f3lkWnm2QG5YSkRLQMiqVobFNNAtlnbbCBdYJ+fu
	 YIs4enWCzEaMK1j8EQFTbGUxG2WejxYQL1GpBc+iqbYm7gEKc1mgT1kEV8OwQiw1Dl
	 1Nv2olHKVnbINCgGbFfpph+Z8/+pA2IYQnI79DR9y9AcYZZQI0ssBYO+zxGUPPJhCd
	 2wRJIRUuSOWgA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a38vmDlNp0G9; Mon, 19 Dec 2022 15:47:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BBF460B04;
	Mon, 19 Dec 2022 15:47:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BBF460B04
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2FF4F1BF317
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Dec 2022 15:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09B5C814B5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Dec 2022 15:47:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09B5C814B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LKhuiLBvevbn for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Dec 2022 15:47:38 +0000 (UTC)
X-Greylist: delayed 00:08:25 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4606B8138E
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4606B8138E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Dec 2022 15:47:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3F58BB80E7B;
 Mon, 19 Dec 2022 15:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F583C433D2;
 Mon, 19 Dec 2022 15:39:07 +0000 (UTC)
Date: Mon, 19 Dec 2022 16:39:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <Y6CFma6PPcvJDGje@kroah.com>
References: <20221219144103.34789-1-wanghai38@huawei.com>
 <Y6B7MKZxjaoQlpgf@kroah.com>
 <dd4d0619-8287-1650-aa43-5db2e86ff8cd@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dd4d0619-8287-1650-aa43-5db2e86ff8cd@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=linuxfoundation.org; 
 s=korg; t=1671464348;
 bh=abQAHntBQcTBqm2NuQ5VKUAc8kU4maN4os+8XBDoq/4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CP5UoDATyz4FQuO5IiIX6XpSMv/2ikU14jWCB7LIFbSgZZ7jwOo/fnOFT/5hwvyQi
 rdqcUz7wfe9NETBSpwVtW++nz0XLfkp943GDb1tMXmOVXuuYa2LPKWOwIJy49L91bo
 naLxbREWQGiqzrMeHbvT6d/xyJG8sodX9eaYMGnM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=CP5UoDAT
Subject: Re: [Intel-wired-lan] [PATCH] kobject: Fix slab-out-of-bounds in
 fill_kobj_path()
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
Cc: rafael@kernel.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 Alice Chao <alice.chao@mediatek.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Dec 19, 2022 at 11:27:58PM +0800, wanghai (M) wrote:
> Can I send v2 like this?
> =

> diff --git a/lib/kobject.c b/lib/kobject.c
> index a0b2dbfcfa23..3f97d903266a 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -112,7 +112,7 @@ static int get_kobj_path_length(struct kobject *kobj)
> =A0=A0=A0=A0=A0=A0=A0 return length;
> =A0}
> =

> -static void fill_kobj_path(struct kobject *kobj, char *path, int length)
> +static int fill_kobj_path(struct kobject *kobj, char *path, int length)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0 struct kobject *parent;
> =

> @@ -121,12 +121,16 @@ static void fill_kobj_path(struct kobject *kobj, ch=
ar
> *path, int length)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int cur =3D strlen(kobject_=
name(parent));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* back up enough to print =
this name with '/' */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 length -=3D cur;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (length <=3D 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n -EINVAL;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(path + length, kobje=
ct_name(parent), cur);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(path + --length) =3D '/';
> =A0=A0=A0=A0=A0=A0=A0 }
> =

> =A0=A0=A0=A0=A0=A0=A0 pr_debug("kobject: '%s' (%p): %s: path =3D '%s'\n",
> kobject_name(kobj),
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kobj, __func__, path);
> +
> +=A0=A0=A0=A0=A0=A0 return 0;
> =A0}
> =

> =A0/**
> @@ -141,13 +145,17 @@ char *kobject_get_path(struct kobject *kobj, gfp_t
> gfp_mask)
> =A0=A0=A0=A0=A0=A0=A0 char *path;
> =A0=A0=A0=A0=A0=A0=A0 int len;
> =

> +retry:
> =A0=A0=A0=A0=A0=A0=A0 len =3D get_kobj_path_length(kobj);
> =A0=A0=A0=A0=A0=A0=A0 if (len =3D=3D 0)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;
> =A0=A0=A0=A0=A0=A0=A0 path =3D kzalloc(len, gfp_mask);
> =A0=A0=A0=A0=A0=A0=A0 if (!path)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;
> -=A0=A0=A0=A0=A0=A0 fill_kobj_path(kobj, path, len);
> +=A0=A0=A0=A0=A0=A0 if (fill_kobj_path(kobj, path, len)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(path);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto retry;
> +=A0=A0=A0=A0=A0=A0 }

Much nicer, thanks!
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
