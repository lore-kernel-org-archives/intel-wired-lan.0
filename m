From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 May 2017 21:51:26 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] ixgbevf: Resolve truncation
 warning	for q_vector->name
In-Reply-To: <20170512183810.26185-3-anthony.l.nguyen@intel.com>
References: <20170512183810.26185-1-anthony.l.nguyen@intel.com>
 <20170512183810.26185-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA3920@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, May 12, 2017 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/4] ixgbevf: Resolve truncation warning
> for q_vector->name
> 
> The following warning is now shown as a result of new checks added for gcc
> 7:
> 
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function
> ?ixgbevf_open?:
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:1363:13: warning: ?%d?
> directive output may be truncated writing between 1 and 10 bytes into a
> region of size between 3 and 18 [-Wformat-truncation=]
>       "%s-%s-%d", netdev->name, "TxRx", ri++);
>              ^~
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:1363:6: note: directive
> argument in the range [0, 2147483647]
>       "%s-%s-%d", netdev->name, "TxRx", ri++);
>       ^~~~~~~~~~
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:1362:4: note: ?snprintf?
> output between 8 and 32 bytes into a destination of size 24
>     snprintf(q_vector->name, sizeof(q_vector->name) - 1,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       "%s-%s-%d", netdev->name, "TxRx", ri++);
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Resolve this warning by making a couple of changes.
>  - Don't reserve space for the null terminator.  Since snprintf adds the
>    null terminator automatically, there is no need for us to reserve a byte
>    for it.
> 
>  - Change a couple variables that can never be negative from int to
>    unsigned int.
> 
> While we're making changes to the format string, move the constant strings
> into the format string instead of providing them as specifiers.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


