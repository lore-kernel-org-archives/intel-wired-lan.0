From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Jan 2021 18:21:33 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 2/8] taprio: Add support
 for frame preemption offload
In-Reply-To: <20210119004028.2809425-3-vinicius.gomes@intel.com>
References: <20210119004028.2809425-1-vinicius.gomes@intel.com>
 <20210119004028.2809425-3-vinicius.gomes@intel.com>
Message-ID: <20210119182133.038fbfc3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 Jan 2021 16:40:22 -0800 Vinicius Costa Gomes wrote:
> Adds a way to configure which traffic classes are marked as
> preemptible and which are marked as express.
> 
> Even if frame preemption is not a "real" offload, because it can't be
> executed purely in software, having this information near where the
> mapping of traffic classes to queues is specified, makes it,
> hopefully, easier to use.
> 
> taprio will receive the information of which traffic classes are
> marked as express/preemptible, and when offloading frame preemption to
> the driver will convert the information, so the driver receives which
> queues are marked as express/preemptible.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

> @@ -1286,13 +1289,15 @@ static int taprio_disable_offload(struct net_device *dev,
>  	offload->enable = 0;
>  
>  	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
> -	if (err < 0) {
> +	if (err < 0)
> +		NL_SET_ERR_MSG(extack,
> +			       "Device failed to disable offload");
> +
> +	err = ops->ndo_setup_tc(dev, TC_SETUP_PREEMPT, &preempt);
> +	if (err < 0)
>  		NL_SET_ERR_MSG(extack,
>  			       "Device failed to disable offload");

This was meant to say something else?

> -		goto out;
> -	}
>  
> -out:
>  	taprio_offload_free(offload);
>  
>  	return err;
