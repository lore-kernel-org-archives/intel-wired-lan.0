From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Aug 2015 19:01:42 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] igb: Teardown SR-IOV
	before	unregister_netdev()
In-Reply-To: <20150729203814.10732.38094.stgit@gimli.home>
References: <20150729203726.10732.91020.stgit@gimli.home>
 <20150729203814.10732.38094.stgit@gimli.home>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AE3CE3@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alex Williamson
> Sent: Wednesday, July 29, 2015 1:38 PM
> To: intel-wired-lan at lists.osuosl.org; davem at davemloft.net; Kirsher,
> Jeffrey T
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v2 1/2] igb: Teardown SR-IOV before
> unregister_netdev()
> 
> When the .remove() callback for a PF is called, SR-IOV support for the
> device is disabled, which requires unbinding and removing the VFs.
> The VFs may be in-use either by the host kernel or userspace, such as
> assigned to a VM through vfio-pci.  In this latter case, the VFs may
> be removed either by shutting down the VM or hot-unplugging the
> devices from the VM.  Unfortunately in the case of a Windows 2012 R2
> guest, hot-unplug is broken due to the ordering of the PF driver
> teardown.  Disabling SR-IOV prior to unregister_netdev() avoids this
> issue.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Acked-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
