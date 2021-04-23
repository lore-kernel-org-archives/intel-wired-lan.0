From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 23 Apr 2021 20:24:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Enable configuration of
 number of qps per VF via devlink
In-Reply-To: <20210423044603.1391-1-sridhar.samudrala@intel.com>
References: <20210423044603.1391-1-sridhar.samudrala@intel.com>
Message-ID: <0f3220d28f6289bfef2e90aa8285f1c678695a54.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-04-22 at 21:46 -0700, Sridhar Samudrala wrote:

<snip>

> +/**
> + * ice_devlink_num_qps_per_vf_validate - Validate the number of qps
> per vf
> + * @devlink: pointer to the devlink instance
> + * @id: the parameter ID to validate
> + * @ctx: context to return the parameter value
> + * @extack: netlink extended ACK structure
> + *
> + * Check that the value passed is less than the max qps allowed for
> a VF and
> + * no VFs are created yet.
> + * Returns: zero on success, or an error code on failure and extack
> with a
> + * reason for failure.
> + */
> +static int
> +ice_devlink_num_qps_per_vf_validate(struct devlink *devlink, u32 id,
> +				    union devlink_param_value val,
> +				    struct netlink_ext_ack *extack)

I believe you changed a parameter, but forgot to update the kdoc:

drivers/net/ethernet/intel/ice/ice_devlink.c:526: warning: Function
parameter or member 'val' not described in
'ice_devlink_num_qps_per_vf_validate'
drivers/net/ethernet/intel/ice/ice_devlink.c:526: warning: Excess
function parameter 'ctx' description in
'ice_devlink_num_qps_per_vf_validate'

