From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 23:19:45 +0000
Subject: [Intel-wired-lan] [PATCH S46 6/9] ice: fix PCI device serial
 number to be lowercase values
In-Reply-To: <20200516005506.5113-6-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
 <20200516005506.5113-6-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16599D4C071B91EE9E4F6C9F8C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S46 6/9] ice: fix PCI device serial number to
> be lowercase values
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> Commit ceb2f00707f9 ("ice: Use pci_get_dsn()") changed the code to use a
> new function to get the Device Serial Number. It also changed the case of the
> filename for loading a package on a specific NIC from lowercase to
> uppercase. Change the filename back to lowercase since that is what we
> specified.
> 
> Fixes: ceb2f00707f9 ("ice: Use pci_get_dsn()")
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


