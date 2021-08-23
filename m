From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 23 Aug 2021 23:43:39 +0000
Subject: [Intel-wired-lan] [net-next v3 10/13] ice: implement basic E822
 PTP support
In-Reply-To: <20210707234108.4071506-11-jacob.e.keller@intel.com>
References: <20210707234108.4071506-1-jacob.e.keller@intel.com>
 <20210707234108.4071506-11-jacob.e.keller@intel.com>
Message-ID: <14819520-4ecf-85da-915d-2f384e275fe9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/7/2021 4:41 PM, Keller, Jacob E wrote:
> Implement support for the basic operations needed to enable the PTP
> hardware clock on E822 devices.
> 
> This includes implementations for the various PHY access functions, as
> well as the ability to start and stop the PHY timers. This is different
> from the E810 device because the configuration depends on link speed, so
> we cannot just start the PHYs immediately. We must wait until the link
> is up to get proper values for the speed based initialization.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

This patch has a bug, unfortunately....

>  
> +/**
> + * ice_ptp_init_tx_e822 - Initialize tracking for Tx timestamps
> + * @pf: Board private structure
> + * @tx: the Tx tracking structure to initialize
> + * @port: the port this structure tracks
> + *
> + * Initialize the Tx timestamp tracker for this port. For generic MAC devices,
> + * the timestamp block is shared for all ports in the same quad. To avoid
> + * ports using the same timestamp index, logically break the block of
> + * registers into chunks based on the port number.
> + */
> +static int
> +ice_ptp_init_tx_e822(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
> +{
> +	tx->quad = port % ICE_PORTS_PER_QUAD;

This quad calculation is wrong, it should be:

  tx->quad = port / ICE_PORTS_PER_QUAD;

This causes the incorrect quad number to be used for all ports except
for port 0. Because of this, Tx timestamps only work on port 0.

Can we fix this and have a v4? If not, a fix commit will be required.

Thanks,
Jake

> +	tx->quad_offset = tx->quad * INDEX_PER_PORT;
> +	tx->len = INDEX_PER_PORT;
> +
> +	return ice_ptp_alloc_tx_tracker(tx);
> +}
> +
