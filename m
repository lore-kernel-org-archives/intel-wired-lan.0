From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Dec 2016 22:41:00 +0000
Subject: [Intel-wired-lan] [next PATCH S56 2/8] i40e: Add bus number
 info to	i40e_bus_info struct
In-Reply-To: <1480710782-9195-3-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
 <1480710782-9195-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39232@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, December 02, 2016 12:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S56 2/8] i40e: Add bus number info to
> i40e_bus_info struct
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> Currently i40e_bus_info has PCI device and function info only and log
> messages print device number as bus number. Added field to provide bus
> number info and modified log statements to print bus, device and function
> information.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Change-ID: I811617cee2714cc0d6bade8d369f57040990756f
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c   | 16 +++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h    | 12 ++++++------
>  drivers/net/ethernet/intel/i40e/i40e_type.h     |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h   |  1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  1 +
>  6 files changed, 19 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


