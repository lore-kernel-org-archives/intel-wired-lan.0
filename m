Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A0606A322
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=k6HVui9i;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiyCxwmE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A24660653;
	Wed, 21 Oct 2026 03:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Hr0DmYXn8QW; Wed, 21 Oct 2026 02:59:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6DFA6071D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792551598;
	b=bA+94YmDvkKFakrDkL5F5v/AmaVw26Rk3rsMyE0f3o78JyB27LPvdGUeu/CLRA9WOI9p
	 90W99jNBh78DL5e9IUEWr54qVh+NMAACO7AokNw3wz9V9FtfyJah/qi9508Qpz2TCFFIV
	 K1KCqa05K8+q0GlcVQgmhG0vVnRsWykF3HbfneIevObzFdSJQ1OArW1eDQmwmcb8v+4jr
	 Ftx9UOD9pN7Ffk7H2pjzun5MGHk+P9QaJhlYdhh2s3Z81l758y5Rk0x+PawwB2QkkbnHS
	 W8jW172bT2s/QnBrSYS3wLJDjG5u6F8oaIJQlCYLGHTsDrgF6JaLGe0JM+bH4GXCuJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792551598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CzSMY7YkRh7R/E4qoOYphW8a6asUjDG/QPCwLK7WvA4=;
	b=WpzEBdI3moZ3SkoRocdqaabH6hYgeFYfy6IOMHdv7oExFWhrbweIyublSxJGAe8Hn4Vv
	 qY6lXbXHkdw+jvriLYc6Gz/53CP2wfjpBjw6tavqvSDRS0YuPpM9TYw1+DsvsHlcqj0FX
	 tSv1B2rfbS5ulTQz8bWh5QsVqb6RQ1hRchzoKRvjtuMPaKHX95GsSiuiS+wio6iqTseYT
	 qaLdPbAWviCT4BTlI5LmIqRpAVXJfa+ANcpeDUJmgahr5o+F1TymqKJsDizablGLtS+VD
	 mV16r58lhuzLJ52xwU2rdraOhSw+9nUqt7Ng4bdIsSZLguNhnQ6asucj6uQslGsjtMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792551598;
	bh=CzSMY7YkRh7R/E4qoOYphW8a6asUjDG/QPCwLK7WvA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=k6HVui9i7Jpg++NsNeWregH6tc/ESEdBRYCydJsAFenqQiZw9oEa6sjOMiIZg1pTK
	 bioLwltCjNKSyxu9nlVNE3aq+wOjb4/mRjxyIqp4GoKjG+aYAKZsEiD/ldOhFB+23e
	 FfUg088xod69p/dYvSRob1ouKGgMqoZybOp7QlbroGZBHc0kExt24Mw4ZJ3lsD1a5O
	 PkzSkBCwa7pmVlxfMys+/YiJGzQRZl9impxB22Tg5W1PEcBZitPZgLWPgYV0NDkToz
	 kWo6A5Fcat0FB5/H0iii21hUYK94uygTxVnXTxOGzUZp48wrSQ4c0MgBNPIfOyUdwQ
	 XWb+/1wtmDycw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6DFA6071D;
	Wed, 21 Oct 2026 02:59:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC7623A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 02:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1B8440112
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 02:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t_8_bXRpFwgA for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 02:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 70BDD40060
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792551596;
 b=XmoJS8ve7/O8+TNTM+pUjtA39SPHbxamf2JFt35Gd1LPmmu9qzH9Fvpaalo7ddHI8e0Q
 JxsqiFYgvktAjw9tvHKFzcnnzG/HvzMT6T1tiOYYj/4F89Fb9OdIc12NM+yfcBXwR/H9u
 wmWq/qeicJwcX56Yp3BoE971XOiIQ6c86tRzQUF3pVtEJjqiUP9QIlljL+kBDPiD7dwK+
 otpiyNobyYcSFGQyXtcnBcY4mGaqCRNGH/xCpvs1VYBPNghi8iXjionNLfj2Bx+pYA60U
 K0bvJDQvNrrm7Lk9xlERKey48JmHoX9UFrU9+cFV1edqlxrgJOiDrlM93exfxqfWsHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792551596;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=CzSMY7YkRh7R/E4qoOYphW8a6asUjDG/QPCwLK7WvA4=;
 b=CKNugHYWLt+hotZKSGWacWRXGpUL+q7apl5ScfWMmqE8RpAzUxm7ISnC1RhHWrRy8+Z8
 7ZL7a+X+Qf/VpQzxg+P0eNMwI1sHFj6SffhbwygNyW12zlbiuIZvpMcJUvkYF7AmDPRcI
 nn3Eh2QcNpkoB66nB4+srS72AvmbZaFJ7998zXfLN3mzYCDlJw9fP4EorX0u5z3ORo0uV
 LGeBQYh6T3+x3Br2O9p2TmQmd7SUXCeqfdkZNMJlCIo6TRaPljslPKOE0wFUPxAW8cleS
 rq8WBFsBXwPEPgjl0z7P2mOo5UDmmIMXLgcYg2noyUYpvKrFiSVjFBJvTyLcGfznxkA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZiyCxwmE; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZiyCxwmE
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70BDD40060
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 02:59:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95880601F1;
 Wed, 21 Oct 2026 02:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4AF1F000CD;
 Wed, 21 Oct 2026 02:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792551594;
 bh=CzSMY7YkRh7R/E4qoOYphW8a6asUjDG/QPCwLK7WvA4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZiyCxwmEHxl9VuG5e3YWszw5k2wOurgTCoP/7kD+KuV8xSCkn40Y86v3fGUSHEkjx
 mh4Ho3sn1qRDUnvyfOs8zrMs7FvKkR5BS2FC3p/mXQPZ5GW0/TncjnWMq7K4Ug1P87
 S7Kk9mtSWVIhLTqHMe5eJ7RhNqu5pNrTJwTDfs6XKJSPaTCgWuXFfGZTTqqrdor5/e
 Smyd9wtfQlV5YdyWDqieyKp9qZ2fjirDSQUWydIActIA3I1xJcOWNMOsIPLdklUnv4
 VjCepHzOLAKHRykbGLBIfCeCvVzMOxcMulrtiGUShmOlPmbjrmQC/4uiBSpuK0I8yp
 n9zwdzK7Z8KuA==
Message-ID: <sashiko-outbox-179736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] i40e: Lock VF cloud filter list operations
To: "Binbin Deng" <18983559317@163.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261020025856.519623-1-18983559317@163.com>
References: <20261020025856.519623-1-18983559317@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:59:53 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] i40e: TOCTOU race and VSI UAF in i40e_vc_add_cloud_filter() and re=
set
- [Low] i40e: mutex definition breaks kernel-doc for i40e_del_all_cloud_fil=
ters()
--

commit 03ab6f762cec8d24f3f9bbef8a127d3ed4ca9ef7
Author: Binbin Deng <18983559317@163.com>

i40e: Lock VF cloud filter list operations

This commit adds a file-local mutex, i40e_vf_cloud_filter_lock, to serialize
VF cloud filter additions, deletions, and bulk removals across
i40e_vc_add_cloud_filter(), i40e_vc_del_cloud_filter(), and
i40e_del_all_cloud_filters().

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers=
/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index c6732a24b6400..d62e59c7ac814 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3740,6 +3740,8 @@ static struct i40e_vsi *i40e_find_vsi_from_seid(str=
uct i40e_vf *vf, u16 seid)
>   *
>   * This function deletes all cloud filters
>   **/
> +static DEFINE_MUTEX(i40e_vf_cloud_filter_lock);
> +
>  static void i40e_del_all_cloud_filters(struct i40e_vf *vf)

[Severity: Low]
Will placing DEFINE_MUTEX(i40e_vf_cloud_filter_lock) between the kernel-doc
comment block and i40e_del_all_cloud_filters() cause scripts/kernel-doc to
emit a warning?

 Because DEFINE_MUTEX() sits immediately after the closing **/ of the comme=
nt,
kernel-doc parses DEFINE_MUTEX() as the documented prototype instead of
i40e_del_all_cloud_filters().

[ ... ]

> @@ -3856,6 +3860,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf =
*vf, u8 *msg)
>  	}
> =20
>  	/* get the vsi to which the tc belongs to */
> +	mutex_lock(&i40e_vf_cloud_filter_lock);
>  	vsi =3D pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
>  	cfilter.seid =3D vsi->seid;
>  	cfilter.flags =3D vcf->field_flags;

[ ... ]

> @@ -4002,6 +4009,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf =
*vf, u8 *msg)
>  	}
> =20
>  	/* get the VSI to which the TC belongs to */
> +	mutex_lock(&i40e_vf_cloud_filter_lock);
>  	vsi =3D pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
>  	cfilter->seid =3D vsi->seid;
>  	cfilter->flags =3D vcf->field_flags;

[Severity: High]
Can i40e_vc_add_cloud_filter() and i40e_vc_del_cloud_filter() still race wi=
th
i40e_ndo_set_vf_trust() and dereference a NULL or freed struct i40e_vsi, or
install a cloud filter after trust has been revoked?

In both i40e_vc_add_cloud_filter() and i40e_vc_del_cloud_filter(), the chec=
ks
for i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE), vf->adq_enabled,
i40e_validate_cloud_filter(vf, vcf), and vf->num_cloud_filters run before
acquiring i40e_vf_cloud_filter_lock.

Meanwhile, when host-side trust is revoked, i40e_ndo_set_vf_trust() resets =
the
VF outside i40e_vf_cloud_filter_lock before calling
i40e_del_all_cloud_filters():

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:i40e_ndo_set_vf_trust() {
	...
	if (!setting &&
	    (vf->adq_enabled || vf->num_cloud_filters > 0 ||
	     test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
	     test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))) {
		i40e_vc_reset_vf(vf, true);
		i40e_del_all_cloud_filters(vf);
	}
	...
}

During i40e_vc_reset_vf() -> i40e_reset_vf() -> i40e_cleanup_reset_vf() ->
i40e_free_vf_res(), the ADq channel VSIs are released and their indices are
cleared without holding i40e_vf_cloud_filter_lock:

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:i40e_free_vf_res() {
	...
	if (vf->adq_enabled && vf->ch[0].vsi_idx) {
		for (j =3D 0; j < vf->num_tc; j++) {
			if (j)
				i40e_vsi_release(pf->vsi[vf->ch[j].vsi_idx]);
			vf->ch[j].vsi_idx =3D 0;
			vf->ch[j].vsi_id =3D 0;
		}
	}
	...
}

If i40e_vc_add_cloud_filter() or i40e_vc_del_cloud_filter() passes the init=
ial
unlocked validation checks and then executes:

	mutex_lock(&i40e_vf_cloud_filter_lock);
	vsi =3D pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
	cfilter->seid =3D vsi->seid;

concurrently with i40e_vc_reset_vf(), vsi can be NULL or already freed by
i40e_vsi_release(), or vf->ch[vcf->action_meta].vsi_idx can be zeroed so th=
at
pf->vsi[0] (the PF main VSI) is used instead.

Additionally, if i40e_vc_add_cloud_filter() passes
i40e_validate_cloud_filter() before trust is revoked and acquires
i40e_vf_cloud_filter_lock after both i40e_vc_reset_vf() and
i40e_del_all_cloud_filters() have finished, wouldn't it program the filter =
into
hardware and append cfilter to vf->cloud_filter_list for an untrusted VF?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020025856.5196=
23-1-18983559317@163.com?part=3D1
