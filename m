From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 23 Jun 2017 23:20:37 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 8/9] i40e: display correct
 UDP	tunnel type name
In-Reply-To: <20170620221701.46765-8-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
 <20170620221701.46765-8-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DABAFB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, June 20, 2017 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S73-V2 8/9] i40e: display correct UDP
> tunnel type name
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The i40e driver attempts to display the UDP tunnel name by doing a check
> against the type, where for non-zero types we use "vxlan" and for zero type
> we use "geneve". This is not future proof, because if new tunnel types get
> added, we'll incorrectly label them. It also depends on the value of
> UDP_TUNNEL_TYPE_GENEVE == 0, which is brittle.
> 
> Instead, replace this with a function that can return a constant string
> depending on the type. For now we'll use "unknown" for types we don't
> know about, and we can expand this in the future if new types get added.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 28
> ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


