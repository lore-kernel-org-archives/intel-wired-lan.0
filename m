From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 1 Feb 2017 01:06:04 +0000
Subject: [Intel-wired-lan] [next-queue v5 PATCH 2/7] i40e: Introduce VF
 Port	Representator(VFPR) netdevs
In-Reply-To: <1485392057-3261-3-git-send-email-sridhar.samudrala@intel.com>
References: <1485392057-3261-1-git-send-email-sridhar.samudrala@intel.com>
 <1485392057-3261-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857D662A4@ORSMSX115.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v5 PATCH 2/7] i40e: Introduce VF Port
> Representator(VFPR) netdevs
> 

Hi,

> +/**
> + * i40e_update_vf_broadcast_filter
> + * @vf: pointer to the VF structure
> + * @enable: boolean flag indicating add/delete
> + *
> + * add/delete VFs broadcast filter
> + **/
> +void i40e_update_vf_broadcast_filter(struct i40e_vf *vf, bool enable)
> +{

Please make this function static, as it is not used anywhere outside this file.

> +	struct i40e_pf *pf = vf->pf;
> +	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
> +	u8 broadcast[ETH_ALEN];
> +	int err;
> +
> +	spin_lock_bh(&vsi->mac_filter_hash_lock);
> +	eth_broadcast_addr(broadcast);
> +	if (enable)
> +		i40e_add_mac_filter(vsi, broadcast);
> +	else
> +		i40e_del_mac_filter(vsi, broadcast);
> +	spin_unlock_bh(&vsi->mac_filter_hash_lock);
> +
> +	/* update broadcast filter */
> +	err = i40e_sync_vsi_filters(vsi);
> +	if (err)
> +		dev_err(&pf->pdev->dev, "Unable to program bcast filter\n");
> +}
> +
>

Thanks,
Jake
 

