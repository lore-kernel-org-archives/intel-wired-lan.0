From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 17 Oct 2017 08:14:54 -0700
Subject: [Intel-wired-lan] [PATCH,
	net-next] i40e: avoid 64-bit division where possible
In-Reply-To: <20171017102351.492492-1-arnd@arndb.de>
References: <20171017102351.492492-1-arnd@arndb.de>
Message-ID: <1508253294.2928.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-10-17 at 12:23 +0200, Arnd Bergmann wrote:
> The new bandwidth calculation causes a link error on 32-bit
> architectures, like
> 
> ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko]
> undefined!
> 
> The problem is the max_tx_rate calculation that uses 64-bit integers.
> This is not really necessary since the numbers are in MBit/s so
> they won't be higher than 40000 for the highest support rate, and
> are guaranteed to not exceed 2^32 in future generations either.
> 
> This changes the representation to 'u32' when dealing with MBit/s
> and uses div_u64() to convert from u64 numbers in byte/s.
> 
> Fixes: 2027d4deacb1 ("i40e: Add support setting TC max bandwidth
> rates")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 27 ++++++++++++++-----
> --------
>  2 files changed, 16 insertions(+), 15 deletions(-)

Unfortunately your patch does not apply cleanly to my tree.  Arnd,
could you please rebase your patch based my next-queue tree (dev-queue
branch)?  I already have several i40e patches queued up and applied to
that branch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171017/b769331a/attachment.asc>
