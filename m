From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 1 Feb 2017 01:05:01 +0000
Subject: [Intel-wired-lan] [next-queue v5 PATCH 6/7] i40e: Add support
 for	exposing VF port statistics via VFPR netdev on the host
In-Reply-To: <1485392057-3261-7-git-send-email-sridhar.samudrala@intel.com>
References: <1485392057-3261-1-git-send-email-sridhar.samudrala@intel.com>
 <1485392057-3261-7-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857D6628E@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Wednesday, January 25, 2017 4:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v5 PATCH 6/7] i40e: Add support for
> exposing VF port statistics via VFPR netdev on the host
> 


> +/**
> + * i40e_vfpr_netdev_get_stats64
> + * @dev: network interface device structure
> + * @stats: netlink stats structure
> + *
> + * Fills the hw statistics from the VSI corresponding to the associated VFPR
> + **/
> +void
> +i40e_vfpr_netdev_get_stats64(struct net_device *netdev,
> +			     struct rtnl_link_stats64 *stats)
> +{

Please make this static.


Thanks,
Jake
