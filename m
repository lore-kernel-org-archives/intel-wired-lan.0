From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 22 Sep 2021 12:05:56 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] devlink: Make
 devlink_register to be void
In-Reply-To: <311a6c7e74ad612474446890a12c9d310b9507ed.1632300324.git.leonro@nvidia.com>
References: <311a6c7e74ad612474446890a12c9d310b9507ed.1632300324.git.leonro@nvidia.com>
Message-ID: <20210922120555.lwjggkl2zsxra64x@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 22, 2021 at 11:58:03AM +0300, Leon Romanovsky wrote:
> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
> index eef13cd20f19..96f211f52ac3 100644
> --- a/net/dsa/dsa2.c
> +++ b/net/dsa/dsa2.c
> @@ -804,10 +804,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>  	dl_priv = devlink_priv(ds->devlink);
>  	dl_priv->ds = ds;
>  
> -	err = devlink_register(ds->devlink);
> -	if (err)
> -		goto free_devlink;
> -
> +	devlink_register(ds->devlink);
>  	/* Setup devlink port instances now, so that the switch
>  	 * setup() can register regions etc, against the ports
>  	 */
> @@ -863,10 +860,8 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>  		if (dp->ds == ds)
>  			dsa_port_devlink_teardown(dp);
>  	devlink_unregister(ds->devlink);
> -free_devlink:
>  	devlink_free(ds->devlink);
>  	ds->devlink = NULL;
> -
>  	return err;
>  }

Acked-by: Vladimir Oltean <olteanv@gmail.com> # dsa
