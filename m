From: Williams, Mitch A <mitch.a.williams@intel.com>
Date: Tue, 4 Apr 2017 16:33:02 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: limit client interface to X722
	hardware
In-Reply-To: <20170404143446.16359-1-sassmann@kpanic.de>
References: <20170404143446.16359-1-sassmann@kpanic.de>
Message-ID: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D80543C1D@FMSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On
> Behalf Of Stefan Assmann
> Sent: Tuesday, April 04, 2017 7:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; sassmann at kpanic.de
> Subject: [PATCH] i40e: limit client interface to X722 hardware
> 
> The client interface is meant for X722 iWARP support. Modprobing i40iw
> on systems with X710/XL710 NICs currently may crash the system. Adding a
> check which limits client interface access to the appropriate hardware.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 191028b..6f873449 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -525,15 +525,17 @@ static void i40e_client_release(struct i40e_client
> *client)
>  static void i40e_client_prepare(struct i40e_client *client)
>  {
>  	struct i40e_device *ldev;
> -	struct i40e_pf *pf;
> 
>  	mutex_lock(&i40e_device_mutex);
>  	list_for_each_entry(ldev, &i40e_devices, list) {
> -		pf = ldev->pf;
> -		i40e_client_add_instance(pf);
> -		/* Start the client subtask */
> -		pf->flags |= I40E_FLAG_SERVICE_CLIENT_REQUESTED;
> -		i40e_service_event_schedule(pf);
> +		struct i40e_pf *pf = ldev->pf;
> +
> +		if (pf->hw.mac.type == I40E_MAC_X722) {
> +			i40e_client_add_instance(pf);
> +			/* Start the client subtask */
> +			pf->flags |= I40E_FLAG_SERVICE_CLIENT_REQUESTED;
> +			i40e_service_event_schedule(pf);
> +		}
>  	}
>  	mutex_unlock(&i40e_device_mutex);
>  }
> --
> 2.9.3

Thanks for pointing this out, Stephan. I think that's not exactly the right way to do this check. Instead, we need to look at the IWARP flag. I'll get a patch out today to take care of it.

So consider this a thankful NAK.

-Mitch

