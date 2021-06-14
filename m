From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 14 Jun 2021 21:22:55 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Add space to the debug
 print
In-Reply-To: <20210614072452.480186-1-sasha.neftin@intel.com>
References: <20210614072452.480186-1-sasha.neftin@intel.com>
Message-ID: <17f7910ef523253e4e42dbdc81e0e80cb14c5e1d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-06-14 at 10:24 +0300, Sasha Neftin wrote:
> Complete to commit 3cf31b1a9eff ("e1000e: bump up timeout to
> wait when ME un-configures ULP mode")
> Minor fixes to allow debug prints more readable.
> 
> Fixes: 3cf31b1a9eff ("e1000e: bump up timeout to
> wait when ME un-configures ULP mode")

The Fixes should all be on one line.
	Fixes tag: Fixes: 3cf31b1a9eff ("e1000e: bump up timeout to
	Has these problem(s):
		- Subject has leading but no trailing parentheses
		- Subject has leading but no trailing quotes


> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 5b008c88beb7..a3cf0af7aedd 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1271,9 +1271,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct
> e1000_hw *hw, bool force)
>  			usleep_range(10000, 11000);
>  		}
>  		if (firmware_bug)
> -			e_warn("ULP_CONFIG_DONE took %dmsec.  This is a
> firmware bug\n", i * 10);
> +			e_warn("ULP_CONFIG_DONE took %d msec.  This is
> a firmware bug\n", i * 10);
>  		else
> -			e_dbg("ULP_CONFIG_DONE cleared after %dmsec\n",
> i * 10);
> +			e_dbg("ULP_CONFIG_DONE cleared after %d
> msec\n", i * 10);

nit: Since there will be a new version, can you put the 'i * 10's on a
new line?
WARNING: line length of 81 exceeds 80 columns
WARNING: line length of 98 exceeds 80 columns


>  
>  		if (force) {
>  			mac_reg = er32(H2ME);
