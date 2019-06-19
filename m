From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jun 2019 23:14:38 +0000
Subject: [Intel-wired-lan] [next v2] iavf: use struct_size() helper
In-Reply-To: <20190614232320.9752-1-jeffrey.t.kirsher@intel.com>
References: <20190614232320.9752-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3F8D43@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Friday, June 14, 2019 4:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next v2] iavf: use struct_size() helper
> 
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> 
> Make use of the struct_size() helper instead of an open-coded version in
> order to avoid any potential type mistakes, in particular in the context in
> which this code is being used.
> 
> So, replace code of the following form:
> 
> sizeof(struct virtchnl_ether_addr_list) + (count * sizeof(struct
> virtchnl_ether_addr))
> 
> with:
> 
> struct_size(veal, list, count)
> 
> and so on...
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> ---
> v2: Fixed up patch to apply cleanly to the current iavf driver
> 
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 37 ++++++++-----------
>  1 file changed, 16 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


