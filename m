From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 Jan 2016 21:12:37 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Fix MDD events generated
 when FCoE+SRIOV are enabled
In-Reply-To: <20151209061358.17965.8368.stgit@neerav-dbg1.jf.intel.com>
References: <20151209061358.17965.8368.stgit@neerav-dbg1.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D13323@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Neerav Parikh
> Sent: Tuesday, December 08, 2015 10:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Fix MDD events generated when
> FCoE+SRIOV are enabled
> 
> When FCoE is enabled with SR-IOV on the X550 NIC the hardware generates
> MDD events.
> 
> This patch fixes these by setting the expected values in the Tx context
> descriptors for FCoE/FIP frames and adding a flush after writing the RDLEN
> register.
> 
> Changes in v2:
> - Removed updating the skb network header for FIP frames
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
The scope of my testing was limited to trying to find any issues that this patch might cause with standard (non-DCB) networking traffic.
