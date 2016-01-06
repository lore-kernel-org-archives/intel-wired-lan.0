From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 Jan 2016 21:11:29 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix to get FDMI HBA
	attributes	information with X550
In-Reply-To: <20151208120118.17644.79053.stgit@ukketine.jf.intel.com>
References: <20151208120118.17644.79053.stgit@ukketine.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D13303@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Usha Ketineni
> Sent: Tuesday, December 08, 2015 4:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix to get FDMI HBA attributes
> information with X550
> 
> Check whether the FCOE support is enabled for the devices to get the  FDMI HBA
> attributes information instead of checking each device id.
> Also, add Model string information for X550.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> ---


Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
The scope of my testing was limited to trying to find any issues that this patch might cause with standard (non-DCB) networking traffic.
