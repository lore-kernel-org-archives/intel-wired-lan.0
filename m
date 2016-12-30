From: David Miller <davem@davemloft.net>
Date: Thu, 29 Dec 2016 21:52:51 -0500 (EST)
Subject: [Intel-wired-lan] [net-next PATCH 2/6] i40e: Introduce VF Port
 Representator(VFPR) netdevs.
In-Reply-To: <1483078863-22026-3-git-send-email-sridhar.samudrala@intel.com>
References: <1483078863-22026-1-git-send-email-sridhar.samudrala@intel.com>
 <1483078863-22026-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <20161229.215251.689242851887487491.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu, 29 Dec 2016 22:20:59 -0800

>  		/* VF resources get allocated during reset */
>  		i40e_reset_vf(&vfs[i], false);
>  
> +		if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
> +			i40e_alloc_vfpr_netdev(&vfs[i], i);

You aren't checking for, and unwinding from, errors signalled
by i40e_alloc_vfpr_netdev().
