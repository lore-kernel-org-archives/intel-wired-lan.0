From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Mar 2018 21:22:33 +0000
Subject: [Intel-wired-lan] [S87 v5 7/7] i40e: restore TCPv4 input set
 when re-enabling ATR
In-Reply-To: <20180308225211.12254-7-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
 <20180308225211.12254-7-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94BE5E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, March 8, 2018 2:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [S87 v5 7/7] i40e: restore TCPv4 input set when re-
> enabling ATR
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When we re-enable ATR we need to restore the input set for TCPv4 filters, in
> order for ATR to function correctly. We already do this for the normal case of
> re-enabling ATR when disabling ntuple support.
> However, when re-enabling ATR after the last tcp4 filter is removed (but
> when ntuple support is still active), we did not restore the TCPv4 filter input
> set.
> 
> This can cause problems if the TCPv4 filters from FDir had changed the input
> set, as ATR will no longer behave as expected.
> 
> When clearing the ATR auto-disable flag, make sure we restore the TCPv4
> input set to avoid this.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



