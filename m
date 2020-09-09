From: Joe Perches <joe@perches.com>
Date: Wed, 09 Sep 2020 02:33:48 -0700
Subject: [Intel-wired-lan] [net-next] net: iavf: Use the ARRAY_SIZE
 macro for aq_to_posix
In-Reply-To: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
References: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
Message-ID: <2530c5c8a596b7edd7e2273cffc3b76ac4b437c7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-09-09 at 16:51 +0800, Wei Xu wrote:
> Use the ARRAY_SIZE macro to calculate the size of an array.
> This code was detected with the help of Coccinelle.
[]
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
[]
> @@ -120,7 +120,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
>  	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
>  		return -EAGAIN;
>  
> -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> +	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
>  		return -ERANGE;

If you want to use a cast,

	if ((u32)aq_rc >= ARRAY_SIZE(aq_to_posix))
		return -ERANGE;

would be a more common and simpler style, though
perhaps testing ac_rc < 0 would be more intelligible.

	if (ac_rc < 0 || ac_rq >= ARRAY_SIZE(aq_to_posix))
		return -ERANGE;



