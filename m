From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Apr 2017 21:17:41 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Allow setting zero MAC address
 for	VF
In-Reply-To: <20170412203522.57743-1-anthony.l.nguyen@intel.com>
References: <20170412203522.57743-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA0DB9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, April 12, 2017 1:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Allow setting zero MAC address for
> VF
> 
> Currently, there is no logic that allows a VF's MAC address to be removed
> from the RAR table.
> 
> Allow the user to specify a zero MAC address in order to clear the VF's MAC
> address from the RAR table.  This functionality is also utilized by libvirt when
> removing VFs.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 28 +++++++++++++++++--
> -------
>  1 file changed, 18 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


