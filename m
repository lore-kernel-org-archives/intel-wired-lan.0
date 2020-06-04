From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jun 2020 19:13:30 +0000
Subject: [Intel-wired-lan] [next-queue v3] i40e: Add a check to see if
 MFS is set
In-Reply-To: <20200529052712.4214-1-jeffrey.t.kirsher@intel.com>
References: <20200529052712.4214-1-jeffrey.t.kirsher@intel.com>
Message-ID: <MWHPR11MB1663918F8118F19CF15E5E8D8C890@MWHPR11MB1663.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jeff Kirsher
> Sent: Thursday, May 28, 2020 10:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v3] i40e: Add a check to see if MFS is
> set
> 
> From: Todd Fujinaka <todd.fujinaka@intel.com>
> 
> A customer was chain-booting to provision his systems and one of the steps
> was setting MFS. MFS isn't cleared by normal warm reboots (clearing
> requires a GLOBR) and there was no indication of why Jumbo Frame receives
> were failing.
> 
> Add a warning if MFS is set to anything lower than the default.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
> v3: removed the unnecessary 'for loop'
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


