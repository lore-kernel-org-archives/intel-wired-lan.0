From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:01:36 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 03/13] i40evf: Allow
 turning off offloads when the
In-Reply-To: <20171227123242.22356-3-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
 <20171227123242.22356-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6FED@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 4:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S84-V2 03/13] i40evf: Allow turning off
> offloads when the
> 
> This patch adds back the capability to turn off offloads when VF has VLAN
> set. The commit 0a3b4f702fb1 ("i40evf: enable support for VF VLAN tag
> stripping control") adds the i40evf_set_features function and changes the
> 'turn off' flow for offloads. This patch adds that capability back by moving
> checking the VLAN option for VF to the next statement.
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


