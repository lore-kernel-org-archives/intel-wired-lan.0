From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Apr 2019 18:45:00 +0000
Subject: [Intel-wired-lan] [PATCH 3/6] ice: Use struct_size() helper
In-Reply-To: <20190329233850.29630-3-jeffrey.t.kirsher@intel.com>
References: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
 <20190329233850.29630-3-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D378664@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Friday, March 29, 2019 4:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/6] ice: Use struct_size() helper
> 
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> 
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo); instance = alloc(size,
> GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> size = struct_size(instance, entry, count);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


