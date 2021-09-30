From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 30 Sep 2021 16:29:42 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Print the api_patch as part
 of the fw.mgmt.api
In-Reply-To: <20210927182150.234879-1-brett.creeley@intel.com>
References: <20210927182150.234879-1-brett.creeley@intel.com>
Message-ID: <BYAPR11MB336791A98D3AC8C03783141DFCAA9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Brett Creeley
> Sent: Monday, September 27, 2021 11:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] ice: Print the api_patch as part of the
> fw.mgmt.api
> 
> Currently when a user uses "devlink dev info", the fw.mgmt.api will be the
> major.minor numbers as shown below:
> 
> devlink dev info pci/0000:3b:00.0
> pci/0000:3b:00.0:
>   driver ice
>   serial_number 00-01-00-ff-ff-00-00-00
>   versions:
>       fixed:
>         board.id K91258-000
>       running:
>         fw.mgmt 6.1.2
>         fw.mgmt.api 1.7 <--- No patch number included
>         fw.mgmt.build 0xd75e7d06
>         fw.mgmt.srev 5
>         fw.undi 1.2992.0
>         fw.undi.srev 5
>         fw.psid.api 3.10
>         fw.bundle_id 0x800085cc
>         fw.app.name ICE OS Default Package
>         fw.app 1.3.27.0
>         fw.app.bundle_id 0xc0000001
>         fw.netlist 3.10.2000-3.1e.0
>         fw.netlist.build 0x2a76e110
>       stored:
>         fw.mgmt.srev 5
>         fw.undi 1.2992.0
>         fw.undi.srev 5
>         fw.psid.api 3.10
>         fw.bundle_id 0x800085cc
>         fw.netlist 3.10.2000-3.1e.0
>         fw.netlist.build 0x2a76e110
> 
> There are many features in the driver that depend on the major, minor, and
> patch version of the FW. Without the patch number in the output for
> fw.mgmt.api debugging issues related to the FW API version is difficult.
> Also, using major.minor.patch aligns with the existing firmware version which
> uses a 3 digit value.
> 
> Fix this by making the fw.mgmt.api print the major.minor.patch versions.
> Shown below is the result:
> 
> devlink dev info pci/0000:3b:00.0
> pci/0000:3b:00.0:
>   driver ice
>   serial_number 00-01-00-ff-ff-00-00-00
>   versions:
>       fixed:
>         board.id K91258-000
>       running:
>         fw.mgmt 6.1.2
>         fw.mgmt.api 1.7.9 <--- patch number included
>         fw.mgmt.build 0xd75e7d06
>         fw.mgmt.srev 5
>         fw.undi 1.2992.0
>         fw.undi.srev 5
>         fw.psid.api 3.10
>         fw.bundle_id 0x800085cc
>         fw.app.name ICE OS Default Package
>         fw.app 1.3.27.0
>         fw.app.bundle_id 0xc0000001
>         fw.netlist 3.10.2000-3.1e.0
>         fw.netlist.build 0x2a76e110
>       stored:
>         fw.mgmt.srev 5
>         fw.undi 1.2992.0
>         fw.undi.srev 5
>         fw.psid.api 3.10
>         fw.bundle_id 0x800085cc
>         fw.netlist 3.10.2000-3.1e.0
>         fw.netlist.build 0x2a76e110
> 
> Fixes: ff2e5c700e08 ("ice: add basic handler for devlink .info_get")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  Documentation/networking/devlink/ice.rst     | 9 +++++----
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 3 ++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
