From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 20 Jun 2017 17:10:12 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Add malicious driver
 detection	support
In-Reply-To: <1497020190-65305-1-git-send-email-paul.greenwalt@intel.com>
References: <1497020190-65305-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB65D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Friday, June 9, 2017 7:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Add malicious driver detection
> support
> 
> Add malicious driver detection (MDD) support for X550, X550em_a, and
> X550em_x devices.
> 
> MDD is a hardware SR-IOV security feature which the driver enables by
> default, but can be controlled on|off by ethtool set-priv-flags parameter.
> When enabled MDD disables a VF drivers transmit queue when a malformed
> descriptor is detected. The PF will log the event and re-enable the VF queue.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
> v2: Changed new function declarations to static.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   3 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c  |  25 +++-
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  13 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   6 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c   |  50 ++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   8 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    | 138
> +++++++++++++++++++++++
>  7 files changed, 241 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


