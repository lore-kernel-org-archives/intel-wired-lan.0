From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 17:00:06 +0000
Subject: [Intel-wired-lan] [next PATCH S37 12/15] i40evf: always
 activate	correct MAC address filter
In-Reply-To: <1463419605-30746-13-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-13-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D68EC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 12/15] i40evf: always activate
> correct MAC address filter
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Always add MAC address at the tail of the MAC filter list. Since the device's
> "real" MAC address is added first, it will always be at the beginning of the list.
> This prevents an issue where the "real" MAC filter might not get added if too
> many other filters are added before bringing the interface up.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I34a8aeebeb0cb87a44b24118adc4176c7b943c1c
> ---
> Testing Hints : Add a lot of MAC filters before bringing the interface up.
> Ensure it still works on the base MAC address.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Real mac filter remains at top of filter list regardless of number of MACs added before bringing interface up, tools report hardware MAC
