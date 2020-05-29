From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 May 2020 05:35:09 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] ice: Replace one-element
 arrays with flexible-arrays
In-Reply-To: <20200527141119.GA30849@embeddedor>
References: <20200527141119.GA30849@embeddedor>
Message-ID: <61CC2BC414934749BD9F5BF3D5D94044986DE746@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Wednesday, May 27, 2020 07:11
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>;
> Kees Cook <keescook@chromium.org>
> Subject: [PATCH net-next v3] ice: Replace one-element arrays with flexible-
> arrays
> 
> The current codebase makes use of one-element arrays in the following
> form:
> 
> struct something {
>     int length;
>     u8 data[1];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
> 
> but the preferred mechanism to declare variable-length types such as these
> ones is a flexible array member[1][2], introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning in case
> the flexible array does not occur last in the structure, which will help us prevent
> some kind of undefined behavior bugs from being inadvertently introduced[3]
> to the codebase from now on. So, replace the one-element array with a
> flexible-array member.
> 
> Also, make use of the offsetof() helper in order to simplify some macros and
> properly calculate the size of the structures that contain flexible-array members.
> 
> This issue was found with the help of Coccinelle and, audited _manually_.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
[Kirsher, Jeffrey T] 

Thanks Gustavo, but we (or I should say Bruce Allan) already has a patch to resolve this,
and is a bit more thorough.  I will make sure you get CC'd on the patch, for your review.

> ---
> Changes in v3:
>  - We still can simply the code even more by using offsetof() just once. :)
> 
> Changes in v2:
>  - Use offsetof(struct ice_aqc_sw_rules_elem, pdata) instead of
>    sizeof(struct ice_aqc_sw_rules_elem) - sizeof(((struct ice_aqc_sw_rules_elem
> *)0)->pdata)
>  - Update changelog text.
> 
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  6 ++---
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 23 ++++++-------------
>  2 files changed, 10 insertions(+), 19 deletions(-)
> 
