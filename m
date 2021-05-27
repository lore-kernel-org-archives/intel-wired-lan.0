From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 27 May 2021 17:21:49 +0000
Subject: [Intel-wired-lan] [PATCH 1/8] ice: add support for sideband
 messages
In-Reply-To: <20210520164850.1884656-2-jacob.e.keller@intel.com>
References: <20210520164850.1884656-1-jacob.e.keller@intel.com>
 <20210520164850.1884656-2-jacob.e.keller@intel.com>
Message-ID: <CO1PR11MB5105D6F1ABB6AC9C8EEB9ED8FA239@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, May 20, 2021 9:49 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Lion, Sean <sean.lion@intel.com>
> Subject: [Intel-wired-lan] [PATCH 1/8] ice: add support for sideband
> messages
> 
> In order to support certain device features, including enabling the PTP
> hardware clock, the ice driver needs to control some registers on the device
> PHY.
> 
> These registers are accessed by sending sideband messages. For some
> hardware, these messages must be sent over the device admin queue, while
> other hardware has a dedicated control queue for the sideband messages.
> 
> Add the neighbor device message structure for sending a message to the
> neighboring device. Where supported, initialize the sideband control queue
> and handle cleanup.
> 
> Add a wrapper function for sending sideband control queue messages that
> read or write a neighboring device register.
> 
> Because some devices send sideband messages over the AdminQ, also
> increase the length of the admin queue to allow more messages to be
> queued up. This is important because the sideband messages add additional
> pressure on the AQ usage.
> 
> This support will be used in following patches to enable support for
> CONFIG_1588_PTP_CLOCK.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  4 +-
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 13 +++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 58 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |  3 +
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 62 +++++++++++++
> drivers/net/ethernet/intel/ice/ice_controlq.h |  2 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   | 51 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 46 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  | 92
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_type.h     |  2 +
>  10 files changed, 332 insertions(+), 1 deletion(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_sbq_cmd.h

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


