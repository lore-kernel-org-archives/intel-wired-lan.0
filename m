From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 26 Nov 2019 11:20:16 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v1 2/4] igc: Add support
 for RX timestamping
In-Reply-To: <20191122020224.1102649-3-vinicius.gomes@intel.com>
References: <20191122020224.1102649-1-vinicius.gomes@intel.com>
 <20191122020224.1102649-3-vinicius.gomes@intel.com>
Message-ID: <877e3mcumn.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:

> This adds support for timestamping received packets.
>
> It is based on the i210, as many features of i225 work the same way.
> The main difference from i210 is that i225 has support for choosing
> the timer register to use when timestamping packets. Right now, we
> only support using timer 0. The other difference is that i225 stores
> two timestamps in the receive descriptor, right now, we only retrieve
> one.
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---

[...]

> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index fa345adad5c9..a5b7e5e05a89 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -283,12 +283,21 @@
>  #define IGC_RCTL_RDMTS_HALF	0x00000000 /* Rx desc min thresh size */
>  #define IGC_RCTL_BAM		0x00008000 /* broadcast enable */
>  
> +/* Split Replication Receive Control */
> +#define IGC_SRRCTL_TIMESTAMP		0x04000

I made a mistake here, it should read "0x40000000" or BIT(30). It's
causing timestamps to only be accessed via the registers, instead of via
the descriptors. Will send a v2 soon.


Cheers,
--
Vinicius
