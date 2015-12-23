From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 23 Dec 2015 23:06:48 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix write to VLVFB
	in	ixgbe_clear_vf_vlans()
In-Reply-To: <20151223010957.27315.28321.stgit@localhost6.localdomain6>
References: <20151223010957.27315.28321.stgit@localhost6.localdomain6>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CFBAD6@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, December 22, 2015 5:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix write to VLVFB in
> ixgbe_clear_vf_vlans()
> 
> Fix the write to the VLVFB register in ixgbe_clear_vf_vlans() where word is the
> actual offset of the register and not the index for the IXGBE_VLVFB macro.
> 
> This was causing PCI AER errors on my system.
> 
> Fixes: 4c7f35f679f592804736f9303051257de2c9f021
> ("ixgbe: Clean stale VLANs when changing port VLAN or resetting")
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
