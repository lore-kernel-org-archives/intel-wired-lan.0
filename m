From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 10 Jun 2021 20:03:36 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/8] ice: add support for sideband
 messages
In-Reply-To: <20210609163953.52440-2-anthony.l.nguyen@intel.com>
References: <20210609163953.52440-1-anthony.l.nguyen@intel.com>
 <20210609163953.52440-2-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510521FC9FA182A8FBF75BA7FA359@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, June 9, 2021 9:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/8] ice: add support for sideband
> messages
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
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
>  drivers/net/ethernet/intel/ice/ice_common.c   | 59 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |  3 +
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 62 +++++++++++++
> drivers/net/ethernet/intel/ice/ice_controlq.h |  2 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   | 51 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 11 ++-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 47 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  | 92
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_type.h     |  2 +
>  11 files changed, 344 insertions(+), 2 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_sbq_cmd.h

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


