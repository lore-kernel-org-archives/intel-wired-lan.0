From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Jun 2017 23:01:24 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve cppcheck format
	string	warning
In-Reply-To: <20170601190605.32148-1-anthony.l.nguyen@intel.com>
References: <20170601190605.32148-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA4C2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, June 1, 2017 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve cppcheck format string
> warning
> 
> cppcheck warns that the format string is incorrect in the function
> ixgbe_get_strings().  Since the value cannot be negative, change the variable
> to unsigned which matches the format specifier.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


