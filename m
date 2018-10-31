From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 19:15:34 +0000
Subject: [Intel-wired-lan] [next S97 v2 2/6] i40e: Add capability flag
 for stopping FW LLDP
In-Reply-To: <20181030175047.18874-2-jeffrey.t.kirsher@intel.com>
References: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
 <20181030175047.18874-2-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32901C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, October 30, 2018 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Galazka, Krzysztof <krzysztof.galazka@intel.com>
> Subject: [Intel-wired-lan] [next S97 v2 2/6] i40e: Add capability flag for
> stopping FW LLDP
> 
> From: Krzysztof Galazka <krzysztof.galazka@intel.com>
> 
> Add HW capability flag to indicate that firmware supports stopping LLDP
> agent. This feature has been added in FW API 1.7 for XL710 devices and 1.6
> for X722. Also raise expected minor version number for X722 FW API to 6.
> 
> Signed-off-by: Krzysztof Galazka <krzysztof.galazka@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c     | 6 ++++++
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 4 +++-
>  drivers/net/ethernet/intel/i40e/i40e_type.h       | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


