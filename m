From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 18:18:05 +0000
Subject: [Intel-wired-lan] [PATCH v3] ixgbevf: restore hw_addr on resume
 or	error
In-Reply-To: <20161123192408.12895.85255.stgit@localhost6.localdomain6>
References: <20161123192408.12895.85255.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39B2C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, November 23, 2016 11:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3] ixgbevf: restore hw_addr on resume or
> error
> 
> Restore adapter->hw.hw_addr after handling an error, or a resume
> operation to make sure we can access the registers.
> 
> v2 - restore hw_addr only if pci_enable_device_mem() succeeds in
> ixgbevf_io_slot_reset()
> 
> v3 - restore hw_addr after pci_enable_device_mem() in ixgbevf_resume()
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


