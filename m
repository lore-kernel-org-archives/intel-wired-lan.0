From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 01 Apr 2015 17:53:32 -0700
Subject: [Intel-wired-lan] [next-queue] igb: cleanup igb_enable_mas() a
 bit
In-Reply-To: <1427256426-24377-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427256426-24377-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427936012.2662.43.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-03-24 at 21:07 -0700, Jeff Kirsher wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Static checkers complain about this because we do:
> 
>         if (!(connsw & E1000_CONNSW_SERDESD)) {
>                 ...
>         } else if (connsw & E1000_CONNSW_SERDESD) {
>                 ...
>         } else {
>                 ...
>         }
> 
> Once you eliminate that E1000_CONNSW_SERDESD is set and not set then
> there aren't any other possibilities so the else statement is dead
> code.
> 
> This function always returns zero so if you delete the "ret_val"
> variable, the code is shorter and more clear.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

I have dropped this patch and have applied Todd's alternate patch
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150401/0454e373/attachment.asc>
