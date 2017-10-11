From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 11 Oct 2017 15:46:56 -0700
Subject: [Intel-wired-lan] [PATCH] i40e/i40evf: actually use u32 for
	feature flags
In-Reply-To: <20171011140316.3802721-1-arnd@arndb.de>
References: <20171011140316.3802721-1-arnd@arndb.de>
Message-ID: <1507762016.6150.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-10-11 at 16:02 +0200, Arnd Bergmann wrote:
> A previous cleanup intended to change the flags variable to 32
> bit instead of 64, but accidentally left out the important
> part of that change, leading to a build error:
> 
> drivers/net/ethernet/intel/i40e/i40e_ethtool.o: In function
> `i40e_set_priv_flags':
> i40e_ethtool.c:(.text+0x1a94): undefined reference to
> `wrong_size_cmpxchg'
> 
> This adds the missing modification.
> 
> Fixes: b74f571f59a8 ("i40e/i40evf: organize and re-number feature
> flags")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

To slow... :-) I had already sent a fix for this on Monday to David. 
Check David Miller's net-next tree, it is already there.
