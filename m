From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 12 Jan 2018 09:52:34 -0800
Subject: [Intel-wired-lan] [PATCH][next] ixgbe: fix comparison of offset
 with zero or NVM_INVALID_PTR
In-Reply-To: <20180112171310.27973-1-colin.king@canonical.com>
References: <20180112171310.27973-1-colin.king@canonical.com>
Message-ID: <1515779554.6613.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2018-01-12 at 17:13 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The incorrect operator && is being used and will always return false
> as offset can never be two different values at the same time. Fix
> this
> by using the || operator instead.
> 
> Detected by CoverityScan, CID#1463806 ("Logically dead code")
> 
> Fixes: 73834aec7199 ("ixgbe: extend firmware version support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Dan Carpenter beat you too it, see his patch in my tree:

commit 7352baadcc2ad2ed214e52bd8b50ac6eb01968cd
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Fri Jan 12 09:45:00 2018 -0800

    ixgbe: Fix && vs || typo
    
    "offset" can't be both 0x0 and 0xFFFF so presumably || was intended
    instead of &&.  That matches with how this check is done in other
    functions.
    
    Fixes: 73834aec7199 ("ixgbe: extend firmware version support")
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180112/812c86ca/attachment.asc>
